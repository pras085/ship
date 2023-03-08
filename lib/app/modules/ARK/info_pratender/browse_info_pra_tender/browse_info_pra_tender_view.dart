import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/browse_info_pra_tender/browse_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'browse_info_pra_tender_controller.dart';

class BrowseInfoPraTenderView extends GetView<BrowseInfoPraTenderController> {
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
                          color:
                              Color(ListColor.colorLightGrey).withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 8),
                        ),
                      ], color: Colors.white),
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
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
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Obx(() => CustomTextField(
                                          context: Get.context,
                                          autofocus: true,
                                          controller:
                                              controller.searchController.value,
                                          textInputAction:
                                              TextInputAction.search,
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
                                                "InfoPraTenderIndexLabelBrowsePlaceholder"
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
                                                  color: Color(ListColor
                                                      .colorLightGrey7),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          7),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(ListColor
                                                      .colorLightGrey7),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          7),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      Color(ListColor.color4),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1),
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (controller.listInfoPraTender.length >
                                          0) {
                                        controller.showSortingDialog();
                                      }
                                    },
                                    child: Obx(() => controller
                                                .listInfoPraTender.length >
                                            0
                                        ? controller.sortBy.value == ""
                                            ? SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg",
                                                color: Colors.black,
                                                width: GlobalVariable.ratioWidth(Get.context) *
                                                    24,
                                                height: GlobalVariable.ratioWidth(Get.context) *
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
                  body: _listInfoPraTender()
                  // Obx(
                  //   () => controller.lastShow.value
                  //       ? _listLastSearch()
                  //       : _listInfoPraTender(),
                  // ),
                  )),
        ));
  }

  // Widget _listLastSearch() {
  //   return Container(
  //     margin: EdgeInsets.only(
  //         left: GlobalVariable.ratioWidth(Get.context) * 16,
  //         right: GlobalVariable.ratioWidth(Get.context) * 16),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.max,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Container(
  //             margin: EdgeInsets.only(
  //                 top: GlobalVariable.ratioWidth(Get.context) * 20,
  //                 bottom: GlobalVariable.ratioWidth(Get.context) * 11),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 CustomText(
  //                     "InfoPraTenderCreateLabelTerakhirDicari"
  //                         .tr, // Terakhir dicari
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.w600,
  //                     color: Colors.black),
  //                 GestureDetector(
  //                   onTap: controller.clearHistorySearch,
  //                   child: CustomText(
  //                       "InfoPraTenderCreateLabelHapusSemua"
  //                           .tr, // Hapus Semua
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w600,
  //                       color: Color(ListColor.colorRed2)),
  //                 )
  //               ],
  //             )),
  //         Obx(() => Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 for (var index = (controller.listHistorySearch.length - 1);
  //                     index >= 0;
  //                     index--)
  //                   GestureDetector(
  //                       onTap: () {
  //                         controller.chooseHistorySearch(index);
  //                       },
  //                       child: Container(
  //                         padding: EdgeInsets.only(
  //                           top: GlobalVariable.ratioWidth(Get.context) * 7,
  //                           bottom:
  //                               GlobalVariable.ratioWidth(Get.context) * 10,
  //                         ),
  //                         child: Row(
  //                           mainAxisSize: MainAxisSize.max,
  //                           children: [
  //                             SvgPicture.asset(GlobalVariable.imagePath+"pencarianterakhir.svg",
  //                                     width: GlobalVariable.ratioWidth(
  //                                             Get.context) *
  //                                         16,
  //                                     height: GlobalVariable.ratioWidth(
  //                                             Get.context) *
  //                                         16),

  //                             Container(
  //                                 width:
  //                                     GlobalVariable.ratioWidth(Get.context) *
  //                                         16),
  //                             Expanded(
  //                                 child: CustomText(
  //                                     controller.listHistorySearch[index],
  //                                     fontSize: 12,
  //                                     fontWeight: FontWeight.w600,
  //                                     color: Colors.black)),
  //                             GestureDetector(
  //                                 onTap: () {
  //                                   controller.hapusHistorySearch(index);
  //                                 },
  //                                 child: SvgPicture.asset(GlobalVariable.imagePath+"ic_close.svg",
  //                                     width: GlobalVariable.ratioWidth(
  //                                             Get.context) *
  //                                         16,
  //                                     height: GlobalVariable.ratioWidth(
  //                                             Get.context) *
  //                                         16)),
  //                           ],
  //                         ),
  //                       )),
  //               ],
  //             ))
  //       ],
  //     ),
  //   );
  // }

  Widget _listInfoPraTender() {
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
                        bottom: (controller.listInfoPraTender.length == 0 &&
                                !controller.isLoadingData
                                    .value) // ni muncul ketika belum ada info pra tender
                            ? GlobalVariable.ratioWidth(Get.context) * 0
                            : GlobalVariable.ratioWidth(Get.context) * 13,
                      ),
                      child: controller.searchController.value.text != "" &&
                              !controller.isLoadingData.value &&
                              controller.searchOn.value
                          ? Container(
                              child: controller.listInfoPraTender.length > 0
                                  ? RichText(
                                      text: TextSpan(
                                          text: "InfoPraTenderIndexLabelMenampilkan"
                                                  .tr +
                                              " " +
                                              controller.countSearch
                                                  .toString() +
                                              " " +
                                              "InfoPraTenderIndexLabelHasilUntuk"
                                                  .tr +
                                              " \"", // Menampilkan hasil untuk
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
                                          text: "InfoPraTenderIndexLabelTidakDitemukan"
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
                  Expanded(child: _showListInfoPraTender()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showListInfoPraTender() {
    return Stack(children: [
      //KALAU MASIH LOADING
      Obx(() => controller.isLoadingData.value
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA
          (controller.listInfoPraTender.length == 0 &&
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
                        'InfoPraTenderIndexLabelSearchKeyword'.tr +
                            'InfoPraTenderIndexLabelSearchTidakDitemukan'.tr +
                            '\n' +
                            'InfoPraTenderIndexLabelDiSistem'
                                .tr, //Keyword tidak ditemukan disistem,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3))
                  ],
                )))
              : _listInfoPraTenderRefresher())
    ]);
  }

  Widget _listInfoPraTenderRefresher() {
    return SmartRefresher(
        enablePullUp:
            controller.listInfoPraTender.length == controller.countSearch.value
                ? false
                : true,
        controller: controller.refreshController,
        onLoading: () async {
          controller.countData.value += 1;
          await controller.getListPratender(
              controller.countData.value, controller.jenisTab.value);
        },
        onRefresh: () async {
          controller.listInfoPraTender.clear();
          controller.isLoadingData.value = true;
          await controller.getListPratender(1, controller.jenisTab.value);
        },
        child: _listInfoPraTenderTile());
  }

  Widget _listInfoPraTenderTile() {
    return ListView.builder(
      itemCount: controller.listInfoPraTender.length,
      itemBuilder: (content, index) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  GlobalAlertDialog.showAlertDialogCustom(
                      context: Get.context,
                      title: "ProsesTenderCreateLabelJudulKonfirmasiPilihan"
                          .tr, //Konfirmasi Pilihan
                      message:
                          "ProsesTenderCreateLabelKonfirmasiPilihan1" //Apakah anda yakin ingin melakukan perubahan data jumlah unit?
                                  .tr +
                              "\n" +
                              "ProsesTenderCreateLabelKonfirmasiPilihan2" //Data yang telah diisi pada data rute yang ditenderkan harus diupdate
                                  .tr,
                      labelButtonPriority1: GlobalAlertDialog.yesLabelButton,
                      onTapPriority1: () async {
                        Get.back(result: [
                          controller.listInfoPraTender[index]['id'],
                          controller.listInfoPraTender[index]['kode']
                        ]);
                      },
                      onTapPriority2: () async {},
                      labelButtonPriority2: GlobalAlertDialog.noLabelButton);
                },
                child: Container(
                    margin: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(Get.context) * 16,
                        0,
                        GlobalVariable.ratioWidth(Get.context) * 16,
                        GlobalVariable.ratioWidth(Get.context) * 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
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
                              GlobalVariable.ratioWidth(Get.context) * 16,
                              GlobalVariable.ratioWidth(Get.context) * 12,
                              GlobalVariable.ratioWidth(Get.context) * 16,
                              GlobalVariable.ratioWidth(Get.context) * 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                  topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          controller.listInfoPraTender[index]
                                              ['kode'],
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(ListColor.colorBlack1B)),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              2),
                                      CustomText(
                                        controller.listInfoPraTender[index]
                                            ['judul'],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        maxLines: 2,
                                        wrapSpace: true,
                                        color: Color(ListColor.colorLightGrey4),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ]),
                              )),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 22,
                              ),
                              Container(
                                child: CustomText(
                                    controller.listInfoPraTender[index]
                                            ['tanggalDibuat'] +
                                        "\n" +
                                        controller.listInfoPraTender[index]
                                            ['jamDibuat'] +
                                        " " +
                                        controller.listInfoPraTender[index]
                                            ['zonaWaktu'],
                                    fontSize: 10,
                                    height: 1.3,
                                    textAlign: TextAlign.right,
                                    color: Color(ListColor.colorBlack1B),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 8,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 16),
                          child: controller.lineDividerWidget(),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              left: GlobalVariable.ratioWidth(Get.context) * 16,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                  bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "rute.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20),
                                          Expanded(
                                              child: Container(
                                                  child: CustomText(
                                            controller.listInfoPraTender[index]
                                                ['rute'],
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          )))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "muatan.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20),
                                          Expanded(
                                              child: CustomText(
                                            GlobalVariable.formatMuatan(
                                                controller.listInfoPraTender[
                                                    index]['muatan']),
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "diumumkan_kepada.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20),
                                          Expanded(
                                              child: CustomText(
                                            controller.listInfoPraTender[index]
                                                ['transporter'],
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            //
                                            color: Color(ListColor.colorGrey4),
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
                          width: MediaQuery.of(Get.context).size.width,
                          height: 0.5,
                          color: Color(ListColor.colorLightGrey2),
                        ),
                      ],
                    )),
              )
            ]);
      },
    );
  }

  Future<bool> willpop() async {
    Get.back();
  }
}
