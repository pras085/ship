import 'package:get/get.dart';
import 'package:muatmuat/app/modules/group_mitra/group_mitra_controller.dart';

class GroupMitraBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(GroupMitraController());
  }

}