import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pilih_metode_pembayaran/subscription_pilih_metode_pembayaran_controller.dart';

class SubscriptionPilihMetodePembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionPilihMetodePembayaranController());
  }
}
