import 'package:get/get.dart';

import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/lokasi_data_perusahaan/lokasi_ubah_data_controller.dart';

class LokasiUbahDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LokasiUbahDataController());
  }
}
