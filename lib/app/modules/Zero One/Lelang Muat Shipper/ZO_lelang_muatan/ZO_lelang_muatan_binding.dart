import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_lelang_muatan/ZO_lelang_muatan_controller.dart';

class ZoLelangMuatanBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );/
    Get.put(ZoLelangMuatanController());
  }
}
