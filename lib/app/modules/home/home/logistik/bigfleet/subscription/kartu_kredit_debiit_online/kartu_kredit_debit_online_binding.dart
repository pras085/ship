import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/kartu_kredit_debiit_online/kartu_kredit_debit_online_controller.dart';

class KartuKreditDebitOnlineBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(KartuKreditDebitOnlineController());
  }
}
