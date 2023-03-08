import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/list_management_lokasi/list_management_lokasi/list_management_lokasi_controller.dart';

class ListManagementLokasiBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(ListManagementLokasiController());
  }
}
