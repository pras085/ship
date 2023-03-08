import 'package:get/get.dart';

import 'package:muatmuat/app/modules/user_type_information/user_type_information_controller.dart';

class UserTypeInformationBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<UserTypeInformationController>(
    //   () => UserTypeInformationController(),
    // );
    Get.put(UserTypeInformationController());
  }
}
