import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search/subscription_riwayat_langganan_bf_list_search_controller.dart';

class SubscriptionRiwayatLanggananBFListSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionRiwayatLanggananBFListSearchController());
  }
}
