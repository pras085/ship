import 'package:get/get.dart';

import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_conditions_controller.dart';

class TermsAndConditionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TermsAndConditionsController());
  }
}
