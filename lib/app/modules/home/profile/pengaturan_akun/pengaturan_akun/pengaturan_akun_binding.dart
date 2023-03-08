import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/pengaturan_akun/pengaturan_akun_controller.dart';
import 'package:muatmuat/app/modules/home/profile/profil_controller.dart';


class PengaturanAkunBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PengaturanAkunController());
  }
}
