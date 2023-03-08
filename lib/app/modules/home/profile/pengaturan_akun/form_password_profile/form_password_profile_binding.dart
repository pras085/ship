import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_password_profile/form_password_profile_controller.dart';

class FormPasswordProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(FormPasswordProfileController());
  }
}
