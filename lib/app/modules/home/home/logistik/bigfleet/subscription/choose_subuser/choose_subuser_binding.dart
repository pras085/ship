import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/choose_subuser/choose_subuser_controller.dart';

class ChooseSubuserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChooseSubuserController());
  }
}
