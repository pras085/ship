import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_controller.dart';

import 'search_result_manajemen_mitra_controller.dart';

class SearchResultManajemenMitraBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchResultManajemenMitraController());
  }
}
