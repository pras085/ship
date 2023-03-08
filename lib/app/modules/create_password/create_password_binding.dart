import 'package:get/get.dart';
import 'package:muatmuat/app/modules/create_password/create_password_controller.dart';

class CreatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(CreatePasswordController());
  }
}
