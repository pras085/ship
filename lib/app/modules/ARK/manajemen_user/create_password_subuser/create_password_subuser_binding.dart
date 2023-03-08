import 'package:get/get.dart';
import 'create_password_subuser_controller.dart';

class CreatePasswordSubUserBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(CreatePasswordSubUserController());
  }
}
