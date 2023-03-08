import 'package:get/get.dart';
import 'package:muatmuat/app/modules/bottom_navbar/notif_chat_controller.dart';
import 'package:muatmuat/app/modules/contact_support/support_controller.dart';

class NotifChatBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(NotifChatController());
  }
}
