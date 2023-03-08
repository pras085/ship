import 'package:get/get.dart';
import 'package:muatmuat/app/modules/choose_ekspetasi_destinasi/choose_ekspetasi_destinasi_controller.dart';

class ChooseEkspetasiDestinasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseEkspetasiDestinasiController>(
      () => ChooseEkspetasiDestinasiController(),
    );
  }
}
