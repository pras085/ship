import 'package:get/get.dart';

import 'choose_area_pickup_internal_controller.dart';

class ChooseAreaPickupInternalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseAreaPickupInternalController>(
      () => ChooseAreaPickupInternalController(),
    );
  }
}
