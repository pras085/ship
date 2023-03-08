import 'package:get/get.dart';
import 'package:muatmuat/app/modules/lokasi_bf_tm/lokasi_bf_tm_controller.dart';
// import 'package:muatmuat/app/modules/select_list_lokasi/select_list_lokasi_controller.dart';

class LokasiBFTMBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LokasiBFTMController());
  }
}
