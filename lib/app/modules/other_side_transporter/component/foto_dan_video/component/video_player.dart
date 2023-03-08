import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String path;

  const VideoPlayer({Key key, this.path}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  Future<void> _future;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.path);
    // _videoPlayerController = VideoPlayerController.file(File(widget.path));
    _future = initVideoPlayer();
  }

  Future<void> initVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {
      log("::: RATIO = " + _videoPlayerController.value.aspectRatio.toString());
      _chewieController = ChewieController(
          customControls: MaterialControls(),
          videoPlayerController: _videoPlayerController,
          looping: false,
          // aspectRatio: 9 / 16,
          aspectRatio: _videoPlayerController.value.aspectRatio,
          autoInitialize: true,
          allowFullScreen: true,
          // showControls: true,
          placeholder: Center(
            child: LoadingComponent(),
          ),
          errorBuilder: (BuildContext ctx, String error) {
            error = "Terjadi kesalahan saat memuat video";
            return Center(
              child: CustomText(
                error,
                color: Color(ListColor.colorBlue),
              ),
            );
          },
          deviceOrientationsOnEnterFullScreen: [
            DeviceOrientation.landscapeLeft,
          ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Center(
          child: _videoPlayerController.value.initialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: Chewie(
                    controller: _chewieController,
                  ),
                )
              : CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }
}
