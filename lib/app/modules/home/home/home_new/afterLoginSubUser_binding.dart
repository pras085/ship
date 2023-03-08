import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/home_new/afterLoginSubUser_controller.dart';


class AfterLoginSubUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AfterLoginSubUserController());
  }
}
