import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list/tm_subscription_riwayat_pesanan_list_controller.dart';

class TMSubscriptionRiwayatPesananListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMSubscriptionRiwayatPesananListController());
  }
}
