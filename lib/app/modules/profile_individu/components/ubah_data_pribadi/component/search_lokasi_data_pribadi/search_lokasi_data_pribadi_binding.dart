import 'package:get/get.dart';

import 'search_lokasi_data_pribadi_controller.dart';


class SearchLocationDataPribadiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchLocationDataPribadiController());
  }
}
