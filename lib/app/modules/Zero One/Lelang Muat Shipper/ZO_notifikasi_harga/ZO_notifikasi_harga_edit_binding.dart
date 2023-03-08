import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_notifikasi_harga/ZO_notifikasi_harga_edit_controller.dart';

class ZoNotifikasiHargaEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ZoNotifikasiHargaEditController());
  }
}
