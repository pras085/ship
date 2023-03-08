import 'package:get/get.dart';
import 'otp_phone_ark_controller.dart';

class OtpPhoneARKBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpPhoneARKController());
  }
}
