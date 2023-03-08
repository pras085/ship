import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_select_location/ZO_map_select_location_controller.dart';

class ZoMapSelectLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ZoMapSelectLocationController());
  }
}
