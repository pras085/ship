import 'package:get/get.dart';
import 'package:muatmuat/app/modules/register_google/register_google_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';

class RegisterGoogleBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(RegisterGoogleController());
  }
}
