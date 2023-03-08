import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoDialog extends PopupRoute {
  final List<String> url;
  final int curIndex;
  late PageController _pageController;

  PhotoDialog(
    this.url, 
    this.curIndex
  ){
    _pageController = PageController(initialPage: curIndex);
  }

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    debugPrint('curIndex '+curIndex.toString());
    debugPrint('cur '+url[curIndex]);
    
    return _builder(context);
  }

  Widget _builder(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions.customChild(
              minScale: 0.5,
              child: CachedNetworkImage(
                imageUrl: url[index],
                progressIndicatorBuilder: (context, _, progress){
                  return Center(
                    child: CircularProgressIndicator()
                  );
                },
              ),
              //child: Image.network(url[index], loadingBuilder: (_, __, ___) => CircularProgressIndicator(),),
            );
          },
          // loadingBuilder: CircularProgressIndicator(),
          itemCount: url.length,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
              ),
            ),
          ),
          // backgroundDecoration: widget.backgroundDecoration,
          pageController: _pageController,
          // onPageChanged: onPageChanged,
        ),
      );
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 0);
}