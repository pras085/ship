import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:muatmuat/app/modules/shipment_capacity_validation/shipment_capacity_validation_controller.dart';

class ShipmentCapacityValidationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ShipmentCapacityValidationController());
  }
}