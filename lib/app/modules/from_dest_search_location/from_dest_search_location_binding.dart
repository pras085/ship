import 'package:get/get.dart';

import 'from_dest_search_location_controller.dart';


class FromDestSearchLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FromDestSearchLocationController());
  }
}
