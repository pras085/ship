import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_phone_profile/otp_phone_profile_controller.dart';

class OtpPhoneProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpPhoneProfileController());
  }
}
