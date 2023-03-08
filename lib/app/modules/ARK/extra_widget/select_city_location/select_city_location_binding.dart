import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_city_location/select_city_location_controller.dart';

class SelectCityLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectCityLocationController());
  }
}
