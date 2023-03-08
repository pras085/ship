import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/modules/verify_email/verify_email_resend_response_model.dart';
import 'package:muatmuat/app/modules/verify_email/verify_email_response_model.dart';
import 'package:muatmuat/app/modules/verify_email/verify_otp_email_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';

class VerifyEmailController extends GetxController {
  //UserController _userController = Get.find();

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

  var isExpired = false.obs;
  var isVerified = false.obs;
  var isError = false.obs;
  final isErrorForceStopEmail = false.obs;
  var errorMessage = "".obs;
  var email = "".obs;
  var endTime = 0.obs; //60 * 2
  var isOTPError = false.obs;
  Timer _timer;
  BuildContext context;
  ApiHelper apiHelperCheckEmail;
  ApiHelper apiHelperCheckOTPEmail;
  UserModel userModel;

  @override
  void onInit() {
    userModel = Get.arguments;
    context = Get.context;
    _startInitSend();
    //email.value = _userController.userModel.value.email;
  }

  @override
  void onReady() {}

  void _startInitSend() {
    email.value = userModel.email;
    setEndTime();
    if (email.value != "") startTimerVerify();
  }

  @override
  void onClose() {
    print("onClose");
    _timer.cancel();
  }

  void _restartTimer() {
    _stopTimer();
    setEndTime();
    isExpired.value = false;
    isVerified.value = false;

    _resetError();
    startTimerVerify();
  }

  void tryAgainCheckEmail() {
    _stopTimer();
    _resetError();
    startTimerVerify();
  }

  Future _checkVerifyEmail() async {
    _resetError();
    if (apiHelperCheckEmail == null)
      apiHelperCheckEmail = ApiHelper(
          context: context,
          isShowDialogLoading: false,
          isShowDialogError: false);
    var reponseBody = await apiHelperCheckEmail.fetchVerifyEmail(email.value);
    //var reponseBody = jsonDecode(response.body);
    if (reponseBody != null) {
      VerifyEmailResponseModel verifyEmailResponse =
          VerifyEmailResponseModel.fromJson(reponseBody);
      if (verifyEmailResponse.message.code == 200) {
        if (verifyEmailResponse.isVerif) {
          userModel.docID = verifyEmailResponse.docID;
          toNextView();
        } else {
          isVerified.value = false;
          startTimerVerify();
        }
      } else {
        if (verifyEmailResponse.isForceStopVerify) {
          isErrorForceStopEmail.value = true;
          _setError(verifyEmailResponse.messageError +
              "(TYPE: " +
              verifyEmailResponse.type +
              ")");
        } else {
          _setError(verifyEmailResponse.message.text +
              "(TYPE: " +
              verifyEmailResponse.type +
              ")");
        }
      }
    } else {
      _setError(apiHelperCheckEmail.errorMessage);
    }
  }

  Future checkVerifyOTP() async {
    String verifID = '';
    String otp = _buildOTP();
    if (otp.length == otpLength) {
      if (apiHelperCheckOTPEmail == null)
        apiHelperCheckOTPEmail = ApiHelper(
            context: context,
            isShowDialogLoading: false,
            isShowDialogError: false);
      var reponseBody =
          await apiHelperCheckOTPEmail.fetchVerifyOTPEmail(verifID, otp);
      if (reponseBody != null) {
        VerifyOTPEmailResponseModel verifyOTPEmailResponse =
            VerifyOTPEmailResponseModel.fromJson(reponseBody);
        if (verifyOTPEmailResponse.message.code == 200) {
          if (verifyOTPEmailResponse.isVerif) {
            userModel.docID = verifyOTPEmailResponse.docID;
            toNextView();
          } else {
            _clearOTP(true);
            isVerified.value = false;
            startTimerVerify();
          }
        } else {
          _clearOTP(true);
          if (verifyOTPEmailResponse.isForceStopVerify) {
            isErrorForceStopEmail.value = true;
            _setError(verifyOTPEmailResponse.messageError +
                "(TYPE: " +
                verifyOTPEmailResponse.type +
                ")");
          } else {
            _setError(verifyOTPEmailResponse.message.text +
                "(TYPE: " +
                verifyOTPEmailResponse.type +
                ")");
          }
        }
      } else {
        _clearOTP(true);
        _setError(apiHelperCheckEmail.errorMessage);
      }
    }
  }

  Future resendVerifyEmail() async {
    _resetError();
    var reponseBody =
        await ApiHelper(context: context, isShowDialogLoading: true)
            .fetchResendVerifyEmail(userModel.docID);
    //var reponseBody = jsonDecode(response.body);
    VerifyEmailResendResponseModel resendResponse =
        VerifyEmailResendResponseModel.fromJson(reponseBody);
    if (resendResponse.message.code == 200) {
      _restartTimer();
    } else if (resendResponse.isForceStopVerify) {
      isErrorForceStopEmail.value = true;
      _setError(resendResponse.messageInsideData +
          "(TYPE: " +
          resendResponse.type +
          ")");
    } else {
      _setError('GlobalLabelErrorNullResponse'.tr);
    }
  }

  void _stopTimer() {
    if (_timer != null) _timer.cancel();
  }

  void startTimerVerify() async {
    if (!isExpired.value) {
      _stopTimer();
      _timer = Timer(Duration(seconds: 1), () async {
        _checkVerifyEmail();
      });
    }
  }

  void setIsAlreadyExpired() {
    _stopTimer();
    Timer(Duration(milliseconds: 1), () async {
      isExpired.value = true;
    });
  }

  void setEndTime() {
    endTime.value = (DateTime.now().millisecondsSinceEpoch +
        1000 * GlobalVariable.timeoutToken);
  }

  // void setContextAndInitData() {
  //   if (this.context == null) {
  //     this.context = context;
  //     _startInitSend();
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

  void toNextView() {
    _stopTimer();
    Get.offAllNamed(Routes.VERIFY_PHONE, arguments: userModel);
  }

  void reRegister() {
    Get.back(result: {
      'reset': true,
    });
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
