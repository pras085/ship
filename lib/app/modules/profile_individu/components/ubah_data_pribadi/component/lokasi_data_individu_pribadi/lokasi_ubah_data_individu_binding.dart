import 'package:get/get.dart';

import 'lokasi_ubah_data_individu_controller.dart';

class LokasiUbahDataIndividuPribadiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LokasiUbahDataIndividuPribadiController());
  }
}
