import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/create_subuser/tm_create_subuser_controller.dart';

class TMCreateSubuserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMCreateSubuserController());
  }
}
