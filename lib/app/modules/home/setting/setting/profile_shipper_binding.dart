import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_controller.dart';

class ProfileShipperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileShipperController());
  }
}
