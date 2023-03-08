import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/map_management_lokasi/map_management_lokasi_controller.dart';

class MapManagementLokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MapManagementLokasiController());
  }
}
