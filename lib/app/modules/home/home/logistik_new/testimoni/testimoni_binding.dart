import 'package:get/get.dart';

import 'testimoni_controller.dart';

class TestimoniBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TestimoniController());
  }
}