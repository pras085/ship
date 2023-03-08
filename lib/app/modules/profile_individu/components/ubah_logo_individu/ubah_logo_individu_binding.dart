import 'package:get/get.dart';

import 'ubah_foto_individu_controller.dart';


class UbahLogoIndividuBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<FormPendaftaranIndividuController>(
    //   () => FormPendaftaranIndividuController(),
    // );
    Get.put(UbahLogoIndividuController());
  }
}
