import 'package:get/get.dart';
import 'package:muatmuat/app/modules/manajemen_order_entry/manajemen_order_controller.dart';

class ManajemenOrderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ManajemenOrderController());
  }
}
