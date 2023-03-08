import 'package:get/get.dart';

import 'search_bagi_peran_sub_user_controller.dart';

class SearchBagiPeranSubUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchBagiPeranSubUserController());
  }
}
