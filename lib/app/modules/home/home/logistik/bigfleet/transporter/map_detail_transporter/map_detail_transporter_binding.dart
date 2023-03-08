import 'package:get/get.dart';

import 'map_detail_transporter_controller.dart';

class MapDetailTransporterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MapDetailTransporterController());
  }
}
