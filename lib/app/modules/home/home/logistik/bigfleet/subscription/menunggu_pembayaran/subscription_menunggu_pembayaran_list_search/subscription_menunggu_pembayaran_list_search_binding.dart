import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search/subscription_menunggu_pembayaran_list_search_controller.dart';

class SubscriptionMenungguPembayaranListSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionMenungguPembayaranListSearchController());
  }
}
