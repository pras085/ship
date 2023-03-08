import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_notifikasi_shipper/ZO_list_notifikasi_controller.dart';

class ZoListNotifikasiShipperBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );/
    Get.put(ZoListNotifikasiShipperController());
  }
}
