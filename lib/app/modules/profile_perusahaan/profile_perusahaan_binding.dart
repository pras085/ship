import 'package:get/get.dart';

import 'profile_perusahaan_controller.dart';

class ProfilePerusahaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfilePerusahaanController());
  }
}