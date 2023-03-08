import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatController extends GetxController {
  var onLoad = true.obs;
  WebViewController webViewController;

  var url = "";

  @override
  void onInit() {
    var otherID = Get.arguments[0]; //pakai transporter id
    var welcomeMessage = Get.arguments[1].toString();
    url =
        "${ApiHelper.urlChatInternal}try-chat-web-view/?token=${GlobalVariable.tokenApp}&otherId=$otherID&otherRole=2${welcomeMessage.isEmpty ? "" : "&welcomeMessage=$welcomeMessage"}";
    print(url);
    // url =
    //     "${ApiHelper.url}try-chat-web-view/?token=${GlobalVariable.tokenApp}&UserID=$otherID&otherRole=2${welcomeMessage.isEmpty ? "" : "&welcomeMessage=$welcomeMessage"}";
  }

  @override
  void onReady() {}
  @override
  void onClose() {}
}
