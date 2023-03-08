import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list/subscription_riwayat_pesanan_list_controller.dart';

class SubscriptionRiwayatPesananListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionRiwayatPesananListController());
  }
}
