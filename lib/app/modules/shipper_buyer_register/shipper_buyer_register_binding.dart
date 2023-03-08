import 'package:get/get.dart';

import 'package:muatmuat/app/modules/shipper_buyer_register/shipper_buyer_register_controller.dart';

class ShipperBuyerRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShipperBuyerRegisterController());
  }
}
