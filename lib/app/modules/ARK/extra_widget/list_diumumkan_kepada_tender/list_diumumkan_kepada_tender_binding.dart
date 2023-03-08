import 'package:get/get.dart';

import 'list_diumumkan_kepada_tender_controller.dart';

class ListDiumumkanKepadaTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListDiumumkanKepadaTenderController());
  }
}
