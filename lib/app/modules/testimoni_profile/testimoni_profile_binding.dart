import 'package:get/get.dart';

import 'testimoni_profile_controller.dart';

class TestimoniProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TestimoniProfileController());
  }
}