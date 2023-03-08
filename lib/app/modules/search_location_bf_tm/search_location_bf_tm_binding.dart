import 'package:get/get.dart';

import 'search_location_bf_tm_controller.dart';

class SearchLocationBFTMBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchLocationBFTMController());
  }
}
