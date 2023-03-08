import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/reset_password/reset_password_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  final isSuccess = false.obs;

  final formKey = GlobalKey<FormState>().obs;

  final emailController = TextEditingController().obs;

  final isCheckValidateOnChange = false.obs;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future resetPassword(String email, BuildContext context) async {
    var reponseBody =
        await ApiHelper(context: context, isShowDialogLoading: true)
            .fetchResetPassword(email);
    ResetPasswordResponseModel resetPasswordResponse =
        ResetPasswordResponseModel.fromJson(reponseBody);
    if (resetPasswordResponse.message.code == 200) {
      //isSuccess.value = true;
      Get.offNamed(Routes.RESET_PASSWORD_SUCCESS, arguments: email);
    } else {
      isSuccess.value = false;
      showAlertDialogError(resetPasswordResponse.data, context);
    }
  }

  void showAlertDialogError(String message, BuildContext context) {
    GlobalAlertDialog.showDialogError(message: message, context: context);
  }

  void onResetButton() {
    if (!isCheckValidateOnChange.value) isCheckValidateOnChange.value = true;
    if (validateForm()) {
      resetPassword(emailController.value.text, Get.context);
    }
  }

  bool validateForm() {
    return formKey.value.currentState.validate();
  }
}
