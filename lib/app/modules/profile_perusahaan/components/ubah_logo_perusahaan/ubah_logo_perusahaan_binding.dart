import 'package:get/get.dart';

import 'ubah_foto_perusahaan_controller.dart';

class UbahLogoPerusahaanBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<FormPendaftaranIndividuController>(
    //   () => FormPendaftaranIndividuController(),
    // );
    Get.put(UbahLogoPerusahaanController());
  }
}
