import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:muatmuat/app/modules/fake_home/fake_home_controller.dart';

class FakeHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FakeHomeController());
  }
}