import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../global_variable.dart';
import 'custom_text.dart';
import 'triangle_rounded.dart';

enum OVERLAY_POSITION { TOP, BOTTOM }

enum TooltipAlign {
  LEFT,
  CENTER,
  RIGHT,
}

class CustomTooltipOverlay extends StatefulWidget {
  final String message;
  final Widget customMessage;
  final double width;
  final TooltipAlign tooltipAlign;
  final Widget child;

  const CustomTooltipOverlay({
    Key key,
    @required this.message,
    this.customMessage,
    this.width,
    this.tooltipAlign,
    @required this.child,
  }) : super(key: key);

  @override
  State<CustomTooltipOverlay> createState() => _CustomTooltipOverlayState();
}

class _CustomTooltipOverlayState extends State<CustomTooltipOverlay> {
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
    _toolBarHeight = GlobalVariable.ratioWidth(context) * 58;
    var screenHeight = MediaQuery.of(context).size.height;

    final screenWidth = MediaQuery.of(context).size.width;
    final halfScreenWidth = screenWidth / 2;
    print("SIZE : ${size.width} - ${size.height}");
    print("remaining screen width : $halfScreenWidth - ${globalOffset.dx}");

    print("OFFSET :: ${offset.dx} - ${offset.dy}");

    Alignment alignment = Alignment.topCenter;
    double x = 0;
    if ((offset.dx < halfScreenWidth) && halfScreenWidth - offset.dx > GlobalVariable.ratioWidth(context) * 150) {
      // left
      alignment = Alignment.topLeft;
      // x = GlobalVariable.ratioWidth(context) * -20;
    } else if ((offset.dx > halfScreenWidth) &&
        offset.dx - halfScreenWidth > 150) {
      // right
      alignment = Alignment.topRight;
      // x = GlobalVariable.ratioWidth(context) * 20;
    }

    if (widget.tooltipAlign == TooltipAlign.CENTER) alignment = Alignment.topCenter;
    else if (widget.tooltipAlign == TooltipAlign.LEFT) alignment = Alignment.topLeft;
    else if (widget.tooltipAlign == TooltipAlign.RIGHT) alignment = Alignment.topRight;

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
              isAutoAdjust: widget.tooltipAlign == null,
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

  Widget nip(Size size, {useShadow = true}) {
    return Positioned(
      width: GlobalVariable.ratioWidth(context) * size.width,
      child: CompositedTransformFollower(
        link: _layerLink,
        showWhenUnlinked: false,
        offset: Offset(0,
            _overlayPosition == OVERLAY_POSITION.BOTTOM
                ? GlobalVariable.ratioWidth(context) * size.height
                : GlobalVariable.ratioWidth(context) * -(21.toDouble())),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: _overlayPosition == OVERLAY_POSITION.BOTTOM ? 2 : 4,
              child: CustomPaint(
                size: Size(GlobalVariable.ratioWidth(context) * 27, GlobalVariable.ratioWidth(context) * 21),
                painter: TriangleRounded(useShadow: useShadow),
              ),
            ),
          ],
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
}

class _TooltipContent extends StatefulWidget {
  final LayerLink layerLink;
  final Alignment alignment;
  final double width;
  final double x;
  final Size parentSize;
  final OVERLAY_POSITION overlayPosition;
  final String message;
  final bool isAutoAdjust;
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
    @required this.isAutoAdjust,
    @required this.child,
  }) : super(key: key);

  @override
  State<_TooltipContent> createState() => _TooltipContentState();
}

class _TooltipContentState extends State<_TooltipContent> {
  // calculate overlayHeight to place it right on the top of widget
  double overlayWidth = 150; // default
  double overlayHeight = 44.0; // default
  
  double halfScreenWidth;
  Alignment alignment;

  @override
  void initState() {
    super.initState();
    alignment = widget.alignment;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final r = context.findRenderObject() as RenderBox;
      if (r != null) {
        overlayWidth = r.size.width;
        overlayHeight = r.size.height;
        // check if tooltip content is not have width more than halfscreen then
        // make it center by overriding value from param;
        if (halfScreenWidth > overlayWidth && widget.isAutoAdjust) {
          alignment = Alignment.topCenter;
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // screen width divide 2 and then substract with default padding 16
    halfScreenWidth = (MediaQuery.of(context).size.width/2) - (GlobalVariable.ratioWidth(context) * 16);
    return CompositedTransformFollower(
      link: widget.layerLink,
      showWhenUnlinked: false,
      followerAnchor: alignment,
      targetAnchor: alignment,
      offset: Offset(
          widget.x,
          widget.overlayPosition == OVERLAY_POSITION.BOTTOM
              ? widget.parentSize.height + 15
              : -((15 + overlayHeight).toDouble())),
      child: Container(
        width: widget.width != null ? GlobalVariable.ratioWidth(context) * widget.width : null,
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
      child: Stack(
        children: [
          Container(
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
          Positioned(
            top: GlobalVariable.ratioWidth(context) * 8,
            right: GlobalVariable.ratioWidth(context) * 8,
            child: SvgPicture.asset('assets/ic_close1,5.svg',
              width: GlobalVariable.ratioWidth(context) * 8,
              height: GlobalVariable.ratioWidth(context) * 8,
              color: Colors.white,
            ),
          ),
        ],
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