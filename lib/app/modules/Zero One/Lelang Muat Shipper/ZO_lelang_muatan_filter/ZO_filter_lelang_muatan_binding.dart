import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_lelang_muatan_filter/ZO_filter_lelang_muatan_controller.dart';

class ZoFilterLelangMuatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ZoFilterLelangMuatanController(),
    );
  }
}
