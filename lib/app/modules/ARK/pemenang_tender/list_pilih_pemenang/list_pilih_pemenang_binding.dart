import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang/list_pilih_pemenang_controller.dart';

class ListPilihPemenangBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ListPilihPemenangController());
  }
}
