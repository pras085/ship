import 'package:get/get.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/ubah_data_usaha_controller.dart';

class UbahDataUsahaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UbahDataUsahaController());
  }
}
