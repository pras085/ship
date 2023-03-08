import 'package:get/get.dart';
import 'package:muatmuat/app/modules/profile_individu/components/search_kecamatan/search_kecamatan_controller.dart';

class SearchKecamatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchKecamatanController());
  }
}
