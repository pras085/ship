import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/check_after_register_login_go_to_home_function.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/google_sign_in_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/login/login_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';

class LoginFunction {
  bool isSuccess = false;
  GoogleSignInFunction _googleSignInFunction = GoogleSignInFunction();
  LoginResponseModel _loginResponse;
  UserModel userModel = UserModel();
  String messageError = "";

  Future loginUser(UserModel user, bool isGoogle, BuildContext context,
      bool isShowDialogLoading) async {
    messageError = "";
    isSuccess = false;
    try {
      var responseBody = await ApiHelper(
              context: context,
              isShowDialogLoading: isShowDialogLoading,
              isShowDialogError: false,
              isDebugGetResponse: true)
          .fetchLogin(user, isGoogle);
      _loginResponse = LoginResponseModel.fromJson(responseBody);

      if (_loginResponse.message.code == 200) {
        isSuccess = true;
        user.isGoogle = isGoogle;
        GlobalVariable.tokenApp = _loginResponse.tokenApp;
        userModel = _loginResponse.data;
        userModel.isGoogle = isGoogle;
        userModel.password = user.password;
      } else {
        isSuccess = false;
        messageError = _loginResponse.dataMessageError == ""
            ? 'LoginLabelErrorLogin'.tr
            : _loginResponse.dataMessageError;
      }
    } catch (err) {
      messageError = 'LoginLabelErrorLogin'.tr;
    }
  }

  signOut2() async {
    try {
      if (GlobalVariable.isGoogleLogin) {
        if (GlobalVariable.user != null) {
          await FirebaseAuth.instance.signOut();
          await GlobalVariable.googleSignIn.signOut();
        }
      }
    } catch (err) {}

    SharedPreferencesHelper.setLogOut();
    Get.offAllNamed(Routes.BEFORE_LOGIN_USER);
  }

  signOut() async {
    try {
      if (GlobalVariable.isGoogleLogin) {
        await _googleSignInFunction.signOut();
      }
    } catch (err) {}

    SharedPreferencesHelper.setLogOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  saveDataUserGotoHome(UserModel user) {
    saveDataUser(user);
    CheckAfterRegisterLoginGoToHome.checkGoToHome();
  }

  saveDataUser(UserModel user) {
    SharedPreferencesHelper.setUserLogin(user);
  }

  Future loginUserWithSavedDataAndMessage(
      UserModel user, bool isGoogle, bool isShowDialogLoading) async {
    await loginUser(user, isGoogle, Get.context, isShowDialogLoading);
    if (isSuccess)
      saveDataUser(userModel);
    else {
      GlobalAlertDialog.showDialogError(
          message: messageError,
          context: Get.context,
          onTapPriority1: () {
            Get.back();
            loginUserWithSavedDataAndMessage(
                user, isGoogle, isShowDialogLoading);
          },
          labelButtonPriority1: "LoginLabelButtonTryAgain".tr,
          onTapPriority2: () {
            Get.offAllNamed(Routes.LOGIN);
          },
          labelButtonPriority2: "LoginLabelButtonCancel".tr);
    }
  }
}
