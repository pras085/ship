import 'package:get/get.dart';

import 'create_notification_harga_controller.dart';

class CreateNotificationHargaBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(CreateNotificationHargaController());
  }
}
