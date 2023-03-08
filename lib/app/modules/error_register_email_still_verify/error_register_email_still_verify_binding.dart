import 'package:get/get.dart';

import 'error_register_email_still_verify_controller.dart';

class ErrorRegisterEmailStillVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ErrorRegisterEmailStillVerifyController());
  }
}
