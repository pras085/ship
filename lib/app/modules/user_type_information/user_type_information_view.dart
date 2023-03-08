import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/modules/user_type_information/user_type_information_controller.dart';
import 'package:muatmuat/app/modules/user_type_information/user_type_information_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/appbar_custom1.dart';
import 'package:muatmuat/app/widgets/appbar_custom2.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class UserTypeInformationView extends GetView<UserTypeInformationController> {
  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _heightAppBar = AppBar().preferredSize.height + 30;
  double _sizeMarginVerticalPerItem = 14;
  double _sizePaddingInsidePerItem = 30;

  double _sizeTopAndBottom(BuildContext context) =>
      MediaQuery.of(context).size.height / 12.4;
  double _sizeMarginBetweenTitleMenu = 40;
  double _sizeTitleFont = 16;
  double _sizeContainerTitle() => _sizeMarginBetweenTitleMenu + _sizeTitleFont;
  double _sizeMarginBetweenButton() => 40;
  double _sizeButton() => 41;
  double _sizeContainerButton() => _sizeMarginBetweenButton() + _sizeButton();
  double _sizeHeightPerItem(BuildContext context) =>
      (MediaQuery.of(context).size.height -
          (_sizeTopAndBottom(context) * 2) -
          _sizeContainerTitle() -
          _sizeContainerButton()) /
      controller.listData.length;
  double _sizeWidthHeightIconPerItem(BuildContext context) =>
      _sizeHeightPerItem(context) -
      (_sizePaddingInsidePerItem * 2) -
      _sizeMarginVerticalPerItem;

  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
            color: Color(ListColor.colorWhite),
            child: SafeArea(
                child: Scaffold(
              backgroundColor: Color(ListColor.colorWhite),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(_heightAppBar),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: _getWidthOfScreen(context),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: ClipOval(
                          child: Material(
                              shape: CircleBorder(),
                              color: Color(ListColor.color4),
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      width: _heightAppBar * 1.7 / 4,
                                      height: _heightAppBar * 1.7 / 4,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: (_heightAppBar * 1.7 / 4) * 0.7,
                                        color: Colors.white,
                                      ))))),
                        ),
                      ),
                      SizedBox(width: 13),
                      CustomText('Informasi Jenis Akun',
                          color: Color(ListColor.color4),
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ],
                  ),
                ),
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      for (int i = 0; i < controller.listData.length; i++)
                        Container(
                            padding: EdgeInsets.only(
                                top: _sizeMarginVerticalPerItem),
                            width: MediaQuery.of(context).size.width,
                            child: Obx(() => _itemPerMenu(
                                i, controller.listData[i], context))),
                      SizedBox(height: 30),
                    ])),
              ),
            ))));
  }

  Widget _itemPerMenu(int index,
      UserTypeInformationModel userTypeInformationModel, BuildContext context) {
    double borderRadius = 16;
    return Column(
      children: [
        InkWell(
          borderRadius: controller.listShow[index]
              ? BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius))
              : BorderRadius.circular(borderRadius),
          onTap: () {
            controller.listShow[index] = !controller.listShow[index];
          },
          child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: _sizePaddingInsidePerItem,
                  horizontal: _sizePaddingInsidePerItem),
              width: MediaQuery.of(Get.context).size.width,
              decoration: BoxDecoration(
                  borderRadius: controller.listShow[index]
                      ? BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius))
                      : BorderRadius.circular(borderRadius),
                  color: Color(ListColor.colorLightBlue7)),
              child: Container(
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 26,
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(ListColor.color4))),
                              child: Icon(
                                controller.listShow[index]
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                size: 20,
                                color: Color(ListColor.color4),
                              ))),
                      SizedBox(width: 15),
                      Expanded(
                        child: CustomText(userTypeInformationModel.question,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: _sizeTitleFont),
                      ),
                    ]),
              )),
        ),
        controller.listShow[index]
            ? InkWell(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius)),
                onTap: () {
                  controller.listShow[index] = !controller.listShow[index];
                },
                child: Container(
                    padding: EdgeInsets.only(
                        bottom: _sizePaddingInsidePerItem,
                        left: _sizePaddingInsidePerItem,
                        right: _sizePaddingInsidePerItem),
                    width: MediaQuery.of(Get.context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(borderRadius),
                            bottomRight: Radius.circular(borderRadius)),
                        color: Color(ListColor.colorLightBlue8)),
                    child: Container(
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          Container(
                              width: 26,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                size: 30,
                                color: Color(ListColor.colorBlack),
                              )),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.keyboard_arrow_right,
                                      size: 30, color: Colors.transparent),
                                  CustomText(userTypeInformationModel.answer,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: _sizeTitleFont)
                                ]),
                          ),
                        ]))))
            : Container()
      ],
    );
  }

  Future<bool> onWillPop() {
    return Future.value(true);
  }
}
