import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'list_area_pickup_transporter_filter_controller.dart';

class ListAreaPickupTransporterFilterView
    extends GetView<ListAreaPickupTransporterFilterController> {
  @override
  Widget build(BuildContext context) {
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
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            CustomTextField(
                              controller:
                                  controller.searchTextEditingController,
                              textInputAction: TextInputAction.search,
                              context: Get.context,
                              textSize: 14,
                              newContentPadding: EdgeInsets.symmetric(
                                  horizontal: 42,
                                  vertical:
                                      GlobalVariable.ratioHeight(context) * 6),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              // newContentPadding: EdgeInsets.symmetric(
                              //     horizontal: 42,
                              //     vertical:
                              //         GlobalVariable.ratioHeight(context) * 6),
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
                              onChanged: (String str) async {
                                controller.addTextSearchCity(str);
                              },
                              onSubmitted: (String str) async {
                                controller.onSubmitSearch();
                              },
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
                              child: Obx(
                                () => controller.isShowClearSearch.value
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
                            ),
                          ],
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
                    itemCount: controller.listParentTemp.length,
                    itemBuilder: (context, index) {
                      var parent = controller.listParentTemp[index];
                      var getChild = List.from(controller.listChildTemp.value)
                          .where((element) => element.kategori == parent)
                          .toList();
                      return Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                initiallyExpanded: false,
                                onExpansionChanged: (value) {
                                  controller.expandParent[index] = value;
                                },
                                title: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => CheckBoxCustom(
                                        value: controller.listChoosen.keys
                                            .toList()
                                            .any((element) => getChild.any(
                                                (childElement) =>
                                                    childElement.id ==
                                                    element)),
                                        onChanged: (value) {
                                          controller.onCheckParent(
                                              index, value);
                                        },
                                        isWithShadow: true,
                                        size: 16,
                                        shadowSize: 18,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    CustomText(parent,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ],
                                ),
                                children: [
                                  for (var childIndex = 0;
                                      childIndex < getChild.length;
                                      childIndex++)
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        childIndex == 0
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    left: 66, right: 20),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height:
                                                    GlobalVariable.ratioHeight(
                                                            Get.context) *
                                                        2,
                                                color: Color(
                                                    ListColor.colorLightGrey10),
                                              )
                                            : SizedBox.shrink(),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 65,
                                                right: 10,
                                                top: 4,
                                                bottom: 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    child: CustomText(
                                                  getChild[childIndex]
                                                      .description,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                                Obx(
                                                  () => CheckBoxCustom(
                                                    value: controller
                                                        .listChoosen.keys
                                                        .any((element) =>
                                                            element ==
                                                            getChild[childIndex]
                                                                .id),
                                                    onChanged: (value) {
                                                      controller
                                                          .onCheckAreaPickup(
                                                              getChild[
                                                                  childIndex],
                                                              value);
                                                    },
                                                    isWithShadow: true,
                                                    size: 16,
                                                    shadowSize: 18,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 66, right: 20),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: GlobalVariable.ratioHeight(
                                                  Get.context) *
                                              0.5,
                                          color:
                                              Color(ListColor.colorLightGrey10),
                                        )
                                      ],
                                    )
                                ],
                              ),
                            ),
                            index == (controller.listParentTemp.length - 1)
                                ? SizedBox.shrink()
                                : controller.expandParent[index] != null &&
                                        controller.expandParent[index]
                                    ? SizedBox.shrink()
                                    : Container(
                                        margin: EdgeInsets.only(
                                            left: 66, right: 20),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: GlobalVariable.ratioHeight(
                                                Get.context) *
                                            2,
                                        color:
                                            Color(ListColor.colorLightGrey10),
                                      )
                          ],
                        ),
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
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 25,
                            vertical:
                                GlobalVariable.ratioHeight(Get.context) * 9),
                        child: Stack(alignment: Alignment.center, children: [
                          CustomText("GlobalButtonResetSearchCity".tr,
                              fontSize: 12,
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
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 25,
                            vertical:
                                GlobalVariable.ratioHeight(Get.context) * 9),
                        child: Stack(alignment: Alignment.center, children: [
                          CustomText("GlobalButtonSaveSearchCity".tr,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
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
