import 'package:get/get.dart';

import 'package:muatmuat/app/modules/location_truck_ready_search/location_truck_ready_search_controller.dart';

class LocationTruckReadySearchBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LocationTruckReadySearchController>(
    //   () => LocationTruckReadySearchController(),
    // );
    Get.put(LocationTruckReadySearchController());
  }
}
