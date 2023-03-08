import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/media_preview/media_preview_buyer.dart';
import 'package:muatmuat/app/template/media_preview/video_thumbnail_buyer.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

import '../../../../global_variable.dart';

class CarouselImageBuyer extends StatefulWidget {
  final int currentIndex;
  final List<String> imageList;

  const CarouselImageBuyer({
    Key key,
    this.currentIndex,
    this.imageList,
  }) : super(key: key);

  @override
  State<CarouselImageBuyer> createState() => _CarouselImageBuyerState();
}

class _CarouselImageBuyerState extends State<CarouselImageBuyer> {
  final _carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  Widget carouselImage(BuildContext context) {
    return Container(
      height: GlobalVariable.ratioWidth(context) * 203,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: CarouselSlider(
              items: imageSliders,
              carouselController: _carouselController,
              options: CarouselOptions(
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: false,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: GlobalVariable.ratioWidth(Get.context) * 12,
            left: GlobalVariable.ratioWidth(Get.context) * 16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                color: Color(ListColor.colorBlackTemplate).withOpacity(0.8),
              ),
              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 6),
              child: CustomText(
                '${(_currentIndex ?? 0) + 1}/${widget.imageList.length}',
                withoutExtraPadding: true,
                color: Color(ListColor.colorWhiteTemplate),
                fontWeight: FontWeight.w600,
                fontSize: 12,
                height: 14.4 / 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get imageSliders => widget.imageList.map((item) {
        return Container(
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              Get.to(
                () => MediaPreviewBuyer(
                  urlMedia: widget.imageList,
                  currentPos: _currentIndex,
                ),
              );
            },
            child: Builder(builder: (context) {
              if (item != null && item != "") {
                if (Utils.isItVideo.contains(item.split(".").last.toLowerCase())) {
                  return VideoThumbnailBuyer(
                    url: item,
                    fit: BoxFit.cover,
                  );
                }
              }
              // cek if it os a video
              return Image.network(
                item ?? '',
                fit: BoxFit.cover,
                width: Get.width,
                // errorBuilder: (context, error, stackTrace) => Image.asset(
                //   'assets/template_buyer/truck_placeholder_template.png',
                //   fit: BoxFit.cover,
                //   width: Get.width,
                // ),
              );
            }),
          ),
        );
      }).toList();

  @override
  Widget build(BuildContext context) {
    return carouselImage(context);
  }
}
