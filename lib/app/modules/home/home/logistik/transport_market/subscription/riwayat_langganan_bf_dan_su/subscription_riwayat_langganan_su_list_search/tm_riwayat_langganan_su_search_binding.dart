import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search/tm_riwayat_langganan_su_search_controller.dart';

class TMSubscriptionRiwayatLanggananSUListSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMSubscriptionRiwayatLanggananSUListSearchController());
  }
}
