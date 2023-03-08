import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_truck_satuan/ZO_filter_truck_satuan_controller.dart';

class ZoFilterTruckSatuanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoFilterTruckSatuanController>(
      () => ZoFilterTruckSatuanController(),
    );
  }
}
