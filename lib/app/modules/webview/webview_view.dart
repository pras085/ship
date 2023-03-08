import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/webview/webview_controller.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends GetView<WebviewController> {
  WebViewController webController;
  var onLoad = false.obs;

  @override
  Widget build(BuildContext context) {
    // List<String> arguments = Get.arguments;
    return WillPopScope(
      onWillPop: () => backOrPop(context),
      child: Scaffold(
        appBar: AppBar(
            // title: Text(arguments[0]),
            title: CustomText('Test Webview'),
            actions: <Widget>[
              Obx(
                () => Opacity(
                  opacity: onLoad.value ? 1.0 : 0.0,
                  child: Container(
                    width: 60.0,
                    height: 20.0,
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              )
            ]),
        body: SafeArea(
            child: WebView(
                onPageStarted: (string) {
                  onLoad.value = true;
                },
                onPageFinished: (string) {
                  onLoad.value = false;
                },
                onWebViewCreated: (WebViewController webViewController) {
                  webController = webViewController;
                },
                // initialUrl: arguments[1]
                initialUrl: "https://www.google.com")),
      ),
    );
  }

  Future<bool> backOrPop(BuildContext context) async {
    print(await webController.currentUrl());
    print(await webController.canGoBack());
    if (await webController.canGoBack()) {
      //   print("onwill goback");
      webController.goBack();
      return Future.value(false);
    } else {
      //   Scaffold.of(context).showSnackBar(
      //     const SnackBar(content: Text("No back history item")),
      //   );
      return Future.value(true);
    }
  }
}
