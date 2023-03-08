import 'package:get/get.dart';

import 'list_city_filter_ark_controller.dart';

class ListCityFilterArkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListCityFilterArkController());
  }
}
