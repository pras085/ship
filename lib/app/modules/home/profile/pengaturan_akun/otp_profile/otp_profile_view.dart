import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_profile/otp_profile_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class OtpProfileView extends GetView<OtpProfileController> {
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
                        height: GlobalVariable.ratioWidth(Get.context) * 91
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 24
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) * 16
                                ),
                                child: CustomBackButton2(
                                  context: Get.context,
                                  onTap: () {
                                    // controller.onWillPop();
                                    Get.back();
                                  },
                                ),
                              ),
                              Expanded(
                                child: SvgPicture.asset(
                                  'assets/ic_logo_muatmuat_putih.svg',
                                  width: GlobalVariable.ratioWidth(Get.context) * 120,
                                ),
                              ),
                              Visibility(
                                visible: false,                                
                                maintainSize: true,
                                maintainState: true,
                                maintainAnimation: true,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: GlobalVariable.ratioWidth(Get.context) * 16
                                  ),
                                  child: CustomBackButton2(
                                    context: Get.context,
                                    onTap: () {
                                      // Get.back();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 36,
                                right: GlobalVariable.ratioWidth(Get.context) * 30,
                                left: GlobalVariable.ratioWidth(Get.context) * 30,
                              ),
                              child: panelCountDownOTP(context),
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
                  height: GlobalVariable.ratioWidth(Get.context) * 91
                ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        // alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/ic_otp_profile.svg",
            width: GlobalVariable.ratioWidth(Get.context) * 128,
            height: GlobalVariable.ratioWidth(Get.context) * 128,
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 22,
          ),
          CustomText(
            "Mohon masukkan OTP yang dikirim melalui pesan Whatsapp diperangkat Anda untuk melanjutkan perubahan",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorWhite),
            textAlign: TextAlign.center,
            height: 1.2,
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 12,
          ),
          CustomText(
            "Kode OTP dikirim ke nomor",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.color2),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 12,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CustomText(
                    controller.phone.value,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < controller.otpLength; i++) textOTP(i)
            ],
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 24,
          ),
          Obx(() => 
            RichText(
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
            ),
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 32,
          ),
          Obx(() => 
            _button(
              height: 33,
              width: 109,
              text: "Kirim Ulang",
              color: !controller.loading.value && controller.endTime.value == 0
                ? Color(ListColor.colorBlue)
                : Color(ListColor.colorGrey3),
              backgroundColor: !controller.loading.value && controller.endTime.value == 0
                ? Color(ListColor.colorYellow)
                : Color(ListColor.colorLightGrey2),
              onTap: !controller.loading.value && controller.endTime.value == 0
                ? () {
                  CustomToastTop.show(
                    message: "Berhasil kirim ulang OTP",
                    context: Get.context,
                    isSuccess: 1,
                  );
                  if (!controller.loading.value) controller.resendOtp();
                  controller.wrong.value = false;
                }
                : null
            ),
          )
          // buttonResendVerification(context),
        ]
      )
    );
  }

  Widget textOTP(int idx) {
    return Obx(() => 
      GestureDetector(
        child: Container(
          width: GlobalVariable.ratioWidth(Get.context) * 42,
          height: GlobalVariable.ratioWidth(Get.context) * 42,
          decoration: BoxDecoration(
            color: Color(ListColor.colorWhite),
            borderRadius: BorderRadius.all(
              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 4),
            ),
          ),
          child: CustomTextFormField(
            context: Get.context,
            textSize: 20,
            controller: controller.otpController[idx],
            focusNode: controller.otpFocusNode[idx],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            obscureText: false,
            keyboardType: TextInputType.phone,
            inputFormatters: [LengthLimitingTextInputFormatter(1)],
            newInputDecoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              focusedBorder: controller.wrong.value 
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(ListColor.colorRed),
                      width: GlobalVariable.ratioWidth(Get.context) * 1
                    )
                  ) 
                : InputBorder.none,
              enabledBorder: controller.wrong.value
                ?  OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(ListColor.colorRed),
                      width: GlobalVariable.ratioWidth(Get.context) * 1
                    )
                  ) 
                : InputBorder.none,
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 14,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 12,
                GlobalVariable.ratioWidth(Get.context) * 12,
              ),
            ),
            onChanged: (value) {
              controller.verifyOtp();
              if (controller.otpController[idx].text.length == 1) {
                if (idx < (controller.otpLength - 1)) {
                  controller.otpFocusNode[idx + 1].requestFocus();
                  if (controller.otpController[idx].text.length == 1) {
                    controller.otpController[idx].selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: controller.otpController[idx].value.text.length,
                    );
                  }
                }
              } 
              else {
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
          )
        ),
        Obx(() => 
          CustomText(
            controller.userModel.value.phone,
            // controller.userModel.value.phone,
            textAlign: TextAlign.center,
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              
            },
            child: CustomText(
              'VerifyHPButtonChangePhoneNumber'.tr,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: controller.isExpired.value && !controller.isGettingTime.value
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
                  child: CircularProgressIndicator()
                ),
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
                          CountdownTimer(
                            endTime: controller.endTime.value,
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              String timer = "";
                              String minuteSecond = "";
                              if (time != null) {
                                String minutes = time.min != null ? '${time.min}:' : '';
                                String seconds = time.sec != null
                                  ? (time.sec.toString().length > 1
                                    ? '${time.sec}'
                                    : '0${time.sec}'
                                  )
                                  : '00';
                                timer = minutes + seconds;
                                minuteSecond = (minutes == ''
                                  ? ' ' + 'VerifyHPLabelSeconds'.tr
                                  : ' ' + 'VerifyHPLabelMinutes'.tr
                                );
                              } 
                              else {
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
                                        text: 'VerifyHPLabelCountdown'.tr + " ",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(ListColor.color2)
                                        )
                                      ),
                                      TextSpan(
                                        text: timer,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                        )
                                      ),
                                      TextSpan(
                                        text: minuteSecond,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white
                                        )
                                      )
                                    ]
                                  ),
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
      onWillPop: () {
        // checkReturnBack(context);
        controller.onWillPop();
        return Future.value(false);
      },
      child: _content(context),
    );
  }

  Widget buttonResendVerification(BuildContext context) {
    return Obx(() => 
      MaterialButton(
        color: controller.isExpired.value
          ? Color(ListColor.color5)
          : Color(ListColor.colorLightGrey12),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(ListColor.colorLightGrey13),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
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

  // move properly, set to global for testing purpose
  void ubahNoHandphoneDialog() {
    // local variabel before we using it inside dialog
    final textController = TextEditingController();
    String errorMessage = "";

    GlobalAlertDialog.showAlertDialogCustom(
      context: Get.context,
      title: "Ubah No Whatsapp",
      labelButtonPriority1: "Simpan",
      customMessage: StatefulBuilder(builder: (context, newSetState) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: GlobalVariable.ratioWidth(Get.context) * 40,
                // TARUH BORDER TEXTFIELD DISINI
                decoration: BoxDecoration(
                  border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: errorMessage.trim().isEmpty
                      ? Color(ListColor.colorLightGrey10)
                      : Color(ListColor.colorRed)
                  ),
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)
                ),
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
                          // controller.searchOnChange(value);
                          // do some validation here
                          if (value.length > 15) {
                            errorMessage = "Karakter tidak boleh lebih dari 15";
                          } else {
                            errorMessage = "";
                          }
                          newSetState(() {});
                        },
                        controller: textController,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        textSize: 14,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        newInputDecoration: InputDecoration(
                          hintText: "Masukkan nomor Whatsapp",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(ListColor.colorLightGrey2)
                          ),
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
              if (errorMessage.trim().isNotEmpty)
                Column(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    CustomText(
                      errorMessage,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1.2,
                      color: Color(ListColor.colorRed),
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }
}