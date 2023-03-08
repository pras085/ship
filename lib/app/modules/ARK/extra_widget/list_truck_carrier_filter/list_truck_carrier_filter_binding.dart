import 'package:get/get.dart';

import 'list_truck_carrier_filter_controller.dart';

class ListTruckCarrierFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListTruckCarrierFilterController());
  }
}
