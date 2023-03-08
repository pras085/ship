import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';

class ZoBannerWidget extends StatefulWidget {
  final CarouselController carouselController;
  final List<Widget> items;
  final void Function(int index, CarouselPageChangedReason reason)
      onPageChanged;

  ZoBannerWidget({
    Key key,
    @required this.items,
    CarouselController carouselController,
    this.onPageChanged,
  })  : this.carouselController = carouselController ?? CarouselController(),
        super(key: key);

  @override
  State<ZoBannerWidget> createState() => _ZoBannerWidgetState();
}

class _ZoBannerWidgetState extends State<ZoBannerWidget> {
  var currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: widget.carouselController,
          options: CarouselOptions(
            scrollPhysics: widget.items.length > 1
                ? null
                : const NeverScrollableScrollPhysics(),
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              widget.onPageChanged?.call(index, reason);
              setState(() => currentPage = index);
            },
            // height: GlobalVariable.ratioWidth(context) * 159,
            aspectRatio: 360 / 134,
            autoPlay: widget.items.length > 1,
            autoPlayInterval: const Duration(seconds: 10),
          ),
          items: widget.items,
        ),
        if (widget.items.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items.asMap().entries.map((entry) {
              return Container(
                width: GlobalVariable.ratioWidth(context) * 6,
                height: GlobalVariable.ratioWidth(context) * 6,
                margin: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(context) * 6.0,
                  horizontal: GlobalVariable.ratioWidth(context) * 2.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPage == entry.key
                      ? Color(ListColor.colorYellow)
                      : Color(ListColor.colorWhite),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
