import 'package:get/get.dart';

import 'cari_harga_transport_controller.dart';

class CariHargaTransportBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(CariHargaTransportController());
  }
}
