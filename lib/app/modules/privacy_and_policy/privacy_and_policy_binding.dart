import 'package:get/get.dart';

import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_controller.dart';

class PrivacyAndPolicyBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<PrivacyAndPolicyController>(
    //   () => PrivacyAndPolicyController(),
    // );
    Get.put(PrivacyAndPolicyController());
  }
}
