import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/google_sign_in_function.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class RegisterController extends GetxController {
  GoogleSignInFunction _googleSignInFunction = GoogleSignInFunction();
  final isShowPassword = false.obs;
  final isShowConfirmPassword = false.obs;

  final formKey = GlobalKey<FormState>().obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  // cek validasi di view
  var isValid = true.obs;
  var isValidPhone = true.obs;
  var isValidEmail = true.obs;
  var isValidPassword = true.obs;
  var isValidReferral = true.obs;
  var isFilled = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

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

  void togglePassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void toggleConfirmPassword() {
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
  }
}
