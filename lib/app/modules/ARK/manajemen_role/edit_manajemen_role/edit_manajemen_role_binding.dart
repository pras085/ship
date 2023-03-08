import 'package:get/get.dart';

import 'edit_manajemen_role_controller.dart';

class EditManajemenRoleBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(EditManajemenRoleController());
  }
}
