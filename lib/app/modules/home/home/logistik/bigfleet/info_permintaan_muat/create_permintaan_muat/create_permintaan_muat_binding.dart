import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/create_permintaan_muat/create_permintaan_muat_controller.dart';

class CreatePermintaanMuatBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreatePermintaanMuatController());
  }
}