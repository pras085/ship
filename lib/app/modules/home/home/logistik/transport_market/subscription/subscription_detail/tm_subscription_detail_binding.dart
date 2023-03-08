import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/subscription_detail/tm_subscription_detail_controller.dart';

class TMSubscriptionDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(TMSubscriptionDetailController());
  }
}
