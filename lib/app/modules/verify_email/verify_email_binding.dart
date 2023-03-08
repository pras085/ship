import 'package:get/get.dart';

import 'package:muatmuat/app/modules/verify_email/verify_email_controller.dart';

class VerifyEmailBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<VerifyEmailController>(
    //   () => VerifyEmailController(),
    // );
    Get.put(VerifyEmailController());
  }
}
