import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/edit_notification_harga/edit_notification_harga_controller.dart';

class EditNotificationHargaBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(EditNotificationHargaController());
  }
}
