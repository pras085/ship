import 'package:get/get.dart';

import 'package:muatmuat/app/modules/search_city/search_city_controller.dart';

class SearchCityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchCityController());
  }
}
