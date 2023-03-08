import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_controller.dart';


class ManajemenNotifikasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ManajemenNotifikasiController());
  }
}
