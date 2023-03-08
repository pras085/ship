import 'package:get/get.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/kontak_pic/kontak_pic_controller.dart';

class KontakPICBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(KontakPICController());
  }
}