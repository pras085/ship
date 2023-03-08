import 'package:get/get.dart';

import 'package:muatmuat/app/modules/place_favorite_crud/place_favorite_crud_controller.dart';

class PlaceFavoriteCrudBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlaceFavoriteCrudController());
  }
}
