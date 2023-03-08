import 'package:get/get.dart';

import 'detail_manajemen_lokasi_controller.dart';

class DetailManajemenLokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailManajemenLokasiController());
  }
}
