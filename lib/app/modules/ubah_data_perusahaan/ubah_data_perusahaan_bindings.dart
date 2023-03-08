import 'package:get/get.dart';

import 'package:muatmuat/app/modules/ubah_data_perusahaan/ubah_data_perusahaan_controller.dart';

class UbahDataPerusahaanBinding extends Bindings {
  @override
  void dependencies() {
    
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(UbahDataPerusahaanController());
  }
}
