import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list/subscription_menunggu_pembayaran_list_controller.dart';

class SubscriptionMenungguPembayaranListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionMenungguPembayaranListController());
  }
}
