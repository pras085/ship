import 'package:get/get.dart';

import 'list_city_filter_controller.dart';

class ListCityFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListCityFilterController());
  }
}
