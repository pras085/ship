import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/edit_info_pra_tender/edit_info_pra_tender_controller.dart';

class EditInfoPraTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditInfoPraTenderController());
  }
}
