import 'package:get/get.dart';

import 'lihat_dokumen_persyaratan_controller.dart';

class LihatDokumenPersyaratanBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(LihatDokumenPersyaratanController());
  }
}
