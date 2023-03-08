import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/demo/lihat_dokumen_persyaratan/lihat_dokumen_persyaratan_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class LihatVideoController extends GetxController {
  var modul = "";
  var sisi = "";
  var tab = "";
  var url = "".obs;
  var title = "".obs;
  var subtitle = "".obs;
  var note = "".obs;
  var jenisTampilan = "".obs;
  var linkVideo = "".obs;
  var dataDemo = [].obs;
  Timer time = null;
  var jmlArmadaController = TextEditingController().obs;
  var kapasitasPengirimanController = TextEditingController().obs;

  var loadingVideo = true.obs;
  var loadingVideoUtama = true.obs;
  var videoPlaying = false.obs;
  var showControl = true.obs;
  var maximize = false.obs;
  var idVideo = ''.obs;
  double iconSizeController = 0.0;
  double iconSizeControllerMaximize = 0.0;
  double iconSizeMaximize = 0.0;
  double iconSizeTopMaximize = 0.0;
  double iconSizeLeftMaximize = 0.0;
  var changePengiriman = "".obs;
  var changeJumlahArmada = "".obs;

  VideoPlayerController video;
  var chewie = null;
  Chewie playerWidget;

  List<File> vdApp = [];
  List<File> vdWeb = [];

  @override
  void onInit() async {
    modul = Get.arguments[0];
    sisi = Get.arguments[1];
    tab = Get.arguments[2];

    iconSizeController = GlobalVariable.ratioWidth(Get.context) * 32;
    iconSizeControllerMaximize = GlobalVariable.ratioWidth(Get.context) * 62;
    iconSizeMaximize = GlobalVariable.ratioWidth(Get.context) * 24;
    iconSizeTopMaximize = GlobalVariable.ratioWidth(Get.context) * 24;
    iconSizeLeftMaximize = GlobalVariable.ratioWidth(Get.context) * 16;

    var data = await GlobalVariable.getStatusUser(Get.context);

    await getData(
        Get.arguments[3],
        Get.arguments[4] ?? '',
        Get.arguments[5] ?? '',
        Get.arguments[6] ?? '',
        Get.arguments[7],
        Get.arguments[8].toString());
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    // video.dispose();
    // chewie.dispose();
    if (video.value.isPlaying) {
      video.pause();
      chewie.value.pause();
    }
    video = null;
    chewie = null;
    super.dispose();
  }

  void getData(String jenisTampilanTemp, String titleTemp, String subtitleTemp,
      String noteTemp, String linkVideoTemp, String idVideoTemp) async {
    loadingVideoUtama.value = true;
    loadingVideo.value = true;
    videoPlaying.value = false;
    showControl.value = false;
    maximize.value = false;

    jenisTampilan.value = jenisTampilanTemp;
    title.value = titleTemp;
    subtitle.value = subtitleTemp;
    note.value = noteTemp;
    linkVideo.value = linkVideoTemp;
    idVideo.value = idVideoTemp;

    dataDemo.clear();
    dataDemo.refresh();

    var userRole = '0';
    if (tab == 'TRANSPORTER') {
      userRole = '4';
    } else {
      userRole = '2';
    }

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDemoLainnya(idVideo.value, userRole, modul);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      print('DATA VIDEO LAIN');
      print(data);

      var namaFile;
      var savedLocation;

      var existed;
      var fileApp;
      var fileWeb;

      for (var x = 0; x < data.length; x++) {
        dataDemo.add(data[x]);
        namaFile = data[x]['VideoApp'].split("/").last.split(".")[0];
        savedLocation =
            (await getTemporaryDirectory()).path + "/" + namaFile + ".png";

        existed = await File(savedLocation).exists();
        fileApp;
        if (!existed) {
          fileApp = await VideoThumbnail.thumbnailFile(
            video: data[x]['VideoApp'],
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            maxHeight: (GlobalVariable.ratioWidth(Get.context) * 224).toInt(),
            quality: 50,
          );
        } else {
          fileApp = savedLocation;
        }

        namaFile = data[x]['Video'].split("/").last.split(".")[0];
        savedLocation =
            (await getTemporaryDirectory()).path + "/" + namaFile + ".png";

        existed = await File(savedLocation).exists();

        if (!existed) {
          fileWeb = await VideoThumbnail.thumbnailFile(
            video: data[x]['Video'],
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            maxHeight: (GlobalVariable.ratioWidth(Get.context) * 184).toInt(),
            quality: 50,
          );
        } else {
          fileWeb = savedLocation;
        }

        vdApp.add(File(fileApp));

        vdWeb.add(File(fileWeb));
        if (x == data.length - 1) {
          loadingVideo.value = false;
        }
      }

      if (data.length == 0) {
        loadingVideo.value = false;
      }
    }

    video =
        new VideoPlayerController.network(linkVideo.value); //linkVideo.value
    print(linkVideo.value);
    await video.initialize();

    chewie = new ChewieController(
        videoPlayerController: video,
        allowFullScreen: true,
        autoInitialize: false,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        showControls: true,
        deviceOrientationsOnEnterFullScreen: jenisTampilan.value == 'ANDROID'
            ? [
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]
            : [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          // DeviceOrientation.landscapeLeft,
          // DeviceOrientation.landscapeRight,
        ]
        // customControls: Obx(() => GestureDetector(
        //     onTap: () {
        //       showController();

        //       print('showControl : ' + showControl.value.toString());
        //       print('videoPlaying : ' + videoPlaying.value.toString());
        //       print('Maximize : ' + maximize.value.toString());
        //     },
        //     child: Container(
        //         color: (showControl.value
        //             ? Colors.black.withOpacity(0.5)
        //             : Colors.transparent),
        //         height: !maximize.value
        //             ? GlobalVariable.ratioWidth(Get.context) * 174
        //             : MediaQuery.of(Get.context).size.width,
        //         child: Stack(
        //           children: [
        //             showControl.value
        //                 ? Positioned.fill(
        //                     child: Align(
        //                         alignment: Alignment.center,
        //                         child: Obx(() => GestureDetector(
        //                             onTap: () {
        //                               if (chewie.value.isPlaying) {
        //                                 chewie.value.pause();
        //                                 videoPlaying.value = false;
        //                               } else {
        //                                 chewie.value.play();
        //                                 videoPlaying.value = true;
        //                               }
        //                               showController();
        //                               print('showControl : ' +
        //                                   showControl.value.toString());
        //                               print('videoPlaying : ' +
        //                                   videoPlaying.value.toString());
        //                               print('Maximize : ' +
        //                                   maximize.value.toString());
        //                             },
        //                             child: SvgPicture.asset(
        //                                 videoPlaying.value
        //                                     ? GlobalVariable.imagePath+'icon-pause.svg'
        //                                     : GlobalVariable.imagePath+'icon-play-biru.svg',
        //                                 width: maximize.value
        //                                     ? iconSizeControllerMaximize
        //                                     : iconSizeController,
        //                                 height: maximize.value
        //                                     ? iconSizeControllerMaximize
        //                                     : iconSizeController)))),
        //                   )
        //                 : SizedBox.expand(),
        //             !maximize.value
        //                 ? Positioned.fill(
        //                     child: Align(
        //                         alignment: Alignment.bottomRight,
        //                         child: GestureDetector(
        //                             onTap: () {
        //                               // if (controller
        //                               //         .jenisTampilan.value ==
        //                               //     'ANDROID') {
        //                               //   controller.chewie.value
        //                               //           .deviceOrientationsAfterFullScreen[0] =
        //                               //       DeviceOrientation
        //                               //           .portraitUp;
        //                               // } else {
        //                               //   controller.chewie.value
        //                               //           .deviceOrientationsAfterFullScreen[0] =
        //                               //       DeviceOrientation
        //                               //           .landscapeRight;
        //                               // }
        //                               chewie.value.enterFullScreen();
        //                               maximize.value = true;

        //                               print('showControl : ' +
        //                                   showControl.value.toString());
        //                               print('videoPlaying : ' +
        //                                   videoPlaying.value.toString());
        //                               print('Maximize : ' +
        //                                   maximize.value.toString());
        //                             },
        //                             child: Container(
        //                                 padding: EdgeInsets.only(
        //                                     right: GlobalVariable.ratioWidth(
        //                                             Get.context) *
        //                                         17,
        //                                     bottom: GlobalVariable.ratioWidth(
        //                                             Get.context) *
        //                                         12),
        //                                 child: SvgPicture.asset(
        //                                     GlobalVariable.imagePath+'maximize.svg',
        //                                     width: iconSizeMaximize,
        //                                     height: iconSizeMaximize)))),
        //                   )
        //                 : Positioned.fill(
        //                     child: Align(
        //                         alignment: Alignment.topLeft,
        //                         child: GestureDetector(
        //                             onTap: () {
        //                               // if (controller
        //                               //         .jenisTampilan.value ==
        //                               //     'ANDROID') {
        //                               //   controller.chewie.value
        //                               //           .deviceOrientationsAfterFullScreen[0] =
        //                               //       DeviceOrientation
        //                               //           .portraitUp;
        //                               // } else {
        //                               //   controller.chewie.value
        //                               //           .deviceOrientationsAfterFullScreen[0] =
        //                               //       DeviceOrientation
        //                               //           .landscapeRight;
        //                               // }
        //                               chewie.value.exitFullScreen();
        //                               maximize.value = false;

        //                               print('showControl : ' +
        //                                   showControl.value.toString());
        //                               print('videoPlaying : ' +
        //                                   videoPlaying.value.toString());
        //                               print('Maximize : ' +
        //                                   maximize.value.toString());
        //                             },
        //                             child: Container(
        //                                 decoration: BoxDecoration(
        //                                     color: Color(ListColor.colorBlue),
        //                                     borderRadius: BorderRadius.circular(
        //                                         GlobalVariable.ratioWidth(
        //                                                 Get.context) *
        //                                             100)),
        //                                 margin: EdgeInsets.only(
        //                                     left: iconSizeLeftMaximize,
        //                                     top: iconSizeTopMaximize),
        //                                 child: SvgPicture.asset(
        //                                     GlobalVariable.imagePath+'ic_back_button.svg',
        //                                     width: iconSizeMaximize,
        //                                     height: iconSizeMaximize)))),
        //                   ),
        //             Positioned.fill(
        //               child: Align(
        //                   alignment: Alignment.bottomCenter,
        //                   child: VideoProgressIndicator(
        //                     video,
        //                     allowScrubbing: true,
        //                     colors: VideoProgressColors(
        //                         backgroundColor: Colors.white,
        //                         playedColor: Color(ListColor.colorBlue),
        //                         bufferedColor: Colors.white),
        //                   )),
        //             ),
        //           ],
        //         )))

        ).obs;

    playerWidget = new Chewie(controller: chewie.value);
    loadingVideoUtama.value = false;
    //video.addListener(checkEndVideo);
  }

  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 0.5,
        color: Color(ListColor.colorLightGrey10),
        height: 0,
      ),
    );
  }

  Widget demoLainnyaWidget() {
    return Obx(() => !loadingVideo.value
        ? jenisTampilan.value == 'ANDROID'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16,
                        ),
                        child: CustomText(
                          "Lihat Demo Lainnya".tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 14),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var x = 0; x < dataDemo.length; x++)
                              GestureDetector(
                                onTap: () async {
                                  print(dataDemo[x]['Title']);
                                  if (video.value.isPlaying) {
                                    video.pause();
                                    chewie.value.pause();
                                  }
                                  video = null;
                                  chewie = null;

                                  await getData(
                                      jenisTampilan.value,
                                      dataDemo[x]['Title'] ?? '',
                                      dataDemo[x]['SubTitle'] ?? '',
                                      dataDemo[x]['Description'] ?? '',
                                      dataDemo[x]['VideoApp'],
                                      dataDemo[x]['ID'].toString());
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: (x == 0
                                        ? GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16
                                        : 0),
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            (x == dataDemo.length - 1
                                                ? 16
                                                : 12),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                  ),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          142,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color(ListColor.colorLightGrey10),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            0.5),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Container(
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: dataDemo[x]['Icon'],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover)),
                                              ),
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                            )),
                                        SizedBox(
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6),
                                        Expanded(
                                            child: CustomText(
                                          dataDemo[x]['Title'],
                                          fontSize: 12,
                                          textAlign: TextAlign.left,
                                          fontWeight: FontWeight.w600,
                                          maxLines: 2,
                                          wrapSpace: true,
                                        ))
                                      ]),
                                      SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            10,
                                      ),
                                      Stack(
                                        children: [
                                          Positioned(
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  4))),
                                                  // height: GlobalVariable
                                                  //         .ratioWidth(
                                                  //             Get.context) *
                                                  //     160,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(
                                                              GlobalVariable.ratioWidth(Get
                                                                      .context) *
                                                                  4)),
                                                      child: Image.file(
                                                          vdApp[x],
                                                          height: (GlobalVariable
                                                                  .ratioWidth(
                                                                      Get.context) *
                                                              224))),
                                                )),
                                          ),
                                          Positioned(
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(
                                                                GlobalVariable.ratioWidth(Get
                                                                        .context) *
                                                                    4))),
                                                    child: CustomText(''),
                                                    width: double.infinity,
                                                    height:
                                                        (GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            224))),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        'icon-play-biru.svg',
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        24,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        24)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ))
                  ])
            : Container(
                margin: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "Lihat Demo Lainnya".tr,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 14),
                      for (var x = 0; x < dataDemo.length; x++)
                        GestureDetector(
                            onTap: () async {
                              print(dataDemo[x]['Title']);
                              if (video.value.isPlaying) {
                                video.pause();
                                chewie.value.pause();
                              }
                              video = null;
                              chewie = null;
                              await getData(
                                  jenisTampilan.value,
                                  dataDemo[x]['Title'] ?? '',
                                  dataDemo[x]['SubTitle'] ?? '',
                                  dataDemo[x]['Description'] ?? '',
                                  dataDemo[x]['Video'],
                                  dataDemo[x]['ID'].toString());
                            },
                            child: Container(
                              width: MediaQuery.of(Get.context).size.width -
                                  GlobalVariable.ratioWidth(Get.context) * 32,
                              child: Column(children: [
                                Stack(
                                  children: [
                                    Positioned(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            4))),
                                            height: (MediaQuery.of(Get.context)
                                                        .size
                                                        .width -
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        32) /
                                                16 *
                                                9,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            4)),
                                                child: Image.file(vdWeb[x])),
                                          )),
                                    ),
                                    Positioned(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            4))),
                                            child: CustomText(''),
                                            width: double.infinity,
                                            height: (MediaQuery.of(Get.context)
                                                        .size
                                                        .width -
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        32) /
                                                16 *
                                                9,
                                          )),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'icon-play-biru.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: dataDemo[x]['Icon'],
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover)),
                                                ),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                              )),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12),
                                          Expanded(
                                            child: CustomText(
                                              dataDemo[x]['Title'],
                                              fontSize: 14,
                                              textAlign: TextAlign.left,
                                              fontWeight: FontWeight.w600,
                                              maxLines: 2,
                                              wrapSpace: true,
                                            ),
                                          )
                                        ]),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  36),
                                          Expanded(
                                            child: CustomText(
                                              dataDemo[x]['SubTitle'],
                                              fontSize: 12,
                                              textAlign: TextAlign.left,
                                              color: Color(
                                                  ListColor.colorLightGrey4),
                                              fontWeight: FontWeight.w500,
                                              maxLines: 5,
                                              height: 1.2,
                                              wrapSpace: true,
                                            ),
                                          ),
                                        ]),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                    ),
                                    x != dataDemo.length - 1
                                        ? Column(
                                            children: [
                                              lineDividerWidget(),
                                              SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        19,
                                              ),
                                            ],
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ]),
                            ))
                    ]))
        : Center(child: CircularProgressIndicator()));
  }

  void checkEndVideo() {
    if (video.value.position == video.value.duration) {
      videoPlaying.value = false;
      chewie.value.pause();
      video.seekTo(Duration(seconds: 0, minutes: 0, hours: 0));
    }
  }

  // void showController() async {
  //   showControl.value = true;

  //   if (videoPlaying.value == true) {
  //     if (time != null) {
  //       if (time.isActive) {
  //         time.cancel();
  //       }
  //     }

  //     time = Timer(Duration(seconds: 5), () {
  //       showControl.value = false;
  //       time.cancel();
  //     });
  //   }

  //   print('VIDEO PLAY : ' + videoPlaying.value.toString());
  // }

  void popUpPemberitahuan() async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 34,
                  right: GlobalVariable.ratioWidth(Get.context) * 34),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: IntrinsicHeight(
                  child: Stack(
                children: [
                  Positioned(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              margin: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'pemberitahuan.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  120,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  120),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12),
                                          CustomText(
                                              "DemoBigFleetsTransporterIndexPemberitahuan"
                                                  .tr, //Pemberitahuan.
                                              fontSize: 18,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12),
                                          CustomText(
                                              modul == 'BIGFLEET' &&
                                                      GlobalVariable.role == '2'
                                                  ? "DemoBigFleetsShipperIndexUntukMempermudah"
                                                      .tr
                                                  : modul == 'BIGFLEET' &&
                                                          GlobalVariable.role ==
                                                              '4'
                                                      ? "DemoBigFleetsTransporterIndexUntukMempermudah"
                                                          .tr
                                                      : modul == 'TRANSPORTMARKET' &&
                                                              GlobalVariable
                                                                      .role ==
                                                                  '2'
                                                          ? "DemoTransportMarketShipperIndexUntukMempermudah"
                                                              .tr
                                                          : "DemoTransportMarketTransporterIndexUntukMempermudah"
                                                              .tr, //Untuk mempermudah.
                                              fontSize: 12,
                                              height: 1.5,
                                              wrapSpace: true,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20),
                                          Container(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  180,
                                              child: Material(
                                                borderRadius: BorderRadius
                                                    .circular(GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        20),
                                                color:
                                                    Color(ListColor.colorBlue),
                                                child: InkWell(
                                                    customBorder:
                                                        RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              18),
                                                    ),
                                                    onTap: () async {
                                                      Get.back();
                                                      if (sisi == 'SHIPPER') {
                                                        popUpKapasitasPengiriman();
                                                      } else {
                                                        popUpJumlahArmada();
                                                      }
                                                    },
                                                    child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    20,
                                                            vertical:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    7),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    ListColor
                                                                        .colorBlue)),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        20)),
                                                        child: Center(
                                                          child: CustomText(
                                                              'DemoBigFleetsTransporterIndexLanjutkan'
                                                                  .tr, // Lanjutkan di Aplikasi
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ))),
                                              )),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16)
                                        ]))
                                  ])))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                        child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'ic_close_blue.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  color: Color(ListColor.color4),
                                ))),
                              ))))
                ],
              )));
        });
  }

  void popUpKapasitasPengiriman() async {
    kapasitasPengirimanController.value.clear();
    changePengiriman.value = "";
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 13,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 14),
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: 2.0,
                      color: Color(ListColor.colorLightGrey16)),
                  CustomText(
                      'DemoBigFleetsShipperIndexKapasitasPengiriman'
                          .tr, //Kapasitas Pengiriman
                      color: Color(ListColor.colorBlue),
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  CustomText(
                      'DemoBigFleetsShipperIndexSebelumMelanjutkanProsesRegistrasi'
                          .tr, //Sebelum melanjutkan Proses Registrasi sebagai Shipper mohon mengisi jumlah kapasitas pengiriman rata-rata Anda per hari
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.5,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
                  Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 228,
                      child: CustomTextFormField(
                          context: Get.context,
                          onChanged: (value) {
                            changePengiriman.value = value;
                          },
                          newContentPadding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                            right: GlobalVariable.ratioWidth(Get.context) * 17,
                            //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9\,]")),
                            DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 0,
                                controller: kapasitasPengirimanController.value)
                          ],
                          textSize: 14,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          newInputDecoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: Colors.white,
                            filled: true,
                            prefix: SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    17),
                            suffix: SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    17),
                            suffixIconConstraints:
                                BoxConstraints(minHeight: 0.0),
                            suffixIcon: Container(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 90,
                              child: CustomText(
                                  "DemoBigFleetsShipperIndexUnitTrukPerHari"
                                      .tr, //unit truk/hari
                                  fontWeight: FontWeight.w400,
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: 14),
                            ),
                            isDense: true,
                            isCollapsed: true,
                          ),
                          controller: kapasitasPengirimanController.value)),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
                  Obx(() => Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 90,
                      child: Material(
                        borderRadius: BorderRadius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        color: kapasitasPengirimanController.value.text != ""
                            ? Color(ListColor.colorBlue)
                            : Color(ListColor.colorStroke),
                        child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 18),
                            ),
                            onTap: () async {
                              if (kapasitasPengirimanController.value.text !=
                                  "") {
                                kirimKapasitas();
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: changePengiriman.value != ""
                                            ? Color(ListColor.colorBlue)
                                            : Color(ListColor.colorStroke)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20)),
                                child: Center(
                                  child: CustomText(
                                      'DemoBigFleetsShipperIndexKirim'
                                          .tr, // Kirim
                                      fontSize: 14,
                                      color: changePengiriman.value != ""
                                          ? Colors.white
                                          : Color(ListColor.colorLightGrey4),
                                      fontWeight: FontWeight.w600),
                                ))),
                      ))),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
                ],
              ),
            ));
  }

  void popUpJumlahArmada() async {
    jmlArmadaController.value.clear();
    changeJumlahArmada.value = "";
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 13,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 14),
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: 2.0,
                      color: Color(ListColor.colorLightGrey16)),
                  CustomText(
                      'DemoBigFleetsTransporterIndexJumlahArmada'
                          .tr, // Jumlah Armada
                      color: Color(ListColor.colorBlue),
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  CustomText(
                      'DemoBigFleetsTransporterIndexSebelumMelanjutkanProsesRegistrasi'
                          .tr, //Sebelum melanjutkan Proses Registrasi sebagai Transporter mohon mengisi jumlah truk yang Anda miliki
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.5,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
                  Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 228,
                      child: CustomTextFormField(
                          onChanged: (value) {
                            changeJumlahArmada.value = value;
                            print(value);
                          },
                          context: Get.context,
                          newContentPadding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                            right: GlobalVariable.ratioWidth(Get.context) * 17,
                            //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9\,]")),
                            DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 0,
                                controller: jmlArmadaController.value)
                          ],
                          textSize: 14,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          newInputDecoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: Colors.white,
                            filled: true,
                            prefix: SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    17),
                            suffix: SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    17),
                            suffixIconConstraints:
                                BoxConstraints(minHeight: 0.0),
                            suffixIcon: Container(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 60,
                              child: CustomText(
                                  "DemoBigFleetsTransporterIndexUnitTruk"
                                      .tr, // unit truk
                                  fontWeight: FontWeight.w400,
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: 14),
                            ),
                            isDense: true,
                            isCollapsed: true,
                          ),
                          controller: jmlArmadaController.value)),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
                  Obx(() => Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 90,
                      child: Material(
                        borderRadius: BorderRadius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        color: jmlArmadaController.value.text != ""
                            ? Color(ListColor.colorBlue)
                            : Color(ListColor.colorStroke),
                        child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 18),
                            ),
                            onTap: () async {
                              if (jmlArmadaController.value.text != "") {
                                kirimArmada(modul);
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: changeJumlahArmada.value != ""
                                            ? Color(ListColor.colorBlue)
                                            : Color(ListColor.colorStroke)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20)),
                                child: Center(
                                  child: CustomText(
                                      'DemoBigFleetsTransporterIndexKirim'
                                          .tr, // Kirim
                                      fontSize: 14,
                                      color: changeJumlahArmada.value != ""
                                          ? Colors.white
                                          : Color(ListColor.colorLightGrey4),
                                      fontWeight: FontWeight.w600),
                                ))),
                      ))),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
                ],
              ),
            ));
  }

  void kirimKapasitas() {
    Get.back();

    simpanKapasitasPengiriman(
        GlobalVariable.formatDoubleDecimal(
            kapasitasPengirimanController.value.text),
        '0');
  }

  void kirimArmada(String modul) {
    Get.back();
    simpanJumlahArmada(
        GlobalVariable.formatDoubleDecimal(jmlArmadaController.value.text),
        '0');
  }

  void popUpPendingVerifikasiTransporter() {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        customTitle: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 32),
              Container(
                padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                child: CustomText(
                    "DemoBigFleetsTransporterIndexPengajuanVerifikasiTransporter"
                            .tr +
                        "\n" +
                        "DemoBigFleetsTransporterIndexSedangDiProses"
                            .tr, //Pengajuan Verifikasi Transporter\nSedang Diproses
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    color: Colors.black),
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_blue.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: Color(ListColor.color4)),
                      ))),
            ])),
        customMessage: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  "DemoBigFleetsTransporterIndexMohonMenunggu"
                      .tr, //Mohon menunggu sampai proses verifikasi oleh Admin muatmuat selesai. Periksa pemberitahuan secara berkala untuk mengetahui perkembangan pengajuan Anda.
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 193,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoBigFleetsTransporterIndexLihatPemberitahuan'
                                      .tr, // Lihat Pemberitahuan
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ))),
                  ))
            ]),
        isShowButton: false);
  }

  void popUpPendingVerifikasiShipper() {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        customTitle: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 32),
              Container(
                padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                child: CustomText(
                    "DemoBigFleetsShipperIndexPengajuanVerifikasiShipper".tr +
                        "\n" +
                        "DemoBigFleetsShipperIndexSedangDiProses"
                            .tr, //Pengajuan Verifikasi Shipper\nSedang Diproses
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    color: Colors.black),
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_blue.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: Color(ListColor.color4)),
                      ))),
            ])),
        customMessage: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  "DemoBigFleetsShipperIndexMohonMenunggu"
                      .tr, //Mohon menunggu sampai proses verifikasi oleh Admin muatmuat selesai. Periksa pemberitahuan secara berkala untuk mengetahui perkembangan pengajuan Anda.
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 193,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoBigFleetsShipperIndexLihatPemberitahuan'
                                      .tr, //Lihat Pemberitahuan
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ))),
                  ))
            ]),
        isShowButton: false);
  }

  void popUpBergabungMenjadiTransporter(String jenis) {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        customTitle: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 32),
              Container(
                padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                child: CustomText(
                    (jenis == 'BIGFLEET'
                        ? "DemoBigFleetsTransporterIndexBergabungMenjadiTransporter"
                                .tr +
                            "\n" +
                            "Big Fleets" //Bergabung Menjadi Transporter\nBig Fleets
                        : "DemoBigFleetsTransporterIndexBergabungMenjadiTransporter"
                                .tr +
                            "\n" +
                            "Transport Market"), //Bergabung Menjadi Transporter\nTransport Market),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    color: Colors.black),
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_blue.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: Color(ListColor.color4)),
                      ))),
            ])),
        customMessage: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  (jenis == 'BIGFLEET'
                      ? "DemoBigFleetsTransporterIndexAndaMerupakanIntermediat"
                          .tr //Anda merupakan intermediat yang memiliki sejumlah truk di atas batas ketentuan. Apakah Anda yakin untuk mendaftar sebagai Transporter Big Fleets?
                      : "DemoTransportMarketTransporterIndexAndaMerupakanIntermediat"
                          .tr), //Anda merupakan intermediat yang memiliki sejumlah truk di atas batas ketentuan. Apakah Anda yakin untuk mendaftar sebagai Transporter Transport Market?
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 230,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                          GetToPage.toNamed<LihatDokumenPersyaratanController>(
                              Routes.LIHAT_DOKUMEN_PERSYARATAN,
                              arguments: [modul, 'TRANSPORTER', 'TRANSPORTER']);
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoTransportMarketTransporterIndexLihatPersyaratanDanDokumenUppersum'
                                      .tr, //Lihat Persyaratan & Dokumen
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ))),
                  )),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 230,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Colors.white,
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                          popUpPemberitahuan();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 6),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoTransportMarketTransporterIndexYakinGabungSekarang'
                                      .tr, //Yakin, Gabung Sekarang
                                  fontSize: 14,
                                  color: Color(ListColor.colorBlue),
                                  fontWeight: FontWeight.w600),
                            ))),
                  ))
            ]),
        isShowButton: false);
  }

  void popUpBergabungMenjadiShipper(String modul) {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        customTitle: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 32),
              Container(
                padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                child: CustomText(
                    (modul == 'BIGFLEET'
                        ? "DemoBigFleetsShipperIndexBergabungMenjadiShipper"
                                .tr +
                            "\n" +
                            "Big Fleets" //"Bergabung Menjadi Shipper\nBig Fleets
                        : "DemoTransportMarketShipperIndexBergabungMenjadiShipper"
                                .tr +
                            "\n" +
                            "Transport Market"), //"Bergabung Menjadi Shipper\nTransport Market
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    color: Colors.black),
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_blue.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: Color(ListColor.color4)),
                      ))),
            ])),
        customMessage: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  (modul == 'BIGFLEET'
                      ? "DemoBigFleetsShipperIndexAndaMerupakanIntermediat"
                          .tr //Anda merupakan intermediat yang harus memiliki kapasitas pengiriman per hari di atas batas minimum ketentuan. Apakah Anda yakin untuk mendaftar Shipper Big Fleets?
                      : "DemoTransportMarketShipperIndexAndaMerupakanIntermediat"
                          .tr //Anda merupakan intermediat yang harus memiliki kapasitas pengiriman per hari di atas batas minimum ketentuan. Apakah Anda yakin untuk mendaftar Shipper Transport Market?),
                  ),
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              modul == 'TRANSPORTMARKET'
                  ? Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 230,
                      child: Material(
                        borderRadius: BorderRadius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        color: Color(ListColor.colorBlue),
                        child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 18),
                            ),
                            onTap: () async {
                              Get.back();
                              GetToPage.toNamed<
                                      LihatDokumenPersyaratanController>(
                                  Routes.LIHAT_DOKUMEN_PERSYARATAN,
                                  arguments: [modul, 'SHIPPER', 'SHIPPER']);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(ListColor.colorBlue)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20)),
                                child: Center(
                                  child: CustomText(
                                      'DemoTransportMarketShipperIndexLihatPersyaratanDanDokumenUppersum'
                                          .tr, //Lihat Persyaratan & Dokumen
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ))),
                      ))
                  : SizedBox(),
              modul == 'TRANSPORTMARKET'
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 12)
                  : SizedBox(),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 230,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Colors.white,
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                          popUpPemberitahuan();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 6),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoTransportMarketTransporterIndexYakinGabungSekarang'
                                      .tr, //Yakin, Gabung Sekarang
                                  fontSize: 14,
                                  color: Color(ListColor.colorBlue),
                                  fontWeight: FontWeight.w600),
                            ))),
                  ))
            ]),
        isShowButton: false);
  }

  void popUpKapasitasAndaMemenuhiKetentuanBigFleets(String qty, String sisi) {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 32),
                          Expanded(
                            // margin: EdgeInsets.only(
                            //   top: GlobalVariable.ratioWidth(Get.context) *
                            //       24,
                            // ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              "DemoTransportMarketTransporterIndexKapasitasMemenuhi".tr +
                                                  "\n" +
                                                  "DemoTransportMarketTransporterIndexKetentuan"
                                                      .tr +
                                                  " Big Fleets"
                                                      .tr, //Kapasitas Anda memenuhi\nketentuan Big Fleets
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              height: 1.2,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    (sisi == 'SHIPPER'
                                                        ? "DemoTransportMarketShipperIndexApakahAndaYakin"
                                                            .tr //Apakah Anda yakin untuk melanjutkan pendaftaran sebagai Shipper Transport Market?
                                                        : "DemoTransportMarketTransporterIndexApakahAndaYakin"
                                                            .tr //Apakah Anda yakin untuk melanjutkan pendaftaran sebagai Transporter Transport Market?
                                                    ),
                                                    fontSize: 12,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5,
                                                    color: Colors.black),
                                                SizedBox(
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        24),
                                                Container(
                                                    width: (sisi == 'SHIPPER'
                                                        ? GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            205
                                                        : GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            220),
                                                    child: Material(
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              20),
                                                      color: Color(
                                                          ListColor.colorBlue),
                                                      child: InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius: BorderRadius
                                                                .circular(GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    18),
                                                          ),
                                                          onTap: () async {
                                                            Get.back();
                                                            if (sisi ==
                                                                'SHIPPER') {
                                                              simpanKapasitasPengiriman(
                                                                  qty, '1');
                                                            } else if (sisi ==
                                                                'TRANSPORTER') {
                                                              simpanJumlahArmada(
                                                                  qty, '1');
                                                            }
                                                            // Get.back();
                                                            // Get.back();
                                                            // showDialog(
                                                            //     context:
                                                            //         Get.context,
                                                            //     barrierDismissible:
                                                            //         true,
                                                            //     builder:
                                                            //         (BuildContext
                                                            //             context) {
                                                            //       return Center(
                                                            //           child:
                                                            //               CircularProgressIndicator());
                                                            //     });
                                                            // var dataUser =
                                                            //     await GlobalVariable
                                                            //         .getStatusUser(
                                                            //             Get.context);

                                                            // Get.back();
                                                            // if (sisi ==
                                                            //     "SHIPPER") {
                                                            //   if ((dataUser[
                                                            //               'UserLevel'] ??
                                                            //           0) !=
                                                            //       1) {
                                                            //     Get.toNamed(Routes
                                                            //         .BIGFLEETS2);
                                                            //   } else {
                                                            //     Get.toNamed(
                                                            //         Routes
                                                            //             .SELAMAT_DATANG,
                                                            //         arguments: [
                                                            //           'BIGFLEET',
                                                            //           (GlobalVariable.role ==
                                                            //                   "2"
                                                            //               ? "SHIPPER"
                                                            //               : "TRANSPORTER")
                                                            //         ]);
                                                            //   }
                                                            // } else if (sisi ==
                                                            //     "TRANSPORTER") {
                                                            //   if ((dataUser[
                                                            //               'UserLevel'] ??
                                                            //           0) !=
                                                            //       1) {
                                                            //     Get.toNamed(Routes
                                                            //         .BIGFLEETS2);
                                                            //   } else {
                                                            //     Get.toNamed(
                                                            //         Routes
                                                            //             .SELAMAT_DATANG,
                                                            //         arguments: [
                                                            //           'BIGFLEET',
                                                            //           (GlobalVariable.role ==
                                                            //                   "2"
                                                            //               ? "SHIPPER"
                                                            //               : "TRANSPORTER")
                                                            //         ]);
                                                            //   }
                                                            // }
                                                          },
                                                          child: Container(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          12,
                                                                  vertical:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          7),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlue)),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              20)),
                                                              child: Center(
                                                                child: CustomText(
                                                                    (sisi == 'SHIPPER'
                                                                        ? 'DemoTransportMarketShipperIndexDaftarShipperBigFleets'.tr //Daftar Shipper Big Fleets
                                                                        : 'DemoTransportMarketTransporterIndexDaftarTransporterBigFleets'.tr), //Daftar Transporter Big Fleets
                                                                    fontSize: 14,
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600),
                                                              ))),
                                                    )),
                                                SizedBox(
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                                Container(
                                                    width: (sisi == 'SHIPPER'
                                                        ? GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            205
                                                        : GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            220),
                                                    child: Material(
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              20),
                                                      color: Colors.white,
                                                      child: InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius: BorderRadius
                                                                .circular(GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    18),
                                                          ),
                                                          onTap: () async {
                                                            Get.back();

                                                            if (sisi ==
                                                                'SHIPPER') {
                                                              Get.back();
                                                              if(modul == 'BIGFLEET'){
                                                                GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.BF);
                                                              } else {
                                                                GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.TM);
                                                              }
                                                              // CustomToast.show(context: Get.context, message: "test 3");
                                                              // Get.toNamed(Routes
                                                              //     .SHIPPER_BUYER_REGISTER);
                                                            } else {
                                                              GlobalAlertDialog.showAlertDialogCustom(
                                                                  paddingLeft:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          16,
                                                                  paddingRight:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          16,
                                                                  context: Get
                                                                      .context,
                                                                  title: "",
                                                                  customMessage: CustomText(
                                                                      "Internal AZ Halaman form Informasi Truk Bigfleet"
                                                                          .tr,
                                                                      fontSize:
                                                                          12,
                                                                      height:
                                                                          1.5,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black),
                                                                  isShowButton:
                                                                      false);
                                                            }
                                                          },
                                                          child: Container(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          24,
                                                                  vertical:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          6),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlue)),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              20)),
                                                              child: Center(
                                                                child: CustomText(
                                                                    'DemoTransportMarketTransporterIndexLanjutkan'
                                                                        .tr, //Lanjutkan
                                                                    fontSize:
                                                                        14,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ))),
                                                    ))
                                              ]),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24)
                                        ])),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                        child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'ic_close_blue.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  color: Color(ListColor.color4),
                                ))),
                              ))
                        ],
                      )))));
        });
  }

  void simpanJumlahArmada(String qty, String force) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        });
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .setJumlahArmada(qty, modul, force);
    print(result);
    if (result['Message']['Code'].toString() == '200') {
      Get.back();

      GlobalAlertDialog.showAlertDialogCustom(
          paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
          paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
          context: Get.context,
          title: "",
          customMessage: CustomText(
              "Internal AZ Halaman form Informasi Truk Bigfleet".tr,
              fontSize: 12,
              height: 1.5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              color: Colors.black),
          isShowButton: false);
    } else if (result['Message']['Code'].toString() == '500' &&
        result['Data'].toString() != '') {
      Get.back();

      if (result['Data']['ValidateResult'].toString() == "1") {
        popUpKapasitasAndaMemenuhiKetentuanBigFleets(qty, sisi);
      } else if (result['Data']['ValidateResult'].toString() == "-1") {
        showDialog(
            context: Get.context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return Dialog(
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10)),
                  child: Container(
                      child: Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          32),
                              Expanded(
                                // margin: EdgeInsets.only(
                                //   top: GlobalVariable.ratioWidth(Get.context) *
                                //       24,
                                // ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20,
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                  modul == 'TRANSPORTMARKET'
                                                      ? "DemoTransportMarketTransporterIndexMohonMaaf"
                                                          .tr //Mohon maaf, jumlah truk yang Anda miliki kurang dari ketentuan Transport Market
                                                      : "DemoBigFleetsTransporterIndexMohonMaaf"
                                                          .tr, //Mohon maaf, jumlah truk yang Anda miliki kurang dari ketentuan Transporter Big Fleets. Jangan khawatir, Anda dapat menikmati layanan Transport Market.
                                                  fontSize: 12,
                                                  textAlign: TextAlign.center,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.5,
                                                  color: Colors.black),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24),
                                              modul == 'TRANSPORTMARKET'
                                                  ? Container(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          215,
                                                      child: Material(
                                                        borderRadius: BorderRadius
                                                            .circular(GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20),
                                                        color: Colors.white,
                                                        child: InkWell(
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          18),
                                                            ),
                                                            onTap: () async {
                                                              Get.back();
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                    vertical:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            7),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Color(ListColor
                                                                            .colorBlue)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                            20)),
                                                                child: Center(
                                                                  child: CustomText(
                                                                      'DemoTransportMarketTransporterIndexKembaliKeTransportMarket'
                                                                          .tr, //Kembali ke Transport Market
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlue),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ))),
                                                      ))
                                                  : Container(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          180,
                                                      child: Material(
                                                        borderRadius: BorderRadius
                                                            .circular(GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20),
                                                        color: Color(ListColor
                                                            .colorBlue),
                                                        child: InkWell(
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          18),
                                                            ),
                                                            onTap: () async {
                                                              Get.back();
                                                              Get.back();
                                                              Get.back();
                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  () {
                                                                Get.toNamed(
                                                                    Routes
                                                                        .SELAMAT_DATANG,
                                                                    arguments: [
                                                                      'TRANSPORTMARKET',
                                                                      'TRANSPORTER'
                                                                    ]);
                                                              });
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                    vertical:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            7),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Color(ListColor
                                                                            .colorBlue)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                            20)),
                                                                child: Center(
                                                                  child: CustomText(
                                                                      'DemoBigFleetsTransporterIndexLihatTransportMarket'
                                                                          .tr, //Lihat Transport Market
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ))),
                                                      )),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24)
                                            ])),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        child: GestureDetector(
                                            child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          'ic_close_blue.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      color: Color(ListColor.color4),
                                    ))),
                                  ))
                            ],
                          )))));
            });
      }
    }
  }

  void simpanKapasitasPengiriman(String qty, String force) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        });
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .setKapasitasPengiriman(qty, modul, force);
    print(result);
    if (result['Message']['Code'].toString() == '200') {
      Get.back();
      if(modul == 'BIGFLEET'){
        GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.BF);
      } else {
        GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.TM);
      }
      // CustomToast.show(context: Get.context, message: "test 7");
      // Get.toNamed(Routes.SHIPPER_BUYER_REGISTER);
    } else if (result['Message']['Code'].toString() == '500') {
      Get.back();
      if (result['Data']['ValidateResult'].toString() == "1") {
        popUpKapasitasAndaMemenuhiKetentuanBigFleets(qty, sisi);
      } else if (result['Data']['ValidateResult'].toString() == "-1") {
        showDialog(
            context: Get.context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return Dialog(
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10)),
                  child: Container(
                      padding: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                      child: Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            32),
                                Expanded(
                                    // margin: EdgeInsets.only(
                                    //   top: GlobalVariable.ratioWidth(Get.context) *
                                    //       24,
                                    // ),
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            20,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              modul == 'TRANSPORTMARKET'
                                                  ? "DemoTransportMarketShipperIndexMohonMaaf"
                                                      .tr //Mohon maaf, jumlah pengiriman yang Anda miliki kurang dari ketentuan Transport Market
                                                  : "DemoBigFleetsShipperIndexMohonMaaf"
                                                      .tr, //Mohon maaf, jumlah kapasitas pengiriman rata - rata perhari Anda tidak mencapai batas minimum Big Fleets Shipper. Jangan khawatir, Anda dapat menikmati layanan Transport Market
                                              fontSize: 12,
                                              textAlign: TextAlign.center,
                                              fontWeight:
                                                  (modul == 'TRANSPORTMARKET'
                                                      ? FontWeight.w600
                                                      : FontWeight.w500),
                                              height: 1.5,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24),
                                          modul == 'TRANSPORTMARKET'
                                              ? Container(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          215,
                                                  child: Material(
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    color: Colors.white,
                                                    child: InkWell(
                                                        customBorder:
                                                            RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  18),
                                                        ),
                                                        onTap: () async {
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        12,
                                                                vertical:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        7),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue)),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            20)),
                                                            child: Center(
                                                              child: CustomText(
                                                                  'DemoTransportMarketTransporterIndexKembaliKeTransportMarket'
                                                                      .tr, //Kembali ke Transport Market
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorBlue),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))),
                                                  ))
                                              : Container(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          200,
                                                  child: Material(
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    color: Color(
                                                        ListColor.colorBlue),
                                                    child: InkWell(
                                                        customBorder:
                                                            RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  18),
                                                        ),
                                                        onTap: () async {
                                                          Get.back();
                                                          Get.back();
                                                          Get.back();
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      500), () {
                                                            Get.toNamed(
                                                                Routes
                                                                    .SELAMAT_DATANG,
                                                                arguments: [
                                                                  'TRANSPORTMARKET',
                                                                  'SHIPPER'
                                                                ]);
                                                          });
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        24,
                                                                vertical:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        7),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue)),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            20)),
                                                            child: Center(
                                                              child: CustomText(
                                                                  'DemoBigFleetsTransporterIndexLihatTransportMarket'
                                                                      .tr, //Lihat Transport Market
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                                Container(
                                    margin: EdgeInsets.only(
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8,
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                          child: GestureDetector(
                                              child: SvgPicture.asset(
                                        GlobalVariable.imagePath +
                                            'ic_close_blue.svg',
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                        color: Color(ListColor.color4),
                                      ))),
                                    ))
                              ])))));
            });
      }
    }
  }

  void popUpIndividu(modul, sisi) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    32),
                            Expanded(
                                // margin: EdgeInsets.only(
                                //   top: GlobalVariable.ratioWidth(Get.context) *
                                //       24,
                                // ),
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          modul == 'TRANSPORTMARKET' &&
                                                  sisi == 'SHIPPER'
                                              ? "DemoTransportMarketShipperIndexJenisAkunAnda"
                                                  .tr //Jenis Akun Anda Adalah Individu
                                              : modul == 'TRANSPORTMARKET' &&
                                                      sisi == 'TRANSPORTER'
                                                  ? "DemoTransportMarketTransporterIndexJenisAkunAnda"
                                                      .tr
                                                  : modul == 'BIGFLEET' &&
                                                          sisi == 'SHIPPER'
                                                      ? "DemoBigFleetsShipperIndexJenisAkunAnda"
                                                          .tr
                                                      : "DemoBigFleetsTransporterIndexJenisAkunAnda"
                                                          .tr,
                                          fontSize: 16,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      CustomText(
                                          modul == 'TRANSPORTMARKET' &&
                                                  sisi == 'SHIPPER'
                                              ? "DemoTransportMarketShipperIndexMohonMaafAkunIndividu"
                                                  .tr //Mohon maaf untuk mendaftar bigfleet
                                              : modul == 'TRANSPORTMARKET' &&
                                                      sisi == 'TRANSPORTER'
                                                  ? "DemoTransportMarketTransporterIndexMohonMaafAkunIndividu"
                                                      .tr
                                                  : modul == 'BIGFLEET' &&
                                                          sisi == 'SHIPPER'
                                                      ? "DemoBigFleetsShipperIndexMohonMaafAkunIndividu"
                                                          .tr
                                                      : "DemoBigFleetsTransporterIndexMohonMaafAkunIndividu"
                                                          .tr,
                                          fontSize: 12,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      8,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      child: GestureDetector(
                                          child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        'ic_close_blue.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    color: Color(ListColor.color4),
                                  ))),
                                ))
                          ])))));
        });
  }

  void popUpInternal() async {
    GlobalAlertDialog.showAlertDialogCustom(
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        context: Get.context,
        title: "",
        customMessage: CustomText("Internal AZ Halaman form ".tr,
            fontSize: 12,
            height: 1.5,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            color: Colors.black),
        isShowButton: false);
  }
}
