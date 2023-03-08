import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/profile/profil_controller.dart';


class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfilController());
  }
}
