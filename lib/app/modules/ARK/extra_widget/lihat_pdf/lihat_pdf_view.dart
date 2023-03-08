import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/lihat_pdf/lihat_pdf_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LihatPDF extends GetView<LihatPDFController> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  WebViewController webController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          appBar: AppBar(
             toolbarHeight: GlobalVariable.ratioWidth(Get.context) * 56,
            leadingWidth: GlobalVariable.ratioWidth(Get.context) * (24 + 16),
            leading: Container(
                padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                ),
                child: GestureDetector(
                    onTap: () {
                      onWillPop(context);
                    },
                    child: SvgPicture.asset(
                        GlobalVariable.imagePath + "ic_back_button.svg",
                        color: GlobalVariable.tabDetailAcessoriesMainColor))),
            titleSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
            title: CustomText(controller.title.value.tr,
                height: 1.2,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w700,
                color: GlobalVariable.tabDetailAcessoriesMainColor,
                fontSize: 14),
            centerTitle: true,
          ),
          body: Obx(
            () => SafeArea(
              // KALAU DIA DARI INTERNET MENGGUNAKAN WEBVIEW SAJA BIAR TIDAK DOWNLOAD
              child: controller.url.value.split(":").first == "https"
                  ? WebView(
                      onPageStarted: (string) {
                        controller.onLoad.value = true;
                      },
                      onPageFinished: (string) {
                        controller.onLoad.value = false;
                      },
                      onWebViewCreated: (WebViewController webViewController) {
                        webController = webViewController;
                      },
                      // initialUrl: arguments[1]
                      initialUrl:
                          'https://docs.google.com/gview?embedded==true&url=' +
                              controller.url.value)
                  : FileReaderView(
                      filePath: controller.url.value,
                      loadingWidget: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          ),
        ));
  }

  Future<bool> onWillPop(BuildContext context) async {
    Get.back();
  }
}
