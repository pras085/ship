import 'package:get/get.dart';
import 'package:muatmuat/app/modules/list_search_truck_siap_muat/list_search_truck_siap_muat_controller.dart';

class ListSearchTruckSiapMuatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListSearchTruckSiapMuatController());
  }
}
