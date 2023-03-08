import 'package:get/get.dart';
import 'package:muatmuat/app/modules/pratender/pratender_controller.dart';

class PratenderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<PrivacyAndPolicyController>(
    //   () => PrivacyAndPolicyController(),
    // );
    Get.put(PratenderController());
  }
}
