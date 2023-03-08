import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'dart:math' as math;

import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class AppBarWithTab2 extends StatefulWidget implements PreferredSizeWidget {
  double _heightAppBar = 110;
  final List<String> listTab;
  final Widget customTab;
  final void Function(int) onClickTab;
  final void Function() onClickSearch;
  final String hintText;
  final List<Widget> listIconWidgetOnRight;
  final int positionTab;

  AppBarWithTab2(
      {@required this.listTab,
      this.customTab,
      @required this.positionTab,
      this.listIconWidgetOnRight,
      @required this.onClickTab,
      this.hintText = "",
      @required this.onClickSearch});

  @override
  final Size preferredSize = Size.fromHeight(110);
  @override
  _AppBarWithTab2State createState() => _AppBarWithTab2State();
}

class _AppBarWithTab2State extends State<AppBarWithTab2> {
  bool _isShowClearText = false;
  @override
  Widget build(BuildContext context) {
    Widget iconOnRightOfSearch = _setWidgetOnRightOfSearch();
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * widget._heightAppBar,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color(ListColor.color4)),
      child: Stack(alignment: Alignment.bottomRight, children: [
        Positioned(
          right: -10,
          bottom: 10,
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Container(
              width: 10,
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.5)
                      ])),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: -10,
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Container(
              width: 30,
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.3)
                      ])),
            ),
          ),
        ),
        Positioned(
          right: 75,
          bottom: 20,
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Container(
              width: 30,
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0)
                      ])),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: GlobalVariable.ratioWidth(Get.context) * 44,
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 16,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 4),
                    child: CustomBackButton(
                        context: Get.context,
                        onTap: () {
                          Get.back();
                        }),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: widget.onClickSearch,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 8,
                          top: GlobalVariable.ratioWidth(Get.context) * 12,
                          // bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                          // right: GlobalVariable.ratioWidth(Get.context) * 12
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 8))),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CustomTextField(
                                    context: Get.context,
                                    enabled: false,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) {},
                                    newInputDecoration: InputDecoration(
                                        hintText: widget.hintText,
                                        fillColor: Colors.transparent,
                                        hintStyle: TextStyle(
                                            fontSize: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "AvenirNext",
                                            color: Color(
                                                ListColor.colorLightGrey2)),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        filled: true,
                                        isDense: true,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(Get.context) *
                                                36,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                9,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                32,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                0))),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      6),
                              child: SvgPicture.asset(
                                "assets/ic_search.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 20,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 16,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 4),
                      child: iconOnRightOfSearch)
                ],
              ),
            ),
            Expanded(
              child: widget.customTab != null
                  ? widget.customTab
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        for (int i = 0; i < widget.listTab.length; i++)
                          Expanded(
                              child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                widget.onClickTab(i);
                              },
                              child: Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(widget.listTab[i],
                                          color: widget.positionTab == i
                                              ? Colors.white
                                              : Color(
                                                  ListColor.colorLightGrey2),
                                          fontWeight: FontWeight.w600),
                                      Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: widget.positionTab == i
                                                ? Colors.white
                                                : Colors.transparent,
                                            shape: BoxShape.circle,
                                          )),
                                    ]),
                              ),
                            ),
                          )),
                      ],
                    ),
            ),
          ],
        )
      ]),
    );
  }

  Widget _setWidgetOnRightOfSearch() {
    List<Widget> listWidget = [];
    if (widget.listIconWidgetOnRight != null) {
      if (widget.listIconWidgetOnRight.length > 0) {
        for (Widget widgetIcon in widget.listIconWidgetOnRight) {
          listWidget.add(SizedBox(
            width: GlobalVariable.ratioWidth(Get.context) * 12,
          ));
          listWidget.add(widgetIcon);
        }
      }
    }
    return listWidget == 0
        ? SizedBox.shrink()
        : Row(
            children: listWidget,
          );
  }
}
