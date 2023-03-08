import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_input_password_profile/form_input_password_profile_controller.dart';

class FormInputPasswordProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(FormInputPasswordProfileController());
  }
}
