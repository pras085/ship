import 'package:get/get.dart';

import 'ubah_foto_profil_controller.dart';

class UbahFotoProfilBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<FormPendaftaranIndividuController>(
    //   () => FormPendaftaranIndividuController(),
    // );
    Get.put(UbahFotoProfilController());
  }
}
