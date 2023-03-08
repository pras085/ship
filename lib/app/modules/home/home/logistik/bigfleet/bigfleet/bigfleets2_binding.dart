import 'package:get/get.dart';

import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet/bigfleets2_controller.dart';

class Bigfleets2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Bigfleets2Controller>(
      () => Bigfleets2Controller(),
    );
  }
}
