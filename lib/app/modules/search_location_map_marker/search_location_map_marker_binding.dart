import 'package:get/get.dart';

import 'package:muatmuat/app/modules/search_location_map_marker/search_location_map_marker_controller.dart';

class SearchLocationMapMarkerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchLocationMapMarkerController());
  }
}
