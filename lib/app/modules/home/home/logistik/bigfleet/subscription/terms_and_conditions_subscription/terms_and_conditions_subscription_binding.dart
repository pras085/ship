import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/terms_and_conditions_subscription_controller.dart';

class TermsAndConditionsSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TermsAndConditionsSubscriptionController());
  }
}
