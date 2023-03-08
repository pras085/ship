import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/otp_email_bftm/otp_email_controller_bftm.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:muatmuat/app/widgets/background_stack_widget.dart';

class OtpEmailBFTMView extends GetView<OtpEmailBFTMController> {
  double widthContent(BuildContext context) => MediaQuery.of(context).size.width - 40;
  double _getWidthOfScreen(BuildContext context) => MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) => MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) => _getWidthOfScreen(context) < _getHeightOfScreen(context)
    ? _getWidthOfScreen(context)
    : _getHeightOfScreen(context);

  Widget _content(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.onCompleteBuild());
    return Container(
      color: Color(ListColor.colorBlue),
      child: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: Color(ListColor.colorBlue),
                key: controller.scaffoldKey.value,
                body: Stack(
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 24,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 8
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 16),
                              child: CustomBackButton2(
                                context: Get.context,
                                onTap: () {
                                  controller.onWillPop();
                                }
                              ),
                            ),
                          )
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              child: panelCountDownOTP(context)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset("assets/meteor_putih.png", 
                  width: GlobalVariable.ratioWidth(Get.context) * 91, 
                  height: GlobalVariable.ratioWidth(Get.context) * 91,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget panelCountDownOTP(var context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/verify_phone_icon.svg",
            width: GlobalVariable.ratioWidth(Get.context) * 110,
            height: GlobalVariable.ratioWidth(Get.context) * 120.9,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 27.1),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 29.5
            ),
            child: CustomText(
              "BFTMRegisterAllCekPesanEmail".tr,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorWhite),
              textAlign: TextAlign.center,
              height: 1.2,
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          CustomText(
            "BFTMRegisterAllKodeOTPDikirimKeEmail".tr,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.color2),
            textAlign: TextAlign.center
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 16),
                child: Obx(() => CustomText(
                  controller.email.value,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
              ),
              Obx(() => _button(
                height: 32,
                width: 68,
                text: "BFTMRegisterAlGanti".tr,
                color: !controller.loading.value && controller.endTime.value == 0
                  ? Color(ListColor.colorBlue)
                  : Color(ListColor.colorGrey3),
                backgroundColor: !controller.loading.value && controller.endTime.value == 0
                  ? Color(ListColor.colorWhite)
                  : Color(ListColor.colorLightGrey2),
                // PENYESUAIAN API
                onTap: !controller.loading.value && controller.endTime.value == 0 ? () {
                  ubahEmailDialog(
                    onSubmit: () {
                      controller.changeEmail();
                    },
                  );
                } : null
              ))
            ],
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 34
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < controller.otpLength; i++) textOTP(i)
              ],
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          Obx(() => RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'AvenirNext',
                fontWeight: FontWeight.w600,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                color: Color(ListColor.colorWhite)
              ),
              children: [
                TextSpan(text: "BFTMRegisterAllKodeOTPBerakhirDalam".tr.replaceAll("\\n", "\n")),
                TextSpan(
                  text: controller.formatedTime(timeInSecond: controller.endTime.value),
                  style: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    fontWeight: FontWeight.w700
                  )
                ),
                TextSpan(text: "BFTMRegisterAllMenit".tr),
              ]
            )
          )),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 32),
          Obx(() => _button(
            height: 33,
            width: 109,
            text: "BFTMRegisterAllKirimUlang".tr,
            color: !controller.loading.value && controller.endTime.value == 0
              ? Color(ListColor.colorBlue)
              : Color(ListColor.colorGrey3),
            backgroundColor: !controller.loading.value && controller.endTime.value == 0
              ? Color(ListColor.colorYellow)
              : Color(ListColor.colorLightGrey2),
            onTap: !controller.loading.value && controller.endTime.value == 0 ? () {
              if (!controller.loading.value) controller.resendOtp();
            } : null),
          ),
        ]
      )
    );
  }

  Widget textOTP(int idx) {
    return Obx(
      () => GestureDetector(
        child: Container(
          width: GlobalVariable.ratioWidth(Get.context) * 42,
          height: GlobalVariable.ratioWidth(Get.context) * 42,
          padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 14,
            GlobalVariable.ratioWidth(Get.context) * 10.5,
            GlobalVariable.ratioWidth(Get.context) * 12,
            GlobalVariable.ratioWidth(Get.context) * 10.5,
          ),
          decoration: BoxDecoration(
            color: Color(ListColor.colorWhite),
            borderRadius: BorderRadius.all(
              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 4),
            ),
            border: Border.all(
              color: controller.errorOtp.value ? Color(ListColor.colorRed) : Colors.transparent,
              width: GlobalVariable.ratioWidth(Get.context) * 1
            )
          ),
          child: CustomTextFormField(
            context: Get.context,
            textSize: 20,
            controller: controller.otpController[idx],
            focusNode: controller.otpFocusNode[idx],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
            obscureText: false,
            keyboardType: TextInputType.phone,
            inputFormatters: [LengthLimitingTextInputFormatter(1)],
            newInputDecoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            onChanged: (value) {
              controller.verifyOtp();
              if (controller.otpController[idx].text.length == 1) {
                if (idx < (controller.otpLength - 1)) {
                  controller.otpFocusNode[idx + 1].requestFocus();
                  if (controller.otpController[idx].text.length == 1) {
                    controller.otpController[idx].selection = TextSelection(
                      baseOffset: 0,
                      extentOffset:
                          controller.otpController[idx].value.text.length,
                    );
                  }
                }
              } else {
                if (idx > 0) {
                  controller.otpFocusNode[idx - 1].requestFocus();
                }
              }
            },
            onTap: () {
              controller.otpController[idx].selection = TextSelection(
                baseOffset: 0,
                extentOffset: controller.otpController[idx].value.text.length,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.onWillPop();
        return Future.value(true);
      },
      child: _content(context),
    );
  }

  Future onWillPop() {
    return Future.value(true);
  }

  Widget buttonResendVerification(BuildContext context) {
    return Obx(
      () => MaterialButton(
        color: controller.isExpired.value
            ? Color(ListColor.color5)
            : Color(ListColor.colorLightGrey12),
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(ListColor.colorLightGrey13),
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        onPressed: () {
          if (controller.isExpired.value) {
            //controller.sendVerifyPhone(true);
            controller.resendToEmail();
          }
        },
        child: CustomText(
          'BFTMRegisterAllKirimUlang'.tr,
          color: controller.isExpired.value
              ? Color(ListColor.color4)
              : Color(ListColor.colorLightGrey13),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

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
                  borderRadius: BorderRadius.circular(borderRadius)),
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

  Future<bool> checkReturnBack(BuildContext context) {
    return Future.value(true);
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: CustomText('VerifyHPLabelConfirmationBack'.tr),
    //         actions: [
    //           FlatButton(
    //             child: CustomText('GlobalButtonYES'.tr),
    //             onPressed: () {
    //               // Get.offAllNamed(Routes.INTRO2ALT);
    //               Get.back();
    //               Get.back();
    //             },
    //           ),
    //           FlatButton(
    //             child: CustomText('GlobalButtonNO'.tr),
    //             onPressed: () {
    //               // Navigator.pop(context);
    //               Get.back();
    //               Get.back();
    //             },
    //           )
    //         ],
    //       );
    //     });
  }

  void ubahEmailDialog({
    @required VoidCallback onSubmit,
  }) {
    // local variabel before we using it inside dialog
    final textController = TextEditingController();
    GlobalAlertDialog.showAlertDialogCustom(
      context: Get.context,
      title: "BFTMRegisterAllUbahEmail".tr,
      barrierColor: Colors.transparent,
      customMessage: Builder(builder: (context) {
        final ctrl = Get.put(OtpEmailBFTMController());
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: GlobalVariable.ratioWidth(Get.context) * 40,
              // TARUH BORDER TEXTFIELD DISINI
              decoration: BoxDecoration(
                  border: Border.all(
                      width: GlobalVariable.ratioWidth(Get.context) * 1,
                      color: ctrl.errorMessageDialog.value.trim().isEmpty
                          ? Color(ListColor.colorLightGrey10)
                          : Color(ListColor.colorRed)),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 6)),
              padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 8,
                GlobalVariable.ratioWidth(Get.context) * 37,
                GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              child: Row(
                children: [
                  // TARUH ICON DISINI
                  Container(
                    margin: EdgeInsets.only(
                      right: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    child: SvgPicture.asset(
                      "assets/ic_email_yellow.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      context: Get.context,
                      autofocus: false,
                      onChanged: (value) {
                        ctrl.changeEmailValue.value = value;
                        // do some validation here
                        // if (RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)) {
                        //   ctrl.errorMessageDialog.value = 'GlobalValidationLabelPenulisanEmailSalah'.tr;
                        //   return;
                        // } else {
                        //   ctrl.errorMessageDialog.value = "";
                        // }
                      },
                      controller: textController,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 12,
                      keyboardType: TextInputType.emailAddress,
                      newInputDecoration: InputDecoration(
                        hintText: "BFTMRegisterAllMasukkanEmail".tr,
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorLightGrey2),
                            fontSize: 12),
                        fillColor: Colors.transparent,
                        filled: true,
                        isDense: true,
                        isCollapsed: true,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (ctrl.errorMessageDialog.value.trim().isNotEmpty) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    CustomText(
                      ctrl.errorMessageDialog.value,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1.2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      color: Color(ListColor.colorRed),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            }),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => Align(
                alignment: Alignment.center,
                child: _buttonDynamic(
                  label: "BFTMRegisterAllSimpan".tr,
                  onPressed: ctrl.changeEmailValue.value.trim().isEmpty
                      ? null
                      : onSubmit,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buttonDynamic({
    @required String label,
    VoidCallback onPressed,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Color(
            onPressed == null ? ListColor.colorLightGrey2 : ListColor.color4),
        side: BorderSide(
            width: 2,
            color: Color(onPressed == null
                ? ListColor.colorLightGrey2
                : ListColor.color4)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(GlobalVariable.ratioWidth(Get.context) * 18),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: CustomText(
          label,
          fontWeight: FontWeight.w600,
          color: onPressed == null
              ? Color(ListColor.colorLightGrey4)
              : Colors.white,
        ),
      ),
    );
  }
}
