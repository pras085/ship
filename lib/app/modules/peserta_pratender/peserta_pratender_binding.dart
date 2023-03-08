import 'package:get/get.dart';
import 'package:muatmuat/app/modules/peserta_pratender/peserta_pratender_controller.dart';

class PesertaPratenderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(PesertaPratenderController());
  }
}
