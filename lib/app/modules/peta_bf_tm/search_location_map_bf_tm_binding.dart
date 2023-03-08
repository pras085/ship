import 'package:get/get.dart';

import 'package:muatmuat/app/modules/peta_bf_tm/search_location_map_bf_tm_controller.dart';

class PetaBFTMBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PetaBFTMController());
  }
}
