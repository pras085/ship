import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/create_proses_tender/create_proses_tender_controller.dart';

class CreateProsesTenderBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreateProsesTenderController());
  }
}