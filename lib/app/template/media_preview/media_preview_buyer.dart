import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/media_preview/video_player_buyer.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'video_thumbnail_buyer.dart';

class MediaPreviewBuyer extends StatefulWidget {

  final List<String> urlMedia;
  final int currentPos;
  final bool hideIndicator;

  const MediaPreviewBuyer({
    @required this.urlMedia,
    this.currentPos = 0,
    this.hideIndicator = false,
  });

  @override
  _MediaPreviewBuyerState createState() => _MediaPreviewBuyerState();
}

class _MediaPreviewBuyerState extends State<MediaPreviewBuyer> with SingleTickerProviderStateMixin {

  PageController pageController;
  int selectedPosition;
  TapDownDetails position;
  TransformationController transformationController = TransformationController();
  Animation<Matrix4> scaleAnimation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.currentPos ?? 0,
    );
    selectedPosition = widget.currentPos ?? 0;
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..addListener(() {
      transformationController.value = scaleAnimation.value;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    animationController.dispose();
    transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.urlMedia.length,
                itemBuilder: (_, i) {
                  final url = widget.urlMedia[i] ?? '';
                  // cek if it os a video
                  if (Utils.isItVideo.contains(url.split(".").last.toLowerCase())) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => VideoPlayerBuyer(
                          path: url,
                        ));
                      },
                      child: VideoThumbnailBuyer(
                        url: url,
                      ),
                    );
                  }
                  // if it is an image
                  if (Utils.isItImage.contains(url.split(".").last.toLowerCase())) {
                    return GestureDetector(
                      // get position tap by collecting data from details here
                      onDoubleTapDown: (details) {
                        position = details;
                        setState(() {});
                      },
                      onDoubleTap: () {
                        if (position != null) {
                          final pos = position.localPosition;
                          double scale = 3;
                          final x = -pos.dx * (scale - 1);
                          final y = -pos.dy * (scale - 1);
                          final zoomed = Matrix4.identity()
                            ..translate(x, y)
                            ..scale(scale);
                          final end = transformationController.value.isIdentity() ? zoomed : Matrix4.identity();
                          scaleAnimation = Matrix4Tween(
                            begin: transformationController.value,
                            end: end,
                          ).animate(CurveTween(curve: Curves.easeInOut).animate(animationController));
                          animationController.forward(from: 0);
                        }
                      },
                      child: InteractiveViewer(
                        transformationController: transformationController,
                        child: imageBuilder(url),
                      ),
                    );
                  }
                  return Center(
                    child: CustomText("The data is not a media!",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 14.4/12,
                      color: Colors.white,
                    ),
                  );
                },
                physics: const BouncingScrollPhysics(),
                onPageChanged: (pos) {
                  selectedPosition = pos;
                  setState(() {});
                },
              ),
            ),
            if (!widget.hideIndicator)
              Positioned(
                bottom: GlobalVariable.ratioWidth(context) * 20,
                left: GlobalVariable.ratioWidth(context) * 16,
                right: 0,
                child: SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 111,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(context) * 2,
                        ),
                        child: CustomText("${selectedPosition+1}/${widget.urlMedia.length}",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 14.4/12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(context) * 20,
                      ),
                      Expanded(
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.urlMedia.length,
                          separatorBuilder: (_, __) {
                            return SizedBox(
                              width: GlobalVariable.ratioWidth(context) * 8,
                            );
                          },
                          padding: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(context) * 16,
                          ),
                          itemBuilder: (c, i) {
                            return GestureDetector(
                              onTap: () {
                                pageController.animateToPage(i, 
                                  duration: Duration(
                                    milliseconds: 200,
                                  ), 
                                  curve: Curves.easeIn,
                                );
                              },
                              child: Container(
                                width: GlobalVariable.ratioWidth(context) * 80,
                                height: GlobalVariable.ratioWidth(context) * 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: GlobalVariable.ratioWidth(context) * 4,
                                    color: selectedPosition == i ? Color(0xFF176CF7) : Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(context) * 4,
                                  ),
                                ),
                                child: Builder(
                                  builder: (c) {
                                    final url = widget.urlMedia[i] ?? '';
                                    // cek if it os a video
                                    if (Utils.isItVideo.contains(url.split(".").last.toLowerCase())) {
                                      return VideoThumbnailBuyer(
                                        url: url,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    // if it is an image
                                    else if (Utils.isItImage.contains(url.split(".").last.toLowerCase())) {
                                      return imageBuilder(url,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                    return Center(
                                      child: CustomText("The data is not a media!",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 14.4/12,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: GlobalVariable.ratioWidth(context) * 16,
              left: GlobalVariable.ratioWidth(context) * 16,
              child: InkWell(
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  GlobalVariable.urlImageTemplateBuyer + 'ic_close_shipper.svg',
                  color: Color(ListColor.colorWhiteTemplate),
                  height: GlobalVariable.ratioWidth(context) * 24,
                  width: GlobalVariable.ratioWidth(context) * 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageBuilder(String url, {
    BoxFit fit = BoxFit.contain,
  }) {
    return Image.network(
      url,
      width: GlobalVariable.ratioWidth(context) * 80,
      height: GlobalVariable.ratioWidth(context) * 80,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
      errorBuilder: (context, child, stackTrace) {
        return Image.asset(
          GlobalVariable.urlImageTemplateBuyer + 'truck_placeholder_template.png', 
          height: GlobalVariable.ratioWidth(context) * 80, 
          fit: BoxFit.contain,
        );
      },
    );
  }

}