import 'package:get/get.dart';

import 'package:muatmuat/app/modules/place_favorite/place_favorite_controller.dart';

class PlaceFavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlaceFavoriteController());
  }
}
