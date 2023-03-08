import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final String urlMedia;

  const ImagePreview({Key key, this.urlMedia}) : super(key: key);
  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.urlMedia,
      fit: BoxFit.fitHeight,
    );
  }
}
