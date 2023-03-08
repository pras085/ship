import 'package:get/get.dart';

import 'list_area_pickup_search_filter_controller.dart';

class ListAreaPickupSearchFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListAreaPickupSearchFilterController());
  }
}
