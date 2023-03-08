import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_head_carrier/list_head_carrier_controller.dart';

class ListHeadCarrierBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListHeadCarrierController());
  }
}
