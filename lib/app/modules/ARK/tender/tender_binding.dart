import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/tender/tender_controller.dart';

class TenderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(TenderController());
  }
}
