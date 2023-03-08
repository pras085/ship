import 'package:get/get.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/foto_dan_video/foto_video_controller.dart';

class FotoDanVideoBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FotoDanVideoController());
  }
}
