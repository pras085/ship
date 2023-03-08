import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_latest_search/ZO_promo_transporter_latest_search_controller.dart';

class ZoPromoTransporterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoPromoTransporterController>(
      () => ZoPromoTransporterController(),
    );
    Get.lazyPut<ZoPromoTransporterLatestSearchController>(
      () => ZoPromoTransporterLatestSearchController(),
      fenix: true,
    );
  }
}
