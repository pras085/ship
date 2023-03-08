import 'package:get/get.dart';

import 'test_list_controller.dart';

class TestListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TestListController());
  }
}
