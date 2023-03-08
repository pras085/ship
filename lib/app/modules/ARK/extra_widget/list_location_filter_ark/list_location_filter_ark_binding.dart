import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_location_filter_ark/list_location_filter_ark_controller.dart';

class ListLocationFilterArkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListLocationFilterArkController());
  }
}
