import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/appbar_profile.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/loading_component.dart';
import 'package:muatmuat/app/widgets/error_display_component.dart';
import 'package:muatmuat/app/widgets/radio_button_custom_widget.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'testimoni_model.dart';
import 'testimoni_controller.dart';

class TestimoniView extends GetView<TestimoniController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(preferredSize: Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56)),
      body: _content(context)
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
            final data = controller.dataModelResponse.value.data;
            return Container(
              color: Colors.white,
              width: double.infinity,
              height: GlobalVariable.ratioWidth(context) * 84,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText("${data.supportingData.averageAllRating ?? 0}",
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(context) * 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _starWidget(
                          context, 
                          (data.supportingData.averageAllRating ?? 0).toInt(),
                          16,
                          9
                        ),    
                        SizedBox(
                          height: GlobalVariable.ratioWidth(context) * 4, // -2px customText
                        ),
                        CustomText("(${data.supportingData.realCountData ?? 0}) ${"TestimoniIndexUlasan".tr}"),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        }),
        Container(
          color: Colors.white,
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: GlobalVariable.ratioWidth(context) * 54,
          ),
          padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(context) * 16,
            GlobalVariable.ratioWidth(context) * 0,
            GlobalVariable.ratioWidth(context) * 16,
            GlobalVariable.ratioWidth(context) * 14,
          ),
          margin: EdgeInsets.only(
            bottom: GlobalVariable.ratioWidth(context) * 14,
          ),
          child: Column(
            children: [
              Obx(() {
                if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
                  return SizedBox.shrink();
                } 
                return SizedBox(
                  height: GlobalVariable.ratioWidth(context) * 14,
                );
              }),
              Obx(() {
                final isLoad = controller.dataModelResponse.value.state == ResponseStates.COMPLETE;
                final data = controller.dataModelResponse.value.data;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: GlobalVariable.ratioWidth(context) * 1,
                      color: Color(ListColor.colorLightGrey10),
                    ),
                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(context) * 6,
                    horizontal: GlobalVariable.ratioWidth(context) * 12,
                  ),
                  child: InkWell(
                    onTap: !isLoad ? null : () {
                      final ratingList = [
                        DataJumlahRating(
                          rating: 0,
                          countRating: data.supportingData.realCountData,
                          displayCountRating: data.supportingData.totalCountDataRating,
                        ),
                      ];
                      ratingList.addAll(data.supportingData.dataJumlahRating);
                      controller.selectedRating.value = controller.selectedRatingResult.value;
                      showModalBottomSheet(
                        context: context, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 17),
                            topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 17),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        builder: (ctx) {
                          return Container(
                            height: GlobalVariable.ratioWidth(context) * 404,
                            padding: EdgeInsets.symmetric(
                              horizontal: GlobalVariable.ratioWidth(context) * 16,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 4),
                                    color: Color(ListColor.colorLightGrey16),
                                  ),
                                  width: GlobalVariable.ratioWidth(context) * 38,
                                  height: GlobalVariable.ratioWidth(context) * 2.74,
                                  margin: EdgeInsets.only(
                                    top: GlobalVariable.ratioWidth(context) * 8,
                                    bottom: GlobalVariable.ratioWidth(context) * 13.26,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: GlobalVariable.ratioWidth(context) * 24,
                                      height: GlobalVariable.ratioWidth(context) * 24,
                                      child: InkWell(
                                        onTap: Get.back,
                                        child: SvgPicture.asset('assets/ic_close1,5.svg',
                                          width: GlobalVariable.ratioWidth(context) * 15,
                                          height: GlobalVariable.ratioWidth(context) * 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints(
                                        minHeight: GlobalVariable.ratioWidth(context) * 18,
                                      ),
                                      margin: EdgeInsets.only(
                                        top:  GlobalVariable.ratioWidth(context) * 2,
                                      ),
                                      child: CustomText(
                                        "TestimoniIndexPilihTestimoni".tr,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(ListColor.colorBlue),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(context) * 276,
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: ratingList.length,
                                        itemBuilder: (c, i) {
                                          return InkWell(
                                            onTap: () {
                                              controller.selectedRating.value = i == 0 ? "0" : "${ratingList[i].rating}";
                                            },
                                            child: Container(
                                              height: GlobalVariable.ratioWidth(context) * 46,
                                              padding: EdgeInsets.fromLTRB(
                                                GlobalVariable.ratioWidth(context) * 10,
                                                GlobalVariable.ratioWidth(context) * 0,
                                                GlobalVariable.ratioWidth(context) * 15,
                                                GlobalVariable.ratioWidth(context) * 0,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(ListColor.colorStroke),
                                                    width: GlobalVariable.ratioWidth(context) * 1,
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset("assets/ic_star_frame.svg",
                                                      width: GlobalVariable.ratioWidth(context) * 15,
                                                      height: GlobalVariable.ratioWidth(context) * 15,
                                                    ),
                                                    SizedBox(
                                                      width: GlobalVariable.ratioWidth(context) * 5,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          top: GlobalVariable.ratioWidth(context) * 2,
                                                        ),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: i == 0 ? "TestimoniIndexSemua".tr 
                                                            : "${Get.locale == Locale('id') ? ("TestimoniIndexStar".tr + " ") : ""}${ratingList[i].rating}${Get.locale == Locale('id') ? "" : (" " + (ratingList[i].rating == 1 ? "TestimoniIndexStar".tr : "TestimoniIndexStars".tr))}",
                                                            style: TextStyle(
                                                              fontFamily: "AvenirNext",
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.black,
                                                            ),
                                                            children: [
                                                              if (i != 0)
                                                                TextSpan(
                                                                  text: " (${ratingList[i].displayCountRating})",
                                                                  style: TextStyle(
                                                                    fontFamily: "AvenirNext",
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Color(ListColor.colorGrey3),
                                                                  ),
                                                                ),
                                                            ]
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    IgnorePointer(
                                                      ignoring: true,
                                                      child: Obx(
                                                        () => RadioButtonCustom(
                                                          colorSelected:
                                                              Color(ListColor.colorBlue),
                                                          colorUnselected:
                                                              Color(ListColor.colorBlue),
                                                          isWithShadow: true,
                                                          isDense: true,
                                                          width: GlobalVariable.ratioWidth(context) * 16,
                                                          height: GlobalVariable.ratioWidth(context) * 16,
                                                          groupValue: controller.selectedRating.value,
                                                          value: i == 0 ? "0" : "${ratingList[i].rating}",
                                                          onChanged: (value) {
                                                            // controller.selectedRating.value = value;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height:  GlobalVariable.ratioWidth(context) * 12,
                                    ),
                                    _button(
                                      onTap: () {
                                        controller.selectedRatingResult.value = controller.selectedRating.value;
                                        controller.fetchDataTestimoni();
                                        Get.back();
                                      },
                                      height: 36,
                                      borderRadius: 18,
                                      backgroundColor: Color(ListColor.colorBlue),
                                      color: Colors.white,
                                      text: "TestimoniIndexTerapkanFilter".tr,
                                    ),
                                    SizedBox(
                                      height:  GlobalVariable.ratioWidth(context) * 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(controller.selectedRatingResult.value == "0" ? 
                            "${"TestimoniIndexSemua".tr} (${isLoad ? data.supportingData.totalCountDataRating : 0})" 
                            : "${Get.locale == Locale('id') ? ("TestimoniIndexStar".tr + " ") : ""}${controller.selectedRatingResult.value}${Get.locale == Locale('id') ? "" : (" " + (controller.selectedRatingResult.value == "1" ? "TestimoniIndexStar".tr : "TestimoniIndexStars".tr))}",
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          SvgPicture.asset("assets/filter_icon.svg",
                            width: GlobalVariable.ratioWidth(context) * 24,
                            height: GlobalVariable.ratioWidth(context) * 24,
                            color: Color(ListColor.colorGrey3),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            if (controller.dataModelResponse.value.state == ResponseStates.COMPLETE) {
              final dataList = controller.dataList;
              if (dataList.isEmpty) return _contentEmpty(context);
              return SmartRefresher(
                enablePullUp: true,
                controller: controller.refreshController,
                onLoading: () {
                  controller.fetchDataTestimoni(
                    refresh: false,
                  );
                },
                onRefresh: () {
                  controller.fetchDataTestimoni();
                },
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (ctx, i) {
                    return Container(
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(context) * 16,
                        GlobalVariable.ratioWidth(context) * 14,
                        GlobalVariable.ratioWidth(context) * 16,
                        GlobalVariable.ratioWidth(context) * 14,
                      ),
                      margin: EdgeInsets.only(
                        bottom: GlobalVariable.ratioWidth(context) * 14,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: dataList[i].filePath,
                            width: GlobalVariable.ratioWidth(context) * 32,
                            height: GlobalVariable.ratioWidth(context) * 32,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 13,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(dataList[i].shipperName,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  withoutExtraPadding: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: GlobalVariable.ratioWidth(context) * 8, // -2px customText
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _starWidget(context, dataList[i].rate, 8, 3.57),
                                    CustomText(dataList[i].tanggal,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.right,
                                      fontStyle: FontStyle.italic,
                                      color: Color(ListColor.colorGrey3),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: GlobalVariable.ratioWidth(context) * 10,
                                ),
                                CustomText(dataList[i].shipperName,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (controller.dataModelResponse.value.state == ResponseStates.ERROR) {
              return ErrorDisplayComponent("${controller.dataModelResponse.value.exception}",
                onRefresh: () => controller.fetchDataTestimoni(),
              );
            }
            return LoadingComponent();
          }),
        ),
      ],
    );
  }

  Widget _starWidget(BuildContext context, int rating, int size, double gap) {
    return Row(
      children: [
        for (int i=0;i<5;i++)
          Container(
            margin: EdgeInsets.only(
              right: GlobalVariable.ratioWidth(context) * (i == 4 ? 0 : gap),
            ),
            child: SvgPicture.asset('assets/ic_star.svg',
              width: GlobalVariable.ratioWidth(context) * size,
              height: GlobalVariable.ratioWidth(context) * size,
              color: Color(i >= rating ? ListColor.colorLightGrey2 : ListColor.colorYellow),
            ),
          )
      ],
    );
  }

  Widget _contentEmpty(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/ic_laptop_empty_search_transporter.svg',
                width: GlobalVariable.ratioWidth(context) * 99.44,
                height: GlobalVariable.ratioWidth(context) * 86,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 14,
              ),
              CustomText(
                'Hasil pencarian tidak ditemukan!',
                fontWeight: FontWeight.w500,
                fontSize: GlobalVariable.ratioWidth(context) * 14,
                color: Color(ListColor.colorBlue),
                height: GlobalVariable.ratioWidth(context) * 1.2,
              )
            ],
          ),
        ),
      ),
    );
  }

  // PRIVATE CUSTOM BUTTON 
  Widget _button({
    double height,
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
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * marginLeft,
        GlobalVariable.ratioWidth(Get.context) * marginTop,
        GlobalVariable.ratioWidth(Get.context) * marginRight,
        GlobalVariable.ratioWidth(Get.context) * marginBottom
      ),
      width: width == null ? maxWidth ? MediaQuery.of(Get.context).size.width : null : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null ? null : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: useShadow
          ? <BoxShadow>[
              BoxShadow(
                color: Color(ListColor.shadowColor).withOpacity(0.08),
                blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                spreadRadius: 0,
                offset:
                    Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
              ),
            ]
          : null,
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * borderRadius),
        border: useBorder
          ? Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * borderSize,
              color: borderColor ?? Color(ListColor.colorBlue),
            )
          : null
      ),
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
            padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * paddingLeft,
              GlobalVariable.ratioWidth(Get.context) * paddingTop,
              GlobalVariable.ratioWidth(Get.context) * paddingRight,
              GlobalVariable.ratioWidth(Get.context) * paddingBottom
            ),
            width: maxWidth ? double.infinity : null,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius)
            ),
            child: customWidget == null
              ? CustomText(
                  text ?? "",
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                )
              : customWidget,
          )
        ),
      ),
    );
  }

}

class _AppBar extends PreferredSize {
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<FormPendaftaranIndividuController>();
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        color: Color(ListColor.colorBlue),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image(
                image: AssetImage("assets/fallin_star_3_icon.png"),
                height: GlobalVariable.ratioWidth(Get.context) * 67,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: MediaQuery.of(Get.context).size.width,
              padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 16,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBackButton(
                    backgroundColor: Colors.white,
                    iconColor: Color(ListColor.colorBlue),
                    context: Get.context,
                    onTap: () {
                      Get.back();
                    }
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 12),
                      child: CustomText(
                        "TestimoniIndexTestimoni".tr,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      )
    );
  }

  _AppBar({this.preferredSize});
}