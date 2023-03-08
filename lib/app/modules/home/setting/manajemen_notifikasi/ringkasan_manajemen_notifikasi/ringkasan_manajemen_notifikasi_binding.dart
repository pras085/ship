import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/ringkasan_manajemen_notifikasi/ringkasan_manajemen_notifikasi_controller.dart';


class RingkasanManajemenNotifikasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RingkasanManajemenNotifikasiController());
  }
}
