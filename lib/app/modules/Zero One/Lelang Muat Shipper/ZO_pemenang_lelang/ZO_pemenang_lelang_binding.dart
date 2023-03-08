import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_controller.dart';

class ZoPemenangLelangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoPemenangLelangController>(
      () => ZoPemenangLelangController(),
    );
  }
}
