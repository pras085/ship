import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/Zo_search_lelang_muatan_list/Zo_search_lelang_muatan_list_controller.dart';

class ZoSearchLelangMuatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ZoSearchLelangMuatanController(),
    );
  }
}
