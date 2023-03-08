import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_transporter_notif/list_transporter_notif_controller.dart';

class ListTransporterNotifBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListTransporterNotifController());
  }
}
