import 'package:flutter/material.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/utils/device_info.dart';
import 'package:muatmuat/global_variable.dart';

class ApiLoginRegister {
  final BuildContext context;
  final bool isShowDialogLoading;
  final bool isShowDialogError;
  final bool isDebugGetResponse;

  ApiHelper _apiHelper;

  ApiLoginRegister(
      {@required this.context,
      this.isShowDialogLoading = true,
      this.isShowDialogError = true,
      this.isDebugGetResponse = false}) {
    _apiHelper = ApiHelper(
      context: context,
      isShowDialogLoading: isShowDialogLoading,
      isShowDialogError: isShowDialogError,
      isDebugGetResponse: isDebugGetResponse,
    );
  }

  Future doLoginUser(Map<String, dynamic> body) async {
    var device = await DeviceInfo.getPhoneInfo();
    body["DeviceName"] = "${device['brand']} ${device['model']}";
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/do_login_user", body);
  }

  Future doRegisterUser(Map<String, dynamic> body) async {
    body["Locale"] = GlobalVariable.languageType;
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/do_register_user", body);
  }

  Future doRegisterUserSellerIndividu(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/do_register_users_seller_individual",
        body);
  }

  Future doValidateRegisterFields(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
        ApiHelper.urlInternal + "api/do_validate_register_fields", body);
  }

  Future doValidateNamePhoneRefCode(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/do_validate_name_phone_ref_code", body);
  }

  Future forgotPassword(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/forgot_password", body);
  }

  Future resetPassword(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/reset_password", body);
  }

  Future getTimerSetting(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/get_timer_setting", body);
  }

  Future getTimerSettingEmail(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/get_timer_setting_email", body);
  }

  Future verifyOtp(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/verify_otp", body);
  }

  Future verifyForgetAccountOtp(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/verify_forget_account_otp", body);
  }

  Future resendOtpRegister(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/resend_otp_register", body);
  }

  Future doChangePhoneAtRegister(Map<String, dynamic> body) async {
    body["Locale"] = GlobalVariable.languageType;
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/do_change_phone_at_register", body);
  }

  Future checkStatusAccount(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/check_status_account", body);
  }

  // Future registerByGoogle(Map<String, dynamic> body) async {
  //   return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //       ApiHelper.urlInternal + "login/register_by_google", body);
  // }

  Future registerByGoogle(Map<String, dynamic> body) async {
    var device = await DeviceInfo.getPhoneInfo();
    body["DeviceName"] = "${device['brand']} ${device['model']}";
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(ApiHelper.urlInternal + "login/register_by_google_app", body);
  }

  Future updateNamePhoneRefCode(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
      ApiHelper.urlInternal + "backend/update_name_phone_ref_code", 
      body
    );
  }
}
