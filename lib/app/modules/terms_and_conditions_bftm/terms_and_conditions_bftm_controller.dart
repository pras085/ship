import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/otp_email_bftm/otp_email_controller_bftm.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_condition_point_model.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_conditions_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsBFTMController extends GetxController {
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
  
  var tipeModul = TipeModul.BF.obs;

  RegisterShipperBfTmController registerShipperBfTmController;

  var _isShowingDialogLoading = false;

  @override
  void onInit() {
    super.onInit();
    _context = Get.context;

    tipeModul.value = Get.arguments;
    registerShipperBfTmController = Get.find<RegisterShipperBfTmController>();

    _getDataTermsCondition();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future checkEmail() async {
    MessageFromUrlModel message;
    _showDialogLoading();
    final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).getEmailStatus();
    message = response['Message'] != null ? MessageFromUrlModel.fromJson(response['Message']) : null;
    if (message != null && message.code == 200) {
      if (response != null && response['Data'] != null) {
        if (response['Data']['Email'] != GlobalVariable.userModelGlobal.email) {
          _closeDialogLoading();
          GlobalAlertDialog.showAlertDialogCustom(
            title: 'BFTMRegisterAllPerubahanData'.tr, 
            message: 'BFTMRegisterAllPerubahanDataPendaftaran'.tr,
            context: Get.context,
            labelButtonPriority1: 'BFTMRegisterAllKembaliKePendaftaran'.tr,
            heightButton1: 31,
            widthButton1: 203,
            positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
            onTapPriority1: () {
              registerShipperBfTmController.pageIndex.value = 2;
              registerShipperBfTmController.changePageIndex(registerShipperBfTmController.pageIndex.value);
              Get.back();
              registerShipperBfTmController.emailCtrl.value.text = response['Data']['Email'];
              registerShipperBfTmController.isEditable.value = response['Data']['IsVerifEmail'] == 0;   
              GlobalVariable.userModelGlobal.email = response['Data']['Email'];
              registerShipperBfTmController.isverif.value = response['Data']['IsVerifEmail'].toString();            
            }
          );
        } else {
          final result = await registerShipperBfTmController.setCompanyData();
          if (result['Message']['Code'] == 200) {
            GlobalVariable.userModelGlobal.email = registerShipperBfTmController.email.value;
            await registerShipperBfTmController.setCapacityValidation();
            await registerShipperBfTmController.setLegality();
            await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false).registerShipper(tipeModul: tipeModul.value);
            if (response['Data']['IsVerifEmail'] == 1) {
              // EMAIL SAMA & SUDAH TERVALIDASI
              _closeDialogLoading();
              Get.offAllNamed(Routes.SUCCESS_REGISTER_BFTM);
            } else {
              // EMAIL SAMA & BELUM TERVALIDASI
              _closeDialogLoading();
              GetToPage.toNamed<OtpEmailBFTMController>(Routes.OTP_EMAIL, arguments: tipeModul.value);
            }
          } else {
            _closeDialogLoading();
            registerShipperBfTmController.pageIndex.value = 2;
            registerShipperBfTmController.changePageIndex(registerShipperBfTmController.pageIndex.value);
            Get.back(result: result['Data']['Message']);
            registerShipperBfTmController.emailCtrl.value.text = response['Data']['Email'];
            registerShipperBfTmController.isEditable.value = response['Data']['IsVerifEmail'] == 0;   
            GlobalVariable.userModelGlobal.email = response['Data']['Email'];
            registerShipperBfTmController.isverif.value = response['Data']['IsVerifEmail'].toString();
          }
        }
      } else {
        CustomToastTop.show(message: message != null ? message.text : "Terjadi Kesalahan Server", context: Get.context, isSuccess: 0);
      }
    }
  }

  void _closeDialogLoading() {
    try {
      if (_isShowingDialogLoading) {
        _isShowingDialogLoading = false;
        Get.back();
      }
    } catch (err) {}
  }

  Future _showDialogLoading() async {
    _isShowingDialogLoading = true;
    return showDialog(
      context: Get.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            backgroundColor: Colors.black54,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    CustomText('GlobalLabelDialogLoading'.tr, color: Colors.blueAccent)
                  ]
                ),
              )
            ]
          )
        );
      }
    );
  }

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
    ).fetchTermCondition(type: tipeModul.value == TipeModul.BF ? "register_bf" : "register_tm");

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
