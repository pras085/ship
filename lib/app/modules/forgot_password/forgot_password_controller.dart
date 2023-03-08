import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/google_sign_in_function.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class ForgotPasswordController extends GetxController {
  //UserController _userController = Get.put(UserController());
  GoogleSignInFunction _googleSignInFunction = GoogleSignInFunction();
  final isFromIntro2 = false.obs;
  final isShowPassword = false.obs;

  final formKey = GlobalKey<FormState>().obs;

  TextEditingController phoneController = TextEditingController();

  // cek validasi di view
  var isValid = true.obs;
  var isFilled = false.obs;

  @override
  void onInit() {
    super.onInit();
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
                  ]));
        });
  }

  bool checkRegex(){
    // bool phoneValid = RegExp(r"^(?:[62|0]8)?[1-9][0-9]{8,12}$").hasMatch(phoneController.text);
    bool phoneValid = RegExp(r"^[0-9]{8,14}$").hasMatch(phoneController.text);

    if(phoneValid) return true;
    
    return false;
  }
}
