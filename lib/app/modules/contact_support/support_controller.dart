import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class SupportController extends GetxController {
  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

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
