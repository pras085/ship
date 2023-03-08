import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/chat/chat_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canGoBack = await controller.webViewController.canGoBack();
        return Future.value(!canGoBack);
      },
      child: Scaffold(
        body: SafeArea(
            child: Obx(
          () => Stack(
            children: [
              WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (string) {
                  controller.onLoad.value = true;
                },
                onPageFinished: (string) {
                  controller.onLoad.value = false;
                },
                onWebViewCreated: (WebViewController webViewController) {
                  controller.webViewController = webViewController;
                },
                initialUrl: controller.url,
                // initialUrl: "https://qc.assetlogistik.com/try-chat-web-view/?meId=2&meName=James&meEmail=jamesac@gmail.com&mePhotoUrl=https://spesialis1.orthopaedi.fk.unair.ac.id/wp-content/uploads/2021/02/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg&meRole=shipper&otherId=1&otherName=Joey&otherEmail=joeycc@gmail.com&otherPhotoUrl=https://st2.depositphotos.com/1104517/11967/v/950/depositphotos_119675554-stock-illustration-male-avatar-profile-picture-vector.jpg&otherRole=shipper",
                // initialUrl: "https://qc.assetlogistik.com/try-chat-web-view/?meId=1&meName=Joey&meEmail=joeycc@gmail.com&mePhotoUrl=https://st2.depositphotos.com/1104517/11967/v/950/depositphotos_119675554-stock-illustration-male-avatar-profile-picture-vector.jpg&meRole=shipper&otherId=2&otherName=James&otherEmail=jamesac@gmail.com&otherPhotoUrl=https://spesialis1.orthopaedi.fk.unair.ac.id/wp-content/uploads/2021/02/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg&otherRole=shipper"
              ),
              !controller.onLoad.value
                  ? SizedBox.shrink()
                  : Expanded(
                      child: Container(
                          color: Colors.black.withAlpha(125),
                          child: Center(
                            child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10),
                                  color: Colors.grey,
                                ),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )),
                          )),
                    )
            ],
          ),
        )),
      ),
    );
  }
}
