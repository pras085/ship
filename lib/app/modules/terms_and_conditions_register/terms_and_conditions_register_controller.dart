import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_condition_point_model.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_conditions_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsRegisterController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    userModel.value = Get.arguments;
    _context = Get.context;
    _getDataTermsCondition();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void onAccept(BuildContext context) {
    if (_isAllChecked()) {
      Get.toNamed(Routes.PRIVACY_AND_POLICY_REGISTER, arguments: Get.arguments);
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
    ).fetchTermCondition();

    print("Response body s&k ${responseBody['Data']}");
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
