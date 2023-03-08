import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_email_profile/verify_email_check_status_response_model.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_email_profile/verify_email_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/global_variable.dart';

class OtpEmailProfileController extends GetxController {
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
  var changeEmailValue = "".obs;

  Timer _timer;
  BuildContext context;
  ApiHelper apiHelperCheckVerifyEmail;
  ApiHelper apiHelperCheckOTPEmail;
  var email = "".obs;
  var tokenFromOtp = "".obs;

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

    if (kDebugMode) print(userModel.value.toJson());
    context = Get.context;

    email.value = Get.arguments["email"];
    tokenFromOtp.value = Get.arguments["token"];
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

    // TYPE_CHANGE_EMAIL_AT_PROFILE = 11;
    var body = {
      "email": email.value,
      "type": type,
    };
    
    var response = await ApiProfile(context: Get.context, isShowDialogLoading: false).getTimerSettingEmail(body);
    message = response['Message'] != null 
      ? MessageFromUrlModel.fromJson(response['Message']) 
      : null;
    if (kDebugMode) print("RESPONSE cekWaktuOtp :: $response");
    if (message != null && message.code == 200) {
      endTime.value = response["Data"]["Remaining"];
      startTimer();
    } 
    else {
      if (response != null && response['Data'] != null) {
        CustomToastTop.show(
          message: "${response['Data']['Message']}",
          context: Get.context,
          isSuccess: 0,
        );
      } 
      else {
        if (message != null) {
          if (!first.value) {
            CustomToastTop.show(
              message: message.text,
              context: Get.context,
              isSuccess: 0,
            );
          }
          else {
            resendOtp();
          }
        } 
        else {
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
      "otp": otp,
      "verif_type": "11",
      "App": "1",
      "Email": email.value
    };
    errorOtp.value = false;
    if (otp.length == otpLength) {
      var response = await ApiProfile(
        context: Get.context, 
        isShowDialogLoading: true, 
        isShowDialogError: true, 
        isDebugGetResponse: true
      ).checkOtpEmailUsers(body);

      message = response['Message'] != null
        ? MessageFromUrlModel.fromJson(response['Message'])
        : null;
      if (kDebugMode) print("RESPONSE VERIFY OTP :: $response");
      if (message != null && message.code == 200) {
        errorOtp.value = false;
        // GlobalVariable.userModelGlobal = UserModel(
        //   docID: (response["Data"]["UserData"]["ID"]).toString(),
        //   email: response["Data"]["UserData"]["Email"],
        //   isGoogle: response["Data"]["UserData"]["IsGoogle"] == 1,
        //   isVerifPhone: response["Data"]["UserData"]["IsVerifPhone"] == 1,
        //   name: response["Data"]["UserData"]["Name"],
        //   password: "",
        //   phone: response["Data"]["Phone"],
        //   referralCode: response["Data"]["RefCode"]
        // );

        // GlobalVariable.tokenApp = response["Data"]["UserData"]["Token"];
        // log("Token: " + GlobalVariable.tokenApp);

        // // save user session
        // await SharedPreferencesHelper.setUserLogin(GlobalVariable.userModelGlobal);                                                
        // final checkUserRes = await ApiHelper(context: Get.context, isShowDialogLoading: true).fetchCheckUser();
        // if (checkUserRes["Data"].isNotEmpty) {
        //   await SharedPreferencesHelper.setUserShipperID(checkUserRes["Data"]["ShipperID"].toString());
        // }

        // GetToPage.offAllNamed<SuccessRegisterController>(
        //   Routes.SUCCESS_REGISTER,
        //   arguments: response["Data"]["RefCode"]
        // );

        // update user model
        log("Email Current: " + email.value);
        log("Email Change: " + changeEmailValue.value);

        GlobalVariable.userModelGlobal.email = changeEmailValue.value;
        GlobalVariable.userModelGlobal.email = email.value;
        email.value = userModel.value.email;

        LoginFunction().signOut2();
        // Get.offAllNamed(Routes.FAKE_HOME);
      } 
      else {
        if (response != null && response['Data'] != null) {
          CustomToastTop.show(
            message: "${response['Data']['Message']}",
            context: Get.context,
            isSuccess: 0,
          );
          errorOtp.value = true;
        } 
        else {
          if (message != null) {
            CustomToastTop.show(
              message: message.text,
              context: Get.context,
              isSuccess: 0,
            );
            errorOtp.value = true;
          } 
          else {
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

    try {
      // ========== RESEND OTP EMAIL USERS THEN GET TIMER SETTING EMAIL "ERROR" 13/1/2023 ==========
      // var response = await ApiProfile(
      //   context: Get.context, 
      //   isShowDialogLoading: true, 
      //   isShowDialogError: true, 
      //   isDebugGetResponse: true
      // ).resendOtpEmailUsers({});

      var body = {
        "Email_baru": email.value,
        "Token": tokenFromOtp.value
      };

      var response = await ApiProfile(
        context: Get.context,
        isShowDialogLoading: true,
        isShowDialogError: true,
        isDebugGetResponse: true,
      ).otpEmailUsers(body);

      message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;
      if (message != null && message.code == 200) {
        if (!first.value)
        CustomToastTop.show(message: "GeneralLROTPLabelBerhasilKirimUlangOTP".tr, context: Get.context, isSuccess: 1);
        cekWaktuOtp("11");
      } 
      else {
        if (message != null) {
          CustomToastTop.show(message: message.text, context: Get.context, isSuccess: 0);
        } 
        else {
          CustomToastTop.show(
            message: "Terjadi Kesalahan Server",
            context: Get.context,
            isSuccess: 0
          );
        }
        loading.value = false;
      }

      for (int i = 0; i < otpLength; i++) {
        otpController[i].clear();
      }
      otpFocusNode[0].requestFocus();
      errorOtp.value = false;
    } 
    catch (e) {
      loading.value = false;
    }
  }

  changeEmail() async {
    MessageFromUrlModel message;
    log("No Email Change: " + changeEmailValue.value);
    var body = {
      "Email_baru": changeEmailValue.value,
      "Token": tokenFromOtp.value
    };

    if (Utils.validateFormatEmail(changeEmailValue.value) != "") {
      errorMessageDialog.value = Utils.validateFormatEmail(changeEmailValue.value);
      return;
    }

    var response = await ApiProfile(
      context: Get.context,
      isShowDialogLoading: true,
      isShowDialogError: true,
      isDebugGetResponse: true,
    ).otpEmailUsers(body);

    if (response != null) {
      message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;
    }

    print("RESPONSE API :: $response");

    if (message != null && message.code == 200) {
      // update user model
      userModel.value.email = changeEmailValue.value;
      email.value = userModel.value.email;
      Get.back(); // dismiss the dialog
      await cekWaktuOtp("11");

      for (int i = 0; i < otpLength; i++) {
        otpController[i].clear();
      }
      otpFocusNode[0].requestFocus();
      errorOtp.value = false;
      
      CustomToastTop.show(
        message: "Berhasil mengubah Email",
        context: Get.context,
        isSuccess: 1
      );
      // cekWaktuOtp();
    } 
    else {
      // notify user the error
      if (response != null && response['Data'] != null) {
        errorMessageDialog.value = "${response['Data']['Message']}".replaceAll("!", "");
      } 
      else {
        if (message != null) {
          CustomToastTop.show(message: message.text, context: Get.context, isSuccess: 0);
        } 
        else {
          CustomToastTop.show(
            message: "Terjadi Kesalahan Server",
            context: Get.context,
            isSuccess: 0
          );
        }
      }
    }
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
      } 
      else {
        endTime.value--;
      }
    });
  }

  Future _checkVerifyEmail({bool isStartTimerWhenNotVerify = true}) async {
    if (apiHelperCheckVerifyEmail == null) {
      apiHelperCheckVerifyEmail = ApiHelper(
        context: context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      );
    }
    var responseBody = await apiHelperCheckVerifyEmail.fetchVerifyEmail(userModel.value.email);
    if (responseBody == null) {
      isError.value = true;
      errorMessage.value = apiHelperCheckVerifyEmail.errorMessage;
    } 
    else {
      VerifyEmailCheckStatusResponseModel verifyResponse = VerifyEmailCheckStatusResponseModel.fromJson(responseBody);
      if (verifyResponse.message.code == 200) {
        verifID = verifyResponse.verifId;
        userModel.value.code = verifyResponse.code;
        if (verifyResponse.verif == "1") {
          isVerified.value = true;
          userModel.value.code = verifyResponse.code;
        } 
        else {
          isVerified.value = false;
          isError.value = false;
          if (isStartTimerWhenNotVerify) _startTimerVerify();
        }
      } 
      else {
        isError.value = true;
        errorMessage.value = verifyResponse.message.text + "(TYPE: " + verifyResponse.type + ")";
      }
    }
  }

  Future checkVerifyOTP() async {
    String otp = _buildOTP();
    if (otp.length == otpLength) {
      if (apiHelperCheckOTPEmail == null)
        apiHelperCheckOTPEmail = ApiHelper(
          context: context,
          isShowDialogLoading: false,
          isShowDialogError: false
        );
      var reponseBody = await apiHelperCheckOTPEmail.fetchVerifyOTPEmail(verifID, otp);
      if (reponseBody != null) {
        if (reponseBody["Message"]["Code"] == 200) {
          isVerified.value = true;
        } 
        else {
          isError.value = true;
          errorMessage.value = reponseBody["Message"]["Text"];
        }
      }
    }
  }

  Future sendVerifyEmail() async {
    _resetError();
    _isSendingVerify = true;
    isGettingTime.value = true;
    ApiHelper apiHelper = ApiHelper(context: context, isShowDialogLoading: false, isShowDialogError: false);
    var reponseBody = await apiHelper.fetchResendVerifyEmail(userModel.value.docID);
    if (reponseBody != null) {
      VerifyEmailResponseModel verifyResponse = VerifyEmailResponseModel.fromJson(reponseBody);
      if (verifyResponse.message.code == 200) {
        _isSendingVerify = false;
        _isResendVerifyEmail = false;
        _setEndTime(verifyResponse.countdown);
        isGettingTime.value = false;
        _startTimerVerify();
      } 
      else {
        _setError(verifyResponse.message.text + "(TYPE: " + verifyResponse.type + ")");
      }
    } 
    else {
      _setError(apiHelper.errorMessage);
    }
  }

  void _stopTimer() {
    if (_timer != null) _timer.cancel();
  }

  void _startTimerVerify() async {
    if (!isExpired.value && !_isOnClose)
      _timer = Timer(Duration(seconds: 1), () async {
        _checkVerifyEmail();
      });
  }

  void _resetAll() {
    _stopTimer();
    isExpired.value = false;
    isVerified.value = false;
    _resetError();
  }

  void _retrySendVerifyToEmail() {
    _resetAll();
    sendVerifyEmail();
  }

  onWillPop() {
    if (_timer != null) {
      _timer.cancel();
    }
    SystemNavigator.pop();
  }

  void resendToEmail() async {
    isGettingTime.value = true;
    _isResendVerifyEmail = true;
    await _checkVerifyEmail(isStartTimerWhenNotVerify: false);
    if (!isVerified.value && !isError.value) {
      _resetAll();
      sendVerifyEmail();
    } 
    else {
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

  void tryAgainCheckEmail() {
    if (_isSendingVerify)
      _retrySendVerifyToEmail();
    else if (_isResendVerifyEmail)
      resendToEmail();
    else
      _continueCheckVerify();
  }

  void onCompleteBuild() async {
    if (first.value) {
      await cekWaktuOtp("11");
      // await resendOtp();
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
