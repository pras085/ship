import 'package:get/get.dart';
import 'package:muatmuat/app/modules/list_user/list_user_controller.dart';

class ListUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListUserController());
  }
}
