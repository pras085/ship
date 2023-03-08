import 'package:get/get.dart';

import 'package:muatmuat/app/modules/reset_password/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ResetPasswordController>(
    //   () => ResetPasswordController(),
    // );
    Get.put(ResetPasswordController());
  }
}
