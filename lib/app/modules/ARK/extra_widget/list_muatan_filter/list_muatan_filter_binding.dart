import 'package:get/get.dart';

import 'list_muatan_filter_controller.dart';

class ListMuatanFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListMuatanFilterController());
  }
}
