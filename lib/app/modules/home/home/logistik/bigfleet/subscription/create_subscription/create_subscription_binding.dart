import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subscription/create_subscription_controller.dart';

class CreateSubscriptionBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreateSubscriptionController());
  }
}