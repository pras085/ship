import 'package:get/get.dart';

class ResetPasswordSuccessController extends GetxController {
  final email = "".obs;
  @override
  void onInit() {
    email.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
