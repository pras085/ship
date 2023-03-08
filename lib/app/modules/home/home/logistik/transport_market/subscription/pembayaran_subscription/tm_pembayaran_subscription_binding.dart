import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/pembayaran_subscription/tm_pembayaran_subscription_controller.dart';

class TMPembayaranSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TMPembayaranSubscriptionController());
  }
}
