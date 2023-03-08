import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_location/ZO_promo_transporter_filter_location_controller.dart';

class ZoPromoTransporterFilterLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ZoPromoTransporterFilterLocationController(),
    );
  }
}
