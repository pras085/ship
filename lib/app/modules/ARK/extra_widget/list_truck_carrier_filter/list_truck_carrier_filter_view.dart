import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'list_truck_carrier_filter_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';

class ListTruckCarrierFilterView
    extends GetView<ListTruckCarrierFilterController> {
  AppBar _appBar = AppBar(
    title: Text('Demo'),
  );

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
        //                     child: CustomText(controller.title,
        //                         fontSize: 14, fontWeight: FontWeight.w600),
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
          preferredSize: Size.fromHeight(_appBar.preferredSize.height + 10),
          child: Container(
            alignment: Alignment.center,
            height: _appBar.preferredSize.height + 10,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ], color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: ClipOval(
                    child: Material(
                        shape: CircleBorder(),
                        color: Color(ListColor.color4),
                        child: InkWell(
                            onTap: () {
                              controller.onClearSearch();
                              Get.back();
                            },
                            child: Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                child: Center(
                                    child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ))))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      CustomTextField(
                        controller: controller.searchBar,
                        textInputAction: TextInputAction.search,
                        context: Get.context,
                        textSize: 14,
                        newContentPadding: EdgeInsets.symmetric(
                            horizontal: 42,
                            vertical: GlobalVariable.ratioWidth(context) * 6),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                        // newContentPadding: EdgeInsets.symmetric(
                        //     horizontal: 42,
                        //     vertical:
                        //         GlobalVariable.ratioWidth(context) * 6),
                        newInputDecoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          hintText: "Cari ${controller.title}",
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(
                              color: Color(ListColor.colorLightGrey2),
                              fontWeight: FontWeight.w600),
                          // contentPadding: EdgeInsets.symmetric(
                          //     horizontal: 42, vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorLightGrey7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                          ),
                        ),
                        onChanged: (String str) async {
                          controller.filterSearch.value = str;
                          controller.refreshData();
                        },
                        onSubmitted: (String str) async {
                          controller.filterSearch.value = str;
                          controller.refreshData();
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 7),
                        child: SvgPicture.asset(
                          GlobalVariable.imagePath + "ic_search_blue.svg",
                          width: 30,
                          height: 30,
                          color: Color(ListColor.colorGrey5),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Obx(() => controller.filterSearch.value.isEmpty
                              ? SizedBox.shrink()
                              : Container(
                                  margin: EdgeInsets.only(right: 7),
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.onClearSearch();
                                      },
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                      )))))
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.listTruckCarrier.length,
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
                                        controller.listTruckCarrier[index].id));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10,
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 77, // 80,
                                      height: 70,
                                      margin: EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                                          border: Border.all(
                                              color: Color(
                                                  ListColor.colorLightGrey2),
                                              width: 1)),
                                      child: CachedNetworkImage(
                                        errorWidget: (context, value, err) =>
                                            Image(
                                          image: AssetImage(
                                              GlobalVariable.imagePath +
                                                  "wingbox_truck.png"),
                                          width: 40,
                                          height: 40,
                                        ),
                                        imageUrl: controller
                                            .listTruckCarrier[index].imageUrl,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.only(
                                          top: FontTopPadding.getSize(14)),
                                      child: Obx(
                                        () => SubstringHighlight(
                                            text: controller.listTruckCarrier
                                                        .length <=
                                                    index
                                                ? ""
                                                : controller
                                                    .listTruckCarrier[index]
                                                    .description,
                                            term: controller.filterSearch.value,
                                            textStyle: TextStyle(
                                                fontSize:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14,
                                                color:
                                                    Color(ListColor.colorGrey4),
                                                fontWeight: FontWeight.w600),
                                            textStyleHighlight: TextStyle(
                                                fontSize:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14,
                                                color: Color(ListColor.color4),
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                                    SizedBox(width: 20),
                                    CheckBoxCustom(
                                      shadowSize: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          18,
                                      size: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14,
                                      isWithShadow: true,
                                      value: controller.listChoosen.containsKey(
                                          controller
                                              .listTruckCarrier[index].id),
                                      onChanged: (value) {
                                        controller.onCheckTruckCarrier(
                                            index, value);
                                      },
                                      // checkColor: Colors.white,
                                      // activeColor: Color(ListColor.color4),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          index == controller.listTruckCarrier.length - 1
                              ? SizedBox.shrink()
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20),
                                  width: MediaQuery.of(context).size.width,
                                  height: 0.5,
                                  color: Color(ListColor.colorLightGrey5),
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
                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
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
                            borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
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
                    width: GlobalVariable.ratioWidth(Get.context) * 15,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color(ListColor.color4),
                          side: BorderSide(
                              width: 2, color: Color(ListColor.color4)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
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
