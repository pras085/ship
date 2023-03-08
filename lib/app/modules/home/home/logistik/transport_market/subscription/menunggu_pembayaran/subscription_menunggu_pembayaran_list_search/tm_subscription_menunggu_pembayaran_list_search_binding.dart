import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search/tm_subscription_menunggu_pembayaran_list_search_controller.dart';

class TMSubscriptionMenungguPembayaranListSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMSubscriptionMenungguPembayaranListSearchController());
  }
}
