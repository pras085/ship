import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/report/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReportController());
  }
}