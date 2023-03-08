import 'package:get/get.dart';

import 'reset_password_success_controller.dart';

class ResetPasswordSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordSuccessController());
  }
}
