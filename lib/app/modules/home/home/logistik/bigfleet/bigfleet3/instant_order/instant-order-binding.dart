import 'package:get/get.dart';

import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet3/instant_order/instant-order-controller.dart';

class InstantOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InstantOrderController>(
      () => InstantOrderController(),
    );
  }
}
