import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/transporter/transporter_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:share/share.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:muatmuat/global_variable.dart';

class TransporterView extends GetView<TransporterController> {
  final List<String> _tabs = <String>["Tab 1", "Tab 2"];
  // final double _widthHeightAvatar = 67;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: controller.change);
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: _AppBar(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
            listOption: [
              GestureDetector(
                onTap: () {
                  // controller.shareTransporter();
                  Share.share("View my website in https://assetlogistik.com");
                },
                child: SvgPicture.asset(
                  "assets/share_icon.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                    onTap: () {
                      controller.tapDownload = true;
                      controller.cekDownloadFile();
                    },
                    child: SvgPicture.asset(
                      "assets/ic_download.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    )),
              )
            ],
          ),

          // AppBar(
          //   leading: Center(
          //     child: ClipOval(
          //       child: Material(
          //           shape: CircleBorder(),
          //           color: Colors.white,
          //           child: InkWell(
          //               onTap: () {
          //                 Get.back();
          //               },
          //               child: Container(
          //                   width: 30,
          //                   height: 30,
          //                   child: Center(
          //                       child: Icon(
          //                     Icons.arrow_back_ios_rounded,
          //                     size: 30 * 0.7,
          //                     color: Color(ListColor.color4),
          //                   ))))),
          //     ),
          //   ),
          //   elevation: 0,
          //   actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 20),
          //   child: GestureDetector(
          //       onTap: () {
          //         controller.shareTransporter();
          //       },
          //       child: Icon(Icons.share_outlined, size: 20)),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(right: 20),
          //   child: GestureDetector(
          //       onTap: () {
          //         controller.tapDownload = true;
          //         controller.downloadFile();
          //       },
          //       child: SvgPicture.asset(
          //         "assets/ic_download.svg",
          //         width: 20,
          //         height: 20,
          //       )),
          // )
          //   ],
          // ),

          body: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                !controller.show.value
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        width: Get.context.mediaQuery.size.width,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator()),
                            ),
                            CustomText("Loading"),
                          ],
                        ))
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 2.0,
                                      child: Container(
                                        color: Color(ListColor.colorBlue),
                                      ),
                                    ),
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20),
                                            topRight: Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20)),
                                        child: Container(
                                          child: CarouselSlider(
                                            items:
                                                controller.imageSliders.value,
                                            options: CarouselOptions(
                                                autoPlay: true,
                                                autoPlayAnimationDuration:
                                                    Duration(seconds: 2),
                                                autoPlayInterval:
                                                    Duration(seconds: 3),
                                                enlargeCenterPage: false,
                                                pageSnapping: true,
                                                viewportFraction: 1,
                                                aspectRatio: 2.0,
                                                onPageChanged: (index, reason) {
                                                  controller.indexImageSlider
                                                      .value = index;
                                                }),
                                          ),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              10),
                                      child: Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    controller.imageSliders
                                                        .value.length;
                                                i++)
                                              i ==
                                                      controller
                                                          .indexImageSlider
                                                          .value
                                                  ? controller
                                                      .buildPageIndicator(true)
                                                  : controller
                                                      .buildPageIndicator(
                                                          false),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.all(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          22),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      _circleAvatar(
                                          controller.transporter.avatar),
                                      Expanded(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              controller.transporter.nama,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                          !controller.transporter.isGold
                                              ? SizedBox.shrink()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          7),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                            "assets/ic_gold.png"),
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            18,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                6,
                                                            right: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                10),
                                                        child: CustomText(
                                                            'Gold Transporter',
                                                            color: Color(
                                                                0xFFD49A29),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .showGoldInfo();
                                                          },
                                                          child: Icon(
                                                              Icons
                                                                  .info_outline,
                                                              color: Color(
                                                                  ListColor
                                                                      .colorBlue),
                                                              size: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  16))
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (controller.position.value != 0) {
                                            controller.position.value = 0;
                                          }
                                        },
                                        padding: EdgeInsets.all(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6),
                                        child: Obx(
                                          () => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        24,
                                                child: SvgPicture.asset(
                                                  "assets/ic_contact.svg",
                                                  color: controller
                                                              .position.value ==
                                                          0
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Color(
                                                          ListColor.colorGrey3),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          6),
                                                  child: CustomText(
                                                      "DetailTransporterLabelKontak"
                                                          .tr,
                                                      fontWeight: controller
                                                                  .position
                                                                  .value ==
                                                              0
                                                          ? FontWeight.w700
                                                          : FontWeight.w600,
                                                      color: controller.position
                                                                  .value ==
                                                              0
                                                          ? Color(
                                                              ListColor.colorBlue)
                                                          : Color(ListColor.colorGrey3))),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: controller
                                                              .position.value ==
                                                          0
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              10)),
                                                ),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        32,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (controller.position.value != 1) {
                                            controller.position.value = 1;
                                            controller.getProfile();
                                          }
                                        },
                                        padding: EdgeInsets.all(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6),
                                        child: Obx(
                                          () => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        24,
                                                child: SvgPicture.asset(
                                                  "assets/ic_profil.svg",
                                                  color: controller
                                                              .position.value ==
                                                          1
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Color(
                                                          ListColor.colorGrey3),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          6),
                                                  child: CustomText(
                                                      "DetailTransporterLabelProfil"
                                                          .tr,
                                                      fontWeight: controller
                                                                  .position
                                                                  .value ==
                                                              1
                                                          ? FontWeight.w700
                                                          : FontWeight.w600,
                                                      color: controller.position
                                                                  .value ==
                                                              1
                                                          ? Color(
                                                              ListColor.colorBlue)
                                                          : Color(ListColor.colorGrey3))),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: controller
                                                              .position.value ==
                                                          1
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              10)),
                                                ),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        32,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (controller.position.value != 2) {
                                            controller.position.value = 2;
                                            controller.getThumbnailVideo();
                                          }
                                        },
                                        padding: EdgeInsets.all(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6),
                                        child: Obx(
                                          () => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        24,
                                                child: SvgPicture.asset(
                                                  "assets/ic_video.svg",
                                                  color: controller
                                                              .position.value ==
                                                          2
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Color(
                                                          ListColor.colorGrey3),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          6),
                                                  child: CustomText(
                                                      "DetailTransporterLabelVideo"
                                                          .tr,
                                                      fontWeight: controller
                                                                  .position
                                                                  .value ==
                                                              2
                                                          ? FontWeight.w700
                                                          : FontWeight.w600,
                                                      color: controller.position
                                                                  .value ==
                                                              2
                                                          ? Color(
                                                              ListColor.colorBlue)
                                                          : Color(ListColor.colorGrey3))),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: controller
                                                              .position.value ==
                                                          2
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              10)),
                                                ),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        32,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (controller.position.value != 3) {
                                            controller.position.value = 3;
                                            controller.getTestimony();
                                          }
                                        },
                                        padding: EdgeInsets.all(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6),
                                        child: Obx(
                                          () => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        24,
                                                child: SvgPicture.asset(
                                                  "assets/ic_testimony.svg",
                                                  color: controller
                                                              .position.value ==
                                                          3
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Color(
                                                          ListColor.colorGrey3),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          6),
                                                  child: CustomText(
                                                      "DetailTransporterLabelTestimony"
                                                          .tr,
                                                      fontWeight: controller
                                                                  .position
                                                                  .value ==
                                                              3
                                                          ? FontWeight.w700
                                                          : FontWeight.w600,
                                                      color: controller.position
                                                                  .value ==
                                                              3
                                                          ? Color(
                                                              ListColor.colorBlue)
                                                          : Color(ListColor.colorGrey3))),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: controller
                                                              .position.value ==
                                                          3
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              10)),
                                                ),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        32,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        2,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.show.value &&
                                        ((controller.position.value == 1 &&
                                                controller.loadProfile.value) ||
                                            (controller.position.value == 2 &&
                                                (controller.loadVideo.value ||
                                                    controller.thumbnailVideo
                                                            .value.length !=
                                                        controller.videoList
                                                            .value.length)) ||
                                            (controller.position.value == 3 &&
                                                controller
                                                    .loadTestimony.value)),
                                    child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 40),
                                        width:
                                            Get.context.mediaQuery.size.width,
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              child: SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                            CustomText("Loading"),
                                          ],
                                        )),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.show.value &&
                                        controller.position.value == 0,
                                    child: contactView(),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.show.value &&
                                        controller.position.value == 1 &&
                                        !controller.loadProfile.value,
                                    child: profileView(),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.show.value &&
                                        controller.position.value == 2 &&
                                        // !controller.loadVideo.value,
                                        controller
                                                .thumbnailVideo.value.length ==
                                            controller.videoList.value.length,
                                    child: controller.videoList.length == 0
                                        ? Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(30),
                                            child: CustomText("Empty"))
                                        : videoView(),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.show.value &&
                                        controller.position.value == 3 &&
                                        !controller.loadTestimony.value,
                                    child: controller.listTestimony.length == 0
                                        ? Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(30),
                                            child: CustomText(
                                                "DetailTransporterLabelNoTestimony"
                                                    .tr))
                                        : testimonyView(),
                                  ),
                                ),
                              ],
                            ),
                          )),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              // horizontal:
                              //     GlobalVariable.ratioWidth(Get.context) *
                              //         14
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x54000000),
                                  spreadRadius: 2,
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: _button(
                                      marginLeft: 16,
                                      customWidget: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                right:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            child: Icon(
                                              controller.iconButtonMitra.value,
                                              color: Color(ListColor.color4),
                                              size: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18,
                                            ),
                                          ),
                                          // Container(
                                          //   alignment: Alignment.center,
                                          //     margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(
                                          //         Get.context) *8),
                                          //     child: SvgPicture.asset(
                                          //       controller.iconButtonMitra.value,
                                          //       color:
                                          //           Color(ListColor.colorBlue),
                                          //       width:
                                          //           GlobalVariable.ratioWidth(
                                          //                   Get.context) *
                                          //               16,
                                          //       height:
                                          //           GlobalVariable.ratioWidth(
                                          //                   Get.context) *
                                          //               16,
                                          //     )),
                                          CustomText(
                                            controller.txtButtonMitra.value,
                                            fontSize: 12,
                                            color: Color(ListColor.colorBlue),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        controller.onPressButtonMitra();
                                      }),
                                ),

                                // Expanded(
                                //   child:
                                // FlatButton(
                                //     padding: EdgeInsets.symmetric(
                                //         vertical: GlobalVariable.ratioWidth(
                                //                 Get.context) *
                                //             6,
                                //         horizontal: GlobalVariable.ratioWidth(
                                //                 Get.context) *
                                //             23),
                                //     onPressed: () async {
                                //       controller.onPressButtonMitra();
                                //     },
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.all(
                                //             Radius.circular(40)),
                                //         side: BorderSide(
                                //             color: Color(ListColor.color4),
                                //             width: 2)),
                                //     child: Obx(
                                //       () => Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: [
                                //           Icon(
                                // controller.iconButtonMitra.value,
                                //             color: Color(ListColor.color4),
                                //             size: GlobalVariable.ratioWidth(
                                //                     Get.context) *
                                //                 18,
                                //           ),
                                //           Expanded(
                                //             child: Obx(
                                //               () => CustomText(
                                // controller
                                //     .txtButtonMitra.value,
                                //                   textAlign: TextAlign.center,
                                //                   fontSize: 12,
                                //                   color: Color(
                                //                       ListColor.color4)),
                                //             ),
                                //           )
                                //         ],
                                //       ),
                                //     )),
                                // ),
                                Container(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                Expanded(
                                  child: _button(
                                      backgroundColor:
                                          Color(ListColor.colorBlue),
                                      marginRight: 16,
                                      customWidget: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                right:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            child: Icon(Icons.call,
                                                color: Colors.white,
                                                size: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    18),
                                          ),

                                          // Container(
                                          //   alignment: Alignment.center,
                                          //     margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(
                                          //         Get.context) *8),
                                          //     child: SvgPicture.asset(
                                          //       "assets/balas_mitra.svg",
                                          //       color:
                                          //           Color(ListColor.colorWhite),
                                          //       width:
                                          //           GlobalVariable.ratioWidth(
                                          //                   Get.context) *
                                          //               16,
                                          //       height:
                                          //           GlobalVariable.ratioWidth(
                                          //                   Get.context) *
                                          //               16,
                                          //     )),
                                          CustomText(
                                            "DetailTransporterLabelCall".tr,
                                            fontSize: 12,
                                            color: Color(ListColor.colorWhite),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        controller.contactPartner();
                                      }),
                                ),

                                // Expanded(
                                //   child: FlatButton(
                                //     padding: EdgeInsets.symmetric(
                                //         vertical: GlobalVariable.ratioWidth(
                                //                 Get.context) *
                                //             6,
                                //         horizontal: GlobalVariable.ratioWidth(
                                //                 Get.context) *
                                //             23),
                                //     color: Color(ListColor.color4),
                                //     onPressed: () {
                                //       controller.contactPartner();
                                //     },
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.all(
                                //             Radius.circular(40))),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Icon(Icons.call,
                                //             color: Colors.white,
                                //             size: GlobalVariable.ratioWidth(
                                //                     Get.context) *
                                //                 18),
                                //         Expanded(
                                //           child: CustomText(
                                //               "DetailTransporterLabelCall".tr,
                                //               textAlign: TextAlign.center,
                                //               fontSize: 12,
                                //               color: Colors.white),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                controller.onDownloading.value == false
                    ? SizedBox.shrink()
                    : Container(
                        color: Colors.black.withOpacity(0.3),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(
                                        backgroundColor: Colors.grey,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(ListColor.color4)),
                                        value: /* controller.processing.value
                                            ? */ null
                                            /* : controller.onProgress.value */),
                                    Container(height: 10),
                                    CustomText(/* controller.processing.value
                                        ?  */"Processing"
                                        /* : "Downloading ${controller.onProgress.value * 100} %" */),
                                  ],
                                )),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contactView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: GlobalVariable.ratioWidth(Get.context) * 18,
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              bottom: GlobalVariable.ratioWidth(Get.context) * 12),
          child: CustomText("Kontak Perusahaan".tr,
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Container(
          margin: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              right: GlobalVariable.ratioWidth(Get.context) * 16,
              bottom: GlobalVariable.ratioWidth(Get.context) * 24),
          padding: EdgeInsets.only(
              top: GlobalVariable.ratioWidth(Get.context) * 14,
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              right: GlobalVariable.ratioWidth(Get.context) * 16,
              bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
              border: Border.all(
                  color: Color(ListColor.colorLightGrey5),
                  width: GlobalVariable.ratioWidth(Get.context) * 0.3)),
          child: Obx(
            () => (controller.contacts.value != null &&
                    controller.contacts.value.values.length != 0)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 12,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("DetailTransporterLabelAlamat".tr,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(ListColor.colorGrey3)),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: CustomText(
                                  controller.contacts["Address"],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorDarkGrey4),
                                ),
                              ),
                            ],
                          )),
                      Container(
                          color: Color(ListColor.colorStroke),
                          height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("DetailTransporterLabelProvinsi".tr,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(ListColor.colorGrey3)),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child:
                                    CustomText(controller.contacts["Province"],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(
                                          ListColor.colorDarkGrey4,
                                        )),
                              ),
                            ],
                          )),
                      Container(
                          color: Color(ListColor.colorStroke), height: 0.5),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("DetailTransporterLabelKota".tr,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(ListColor.colorGrey3)),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: CustomText(controller.contacts["City"],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorDarkGrey4)),
                              ),
                            ],
                          )),
                      Container(
                          color: Color(ListColor.colorStroke),
                          height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("DetailTransporterLabelTelpDarurat".tr,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(ListColor.colorGrey3)),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: CustomText(controller.contacts["Phone"],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorDarkGrey4)),
                              ),
                            ],
                          )),
                      Container(
                          color: Color(ListColor.colorStroke),
                          height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("DetailTransporterLabelWADarurat".tr,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(ListColor.colorGrey3)),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: CustomText(
                                    controller.contacts["PhoneWA"],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorDarkGrey4)),
                              ),
                            ],
                          )),
                      // Container(
                      //     color: Color(ListColor.colorStroke),
                      //     height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                      Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 18,
                          margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 4),
                              color: Color(ListColor.colorGrey6)),
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CustomText("DetailTransporterLabelDaftarPIC".tr,
                                  fontWeight: FontWeight.w700, fontSize: 10),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/ic_info_pic_transporter.png"),
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          22,
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          22)
                                  // SvgPicture.asset(
                                  //   "assets/ic_info_pic_transporter.svg",
                                  //   height:
                                  //       GlobalVariable.ratioWidth(Get.context) *
                                  //           11,
                                  // )
                                  )
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 12,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      alignment: Alignment.center,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14,
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14,
                                      child: SvgPicture.asset(
                                        "assets/ic_profile_transporter.svg",
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                      )),
                                  // Icon(Icons.person_outline,
                                  //     color: Color(ListColor.colorGrey3),
                                  //     size: GlobalVariable.ratioWidth(
                                  //             Get.context) *
                                  //         14),
                                  Container(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  CustomText(
                                    "PIC 1",
                                    color: Color(ListColor.colorGrey3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              )),
                              Container(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          25),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => CustomText(
                                        (controller.contacts["NamePic1"]
                                                .toString()
                                                .isEmpty)
                                            ? "-"
                                            : controller.contacts["NamePic1"]
                                                .toString(),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorBlack))),
                                    Container(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16),
                                    Obx(
                                      () => Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Obx(() => CustomText(
                                                (controller
                                                        .contacts["ContactPic1"]
                                                        .toString()
                                                        .isEmpty)
                                                    ? "-"
                                                    : controller
                                                        .contacts["ContactPic1"]
                                                        .toString(),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(
                                                    ListColor.colorBlack))),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16),
                                              child: Container(
                                                child: SvgPicture.asset(
                                                  "assets/ic_phone.svg",
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          22,
                                                ),
                                              )
                                              // Icon(
                                              //   Icons.call,
                                              //   color: Color(0xFF25D366),
                                              //   size: 16,
                                              // )
                                              ),
                                          (controller.contacts["IsWa1"]
                                                  .toString()
                                                  .isEmpty)
                                              ? SizedBox.shrink()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          18),
                                                  child: Container(
                                                      child: Image(
                                                          image: AssetImage(
                                                              "assets/ic_whatsapp.png"),
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              22,
                                                          width: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              22)
                                                      // SvgPicture.asset(
                                                      //     "assets/ic_whatsapp.svg"),
                                                      // width: GlobalVariable
                                                      //         .ratioWidth(
                                                      //             Get.context) *
                                                      //     22,
                                                      // height: GlobalVariable
                                                      //         .ratioWidth(
                                                      //             Get.context) *
                                                      //     22,
                                                      ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Container(
                          color: Color(ListColor.colorStroke),
                          height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      alignment: Alignment.center,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14,
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14,
                                      child: SvgPicture.asset(
                                        "assets/ic_profile_transporter.svg",
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                      )),
                                  Container(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  CustomText(
                                    "PIC 2",
                                    color: Color(ListColor.colorGrey3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              )),
                              Container(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          25),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => CustomText(
                                        (controller.contacts["NamePic2"]
                                                .toString()
                                                .isEmpty)
                                            ? "-"
                                            : controller.contacts["NamePic2"]
                                                .toString(),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorBlack))),
                                    Container(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16),
                                    Obx(
                                      () => Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Obx(() => CustomText(
                                                (controller
                                                        .contacts["ContactPic2"]
                                                        .toString()
                                                        .isEmpty)
                                                    ? "-"
                                                    : controller
                                                        .contacts["ContactPic2"]
                                                        .toString(),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(
                                                    ListColor.colorBlack))),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16),
                                              child: Container(
                                                child: SvgPicture.asset(
                                                  "assets/ic_phone.svg",
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          22,
                                                ),
                                              )),
                                          (controller.contacts["IsWa2"]
                                                  .toString()
                                                  .isEmpty)
                                              ? SizedBox.shrink()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          18),
                                                  child: Container(
                                                      child: Image(
                                                          image: AssetImage(
                                                              "assets/ic_whatsapp.png"),
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              22,
                                                          width: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              22)
                                                      //   SvgPicture.asset(
                                                      //       "assets/ic_whatsapp.svg"),
                                                      //   width: GlobalVariable
                                                      //           .ratioWidth(
                                                      //               Get.context) *
                                                      //       22,
                                                      //   height: GlobalVariable
                                                      //           .ratioWidth(
                                                      //               Get.context) *
                                                      //       22,
                                                      ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Container(
                          color: Color(ListColor.colorStroke),
                          height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                      Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      alignment: Alignment.center,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14,
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14,
                                      child: SvgPicture.asset(
                                        "assets/ic_profile_transporter.svg",
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                      )),
                                  Container(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  CustomText(
                                    "PIC 3",
                                    color: Color(ListColor.colorGrey3),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              )),
                              Container(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          25),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => CustomText(
                                        (controller.contacts["NamePic3"]
                                                .toString()
                                                .isEmpty)
                                            ? "-"
                                            : controller.contacts["NamePic3"]
                                                .toString(),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorBlack))),
                                    Container(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16),
                                    Obx(
                                      () => Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Obx(() => CustomText(
                                                (controller
                                                        .contacts["ContactPic3"]
                                                        .toString()
                                                        .isEmpty)
                                                    ? "-"
                                                    : controller
                                                        .contacts["ContactPic3"]
                                                        .toString(),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(
                                                    ListColor.colorBlack))),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16),
                                              child: Container(
                                                child: SvgPicture.asset(
                                                  "assets/ic_phone.svg",
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          22,
                                                ),
                                              )),
                                          (controller.contacts["IsWa3"]
                                                  .toString()
                                                  .isEmpty)
                                              ? SizedBox.shrink()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          18),
                                                  child: Container(
                                                      child: Image(
                                                          image: AssetImage(
                                                              "assets/ic_whatsapp.png"),
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              22,
                                                          width: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              22)
                                                      // SvgPicture.asset(
                                                      //     "assets/ic_whatsapp.svg"),
                                                      // width: GlobalVariable
                                                      //         .ratioWidth(
                                                      //             Get.context) *
                                                      //     22,
                                                      // height: GlobalVariable
                                                      //         .ratioWidth(
                                                      //             Get.context) *
                                                      //     22,
                                                      ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Container(
                          color: Color(ListColor.colorStroke),
                          height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("Website",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(ListColor.colorGrey3)),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: CustomText(
                                  controller.contacts["Website"] ?? "-",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(
                                    ListColor.colorDarkGrey4,
                                  ),
                                ),
                              )
                            ],
                          )),
                      Container(
                          color: Color(ListColor.colorStroke),
                          height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("Email",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(ListColor.colorGrey3)),
                              Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: CustomText(
                                  controller.contacts["Email"],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(
                                    ListColor.colorDarkGrey4,
                                  ),
                                ),
                              )
                            ],
                          )),
                      Container(
                          color: Color(ListColor.colorStroke),
                          height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                      controller.transporter != null
                          ? ((controller.transporter.latitude != "" ||
                                  controller.transporter.longitude != "")
                              ? Stack(children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            18),
                                    width:
                                        MediaQuery.of(Get.context).size.width,
                                    height: 200,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    6)),
                                        child: buildMap()),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                          onTap: () {
                                            controller.onClickMap();
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  36,
                                              decoration: BoxDecoration(
                                                color: Color(ListColor.color4),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            6),
                                                    bottomRight: Radius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            6)),
                                              ),
                                              alignment: Alignment.center,
                                              child: CustomText(
                                                "Lihat Peta",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ))),
                                    ),
                                  ),
                                ])
                              : SizedBox.shrink())
                          : SizedBox.shrink()
                    ],
                  )
                : Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 50,
                    alignment: Alignment.center,
                    child: CustomText("DetailTransporterLabelKontakKosong".tr)),
          ),
        ),
      ],
    );
  }

  Widget profileView() {
    return Container(
      margin: EdgeInsets.only(
          top: GlobalVariable.ratioWidth(Get.context) * 18,
          left: GlobalVariable.ratioWidth(Get.context) * 16,
          right: GlobalVariable.ratioWidth(Get.context) * 16,
          bottom: GlobalVariable.ratioWidth(Get.context) * 25),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText("DetailTransporterLabelProfilPerusahaan".tr,
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            Container(height: GlobalVariable.ratioWidth(Get.context) * 12),
            Container(
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
                  border: Border.all(
                      color: Color(ListColor.colorLightGrey5),
                      width: GlobalVariable.ratioWidth(Get.context) * 0.3)),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 7,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 9),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText("DetailTransporterLabelAreaLayanan".tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorGrey3)),
                            Container(
                              margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      4),
                              child: CustomText(
                                controller.profil["AreaLayanan"] == ""
                                    ? "-"
                                    : controller.profil["AreaLayanan"],
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(ListColor.colorDarkGrey4),
                              ),
                            ),
                          ],
                        )),
                    Container(
                        color: Color(ListColor.colorStroke),
                        height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                    Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 7,
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 9),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText("DetailTransporterLabelJumlahTruk".tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorGrey3)),
                            Container(
                              margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      4),
                              child: CustomText(
                                  controller.profil["QtyTruck"].toString(),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorDarkGrey4)),
                            ),
                          ],
                        )),
                    Container(
                        color: Color(ListColor.colorStroke),
                        height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                    Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 7,
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 9),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText("DetailTransporterLabelCustomer".tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorGrey3)),
                            Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: Html(
                                    data: controller.profil["Customer"] == ""
                                        ? "-"
                                        : controller.profil["Customer"],
                                    style: {
                                      "body": Style(
                                          color:
                                              Color(ListColor.colorDarkGrey4),
                                          fontSize: FontSize(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14),
                                          margin: EdgeInsets.zero,
                                          padding: EdgeInsets.zero,
                                          fontWeight: FontWeight.w600)
                                    })
                                // Text(controller.profil["Customer"],
                                //     style:
                                //         TextStyle(fontWeight: FontWeight.w600)),
                                ),
                          ],
                        )),
                    Container(
                        color: Color(ListColor.colorStroke),
                        height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                    Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 7,
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 9),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText("DetailTransporterLabelPortofolio".tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorGrey3)),
                            Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                child: Html(
                                    data: controller.profil["Portofolio"] == ""
                                        ? "-"
                                        : controller.profil["Portofolio"],
                                    style: {
                                      "body": Style(
                                          color:
                                              Color(ListColor.colorDarkGrey4),
                                          fontSize: FontSize(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14),
                                          margin: EdgeInsets.zero,
                                          padding: EdgeInsets.zero,
                                          fontWeight: FontWeight.w600)
                                    })
                                // Text(controller.profil["Portofolio"],
                                //     style:
                                //         TextStyle(fontWeight: FontWeight.w600)),
                                ),
                          ],
                        )),
                    Container(
                        color: Color(ListColor.colorStroke),
                        height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      7,
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      12,
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          9),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      "DetailTransporterLabelTahunMulaiUsaha"
                                          .tr,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.colorGrey3)),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4),
                                    child: CustomText(
                                      controller.profil["Establishment"],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor.colorDarkGrey4),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      7,
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      12,
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          9),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      "DetailTransporterLabelTahunBerdiri".tr,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.colorGrey3)),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4),
                                    child: CustomText(
                                        controller.profil["Founded"],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorDarkGrey4)),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    Container(
                        color: Color(ListColor.colorStroke),
                        height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                    Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 7,
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 9),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText("DetailTransporterLabelKeunggulan".tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorGrey3)),
                            Container(
                              margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      4),
                              child: CustomText(controller.profil["Advantage"],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorDarkGrey4)),
                            ),
                          ],
                        )),
                    Container(
                        color: Color(ListColor.colorStroke),
                        height: GlobalVariable.ratioWidth(Get.context) * 0.5),
                    Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 7,
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 9),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                "DetailTransporterLabelLayananTambahan".tr,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorGrey3)),
                            Container(
                              margin: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      4),
                              child: CustomText(controller.profil["Service"],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorDarkGrey4)),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            controller.kendaraan.length == 0
                ? SizedBox.shrink()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 24),
                      CustomText("DetailTransporterLabelInformasiKendaraan".tr,
                          fontSize: 14, fontWeight: FontWeight.w600),
                      for (int x = 0; x < controller.kendaraan.length; x++)
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 10),
                          padding: EdgeInsets.all(
                              GlobalVariable.ratioWidth(Get.context) * 17),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 10)),
                              border: Border.all(
                                  color: Color(ListColor.colorLightGrey5),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0.3)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6),
                                  width: 100,
                                  height: 70,
                                  color: Colors.white,
                                  child: Image.network(
                                      controller.kendaraan[x]["ImageTruck"],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity)),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(controller.kendaraan[x]["Head"],
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      child: CustomText(
                                          controller.kendaraan[x]["Carrier"],
                                          fontSize: 14,
                                          color: Color(ListColor.colorDarkGrey),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          6),
                              CustomText(
                                  controller.kendaraan[x]["Qty"].toString(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)
                            ],
                          ),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget videoView() {
    return Obx(
      () => GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 16 / 11,
        padding: EdgeInsets.zero,
        children: List.generate(controller.thumbnailVideo.length, (index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                border:
                    Border.all(color: Color(ListColor.colorGrey3), width: 1)),
            margin: EdgeInsets.all(10),
            child: MaterialButton(
              minWidth: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
              ),
              onPressed: () {
                Get.toNamed(Routes.SHOW_VIDEO,
                    arguments: [controller.videoList.value]);
              },
              padding: EdgeInsets.zero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.memory(controller.thumbnailVideo[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildMap() {
    return FlutterMap(
      options: MapOptions(
        interactiveFlags: InteractiveFlag.none,
        center: LatLng(double.parse(controller.transporter.latitude),
            double.parse(controller.transporter.longitude)),
        zoom: 13.0,
      ),
      layers: [
        GlobalVariable.tileLayerOptions,
        MarkerLayerOptions(markers: [
          Marker(
            width: GlobalVariable.ratioWidth(Get.context) * 16.85,
            height: GlobalVariable.ratioWidth(Get.context) * 20,
            point: LatLng(double.parse(controller.transporter.latitude),
                double.parse(controller.transporter.longitude)),
            builder: (ctx) => Image.asset(
              'assets/pin_new.png',
              width: GlobalVariable.ratioWidth(Get.context) * 16.85,
              height: GlobalVariable.ratioWidth(Get.context) * 20,
            ),
          ),
        ])
      ],
    );
  }

  Widget testimonyView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: GlobalVariable.ratioWidth(Get.context) * 18,
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              bottom: GlobalVariable.ratioWidth(Get.context) * 12),
          child: CustomText("Testimoni".tr,
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16,
                bottom: GlobalVariable.ratioWidth(Get.context) * 24),
            padding: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(Get.context) * 8),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(ListColor.colorLightGrey5),
                  width: GlobalVariable.ratioWidth(Get.context) * 0.3),
              borderRadius: BorderRadius.all(
                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 90,
                      margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 30,
                          right: GlobalVariable.ratioWidth(Get.context) * 10),
                      child: CustomText("4,2",
                          fontSize: 48, fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: FontTopPadding.getSize(48)),
                            Obx(() => RatingBarIndicator(
                                  rating: controller.rating["Grade"],
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemSize:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  itemBuilder: (context, _) => Container(
                                    margin: EdgeInsets.only(
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8),
                                    child: SvgPicture.asset(
                                      "assets/ic_star.svg",
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                    ),
                                  ),
                                  // Icon(Icons.star,
                                  //     color: Color(ListColor.colorYellow)),
                                  unratedColor:
                                      Color(ListColor.colorLightGrey2),
                                )),
                            Obx(() => CustomText(
                                controller.listTestimony.length.toString() +
                                    " " +
                                    "DetailTransporterLabelUlasan".tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w400))
                          ]),
                    )
                  ],
                ),
                Container(height: GlobalVariable.ratioWidth(Get.context) * 8),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 30,
                    ),
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                          (index) => Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                  child: SvgPicture.asset(
                                    "assets/ic_star.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                  ),
                                ),
                                // Icon(
                                //   Icons.star,
                                //   color: Color(ListColor.colorYellow),
                                //   size: GlobalVariable.ratioWidth(Get.context) *
                                //       12,
                                // ),
                                Container(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                CustomText((5 - index).toString(),
                                    fontSize: 12, fontWeight: FontWeight.w400)
                              ],
                            ),
                          ),
                        )),
                    Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 10,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                            // margin: EdgeInsets.symmetric(
                            //     vertical: 3, horizontal: 13),
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 20)),
                              child: Obx(
                                () => LinearProgressIndicator(
                                  backgroundColor: Color(0x4057bb8a),
                                  minHeight: controller.totalRating.value,
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xff57bb8a)),
                                  value: (controller.rating["Five"]) /
                                      controller.totalRating.value,
                                ),
                              ),
                            )),
                        Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                            // margin: EdgeInsets.symmetric(
                            //     vertical: 3, horizontal: 13),
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 20)),
                              child: Obx(
                                () => LinearProgressIndicator(
                                  backgroundColor: Color(0x409ace6a),
                                  minHeight: controller.totalRating.value,
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xff9ace6a)),
                                  value: (controller.rating["Four"]) /
                                      controller.totalRating.value,
                                ),
                              ),
                            )),
                        Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                            // margin: EdgeInsets.symmetric(
                            //     vertical: 3, horizontal: 13),
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: Obx(
                                () => LinearProgressIndicator(
                                  backgroundColor: Color(0x40ffcf02),
                                  minHeight: controller.totalRating.value,
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xffffcf02)),
                                  value: (controller.rating["Three"]) /
                                      controller.totalRating.value,
                                ),
                              ),
                            )),
                        Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                            // margin: EdgeInsets.symmetric(
                            //     vertical: 3, horizontal: 13),
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 20)),
                              child: Obx(
                                () => LinearProgressIndicator(
                                  backgroundColor: Color(0x40ff9f02),
                                  minHeight: controller.totalRating.value,
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xffff9f02)),
                                  value: (controller.rating["Two"]) /
                                      controller.totalRating.value,
                                ),
                              ),
                            )),
                        Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 20,
                            // margin: EdgeInsets.symmetric(
                            //     vertical: 3, horizontal: 13),
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 20)),
                              child: Obx(
                                () => LinearProgressIndicator(
                                  backgroundColor: Color(0x40ff6f31),
                                  minHeight: controller.totalRating.value,
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xffff6f31)),
                                  value: (controller.rating["One"]) /
                                      controller.totalRating.value,
                                ),
                              ),
                            )),
                      ],
                    )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 25,
                          right: GlobalVariable.ratioWidth(Get.context) * 30),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 3),
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                              alignment: Alignment.centerLeft,
                              child: Obx(() => CustomText(
                                    controller.rating["Five"].toString(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 3),
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                              alignment: Alignment.centerLeft,
                              child: Obx(() => CustomText(
                                    controller.rating["Four"].toString(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 3),
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                              alignment: Alignment.centerLeft,
                              child: Obx(() => CustomText(
                                    controller.rating["Three"].toString(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 3),
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                              alignment: Alignment.centerLeft,
                              child: Obx(() => CustomText(
                                    controller.rating["Two"].toString(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 3),
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 20,
                              alignment: Alignment.centerLeft,
                              child: Obx(() => CustomText(
                                    controller.rating["One"].toString(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ]),
                    )
                  ],
                )
              ],
            )),
        Container(
            margin: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              right: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color(ListColor.colorLightGrey5),
                    width: GlobalVariable.ratioWidth(Get.context) * 0.3),
                borderRadius: BorderRadius.all(Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 10))),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var repeat = 0;
                      repeat < controller.listTestimony.length;
                      repeat++)
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(
                              GlobalVariable.ratioWidth(Get.context) * 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 32,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 32,
                                margin: EdgeInsets.only(
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            13),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Image(
                                    image: AssetImage(
                                        "assets/gambar_example.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                  controller
                                                      .listTestimony[repeat]
                                                          ["Shipper"]
                                                      .toString(),
                                                  fontSize: 14,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        5),
                                                child: RatingBarIndicator(
                                                  rating: double.parse(
                                                      controller
                                                          .listTestimony[repeat]
                                                              ["Rate"]
                                                          .toString()),
                                                  direction: Axis.horizontal,
                                                  itemSize:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  // itemCount: 5,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Container(
                                                    margin: EdgeInsets.only(
                                                        right: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            4),
                                                    //index != 4 ? 3 : 0),

                                                    child: SvgPicture.asset(
                                                      "assets/ic_star.svg",
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          8,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          8,
                                                    ),

                                                    //     Icon(
                                                    //   Icons.star,
                                                    //   color: Color(ListColor
                                                    //       .colorYellow),
                                                    // ),
                                                  ),
                                                  unratedColor: Color(ListColor
                                                      .colorLightGrey2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  10),
                                          child: CustomText(
                                            controller.listTestimony[repeat]
                                                    ["CommentTime"]
                                                .toString(),
                                            color: Color(ListColor.colorGrey3),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14),
                                      child: CustomText(
                                          controller.listTestimony[repeat]
                                                  ["Testimoni"]
                                              .toString(),
                                          fontSize: 12,
                                          height: 1.2,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (repeat != controller.listTestimony.length - 1 &&
                            controller.listTestimony.length == 1)
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 0.5,
                              color: Colors.grey)
                      ],
                    )
                ],
              ),
            ))
      ],
    );
  }

  Widget _circleAvatar(String urlImage) {
    return Container(
      margin:
          EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 12),
      child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: Container(
            width: GlobalVariable.ratioWidth(Get.context) * 68,
            height: GlobalVariable.ratioWidth(Get.context) * 68,
            child: urlImage == ""
                ? _defaultAvatar()
                : CachedNetworkImage(
                    errorWidget: (context, value, err) => _defaultAvatar(),
                    imageUrl: GlobalVariable.urlImage + urlImage,
                    imageBuilder: (context, imageProvider) => Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 68,
                      height: GlobalVariable.ratioWidth(Get.context) * 68,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                  ),
          )),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      width: GlobalVariable.ratioWidth(Get.context) * 68,
      height: GlobalVariable.ratioWidth(Get.context) * 68,
      decoration: BoxDecoration(
          color: Color(ListColor.colorPurple),
          borderRadius: BorderRadius.all(Radius.circular(35))),
      child: Center(
          child: SvgPicture.asset("assets/detail_transporter_default_icon.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 34,
              height: GlobalVariable.ratioWidth(Get.context) * 34)),
    );
  }

  Widget _button({
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 8,
    double paddingRight = 0,
    double paddingBottom = 8,
    bool useShadow = false,
    bool useBorder = true,
    double borderRadius = 26,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 12,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: maxWidth ? MediaQuery.of(Get.context).size.width : null,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.3),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}

class _AppBar extends PreferredSize {
  final Size preferredSize;
  final List<Widget> listOption;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: preferredSize.height,
      child: Container(
          height: preferredSize.height,
          color: Color(ListColor.color4),
          child: Stack(alignment: Alignment.centerLeft, children: [
            Container(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 14,
              ),
              child: CustomBackButton(
                  context: Get.context,
                  onTap: () {
                    Get.back();
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: listOption,
            ),
          ])),
    ));
  }

  _AppBar({@required this.preferredSize, this.listOption});
}
