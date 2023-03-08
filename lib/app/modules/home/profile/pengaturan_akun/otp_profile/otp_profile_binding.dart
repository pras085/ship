import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/otp_profile/otp_profile_controller.dart';

class OtpProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpProfileController());
  }
}
