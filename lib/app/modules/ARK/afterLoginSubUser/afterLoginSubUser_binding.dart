import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/afterLoginSubUser/afterLoginSubUser_controller.dart';


class AfterLoginSubUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AfterLoginSubUserController());
  }
}
