import 'package:get/get.dart';

import 'create_pratender_controller.dart';

class CreatePratenderBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreatePratenderController());
  }
}