import 'package:get/get.dart';
import 'package:muatmuat/app/modules/show_video/show_video_controller.dart';

class ShowVideoBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ShowVideoController());
  }
}
