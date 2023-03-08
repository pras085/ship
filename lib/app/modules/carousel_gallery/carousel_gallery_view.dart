import 'package:carousel_slider/carousel_slider.dart';
// import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:muatmuat/app/modules/carousel_gallery/carousel_gallery_controller.dart';
import 'package:video_player/video_player.dart';

class CarouselGalleryView extends GetView<CarouselGalleryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child:
            // Obx(() =>
            CarouselSlider.builder(
          itemCount: controller.link.length,
          options: CarouselOptions(
              pageSnapping: true,
              height: context.mediaQuery.size.height,
              viewportFraction: 1,
              initialPage: 0,
              onPageChanged: (index, reason) {}),
          itemBuilder: (context, index) {
            var link = controller.link[index];
            var regexVideo = RegExp(r'^.*.mp4$');
            var isVideo = regexVideo.hasMatch(link);
            return Container(
              color: Colors.black,
              child: isVideo
                  ? videoView(link, index)
                  : Image.network(
                      link,
                      width: context.mediaQuery.size.width,
                    ),
            );
          },
        ),
        // ),
      ),
    );
  }
}

Widget videoView(String link, int index) {
  var isPlaying = false.obs;
  var videoController = VideoPlayerController.network(link)
    ..initialize().then((value) => null);
  videoController.initialize();
  // var chewieController = ChewieController(
  //   videoPlayerController: videoController,
  //   autoPlay: false,
  //   looping: false,
  //   // customControls: Stack(
  //   //   alignment: Alignment.center,
  //   //   children: [Container(width: 200, height: 200)],
  //   // )
  // );

  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
          width: Get.context.mediaQuery.size.width,
          child: AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            // child:
            //     // VideoPlayer(videoController)
            //     Chewie(controller: chewieController)
          )),
      // Align(
      //     alignment: Alignment.bottomCenter,
      //     child: Obx(
      //       () => IconButton(
      //         icon: Icon(
      //           isPlaying.value ? Icons.pause : Icons.play_arrow,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           if (isPlaying.value) {
      //             videoController.pause();
      //             isPlaying.value = false;
      //           } else {
      //             videoController.play();
      //             isPlaying.value = true;
      //           }
      //         },
      //       ),
      //     ))
    ],
  );
}
