import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/google_sign_in_function.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class LoginController extends GetxController {
  //UserController _userController = Get.put(UserController());
  GoogleSignInFunction _googleSignInFunction = GoogleSignInFunction();
  final isFromIntro2 = false.obs;
  final isShowPassword = false.obs;

  final formKey = GlobalKey<FormState>().obs;
  final useremailph = GlobalKey().obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // cek validasi di view
  var isValid = true.obs;
  var isFilled = false.obs;
  var inputtype = false.obs;

  var typeLogin = 1;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setIsShowPassword(bool value) {
    isShowPassword.value = value;
  }

  signInWithGoogle(BuildContext context) {
    _googleSignInFunction.signInWithGoogle(false, context);
    //_googleSignInUserController.signInWithGoogle(false, context);
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
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      "Please Wait....",
                      color: Colors.blueAccent,
                    )
                  ]),
                )
              ],
            ),
          );
        });
  }

  void togglePassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  bool checkRegex() {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(emailController.text);
    // bool phoneValid = RegExp(r"^(?:[62|0]8)?[1-9][0-9]{8,12}$").hasMatch(emailController.text);
    bool phoneValid = RegExp(r"^[0-9]{8,14}$").hasMatch(emailController.text);
    bool numberValid = RegExp(r'^[0-9]+$').hasMatch(emailController.text);

    // bool emailValid = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(emailController.text);

    if (emailValid || phoneValid) {
      if (numberValid) {
        if (phoneValid) {
          typeLogin = 2;
          inputtype.value = false;
        }
      } else {
        if (emailValid) {
          typeLogin = 1;
          inputtype.value = true;
        }
      }
      return true;
    } else {
      // CEK DULU APAKAH ANGKA
      if (numberValid) {
        if (!phoneValid) {
          typeLogin = 2;
          inputtype.value = false;
        }
      } else {
        if (!emailValid) {
          typeLogin = 1;
          inputtype.value = true;
        }
      }
      
      return false;
    }
  }
}
