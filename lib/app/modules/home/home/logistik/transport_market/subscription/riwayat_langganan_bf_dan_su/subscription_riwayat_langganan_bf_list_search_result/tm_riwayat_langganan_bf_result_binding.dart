import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_bf_list_search_result/tm_riwayat_langganan_bf_result_controller.dart';

class TMSubscriptionRiwayatLanggananBFListSearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMSubscriptionRiwayatLanggananBFListSearchResultController());
  }
}
