import 'package:get/get.dart';

import 'list_halaman_peserta_detail_penawaran_controller.dart';

class ListHalamanPesertaDetailPenawaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListHalamanPesertaDetailPenawaranController());
  }
}
