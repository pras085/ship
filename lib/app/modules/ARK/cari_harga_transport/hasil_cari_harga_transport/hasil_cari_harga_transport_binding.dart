import 'package:get/get.dart';

import 'hasil_cari_harga_transport_controller.dart';

class HasilCariHargaTransportBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(HasilCariHargaTransportController());
  }
}
