import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'success_create_password_controller.dart';

class SuccessCreatePasswordView
    extends GetView<SuccessCreatePasswordController> {
  double angka1(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 8;
  double panjangIsiButton(BuildContext context) =>
      (MediaQuery.of(context).size.width - 20) * 4 / 5;
  double widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  DateTime currentBackPressTime;

  //LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    print('build success create password seller');
    return Container(
      color: Color(ListColor.color4),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body:
                // WillPopScope(
                //   onWillPop: controller.isFromIntro2.value ? null : onWillPop,
                // child:
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      color: Color(ListColor.colorBlue),
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset("assets/meteor_putih.png", 
                        width: GlobalVariable.ratioWidth(Get.context) * 91, 
                        height: GlobalVariable.ratioWidth(Get.context) * 91,),
                    ),
                    Container(
                      height: MediaQuery.of(Get.context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    top: GlobalVariable.ratioWidth(Get.context) * 24),
                                width: GlobalVariable.ratioWidth(Get.context) * 120,
                                height: GlobalVariable.ratioWidth(Get.context) * 21,
                                child: SvgPicture.asset(
                                  'assets/ic_logo_muatmuat_putih.svg',
                                  width: GlobalVariable.ratioWidth(Get.context) * 120,
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) * 77.41),
                                width: GlobalVariable.ratioWidth(Get.context) * 180,
                                height: GlobalVariable.ratioWidth(Get.context) * 180,
                                child: SvgPicture.asset(
                                  'assets/ic_logo_muat_emoji2.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) * 180,
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                              child: CustomText(
                                "GeneralLRCreatePasswordLabelSuccessTitle".tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 0,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 285),
                              child: CustomText(
                                "GeneralLRCreatePasswordLabelSuccessDesc".tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            _button(
                                height: 36,
                                marginLeft: 16,
                                marginRight: 16,
                                useBorder: false,
                                borderRadius: 18,
                                text: "Masuk",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(ListColor.colorBlue),
                                backgroundColor: Color(ListColor.colorYellow),
                                onTap: () {
                                  print("MASUK");
                                  // Get.back(result: true);
                                  LoginFunction().signOut2();
                                }),
                            SizedBox(
                              height: GlobalVariable.ratioWidth(Get.context) * 90,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            // ),
            ),
      ),
    );
  }

  // Widget buttonCircular(Widget child, double height) {
  Widget buttonCircular(Widget child) {
    return Container(
      // height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
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

  Widget _signInButton(BuildContext context) {
    return buttonCircular(FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      // minWidth: 72,
      // height: 36,
      color: Colors.white,
      child: Center(
          child:
              Image(image: AssetImage("assets/google_logo.png"), height: 20.0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      onPressed: () {
        controller.signInWithGoogle(context);
      },
    )
        // ,40
        );
  }

  Widget _formRegister() {
    return Column(
      children: [
        // field nama
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 14),
          height: GlobalVariable.ratioWidth(Get.context) * 40,
          decoration: BoxDecoration(
              border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10)),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6)),
        ),
        // field no wa
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 14),
          height: GlobalVariable.ratioWidth(Get.context) * 40,
          decoration: BoxDecoration(
              border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10)),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6)),
        ),
        // field email
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 14),
          height: GlobalVariable.ratioWidth(Get.context) * 40,
          decoration: BoxDecoration(
              border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10)),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6)),
        ),
        // field password
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 14),
          height: GlobalVariable.ratioWidth(Get.context) * 40,
          decoration: BoxDecoration(
              border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10)),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6)),
        ),
        // field confirm password
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 14),
          height: GlobalVariable.ratioWidth(Get.context) * 40,
          decoration: BoxDecoration(
              border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10)),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6)),
        ),
        // field referral
        Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 0,
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 32),
          height: GlobalVariable.ratioWidth(Get.context) * 40,
          decoration: BoxDecoration(
              border: Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorLightGrey10)),
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * 6)),
        ),
      ],
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
