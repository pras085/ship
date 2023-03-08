import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/bahasa_placeholder/bahasaPlaceholder_controller.dart';

class BahasaPlaceholderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BahasaPlaceholderController());
  }
}
