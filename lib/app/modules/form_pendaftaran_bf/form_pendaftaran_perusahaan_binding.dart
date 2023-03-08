import 'package:get/get.dart';
import 'package:muatmuat/app/modules/form_pendaftaran_bf/form_pendaftaran_bf_controller.dart';

class FormPendaftaranBFBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<FormPendaftaranIndividuController>(
    //   () => FormPendaftaranIndividuController(),
    // );
    Get.put(FormPendaftaranBFController());
  }
}