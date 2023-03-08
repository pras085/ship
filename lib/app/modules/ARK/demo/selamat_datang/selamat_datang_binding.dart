import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/demo/selamat_datang/selamat_datang_controller.dart';

class SelamatDatangBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(SelamatDatangController());
  }
}
