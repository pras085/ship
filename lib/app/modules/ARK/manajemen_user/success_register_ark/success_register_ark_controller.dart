import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/google_sign_in_function.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

class SuccessRegisterARKController extends GetxController {
  //UserController _userController = Get.put(UserController());
  GoogleSignInFunction _googleSignInFunction = GoogleSignInFunction();
  final isFromIntro2 = false.obs;
  final isShowPassword = false.obs;

  final formKey = GlobalKey<FormState>().obs;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  var referralCode = "".obs;

  static const String _chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  Random _rnd = Random();

  @override
  void onInit() async {
    referralCode.value = Get.arguments;
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future loginUser(UserModel user, BuildContext context) async {
    LoginFunction loginFunction = LoginFunction();
    await loginFunction.loginUser(user, false, context, true);
    if (loginFunction.isSuccess) {
      user = loginFunction.userModel;
      if (loginFunction.userModel.isVerifPhone) {
        loginFunction.saveDataUserGotoHome(user);
      } else {
        Get.offAllNamed(Routes.VERIFY_PHONE, arguments: user);
      }
    } else {
      GlobalAlertDialog.showDialogError(
          message: loginFunction.messageError, context: context);
    }
  }

  void setIsShowPassword(bool value) {
    isShowPassword.value = value;
  }

  signInWithGoogle(BuildContext context) {
    _googleSignInFunction.signInWithGoogle(false, context);
  }

  void getToRegister() {
    Get.offNamed(Routes.REGISTER_USER);
  }

  Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        CustomText(
                          "Please Wait....",
                          color: Colors.blueAccent,
                        )
                      ]),
                    )
                  ]));
        });
  }
}
