import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/webview/webview_view.dart';
import 'package:muatmuat/app/modules/webview_tac_pap/webview_tac_pap_controller.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewTacPapView extends GetView<WebviewTacPapController> {
  WebViewController webController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: CustomText('MuatMuat'), centerTitle: true, actions: <Widget>[
        Obx(
          () => Opacity(
            opacity: controller.onLoad.value ? 1.0 : 0.0,
            child: Container(
              width: 40.0,
              height: 20.0,
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        )
      ]),
      body: WebView(
          onPageStarted: (string) {
            controller.setOnLoad(true);
          },
          onPageFinished: (string) {
            controller.setOnLoad(false);
          },
          onWebViewCreated: (WebViewController webViewController) {
            webController = webViewController;
          },
          initialUrl: controller.url.value),
    );
  }
}
