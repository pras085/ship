import 'package:get/get.dart';

import 'package:muatmuat/app/modules/login/login_controller.dart';
import 'package:muatmuat/app/modules/upload_legalitas/upload_legalitas_controller.dart';

class UploadLegalitasBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(UploadLegalitasController());
  }
}
