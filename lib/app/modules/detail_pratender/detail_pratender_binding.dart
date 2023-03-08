import 'package:get/get.dart';
import 'detail_pratender_controller.dart';

class DetailPratenderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(DetailPratenderController());
  }
}
