import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/notification/notif_controller.dart';

class NotifBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(NotifController());
  }
}
