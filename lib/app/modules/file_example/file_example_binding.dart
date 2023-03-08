import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:muatmuat/app/modules/file_example/file_example_controller.dart';

class FileExampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FileExampleController());
  }
}