import 'package:get/get.dart';

import 'browse_info_pra_tender_controller.dart';

class BrowseInfoPraTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BrowseInfoPraTenderController());
  }
}
