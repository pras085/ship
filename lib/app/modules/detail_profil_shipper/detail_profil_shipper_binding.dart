import 'package:get/get.dart';

import 'detail_profil_shipper_controller.dart';

class DetailProfilShipperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailProfilShipperController());
  }
}
