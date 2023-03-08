import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/kartu_kredit_debiit_online/tm_kartu_kredit_debit_online_controller.dart';

class TMKartuKreditDebitOnlineBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMKartuKreditDebitOnlineController());
  }
}
