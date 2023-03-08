import 'package:get/get.dart';

import 'manajemen_hak_akses_controller.dart';

class ManajemenHakAksesBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ManajemenHakAksesController());
  }
}
