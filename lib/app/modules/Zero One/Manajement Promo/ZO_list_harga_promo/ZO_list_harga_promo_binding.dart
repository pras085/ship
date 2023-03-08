import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_list_harga_promo/ZO_list_harga_promo_controller.dart';

class ZoListHargaPromoBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ZoListHargaPromoController>(
    //   () => ZoListHargaPromoController(),
    // );
    Get.put(ZoListHargaPromoController());
  }
}
