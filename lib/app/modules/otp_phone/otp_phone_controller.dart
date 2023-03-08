import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/change_format_number_function.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/api_login_register.dart';
import 'package:muatmuat/app/modules/success_register/success_register_controller.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_check_status_response_model.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';

class OtpPhoneController extends GetxController {
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
  // String errorMessageChangeHP = "";

  var isExpired = false.obs;
  var isVerified = false.obs;
  var isError = false.obs;
  final isGettingTime = false.obs;
  var isOTPError = false.obs;

  var endTime = 0.obs; //60 * 2
  var userModel = UserModel().obs;
  var loading = true.obs;

  var docID = "".obs;
  var errorMessage = "".obs;

  // for dialog change no wa
  var errorMessageDialog = "".obs;
  var changePhoneNoValue = "".obs;

  Timer _timer;
  BuildContext context;
  ApiHelper apiHelperCheckVerifyPhone;
  ApiHelper apiHelperCheckOTPPhone;
  var phoneNumber = "".obs;

  bool _isOnClose = false;
  bool _isSendingVerify = false;
  bool _isOnFirstTime = true;
  bool _isResendVerifyEmail = false;

  // double widthCountdownContainer = 0;
  // double heightCountdownContainer = 0;
  var verifID = '';
  var first = true.obs;

  var errorOtp = false.obs;

  @override
  void onInit() {
    super.onInit();
    userModel.value = Get.arguments;
    phoneNumber.value = userModel.value.phone;
    if (kDebugMode) print(userModel.value.toJson());
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
    super.onClose();
    _stopTimer();
  }

  cekWaktuOtp(String type) async {
    loading.value = true;
    MessageFromUrlModel message;

    ///type 0 untuk register
    ///type 1 untuk forget password
    ///type 2 untuk change phone
    var body = {
      "phone": userModel.value.phone,
      "type": type,
    };
    
    var response = await ApiLoginRegister(context: Get.context, isShowDialogLoading: false).getTimerSetting(body);
    message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;
    if (kDebugMode) print("RESPONSE cekWaktuOtp :: $response");
    if (message != null && message.code == 200) {
      endTime.value = response["Data"]["Remaining"];
      resetOtpText();
      startTimer();
    } else {
      if (response != null && response['Data'] != null) {
        CustomToastTop.show(
          message: "${response['Data']['Message']}",
          context: Get.context,
          isSuccess: 0,
        );
      } else {
        if (message != null) {
          if (!first.value) {
            CustomToastTop.show(
              message: message.text,
              context: Get.context,
              isSuccess: 0,
            );
          }
        } else {
          CustomToastTop.show(
            message: "Terjadi Kesalahan Server",
            context: Get.context,
            isSuccess: 0,
          );
        }
      }
    }
    loading.value = false;
  }

