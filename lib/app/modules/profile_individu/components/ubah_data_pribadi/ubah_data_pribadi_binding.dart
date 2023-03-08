import 'package:get/get.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_pribadi/ubah_data_pribadi_controller.dart';

class UbahDataPribadiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UbahDataPribadiController());
  }
}
