import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subuser/create_subuser_controller.dart';

class CreateSubuserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateSubuserController());
  }
}
