import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search/subscription_riwayat_pesanan_list_search_controller.dart';

class SubscriptionRiwayatPesananListSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionRiwayatPesananListSearchController());
  }
}
