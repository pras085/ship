import 'package:get/get.dart';

import 'package:muatmuat/app/modules/choose_user_type/choose_user_type_controller.dart';

class ChooseUserTypeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ChooseUserTypeController>(
    //   () => ChooseUserTypeController(),
    // );
    Get.put(ChooseUserTypeController());
  }
}
