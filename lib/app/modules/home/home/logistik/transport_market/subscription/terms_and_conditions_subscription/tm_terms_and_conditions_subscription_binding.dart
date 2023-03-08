import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/terms_and_conditions_subscription/tm_terms_and_conditions_subscription_controller.dart';

class TMTermsAndConditionsSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMTermsAndConditionsSubscriptionController());
  }
}
