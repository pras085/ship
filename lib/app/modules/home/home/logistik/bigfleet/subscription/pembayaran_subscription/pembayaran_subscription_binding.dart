import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/pembayaran_subscription/pembayaran_subscription_controller.dart';

class PembayaranSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PembayaranSubscriptionController());
  }
}
