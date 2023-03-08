import 'package:get/get.dart';

import 'search_manajemen_role_controller.dart';

class SearchManajemenRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchManajemenRoleController());
  }
}
