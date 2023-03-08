import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:muatmuat/app/modules/choose_district/choose_district_controller.dart';

class ChooseDistrictBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChooseDistrictController());
  }
}