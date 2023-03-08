import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/search_result_list_management_lokasi/search_result_list_management_lokasi_controller.dart';

class SearchResultListManagementLokasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchResultListManagementLokasiController());
  }
}
