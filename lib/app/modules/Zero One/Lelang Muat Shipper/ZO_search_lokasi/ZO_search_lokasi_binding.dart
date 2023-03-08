import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_search_lokasi/ZO_search_lokasi_controller.dart';

class ZoSearchLokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoSearchLokasiController>(
      () => ZoSearchLokasiController(),
    );
  }
}
