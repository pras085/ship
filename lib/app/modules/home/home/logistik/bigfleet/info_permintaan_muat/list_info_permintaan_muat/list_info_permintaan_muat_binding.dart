import 'package:get/get.dart';

import 'list_info_permintaan_muat_controller.dart';

class ListInfoPermintaanMuatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListInfoPermintaanMuatController());
  }
}
