import 'package:get/get.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_bftm/terms_and_conditions_bftm_controller.dart';

class TermsAndConditionsBFTMBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TermsAndConditionsBFTMController());
  }
}
