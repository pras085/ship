import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/detail_info_pra_tender/detail_info_pra_tender_controller.dart';

class DetailInfoPraTenderBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(DetailInfoPraTenderController());
  }
}
