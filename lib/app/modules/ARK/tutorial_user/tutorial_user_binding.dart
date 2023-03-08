import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/tender/tender_controller.dart';

import 'tutorial_user_controller.dart';

class TutorialUserBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(TutorialUserController());
  }
}
