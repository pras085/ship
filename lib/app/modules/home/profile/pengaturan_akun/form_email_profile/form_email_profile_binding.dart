import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_email_profile/form_email_profile_controller.dart';

import 'package:muatmuat/app/modules/login/login_controller.dart';

class FormEmailProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(FormEmailProfileController());
  }
}
