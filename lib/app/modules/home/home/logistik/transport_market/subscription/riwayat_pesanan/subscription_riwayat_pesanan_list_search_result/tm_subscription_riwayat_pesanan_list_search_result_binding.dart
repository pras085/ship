import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search_result/tm_subscription_riwayat_pesanan_list_search_result_controller.dart';

class TMSubscriptionRiwayatPesananListSearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMSubscriptionRiwayatPesananListSearchResultController());
  }
}
