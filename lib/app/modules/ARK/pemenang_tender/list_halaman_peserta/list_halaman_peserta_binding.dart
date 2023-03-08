import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta/list_halaman_peserta_controller.dart';

class ListHalamanPesertaBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ListHalamanPesertaController());
  }
}
