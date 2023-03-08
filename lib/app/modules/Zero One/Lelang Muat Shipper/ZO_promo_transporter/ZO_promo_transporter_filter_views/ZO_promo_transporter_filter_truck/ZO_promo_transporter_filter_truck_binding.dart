import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_truck/ZO_promo_transporter_filter_truck_controller.dart';

class ZoPromoTransporterFilterTruckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoPromoTransporterFilterTruckController>(
      () => ZoPromoTransporterFilterTruckController(),
    );
  }
}
