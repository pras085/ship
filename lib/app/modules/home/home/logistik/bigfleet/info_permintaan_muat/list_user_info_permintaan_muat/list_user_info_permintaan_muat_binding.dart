import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_user_info_permintaan_muat/list_user_info_permintaan_muat_controller.dart';

class ListUserInfoPermintaanMuatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListUserInfoPermintaanMuatController());
  }
}
