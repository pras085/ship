import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialAwal extends StatefulWidget {
  final Widget child;
  final bool tutorAwal;
  final Function onTap;
  TutorialAwal({
    Key key,
    this.child,
    this.tutorAwal,
    this.onTap,

  }) : super(key: key);

  @override
  State<TutorialAwal> createState() => _TutorialAwalState();
}

class _TutorialAwalState extends State<TutorialAwal> {

  OverlayEntry overlayEntry;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.tutorAwal) {
        createHighlightOverlay(widget.onTap);
      }
      return;
    });
    return widget.child;
  }

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    removeHighlightOverlay();
    super.dispose();
  }

  void createHighlightOverlay(Function onTap) {
    // Remove the existing OverlayEntry.
    removeHighlightOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: (){
            removeHighlightOverlay();
            onTap();
          },
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Color(ListColor.colorBlue3).withOpacity(0.9),

                ),
                // //lingkaran kiri
                // Positioned(
                //   left: GlobalVariable.ratioWidth(context) * -35,
                //   top: ((MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) / 2) - 56 * GlobalVariable.ratioWidth(context),
                //   child: circle(
                //     size: 112, 
                //     color: Colors.white, 
                //     opacity: 0.1,
                //     child: circle(
                //       size: 69.04, 
                //       color: Colors.white, 
                //       opacity: 0.1,
                //       child: circle(
                //         size: 40.66, 
                //         color: Colors.white, 
                //         opacity: 0.2,
                //       )
                //     )
                //   ),
                // ),

                // //tangan kiri
                // Positioned(
                //   left: GlobalVariable.ratioWidth(context) * 22,
                //   top: ((MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) / 2),
                //   child: SvgPicture.asset(
                //     "assets/tutor_ic_left_hand.svg",
                //     width: GlobalVariable.ratioWidth(context) * 25,
                //   ),
                // ),

                // //text tangan kiri
                // Positioned(
                //   left: GlobalVariable.ratioWidth(context) * 20,
                //   top: ((MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) / 2) + 39 * GlobalVariable.ratioWidth(context),
                //   child: Container(
                //     alignment: Alignment.centerLeft,
                //     width: GlobalVariable.ratioWidth(context) * 296,
                //     child: CustomText(
                //       "Klik bagian kiri\nuntuk kembali ke\ntutorial sebelumnya",
                //       textAlign: TextAlign.left,
                //       fontWeight: FontWeight.w600,
                //       fontSize: 12,
                //       height: 15.6/12,
                //       color: Colors.white,
                //       decoration: TextDecoration.none,
                //     ),
                //   ),
                // ),

                
                //lingkaran kanan
                Positioned(
                  left: GlobalVariable.ratioWidth(context) * 285,
                  top: ((MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) / 2) - 56 * GlobalVariable.ratioWidth(context),
                  child: circle(
                    size: 112, 
                    color: Colors.white, 
                    opacity: 0.1,
                    child: circle(
                      size: 69.04, 
                      color: Colors.white, 
                      opacity: 0.1,
                      child: circle(
                        size: 40.66, 
                        color: Colors.white, 
                        opacity: 0.2,
                      )
                    )
                  ),
                ),

                //tangan kanan
                Positioned(
                  left: GlobalVariable.ratioWidth(context) * 318,
                  top: ((MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) / 2),
                  child: SvgPicture.asset(
                    "assets/tutor_ic_right_hand.svg",
                    width: GlobalVariable.ratioWidth(context) * 23,
                  ),
                ),

                //text tangan kanan
                Positioned(
                  right: GlobalVariable.ratioWidth(context) * 20,
                  top: ((MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) / 2) + 39 * GlobalVariable.ratioWidth(context),
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: GlobalVariable.ratioWidth(context) * 148,
                    child: CustomText(
                      "Klik untuk menuju ke\ntutorial selanjutnya",
                      textAlign: TextAlign.right,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 15.6/12,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),

                //lingkaran bawah
                Positioned(
                  left: GlobalVariable.ratioWidth(context) * 150,
                  bottom: GlobalVariable.ratioWidth(context) * -109,
                  child: circle(
                    size: 292, 
                    color: Colors.white, 
                    opacity: 0.1,
                    child: circle(
                      size: 180, 
                      color: Colors.white, 
                      opacity: 0.1,
                      child: circle(
                        size: 106, 
                        color: Colors.white, 
                        opacity: 0.2,
                        child: CustomText(
                          "LEWATI",
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      )
                    )
                  ),
                ),

                //arrow
                Positioned(
                  left: GlobalVariable.ratioWidth(context) * 216,
                  bottom: GlobalVariable.ratioWidth(context) * 29,
                  child: SvgPicture.asset(
                    "assets/tutor_ic_arrow.svg",
                    width: GlobalVariable.ratioWidth(context) * 38,
                  ),
                ),

                //text atas
                Positioned(
                  left: GlobalVariable.ratioWidth(context) * 32,
                  top: GlobalVariable.ratioWidth(context) * 127,
                  child: Container(
                    alignment: Alignment.center,
                    width: GlobalVariable.ratioWidth(context) * 296,
                    child: CustomText(
                      "Panduan untuk menikmati\nVirtual Tour",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      height: 21.78/18,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),

                //text bawah
                Positioned(
                  left: GlobalVariable.ratioWidth(context) * 55,
                  bottom: GlobalVariable.ratioWidth(context) * 74 ,
                  child: Container(
                    alignment: Alignment.center,
                    width: GlobalVariable.ratioWidth(context) * 250,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: "AvenirNext",
                          fontSize: GlobalVariable.ratioWidth(context) * 12,
                          height: 15.6/12,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                        children: [
                          TextSpan(
                            text: "Klik tombol Lewati bila Anda ingin keluar dari tutorial ini.\nAnda bisa mengakses tutorial ini lagi di halaman ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )
                          ),
                          TextSpan(
                            text: "Pengaturan Akun dan\nklik menu Tutorial",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            )
                          ),
                        ]
                      ),
                      
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry);
  }

  Widget circle ({double size, Color color, double opacity, Widget child}) {
    return Container(
      width: GlobalVariable.ratioWidth(context) * size,
      height: GlobalVariable.ratioWidth(context) * size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 1000),
      ),
      child: child,
    );
  }
}

