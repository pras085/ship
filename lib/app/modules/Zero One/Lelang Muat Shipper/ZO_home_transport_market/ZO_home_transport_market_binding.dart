import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_home_transport_market/ZO_home_transport_market_controller.dart';
import 'package:muatmuat/app/modules/contact_support/support_controller.dart';

class ZoHomeTransportMarketBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );/
    Get.put(ZoHomeTransportMarketController());
  }
}
