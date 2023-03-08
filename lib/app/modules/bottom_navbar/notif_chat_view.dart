import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/bottom_navbar/notif_chat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/scaffold_with_bottom_navbar.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NotifChatView extends GetView<NotifChatController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ScaffoldWithBottomNavbar(
          newNotif: controller.newNotif.value,
          beforeLogin: false,
          body: SafeArea(
            bottom: false,
            child: Container(
              color: Colors.white,
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      blurRadius: GlobalVariable.ratioWidth(context) * 26,
                      offset:
                          Offset(0, GlobalVariable.ratioWidth(context) * -66),
                    )
                  ]),
                  // color: Colors.white,
                  height: GlobalVariable.ratioWidth(context) * 56,
                  width: GlobalVariable.ratioWidth(context) * 360,
                  child: Center(
                      child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(context) * 16),
                        child: _backButtonWidget(),
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 120),
                      CustomText(
                        'Pesan',
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      )
                    ],
                  )),
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 20),
                GestureDetector(
                  onTap: () {
                    GetToPage.toNamed<NotifChatView>(Routes.NOTIF);
                  },
                  child: Container(
                    color: Colors.white,
                    // color: Colors.amberAccent,
                    height: GlobalVariable.ratioWidth(context) * 40,
                    width: GlobalVariable.ratioWidth(context) * 328,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: GlobalVariable.ratioWidth(context) * 24,
                            width: GlobalVariable.ratioWidth(context) * 24,
                            child: Image.asset('assets/bell2.png')),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(context) * 14,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(context) * 5.5),
                          child: CustomText(
                            'Notifikasi',
                            color: Color(0xFF525252),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: controller.jumlahnotif.value > 9 ? GlobalVariable.ratioWidth(context) * 163 : GlobalVariable.ratioWidth(context) * 171,
                        ),
                        controller.jumlahnotif.value == 0
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(context) * 3),
                                child: Container(
                                  height:
                                      GlobalVariable.ratioWidth(context) * 18,
                                  width:
                                      GlobalVariable.ratioWidth(context) * 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(context) *
                                              54),
                                      color: Colors.transparent),
                                ),
                              )
                            : controller.jumlahnotif.value > 9
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            GlobalVariable.ratioWidth(context) *
                                                3),
                                    child: Container(
                                      height:
                                          GlobalVariable.ratioWidth(context) *
                                              18,
                                      width:
                                          GlobalVariable.ratioWidth(context) *
                                              27,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              GlobalVariable.ratioWidth(
                                                      context) *
                                                  54),
                                          color: Color(0xFFF71717)),
                                      child: Center(
                                          child: CustomText(
                                        controller.jumlahnotif.value > 99 ? 
                                        '99+' :
                                        controller.jumlahnotif.value.toString(),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      )),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            GlobalVariable.ratioWidth(context) *
                                                3),
                                    child: Container(
                                      height:
                                          GlobalVariable.ratioWidth(context) *
                                              18,
                                      width:
                                          GlobalVariable.ratioWidth(context) *
                                              18,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              GlobalVariable.ratioWidth(
                                                      context) *
                                                  54),
                                          color: Color(0xFFF71717)),
                                      child: Center(
                                          child: CustomText(
                                        controller.jumlahnotif.value > 99 ? 
                                        '99+' :
                                        controller.jumlahnotif.value.toString(),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      )),
                                    ),
                                  ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(context) * 13,
                        ),
                        Container(
                          // color: Colors.green,
                          height: GlobalVariable.ratioWidth(context) * 24,
                          width: GlobalVariable.ratioWidth(context) * 25.07,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: GlobalVariable.ratioWidth(context) * 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(context) * 16),
                  child: lineDividerWidget(),
                ),
                SizedBox(height: GlobalVariable.ratioWidth(context) * 18),
                Container(
                  // color: Colors.amberAccent,
                  height: GlobalVariable.ratioWidth(context) * 41,
                  width: GlobalVariable.ratioWidth(context) * 328,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: GlobalVariable.ratioWidth(context) * 24,
                          width: GlobalVariable.ratioWidth(context) * 24,
                          child: Image.asset('assets/chat2.png')),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 14,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(context) * 5.5),
                        child: CustomText(
                          'Chat',
                          color: Color(0xFF525252),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 194,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(context) * 3),
                        child: Container(
                          height: GlobalVariable.ratioWidth(context) * 18,
                          width: GlobalVariable.ratioWidth(context) * 27,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(context) * 54),
                              color: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 12,
                      ),
                      Container(
                        // color: Colors.green,
                        height: GlobalVariable.ratioWidth(context) * 24,
                        width: GlobalVariable.ratioWidth(context) * 25.07,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: GlobalVariable.ratioWidth(context) * 15,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(context) * 16),
                  child: lineDividerWidget(),
                ),
              ]),
            ),
          )),
    );
  }

  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioHeight(Get.context) * 1,
        color: Color(ListColor.colorLightGrey14).withOpacity(0.3),
        height: 0,
      ),
    );
  }

  Widget _backButtonWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: ClipOval(
          child: Material(
              shape: CircleBorder(),
              color: Color(0xFF176CF7),
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      width: 24,
                      height: 24,
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 16, // 30 * 0.7,
                        color: Colors.white,
                      ))))),
        ),
      ),
    );
  }

  // PRIVATE CUSTOM BUTTON
  Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text ?? "",
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}
