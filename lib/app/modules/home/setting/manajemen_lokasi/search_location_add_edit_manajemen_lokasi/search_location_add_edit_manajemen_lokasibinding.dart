import 'package:get/get.dart';
import 'search_location_add_edit_manajemen_lokasi_controller.dart';

class SearchLocationAddEditManajemenLokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchLocationAddEditManajemenLokasiController());
  }
}
