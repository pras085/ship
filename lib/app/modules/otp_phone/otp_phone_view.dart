import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/modules/otp_phone/otp_phone_controller.dart';
import 'package:muatmuat/app/modules/success_register/success_register_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:muatmuat/app/widgets/background_stack_widget.dart';

class OtpPhoneView extends GetView<OtpPhoneController> {
  final _dialogFormKey = GlobalKey<FormState>();
  TextEditingController _noTelpController = TextEditingController();

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
              "GeneralLROTPLabelCekPesanWA".tr,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(ListColor.colorWhite),
              textAlign: TextAlign.center,
              height: 1.2,
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          CustomText(
            "GeneralLROTPLabelKodeOTPDikirimKeNomor".tr,
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
                  controller.phoneNumber.value,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
              ),
              Obx(() => _button(
                height: 32,
                width: 68,
                text: "GeneralLROTPLabelGanti".tr,
                color: !controller.loading.value && controller.endTime.value == 0
                  ? Color(ListColor.colorBlue)
                  : Color(ListColor.colorGrey3),
                backgroundColor: !controller.loading.value && controller.endTime.value == 0
                  ? Color(ListColor.colorWhite)
                  : Color(ListColor.colorLightGrey2),
                onTap: !controller.loading.value && controller.endTime.value == 0 ? () {
                  ubahNoHandphoneDialog(
                    onSubmit: () {
                    controller.otpController[0].clear();
                    controller.otpController[1].clear();
                    controller.otpController[2].clear();
                    controller.otpController[3].clear();
                    controller.otpController[4].clear();
                    controller.otpController[5].clear();
                      controller.changePhoneNumber();
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
                TextSpan(text: "GeneralLROTPLabelKodeOTPAktivasiBerakhirDalam".tr.replaceAll("\\n", "\n")),
                TextSpan(
                  text: controller.formatedTime(timeInSecond: controller.endTime.value),
                  style: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    fontWeight: FontWeight.w700
                  )
                ),
                TextSpan(text: "GeneralLROTPLabelMenit".tr),
              ]
            )
          )),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 32),
          Obx(() => _button(
            height: 33,
            width: 109,
            text: "GeneralLROTPLabelKirimUlang".tr,
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
          // buttonResendVerification(context),
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

  Widget panelCountDown(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/verify_phone_icon.svg",
          width: _getSizeSmallestWidthHeight(context) / 2.6,
          height: _getSizeSmallestWidthHeight(context) / 2.6,
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: CustomText(
            'VerifyHPLabelSendCode'.tr,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color(ListColor.color2),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 70),
            child: CustomText(
              'VerifyHPLabelYourPhoneNumber'.tr,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            )),
        Obx(
          () => CustomText(
            controller.phoneNumber.value,
            // controller.userModel.value.phone,
            textAlign: TextAlign.center,
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              // return showDialog(
              //     context: _scaffoldKey.currentContext,
              //     builder: (context) {
              //       return showDialogEditPhone(
              //           _scaffoldKey.currentContext);
              //     });
              // if (controller.isExpired.value) showModalBottomEditPhone();
            },
            child: CustomText(
              'VerifyHPButtonChangePhoneNumber'.tr,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color:
                  controller.isExpired.value && !controller.isGettingTime.value
                      ? Color(ListColor.color5)
                      : Colors.grey,
            ),
          ),
        ),
        controller.isGettingTime.value
            ? Container(
                // width: controller.widthCountdownContainer,
                // height: controller.heightCountdownContainer,
                width: 80,
                height: 80,
                child: Center(
                  child: Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator()),
                ),
              )
            : Container(
                key: controller.globalKeyContainerCountDown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 70),
                      child: Stack(children: [
                        CustomText(
                          "\n",
                          fontSize: 18,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Text(
                            //   'VerifyHPLabelCountdown'.tr + " ",
                            //   style: TextStyle(
                            //       fontSize: 18,
                            //       color: Color(ListColor.color2)),
                            // ),
                            CountdownTimer(
                              endTime: controller.endTime.value,
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                String timer = "";
                                String minuteSecond = "";
                                if (time != null) {
                                  String minutes =
                                      time.min != null ? '${time.min}:' : '';
                                  String seconds = time.sec != null
                                      ? (time.sec.toString().length > 1
                                          ? '${time.sec}'
                                          : '0${time.sec}')
                                      : '00';
                                  timer = minutes + seconds;
                                  minuteSecond = (minutes == ''
                                      ? ' ' + 'VerifyHPLabelSeconds'.tr
                                      : ' ' + 'VerifyHPLabelMinutes'.tr);
                                } else {
                                  timer = "00";
                                  controller.setIsAlreadyExpired();
                                }
                                return Expanded(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'AvenirNext',
                                        ),
                                        children: [
                                          TextSpan(
                                              text:
                                                  'VerifyHPLabelCountdown'.tr +
                                                      " ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color:
                                                      Color(ListColor.color2))),
                                          TextSpan(
                                              text: timer,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          TextSpan(
                                              text: minuteSecond,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white))
                                        ]),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ]),
                    ),
                    buttonResendVerification(context)
                  ],
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:
          // () => checkReturnBack(context),
          () {
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
            controller.resendToPhone();
          }
        },
        child: CustomText(
          'VerifyHPButtonResendCode'.tr,
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

  void ubahNoHandphoneDialog({
    @required VoidCallback onSubmit,
  }) {
    // local variabel before we using it inside dialog
    final textController = TextEditingController();
    GlobalAlertDialog.showAlertDialogCustom(
      context: Get.context,
      title: "GeneralLROTPLabelUbahNoWA".tr,
      barrierColor: Colors.transparent,
      customMessage: Builder(builder: (context) {
        final ctrl = Get.put(OtpPhoneController());
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
                      "assets/ic_whatsapp_seller.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      context: Get.context,
                      autofocus: false,
                      onChanged: (value) {
                        ctrl.changePhoneNoValue.value = value;
                        // do some validation here
                        if (value.length > 14) {
                          ctrl.errorMessageDialog.value =
                              "Karakter tidak boleh lebih dari 14";
                        } else {
                          ctrl.errorMessageDialog.value = "";
                        }
                      },
                      controller: textController,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textSize: 12,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        LengthLimitingTextInputFormatter(14)
                        // FilteringTextInputFormatter.allow(RegExp("[0-9\+]")),
                      ],
                      newInputDecoration: InputDecoration(
                        hintText: "GeneralLROTPLabelMasukkanNoWA".tr,
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
                  label: "GeneralLROTPLabelSimpan".tr,
                  onPressed: ctrl.changePhoneNoValue.value.trim().isEmpty
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
