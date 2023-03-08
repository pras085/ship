import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pilih_metode_pembayaran/tm_subscription_pilih_metode_pembayaran_controller.dart';

class TMSubscriptionPilihMetodePembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMSubscriptionPilihMetodePembayaranController());
  }
}
