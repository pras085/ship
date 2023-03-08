import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_detail/subscription_detail_controller.dart';

class SubscriptionDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(SubscriptionDetailController());
  }
}
