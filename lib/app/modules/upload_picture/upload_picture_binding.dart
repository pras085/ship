import 'package:get/get.dart';
import 'package:muatmuat/app/modules/upload_picture/upload_picture_controller.dart';

class UploadPictureBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(UploadPictureController());
  }
}
