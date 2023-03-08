import 'package:get/get.dart';
import 'package:muatmuat/app/modules/verify_email/verify_email_controller.dart';

import 'package:muatmuat/app/modules/verify_phone/verify_phone_controller.dart';

class VerifyPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VerifyPhoneController());
  }
}
