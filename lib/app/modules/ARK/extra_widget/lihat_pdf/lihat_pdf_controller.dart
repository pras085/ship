import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LihatPDFController extends GetxController {
  final url = "".obs;
  final title = "".obs;
  final onLoad = false.obs;

  @override
  void onInit() {
    title.value = Get.arguments[0];
    url.value = Get.arguments[1];
    //_launchInWebViewOrVC(url.value);
    print(url.value);
    print(title.value);
    print(url.value.split(":").first);
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void setOnLoad(bool isLoad) {
    onLoad.value = isLoad;
  }
}
