import 'package:get/get.dart';
import 'package:muatmuat/app/modules/contact_support/support_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(SupportController());

  }
}