import 'package:get/get.dart';

import 'ubah_kelengkapan_legalitas_controller.dart';

class UbahKelengkapanLegalitasBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UbahKelengkapanLegalitasController());
  }
}