import 'package:get/get.dart';

class ErrorRegisterEmailStillVerifyController extends GetxController {
  String email;
  @override
  void onInit() {
    email = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void reRegister() {
    Get.back(result: {
      'reset': true,
    });
  }
}
