import 'package:get/get.dart';
import 'manajemen_user_bagi_peran_controller.dart';

class ManajemenUserBagiPeranBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ManajemenUserBagiPeranController());
  }
}
