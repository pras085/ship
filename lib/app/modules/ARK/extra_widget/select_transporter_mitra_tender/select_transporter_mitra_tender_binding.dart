import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_transporter_mitra_tender/select_transporter_mitra_tender_controller.dart';

class SelectTransporterMitraTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SelectTransporterMitraTenderController());
  }
}
