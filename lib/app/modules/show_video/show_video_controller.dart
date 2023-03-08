// import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShowVideoController extends GetxController {
  // var link = [
  //   "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
  //   "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4"
  // ].obs;
  ChewieController chewieController;
  VideoPlayerController videoController;
  // var isPlaying = false.obs;
  var ready = false.obs;
  // var dataSourceList = <BetterPlayerDataSource>[].obs;

  @override
  void onInit() async {
    List<String> videoUrl = Get.arguments[0];
    videoController = VideoPlayerController.network(videoUrl[0])
      ..initialize().then((value) => null);
    // videoController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: false,
      looping: false,
      // customControls: Stack(
      //   alignment: Alignment.center,
      //   children: [Container(width: 200, height: 200)],
      // )
    );
    ready.value = true;

    // List<String> videoUrl = Get.arguments[0];
    // videoUrl.forEach((element) {
    //   dataSourceList.add(
    //     BetterPlayerDataSource(BetterPlayerDataSourceType.network, element),
    //   );
    // });
    // dataSourceList.add(
    //   BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.network,
    //     "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    //   ),
    // );
    // dataSourceList.add(
    //   BetterPlayerDataSource(BetterPlayerDataSourceType.network,
    //       "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"),
    // );
    // dataSourceList.add(
    //   BetterPlayerDataSource(BetterPlayerDataSourceType.network,
    //       "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"),
    // );
  }

  @override
  void onReady() async {}

  @override
  void onClose() async {
    videoController.dispose();
    chewieController.dispose();
  }
}
