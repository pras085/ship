import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_tentukan_pemenang_tender/list_tentukan_pemenang_tender_controller.dart';

class ListTentukanPemenangTenderBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ListTentukanPemenangTenderController());
  }
}
