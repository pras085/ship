import 'package:get/get.dart';
import 'package:muatmuat/app/modules/detail_ltsm/detail_ltsm_controller.dart';

class DetailLTSMBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailLTSMController());
  }
}