  verifyOtp() async {
    MessageFromUrlModel message;
    String otp = _buildOTP();
    var body = {
      "phone": userModel.value.phone,
      "otp": otp,
      "Lang": GlobalVariable.languageType
    };
    errorOtp.value = false;
    if (otp.length == otpLength) {
      var response = await ApiLoginRegister(context: Get.context, isShowDialogLoading: true).verifyOtp(body);
      message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
      if (kDebugMode) print("RESPONSE VERIFY OTP :: $response");
      if (message != null && message.code == 200) {
        errorOtp.value = false;
        GlobalVariable.userModelGlobal = UserModel(
          docID: (response["Data"]["UserData"]["ID"]).toString(),
          email: response["Data"]["UserData"]["Email"],
          isGoogle: response["Data"]["UserData"]["IsGoogle"] == 1,
          isVerifPhone: response["Data"]["UserData"]["IsVerifPhone"] == 1,
          name: response["Data"]["UserData"]["Name"],
          password: "",
          phone: response["Data"]["Phone"],
          code: response["Data"]["Code"].toString(),
          referralCode: response["Data"]["RefCode"].toString()
        );

        GlobalVariable.tokenApp = response["Data"]["UserData"]["Token"];
        log("Token: " + GlobalVariable.tokenApp);

        // save user session
        await SharedPreferencesHelper.setUserLogin(GlobalVariable.userModelGlobal);                                                
        final checkUserRes = await ApiHelper(context: Get.context, isShowDialogLoading: true).fetchCheckUser();
        if (checkUserRes["Data"].isNotEmpty) {
          await SharedPreferencesHelper.setUserShipperID(checkUserRes["Data"]["ShipperID"].toString());
        }

        GetToPage.offAllNamed<SuccessRegisterController>(
          Routes.SUCCESS_REGISTER,
          arguments: response["Data"]["RefCode"]
        );
      } else {
        if (response != null && response['Data'] != null) {
          CustomToastTop.show(
            message: "${response['Data']['Message']}",
            context: Get.context,
            isSuccess: 0,
          );
          errorOtp.value = true;
        } else {
          if (message != null) {
            CustomToastTop.show(
              message: message.text,
              context: Get.context,
              isSuccess: 0,
            );
            errorOtp.value = true;
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
    loading.value = true;
    MessageFromUrlModel message;
    var body = {
      "phone": userModel.value.phone,
    };

    try {
      var response = await ApiLoginRegister(context: Get.context).resendOtpRegister(body);
      message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;
      if (message != null && message.code == 200) {
        CustomToastTop.show(message: "GeneralLROTPLabelBerhasilKirimUlangOTP".tr, context: Get.context, isSuccess: 1);
        cekWaktuOtp("0");
      } else {
        if (message != null) {
          CustomToastTop.show(message: message.text, context: Get.context, isSuccess: 0);
        } else {
          CustomToastTop.show(
            message: "Terjadi Kesalahan Server",
            context: Get.context,
            isSuccess: 0
          );
        }
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
    }

    resetOtpText();
  }

  changePhoneNumber() async {
    MessageFromUrlModel message;
    var body = {
      "old_phone": userModel.value.phone,
      "new_phone": changePhoneNoValue.value,
      "app": "1",
      "Lang": GlobalVariable.languageType
    };

    if (changePhoneNoValue.value.length < 8) {
      errorMessageDialog.value = 'GlobalValidationLabelNoWhatsappMinimal8'.tr;
      return;
    }

    var response = await ApiLoginRegister(
      context: Get.context,
      isShowDialogLoading: true,
      isDebugGetResponse: true,
    ).doChangePhoneAtRegister(body);

    if (response != null) {
      message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;
    }

    print("RESPONSE API :: $response");

    if (message != null && message.code == 200) {
      // update user model
      userModel.value.phone = changePhoneNoValue.value;
      phoneNumber.value = userModel.value.phone;
      Get.back(); // dismiss the dialog
      await cekWaktuOtp("2");
      CustomToastTop.show(
        message: "Berhasil mengubah No. Whatsapp",
        context: Get.context,
        isSuccess: 1
      );
      // cekWaktuOtp();
    } else {
      // notify user the error
      if (response != null && response['Data'] != null) {
        errorMessageDialog.value = "${response['Data']['Message']}".replaceAll("!", "");
      } else {
        if (message != null) {
          CustomToastTop.show(message: message.text, context: Get.context, isSuccess: 0);
        } else {
          CustomToastTop.show(
            message: "Terjadi Kesalahan Server",
            context: Get.context,
            isSuccess: 0
          );
        }
      }
    }
  }

  void resetOtpText() {
    for (int i = 0; i < otpLength; i++) {
      otpController[i].clear();
    }
    otpFocusNode[0].requestFocus();
    errorOtp.value = false;
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

  Future _checkVerifyPhone({bool isStartTimerWhenNotVerify = true}) async {
    if (apiHelperCheckVerifyPhone == null) {
      apiHelperCheckVerifyPhone = ApiHelper(
        context: context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      );
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
        if (reponseBody["Message"]["Code"] == 200) {
          isVerified.value = true;
        } else {
          isError.value = true;
          errorMessage.value = reponseBody["Message"]["Text"];
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

  void _retrySendVerifyToPhone() {
    _resetAll();
    sendVerifyPhone();
  }

  onWillPop() {
    if (_timer != null) {
      _timer.cancel();
    }
    SystemNavigator.pop();
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
      Timer(Duration(milliseconds: 1), () async {
        isExpired.value = true;
      });
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
    if (first.value) {
      await cekWaktuOtp("0");
      first.value = false;
    }
  }

  String _buildOTP() {
    String result = '';
    for (int i = 0; i < otpLength; i++) {
      result = result + otpController[i].text.trim();
    }
    return result;
  }
}
