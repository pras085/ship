import 'package:get/get.dart';
import 'package:muatmuat/app/modules/success_register/success_register_controller.dart';

class SuccessRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SuccessRegisterController());
  }
}
