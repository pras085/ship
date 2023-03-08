import 'package:get/get.dart';

import 'search_pemenang_tender_controller.dart';

class SearchPemenangTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchPemenangTenderController());
  }
}
