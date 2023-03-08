import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_point_model.dart';
import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_response_model.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyAndPolicyController extends GetxController {
  final isAgreeTC = false.obs;
  final isAgreeTC2 = false.obs;
  RegisterUserController _registerUserController = Get.find();

  final privacyAndPolicyData = "".obs;
  final errorMessage = "".obs;
  final isError = false.obs;
  final isSuccess = false.obs;

  BuildContext _context;

  final listPoint = [].obs;

  @override
  void onInit() {
    _context = Get.context;
    _getDataPrivacyPolicy();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void onAccept(BuildContext context) {
    if (_isAllChecked()) {
      // && isAgreeTC2.value
      _registerUserController.registerUser(context);
    } else {
      _showAlertDialogError('PAPLabelErrorCheck'.tr, context);
    }
  }

  void _showAlertDialogError(String message, BuildContext context) {
    GlobalAlertDialog.showAlertDialogCustom(message: message, context: context);
  }

  Future _getDataPrivacyPolicy() async {
    _resetError();
    var responseBody = await ApiHelper(
            context: _context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchPrivacyPolicy();
    if (responseBody != null) {
      PrivacyAndPolicyResponseModel privacyAndPolicyResponseModel =
          PrivacyAndPolicyResponseModel.fromJson(responseBody);
      if (privacyAndPolicyResponseModel.message.code == 200) {
        // privacyAndPolicyData.value = privacyAndPolicyResponseModel.data;
        listPoint.addAll(privacyAndPolicyResponseModel.listPoint);
        isSuccess.value = true;
        listPoint.refresh();
      } else {
        _setError(privacyAndPolicyResponseModel.message.text);
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
      //await launch(url);
      Get.toNamed(Routes.WEBVIEW_TAC_PAP, arguments: url);
    }
  }

  void setCheckbox(bool isChecked, int index) {
    listPoint[index].isChecked = isChecked;
    listPoint.refresh();
  }

  _isAllChecked() {
    bool result = true;
    for (PrivacyAndPolicyPointModel model in listPoint) {
      if (!model.isChecked) {
        result = false;
        break;
      }
    }
    return result;
  }

  // void setContextAndGetDataPrivacyPolicy(BuildContext context) {
  //   if (_context == null) {
  //     _context = context;
  //     _getDataPrivacyPolicy();
  //   }
  // }
}
