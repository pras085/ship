import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_notifikasi/manajemen_notifikasi_email/manajemen_notifikasi_email_controller.dart';


class ManajemenNotifikasiEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ManajemenNotifikasiEmailController());
  }
}
