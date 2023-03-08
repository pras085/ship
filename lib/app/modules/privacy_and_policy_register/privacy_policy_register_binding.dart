import 'package:get/get.dart';
import 'package:muatmuat/app/modules/privacy_and_policy_register/privacy_policy_register_controller.dart';

class PrivacyPolicyRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PrivacyPolicyRegisterController());
  }
}
