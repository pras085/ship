import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_aplikasi/manajemen_notifikasi_aplikasi_controller.dart';


class ManajemenNotifikasiAplikasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ManajemenNotifikasiAplikasiController());
  }
}
