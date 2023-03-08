import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/choose_district/choose_district_profil_controller.dart';

class ChooseDistrictProfilPerusahaanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChooseDistrictProfilPerusahaanController());
  }
}