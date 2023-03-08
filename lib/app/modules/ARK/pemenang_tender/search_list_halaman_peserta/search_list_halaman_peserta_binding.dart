import 'package:get/get.dart';

import 'search_list_halaman_peserta_controller.dart';

class SearchListHalamanPesertaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchListHalamanPesertaController());
  }
}
