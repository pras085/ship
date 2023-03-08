import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/pengaturan_akun/syarat_dan_kebijakan/syarat_dan_kebijakan_controller.dart';

class SyaratDanKebijakanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SyaratDanKebijakanController());
  }
}
