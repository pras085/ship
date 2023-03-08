import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/validator/phoine_number_validator.dart';
import 'package:muatmuat/app/modules/verify_phone/dialog_change_number.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/test_form_field_widget2.dart';
import 'package:muatmuat/app/widgets/text_form_field_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:share/share.dart';
import 'package:validators/validators.dart' as validator;
import 'package:muatmuat/app/widgets/background_stack_widget.dart';

class VerifyPhoneView extends GetView<VerifyPhoneController> {
  final _dialogFormKey = GlobalKey<FormState>();
  TextEditingController _noTelpController = TextEditingController();

  double widthContent(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) =>
      _getWidthOfScreen(context) < _getHeightOfScreen(context)
          ? _getWidthOfScreen(context)
          : _getHeightOfScreen(context);

  Widget _content(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuild());
    return Scaffold(
      key: controller.scaffoldKey.value,
      body: BackgroundStackWidget(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(30),
              child: Center(
                child: Obx(
                  () => controller.isError.value
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                        controller.tryAgainCheckPhoneNumber();
                                      },
                                      child: Center(
                                          child: Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: CustomText(
                                            "VerifyHPButtonTryAgain".tr,
                                            color: Color(ListColor.color4),
                                            fontWeight: FontWeight.w600),
                                      ))),
                                ))
                            // Container(
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
                            //             controller.tryAgainCheckPhoneNumber();
                            //           },
                            //           child: Center(
                            //               child: Text(
                            //                   'VerifyHPButtonTryAgain'.tr,
                            //                   style: TextStyle(
                            //                       color:
                            //                           Color(ListColor.color4),
                            //                       fontWeight:
                            //                           FontWeight.w800)))),
                            //     )),
                            // Container(
                            //     width: MediaQuery.of(context).size.width / 2,
                            //     margin: EdgeInsets.only(top: 10),
                            //     height: 90,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(20),
                            //         color: Color(ListColor.color2)),
                            //     child: Material(
                            //       borderRadius: BorderRadius.circular(20),
                            //       color: Colors.transparent,
                            //       child: InkWell(
                            //           borderRadius: BorderRadius.circular(20),
                            //           onTap: () {
                            //             controller.tryAgainCheckPhoneNumber();
                            //           },
                            //           child: Container(
                            //             child: Center(
                            //               child: Text(
                            //                   'VerifyHPButtonTryAgain'.tr,
                            //                   textAlign: TextAlign.center,
                            //                   style: TextStyle(
                            //                       color:
                            //                           Color(ListColor.color4),
                            //                       fontWeight: FontWeight.w800)),
                            //             ),
                            //           )),
                            //     ))
                          ],
                        )
                      : (controller.isVerified.value
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/success_verified_icon.svg",
                                  width: 170,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: CustomText(
                                    'VerifyHPLabelSuccessVerified'.tr,
                                    textAlign: TextAlign.center,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.color2),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 60),
                                  child: CustomText(
                                    controller.userModel.value.code,
                                    textAlign: TextAlign.center,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(ListColor.color2),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(bottom: 120),
                                    child: CustomText(
                                      'DetailTransporterShareCode'.tr,
                                      textAlign: TextAlign.center,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.color2),
                                    )),
                                MaterialButton(
                                  minWidth:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          181,
                                  onPressed: () {
                                    Share.share(("VerifyHPLabelShareReferral"
                                            .tr)
                                        .replaceAll(":KODE_REFERRAL",
                                            controller.userModel.value.code));
                                  },
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  color: Colors.white,
                                  child: CustomText(
                                    "DetailTransporterShareReferalCode".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.color4),
                                  ),
                                ),
                                Container(height: 20),
                                MaterialButton(
                                  minWidth:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          181,
                                  onPressed: () {
                                    controller.onClickOK();
                                  },
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  color: Color(ListColor.color5),
                                  child: CustomText(
                                    "VerifyHPButtonOK".tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.color4),
                                  ),
                                ),
                                // Container(
                                //     width:
                                //         MediaQuery.of(context).size.width / 2,
                                //     margin: EdgeInsets.only(top: 10),
                                //     height: 40,
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(20),
                                //         color: Color(ListColor.color2)),
                                //     child: Material(
                                //       borderRadius: BorderRadius.circular(20),
                                //       color: Colors.transparent,
                                //       child: InkWell(
                                //           borderRadius:
                                //               BorderRadius.circular(20),
                                //           onTap: () {
                                //             controller.onClickOK();
                                //           },
                                //           child: Center(
                                //               child: Text('VerifyHPButtonOK'.tr,
                                //                   style: TextStyle(
                                //                       color: Color(
                                //                           ListColor.color4),
                                //                       fontWeight:
                                //                           FontWeight.w800)))),
                                //     ))
                              ],
                            )
                          :
                          // controller.isExpired.value
                          //     ? Column(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           Image(
                          //               image: AssetImage(
                          //                   "assets/header_verifikasi_icon.png"),
                          //               width:
                          //                   MediaQuery.of(context).size.width *
                          //                       2 /
                          //                       4),
                          //           Container(
                          //             margin: EdgeInsets.only(top: 40),
                          //             child: Text(
                          //               'VerifyHPLabelExpired'.tr,
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(
                          //                   fontSize: 18,
                          //                   color: Color(ListColor.color2)),
                          //             ),
                          //           ),
                          //           buttonResendVerification(context)
                          //         ],
                          //       )
                          //     :
                          panelCountDownOTP(context)),
                  // panelCountDown(context)),
                ),
              ),
            ),
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
            // alignment: Alignment.center,
            children: [
          Container(height: 40),
          SvgPicture.asset(
            "assets/verify_phone_icon.svg",
            width: _getSizeSmallestWidthHeight(context) / 3.4,
            height: _getSizeSmallestWidthHeight(context) / 3.4,
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            "Email Anda berhasil diaktivasi,",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.color2),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          CustomText(
            "Masukkan 6-digit kode OTP yang dikirimkan",
            fontSize: 14,
            fontWeight: FontWeight.w600,
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
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.color2))),
                TextSpan(
                    text: controller.userModel.value.phone,
                    style: TextStyle(
                        fontSize: GlobalVariable.ratioHeight(Get.context) * 14,
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.color2))),
                TextSpan(
                    text: '  ',
                    style: TextStyle(
                        fontSize: GlobalVariable.ratioHeight(Get.context) * 14,
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.color2))),
                TextSpan(
                    text: "Ganti No. Telepon",
                    style: TextStyle(
                        fontSize: GlobalVariable.ratioHeight(Get.context) * 14,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        color: controller.isExpired.value &&
                                !controller.isGettingTime.value
                            ? Color(ListColor.color5)
                            : Colors.grey),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (controller.isExpired.value)
                          showModalBottomEditPhone();
                      }),
              ])),
          SizedBox(
            height: 20,
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
                    fontWeight: FontWeight.w600,
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
            "Anda dapat klik link / tautan yang telah dikirim ke no. telepon Anda untuk melanjutkan proses pendaftaran",
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
  }

  // Widget panelCountDown(var context) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       SvgPicture.asset(
  //         "assets/verify_phone_icon.svg",
  //         width: _getSizeSmallestWidthHeight(context) / 2.6,
  //         height: _getSizeSmallestWidthHeight(context) / 2.6,
  //       ),
  //       Container(
  //         margin: EdgeInsets.only(top: 20),
  //         child: Text(
  //           'VerifyHPLabelSendCode'.tr,
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //               fontWeight: FontWeight.w600,
  //               fontSize: 18,
  //               color: Color(ListColor.color2)),
  //         ),
  //       ),
  //       Container(
  //           margin: EdgeInsets.only(top: 70),
  //           child: Text(
  //             'VerifyHPLabelYourPhoneNumber'.tr,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w700,
  //                 fontSize: 20,
  //                 color: Colors.white),
  //           )),
  //       Obx(
  //         () => Text(
  //           controller.userModel.value.phone,
  //           // controller.userModel.value.phone,
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //               fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
  //         ),
  //       ),
  //       Container(
  //         padding: EdgeInsets.all(10),
  //         child: GestureDetector(
  //           onTap: () {
  //             // return showDialog(
  //             //     context: _scaffoldKey.currentContext,
  //             //     builder: (context) {
  //             //       return showDialogEditPhone(
  //             //           _scaffoldKey.currentContext);
  //             //     });
  //             if (controller.isExpired.value) showModalBottomEditPhone();
  //           },
  //           child: Text(
  //             'VerifyHPButtonChangePhoneNumber'.tr,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //                 fontWeight: FontWeight.w800,
  //                 fontSize: 18,
  //                 color: controller.isExpired.value &&
  //                         !controller.isGettingTime.value
  //                     ? Color(ListColor.color5)
  //                     : Colors.grey),
  //           ),
  //         ),
  //       ),
  //       controller.isGettingTime.value
  //           ? Container(
  //               width: controller.widthCountdownContainer,
  //               height: controller.heightCountdownContainer,
  //               child: Center(
  //                 child: Container(
  //                     width: 30,
  //                     height: 30,
  //                     child: CircularProgressIndicator()),
  //               ),
  //             )
  //           : Container(
  //               key: controller.globalKeyContainerCountDown,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Container(
  //                     margin: EdgeInsets.symmetric(vertical: 70),
  //                     child: Stack(children: [
  //                       Text("\n",
  //                           style: TextStyle(
  //                             fontSize: 18,
  //                           )),
  //                       Row(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           // Text(
  //                           //   'VerifyHPLabelCountdown'.tr + " ",
  //                           //   style: TextStyle(
  //                           //       fontSize: 18,
  //                           //       color: Color(ListColor.color2)),
  //                           // ),
  //                           CountdownTimer(
  //                             endTime: controller.endTime.value,
  //                             widgetBuilder: (_, CurrentRemainingTime time) {
  //                               String timer = "";
  //                               String minuteSecond = "";
  //                               if (time != null) {
  //                                 String minutes =
  //                                     time.min != null ? '${time.min}:' : '';
  //                                 String seconds = time.sec != null
  //                                     ? (time.sec.toString().length > 1
  //                                         ? '${time.sec}'
  //                                         : '0${time.sec}')
  //                                     : '00';
  //                                 timer = minutes + seconds;
  //                                 minuteSecond = (minutes == ''
  //                                     ? ' ' + 'VerifyHPLabelSeconds'.tr
  //                                     : ' ' + 'VerifyHPLabelMinutes'.tr);
  //                               } else {
  //                                 timer = "00";
  //                                 controller.setIsAlreadyExpired();
  //                               }
  //                               return Expanded(
  //                                 child: RichText(
  //                                   textAlign: TextAlign.center,
  //                                   text: TextSpan(
  //                                       style: TextStyle(
  //                                         fontFamily: 'AvenirNext',
  //                                       ),
  //                                       children: [
  //                                         TextSpan(
  //                                             text:
  //                                                 'VerifyHPLabelCountdown'.tr +
  //                                                     " ",
  //                                             style: TextStyle(
  //                                                 fontSize: 18,
  //                                                 color:
  //                                                     Color(ListColor.color2))),
  //                                         TextSpan(
  //                                             text: timer,
  //                                             style: TextStyle(
  //                                                 fontSize: 18,
  //                                                 fontWeight: FontWeight.bold,
  //                                                 color: Colors.white)),
  //                                         TextSpan(
  //                                             text: minuteSecond,
  //                                             style: TextStyle(
  //                                                 fontSize: 18,
  //                                                 color: Colors.white))
  //                                       ]),
  //                                 ),
  //                               );
  //                               // Row(
  //                               //   mainAxisSize: MainAxisSize.min,
  //                               //   mainAxisAlignment:
  //                               //       MainAxisAlignment.start,
  //                               //   children: [
  //                               //     Text(timer,
  //                               //         style: TextStyle(
  //                               //             fontSize: 18,
  //                               //             fontWeight:
  //                               //                 FontWeight.bold,
  //                               //             color: Color(
  //                               //                 ListColor.color5))),
  //                               //     Text(minuteSecond,
  //                               //         style: TextStyle(
  //                               //             fontSize: 18,
  //                               //             fontWeight:
  //                               //                 FontWeight.bold,
  //                               //             color: Color(
  //                               //                 ListColor.color2))),
  //                               //   ],
  //                               // );
  //                             },
  //                           )
  //                         ],
  //                       ),
  //                     ]),
  //                   ),
  //                   buttonResendVerification(context)
  //                 ],
  //               ),
  //             ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => checkReturnBack(context),
      child: _content(context),
    );
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
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    // return Container(
    //     margin: EdgeInsets.only(top: controller.isExpired.value ? 20 : 80),
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
    //             controller.sendVerifyPhone(true);
    //           },
    //           child: Center(
    //               child: Text('VerifyHPButtonResendCode'.tr,
    //                   style: TextStyle(
    //                       color: Color(ListColor.color4),
    //                       fontWeight: FontWeight.w800)))),
    //     ));
  }

  // Widget showDialogEditPhone(BuildContext context) {
  //   return Dialog(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(2),
  //     ),
  //     elevation: 0,
  //     backgroundColor: Colors.transparent,
  //     child: contentBox(context),
  //   );
  // }

  showModalBottomEditPhone() {
    controller.noHPtextEditingController.text = "";
    controller.errorMessageChangeHP = "";
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return DialogChangeNumber(
            onChangeButton: (value) {
              controller.changePhoneNumber(
                  controller.scaffoldKey.value.currentContext, value);
            },
            noTelpController: controller.noHPtextEditingController,
            dialogFormKey: controller.dialogFormKey,
            errorMessage: controller.errorMessageChangeHP,
            onChangeErrorMessage: (errorMessage) {
              controller.errorMessageChangeHP = errorMessage;
            },
          );
          // Container(
          //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(20),
          //             topRight: Radius.circular(20))),
          //     child: contentBox(context));
        });
  }

  // Widget contentBox(BuildContext context) {
  //   return Form(
  //     key: _dialogFormKey,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Text(
  //           'VerifyHPLabelDialogTitleChangePhoneNumber'.tr,
  //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
  //         ),
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 20),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.max,
  //             children: [
  //               // Container(
  //               //   margin: EdgeInsets.only(top: 32, right: 20),
  //               //   child: MaterialButton(
  //               //       padding: EdgeInsets.all(13),
  //               //       shape: RoundedRectangleBorder(
  //               //           borderRadius: BorderRadius.all(Radius.circular(13)),
  //               //           side: BorderSide(color: Colors.grey)),
  //               //       onPressed: () {},
  //               //       child: Text("+62",
  //               //           style: TextStyle(color: Colors.grey, fontSize: 18))),
  //               // ),
  //               Expanded(
  //                 child: TextFormFieldWidget(
  //                     isShowError: false,
  //                     title: 'VerifyHPLabelEdtDialogChange'.tr,
  //                     validator: (String value) {
  //                       return PhoneNumberValidator.validate(
  //                           value: value,
  //                           warningIfEmpty:
  //                               'VerifyHPLabelEdtValidatorPhoneNumberEmpty'.tr,
  //                           warningIfFormatNotMatch:
  //                               'VerifyHPLabelEdtValidatorPhoneNumberFalseFormat'
  //                                   .tr,
  //                           minLength: 9);
  //                       // if (value.isEmpty)
  //                       //   return 'VerifyHPLabelEdtValidatorPhoneNumberEmpty'.tr;
  //                       // else if (value.length < 9)
  //                       //   return 'VerifyHPLabelEdtValidatorPhoneNumberFalseFormat'
  //                       //       .tr;
  //                       // return null;
  //                     },
  //                     width: widthContent(context),
  //                     isPassword: false,
  //                     isEmail: false,
  //                     isPhoneNumber: true,
  //                     textEditingController: _noTelpController,
  //                     isNextEditText: false),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(height: 20),
  //         MaterialButton(
  //             color: Color(ListColor.color5),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(30))),
  //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
  //             onPressed: () {
  //               if (_dialogFormKey.currentState.validate()) {
  //                 Get.back();
  //                 controller.changePhoneNumber(
  //                     controller.scaffoldKey.value.currentContext,
  //                     _noTelpController.text);
  //                 _noTelpController.text = "";
  //               }
  //             },
  //             child: Text('VerifyHPButtonDialogChange'.tr,
  //                 style: TextStyle(
  //                     color: Color(ListColor.color4),
  //                     fontWeight: FontWeight.w600))),
  //         // Container(
  //         //   width: widthContent(context),
  //         //   margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
  //         //   child: MaterialButton(
  //         //     shape: RoundedRectangleBorder(
  //         //       borderRadius: BorderRadius.circular(20),
  //         //     ),
  //         //     onPressed: () {
  //         //       if (_dialogFormKey.currentState.validate()) {
  //         //         Get.back();
  //         //         controller.changePhoneNumber(
  //         //             context, _noTelpController.text);
  //         //         _noTelpController.text = "";
  //         //       }
  //         //     },
  //         //     color: Color(ListColor.color4),
  //         //     child: Text('VerifyHPButtonDialogChange'.tr,
  //         //         style: TextStyle(
  //         //             color: Colors.white, fontWeight: FontWeight.w800)),
  //         //   ),
  //         // ),
  //         // Align(
  //         //   alignment: Alignment.bottomCenter,
  //         //   child: Container(
  //         //       width: widthContent(context) * 2 / 3,
  //         //       height: 40,
  //         //       decoration: BoxDecoration(
  //         //           borderRadius: BorderRadius.circular(20),
  //         //           color: Color(ListColor.color4)),
  //         //       child: Material(
  //         //         borderRadius: BorderRadius.circular(20),
  //         //         color: Colors.transparent,
  //         //         child: InkWell(
  //         //             borderRadius: BorderRadius.circular(20),
  //         //             onTap: () {
  //         //               if (_dialogFormKey.currentState.validate()) {
  //         //                 Get.back();
  //         //                 controller.changePhoneNumber(
  //         //                     context, _noTelpController.text);
  //         //                 _noTelpController.text = "";
  //         //               }
  //         //             },
  //         //             child: Center(
  //         //                 child: Text("ubah".tr,
  //         //                     style: TextStyle(
  //         //                         color: Colors.white,
  //         //                         fontWeight: FontWeight.w800)))),
  //         //       )),
  //         // ),
  //       ],
  //     ),
  //   );
  // }

  Future<bool> checkReturnBack(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: CustomText('VerifyHPLabelConfirmationBack'.tr),
            actions: [
              FlatButton(
                child: CustomText('GlobalButtonYES'.tr),
                onPressed: () {
                  Get.offAllNamed(Routes.INTRO2ALT);
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
