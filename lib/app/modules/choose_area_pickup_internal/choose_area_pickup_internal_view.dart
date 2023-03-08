import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/checkbox_custom_widget.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'choose_area_pickup_internal_controller.dart';

class ChooseAreaPickupInternalView extends GetView<ChooseAreaPickupInternalController> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.onCompleteBuildWidget());
    return SafeArea(
      child: WillPopScope(
          onWillPop: () async {
            controller.onClearSearch();
            return true;
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(64),
              child: Container(
                height: 64,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorBlack).withOpacity(0.15),
                    blurRadius: GlobalVariable.ratioWidth(context) * 15,
                    spreadRadius: GlobalVariable.ratioWidth(context) * 0,
                    offset: Offset(0, GlobalVariable.ratioWidth(context) * 4),
                  ),
                ], color: Colors.white),
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(context) * 16,
                ),
                child: Center(
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
                                    controller.onClearSearch();
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
                              Obx(
                                () => CustomTextField(
                                    context: Get.context,
                                    onChanged: (value) {
                                      controller.addTextSearchCity(value);
                                    },
                                    controller: controller
                                        .searchTextEditingController.value,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) {
                                      controller.onSubmitSearch();
                                    },
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    newContentPadding: EdgeInsets.symmetric(
                                        horizontal: 42,
                                        vertical:
                                            GlobalVariable.ratioHeight(
                                                    context) *
                                                6),
                                    textSize: 14,
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      hintText:
                                          "Cari Kota Tujuan", // "Cari Area Pick Up",
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Color(
                                              ListColor.colorLightGrey2),
                                          fontWeight: FontWeight.w600),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey7),
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey7),
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey7),
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                child: SvgPicture.asset(
                                  "assets/search_magnifition_icon.svg",
                                  width: GlobalVariable.ratioWidth(
                                          Get.context) *
                                      24,
                                  height: GlobalVariable.ratioWidth(
                                          Get.context) *
                                      24,
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
                                            margin:
                                                EdgeInsets.only(right: 10),
                                            child: Icon(
                                              Icons.close_rounded,
                                              size: GlobalVariable
                                                      .ratioHeight(
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
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(Get.context).size.width,
              height: MediaQuery.of(Get.context).size.height,
              child: Obx(
                () => Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        child: Obx(
                          () => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              controller.searchValue.value.isEmpty
                                  ? controller.lastSearchTransaction.length == 0
                                      ? SizedBox.shrink()
                                      : Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 20, bottom: 7),
                                                  child: CustomText(
                                                      "Pencarian Terakhir",
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(ListColor
                                                          .colorLightGrey14))),
                                              Obx(() => Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      for (var index = (controller
                                                                  .lastSearchTransaction
                                                                  .length -
                                                              1);
                                                          index >= 0;
                                                          index--)
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 8),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorGrey3WithOpacity)),
                                                              Container(
                                                                  width: 16),
                                                              Expanded(
                                                                  child: GestureDetector(
                                                                      onTap: () {
                                                                        controller
                                                                            .onCheckLastSearchTransaction(index);
                                                                      },
                                                                      child: CustomText(
                                                                          //yg lama controller.lastTransaction
                                                                          controller.lastSearchTransaction[controller.lastSearchTransaction.keys.toList()[index]],
                                                                          fontSize: 11,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: Color(ListColor.colorDarkGrey3))))
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        )
                                  : controller.loading.value
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20),
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        )
                                      : Container(
                                          child: Obx(() =>
                                              controller.listLocation.isEmpty &&
                                                      !controller
                                                          .firstLoad.value
                                                  ? Container(
                                                      width: MediaQuery.of(
                                                              Get.context)
                                                          .size
                                                          .width,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 20),
                                                      child: CustomText(
                                                          "Data Tidak Ditemukan",
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  : Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        for (var index = 0;
                                                            index <
                                                                controller
                                                                    .listLocation
                                                                    .length;
                                                            index++)
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                left: 16,
                                                                right: 16,
                                                                top: index == 0
                                                                    ? 8
                                                                    : 0,
                                                                bottom: index ==
                                                                        (controller.listLocation.length -
                                                                            1)
                                                                    ? 8
                                                                    : 0),
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  controller.onCheckLocation(
                                                                      index,
                                                                      !controller.listChoosen.containsKey(controller
                                                                          .listLocation
                                                                          .keys
                                                                          .elementAt(
                                                                              index)));
                                                                },
                                                                child:
                                                                    Container(
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child: Stack(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            children: [
                                                                              CustomText(controller.listLocation.values.elementAt(index), maxLines: 2, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600, color: Colors.black, fontSize: 14),
                                                                              CustomText("\n", maxLines: 2, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600, color: Colors.black, fontSize: 14)
                                                                            ]),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    )),
                                        ),
                              (controller.searchValue.value.isEmpty &&
                                          controller.lastSearchTransaction
                                                  .length >
                                              0 &&
                                          controller
                                              .lastTransaction.isNotEmpty) ||
                                      (controller
                                              .searchValue.value.isNotEmpty &&
                                          !controller.firstLoad.value &&
                                          controller.lastTransaction.isNotEmpty)
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16, top: 3),
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                      color: Color(ListColor.colorLightGrey5),
                                    )
                                  : SizedBox.shrink(),
                              controller.lastTransaction.isNotEmpty
                                  ? Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: 18, bottom: 7),
                                              child: CustomText(
                                                  "Transaksi Terakhir",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(ListColor
                                                      .colorLightGrey14))),
                                          Obx(() => Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  for (var index = (controller
                                                              .lastTransaction
                                                              .length -
                                                          1);
                                                      index >= 0;
                                                      index--)
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 7),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Icon(Icons.timer,
                                                              color: Color(ListColor
                                                                  .colorGrey3WithOpacity)),
                                                          Container(width: 16),
                                                          Expanded(
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        controller
                                                                            .onCheckLastTransaction(index);
                                                                      },
                                                                      child: CustomText(
                                                                          controller.lastTransaction[controller.lastTransaction.keys.toList()[
                                                                              index]],
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(ListColor.colorDarkGrey3))))
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                    ),
                    !controller.loadLastSearchLastTrasaction.value
                        ? SizedBox.shrink()
                        : Positioned.fill(
                            child: Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator())),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
