import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_search/ZO_pilih_pemenang_search_controller.dart';

class ZoPilihPemenangSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ZoPilihPemenangSearchController(),
    );
  }
}
