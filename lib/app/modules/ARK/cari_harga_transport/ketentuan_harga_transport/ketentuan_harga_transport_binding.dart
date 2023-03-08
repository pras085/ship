import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/ketentuan_harga_transport/ketentuan_harga_transport_controller.dart';

class KetentuanHargaTransportBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(KetentuanHargaTransportController());
  }
}
