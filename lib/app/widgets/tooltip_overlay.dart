import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../global_variable.dart';
import 'custom_text.dart';
import 'triangle_rounded.dart';

enum OVERLAY_POSITION { TOP, BOTTOM }

class TooltipOverlay extends StatefulWidget {
  final String message;
  final Widget customMessage;
  final double width;
  final Widget child;

  const TooltipOverlay({
    Key key,
    @required this.message,
    this.customMessage,
    this.width = 203,
    @required this.child,
  }) : super(key: key);

  @override
  State<TooltipOverlay> createState() => _TooltipOverlayState();
}

class _TooltipOverlayState extends State<TooltipOverlay> {
  TapDownDetails _tapDownDetails;
  OverlayEntry _overlayEntry;
  OVERLAY_POSITION _overlayPosition;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  double _statusBarHeight;
  double _toolBarHeight;

  // @override
  // void initState() {
  //   super.initState();
  //   OverlayState? overlayState = Overlay.of(context);
  //   _focusNode.addListener(() {
  //
  //   });
  // }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var globalOffset = renderBox.localToGlobal(_tapDownDetails.globalPosition);

    _statusBarHeight = MediaQuery.of(context).padding.top;

    // TODO: Calculate ToolBar Height Using MediaQuery
    _toolBarHeight = GlobalVariable.ratioWidth(context) * 58;
    var screenHeight = MediaQuery.of(context).size.height;

    final screenWidth = MediaQuery.of(context).size.width;
    final halfScreenWidth = screenWidth / 2;
    print("remaining screen width : $halfScreenWidth - ${globalOffset.dx}");

    print("OFFSET :: ${offset.dx} - ${offset.dy}");

    Alignment alignment = Alignment.topCenter;
    double x = 0;
    if ((offset.dx < halfScreenWidth) && halfScreenWidth - offset.dx > GlobalVariable.ratioWidth(context) * 150) {
      // left
      alignment = Alignment.topLeft;
      x = GlobalVariable.ratioWidth(context) * -20;
    } else if ((offset.dx > halfScreenWidth) &&
        offset.dx - halfScreenWidth > 150) {
      // right
      alignment = Alignment.topRight;
      x = GlobalVariable.ratioWidth(context) * 20;
    }

    var remainingScreenHeight =
        screenHeight - (_statusBarHeight ?? 0) - (_toolBarHeight ?? 0);

