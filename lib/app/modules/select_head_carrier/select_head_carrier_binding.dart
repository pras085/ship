import 'package:get/get.dart';
import 'package:muatmuat/app/modules/select_head_carrier/select_head_carrier_controller.dart';

class SelectHeadCarrierBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectHeadCarrierController());
  }
}
