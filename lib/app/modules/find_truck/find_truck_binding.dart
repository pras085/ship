import 'package:get/get.dart';
import 'find_truck_controller.dart';

class FindTruckBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(FindTruckController());
  }
}
