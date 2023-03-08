import 'package:get/get.dart';
import 'package:muatmuat/app/modules/balance/balance_controller.dart';

class BalanceBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<NotifController>(
    //   () => NotifController(),
    // );
    Get.put(BalanceController());

  }
}