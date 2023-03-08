import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/before_login/beforeLoginUser_controller.dart';


class BeforeLoginUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BeforeLoginUserController());
  }
}
