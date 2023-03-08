import 'package:get/get.dart';

import 'manajemen_user_controller.dart';

class ManajemenUserBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ManajemenUserController());
  }
}
