import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_rute_tender/select_rute_tender_controller.dart';

class SelectRuteTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectRuteTenderController());
  }
}
