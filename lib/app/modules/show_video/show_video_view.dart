// import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/show_video/show_video_controller.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:video_player/video_player.dart';

class ShowVideoView extends GetView<ShowVideoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: Obx(() => controller.ready.value
            ? Chewie(controller: controller.chewieController)
            : CustomText("Loading")),
      ),
    );
    // var videoController = VideoPlayerController.network(
    //     "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4")
    //   ..initialize().then((value) => null);
    // videoController.initialize();
    // var chewieController = ChewieController(
    //   videoPlayerController: videoController,
    //   autoPlay: false,
    //   looping: false,
    //   // customControls: Stack(
    //   //   alignment: Alignment.center,
    //   //   children: [Container(width: 200, height: 200, color: Colors.green)],
    //   // )
    // );

    // return Scaffold(
    //   body: Container(
    //     child: Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Container(
    //             width: Get.context.mediaQuery.size.width,
    //             child: AspectRatio(
    //                 aspectRatio: videoController.value.aspectRatio,
    //                 child:
    //                     // VideoPlayer(videoController)
    //                     Chewie(controller: chewieController))),
    //       ],
    //     ),
    //   ),
    // );
    // return Scaffold(
    //     body: Container(
    //   color: Colors.black,
    //   height: context.mediaQuery.size.height,
    //   child: Stack(
    //     alignment: Alignment.center,
    //     children: [
    //       AspectRatio(
    //         aspectRatio: 16 / 9,
    //         child: Container(
    //           color: Colors.green,
    //           child: Obx(
    //             () => BetterPlayerPlaylist(
    //                 betterPlayerConfiguration: BetterPlayerConfiguration(),
    //                 betterPlayerPlaylistConfiguration:
    //                     const BetterPlayerPlaylistConfiguration(),
    //                 betterPlayerDataSourceList:
    //                     controller.dataSourceList.value),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // ));
  }
}
