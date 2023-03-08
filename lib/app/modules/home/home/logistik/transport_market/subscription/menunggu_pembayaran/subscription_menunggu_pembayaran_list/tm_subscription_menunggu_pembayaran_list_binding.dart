import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list/tm_subscription_menunggu_pembayaran_list_controller.dart';

class TMSubscriptionMenungguPembayaranListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMSubscriptionMenungguPembayaranListController());
  }
}
