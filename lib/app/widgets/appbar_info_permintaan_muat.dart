import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'dart:math' as math;

import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class AppBarInfoPermintaanMuat extends StatefulWidget implements PreferredSizeWidget {
  final List<String> listTab;
  final Widget customTab;
  final void Function(int) onClickTab;
  final void Function() onClickSearch;
  final String hintText;
  final List<Widget> listIconWidgetOnRight;
  final int positionTab;

  AppBarInfoPermintaanMuat(
      {@required this.listTab,
      this.customTab,
      @required this.positionTab,
      this.listIconWidgetOnRight,
      @required this.onClickTab,
      this.hintText = "",
      @required this.onClickSearch});

  @override
  _AppBarInfoPermintaanMuatState createState() => _AppBarInfoPermintaanMuatState();

  @override
  final Size preferredSize = Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 92);
}

class _AppBarInfoPermintaanMuatState extends State<AppBarInfoPermintaanMuat> {
  bool _isShowClearText = false;
  @override
  Widget build(BuildContext context) {
    Widget iconOnRightOfSearch = _setWidgetOnRightOfSearch();
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 92,
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
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 12,
            ),
            Container(
              height: GlobalVariable.ratioWidth(Get.context) * 32,
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
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
                        height: GlobalVariable.ratioWidth(Get.context) * 32,
                        margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 8))),
                        child: Stack(
                          alignment: Alignment.centerLeft,
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
                                            6,
                                        GlobalVariable.ratioWidth(
                                                Get.context) *
                                            32,
                                        GlobalVariable.ratioWidth(
                                                Get.context) *
                                            0))),
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
                      child: iconOnRightOfSearch)
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 12),
                child: widget.customTab != null
                    ? widget.customTab
                    : Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CustomText(widget.listTab[i],
                                            color: widget.positionTab == i
                                                ? Colors.white
                                                : Color(
                                                    ListColor.colorLightGrey2),
                                            fontSize: 14,
                                            height: 1.2,
                                            fontWeight: widget.positionTab == i
                                                ? FontWeight.w700
                                                : FontWeight.w600),
                                        Container(
                                            margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 1),
                                            width: GlobalVariable.ratioWidth(Get.context) * 8,
                                            height: GlobalVariable.ratioWidth(Get.context) * 8,
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
