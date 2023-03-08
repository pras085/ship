import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/api_login_register.dart';
import 'package:muatmuat/app/modules/otp_phone/otp_phone_controller.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_condition_point_model.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_conditions_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyRegisterController extends GetxController {
  final isAgreeTC = false.obs;
  final isAgreeTC2 = false.obs;

  final termsConditionData = "".obs;
  final errorMessage = "".obs;
  final isError = false.obs;
  final isSuccess = false.obs;
  final isOK = false.obs;

  BuildContext _context;

  final listPoint = [].obs;
  final listCheck = [].obs;

  var atBottom = false.obs;

  var userModel = UserModel().obs;
  var loading = false.obs;
  var timeOtp = 0;

  @override
  void onInit() {
    userModel.value = Get.arguments;
    _context = Get.context;
    _getDataTermsCondition();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  doRegisterUser() async {
    loading.value = true;
    MessageFromUrlModel message;

    if (GlobalVariable.isGoogleRegister) {
      var body = {
        "base_data": jsonEncode({
          "ID": GlobalVariable.docID,
          "App": "1",
          "Locale": GlobalVariable.languageType,
          "Email": GlobalVariable.emailLogin,
          "Token": GlobalVariable.tokenApp,
          "Key": "AZthebestsystem"
        }),
        "user_data": jsonEncode({
          "name": userModel.value.name,
          "phone": userModel.value.phone,
          "referral_code": userModel.value.referralCode
        })
      };
      var response = await ApiLoginRegister(context: Get.context, isShowDialogLoading: true).updateNamePhoneRefCode(body);
      message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;

      if (message != null && message.code == 200) {
        GlobalVariable.userModelGlobal = UserModel(
          docID: GlobalVariable.docID,
          email: GlobalVariable.emailLogin,
          isGoogle: true,
          isVerifPhone: false,
          name: userModel.value.name,
          password: "",
          phone: userModel.value.phone,
          code: userModel.value.code,
          referralCode: userModel.value.referralCode
        );
        await SharedPreferencesHelper.setUserLogin(GlobalVariable.userModelGlobal);
        await GetToPage.offAllNamed<OtpPhoneController>(Routes.OTP_PHONE_REGISTER, arguments: GlobalVariable.userModelGlobal);
      } else {
        if (message != null) {
          CustomToastTop.show(message: message.text, context: Get.context, isSuccess: 0);
        } else {
          CustomToastTop.show(message: "Terjadi Kesalahan Server", context: Get.context, isSuccess: 0);
        }
      }
    } else {
      var parameter = {
        "name": userModel.value.name,
        "phone": userModel.value.phone,
        "email": userModel.value.email,
        "password": userModel.value.password,
        "confirm_password": userModel.value.password,
        "referral_code": userModel.value.referralCode
      };

      var body = {"user_data": jsonEncode(parameter)};
      var response = await ApiLoginRegister(context: Get.context, isShowDialogLoading: true).doRegisterUser(body);
      message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;

      if (message != null && message.code == 200) {
        GlobalVariable.userModelGlobal = UserModel(
          docID: (response["Data"]["Session"]["Code"]).toString(),
          email: response["Data"]["Session"]["Email"],
          isGoogle: response["Data"]["Session"]["IsGoogle"] == 1,
          isVerifPhone: response["Data"]["Session"]["IsVerifPhone"] == 1,
          name: response["Data"]["Session"]["Name"],
          password: "",
          phone: response["Data"]["Session"]["Phone"],
          code: response["Data"]["Code"].toString(),
          referralCode: response["Data"]["RefCode"].toString()
        );
        GlobalVariable.tokenApp = response["Data"]["Session"]["Token"];
        await SharedPreferencesHelper.setUserLogin(GlobalVariable.userModelGlobal);
        await GetToPage.offAllNamed<OtpPhoneController>(Routes.OTP_PHONE_REGISTER, arguments: GlobalVariable.userModelGlobal);
      } else {
        if (message != null) {
          CustomToastTop.show(message: message.text, context: Get.context, isSuccess: 0);
        } else {
          CustomToastTop.show(message: "Terjadi Kesalahan Server", context: Get.context, isSuccess: 0);
        }
      }
    }
    
    loading.value = false;
  }

  void onAccept(BuildContext context) {
    if (_isAllChecked()) {
      Get.toNamed(Routes.PRIVACY_AND_POLICY, arguments: Get.arguments);
    } else {
      _showAlertDialogError('TACLabelErrorCheck'.tr, context);
    }
  }

  void _showAlertDialogError(String message, BuildContext context) {
    GlobalAlertDialog.showDialogError(message: message, context: context);
  }

  Future _getDataTermsCondition() async {
    _resetError();

    var responseBody = await ApiHelper(
      context: _context,
      isShowDialogLoading: false,
      isShowDialogError: false
    ).fetchPrivacyPolicy();

    if (responseBody != null) {
      TermsAndConditionsResponseModel termsAndConditionsResponseModel = TermsAndConditionsResponseModel.fromJson(responseBody);
      if (termsAndConditionsResponseModel.message.code == 200) {
        listPoint.addAll(termsAndConditionsResponseModel.listPoint);
        isSuccess.value = true;
        listPoint.refresh();
        for (int i = 0; i < listPoint.length; i++) {
          listCheck.add(false);
        }
      } else {
        _setError(termsAndConditionsResponseModel.message.text);
      }
    } else {
      _setError('GlobalLabelErrorNoConnection'.tr);
    }
  }

  void _resetError() {
    isError.value = false;
    errorMessage.value = "";
  }

  void _setError(String errorMessage) {
    isError.value = true;
    this.errorMessage.value = errorMessage;
  }

  void urlLauncher(String url) async {
    if (await canLaunch(url)) {
      Get.toNamed(Routes.WEBVIEW_TAC_PAP, arguments: url);
    }
  }

  void setCheckbox(bool isChecked, int index) {
    listPoint[index].isChecked = isChecked;
    listPoint.refresh();
  }

  isAllCheck() {
    bool result = true;
    for (int i = 0; i < listCheck.length; i++) {
      if (i != 0) {
        if (!listCheck[i]) {
          result = false;
        }
      }
    }
    return result;
  }

  _isAllChecked() {
    bool result = true;
    for (TermsAndConditionsPointModel model in listPoint) {
      if (!model.isChecked) {
        result = false;
        break;
      }
    }
    return result;
  }
}
