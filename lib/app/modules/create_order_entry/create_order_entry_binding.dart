import 'package:get/get.dart';
import 'package:muatmuat/app/modules/create_order_entry/create_order_entry_controller.dart';

class CreateOrderEntryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CreateOrderEntryController());
  }
}
