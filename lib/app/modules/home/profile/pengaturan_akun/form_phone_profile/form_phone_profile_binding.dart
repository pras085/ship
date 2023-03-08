import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/form_phone_profile/form_phone_profile_controller.dart';

class FormPhoneProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FormPhoneProfileController());
  }
}
