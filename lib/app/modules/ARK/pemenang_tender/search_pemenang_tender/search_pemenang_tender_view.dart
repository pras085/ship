import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/search_pemenang_tender/search_pemenang_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'dart:math' as math;
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'search_pemenang_tender_controller.dart';

class SearchPemenangTenderView extends GetView<SearchPemenangTenderController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: willpop,
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
                backgroundColor: Color(ListColor.colorLightGrey6),
                resizeToAvoidBottomInset: false,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      GlobalVariable.ratioWidth(Get.context) * 56),
                  child: Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 56,
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
                              GlobalVariable.ratioWidth(Get.context) * 12,
                              GlobalVariable.ratioWidth(Get.context) * 16,
                              GlobalVariable.ratioWidth(Get.context) * 11.5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  child: GestureDetector(
                                      onTap: willpop,
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
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                              ),
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Obx(() => CustomTextField(
                                        enabled: !controller.isLoadingData.value
                                            ? true
                                            : false,
                                        context: Get.context,
                                        autofocus: true,
                                        controller:
                                            controller.searchController.value,
                                        textInputAction: TextInputAction.search,
                                        onChanged: (value) {
                                          controller.onChangeText(value);
                                        },
                                        onTap: () {
                                          controller.lastShow.value = true;
                                          controller.onChangeText(controller
                                              .searchController.value.text);
                                        },
                                        onEditingComplete: () {
                                          controller.onSearch();
                                        },
                                        textSize: 14,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        newInputDecoration: InputDecoration(
                                          isDense: true,
                                          isCollapsed: true,
                                          hintText:
                                              "PemenangTenderIndexLabelSearchPlaceholder"
                                                  .tr,
                                          fillColor: Colors.white,
                                          hintStyle: TextStyle(
                                            color: Color(
                                                ListColor.colorLightGrey2),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          filled: true,
                                          contentPadding: EdgeInsets.only(
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                32,
                                            right: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                30,
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                9,
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(
                                                    ListColor.colorLightGrey7),
                                                width:
                                                    GlobalVariable.ratioWidth(
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
                                                width:
                                                    GlobalVariable.ratioWidth(
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
                                                width:
                                                    GlobalVariable.ratioWidth(
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
                                      child: Obx(() => controller
                                                  .isShowClearSearch.value &&
                                              controller.lastShow.value
                                          ? GestureDetector(
                                              onTap: () {
                                                controller.onClearSearch();
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                          GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              4),
                                                  child: SvgPicture.asset(
                                                      GlobalVariable.imagePath +
                                                          "ic_close_blue.svg",
                                                      color: Colors.black,
                                                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                      height: GlobalVariable.ratioWidth(Get.context) * 24)))
                                          : SizedBox.shrink()),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (controller.listPemenangTender.length >
                                            0 &&
                                        !controller.lastShow.value) {
                                      controller.showSortingDialog();
                                    }
                                  },
                                  child: Obx(() => controller.listPemenangTender.length > 0 &&
                                          !controller.lastShow.value
                                      ? controller.sortBy.value == ""
                                          ? SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg",
                                              color: Colors.black,
                                              width: GlobalVariable.ratioWidth(Get.context) *
                                                  24,
                                              height:
                                                  GlobalVariable.ratioWidth(Get.context) *
                                                      24)
                                          : SvgPicture.asset(GlobalVariable.imagePath + "ic_sort_black_on.svg",
                                              width: GlobalVariable.ratioWidth(Get.context) *
                                                  24,
                                              height:
                                                  GlobalVariable.ratioWidth(Get.context) *
                                                      24)
                                      : //
                                      SvgPicture.asset(
                                          GlobalVariable.imagePath + "sorting_active.svg",
                                          width: GlobalVariable.ratioWidth(Get.context) * 24,
                                          color: Color(ListColor.colorLightGrey2),
                                          height: GlobalVariable.ratioWidth(Get.context) * 24)))
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
                body: Obx(
                  () => controller.lastShow.value
                      ? _listLastSearch()
                      : _listPemenangTender(),
                )),
          ),
        ));
  }

  Widget _periodeTenderLabelWidget(int index) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 80,
              0,
              0,
              GlobalVariable.ratioWidth(Get.context) * 175),
          child: Stack(children: [
            Positioned.fill(
                child: Container(
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorDarkGrey5),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: -10,
                        offset: Offset(0.0, 15.0))
                  ]),
            )),
            Positioned.fill(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SimpleShadow(
                      child: SvgPicture.asset(
                          GlobalVariable.imagePath + "segitiga.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 20,
                          height: GlobalVariable.ratioWidth(Get.context) * 22),
                      opacity: 0.5,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(0, 5),
                      sigma: 7,
                    ))),
            Container(
                width: GlobalVariable.ratioWidth(Get.context) * 175,
                // height: GlobalVariable.ratioWidth(Get.context) * 59,
                margin: EdgeInsets.only(bottom: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(ListColor.colorDarkGrey5),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 9),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Stack(children: [
                    Positioned(
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      8,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      8,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          13),
                              child: GestureDetector(
                                  onTap: () {
                                    controller.listPemenangTender[index]
                                        ['labelPeriode'] = false;
                                    controller.listPemenangTender.refresh();
                                  },
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath + "ic_close.svg",
                                      color: Color(ListColor.color2),
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14,
                                      height:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              14)))),
                    ),
                    Positioned(
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      16,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      22,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          22,
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16),
                              child: CustomText(
                                  'PemenangTenderIndexLabelPeriodePengumuman'
                                      .tr, //"Periode Pengumuman", PemenangTenderIndexLabelPeriodeTender
                                  fontSize: 12,
                                  height: 1.3,
                                  fontWeight: FontWeight.w500,
                                  color: Color(ListColor.color2),
                                  textAlign: TextAlign.center))),
                    ),
                  ]),
                ))
          ])),
    ]);
  }

  Widget _listLastSearch() {
    return Container(
      margin: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 16,
          right: GlobalVariable.ratioWidth(Get.context) * 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                  bottom: GlobalVariable.ratioWidth(Get.context) * 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                      "PemenangTenderIndexLabelTerakhirDicari"
                          .tr, // Terakhir dicari
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  GestureDetector(
                    onTap: controller.clearHistorySearch,
                    child: CustomText(
                        "PemenangTenderIndexLabelHapusSemua".tr, // Hapus Semua
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorRed2)),
                  )
                ],
              )),
          Obx(() => !controller.isLoadingLast.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var index = 0;
                        index < controller.listHistorySearch.length;
                        index++)
                      GestureDetector(
                          onTap: () {
                            controller.chooseHistorySearch(index);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 7,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 10,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "pencarianterakhir.svg",
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                Container(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                Expanded(
                                    child: CustomText(
                                        controller.listHistorySearch[index]
                                            ['search'],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                                GestureDetector(
                                    onTap: () {
                                      controller.hapusHistorySearch(index);
                                    },
                                    child: SvgPicture.asset(
                                        GlobalVariable.imagePath +
                                            "ic_close.svg",
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16)),
                              ],
                            ),
                          )),
                  ],
                )
              : Center(child: CircularProgressIndicator()))
        ],
      ),
    );
  }

  Widget _listPemenangTender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      width: MediaQuery.of(Get.context).size.width,
                      margin: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 16,
                        right: GlobalVariable.ratioWidth(Get.context) * 16,
                        top: controller.searchOn.value
                            ? GlobalVariable.ratioWidth(Get.context) * 20
                            : 0,
                        bottom: (controller.listPemenangTender.length == 0 &&
                                !controller.isLoadingData
                                    .value) // ni muncul ketika belum ada info pra tender
                            ? GlobalVariable.ratioWidth(Get.context) * 0
                            : GlobalVariable.ratioWidth(Get.context) * 13,
                      ),
                      child: controller.searchController.value.text != "" &&
                              !controller.isLoadingData.value &&
                              controller.searchOn.value
                          ? Container(
                              child: controller.listPemenangTender.length > 0
                                  ? RichText(
                                      text: TextSpan(
                                          text: "PemenangTenderIndexLabelMenampilkan"
                                                  .tr +
                                              " " +
                                              GlobalVariable
                                                      .formatCurrencyDecimal(
                                                          controller.countSearch
                                                              .toString())
                                                  .toString() +
                                              " " +
                                              "PemenangTenderIndexLabelHasilUntuk"
                                                  .tr +
                                              " \"", // Menampilkan hasil untuk
                                          style: TextStyle(
                                            fontFamily: "AvenirNext",
                                            color:
                                                Color(ListColor.colorDarkBlue2),
                                            fontSize: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: controller
                                                    .searchController
                                                    .value
                                                    .text,
                                                style: TextStyle(
                                                  fontFamily: "AvenirNext",
                                                  color: Colors.black,
                                                  fontSize: GlobalVariable
                                                          .ratioFontSize(
                                                              Get.context) *
                                                      12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "\"", // Menampilkan hasil untuk
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "AvenirNext",
                                                        color: Color(ListColor
                                                            .colorDarkBlue2),
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ])
                                          ]),
                                    )
                                  : RichText(
                                      text: TextSpan(
                                          text: "PemenangTenderIndexLabelTidakDitemukan"
                                                  .tr +
                                              " ", //Tidak ditemukan hasil pencarian untuk
                                          style: TextStyle(
                                            fontFamily: "AvenirNext",
                                            color:
                                                Color(ListColor.colorDarkBlue2),
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "\"" +
                                                    controller.searchController
                                                        .value.text +
                                                    "\"",
                                                style: TextStyle(
                                                  fontFamily: "AvenirNext",
                                                  color: Colors.black,
                                                  fontSize: GlobalVariable
                                                          .ratioFontSize(
                                                              Get.context) *
                                                      12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: "",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "AvenirNext",
                                                        color: Color(ListColor
                                                            .colorDarkBlue2),
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      children: [])
                                                ])
                                          ]),
                                    ))
                          : SizedBox()),
                  Expanded(child: _showListPemenangTender()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showListPemenangTender() {
    return Stack(children: [
      //KALAU MASIH LOADING
      Obx(() => controller.isLoadingData.value
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA
          (controller.listPemenangTender.length == 0 &&
                  !controller.isLoadingData.value)
              ? Center(
                  child: Container(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        GlobalVariable.imagePath +
                            "ic_pencarian_tidak_ditemukan.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 82,
                        height: GlobalVariable.ratioWidth(Get.context) * 93),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 15),
                    CustomText(
                        'PemenangTenderIndexLabelSearchKeyword'.tr +
                            'PemenangTenderIndexLabelSearchTidakDitemukan'.tr +
                            '\n' +
                            'PemenangTenderIndexLabelDiSistem'
                                .tr, //Keyword tidak ditemukan disistem,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3))
                  ],
                )))
              : _listPemenangTenderRefresher())
    ]);
  }

  Widget _listPemenangTenderRefresher() {
    return SmartRefresher(
        enablePullUp:
            controller.listPemenangTender.length == controller.countSearch.value
                ? false
                : true,
        controller: controller.refreshController,
        onLoading: () async {
          controller.countData.value += 1;
          await controller.getListTender(
              controller.countData.value, controller.jenisTab.value);
        },
        onRefresh: () async {
          controller.listPemenangTender.clear();
          controller.isLoadingData.value = true;
          await controller.getListTender(1, controller.jenisTab.value);
        },
        child: _listPemenangTenderTile());
  }

  Widget _listPemenangTenderTile() {
    return ListView.builder(
      itemCount: controller.listPemenangTender.length,
      itemBuilder: (content, index) {
        return controller.jenisTab.value == 'BelumDiumumkan'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Obx(() => Stack(
                          children: [
                            Positioned(
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                    onTap: () async {
                                      controller.cekDetail =
                                          await SharedPreferencesHelper
                                              .getHakAkses(
                                                  "Lihat Detail Tender",denganLoading:true);
                                      if (SharedPreferencesHelper.cekAkses(
                                          controller.cekDetail)) {
                                        var data = await GetToPage.toNamed<
                                                DetailProsesTenderController>(
                                            Routes.DETAIL_PROSES_TENDER,
                                            arguments: [
                                              controller
                                                      .listPemenangTender[index]
                                                  ['id'],
                                              controller.jenisTab.value
                                            ]);
                                        print('LIST BELUMDIUMUMKAN');
                                        print(data);
                                        if (data == null) {
                                          controller.refreshAll();
                                        }
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            0,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                14),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      12)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      16,
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      9,
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      13,
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      11),
                                              decoration: BoxDecoration(
                                                  color: Color(ListColor.color4)
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10))),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                    child: Wrap(children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomText(
                                                              controller.listPemenangTender[
                                                                      index]
                                                                  ['judul'],
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              wrapSpace: true,
                                                              height: 1.4),
                                                          SizedBox(
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  2),
                                                          CustomText(
                                                            controller
                                                                    .listPemenangTender[
                                                                index]['kode'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            //
                                                            color: Color(
                                                                ListColor
                                                                    .colorBlue),
                                                          )
                                                        ],
                                                      )
                                                    ]),
                                                  )),
                                                  SizedBox(
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        22,
                                                  ),
                                                  GestureDetector(
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                2,
                                                          ),
                                                          child: SvgPicture.asset(
                                                              GlobalVariable
                                                                      .imagePath +
                                                                  "more_vert.svg",
                                                              color: Color(ListColor
                                                                  .colorIconVert),
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  24,
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24)),
                                                      onTap: () {
                                                        controller.opsi(
                                                            controller.listPemenangTender[
                                                                index]['id'],
                                                            controller.listPemenangTender[
                                                                    index][
                                                                'sudahAdaPemenang']);
                                                      }),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      14,
                                                  horizontal:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                // borderRadius: BorderRadius.only(
                                                //     bottomLeft: Radius.circular(borderRadius),
                                                //     bottomRight: Radius.circular(borderRadius))
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  GlobalVariable
                                                                          .imagePath +
                                                                      "periode_seleksi.svg",
                                                                  width: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      14,
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      14),
                                                              SizedBox(
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      20),
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                          child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                    CustomText(
                                                                      "PemenangTenderIndexLabelPeriodeSeleksi"
                                                                          .tr, //Periode Seleksi
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      //
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorGrey4),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                3),
                                                                    CustomText(
                                                                      controller
                                                                              .listPemenangTender[index]
                                                                          [
                                                                          'periodeSeleksi'],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      //
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlack),
                                                                    )
                                                                  ])))
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              12,
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  GlobalVariable
                                                                          .imagePath +
                                                                      "periode_pengumuman.svg",
                                                                  width: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      14,
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      14),
                                                              SizedBox(
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      20),
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                          child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                    CustomText(
                                                                      "PemenangTenderIndexLabelPeriodePengumuman"
                                                                          .tr, //Periode Pengumuman
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      //
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorGrey4),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                3),
                                                                    CustomText(
                                                                      controller
                                                                              .listPemenangTender[index]
                                                                          [
                                                                          'periodePengumuman'],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      //
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlack),
                                                                    )
                                                                  ])))
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              12,
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  GlobalVariable
                                                                          .imagePath +
                                                                      "rute.svg",
                                                                  width: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      14,
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      14),
                                                              SizedBox(
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      20),
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                          child:
                                                                              CustomText(
                                                                controller.listPemenangTender[
                                                                        index]
                                                                    ['rute'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                //
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey4),
                                                              )))
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              12,
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  GlobalVariable
                                                                          .imagePath +
                                                                      "muatan.svg",
                                                                  width: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      12,
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      12),
                                                              SizedBox(
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      20),
                                                              Expanded(
                                                                  child:
                                                                      CustomText(
                                                                GlobalVariable.formatMuatan(
                                                                    controller.listPemenangTender[
                                                                            index]
                                                                        [
                                                                        'muatan']),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                //
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey4),
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              12,
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  GlobalVariable
                                                                          .imagePath +
                                                                      "pemenang_blue.svg",
                                                                  width: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      14,
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      14),
                                                              SizedBox(
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      20),
                                                              Expanded(
                                                                  child:
                                                                      CustomText(
                                                                controller
                                                                    .listPemenangTender[
                                                                        index][
                                                                        'pemenang']
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                //
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey4),
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(Get.context)
                                                  .size
                                                  .width,
                                              height: 0.5,
                                              color: Color(
                                                  ListColor.colorLightGrey2),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: GlobalVariable.ratioWidth(Get.context) *
                                                        16,
                                                    right: GlobalVariable.ratioWidth(Get.context) *
                                                        16,
                                                    top: GlobalVariable.ratioWidth(Get.context) *
                                                        7.5,
                                                    bottom:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            7),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius.circular(
                                                            GlobalVariable.ratioWidth(Get.context) * 10),
                                                        bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                        child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        // BERAKHIR HARI INI
                                                        int.parse(controller.listPemenangTender[index]['sisaHari'].toString()) ==
                                                                0
                                                            ? Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: GlobalVariable.ratioWidth(Get.context) *
                                                                        4,
                                                                    horizontal:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            8),
                                                                decoration: BoxDecoration(
                                                                    color: Color(ListColor
                                                                        .colorBackgroundLabelBatal),
                                                                    borderRadius:
                                                                        BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                            6)),
                                                                child: Row(
                                                                    children: [
                                                                      CustomText(
                                                                          "PemenangTenderIndexLabelBerakhirHariIni".tr +
                                                                              " ", // Berakhir hari ini
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(ListColor.colorRed)),
                                                                      Image
                                                                          .asset(
                                                                        GlobalVariable.imagePath +
                                                                            "warning_icon.png",
                                                                        width: GlobalVariable.ratioWidth(Get.context) *
                                                                            14,
                                                                      ),
                                                                    ]))
                                                            : int.parse(controller.listPemenangTender[index]['sisaHari'].toString()) <
                                                                    0
                                                                ?

                                                                // TELAH BERAKHIR
                                                                Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical: GlobalVariable.ratioWidth(Get.context) * 4,
                                                                        horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                                    decoration: BoxDecoration(color: Color(ListColor.colorBackgroundLabelBatal), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                                    child: Row(children: [
                                                                      CustomText(
                                                                          "PemenangTenderIndexLabelTelahBerakhir".tr +
                                                                              " ", // Telah Berakhir
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              Color(ListColor.colorRed)),
                                                                      Image
                                                                          .asset(
                                                                        GlobalVariable.imagePath +
                                                                            "warning_icon.png",
                                                                        width: GlobalVariable.ratioWidth(Get.context) *
                                                                            14,
                                                                      ),
                                                                    ]))
                                                                : int.parse(controller.listPemenangTender[index]['sisaHari'].toString()) < 4
                                                                    ?

                                                                    // BERAKHIR DALAM 3 HARI
                                                                    Container(
                                                                        padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                                        decoration: BoxDecoration(color: Color(ListColor.colorWarningTile), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                                        child: Row(children: [
                                                                          CustomText(
                                                                              "PemenangTenderIndexLabelBerakhirDalam".tr + " " + controller.listPemenangTender[index]['sisaHari'] + " " + "PemenangTenderIndexLabelHari".tr, // Berakhir Dalam 3 Hari
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(ListColor.colorBackgroundLabelTidakAdaPeserta)),
                                                                        ]))
                                                                    : int.parse(controller.listPemenangTender[index]['sisaHari'].toString()) < 8
                                                                        ?
                                                                        // BERAKHIR DALAM 7 HARI
                                                                        Container(
                                                                            padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                                            decoration: BoxDecoration(color: Color(ListColor.colorLightGrey12), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                                            child: Row(children: [
                                                                              CustomText("PemenangTenderIndexLabelBerakhirDalam".tr + " " + controller.listPemenangTender[index]['sisaHari'].toString() + " " + "PemenangTenderIndexLabelHari".tr, // Berakhir Dalam 3 Hari
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: Color(ListColor.colorBlack)),
                                                                            ]))
                                                                        : SizedBox()
                                                      ],
                                                    )),
                                                    Material(
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              20),
                                                      color: !controller
                                                                      .listPemenangTender[
                                                                  index][
                                                              'sudahAdaPemenang']
                                                          ? Color(ListColor
                                                              .colorBlue)
                                                          : Colors.white,
                                                      child: InkWell(
                                                          customBorder:
                                                              RoundedRectangleBorder(
                                                            borderRadius: BorderRadius
                                                                .circular(GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    18),
                                                          ),
                                                          onTap: () async {
                                                            controller.getDetail(
                                                                controller.listPemenangTender[
                                                                        index]
                                                                    ['id'],
                                                                (!controller.listPemenangTender[
                                                                            index]
                                                                        [
                                                                        'sudahAdaPemenang']
                                                                    ? 'PILIH'
                                                                    : 'LIHAT'));
                                                          },
                                                          child: Container(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          24,
                                                                  vertical:
                                                                      GlobalVariable.ratioWidth(Get
                                                                              .context) *
                                                                          6),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      width:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              1,
                                                                      color: ((controller.cekPilihPemenang && !controller.listPemenangTender[index]['sudahAdaPemenang']) ||
                                                                              (controller.cekLihatPemenang && controller.listPemenangTender[index]['sudahAdaPemenang']))
                                                                          ? Color(ListColor.colorBlue)
                                                                          : Color(ListColor.colorAksesDisable)),
                                                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                                                              child: Center(
                                                                child: CustomText(
                                                                    (!controller.listPemenangTender[index]['sudahAdaPemenang']
                                                                            ? 'PemenangTenderIndexLabelPilihPemenang' //'Pilih Pemenang'.tr,
                                                                            : 'PemenangTenderIndexLabelLihatPemenang') //'Lihat Pemenang'.tr,
                                                                        .tr,
                                                                    fontSize: 12,
                                                                    color: !controller.listPemenangTender[index]['sudahAdaPemenang']
                                                                        ? Colors.white
                                                                        : controller.cekLihatPemenang
                                                                            ? Color(ListColor.colorBlue)
                                                                            : Color(ListColor.colorAksesDisable),
                                                                    fontWeight: FontWeight.w600),
                                                              ))),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        )),
                                  )),
                            ),
                          ],
                        ))
                  ])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Stack(children: [
                      Positioned(
                          child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () async {
                            controller.cekDetail =
                                await SharedPreferencesHelper.getHakAkses(
                                    "Lihat Detail Tender",denganLoading:true);
                            if (SharedPreferencesHelper.cekAkses(
                                controller.cekDetail)) {
                              var data = await GetToPage.toNamed<
                                      DetailProsesTenderController>(
                                  Routes.DETAIL_PROSES_TENDER,
                                  arguments: [
                                    controller.listPemenangTender[index]['id'],
                                    controller.jenisTab.value
                                  ]);

                              if (data == null) {
                                controller.refreshAll();
                              }
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  0,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            9,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            13,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11),
                                    decoration: BoxDecoration(
                                        color: Color(
                                            ListColor.colorHeaderListTender),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    10),
                                            topRight: Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    10))),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            child: Container(
                                          child: Wrap(children: [
                                            CustomText(
                                                controller.listPemenangTender[
                                                    index]['judul'],
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                wrapSpace: true,
                                                height: 1.4)
                                          ]),
                                        )),
                                        SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              22,
                                        ),
                                        Container(
                                          child: CustomText(
                                              controller.listPemenangTender[
                                                          index]
                                                      ['tanggalDiputuskan'] +
                                                  "\n" +
                                                  controller.listPemenangTender[
                                                      index]['jamDiputuskan'] +
                                                  " " +
                                                  controller.listPemenangTender[
                                                      index]['zonaWaktu'],
                                              fontSize: 10,
                                              height: 1.3,
                                              textAlign: TextAlign.right,
                                              color: Color(ListColor.colorBlue),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              5,
                                        ),
                                        GestureDetector(
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                  top: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      2,
                                                ),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        "more_vert.svg",
                                                    color: Color(ListColor
                                                        .colorIconVert),
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        24,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        24)),
                                            onTap: () {
                                              controller.opsi(
                                                  controller.listPemenangTender[
                                                      index]['id'],
                                                  controller.listPemenangTender[
                                                          index]
                                                      ['sudahAdaPemenang']);
                                            }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.only(
                                      //     bottomLeft: Radius.circular(borderRadius),
                                      //     bottomRight: Radius.circular(borderRadius))
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    SvgPicture.asset(
                                                        GlobalVariable
                                                                .imagePath +
                                                            "kode.svg",
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            14,
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            14),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    Expanded(
                                                        child: Container(
                                                            child: CustomText(
                                                      controller
                                                              .listPemenangTender[
                                                          index]['kode'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      //
                                                      color: Color(
                                                          ListColor.colorGrey4),
                                                    )))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    controller.listPemenangTender[
                                                            index]
                                                        ['labelPeriode'] = true;
                                                    print(controller
                                                            .listPemenangTender[
                                                        index]['labelPeriode']);
                                                    controller
                                                        .listPemenangTender
                                                        .refresh();
                                                  },
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        SvgPicture.asset(
                                                            GlobalVariable
                                                                    .imagePath +
                                                                "periode_pengumuman.svg",
                                                            width: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                14,
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                14),
                                                        SizedBox(
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20),
                                                        Expanded(
                                                            child: Container(
                                                                child:
                                                                    CustomText(
                                                          controller.listPemenangTender[
                                                                  index][
                                                              'periodePengumuman'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          //
                                                          color: Color(ListColor
                                                              .colorGrey4),
                                                        )))
                                                      ],
                                                    ),
                                                  )),
                                              SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12,
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    SvgPicture.asset(
                                                        GlobalVariable
                                                                .imagePath +
                                                            "rute.svg",
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            14,
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            14),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    Expanded(
                                                        child: CustomText(
                                                      controller
                                                              .listPemenangTender[
                                                          index]['rute'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      //
                                                      color: Color(
                                                          ListColor.colorGrey4),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12,
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    SvgPicture.asset(
                                                        GlobalVariable
                                                                .imagePath +
                                                            "muatan.svg",
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            12,
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            12),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    Expanded(
                                                        child: CustomText(
                                                      GlobalVariable.formatMuatan(
                                                          controller
                                                                  .listPemenangTender[
                                                              index]['muatan']),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      //
                                                      color: Color(
                                                          ListColor.colorGrey4),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12,
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    SvgPicture.asset(
                                                        GlobalVariable
                                                                .imagePath +
                                                            "pemenang_blue.svg",
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            14,
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            14),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    Expanded(
                                                        child: CustomText(
                                                      controller
                                                          .listPemenangTender[
                                                              index]['pemenang']
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      //
                                                      color: Color(
                                                          ListColor.colorGrey4),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(Get.context).size.width,
                                    height: 0.5,
                                    color: Color(ListColor.colorLightGrey2),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          right:
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  16,
                                          top: GlobalVariable.ratioWidth(Get.context) *
                                              7.5,
                                          bottom:
                                              GlobalVariable.ratioWidth(Get.context) *
                                                  7),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                  GlobalVariable.ratioWidth(Get.context) * 10),
                                              bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(child: CustomText('')),
                                          Material(
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20),
                                            color: Color(ListColor.colorBlue),
                                            child: InkWell(
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          18),
                                                ),
                                                onTap: () async {
                                                  controller.getDetail(
                                                      controller
                                                              .listPemenangTender[
                                                          index]['id'],
                                                      'LIHAT');
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            24,
                                                        vertical: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            7),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                GlobalVariable.ratioWidth(
                                                                        Get.context) *
                                                                    20)),
                                                    child: Center(
                                                      child: CustomText(
                                                          'PemenangTenderIndexLabelLihatPemenang' //'Lihat Pemenang'.tr,
                                                              .tr,
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))),
                                          )
                                        ],
                                      )),
                                ],
                              )),
                        ),
                      )),
                      Obx(() =>
                          controller.listPemenangTender[index]['labelPeriode']
                              ? Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: _periodeTenderLabelWidget(index)),
                                )
                              : SizedBox(
                                  child: Container(color: Colors.red),
                                ))
                    ])
                  ]);
      },
    );
  }

  Future<bool> willpop() async {
    print(controller.mapSort);
    Get.back(result: [
      controller.sortBy.value,
      controller.sortType.value,
      controller.mapSort,
      controller.sort
    ]);
  }
}
