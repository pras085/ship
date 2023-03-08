import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_controller.dart';

class DetailProsesTenderBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(DetailProsesTenderController());
  }
}
