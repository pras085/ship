import 'package:get/get.dart';

import 'search_proses_tender_controller.dart';

class SearchProsesTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchProsesTenderController());
  }
}
