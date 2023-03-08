import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/edit_group/edit_group_controller.dart';

class EditGroupBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(EditGroupController());
  }
}