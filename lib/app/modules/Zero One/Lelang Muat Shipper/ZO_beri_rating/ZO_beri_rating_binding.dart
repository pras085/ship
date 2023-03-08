import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_beri_rating/ZO_beri_rating_controller.dart';

class ZoBeriRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoBeriRatingController>(
      () => ZoBeriRatingController(),
    );
  }
}
