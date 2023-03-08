import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/change_format_number_function.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_otp_phone_response_model.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_change_phone_response_model.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_check_status_response_model.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/global_variable.dart';

class VerifyPhoneController extends GetxController {
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

  @override
  void onInit() {
    userModel.value = Get.arguments;
    context = Get.context;
    // isVerified.value = true;
    //_startInitSend();
  }

  void _setEndTime(int timeSecond) {
    endTime.value = (DateTime.now().millisecondsSinceEpoch + 1000 * timeSecond);
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    print("onClose");
    _isOnClose = true;
    _stopTimer();
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

  Future changePhoneNumber(BuildContext context, String phone) async {
    _resetError();
    phone = convertPhoneNumber(phone);
    var responseBody = await ApiHelper(
            context: context,
            isShowDialogLoading: true,
            isShowDialogError: false)
        .fetchChangeNumber(userModel.value.docID, phone);
    if (responseBody != null) {
      VerifyPhoneChangePhoneResponseModel verifyChangePhoneResponse =
          VerifyPhoneChangePhoneResponseModel.fromJson(responseBody);
      if (verifyChangePhoneResponse.message.code == 200) {
        userModel.value.phone = phone;
        userModel.refresh();
        GlobalAlertDialog.showAlertDialogCustom(
            title: 'GlobalLabelSuccess'.tr,
            isDismissible: false,
            message: 'VerifyHPLabelDialogSuccessChangePhoneNumber'.tr,
            context: context,
            labelButtonPriority1: 'GlobalButtonOK'.tr);
        resendToPhone();
      } else {
        GlobalAlertDialog.showDialogError(
            message: verifyChangePhoneResponse.data,
            context: context,
            isDismissible: false);
      }
    } else {
      GlobalAlertDialog.showDialogError(
          message: "GlobalLabelErrorNullResponse".tr,
          context: context,
          isDismissible: false);
    }
  }

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

  void onCompleteBuild() {
    if (_isOnFirstTime) {
      _isOnFirstTime = false;
      // final renderBox = globalKeyContainerCountDown.currentContext
      //     .findRenderObject() as RenderBox;
      // widthCountdownContainer = renderBox.size.width;
      // heightCountdownContainer = renderBox.size.height;
      _startInitSend();
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
    return result;
  }
}
