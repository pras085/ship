import 'package:get/get.dart';
import 'package:muatmuat/app/modules/select_list_lokasi/select_list_lokasi_controller.dart';

class SelectListLokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectListLokasiController());
  }
}
