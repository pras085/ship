import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/create_subscription/tm_create_subscription_controller.dart';

class TMCreateSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMCreateSubscriptionController());
  }
}
