import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/choose_subuser/tm_choose_subuser_controller.dart';

class TMChooseSubuserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMChooseSubuserController());
  }
}
