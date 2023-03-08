import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/pemenang_tender/pemenang_tender_controller.dart';

class PemenangTenderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(PemenangTenderController());
  }
}
