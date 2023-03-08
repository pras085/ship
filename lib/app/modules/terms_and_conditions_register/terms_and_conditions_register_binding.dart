import 'package:get/get.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_register/terms_and_conditions_register_controller.dart';

class TermsAndConditionsRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TermsAndConditionsRegisterController());
  }
}
