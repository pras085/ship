import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_select/ZO_map_select_controller.dart';

class ZoMapSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ZoMapSelectController());
  }
}
