import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_muatan/ZO_list_muatan_controller.dart';

class ZoListMuatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoListMuatanController>(
      () => ZoListMuatanController(),
    );
    // Get.put(ZoListMuatanController());
  }
}
