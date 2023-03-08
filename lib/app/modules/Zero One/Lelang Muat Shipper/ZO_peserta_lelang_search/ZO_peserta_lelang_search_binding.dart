import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang_search/ZO_peserta_lelang_search_controller.dart';

class ZoPesertaLelangSearchBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ZoPesertaLelangSearchController());
    Get.put(
      ZoPesertaLelangSearchController(),
    );
  }
}
