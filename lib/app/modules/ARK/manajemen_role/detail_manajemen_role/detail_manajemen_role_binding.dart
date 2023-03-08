import 'package:get/get.dart';

import 'detail_manajemen_role_controller.dart';

class DetailManajemenRoleBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(DetailManajemenRoleController());
  }
}
