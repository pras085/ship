import 'package:get/get.dart';

import 'informasi_proses_tender_controller.dart';

class InformasiProsesTenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InformasiProsesTenderController());
  }
}
