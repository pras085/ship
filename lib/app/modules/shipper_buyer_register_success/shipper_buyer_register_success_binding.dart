import 'package:get/get.dart';
import 'package:muatmuat/app/modules/shipper_buyer_register_success/shipper_buyer_register_success_controller.dart';

class ShipperBuyerRegisterSuccessBinding extends Bindings{
  @override
  void dependencies() {
    
    Get.put(ShipperBuyerRegisterSuccessController());
    // TODO: implement dependencies
  }

}