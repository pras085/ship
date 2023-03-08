import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/other_side_transporter/component/foto_dan_video/foto_video_gold_model.dart';
import 'package:muatmuat/app/modules/other_side_transporter/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FotoDanVideoController extends GetxController {
  var dataTransporterC = Get.find<OtherSideTransController>();
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  var canSave = false.obs;
  var isVideo = false.obs;
  var fileUpload = File('').obs;
  var errorMessage = "".obs;

  // MODEL
  var dataFotoVideoResponse = ResponseState<FotoVideoGoldModel>().obs;

  // LIST
  var listDataShipperSelected = [];

  @override
  void onInit() async {
    super.onInit();
    await fetchFotoVideo();
    // await initializePlayer();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
    // chewieController.dispose();
  }

  Future<void> fetchFotoVideo() async {
    try {
      dataFotoVideoResponse.value = ResponseState.loading();
      final response = await ApiProfile(context: Get.context).getFotoVideoTransporter('${dataTransporterC.idtrans.value}');
      if (response != null) {
        // convert json to object
        dataFotoVideoResponse.value = ResponseState.complete(FotoVideoGoldModel.fromJson(response));
        if (dataFotoVideoResponse.value.data.message.code == 200) {
          // sukses
        } else {
          // error
          if (dataFotoVideoResponse.value.data.message != null && dataFotoVideoResponse.value.data.message.code == 200) {
            throw ("${dataFotoVideoResponse.value.data.message.text}");
          }
          throw ("failed to fetch data!");
        }
      } else {
        // error
        throw ("failed to fetch data!");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataFotoVideoResponse.value = ResponseState.error("$error");
    }
  }

  Future<File> generateThumbnail(String name) async {
    final videoThumbnail = await VideoThumbnail.thumbnailFile(
      video: name,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
    );
    log(':::: THUMB = $videoThumbnail');
    return File(videoThumbnail);
  }
}
