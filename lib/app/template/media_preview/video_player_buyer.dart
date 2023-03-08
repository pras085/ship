import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBuyer extends StatefulWidget {
  final String path;

  const VideoPlayerBuyer({Key key, this.path}) : super(key: key);

  @override
  _VideoPlayerBuyerState createState() => _VideoPlayerBuyerState();
}

class _VideoPlayerBuyerState extends State<VideoPlayerBuyer> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.path);
  }

  Future<bool> _initializeVideo() async {
    try {
      await _videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        autoInitialize: true,
        autoPlay: false,
        looping: false,
        errorBuilder: (BuildContext ctx, String error) {
          error = "Terjadi kesalahan saat memuat video";
          return Center(
            child: CustomText(
              error,
              color: Colors.white,
            ),
          );
        },
        deviceOrientationsOnEnterFullScreen: [
          DeviceOrientation.landscapeLeft,
        ],
      );
      return true;
    } catch (error) {
      if (kDebugMode) print("ERROR $error");
      throw "failed to load video!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: _initializeVideo(),
          builder: (ctx, snap) {
            if (snap.hasData && snap.data) {
              return Chewie(
                controller: _chewieController,
              );
            } else if (snap.hasError) {
              return Center(
                child: CustomText(
                  snap.error,
                  color: Colors.white,
                ),
              );
            }
            return LoadingComponent();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_chewieController != null) _chewieController.dispose();
    if (_chewieController != null) _videoPlayerController.dispose();
    super.dispose();
  }
}
