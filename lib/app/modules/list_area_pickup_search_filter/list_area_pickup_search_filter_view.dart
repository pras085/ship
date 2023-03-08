import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'list_area_pickup_search_filter_controller.dart';

class ListAreaPickupSearchFilterView
    extends GetView<ListAreaPickupSearchFilterController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(64),
        //   child: Container(
        //     height: 64,
        //     width: MediaQuery.of(context).size.width,
        //     decoration: BoxDecoration(boxShadow: <BoxShadow>[
        //       BoxShadow(
        //         color: Color(ListColor.colorLightGrey).withOpacity(0.5),
        //         blurRadius: 10,
        //         spreadRadius: 2,
        //       ),
        //     ], color: Colors.white),
        //     child: Stack(alignment: Alignment.bottomCenter, children: [
        //       Container(
        //         height: 64,
        //         child: Column(
        //             mainAxisSize: MainAxisSize.max,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Stack(
        //                 alignment: Alignment.centerLeft,
        //                 children: [
        //                   GestureDetector(
        //                     onTap: () {
        //                       Get.back();
        //                     },
        //                     child: Container(
        //                       height: 64,
        //                       padding: EdgeInsets.symmetric(horizontal: 10),
        //                       child: ClipOval(
        //                         child: Material(
        //                             shape: CircleBorder(),
        //                             color: Color(ListColor.color4),
        //                             child: Container(
        //                                 width: 30,
        //                                 height: 30,
        //                                 child: Center(
        //                                     child: Icon(
        //                                   Icons.arrow_back_ios_rounded,
        //                                   size: 20,
        //                                   color: Colors.white,
        //                                 )))),
        //                       ),
        //                     ),
        //                   ),
        //                   Align(
        //                     alignment: Alignment.center,
        //                     child: Text(controller.title,
        //                         style: TextStyle(
        //                             fontSize: 14, fontWeight: FontWeight.w600)),
        //                   )
        //                 ],
        //               ),
        //             ]),
        //       ),
        //       Container(
        //           width: MediaQuery.of(context).size.width,
        //           height: 2,
        //           color: Color(ListColor.colorLightBlue5))
        //     ]),
        //   ),
        // ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(64),
          child: Container(
            height: 64,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ], color: Colors.white),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: ClipOval(
                          child: Material(
                              shape: CircleBorder(),
                              color: Color(ListColor.color4),
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      width: 30,
                                      height: 30,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ))))),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              CustomTextField(
                                onChanged: (value) {
                                  controller.addTextSearchCity(value);
                                },
                                controller:
                                    controller.searchTextEditingController,
                                textInputAction: TextInputAction.search,
                                context: Get.context,
                                textSize: 14,
                                newContentPadding: EdgeInsets.symmetric(
                                    horizontal: 42,
                                    vertical:
                                        GlobalVariable.ratioHeight(context) *
                                            6),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                onSubmitted: (value) {
                                  controller.onSubmitSearch();
                                },
                                newInputDecoration: InputDecoration(
                                  isDense: true,
                                  isCollapsed: true,
                                  hintText: "Cari Area Pick Up".tr,
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: TextStyle(
                                      color: Color(ListColor.colorLightGrey2),
                                      fontWeight: FontWeight.w600),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ListColor.colorLightGrey7),
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ListColor.colorLightGrey7),
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(ListColor.colorLightGrey7),
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: SvgPicture.asset(
                                  "assets/search_magnifition_icon.svg",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: controller.isShowClearSearch.value
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.onClearSearch();
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.close_rounded,
                                              size: GlobalVariable.ratioHeight(
                                                      Get.context) *
                                                  24,
                                            )),
                                      )
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Color(ListColor.colorLightBlue5))
            ]),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.listAreaPickupSearchFind.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.onCheckTruckCarrier(
                                    index,
                                    !controller.listChoosen.containsKey(
                                        controller
                                            .listAreaPickupSearchFind[index]
                                            .id));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 32,
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          index == 0 ||
                                                  ((index > 0) &&
                                                      (controller
                                                              .listAreaPickupSearchFind[
                                                                  index]
                                                              .keyDescription ==
                                                          controller
                                                              .listAreaPickupSearchFind[
                                                                  index - 1]
                                                              .keyDescription))
                                              ? "   "
                                              : controller
                                                  .listAreaPickupSearchFind[
                                                      index]
                                                  .keyDescription,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    Expanded(
                                      child: Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            CustomText(
                                                controller
                                                    .listAreaPickupSearchFind[
                                                        index]
                                                    .description,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                            CustomText("\n",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)
                                          ]),
                                    ),
                                    SizedBox(width: 5),
                                    Obx(
                                      () => CheckBoxCustom(
                                        value: controller.listChoosen
                                            .containsKey(controller
                                                .listAreaPickupSearchFind[index]
                                                .id),
                                        onChanged: (value) {
                                          controller.onCheckTruckCarrier(
                                              index, value);
                                        },
                                        isWithShadow: true,
                                        size: 16,
                                        shadowSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          controller.listAreaPickupSearchFind.length <= 1
                              ? SizedBox.shrink()
                              : Container(
                                  margin: EdgeInsets.only(
                                      left: (index == 0 &&
                                              controller
                                                  .listAreaPickupSearchFind[
                                                      index]
                                                  .description
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains("kota"))
                                          ? 20
                                          : 52,
                                      right: 20),
                                  width: MediaQuery.of(context).size.width,
                                  height: (index == 0 &&
                                          controller
                                              .listAreaPickupSearchFind[index]
                                              .description
                                              .toString()
                                              .toLowerCase()
                                              .contains("kota"))
                                      ? 2
                                      : 0.5,
                                  // color: Color(index == 0
                                  //     ? ListColor.colorLightGrey4
                                  //     : ListColor.colorLightGrey5),
                                  color: Color(ListColor.colorLightGrey10),
                                )
                        ],
                      );
                    }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 23),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 4,
                    ),
                  ]),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              width: 2, color: Color(ListColor.color4)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                      onPressed: () {
                        controller.resetAll();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Stack(alignment: Alignment.center, children: [
                          CustomText("GlobalButtonResetSearchCity".tr,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.color4)),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color(ListColor.color4),
                          side: BorderSide(
                              width: 2, color: Color(ListColor.color4)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                      onPressed: () {
                        controller.onSubmit();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Stack(alignment: Alignment.center, children: [
                          CustomText("GlobalButtonSaveSearchCity".tr,
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
