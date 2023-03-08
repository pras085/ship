import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/search_list_transporter/search_list_transporter_controller.dart';

class SearchListTransporterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchListTransporterController());
  }
}
