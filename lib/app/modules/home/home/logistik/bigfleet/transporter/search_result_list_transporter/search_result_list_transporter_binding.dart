import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_result_list_transporter/search_result_list_transporter_controller.dart';

class SearchResultListTransporterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchResultListTransporterController());
    ;
  }
}
