import 'package:get/get.dart';

import 'package:muatmuat/app/modules/bigfleets/bigfleets_controller.dart';

class BigfleetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BigfleetsController());
  }
}
