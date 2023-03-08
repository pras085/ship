import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_email_profile/otp_email_profile_controller.dart';

class OtpEmailProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpEmailProfileController());
  }
}
