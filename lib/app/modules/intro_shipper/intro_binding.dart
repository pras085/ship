import 'package:get/get.dart';

import 'package:muatmuat/app/modules/intro_shipper/intro_controller.dart';

class IntroBindingShipper extends Bindings {
  @override
  void dependencies() {
    Get.put(IntroShipperController());
  }
}
