import 'package:get/get.dart';

class WebviewTacPapController extends GetxController {
  //TODO: Implement WebviewTacPapController

  final url = "".obs;
  final onLoad = false.obs;

  @override
  void onInit() {
    url.value = Get.arguments;
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void setOnLoad(bool isLoad) {
    onLoad.value = isLoad;
  }
}
