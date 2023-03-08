import 'package:get/get.dart';
import 'package:muatmuat/app/modules/profile_individu/components/ubah_data_usaha/component/lokasi_data_individu_usaha/lokasi_data_individu_usaha_controller.dart';



class LokasiUbahDataIndividuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LokasiUbahDataIndividuController());
  }
}
