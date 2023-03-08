import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/demo/lihat_video/lihat_video_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_bottom_demo.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:validators/validators.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

class LihatVideoView extends GetView<LihatVideoController> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  WebViewController webController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: SafeArea(
            child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      GlobalVariable.ratioWidth(Get.context) * 56),
                  child: Container(
                    alignment: Alignment.center,
                    height: GlobalVariable.ratioWidth(Get.context) * 56,
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                        vertical: GlobalVariable.ratioWidth(Get.context) * 16),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(GlobalVariable.urlImageNavbar),
                            fit: BoxFit.fill),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(ListColor.colorLightGrey)
                                .withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                        color: Colors.white),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "ic_back_button.svg",
                                    color: GlobalVariable
                                        .tabDetailAcessoriesMainColor,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24))),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        Container(
                          child: Obx(() => CustomText(
                              controller.title.value, //Persyaratan dan Dokumen
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: ButtonBottomDemoWidget(
                  onTap: controller.sisi == 'TRANSPORTER' &&
                          controller.tab == 'TRANSPORTER'
                      ? () async {
                          showDialog(
                              context: Get.context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return WillPopScope(
                                    onWillPop: () {},
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              });
                          var data =
                              await GlobalVariable.getStatusUser(Get.context);
                          Get.back();
                          if (data['UserType'] == 0) {
                            controller.popUpIndividu(
                                controller.modul, controller.tab);
                          } else if (data[
                                  'TransporterHasPendingVerification'] ==
                              1) {
                            controller.popUpPendingVerifikasiTransporter();
                          } else if (data['TransporterIsIntermediat'] == 1) {
                            controller.popUpBergabungMenjadiTransporter(
                                controller.modul);
                          } else if (data['TransporterIsVerifBF'] == 1 &&
                              data['TransporterIsVerifTM'] == 0) {
                            controller.popUpInternal();
                          } else {
                            controller.popUpPemberitahuan();
                          }
                        }
                      : controller.sisi == 'TRANSPORTER' &&
                              controller.tab == 'SHIPPER'
                          ? () {
                              OpenAppstore.launch(
                                  androidAppId: "com.miHoYo.GenshinImpact",
                                  iOSAppId: "");
                            }
                          : controller.sisi == 'SHIPPER' &&
                                  controller.tab == 'SHIPPER'
                              ? () async {
                                  {
                                    showDialog(
                                        context: Get.context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return WillPopScope(
                                              onWillPop: () {},
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()));
                                        });
                                    var data =
                                        await GlobalVariable.getStatusUser(
                                            Get.context);
                                    Get.back();
                                    if (data['UserType'] == 0) {
                                      controller.popUpIndividu(
                                          controller.modul, controller.tab);
                                    } else if (data[
                                            'ShipperHasPendingVerification'] ==
                                        1) {
                                      controller
                                          .popUpPendingVerifikasiShipper();
                                    } else if (data['ShipperIsIntermediat'] ==
                                        1) {
                                      controller.popUpBergabungMenjadiShipper(
                                          controller.modul);
                                    } else if (data['ShipperIsVerifBF'] == 1 &&
                                        data['ShipperIsVerifTM'] == 0) {
                                      controller.popUpInternal();
                                    } else {
                                      controller.popUpPemberitahuan();
                                    }
                                  }
                                }
                              : () {
                                  OpenAppstore.launch(
                                      androidAppId: "com.miHoYo.GenshinImpact",
                                      iOSAppId: "");
                                },
                  modul: controller.modul,
                  sisi: controller.sisi,
                  tab: controller.tab,
                ),
                body: Obx(() => SafeArea(
                        child: Container(
                            child: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                          //VIDEO
                          Stack(children: [
                            Positioned(
                              child: Align(
                                alignment: Alignment.center,
                                child: !controller.loadingVideoUtama.value
                                    ? GestureDetector(
                                        onTap: () {
                                          // controller.showController();

                                          // print('showControl : ' +
                                          //     controller.showControl.value.toString());
                                          // print('videoPlaying : ' +
                                          //     controller.videoPlaying.value.toString());
                                          // print('Maximize : ' +
                                          //     controller.maximize.value.toString());
                                        },
                                        child: Container(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              174,
                                          color: Colors.black,
                                          padding: EdgeInsets.only(
                                              bottom: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  10),
                                          child: controller.playerWidget,
                                        ))
                                    : Container(
                                        //color: Colors.black,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            174,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())),
                              ),
                            ),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        color: Color(
                                            ListColor.colorBackgroundTender),
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            10,
                                        width: double.infinity,
                                        child: CustomText(""))))
                          ]),

                          //VIDEO
                          Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    CustomText(
                                      controller.title.value,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    CustomText(controller.note.value,
                                        fontWeight: FontWeight.w500,
                                        color: Color(ListColor.colorLightGrey4),
                                        fontSize: 12,
                                        height: 1.5),
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24),
                                    controller.lineDividerWidget(),
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24),
                                  ])),
                          controller.demoLainnyaWidget(),
                          (controller.jenisTampilan.value == 'ANDROID'
                              ? SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          80)
                              : SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          60)),
                        ]))))))));
  }

  Future<bool> onWillPop(BuildContext context) async {
    Get.back();
  }
}
