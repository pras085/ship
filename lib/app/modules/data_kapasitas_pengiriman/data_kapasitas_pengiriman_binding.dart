import 'package:get/get.dart';
import 'package:muatmuat/app/modules/data_kapasitas_pengiriman/data_kapasitas_pengiriman_controller.dart';

class DataKapasitasPengirimanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DataKapasitasPengirimanController());
  }
}
