import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'dart:math' as math;
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'custom_text.dart';

class AppBarWithTab2 extends StatefulWidget implements PreferredSizeWidget {
  final List<String> listTab;
  final Widget customTab;
  final void Function(int) onClickTab;
  final void Function() onClickSearch;
  final String hintText;
  final List<Widget> listIconWidgetOnRight;
  final int positionTab;
  final void Function() onClose;

  AppBarWithTab2(
      {@required this.listTab,
      this.customTab,
      @required this.positionTab,
      this.listIconWidgetOnRight,
      @required this.onClickTab,
      this.hintText = "",
      this.onClose = null,
      @required this.onClickSearch});

  @override
  final Size preferredSize =
      Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 93);
  @override
  _AppBarWithTab2State createState() => _AppBarWithTab2State();
}

class _AppBarWithTab2State extends State<AppBarWithTab2> {
  bool _isShowClearText = false;
  @override
  Widget build(BuildContext context) {
    Widget iconOnRightOfSearch = _setWidgetOnRightOfSearch();
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 93,
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(color: GlobalVariable.appsMainColor, boxShadow: [
        BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2))
      ]),
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
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 20)),
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
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 20)),
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
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 20)),
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
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 6,
                  GlobalVariable.ratioWidth(Get.context) * 15,
                  GlobalVariable.ratioWidth(Get.context) * 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      child: GestureDetector(
                          onTap: () {
                            if (widget.onClose != null) {
                              widget.onClose();
                            } else {
                              Get.back();
                            }
                          },
                          child: SvgPicture.asset(
                              GlobalVariable.imagePath + "ic_back_button.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              color: GlobalVariable
                                  .tabDetailAcessoriesMainColor))),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 9,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: widget.onClickSearch,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          CustomTextField(
                              enabled: false,
                              textInputAction: TextInputAction.search,
                              context: Get.context,
                              newInputDecoration: InputDecoration(
                                hintText: widget.hintText,
                                hintStyle: TextStyle(
                                    color: Color(ListColor.colorGrey5),
                                    fontSize:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14,
                                    height: 1.2,
                                    fontWeight: FontWeight.w600),
                                fillColor: Colors.white,
                                filled: true,
                                isDense: true,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      32,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          6,
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      8,
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(ListColor.colorLightGrey7),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(ListColor.colorLightGrey7),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(ListColor.colorLightGrey7),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10),
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 6,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 2),
                            child: SvgPicture.asset(
                              GlobalVariable.imagePath + "ic_search_blue.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              color: widget.onClickSearch == null
                                  ? Color(ListColor.colorLightGrey2)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  iconOnRightOfSearch
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
                                              ? GlobalVariable
                                                  .tabDetailAcessoriesMainColor
                                              : GlobalVariable
                                                  .tabDetailAcessoriesDisableColor,
                                          fontSize: 14,
                                          height: 1.2,
                                          fontWeight: widget.positionTab == i
                                              ? FontWeight.w700
                                              : FontWeight.w600),
                                      SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            2,
                                      ),
                                      Container(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8,
                                          decoration: BoxDecoration(
                                            color: widget.positionTab == i
                                                ? GlobalVariable
                                                    .tabDetailAcessoriesMainColor
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
            width: 10,
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
