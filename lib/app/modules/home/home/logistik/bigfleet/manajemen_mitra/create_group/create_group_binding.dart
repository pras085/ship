import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/create_group/create_group_controller.dart';

class CreateGroupBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CreateGroupController());
  }
}