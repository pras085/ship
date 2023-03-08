import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/choose_voucher/choose_voucher_controller.dart';

class ChooseVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChooseVoucherController());
  }
}
