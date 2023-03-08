import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/transport_market/transport_market_controller.dart';

class TransportMarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransportMarketController>(
      () => TransportMarketController(),
    );
  }
}
