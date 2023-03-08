import 'package:get/get.dart';

import 'search_info_pra_tender_controller.dart';

class SearchInfoPraTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchInfoPraTenderController());
  }
}
