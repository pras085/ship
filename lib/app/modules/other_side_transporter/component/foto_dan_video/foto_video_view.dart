import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/foto_dan_video/component/image_preview.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/foto_dan_video/component/video_player.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/global_variable.dart';

import 'foto_video_controller.dart';

class FotoDanVideoView extends GetView<FotoDanVideoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarProfile(
        isBlueMode: true,
        onClickBack: () => Get.back(),
        title: "Foto dan Video",
        isCenter: false,
        isWithBackgroundImage: true,
        isWithShadow: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(context) * 24,
                    vertical: GlobalVariable.ratioWidth(context) * 20,
                  ),
                  constraints: BoxConstraints(
                    minHeight: GlobalVariable.ratioWidth(context) * 180,
                  ),
                  child: Obx(
                    () {
                      if (controller.dataFotoVideoResponse.value.state == ResponseStates.COMPLETE) {
                        final data = controller.dataFotoVideoResponse.value.data.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: GlobalVariable.ratioWidth(context) * 12,
                                crossAxisSpacing: GlobalVariable.ratioWidth(context) * 12,
                                childAspectRatio: 5 / 3,
                              ),
                              itemCount: data.length,
                              itemBuilder: (ctx, i) {
                                var isHaveData = i < data.length;
                                var isVideo = isHaveData ? data[i].fileType == "Video" : false;
                                return Material(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 10),
                                    side: isHaveData
                                        ? BorderSide.none
                                        : BorderSide(
                                            width: GlobalVariable.ratioWidth(context) * 1,
                                            color: Color(ListColor.colorBlue),
                                          ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: () async {
                                      if (isHaveData) {
                                        if (data[i].filePath != null) {
                                          // log('::INDEX  $i ' + '$isHaveData ' + '${data[i].filePath}');
                                          if (isVideo) {
                                            log('::: VIDEO  $i');
                                            await Get.dialog(
                                                Material(
                                                  child: VideoPlayer(path: data[i].filePath),
                                                ),
                                                useSafeArea: false,
                                                barrierDismissible: true);
                                          } else {
                                            log('::: PHOTO  $i');
                                            await Get.dialog(
                                              Material(
                                                color: Colors.transparent,
                                                child: Center(
                                                  child: ImagePreview(urlMedia: data[i].filePath),
                                                ),
                                              ),
                                              barrierDismissible: true,
                                              useSafeArea: false,
                                            );
                                          }
                                        }
                                      }
                                      // else {
                                      //   log('::INDEX  $i ' + '$isHaveData');
                                      //   // var result = await GetToPage.toNamed<UploadUbahFotoVideoController>(Routes.UPLOAD_UBAH_FOTO_VIDEO);
                                      //   controller.chooseFile();
                                      //   // controller.uploadFotoVideo("Gallery");
                                      // }
                                    },
                                    child: Container(
                                      width: GlobalVariable.ratioWidth(context) * 150,
                                      height: GlobalVariable.ratioWidth(context) * 90,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          if (isHaveData)
                                            Positioned.fill(
                                              child: !isVideo
                                                  ? CachedNetworkImage(
                                                      imageUrl: data[i].filePath,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : FutureBuilder(
                                                      future: controller.generateThumbnail(data[i].filePath),
                                                      builder: (BuildContext ctx, AsyncSnapshot<File> snap) {
                                                        if (snap.hasData) {
                                                          log('::: SUKKESSS');
                                                        } else {
                                                          log('::: KOSONG');
                                                          return Center(
                                                            child: CircularProgressIndicator(
                                                              backgroundColor: Color(ListColor.colorYellowTransporter),
                                                            ),
                                                          );
                                                        }
                                                        return Image.file(
                                                          snap.data,
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                            )
                                          else
                                            SizedBox(),
                                          // Align(
                                          //   alignment: Alignment.center,
                                          //   child: Column(
                                          //     mainAxisSize: MainAxisSize.min,
                                          //     children: [
                                          //       SvgPicture.asset(
                                          //         "assets/ic_add_2,5.svg",
                                          //         width: GlobalVariable.ratioWidth(context) * 18,
                                          //         height: GlobalVariable.ratioWidth(context) * 18,
                                          //         color: Color(ListColor.colorBlue),
                                          //       ),
                                          //       SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                                          //       CustomText(
                                          //         "Tambah",
                                          //         fontSize: 12,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Color(ListColor.colorBlue),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // if (isHaveData)
                                          //   Positioned(
                                          //     top: GlobalVariable.ratioWidth(context) * 5,
                                          //     right: GlobalVariable.ratioWidth(context) * 4,
                                          //     child: InkWell(
                                          //       onTap: () async {
                                          //         log('::DELETE  $i ' + '${data[i].iD}');
                                          //         controller.deletePhoto(data[i].iD.toString());
                                          //       },
                                          //       child: SvgPicture.asset(
                                          //         "assets/ic_close_rounded.svg",
                                          //         width: GlobalVariable.ratioWidth(context) * 18,
                                          //         height: GlobalVariable.ratioWidth(context) * 18,
                                          //       ),
                                          //     ),
                                          //   ),
                                          if (isVideo)
                                            Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: GlobalVariable.ratioWidth(context) * 22,
                                                width: GlobalVariable.ratioWidth(context) * 24,
                                                child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Color(ListColor.colorWhite),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: GlobalVariable.ratioWidth(context) * 12),
                          ],
                        );
                      } else if (controller.dataFotoVideoResponse.value.state == ResponseStates.ERROR) {
                        return ErrorDisplayComponent(
                          "${controller.dataFotoVideoResponse.value.exception}",
                          onRefresh: () => controller.fetchFotoVideo(),
                        );
                      }
                      return LoadingComponent();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
