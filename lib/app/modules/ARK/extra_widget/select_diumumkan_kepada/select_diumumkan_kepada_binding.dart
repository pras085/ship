import 'package:get/get.dart';

import 'select_diumumkan_kepada_controller.dart';

class SelectDiumumkanKepadaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectDiumumkanKepadaController());
  }
}
