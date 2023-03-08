import 'package:get/get.dart';
import 'package:muatmuat/app/modules/detail_manajemen_order/detail_manajemen_order_controller.dart';

class DetailManajemenOrderBinding extends Bindings{
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(DetailManajemenOrderController());
  }

}