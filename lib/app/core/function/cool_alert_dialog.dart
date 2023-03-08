import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoolAlertDialog {
  static void showAlertDialogError(
      {String message, BuildContext context, Function function}) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'GlobalLabelError'.tr,
        text: message,
        barrierDismissible: false,
        confirmBtnText: 'GlobalButtonOK'.tr,
        onConfirmBtnTap: () {
          Get.back();
          if (function != null) {
            function();
          }
        });
  }

  static void showAlertDialogSuccess(String message, BuildContext context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: 'GlobalLabelSuccess'.tr,
        text: message,
        barrierDismissible: false,
        confirmBtnText: 'GlobalButtonOK'.tr,
        onConfirmBtnTap: () {
          Get.back();
        });
  }

  static void showAlertDialogSuccessNotDissmiss(
      String message, Function functionConfirmBtn) {
    CoolAlert.show(
        context: Get.context,
        type: CoolAlertType.success,
        title: 'GlobalLabelSuccess'.tr,
        text: message,
        barrierDismissible: false,
        confirmBtnText: 'GlobalButtonOK'.tr,
        onConfirmBtnTap: () {
          Get.back();
          if (functionConfirmBtn != null) {
            functionConfirmBtn();
          }
        });
  }

  static void showAlertDialogConfirmButton(String message, String confirmText,
      String cancelText, Function functionConfirmBtn,
      {Function functionCancelBtn}) {
    CoolAlert.show(
        context: Get.context,
        type: CoolAlertType.confirm,
        title: 'Information',
        text: message,
        barrierDismissible: false,
        confirmBtnText: confirmText,
        onConfirmBtnTap: () {
          Get.back();
          if (functionConfirmBtn != null) {
            functionConfirmBtn();
          }
        },
        showCancelBtn: true,
        cancelBtnText: cancelText,
        onCancelBtnTap: () {
          Get.back();
          if (functionCancelBtn != null) {
            functionCancelBtn();
          }
        });
  }

  static void showAlertDialogErrorCustomButton(
      {String message,
      BuildContext context,
      Function functionConfirmBtn,
      String confirmBtnText,
      Function functionCancelBtn,
      String cancelBtnText}) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'GlobalLabelError'.tr,
        text: message,
        barrierDismissible: false,
        confirmBtnText: confirmBtnText,
        onConfirmBtnTap: () {
          Get.back();
          if (functionConfirmBtn != null) {
            functionConfirmBtn();
          }
        },
        showCancelBtn: true,
        cancelBtnText: cancelBtnText,
        onCancelBtnTap: () {
          Get.back();
          if (functionCancelBtn != null) {
            functionCancelBtn();
          }
        });
  }
}
