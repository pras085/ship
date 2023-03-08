import 'package:get/get.dart';
import 'search_lokasi_data_usaha_controller.dart';

class SearchLocationDataUsahaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchLocationDataUsahaController());
  }
}
