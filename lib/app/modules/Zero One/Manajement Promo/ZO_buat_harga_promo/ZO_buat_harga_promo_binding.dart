import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_buat_harga_promo/ZO_buat_harga_promo_controller.dart';

class ZoBuatHargaPromoBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );/
    Get.put(ZoBuatHargaPromoController());
  }
}
