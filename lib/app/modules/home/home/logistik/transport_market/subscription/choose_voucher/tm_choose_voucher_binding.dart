import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/choose_voucher/tm_choose_voucher_controller.dart';

class TMChooseVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMChooseVoucherController());
  }
}
