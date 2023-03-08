import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/detail_permintaan_muat/detail_permintaan_muat_controller.dart';

class DetailPermintaanMuatBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(DetailPermintaanMuatController());
  }
}
