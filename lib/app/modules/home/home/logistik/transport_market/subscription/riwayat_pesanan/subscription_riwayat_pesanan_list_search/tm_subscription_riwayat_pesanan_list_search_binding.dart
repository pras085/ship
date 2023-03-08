import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search/tm_subscription_riwayat_pesanan_list_search_controller.dart';

class TMSubscriptionRiwayatPesananListSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMSubscriptionRiwayatPesananListSearchController());
  }
}
