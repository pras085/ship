import 'package:get/get.dart';

import 'search_location_map_controller.dart';

class SearchLocationUbahDataMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchLocationUbahDataMapController());
  }
}
