import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_lelang/ZO_pilih_pemenang_lelang_controller.dart';

class ZoPilihPemenangLelangBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );/
    Get.put(ZoPilihPemenangLelangController());
  }
}
