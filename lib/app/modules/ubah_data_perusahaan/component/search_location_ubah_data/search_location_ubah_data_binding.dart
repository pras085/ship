import 'package:get/get.dart';

import 'search_location_ubah_data_controller.dart';

class SearchLocationUbahDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchLocationUbahDataController());
  }
}
