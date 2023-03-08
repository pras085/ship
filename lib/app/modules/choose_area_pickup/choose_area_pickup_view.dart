import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'choose_area_pickup_controller.dart';

class ChooseAreaPickupView extends GetView<ChooseAreaPickupController> {
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
              preferredSize:
                  Size.fromHeight(GlobalVariable.ratioHeight(Get.context) * 56),
              child: Container(
                height: GlobalVariable.ratioHeight(Get.context) * 56,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 8),
                  ),
                ], color: Colors.white),
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioHeight(Get.context) * 12,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioHeight(Get.context) * 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                              child: GestureDetector(
                                  onTap: () {
                                    controller.onClearSearch();
                                    Get.back();
                                  },
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          "ic_back_blue_button.svg",
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24))),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 12,
                          ),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Obx(() => CustomTextField(
                                    context: Get.context,
                                    controller: controller
                                        .searchTextEditingController.value,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) {
                                      controller.onSubmitSearch();
                                    },
                                    onChanged: (value) {
                                      controller.addTextSearchCity(value);
                                    },
                                    textSize: 14,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      hintText: controller.hintText.value,
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                        color: Color(ListColor.colorLightGrey2),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      filled: true,
                                      contentPadding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            32,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            6,
                                        top: GlobalVariable.ratioHeight(
                                                Get.context) *
                                            9,
                                        bottom: GlobalVariable.ratioHeight(
                                                Get.context) *
                                            6,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey7),
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                1),
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                7),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey7),
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                1),
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                7),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(ListColor.color4),
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                1),
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                7),
                                      ),
                                    ))),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          2),
                                  child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "ic_search_blue.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Obx(() => controller
                                          .isShowClearSearch.value
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.onClearSearch();
                                          },
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  right: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      4),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "ic_close_blue.svg",
                                                  color: Colors.black,
                                                  width: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                                  height: GlobalVariable.ratioWidth(Get.context) * 24)))
                                      : SizedBox.shrink()),
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
            body: Container(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
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
                                  ? controller.lastSearchTransaction
                                              .isNotEmpty &&
                                          !controller
                                              .loadLastSearchLastTransaction
                                              .value &&
                                          !controller.loadLastSearch.value
                                      ? Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                    top: GlobalVariable
                                                            .ratioHeight(
                                                                Get.context) *
                                                        18,
                                                    bottom: GlobalVariable
                                                            .ratioHeight(
                                                                Get.context) *
                                                        6,
                                                  ),
                                                  child: CustomText(
                                                      "InfoPraTenderCreateLabelPencarianTerakhir"
                                                          .tr, // Pencarian Terakhir
                                                      fontSize: 12,
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
                                                          margin: EdgeInsets.symmetric(
                                                              vertical: GlobalVariable
                                                                      .ratioHeight(
                                                                          Get.context) *
                                                                  6),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  size: GlobalVariable
                                                                          .ratioHeight(Get
                                                                              .context) *
                                                                      18,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorGrey3WithOpacity)),
                                                              Container(
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      12),
                                                              Expanded(
                                                                  child: GestureDetector(
                                                                      onTap: () {
                                                                        controller
                                                                            .onCheckLastSearchTransaction(index);
                                                                        controller
                                                                            .saveSearchLocation(
                                                                          controller.lastSearchTransaction[controller
                                                                              .lastSearchTransaction
                                                                              .keys
                                                                              .toList()[index]],
                                                                        );
                                                                      },
                                                                      child: CustomText(
                                                                          //yg lama controller.lastTransaction
                                                                          controller.lastSearchTransaction[controller.lastSearchTransaction.keys.toList()[index]],
                                                                          fontSize: 14,
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
                                      : SizedBox.shrink()
                                  : controller.loading.value
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              top: GlobalVariable.ratioHeight(
                                                      Get.context) *
                                                  20,
                                              bottom:
                                                  GlobalVariable.ratioHeight(
                                                          Get.context) *
                                                      18),
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(),
                                        )
                                      : Container(
                                          padding: EdgeInsets.only(
                                            top: GlobalVariable.ratioHeight(
                                                    Get.context) *
                                                12,
                                          ),
                                          child:
                                              Obx(
                                                  () =>
                                                      controller.listLocation
                                                                  .isEmpty &&
                                                              !controller
                                                                  .firstLoad
                                                                  .value
                                                          ? Container(
                                                              width: MediaQuery
                                                                      .of(Get
                                                                          .context)
                                                                  .size
                                                                  .width,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding: EdgeInsets.only(
                                                                  top: GlobalVariable
                                                                          .ratioHeight(Get
                                                                              .context) *
                                                                      8,
                                                                  bottom: GlobalVariable
                                                                          .ratioHeight(
                                                                              Get.context) *
                                                                      6),
                                                              child: CustomText(
                                                                  "InfoPraTenderCreateLabelTidakDitemukan"
                                                                      .tr, // Tidak Ditemukan
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorDarkGrey3),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )
                                                          : Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                for (var index =
                                                                        0;
                                                                    index <
                                                                        controller
                                                                            .listLocation
                                                                            .length;
                                                                    index++)
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: GlobalVariable.ratioHeight(Get.context) *
                                                                            8,
                                                                        bottom:
                                                                            GlobalVariable.ratioHeight(Get.context) *
                                                                                8),
                                                                    child:
                                                                        Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          controller.onCheckLocation(
                                                                              index,
                                                                              !controller.listChoosen.containsKey(controller.listLocation.keys.elementAt(index)));
                                                                          controller.saveSearchLocation(controller
                                                                              .listLocation
                                                                              .values
                                                                              .elementAt(index));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Stack(alignment: Alignment.centerLeft, children: [
                                                                                  CustomText(controller.listLocation.values.elementAt(index), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w700, color: Color(ListColor.colorDarkGrey3), fontSize: 14),
                                                                                ]),
                                                                              ),
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
                                  ? Column(
                                      children: [
                                        SizedBox(
                                            height: GlobalVariable.ratioHeight(
                                                    Get.context) *
                                                12),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: GlobalVariable.ratioHeight(
                                                  Get.context) *
                                              1,
                                          color:
                                              Color(ListColor.colorLightGrey5)
                                                  .withOpacity(0.4),
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              controller.lastTransaction.isNotEmpty &&
                                      !controller.loadLastSearchLastTransaction
                                          .value &&
                                      !controller.loadLastSearch.value
                                  ? Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: GlobalVariable
                                                          .ratioHeight(
                                                              Get.context) *
                                                      18,
                                                  bottom: GlobalVariable
                                                          .ratioHeight(
                                                              Get.context) *
                                                      6),
                                              child: CustomText(
                                                  "InfoPraTenderCreateLabelTransaksiTerakhir"
                                                      .tr, // Transaksi Terakhir
                                                  fontSize: 12,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: GlobalVariable
                                                                .ratioHeight(Get
                                                                    .context) *
                                                            6,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          SvgPicture.asset(
                                                              GlobalVariable
                                                                      .imagePath +
                                                                  "pencarianterakhir.svg",
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  16,
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  16),
                                                          Container(
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  16),
                                                          Expanded(
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        controller
                                                                            .onCheckLastTransaction(index);
                                                                        controller.saveSearchLocation(controller.lastTransaction[controller
                                                                            .lastTransaction
                                                                            .keys
                                                                            .toList()[index]]);
                                                                      },
                                                                      child: CustomText(
                                                                          controller.lastTransaction[controller.lastTransaction.keys.toList()[
                                                                              index]],
                                                                          fontSize:
                                                                              14,
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
                    !controller.loadLastSearchLastTransaction.value &&
                            !controller.loadLastSearch.value
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
