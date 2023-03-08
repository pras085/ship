import 'package:get/get.dart';
import 'package:muatmuat/app/modules/notification/notif_controller.dart';

class NotifBindingNew extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(NotifControllerNew());

  }
}