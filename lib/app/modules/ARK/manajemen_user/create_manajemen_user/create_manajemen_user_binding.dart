import 'package:get/get.dart';
import 'create_manajemen_user_controller.dart';

class CreateManajemenUserBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(CreateManajemenUserController());
  }
}
