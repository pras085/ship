import 'package:get/get.dart';
import 'package:muatmuat/app/modules/otp_email_bftm/otp_email_controller_bftm.dart';

class OtpEmailBFTMBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpEmailBFTMController());
  }
}
