import 'package:get/get.dart';

import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet3/bigfleets3_controller.dart';

class Bigfleets3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Bigfleets3Controller>(
      () => Bigfleets3Controller(),
    );
  }
}
