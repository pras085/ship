import 'package:get/get.dart';

import 'search_manajemen_user_controller.dart';

class SearchManajemenUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchManajemenUserController());
  }
}
