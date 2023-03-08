import 'package:get/get.dart';

import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_controller.dart';

class LokasiTrukSiapMuatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LokasiTrukSiapMuatController());
  }
}