class Tutorial {
  void showTutor2 ({
    @required TutorialCoachMark tcm, 
  }) {
    tcm.show();
  }

  void disposeTutor ({
    @required TutorialCoachMark tcm, 
  }) {
    tcm.finish();
  }

  TutorialCoachMark showTutor ({
    @required BuildContext context, 
    @required TutorialCoachMark tcm, 
    @required List<TargetFocus> targets,
    ScrollController scrollController,
    GlobalKey keyScroll,
  }) {
    return TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Color(ListColor.colorBlue3).withOpacity(0.9),
      textSkip: "",
      hideSkip: true,
      focusAnimationDuration: Duration(seconds: 1),
      paddingFocus: GlobalVariable.ratioWidth(context) * 7,
      opacityShadow: 0.9,
      onFinish: () {},
      onClickTarget: (target) {
        try {
          if (scrollController != null && keyScroll != null) {
            if (int.parse(target.identify) < targets.length -1) {
              // RenderBox renderNextTarget = targets[int.parse(target.identify) + 1].keyTarget.currentContext?.findRenderObject() as RenderBox;
              RenderBox renderNextTarget = targets[int.parse(target.identify) + 1].keyTarget.currentContext?.findRenderObject() as RenderBox;
              Size sizeNextTarget  = renderNextTarget.size; // or _widgetKey.currentContext?.size
              // print('Size sizeNextTarget: ${sizeNextTarget.height}');
              Offset offsetMerahTerhadapLayar = renderNextTarget.localToGlobal(Offset.zero,);
              // print('Offset atas Merah Terhadap Layar: ${offsetMerahTerhadapLayar.dx}, ${offsetMerahTerhadapLayar.dy}');

              RenderBox renderBoxScroll = keyScroll.currentContext?.findRenderObject() as RenderBox;
              Size sizeScroll = renderBoxScroll.size; // or _widgetKey.currentContext?.size
              // print('Size Scroll: ${sizeScroll.width}, ${sizeScroll.height}');
              Offset offsetMerahTerhadapScroll = renderBoxScroll.globalToLocal(offsetMerahTerhadapLayar);
              //nilai negatif berarti titik atas terpotong
              print('Offset Merah Terhadap Scroll atas: ${offsetMerahTerhadapScroll.dy}');
              //nilai positif berarti titik bawah terpotong
              print('Offset Biru Terhadap Scroll Bawah: ${sizeNextTarget.height + offsetMerahTerhadapScroll.dy - sizeScroll.height }');

              if(sizeNextTarget.height + offsetMerahTerhadapScroll.dy - sizeScroll.height > 0.0) {
                scrollController.animateTo(scrollController.position.pixels + (sizeNextTarget.height + offsetMerahTerhadapScroll.dy - sizeScroll.height), duration: Duration(microseconds: 500), curve: Curves.linear);
              }
              
            } 
          } 
        } catch (err) {
          print(err);
        }
      },
      onSkip: () {},
      onClickOverlay: (target) {},
    )..show();
  }

  TargetFocus setTarget (
    {
      @required BuildContext context,
      @required Function onSkip,
      @required String identify,
      @required GlobalKey globalKey,
      @required String title,
      @required String subTitle,
      @required ContentAlign contentAlign,
      @required ContentAlign textAlign,
      ShapeLightFocus shape = ShapeLightFocus.Circle,
      Alignment skipAlign = Alignment.bottomRight,
    }
  ) {
    return TargetFocus(
      identify: identify,
      keyTarget: globalKey,
      contents: [
        TargetContent(
          align: contentAlign,
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: 
                    textAlign == ContentAlign.left
                    ? CrossAxisAlignment.start
                    : textAlign == ContentAlign.right 
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: 
                    textAlign == ContentAlign.left
                    ? Alignment.centerLeft
                    : textAlign == ContentAlign.right 
                      ? Alignment.centerRight
                      : Alignment.center,
                  // color: Colors.purple,
                  width: textAlign == ContentAlign.left || textAlign == ContentAlign.right
                    ? GlobalVariable.ratioWidth(context) * 207
                    : GlobalVariable.ratioWidth(context) * 296,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(context) * 0,
                      bottom: GlobalVariable.ratioWidth(context) * 14
                    ),
                    child: CustomText(
                      title,
                      textAlign: textAlign == ContentAlign.left
                        ? TextAlign.left
                        : textAlign == ContentAlign.right 
                          ? TextAlign.right
                          : TextAlign.center,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      height: 21.78/18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: 
                    textAlign == ContentAlign.left
                      ? Alignment.centerLeft
                      : textAlign == ContentAlign.right 
                        ? Alignment.centerRight
                        : Alignment.center,
                  // color: Colors.purple,
                  width: textAlign == ContentAlign.left || textAlign == ContentAlign.right
                    ? GlobalVariable.ratioWidth(context) * 207
                    : GlobalVariable.ratioWidth(context) * 296,
                  child: CustomText(
                    subTitle,
                    textAlign: textAlign == ContentAlign.left
                      ? TextAlign.left
                      : textAlign == ContentAlign.right 
                        ? TextAlign.right
                        : TextAlign.center,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 18.2/14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ),
        TargetContent(
          align: ContentAlign.custom,
          customPosition: 
            skipAlign == Alignment.topRight 
            ? CustomTargetContentPosition(
              left: GlobalVariable.ratioWidth(context) * 269,
              top: GlobalVariable.ratioWidth(context) * 30
            )
            : CustomTargetContentPosition(
              left: GlobalVariable.ratioWidth(context) * 269,
              bottom: GlobalVariable.ratioWidth(context) * 30
            )
          ,
          child: GestureDetector(
            onTap: () {
              onSkip();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                CustomText(
                  "LEWATI",
                  color: Colors.white, 
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ],
            ),
          )
        )
      ],
      shape: shape,
      radius: GlobalVariable.ratioWidth(context) * 10,
    );
  }
}


class TutorListener extends StatefulWidget {
  final Widget child;
  final Function listener;
  final Function onDispose;
  final List<TutorialCoachMark> listTcm;
  final bool tutorAwal;

  final Key key;
  TutorListener({
    @required this.child,
    @required this.listener,
    @required this.onDispose,
    @required this.listTcm,
    this.tutorAwal = false,
    this.key,
  }): super(key: key);

  @override
  State<TutorListener> createState() => _TutorListenerState();
}

class _TutorListenerState extends State<TutorListener> {
  
  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.tutorAwal) {
        return widget.listener();
      } 
    });
    return TutorialAwal(
      onTap: () {
        if (widget.tutorAwal) {
          widget.listener();
        }
      },
      tutorAwal: widget.tutorAwal,
      child: widget.child
    );
  }
}