import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:muatmuat/app/modules/choose_business_field/choose_business_field_controller.dart';

class ChooseBusinessFieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChooseBusinessFieldController());
  }
}