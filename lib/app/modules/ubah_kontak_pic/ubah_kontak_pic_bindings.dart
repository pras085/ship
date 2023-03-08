import 'package:get/get.dart';

import 'package:muatmuat/app/modules/ubah_kontak_pic/ubah_kontak_pic_controller.dart';

class UbahKontakPicBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(UbahKontakPicController());
  }
}
