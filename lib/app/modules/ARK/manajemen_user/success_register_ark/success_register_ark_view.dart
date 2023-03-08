import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:quiver/pattern.dart';

import 'success_register_ark_controller.dart';

class SuccessRegisterARKView extends GetView<SuccessRegisterARKController> {
  double angka1(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 8;
  double panjangIsiButton(BuildContext context) =>
      (MediaQuery.of(context).size.width - 20) * 4 / 5;
  double widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    print('build success register seller');
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Color(ListColor.colorBlue),
          statusBarIconBrightness: Brightness.light),
      child: Container(
        color: Color(ListColor.color4),
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    color: Color(ListColor.colorBlue),
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      GlobalVariable.imagePath + "meteor_putih.png",
                      width: GlobalVariable.ratioWidth(Get.context) * 91,
                      height: GlobalVariable.ratioWidth(Get.context) * 91,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      GlobalVariable.imagePath + "meteor_putih.png",
                      width: GlobalVariable.ratioWidth(Get.context) * 91,
                      height: GlobalVariable.ratioWidth(Get.context) * 91,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(Get.context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                          ),
                          Column(children: [
                            Container(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    120,
                                // height:
                                //     GlobalVariable.ratioWidth(Get.context) * 33,
                                child: SvgPicture.asset(
                                  'assets/muatmuat logo.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          120,
                                )),
                            // CustomText(
                            //   "ManajemenUserBuatPasswordSellerPartner".tr,
                            //   fontSize: 10,
                            //   fontWeight: FontWeight.w600,
                            //   color: Colors.white,
                            // ),
                          ]),
                          Container(
                              margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      88),
                              child: SvgPicture.asset(
                                'assets/ic_logo_muat_emoji.svg',
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    180,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    180,
                              )),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 30,
                                GlobalVariable.ratioWidth(Get.context) * 32,
                                GlobalVariable.ratioWidth(Get.context) * 29,
                                GlobalVariable.ratioWidth(Get.context) * 12),
                            child: CustomText(
                              "ManajemenUserBuatPasswordSelamatPendaftaranAndaBerhasil"
                                  .tr,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 0,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 0),
                            child: CustomText(
                              "ManajemenUserBuatPasswordAkunSubUserBerhasil".tr,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(context) * 80),
                      child: _button(
                          height: 36,
                          marginLeft: 16,
                          marginRight: 16,
                          useBorder: false,
                          borderRadius: 18,
                          text: "GeneralLRLoginLabelMasuk".tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorBlue),
                          backgroundColor: Color(ListColor.colorYellow),
                          onTap: () {
                            print("check");
                            Get.reset();
                            Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER,
                                arguments: [true]);
                            // Get.offAllNamed(Routes.HOME);
                          }),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget buttonCircular(Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 40),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.shadowColor4),
            blurRadius: 2,
            offset: Offset(0, 30 / 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _button({
    bool maxWidth = false,
    double width = 0,
    double height = 0,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = true,
    Color borderColor,
    double borderSize,
    double borderRadius,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: maxWidth ? double.infinity : null,
      height: GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.3),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor,
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
            onTap: onTap == null
                ? null
                : () {
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
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
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
