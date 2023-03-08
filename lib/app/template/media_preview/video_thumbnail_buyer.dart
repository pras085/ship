import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../global_variable.dart';

class VideoThumbnailBuyer extends StatefulWidget {

  final String url;
  final BoxFit fit;

  const VideoThumbnailBuyer({
    Key key,
    @required this.url,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  State<VideoThumbnailBuyer> createState() => _VideoThumbnailBuyerState();
}

class _VideoThumbnailBuyerState extends State<VideoThumbnailBuyer> with AutomaticKeepAliveClientMixin {

  Future<File> generateThumbnail(String name) async {
    final videoThumbnail = await VideoThumbnail.thumbnailFile(
      video: name,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 10,
    );
    return File(videoThumbnail);
  }

  @override
  Widget build(BuildContext context) {
    print("HEREEEEEEE ${widget.url}");
    return FutureBuilder<File>(
      future: generateThumbnail(widget.url),
      builder: (ctx, snap) {
        if (snap.hasData) {  
          return Stack(
            children: [
              Positioned.fill(
                child: Image.file(
                  snap.data,
                  fit: widget.fit,
                  errorBuilder: (context, child, stackTrace) {
                    return Center(
                      child: CustomText("Failed to load image!",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 14.4/12,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(Icons.play_circle_fill,
                  size: GlobalVariable.ratioWidth(context) * 24,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ],
          );
        }
        return ColoredBox(
          color: Color(0xFFC6CBD4),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
  
}