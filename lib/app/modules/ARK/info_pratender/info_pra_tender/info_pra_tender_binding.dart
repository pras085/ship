import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/info_pra_tender/info_pra_tender_controller.dart';

class InfoPraTenderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(InfoPraTenderController());
  }
}
