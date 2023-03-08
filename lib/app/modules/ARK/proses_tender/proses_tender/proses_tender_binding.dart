import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/proses_tender/proses_tender_controller.dart';

class ProsesTenderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ProsesTenderController());
  }
}
