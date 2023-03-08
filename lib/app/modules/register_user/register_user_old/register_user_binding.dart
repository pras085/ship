import 'package:get/get.dart';

import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';

class RegisterUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterUserController());
    // Get.lazyPut<RegisterUserController>(
    //   () => RegisterUserController(),
    // );
  }
}
