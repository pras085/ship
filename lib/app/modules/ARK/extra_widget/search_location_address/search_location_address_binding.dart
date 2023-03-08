import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/search_location_address/search_location_address_controller.dart';

class SearchLocationAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchLocationAddressController());
  }
}
