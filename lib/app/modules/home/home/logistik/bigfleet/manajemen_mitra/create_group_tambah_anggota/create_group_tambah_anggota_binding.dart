import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/create_group_tambah_anggota/create_group_tambah_anggota_controller.dart';

class CreateGroupTambahAnggotaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateGroupTambahAnggotaController());
  }
}
