import 'package:get/get.dart';
import 'package:muatmuat/app/modules/otp_phone/otp_phone_controller.dart';

class OtpPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpPhoneController());
  }
}
