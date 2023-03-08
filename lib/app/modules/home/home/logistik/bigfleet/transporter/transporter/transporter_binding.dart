import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/transporter/transporter_controller.dart';

class TransporterBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(TransporterController());
  }
}
