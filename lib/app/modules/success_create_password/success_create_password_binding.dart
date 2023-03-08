import 'package:get/get.dart';
import 'package:muatmuat/app/modules/success_create_password/success_create_password_controller.dart';

class SuccessCreatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(SuccessCreatePasswordController());
  }
}
