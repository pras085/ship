import 'package:get/get.dart';

import 'tentang_perusahaan_controller.dart';

class TentangPerusahaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TentangPerusahaanController());
  }
}
