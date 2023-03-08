import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/create_info_pra_tender/create_info_pra_tender_controller.dart';

class CreateInfoPraTenderBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreateInfoPraTenderController());
  }
}