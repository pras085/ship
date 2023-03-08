import 'package:get/get.dart';

import 'detail_manajemen_group_mitra_controller.dart';

class DetailManajemenGroupMitraBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailManajemenGroupMitraController());
  }
}
