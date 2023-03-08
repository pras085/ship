import 'package:get/get.dart';

import 'package:muatmuat/app/modules/webview_tac_pap/webview_tac_pap_controller.dart';

class WebviewTacPapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WebviewTacPapController());
  }
}
