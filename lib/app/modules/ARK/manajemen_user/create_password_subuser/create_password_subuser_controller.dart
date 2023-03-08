import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/otp_phone_ark/otp_phone_ark_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'dart:convert';

class CreatePasswordSubUserController extends GetxController {
  var loading = true.obs;
  var isEdit = false.obs;
  String id = "";
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var validasiSimpan = true;
  var validasiPassword = "".obs;
  var validasiEmail = "".obs;
  var validasiPhone = "".obs;
  var isFilledAll = false.obs;
  var formKey = GlobalKey<FormState>().obs;
  var isValid = true.obs;

  final isShowPassword = false.obs;
  final isShowConfirmPassword = false.obs;

  final isSuccess = false.obs;

  final isCheckValidateOnChange = false.obs;

  var mapdata = {};
  @override
  void onInit() async {
    mapdata = Get.arguments[0] ?? {};
    print(mapdata);
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void checkFilledAll() {
    if (passwordController.value.text == "" ||
        confirmPasswordController.value.text == "") {
      isFilledAll.value = false;
    } else {
      isFilledAll.value = true;
    }
  }

  void togglePassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void toggleConfirmPassword() {
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
  }

  void onSubmit() async {
    // var data = await GetToPage.toNamed<VerifyOTPPhoneController>(
    //     Routes.VERIFY_OTP_PHONE,
    //     arguments: ["08385632456", ""]);

    // if (data != null) {
    //   // Get.back();
    // }
    // showDialog(
    //     context: Get.context,
    //     barrierDismissible: true,
    //     builder: (BuildContext context) {
    //       return WillPopScope(
    //           onWillPop: () {},
    //           child: Center(child: CircularProgressIndicator()));
    //     });
    bool valid = true;
    if (passwordController.value.text != confirmPasswordController.value.text) {
      validasiPassword.value = "ManajemenUserBuatPasswordPasswordTidakSama".tr;
      valid = false;
      CustomToastTop.show(
        context: Get.context,
        message: validasiPassword.value,
        isSuccess: 0,
      );
    } else {
      validasiPassword.value = "";
    }

    if (valid) {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String encodedPassword =
          stringToBase64.encode(passwordController.value.text);
      String encodedConfirmPassword =
          stringToBase64.encode(confirmPasswordController.value.text);
      var result = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .createNewPasswordSubUser(
              mapdata["token"], encodedPassword, encodedConfirmPassword);

      if (result != null && result['Message']['Code'].toString() == '200') {
        print("BERHASIL SIMPAN");
        print(result);
        var dataResult = result['Data'];
        var data = await GetToPage.toNamed<OtpPhoneARKController>(
            Routes.OTP_PHONE_ARK,
            arguments: [dataResult['Phone'], dataResult['Token']]);

        if (data != null) {
          Get.back();
        }
      } else if (result != null &&
          result['Message']['Code'].toString() == '500') {
        var dataResponse = result['Data'] ?? {};
        print("GAGAL SIMPAN");
        print(result);
        if (dataResponse['Message'] != null) {
          validasiPassword.value = dataResponse["Message"] ?? "";
          valid = false;
          CustomToastTop.show(
            context: Get.context,
            message: validasiPassword.value,
            isSuccess: 0,
          );
        }
        // if (dataResponse['phone'] != null) {
        //   validasiPhone.value = dataResponse["phone"] ?? "";
        //   valid = false;
        // } else {
        //   validasiPhone.value = "";
        // }
        // Get.back();
      }
    } else {
      // Get.back();
    }
    isValid.value = false;
    formKey.value.currentState.validate();
  }

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
    // if (!isCheckValidateOnChange.value) isCheckValidateOnChange.value = true;
    // if (validateForm()) {
    //   resetPassword(emailController.value.text, Get.context);
    // }
    // UserModel user;
    // Get.offAllNamed(Routes.VERIFY_PHONE, arguments: user);
  }

  bool validateForm() {
    return formKey.value.currentState.validate();
  }
}

class ResetPasswordResponseModel {
  MessageFromUrlModel message;
  String data;

  ResetPasswordResponseModel({this.message});

  ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    data = json['Data'];
  }
}
