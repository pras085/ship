import 'package:get/get.dart';

import 'package:muatmuat/app/modules/home/home/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
