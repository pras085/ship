import 'package:get/get.dart';

import 'list_halaman_peserta_detail_kebutuhan_controller.dart';

class ListHalamanPesertaDetailKebutuhanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListHalamanPesertaDetailKebutuhanController());
  }
}
