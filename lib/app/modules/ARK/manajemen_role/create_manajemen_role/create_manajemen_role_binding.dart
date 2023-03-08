import 'package:get/get.dart';

import 'create_manajemen_role_controller.dart';

class CreateManajemenRoleBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(CreateManajemenRoleController());
  }
}
