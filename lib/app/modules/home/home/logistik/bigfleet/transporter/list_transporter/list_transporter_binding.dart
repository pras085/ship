import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/list_transporter/list_transporter_controller.dart';

class ListTransporterBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ListTransporterController());
  }
}