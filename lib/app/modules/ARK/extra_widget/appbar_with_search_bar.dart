import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'dart:math' as math;
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'custom_text.dart';

class AppBarWithSearchBar extends StatefulWidget
    implements PreferredSizeWidget {
  final void Function() onClickSearch;
  final String hintText;
  final String titleText;
  final List<Widget> listIconWidgetOnRight;
  final int positionTab;
  final void Function() onClose;

  AppBarWithSearchBar(
      {@required this.positionTab,
      this.listIconWidgetOnRight,
      this.hintText = "",
      this.titleText = "",
      this.onClose = null,
      @required this.onClickSearch});

  @override
  final Size preferredSize = Size.fromHeight(160);
  @override
  _AppBarWithSearchBarState createState() => _AppBarWithSearchBarState();
}

class _AppBarWithSearchBarState extends State<AppBarWithSearchBar> {
  bool _isShowClearText = false;
  @override
  Widget build(BuildContext context) {
    Widget iconOnRightOfSearch = _setWidgetOnRightOfSearch();
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 85,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color(ListColor.color4), boxShadow: [
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
                    child: CustomText(widget.titleText,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  iconOnRightOfSearch
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 5,
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
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
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              height: 1.2,
                              fontWeight: FontWeight.w600),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 32,
                            right: GlobalVariable.ratioWidth(Get.context) * 6,
                            top: GlobalVariable.ratioWidth(Get.context) * 8,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 8,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 6,
                          right: GlobalVariable.ratioWidth(Get.context) * 2),
                      child: SvgPicture.asset(
                        GlobalVariable.imagePath + "ic_search_blue.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                        height: GlobalVariable.ratioWidth(Get.context) * 24,
                        color: widget.onClickSearch == null
                            ? Color(ListColor.colorLightGrey2)
                            : null,
                      ),
                    ),
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
