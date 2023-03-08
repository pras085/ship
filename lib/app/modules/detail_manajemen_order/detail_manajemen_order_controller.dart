import 'dart:async';

import 'package:get/get.dart';

class DetailManajemenOrderController extends GetxController {
  var loadList = true.obs;

  @override
  void onInit() {
    Timer(Duration(seconds: 3), () async {
      loadList.value = false;
    });
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
