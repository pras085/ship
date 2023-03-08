import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search/subscription_riwayat_langganan_su_list_search_controller.dart';

class SubscriptionRiwayatLanggananSUListSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionRiwayatLanggananSUListSearchController());
  }
}
