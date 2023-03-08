import 'package:get/get.dart';

import 'list_halaman_peserta_pilih_pemenang_controller.dart';

class ListHalamanPesertaPilihPemenangBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListHalamanPesertaPilihPemenangController());
  }
}
