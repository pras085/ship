import 'package:get/get.dart';

import 'search_manajemen_mitra_controller.dart';

class SearchManajemenMitraBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchManajemenMitraController());
  }
}
