import 'package:get/get.dart';
import 'package:muatmuat/app/tawkto/tawkto_controller.dart';


class TawktoBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<TawktoController>(()=>TawktoController());
  }

}