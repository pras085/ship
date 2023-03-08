import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/template/appbar/appbar_detail_buyer.dart';
import 'package:muatmuat/app/template/detail/detail_title_product_buyer.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'example_detail_buyer_product_controller.dart';

// CONTOH LIST IMAGE
final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class ExampleDetailProductBuyer extends GetView<ExampleDetailProductBuyerController> {
  CarouselController carouselC;

  var current = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarDetailBuyer(
        // title: 'Laporkan Iklan',
        onClickBack: () => Get.back(),
        onClickFavorite: () {
          controller.favorite = !controller.favorite;
        },
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(ListColor.colorBgTemplate1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              carouselImage(context),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 5,
                child: ColoredBox(color: Colors.transparent),
              ),
              content(context),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 5,
                child: ColoredBox(color: Colors.transparent),
              ),
              componentSellerProfile(context),
              componentLaporkanIklan(context, 'Ada masalah dengan iklan ini ?'),
            ],
          ),
        ),
      ),
    );
  }

  Widget carouselImage(BuildContext context) {
    return Container(
      height: GlobalVariable.ratioWidth(context) * 203,
      width: double.infinity,
      child: CarouselSlider(
        items: imageSliders,
        carouselController: carouselC,
        options: CarouselOptions(
          viewportFraction: 1.0,
          initialPage: 0,
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {
            current.value = index;
          },
        ),
      ),
    );
  }

  final List<Widget> imageSliders = imgList.map((item) {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              log(':::: INDEX = ' + imgList.indexOf(item).toString());
            },
            child: Image.network(
              item,
              fit: BoxFit.cover,
              width: Get.width,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                color: Color(ListColor.colorBlackTemplate).withOpacity(0.8),
              ),
              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 6),
              child: CustomText(
                '${imgList.indexOf(item) + 1}/${imgList.length}',
                withoutExtraPadding: true,
                color: Color(ListColor.colorWhiteTemplate),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  Widget content(BuildContext context) {
    var gap = SizedBox(height: GlobalVariable.ratioWidth(context) * 12);

    return Container(
      color: Color(ListColor.colorWhiteTemplate),
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Aki ACCU Basah INCOE Gold N50z, Truk Tronton, Engkel, Colt Diesel, Elf',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            withoutExtraPadding: true,
            height: 19.2 / 16,
          ),
          gap,
          CustomText(
            'Rp200.000',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 24 / 20,
            withoutExtraPadding: true,
          ),
          gap,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                GlobalVariable.urlImageTemplateBuyer + 'temp_location_blue.svg',
                width: GlobalVariable.ratioWidth(context) * 18,
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
              CustomText(
                'Tanggerang, Tanggerang Kota',
                height: 24 / 20,
                withoutExtraPadding: true,
                color: Color(ListColor.colorGreyTemplate),
              ),
              Spacer(),
              CustomText(
                '21 Nov 2022',
                withoutExtraPadding: true,
                color: Color(ListColor.colorGreyTemplate),
              ),
            ],
          ),
        ],
      ),
    );
  }

  openMediaPreview(BuildContext ctx, String index) {
    return showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        backgroundColor: Color(ListColor.colorBlackTemplate),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        content: Builder(
          builder: (ctx) {
            var height = double.infinity - GlobalVariable.ratioWidth(ctx) * 10;
            var width = double.infinity - GlobalVariable.ratioWidth(ctx) * 10;
            return SizedBox(
              width: width,
              height: height,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: index,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: _closeButton(ctx),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: carouselPreview(ctx),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget carouselPreview(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      height: GlobalVariable.ratioWidth(context) * 80,
      width: GlobalVariable.ratioWidth(context) * 80,
      child: CarouselSlider(
        items: imageSliders,
        carouselController: carouselC,
        options: CarouselOptions(
          viewportFraction: 1.0,
          initialPage: 0,
          enlargeCenterPage: false,
          onPageChanged: (index, reason) {
            current.value = index;
          },
        ),
      ),
    );
  }

  Widget _closeButton(context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: Get.back,
        child: Container(
          height: GlobalVariable.ratioWidth(context) * 24,
          child: SvgPicture.asset(
            GlobalVariable.urlImageTemplateBuyer +'ic_close_shipper.svg',
            color: Color(ListColor.colorWhiteTemplate),
          ),
        ),
      ),
    );
  }

  Widget componentSellerProfile(BuildContext context) {
    return Container(
      // height: GlobalVariable.ratioWidth(context) * 134,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 14,
              GlobalVariable.ratioWidth(context) * 16,
              GlobalVariable.ratioWidth(context) * 12,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(ListColor.colorWhiteTemplate),
              border: Border(
                bottom: BorderSide(
                  color: Color(ListColor.colorGreyTemplate2),
                  width: GlobalVariable.ratioWidth(context) * 0.5,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Container(
                      height: GlobalVariable.ratioWidth(context) * 40,
                      width: GlobalVariable.ratioWidth(context) * 40,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 20),
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(ListColor.colorBorderTemplate)),
                      ),
                      child: SizedBox(),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        GlobalVariable.urlImageTemplateBuyer + 'ic_buyer_verified_template.svg',
                        height: GlobalVariable.ratioWidth(context) * 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'PT. Super Truck',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      withoutExtraPadding: true,
                    ),
                    SizedBox(height: GlobalVariable.ratioWidth(context) * 8),
                    RichText(
                      text: TextSpan(
                        text: 'Anggota Sejak : ',
                        style: TextStyle(
                          fontFamily: 'AvenirNext',
                          fontSize: GlobalVariable.ratioWidth(context) * 14,
                          color: Color(ListColor.colorGreyTemplate3),
                          fontWeight: FontWeight.w500,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '2020',
                            style: TextStyle(
                              fontFamily: 'AvenirNext',
                              fontSize: GlobalVariable.ratioWidth(context) * 14,
                              color: Color(ListColor.colorBlackTemplate1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          componentFixedButton(context)
        ],
      ),
    );
  }

  Widget componentFixedButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 12,
        GlobalVariable.ratioWidth(context) * 16,
        GlobalVariable.ratioWidth(context) * 24,
      ),
      decoration: BoxDecoration(
        color: Color(ListColor.colorWhiteTemplate),
        border: Border(
          bottom: BorderSide(
            color: Color(ListColor.colorGreyTemplate2),
            width: GlobalVariable.ratioWidth(context) * 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _button(
              width: 197,
              height: 32,
              useBorder: true,
              borderColor: Color(ListColor.colorBlue),
              borderSize: 1,
              borderRadius: 18,
              text: 'Lihat Barang Lainnya',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.colorBlue),
              backgroundColor: Color(ListColor.colorWhiteTemplate),
              onTap: () async {}),
          SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
          _button(
            width: 119,
            height: 32,
            borderRadius: 18,
            onTap: () {},
            backgroundColor: Color(ListColor.colorBlueTemplate1),
            text: 'Hubungi',
            color: Color(ListColor.colorWhiteTemplate),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            useBorder: false,
          ),
        ],
      ),
    );
  }

  Widget componentLaporkanIklan(BuildContext context, String text) {
    var gap = SizedBox(width: GlobalVariable.ratioWidth(context) * 2);
    return Container(
      width: double.infinity,
      height: GlobalVariable.ratioWidth(context) * 46,
      color: Color(ListColor.colorBlueTemplate2).withOpacity(0.5),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text,
            withoutExtraPadding: true,
          ),
          gap,
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  GlobalVariable.urlImageTemplateBuyer + 'ic_flag_template.svg',
                  height: gap.width + 12,
                  color: Color(ListColor.colorBlueTemplate1),
                ),
                gap,
                CustomText(
                  'Laporkan',
                  withoutExtraPadding: true,
                  color: Color(ListColor.colorBlueTemplate1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(
      {double height,
      double width,
      bool maxWidth = false,
      double marginLeft = 0,
      double marginTop = 0,
      double marginRight = 0,
      double marginBottom = 0,
      double paddingLeft = 0,
      double paddingTop = 0,
      double paddingRight = 0,
      double paddingBottom = 0,
      bool useShadow = false,
      bool useBorder = true,
      double borderRadius = 18,
      double borderSize = 1,
      String text = "",
      @required Function onTap,
      FontWeight fontWeight = FontWeight.w600,
      double fontSize = 12,
      Color color = Colors.white,
      Color backgroundColor = Colors.white,
      Color borderColor,
      Widget customWidget}) {
    return Container(
      margin: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * marginLeft, GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight, GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(GlobalVariable.ratioWidth(Get.context) * paddingLeft, GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight, GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}
