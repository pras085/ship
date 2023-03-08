import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/network/api_helper.dart' as apiInternal;

class NotifChatController extends GetxController {
  var newNotif = false.obs;
  var jumlahnotif = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> getInit() async {
    await getNotif();
  }

  Future getNotif() async {
    var result = await apiInternal.ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListNotifAll();
    log(result.toString());
    log(result['SupportingData']['NotReadCount'].toString() + 'habib');
    if (result['Message']['Code'].toString() == '200') {
      newNotif.value = result['SupportingData']['NotReadCount'] > 0;
      jumlahnotif.value = result['SupportingData']['NotReadCount'];
    }
  }

  sendSupport(String title, String message) {
    showDialog(
        context: Get.context,
        builder: (context) {
          return AlertDialog(
            content: CustomText(
                'Your report has been sent and will be processed for approximately 7 days.'),
            actions: [
              MaterialButton(
                onPressed: () {
                  var count = 0;
                  Navigator.popUntil(context, (route) {
                    return count++ == 2;
                  });
                },
                child: CustomText('OK'),
              )
            ],
          );
        });
  }
}
