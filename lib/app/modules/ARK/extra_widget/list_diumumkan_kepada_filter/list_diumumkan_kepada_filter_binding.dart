import 'package:get/get.dart';

import 'list_diumumkan_kepada_filter_controller.dart';

class ListDiumumkanKepadaFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListDiumumkanKepadaFilterController());
  }
}
