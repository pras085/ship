import 'package:get/get.dart';

import 'success_register_ark_controller.dart';

class SuccessRegisterARKBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SuccessRegisterARKController());
  }
}