    if (globalOffset.dy > remainingScreenHeight / 2) {
      _overlayPosition = OVERLAY_POSITION.TOP;
    } else {
      _overlayPosition = OVERLAY_POSITION.BOTTOM;
    }
    return OverlayEntry(builder: (context) {
      return Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _overlayEntry?.remove();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
          nip(size),
          Positioned(
            // width: MediaQuery.of(context).size.width - 20,
            child: _TooltipContent(
              layerLink: _layerLink,
              alignment: alignment,
              x: x,
              width: widget.width,
              parentSize: size,
              overlayPosition: _overlayPosition,
              message: widget.message,
              child: widget.customMessage,
            ),
          ),
          nip(size, useShadow: false),
        ],
      );
    });
  }

  Widget nip(size, {useShadow = true}) {
    return Positioned(
      width: GlobalVariable.ratioWidth(context) * 27,
      child: CompositedTransformFollower(
        link: _layerLink,
        showWhenUnlinked: false,
        offset: Offset(GlobalVariable.ratioWidth(context) * -6,
            _overlayPosition == OVERLAY_POSITION.BOTTOM
                ? GlobalVariable.ratioWidth(context) * size.height
                : GlobalVariable.ratioWidth(context) * -(21.toDouble())),
        child: RotatedBox(
          quarterTurns: _overlayPosition == OVERLAY_POSITION.BOTTOM ? 2 : 4,
          child: CustomPaint(
            size: Size(GlobalVariable.ratioWidth(context) * 27, GlobalVariable.ratioWidth(context) * 21),
            painter: TriangleRounded(useShadow: useShadow),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        child: widget.child,
        onTapDown: (TapDownDetails tapDown) {
          setState(() {
            _tapDownDetails = tapDown;
          });
          _overlayEntry = _createOverlayEntry();
          Overlay.of(context)?.insert(_overlayEntry);
        },
      ),
    );
  }

  // Widget nip() {
  //   return SizedBox(
  //     height: 21.0,
  //     width: 27.0,
  //     // margin: EdgeInsets.only(left: (_tapDownDetails?.globalPosition.dx ?? 0)),
  //     child: CustomPaint(
  //       painter: OpenPainter(_overlayPosition!),
  //     ),
  //   );
  // }
}

// class OpenPainter extends CustomPainter {
//   final OVERLAY_POSITION overlayPosition;
//
//   OpenPainter(this.overlayPosition);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     switch (overlayPosition) {
//       case OVERLAY_POSITION.TOP:
//         var paint = Paint()
//           ..style = PaintingStyle.fill
//           ..color = Colors.white
//           ..isAntiAlias = true;
//
//         _drawThreeShape(
//           canvas,
//           first: Offset(0, 0),
//           second: Offset(20, 0),
//           third: Offset(10, 15),
//           size: size,
//           paint: paint,
//         );
//
//         break;
//       case OVERLAY_POSITION.BOTTOM:
//         var paint = Paint()
//           ..style = PaintingStyle.fill
//           ..color = Colors.white
//           ..isAntiAlias = true;
//
//         _drawThreeShape(
//           canvas,
//           first: Offset(15, 0),
//           second: Offset(0, 20),
//           third: Offset(30, 20),
//           size: size,
//           paint: paint,
//         );
//
//         break;
//     }
//
//     canvas.save();
//     canvas.restore();
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
//
//   void _drawThreeShape(Canvas canvas,
//       {required Offset first,
//       required Offset second,
//       required Offset third,
//       required Size size,
//       paint}) {
//     var path1 = Path()
//       ..moveTo(first.dx, first.dy)
//       ..lineTo(second.dx, second.dy)
//       ..lineTo(third.dx, third.dy);
//     canvas.drawPath(path1, paint);
//   }
// }

class _TooltipContent extends StatefulWidget {
  final LayerLink layerLink;
  final Alignment alignment;
  final double width;
  final double x;
  final Size parentSize;
  final OVERLAY_POSITION overlayPosition;
  final String message;
  final Widget child;

  const _TooltipContent({
    Key key,
    @required this.layerLink,
    @required this.alignment,
    @required this.width,
    @required this.x,
    @required this.parentSize,
    @required this.overlayPosition,
    @required this.message,
    @required this.child,
  }) : super(key: key);

  @override
  State<_TooltipContent> createState() => _TooltipContentState();
}

class _TooltipContentState extends State<_TooltipContent> {
  // calculate overlayHeight to place it right on the top of widget
  double overlayHeight = 44.0; // default

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final r = context.findRenderObject() as RenderBox;
      if (r != null) {
        setState(() {
          overlayHeight = r.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      link: widget.layerLink,
      showWhenUnlinked: false,
      followerAnchor: widget.alignment,
      targetAnchor: widget.alignment,
      offset: Offset(
          widget.x,
          widget.overlayPosition == OVERLAY_POSITION.BOTTOM
              ? widget.parentSize.height + 15
              : -((15 + overlayHeight).toDouble())),
      child: Container(
        width: GlobalVariable.ratioWidth(context) * widget.width,
        child: body(context, widget.message),
      ),
    );
  }

  Widget body(BuildContext context, String message) {
    return Material(
      borderRadius: BorderRadius.circular(
        GlobalVariable.ratioWidth(context) * 8,
      ),
      elevation: 4.0,
      color: Color(0xFF001537),
      child: Container(
        padding: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(context) * 12,
          GlobalVariable.ratioWidth(context) * 16,
          GlobalVariable.ratioWidth(context) * 12,
          GlobalVariable.ratioWidth(context) * 16,
        ),
        child: widget.child ?? CustomText(
          widget.message,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 15.54/12,
          color: Colors.white,
          textAlign: TextAlign.center,
          withoutExtraPadding: true,
        ),
      ),
    );
  }
}

class TooltipOverlaySubscription extends StatefulWidget {
  final String message;
  final Widget child;

  const TooltipOverlaySubscription({
    @required this.message,
    @required this.child,
  });

  @override
  _TooltipOverlaySubscriptionState createState() => _TooltipOverlaySubscriptionState();
}

class _TooltipOverlaySubscriptionState extends State<TooltipOverlaySubscription>
    with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry _overlayEntry;
  GlobalKey _globalKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    OverlayState overlayState = Overlay.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _globalKey;
    });
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = createOverlay();
        overlayState.insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
  }

  OverlayEntry createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    return OverlayEntry(builder: (context) {
      return Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => _focusNode.unfocus(),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            width: GlobalVariable.ratioWidth(context) * 203,
            height: GlobalVariable.ratioWidth(context) * 60,
            //height: 60,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, GlobalVariable.ratioWidth(context) * -52),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _focusNode.unfocus(),
                  child: CustomPaint(
                    painter: CustomStyleArrow(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(context) * 12,
                        GlobalVariable.ratioWidth(context) * 6,
                        GlobalVariable.ratioWidth(context) * 12,
                        GlobalVariable.ratioWidth(context) * 6,
                      ),
                      child: Center(
                        child: CustomText(
                          widget.message,
                          fontSize: 12,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (_focusNode.hasFocus) {
            _focusNode.unfocus();
          } else {
            _focusNode.requestFocus();
          }
        },
        child: Focus(
          focusNode: _focusNode,
          child: widget.child,
        ),
      ),
    );
  }
}

class CustomStyleArrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFF001537)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    final double triangleH = 10;
    final double triangleW = 25.0;
    final double width = size.width;
    final double height = size.height;

    final Paint shadowPaint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 1
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2);

    final BorderRadius borderRadius = BorderRadius.circular(9);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    final rrectShadow =
        RRect.fromRectAndRadius(Offset(1, 1) & size, Radius.circular(9));
    canvas.drawRRect(rrectShadow, shadowPaint); // shadow
    canvas.drawRRect(outer, paint); // main

    // draw triangle
    final Path trianglePath = Path()
      ..moveTo(width / 2 - triangleW / 2, height)
      ..lineTo(width / 2, triangleH + height)
      ..lineTo(width / 2 + triangleW / 2, height)
      ..lineTo(width / 2 - triangleW, height);
    canvas.drawShadow(trianglePath, Colors.black26, 2.0, false);
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}