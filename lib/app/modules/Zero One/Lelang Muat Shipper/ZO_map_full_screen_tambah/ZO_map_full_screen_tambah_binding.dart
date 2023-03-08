import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_full_screen_tambah/ZO_map_full_screen_tambah_controller.dart';

class ZoMapFullScreenTambahBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );/
    Get.put(ZoMapFullScreenTambahController());
  }
}
