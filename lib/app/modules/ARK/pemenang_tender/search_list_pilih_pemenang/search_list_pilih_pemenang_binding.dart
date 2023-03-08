import 'package:get/get.dart';

import 'search_list_pilih_pemenang_controller.dart';

class SearchListPilihPemenangBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchListPilihPemenangController());
  }
}
