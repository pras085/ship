import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/api_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/tac_point_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/terms_and_conditions_response_model.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsSubscriptionController extends GetxController {
  final isAgreeTC = false.obs;
  bool _isFirstTime = true;
  final isLoading = true.obs;
  final isErrorCheck = false.obs;
  bool isSuccess = false;

  final termsConditionData = "".obs;
  final errorMessage = "".obs;
  bool isAlwaysValidate = false;
  var atBottom = false.obs;

  var isButtonClick = false;

  BuildContext _context;

  final listPoint = [].obs;

  @override
  void onInit() {
    _context = Get.context;
    _getDataTermsCondition();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void onAccept(BuildContext context) {
    isAlwaysValidate = true;
    isButtonClick = true;
    if (_isAllChecked()) {
      Get.back(result: true);
      // GetToPage.offNamed<SubscriptionHomeController>(Routes.SUBSCRIPTION_HOME);
    } else {
      isErrorCheck.value = true;
      //_showAlertDialogError('TACLabelErrorCheck'.tr, context);
    }
  }

  void _showAlertDialogError(String message, BuildContext context) {
    GlobalAlertDialog.showDialogError(message: message, context: context);
  }

  Future _getDataTermsCondition() async {
    var responseBody = await ApiSubscription(
            context: _context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchTermCondition(type: 'subscription-bigfleet-shipper');
    if (responseBody != null) {
      TermsAndConditionsResponseModel termsAndConditionsResponseModel =
          TermsAndConditionsResponseModel.fromJson(responseBody);
      if (termsAndConditionsResponseModel.message.code == 200) {
        listPoint.addAll(termsAndConditionsResponseModel.listPoint);
        isSuccess = true;
        isLoading.value = false;
        listPoint.refresh();
      } else {
        //_setError(termsAndConditionsResponseModel.message.text);
      }
    } else {
      //_setError('GlobalLabelErrorNoConnection'.tr);
    }
  }

  void urlLauncher(String url) async {
    if (await canLaunch(url)) {
      //await launch(url);
      Get.toNamed(Routes.WEBVIEW_TAC_PAP, arguments: url);
    }
  }

  void setCheckbox(bool isChecked, int index) {
    listPoint[index].isChecked = isChecked;
    // if (isAlwaysValidate) isErrorCheck.value = !_isAllChecked();
    if (!isErrorCheck.value) {
      isButtonClick = false;
    } else {
      if (isAlwaysValidate) isErrorCheck.value = !_isAllChecked();
    }
    listPoint.refresh();
  }

  _isAllChecked() {
    bool result = true;
    for (int i = 1; i < listPoint.length; i++) {
      TACPointModel model = listPoint[i];
      if (!model.isChecked) {
        result = false;
        break;
      }
    }
    return result;
  }

  onCompleteBuild() {
    if (_isFirstTime) {
      _isFirstTime = false;
      //_getDataTermsCondition();
    }
  }
}
