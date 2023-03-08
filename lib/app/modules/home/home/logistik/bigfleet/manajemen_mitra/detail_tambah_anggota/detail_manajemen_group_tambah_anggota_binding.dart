import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/detail_tambah_anggota/detail_manajemen_group_tambah_anggota_controller.dart';

class DetailManajemenGroupTambahAnggotaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailManajemenGroupTambahAnggotaController());
  }
}
