import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/edit_proses_tender/edit_proses_tender_controller.dart';

class EditProsesTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProsesTenderController());
  }
}
