import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';

class RegisterShipperBfTmBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterShipperBfTmController());
  }
}