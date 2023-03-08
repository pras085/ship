import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/filter_manajemen_lokasi/filter_manajemen_lokasi_controller.dart';

class FilterManajemenLokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterManajemenLokasiController>(
      () => FilterManajemenLokasiController(),
    );
  }
}
