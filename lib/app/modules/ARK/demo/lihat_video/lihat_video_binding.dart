import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/demo/lihat_video/lihat_video_controller.dart';

class LihatVideoBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(LihatVideoController());
  }
}
