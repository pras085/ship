import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/lihat_pdf/lihat_pdf_controller.dart';

class LihatPDFBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(LihatPDFController());

  }
}