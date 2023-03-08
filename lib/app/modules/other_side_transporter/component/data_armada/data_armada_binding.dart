import 'package:get/get.dart';
import 'package:muatmuat/app/modules/create_password/create_password_controller.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/data_armada/data_armada_controller.dart';

class DataArmadaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DataArmadaController());
  }
}
