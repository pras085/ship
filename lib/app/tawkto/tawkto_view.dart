import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TawktoView extends GetView{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tes"),
      ),
      body: SafeArea(
        child: 
        // Tawk(
        //     directChatLink: 'https://tawk.to/chat/60585510f7ce18270932864b/1f1cgoiiq',
        //     visitor: TawkVisitor(
        //         name: 'Ayoub AMINE',
        //         email: 'ayoubamine2a@gmail.com',
        //     ),
        // ),
        Stack(
          children: [
            Positioned.fill(
              child: WebView(
                initialUrl: "https://qc.assetlogistik.com/try-chat-web-view",
                // initialUrl: "https://www.google.com",
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (_) {
                  print("START");
                },
                onPageFinished: (finish) {
                  print("FINSIH");
                  controller.isLoading.value = false;
                },
              ),
            ),
          ],
        )
      ),
    );
  }

}