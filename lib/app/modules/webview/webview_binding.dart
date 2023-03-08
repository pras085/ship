import 'package:get/get.dart';
import 'package:muatmuat/app/modules/webview/webview_controller.dart';

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(WebviewController());

  }
}