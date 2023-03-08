import 'package:get/get.dart';

import 'profile_perusahaan_controller.dart';

class OtherSideTransBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtherSideTransController());
  }
}