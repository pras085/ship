import 'package:get/get.dart';

import 'profile_individu_controller.dart';

class ProfileIndividuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileIndividuController());
  }
}