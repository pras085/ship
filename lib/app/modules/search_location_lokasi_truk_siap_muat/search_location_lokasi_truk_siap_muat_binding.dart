import 'package:get/get.dart';
import 'package:muatmuat/app/modules/search_location_lokasi_truk_siap_muat/search_location_lokasi_truk_siap_muat_controller.dart';

class SearchLocationLokasiTrukSiapMuatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchLocationLokasiTrukSiapMuatController());
  }
}
