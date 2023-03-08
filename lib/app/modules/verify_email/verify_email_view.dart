import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/home/home_view.dart';
import 'package:muatmuat/app/modules/verify_email/verify_email_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/background_stack_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:muatmuat/global_variable.dart';

class VerifyEmailView extends GetView<VerifyEmailController> {
  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) =>
      _getWidthOfScreen(context) < _getHeightOfScreen(context)
          ? _getWidthOfScreen(context)
          : _getHeightOfScreen(context);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => checkReturnBack(context),
      child: Scaffold(
        body: BackgroundStackWidget(
            body: Container(
          padding: EdgeInsets.all(30),
          child: Obx(() => controller.isError.value
              ? (!controller.isErrorForceStopEmail.value
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          controller.errorMessage.value,
                          textAlign: TextAlign.center,
                          fontSize: 20,
                          color: Color(ListColor.color2),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            margin: EdgeInsets.only(top: 15),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(ListColor.color2)),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    controller.tryAgainCheckEmail();
                                  },
                                  child: Center(
                                      child: CustomText(
                                          "GlobalButtonTryAgain".tr,
                                          color: Color(ListColor.color4),
                                          fontWeight: FontWeight.w800))),
                            ))
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 80),
                        SvgPicture.asset(
                          "assets/cancel_verif_email_icon.svg",
                          width: _getSizeSmallestWidthHeight(context) / 3.4,
                          height: _getSizeSmallestWidthHeight(context) / 3.4,
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        CustomText(
                          'VerifyEmailLabelSuccessCancelVerifyEmail'.tr,
                          textAlign: TextAlign.center,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.color2),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  'VerifyEmailLabelYourEmail'.tr,
                                  textAlign: TextAlign.center,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(ListColor.color2),
                                ),
                                CustomText(
                                  controller.userModel.email,
                                  textAlign: TextAlign.center,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(ListColor.color2),
                                ),
                              ]),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(height: 80),
                            CustomText(
                              'VerifyEmailLabelSuccessCancelVerifyEmailDesc'.tr,
                              textAlign: TextAlign.center,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(ListColor.color2),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                color: Color(ListColor.color5),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 14),
                                onPressed: () {
                                  controller.reRegister();
                                },
                                child: CustomText(
                                    'VerifyEmailLabelButtonReRegister'.tr,
                                    fontSize: 14,
                                    color: Color(ListColor.color4),
                                    fontWeight: FontWeight.w600)),
                            Container(height: 50),
                          ],
                        ),
                      ],
                    ))
              : (controller.isVerified.value
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          'VerifyEmailLabelAlreadyVerified'.tr,
                          textAlign: TextAlign.center,
                          fontSize: 16,
                          color: Color(ListColor.color2),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            margin: EdgeInsets.only(top: 10),
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(ListColor.color2)),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    controller.toNextView();
                                  },
                                  child: Center(
                                      child: CustomText(
                                          'VerifyEmailButtonOK'.tr,
                                          color: Color(ListColor.color4),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600))),
                            ))
                      ],
                    )
                  // : controller.isExpired.value
                  //     ? Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Image(
                  //               image: AssetImage(
                  //                   "assets/header_verifikasi_icon.png"),
                  //               height: 200.0),
                  //           Text(
                  //             'VerifyEmailLabelExpired'.tr,
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //                 fontSize: 20,
                  //                 color: Color(ListColor.color2)),
                  //           ),
                  //           buttonResendVerification(context)
                  //         ],
                  //       )
                  : panelCountDownOTP(context)
              // : panelCountDown(context)
              )),
        )),
      ),
    );
  }

  Widget panelCountDownOTP(var context) {
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // alignment: Alignment.center,
            children: [
          Container(height: 40),
          SvgPicture.asset(
            "assets/mail_icon.svg",
            width: _getSizeSmallestWidthHeight(context) / 3.4,
            height: _getSizeSmallestWidthHeight(context) / 3.4,
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            "Masukkan 6-digit kode OTP yang dikirimkan",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.color2),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: "ke ",
                    style: TextStyle(
                        fontSize: GlobalVariable.ratioHeight(Get.context) * 14,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.color2))),
                TextSpan(
                    text: controller.userModel.email,
                    style: TextStyle(
                        fontSize: GlobalVariable.ratioHeight(Get.context) * 14,
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.color2))),
              ])),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < controller.otpLength; i++) textOTP(i)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Obx(() => Offstage(
              offstage: !controller.isOTPError.value,
              child: Container(
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorLightBlue2),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  child: CustomText(
                    " Kode OTP yang Anda masukkan salah ",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(ListColor.color2),
                    textAlign: TextAlign.center,
                  )))),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: Divider(height: 1, color: Color(ListColor.color2))),
              CustomText(
                "  atau   ",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(ListColor.color2),
                textAlign: TextAlign.center,
              ),
              Expanded(
                  flex: 1,
                  child: Divider(height: 1, color: Color(ListColor.color2))),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          CustomText(
            "Anda dapat klik link / tautan yang telah dikirim ke email Anda untuk melanjutkan proses pendaftaran",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.color2),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
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
                            : '0${time.sec}')
                        : '00';
                    timer = minutes + seconds;
                    minuteSecond = (minutes == ''
                        ? ' ' + 'VerifyEmailLabelSeconds'.tr
                        : ' ' + 'VerifyEmailLabelMinutes'.tr);
                  } else {
                    timer = "00";
                    controller.setIsAlreadyExpired();
                  }
                  return Expanded(
                    child: (time != null)
                        ? RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'AvenirNext',
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          'VerifyEmailLabelCountdown'.tr + " ",
                                      style: TextStyle(
                                          fontSize: GlobalVariable.ratioHeight(
                                                  Get.context) *
                                              14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                  TextSpan(
                                      text: timer,
                                      style: TextStyle(
                                          fontSize: GlobalVariable.ratioHeight(
                                                  Get.context) *
                                              14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                  TextSpan(
                                      text: minuteSecond,
                                      style: TextStyle(
                                          fontSize: GlobalVariable.ratioHeight(
                                                  Get.context) *
                                              14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white))
                                ]))
                        : CustomText(
                            "Link aktivasi telah kadaluarsa",
                            fontFamily: 'AvenirNext',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                          ),
                  );
                },
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          buttonResendVerification(context),
        ]));
  }

  Widget textOTP(int idx) {
    return Obx(() => GestureDetector(
        child: Container(
            width: 48,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: Color(controller.isOTPError.value
                        ? ListColor.colorRed
                        : ListColor.colorLightGrey2)),
                color: Color(ListColor.color2),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: CustomTextFormField(
              context: Get.context,
              newInputDecoration: InputDecoration(),
              textSize: 16,
              controller: controller.otpController[idx],
              focusNode: controller.otpFocusNode[idx],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              obscureText: true,
              keyboardType: TextInputType.phone,
              inputFormatters: [LengthLimitingTextInputFormatter(1)],
              onChanged: (value) {
                controller.checkVerifyOTP();
                if (controller.otpController[idx].text.length == 1) {
                  if (idx < (controller.otpLength - 1)) {
                    controller.otpFocusNode[idx + 1].requestFocus();
                    if (controller.otpController[idx].text.length == 1) {
                      controller.otpController[idx].selection = TextSelection(
                          baseOffset: 0,
                          extentOffset:
                              controller.otpController[idx].value.text.length);
                    }
                  }
                }
              },
              onTap: () {
                controller.otpController[idx].selection = TextSelection(
                    baseOffset: 0,
                    extentOffset:
                        controller.otpController[idx].value.text.length);
              },
              newContentPadding: null,
            ))));

    // return TextFormFieldWidget(
    //     contentTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //     isShowError: false,
    //     isNumber: true,
    //     validator: (String value) {
    //       if (value.isEmpty) {
    //         return "";
    //       }
    //       return null;
    //     },
    //     width: 50,
    //     textEditingController: controller.otpController[idx]);
  }

  // Widget panelCountDown(var context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     // alignment: Alignment.center,
  //     children: [
  //       // Align(
  //       //     alignment: Alignment.topCenter,
  //       //     child: Column(
  //       //         mainAxisSize: MainAxisSize.min,
  //       //         children: [
  //       Container(height: 40), // 96),
  //       SvgPicture.asset(
  //         "assets/mail_icon.svg",
  //         width: _getSizeSmallestWidthHeight(context) / 3.4,
  //         height: _getSizeSmallestWidthHeight(context) / 3.4,
  //       ),
  //       SizedBox(
  //         height: 28,
  //       ),
  //       Text(
  //         'VerifyEmailLabelSendCode'.tr,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w600,
  //             color: Color(ListColor.color2)),
  //       ),
  //       SizedBox(
  //         height: 66,
  //       ),
  //       // ])),
  //       // Align(
  //       //   alignment: Alignment.center,
  //       //   child: Column(
  //       //     mainAxisSize: MainAxisSize.min,
  //       //     children: [
  //       Text(
  //         'VerifyEmailLabelYourEmail'.tr,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w700,
  //             color: Color(ListColor.color2)),
  //       ),
  //       Text(
  //         controller.userModel.email,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w700,
  //             color: Color(ListColor.color2)),
  //       ),
  //       // ])),
  //       // Align(
  //       //   alignment: Alignment.bottomCenter,
  //       //   child: Column(
  //       //     mainAxisSize: MainAxisSize.min,
  //       //     children: [
  //       SizedBox(
  //         height: 54,
  //       ),
  //       Container(
  //         margin: EdgeInsets.only(top: 20),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             // Text(
  //             //   'VerifyEmailLabelCountdown'.tr + " ",
  //             //   style: TextStyle(
  //             //       fontSize: 18,
  //             //       color: Color(ListColor.color2)),
  //             // ),
  //             CountdownTimer(
  //               endTime: controller.endTime.value,
  //               widgetBuilder: (_, CurrentRemainingTime time) {
  //                 String timer = "";
  //                 String minuteSecond = "";
  //                 if (time != null) {
  //                   String minutes = time.min != null ? '${time.min}:' : '';
  //                   String seconds = time.sec != null
  //                       ? (time.sec.toString().length > 1
  //                           ? '${time.sec}'
  //                           : '0${time.sec}')
  //                       : '00';
  //                   timer = minutes + seconds;
  //                   minuteSecond = (minutes == ''
  //                       ? ' ' + 'VerifyEmailLabelSeconds'.tr
  //                       : ' ' + 'VerifyEmailLabelMinutes'.tr);
  //                 } else {
  //                   timer = "00";
  //                   controller.setIsAlreadyExpired();
  //                 }
  //                 return Expanded(
  //                   child: RichText(
  //                       textAlign: TextAlign.center,
  //                       text: timer == "00"
  //                           ? TextSpan(
  //                               style: TextStyle(
  //                                 fontFamily: 'AvenirNext',
  //                               ),
  //                               children: [
  //                                   TextSpan(
  //                                       text: 'VerifyEmailLabelCountdown'.tr +
  //                                           " ",
  //                                       style: TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.w500,
  //                                           color: Color(ListColor.color2))),
  //                                   TextSpan(
  //                                       text: timer,
  //                                       style: TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.bold,
  //                                           color: Colors.white)),
  //                                   TextSpan(
  //                                       text: minuteSecond,
  //                                       style: TextStyle(
  //                                           fontSize: 20,
  //                                           fontWeight: FontWeight.w500,
  //                                           color: Colors.white))
  //                                 ])
  //                           : Text(
  //                               "Link aktivasi telah kadaluarsa",
  //                               style: TextStyle(
  //                                   fontFamily: 'AvenirNext',
  //                                   fontSize: 20,
  //                                   fontWeight: FontWeight.w500,
  //                                   color: Color(ListColor.color2)),
  //                             )),
  //                 );
  //               },
  //             )
  //           ],
  //         ),
  //       ),
  //       Container(height: 65),
  //       buttonResendVerification(context),
  //       // Container(height: 55),
  //       // ])),
  //     ],
  //   );
  // }

  Future<bool> checkReturnBack(BuildContext context) {
    if (controller.isError.value && controller.isErrorForceStopEmail.value) {
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: CustomText('VerifyEmailLabelConfirmationBack'.tr),
              actions: [
                FlatButton(
                  child: CustomText('GlobalButtonYES'.tr),
                  onPressed: () {
                    Navigator.popUntil(context, (Route<dynamic> route) {
                      var routeName = route.settings.name;
                      if (routeName != "/register-user") {
                        return false;
                      } else {
                        return true;
                      }
                    });
                  },
                ),
                FlatButton(
                  child: CustomText('GlobalButtonNO'.tr),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
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
            controller.resendVerifyEmail();
          }
        },
        child: CustomText(
          'VerifyEmailButtonResendCode'.tr,
          color: controller.isExpired.value
              ? Color(ListColor.color4)
              : Color(ListColor.colorLightGrey13),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    // return Container(
    //     width: MediaQuery.of(context).size.width / 2,
    //     margin: EdgeInsets.only(top: 10),
    //     height: 40,
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(20),
    //         color: Color(ListColor.color2)),
    //     child: Material(
    //       borderRadius: BorderRadius.circular(20),
    //       color: Colors.transparent,
    //       child: InkWell(
    //           borderRadius: BorderRadius.circular(20),
    //           onTap: () {
    //             controller.resendVerifyEmail();
    //           },
    //           child: Center(
    //               child: Text('VerifyEmailButtonResendCode'.tr,
    //                   style: TextStyle(
    //                       color: Color(ListColor.color4),
    //                       fontWeight: FontWeight.w800)))),
    //     ));
  }
}
