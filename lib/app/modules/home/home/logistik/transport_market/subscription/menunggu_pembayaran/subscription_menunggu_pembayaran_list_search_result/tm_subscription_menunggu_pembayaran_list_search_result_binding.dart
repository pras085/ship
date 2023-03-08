import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search_result/tm_subscription_menunggu_pembayaran_list_search_result_controller.dart';

class TMSubscriptionMenungguPembayaranListSearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMSubscriptionMenungguPembayaranListSearchResultController());
  }
}
