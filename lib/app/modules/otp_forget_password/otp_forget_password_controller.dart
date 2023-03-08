import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/change_format_number_function.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/api_login_register.dart';
import 'package:muatmuat/app/modules/create_password/create_password_controller.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_otp_phone_response_model.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_change_phone_response_model.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_check_status_response_model.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class OtpForgetPasswordController extends GetxController {
  RxList<TextEditingController> otpController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ].obs;
  RxList<FocusNode> otpFocusNode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ].obs;

  int otpLength = 6;

  final globalKeyContainerCountDown = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>().obs;
  final TextEditingController noHPtextEditingController =
      TextEditingController();
  final dialogFormKey = GlobalKey<FormState>();
  String errorMessageChangeHP = "";

  var isExpired = false.obs;
  var isVerified = false.obs;
  var isError = false.obs;
  final isGettingTime = false.obs;
  var isOTPError = false.obs;

  var endTime = 0.obs; //60 * 2
  var userModel = UserModel().obs;
  var phone = "".obs;
  var loading = true.obs;

  var docID = "".obs;
  var errorMessage = "".obs;

  Timer _timer;
  BuildContext context;
  ApiHelper apiHelperCheckVerifyPhone;
  ApiHelper apiHelperCheckOTPPhone;

  bool _isOnClose = false;
  bool _isSendingVerify = false;
  bool _isOnFirstTime = true;
  bool _isResendVerifyEmail = false;

  // double widthCountdownContainer = 0;
  // double heightCountdownContainer = 0;
  var verifID = '';
  var first = true.obs;
  RxBool wrong = false.obs;

  @override
  void onInit() {
    super.onInit();
    phone.value = Get.arguments;
    context = Get.context;
    // isVerified.value = true;
    //_startInitSend();
    // endTime.value = 10;
    // startTimer();
  }

  void _setEndTime(int timeSecond) {
    endTime.value = (DateTime.now().millisecondsSinceEpoch + 1000 * timeSecond);
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    // print("onClose");
    // _isOnClose = true;
    // _stopTimer();
  }

  cekWaktuOtp() async {
    loading.value = true;
    MessageFromUrlModel message;

    ///type 0 untuk register
    ///type 1 untuk forget password
    var body = {
      "phone": phone.value,
      "type": "1",
    };

    var response =
        await ApiLoginRegister(context: Get.context, isShowDialogLoading: true)
            .getTimerSetting(body);
    message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
    if (message != null && message.code == 200) {
      endTime.value = response["Data"]["Remaining"];
      startTimer();
    } else {
      if (message != null) {
        if (!first.value) {
          CustomToastTop.show(
              message: message.text, context: Get.context, isSuccess: 0);
        }
      } else {
        CustomToastTop.show(
            message: "Terjadi Kesalahan Server",
            context: Get.context,
            isSuccess: 0);
      }
    }
    loading.value = false;
  }

  verifyOtp() async {
    MessageFromUrlModel message;
    String otp = _buildOTP();
    var body = {
      "Phone": phone.value,
      "App": "1",
      "OTP": otp,
    };
    print('bodynya $body');
    if (otp.length == otpLength) {
      var response = await ApiLoginRegister(
        context: Get.context,
        isShowDialogLoading: true,
        isShowDialogError: true,
        isDebugGetResponse: true,
      ).verifyForgetAccountOtp(body);
      message = response['Message'] != null
          ? MessageFromUrlModel.fromJson(response['Message'])
          : null;
      if (message != null && message.code == 200) {
        print('response nya $response tokennya');
        print('response nya ${response["Data"]["Token"]} tokennya');
        print('refo');
        var result = await GetToPage.toNamed<CreatePasswordController>(
            Routes.CREATE_PASSWORD,
            arguments: [phone.value, response["Data"]["Token"]]);
        if (result != null) {
          if (result) {
            Get.back(result: true);
          }
        }
      } else {
        if (response != null && response['Data'] != null) {
          if(response['Data']['Message'].toString().contains('expired')){
            wrong.value = true;
          CustomToastTop.show(
            message: "Kode OTP yang Anda masukkan telah\nexpired!",
            context: Get.context,
            isSuccess: 0,
          );
          }
          else{
            wrong.value = true;
          CustomToastTop.show(
            message: "Kode OTP yang Anda masukkan salah!",
            context: Get.context,
            isSuccess: 0,
          );
          }
          
        } else {
          if (message != null) {
            wrong.value = true;
            CustomToastTop.show(
              message: message.text,
              context: Get.context,
              isSuccess: 0,
            );
          } else {
            CustomToastTop.show(
              message: "Terjadi Kesalahan Server",
              context: Get.context,
              isSuccess: 0,
            );
          }
        }
      }
    }
  }

  resendOtp() async {
    // loading.value = true;
    MessageFromUrlModel message;
    var body = {
      "Phone": phone.value,
      "App": "1",
    };

    var response =
        await ApiLoginRegister(context: Get.context, isShowDialogLoading: true)
            .forgotPassword(body);
    message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
    if (message != null && message.code == 200) {
      cekWaktuOtp();
    } else {
      if (message != null) {
        CustomToastTop.show(
            message: message.text, context: Get.context, isSuccess: 0);
      } else {
        CustomToastTop.show(
            message: "Terjadi Kesalahan Server",
            context: Get.context,
            isSuccess: 0);
      }
      loading.value = true;
    }

    resetOtpText();
  }

  changePhoneNumber() async {
    MessageFromUrlModel message;
    var body = {
      "phone": userModel.value.phone,
    };

    var response =
        await ApiLoginRegister(context: Get.context, isShowDialogLoading: false)
            .doChangePhoneAtRegister(body);
    message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
    if (message != null && message.code == 200) {
    } else {
      if (message != null) {
        CustomToastTop.show(
            message: message.text, context: Get.context, isSuccess: 0);
      } else {
        CustomToastTop.show(
            message: "Terjadi Kesalahan Server",
            context: Get.context,
            isSuccess: 0);
      }
    }
  }

  void onWillPop() {
    if (_timer != null) {
      _timer.cancel();
    }
    Get.back();
  }

  void resetOtpText() {
    for (int i = 0; i < otpLength; i++) {
      otpController[i].clear();
    }
    otpFocusNode[0].requestFocus();
    wrong.value = false;
  }

  String formatedTime({@required int timeInSecond}) {
    int sec = endTime.value % 60;
    int min = (endTime.value / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (endTime.value == 0) {
        timer.cancel();
      } else {
        endTime.value--;
      }
    });
  }

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
                              color: Color(ListColor.colorLightGrey2)),
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

  Future _checkVerifyPhone({bool isStartTimerWhenNotVerify = true}) async {
    if (apiHelperCheckVerifyPhone == null) {
      apiHelperCheckVerifyPhone = ApiHelper(
          context: context,
          isShowDialogLoading: false,
          isShowDialogError: false);
    }
    var responseBody = await apiHelperCheckVerifyPhone.fetchVerifyPhone(
        userModel.value.docID, userModel.value.phone);
    if (responseBody == null) {
      isError.value = true;
      errorMessage.value = apiHelperCheckVerifyPhone.errorMessage;
    } else {
      VerifyPhoneCheckStatusResponseModel verifyResponse =
          VerifyPhoneCheckStatusResponseModel.fromJson(responseBody);
      if (verifyResponse.message.code == 200) {
        verifID = verifyResponse.verifId;
        userModel.value.code = verifyResponse.code;
        if (verifyResponse.verif == "1") {
          isVerified.value = true;
          userModel.value.code = verifyResponse.code;
        } else {
          isVerified.value = false;
          isError.value = false;
          if (isStartTimerWhenNotVerify) _startTimerVerify();
        }
      } else {
        isError.value = true;
        errorMessage.value =
            verifyResponse.message.text + "(TYPE: " + verifyResponse.type + ")";
      }
    }
  }

  Future checkVerifyOTP() async {
    String otp = _buildOTP();
    if (otp.length == otpLength) {
      if (apiHelperCheckOTPPhone == null)
        apiHelperCheckOTPPhone = ApiHelper(
            context: context,
            isShowDialogLoading: false,
            isShowDialogError: false);
      var reponseBody =
          await apiHelperCheckOTPPhone.fetchVerifyOTPPhone(verifID, otp);
      if (reponseBody != null) {
        // VerifyOTPPhoneResponseModel verifyOTPPhoneResponse =
        //     VerifyOTPPhoneResponseModel.fromJson(reponseBody);
        if (reponseBody["Message"]["Code"] == 200) {
          // if (verifyOTPPhoneResponse.isVerif) {
          isVerified.value = true;
          // userModel.value.code = verifyOTPPhoneResponse.docID;
          // } else {
          //   isVerified.value = false;
          //   _startTimerVerify();
          // }
        } else {
          isError.value = true;
          errorMessage.value = reponseBody["Message"]["Text"]
              // + "(TYPE: " +
              // verifyOTPPhoneResponse.type +
              // ")"
              ;
        }
      }
    }
  }

  Future sendVerifyPhone() async {
    _resetError();
    _isSendingVerify = true;
    isGettingTime.value = true;
    ApiHelper apiHelper = ApiHelper(
        context: context, isShowDialogLoading: false, isShowDialogError: false);
    var reponseBody =
        await apiHelper.fetchResendVerifyPhone(userModel.value.docID);
    //var reponseBody = jsonDecode(response.body);
    if (reponseBody != null) {
      VerifyPhoneResponseModel verifyResponse =
          VerifyPhoneResponseModel.fromJson(reponseBody);
      if (verifyResponse.message.code == 200) {
        _isSendingVerify = false;
        _isResendVerifyEmail = false;
        _setEndTime(verifyResponse.countdown);
        isGettingTime.value = false;
        _startTimerVerify();
      } else {
        _setError(verifyResponse.message.text +
            "(TYPE: " +
            verifyResponse.type +
            ")");
      }
    } else {
      _setError(apiHelper.errorMessage);
    }
  }

  void _stopTimer() {
    if (_timer != null) _timer.cancel();
  }

  void _startTimerVerify() async {
    if (!isExpired.value && !_isOnClose)
      _timer = Timer(Duration(seconds: 1), () async {
        _checkVerifyPhone();
      });
  }

  void _resetAll() {
    _stopTimer();
    isExpired.value = false;
    isVerified.value = false;
    _resetError();
  }

  void _restartTimer() {
    _resetAll();
    _startTimerVerify();
  }

  void _retrySendVerifyToPhone() {
    _resetAll();
    sendVerifyPhone();
  }

  void resendToPhone() async {
    isGettingTime.value = true;
    _isResendVerifyEmail = true;
    await _checkVerifyPhone(isStartTimerWhenNotVerify: false);
    if (!isVerified.value && !isError.value) {
      _resetAll();
      sendVerifyPhone();
    } else {
      isGettingTime.value = false;
    }
  }

  void _continueCheckVerify() {
    _stopTimer();
    _resetError();
    _startTimerVerify();
  }

  void setIsAlreadyExpired() {
    if (!_isOnFirstTime) {
      _stopTimer();
      //isExpired.value = true;
      Timer(Duration(milliseconds: 1), () async {
        isExpired.value = true;
      });
    }
  }

  void _getToHome() {
    LoginFunction().saveDataUserGotoHome(userModel.value);
  }

  Future onClickOK() async {
    if (GlobalVariable.tokenApp != "") {
      _getToHome();
    } else {
      //Get.offAllNamed(Routes.LOGIN);
      LoginFunction loginFunction = LoginFunction();
      await loginFunction.loginUserWithSavedDataAndMessage(
          userModel.value, userModel.value.isGoogle, true);
      if (loginFunction.isSuccess) {
        loginFunction.userModel;
        GlobalVariable.tokenApp;
        Get.offAllNamed(Routes.CHOOSE_USER_TYPE);
      }
    }
  }

  // Future changePhoneNumber(BuildContext context, String phone) async {
  //   _resetError();
  //   phone = convertPhoneNumber(phone);
  //   var responseBody = await ApiHelper(
  //           context: context,
  //           isShowDialogLoading: true,
  //           isShowDialogError: false)
  //       .fetchChangeNumber(userModel.value.docID, phone);
  //   if (responseBody != null) {
  //     VerifyPhoneChangePhoneResponseModel verifyChangePhoneResponse =
  //         VerifyPhoneChangePhoneResponseModel.fromJson(responseBody);
  //     if (verifyChangePhoneResponse.message.code == 200) {
  //       userModel.value.phone = phone;
  //       userModel.refresh();
  //       GlobalAlertDialog.showAlertDialogCustom(
  //           title: 'GlobalLabelSuccess'.tr,
  //           isDismissible: false,
  //           message: 'VerifyHPLabelDialogSuccessChangePhoneNumber'.tr,
  //           context: context,
  //           labelButtonPriority1: 'GlobalButtonOK'.tr);
  //       resendToPhone();
  //     } else {
  //       GlobalAlertDialog.showDialogError(
  //           message: verifyChangePhoneResponse.data,
  //           context: context,
  //           isDismissible: false);
  //     }
  //   } else {
  //     GlobalAlertDialog.showDialogError(
  //         message: "GlobalLabelErrorNullResponse".tr,
  //         context: context,
  //         isDismissible: false);
  //   }
  // }

  void _setError(String message) {
    isError.value = true;
    errorMessage.value = message;
  }

  void _resetError() {
    isError.value = false;
    errorMessage.value = "";
  }

  // void setContextAndInitData(BuildContext context) {
  //   if (this.context == null) {
  //     this.context = context;
  //     _startInitSend();
  //   }
  // }

  Future _startInitSend() async {
    //setEndTime();
    await sendVerifyPhone();
    _checkVerifyPhone();
  }

  void tryAgainCheckPhoneNumber() {
    if (_isSendingVerify)
      _retrySendVerifyToPhone();
    else if (_isResendVerifyEmail)
      resendToPhone();
    else
      _continueCheckVerify();
  }

  String convertPhoneNumber(String number) {
    return ChangeFormatNumberFunction.convertPhoneNumber(number);
  }

  void onCompleteBuild() async {
    // if (_isOnFirstTime) {
    //   _isOnFirstTime = false;
    // final renderBox = globalKeyContainerCountDown.currentContext
    //     .findRenderObject() as RenderBox;
    // widthCountdownContainer = renderBox.size.width;
    // heightCountdownContainer = renderBox.size.height;

    // _startInitSend();
    // }

    if (first.value) {
      await cekWaktuOtp();
      first.value = false;
    }
  }

  void _clearOTP(bool isError) {
    for (int i = 0; i < otpLength; i++) {
      otpController[i].text = '';
    }
    otpFocusNode[0].requestFocus();
    isOTPError.value = isError;
  }

  String _buildOTP() {
    String result = '';
    for (int i = 0; i < otpLength; i++) {
      result = result + otpController[i].text.trim();
    }
    print('resultnya' + result);
    return result;
  }
}
