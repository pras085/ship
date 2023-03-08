import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class BahasaPlaceholderController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) => onCompleteBuildWidget());
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void onCompleteBuildWidget() async {
    await Future.delayed(Duration(milliseconds: 500));
    Get.offAllNamed(Routes.AFTER_LOGIN_SUBUSER);
  }
}
