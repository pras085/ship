import 'package:get/get.dart';
import 'package:muatmuat/app/modules/otp_forget_password/otp_forget_password_controller.dart';

class OtpForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpForgetPasswordController());
  }
}
