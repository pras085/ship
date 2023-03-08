import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang_telah_dipilih/list_pilih_pemenang_telah_dipilih_controller.dart';

class ListPilihPemenangTelahDipilihBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ListPilihPemenangTelahDipilihController());
  }
}
