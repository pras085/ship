import 'package:get/get.dart';

import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_controller.dart';

class LocationTruckReadyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationTruckReadyController());
  }
}
