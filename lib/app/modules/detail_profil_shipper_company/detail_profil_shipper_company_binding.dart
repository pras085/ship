import 'package:get/get.dart';
import 'package:muatmuat/app/modules/detail_profil_shipper_company/detail_profil_shipper_company_controller.dart';

class DetailProfilShipperCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailProfilShipperCompanyController());
  }
}
