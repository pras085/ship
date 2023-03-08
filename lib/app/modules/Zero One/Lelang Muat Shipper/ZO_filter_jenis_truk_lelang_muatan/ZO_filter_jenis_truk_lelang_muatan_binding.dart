import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_jenis_truk_lelang_muatan/ZO_filter_jenis_truk_lelang_muatan_controller.dart';

class ZoFilterJenisTrukLelangMuatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoFilterJenisTrukLelangMuatanController>(
      () => ZoFilterJenisTrukLelangMuatanController(),
    );
  }
}
