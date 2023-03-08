import 'package:get/get.dart';
import 'package:muatmuat/app/modules/pay/pay_controller.dart';

class PayBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(
    //   () => LoginController(),
    // );
    Get.put(PayController());
  }
}
