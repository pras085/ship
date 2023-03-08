import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/zona_waktu_dan%20bahasa/zona_waktu_dan%20bahasa_controller.dart';

class ZonaWaktuDanBahasaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ZonaWaktuDanBahasaController());
  }
}
