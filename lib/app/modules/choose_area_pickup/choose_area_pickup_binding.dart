import 'package:get/get.dart';

import 'choose_area_pickup_controller.dart';

class ChooseAreaPickupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseAreaPickupController>(
      () => ChooseAreaPickupController(),
    );
  }
}
