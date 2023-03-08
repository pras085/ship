import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_penawaran/list_halaman_peserta_detail_penawaran_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'search_list_halaman_peserta_controller.dart';

class SearchListHalamanPesertaView
    extends GetView<SearchListHalamanPesertaController> {
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
                                              "ProsesTenderLihatPesertaLabelSearchPlaceholder"
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
                                    if (controller.listPeserta.length > 0 &&
                                        !controller.lastShow.value) {
                                      controller.showSortingDialog();
                                    }
                                  },
                                  child: Obx(() => controller.listPeserta.length > 0 &&
                                          !controller.lastShow.value
                                      ? controller.sortBy.value == ""
                                          ? SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg",
                                              color: Colors.black,
                                              width: GlobalVariable.ratioWidth(Get.context) *
                                                  24,
                                              height: GlobalVariable.ratioWidth(Get.context) *
                                                  24)
                                          : SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "ic_sort_black_on.svg",
                                              width: GlobalVariable.ratioWidth(Get.context) *
                                                  24,
                                              height: GlobalVariable.ratioWidth(Get.context) *
                                                  24)
                                      : //
                                      SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg",
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
                      : _listPeserta(),
                )),
          ),
        ));
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
                      "ProsesTenderLihatPesertaLabelTerakhirDicari"
                          .tr, // Terakhir dicari
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  GestureDetector(
                    onTap: controller.clearHistorySearch,
                    child: CustomText(
                        "ProsesTenderLihatPesertaLabelHapusSemua"
                            .tr, // Hapus Semua
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
                    for (var index = (controller.listHistorySearch.length - 1);
                        index >= 0;
                        index--)
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

  Widget _listPeserta() {
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
                        bottom: (controller.listPeserta.length == 0 &&
                                !controller.isLoadingData
                                    .value) // ni muncul ketika belum ada info pra tender
                            ? GlobalVariable.ratioWidth(Get.context) * 0
                            : GlobalVariable.ratioWidth(Get.context) * 13,
                      ),
                      child: controller.searchController.value.text != "" &&
                              !controller.isLoadingData.value &&
                              controller.searchOn.value
                          ? Container(
                              child: controller.listPeserta.length > 0
                                  ? RichText(
                                      text: TextSpan(
                                          text: "ProsesTenderLihatPesertaLabelMenampilkan"
                                                  .tr +
                                              " " +
                                              GlobalVariable
                                                      .formatCurrencyDecimal(
                                                          controller.countSearch
                                                              .toString())
                                                  .toString() +
                                              " " +
                                              "ProsesTenderLihatPesertaLabelHasilUntuk"
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
                                          text: "ProsesTenderLihatPesertaLabelTidakDitemukan"
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
                  Expanded(child: _showListPeserta()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showListPeserta() {
    return Stack(children: [
      //KALAU MASIH LOADING
      Obx(() => controller.isLoadingData.value
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA
          (controller.listPeserta.length == 0 &&
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
                        'ProsesTenderLihatPesertaLabelSearchKeyword'.tr +
                            " " +
                            'ProsesTenderLihatPesertaLabelSearchTidakDitemukan'
                                .tr +
                            '\n' +
                            'ProsesTenderLihatPesertaLabelDiSistem'
                                .tr, //Keyword tidak ditemukan disistem,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3))
                  ],
                )))
              : _listPesertaRefresher())
    ]);
  }

  Widget _listPesertaRefresher() {
    return SmartRefresher(
        enablePullUp:
            controller.listPeserta.length == controller.countSearch.value
                ? false
                : true,
        controller: controller.refreshController,
        onLoading: () async {
          controller.countData.value += 1;
          await controller.getListPeserta(controller.countData.value);
        },
        onRefresh: () async {
          controller.listPeserta.clear();
          controller.isLoadingData.value = true;
          await controller.getListPeserta(1);
        },
        child: _listPesertaTile());
  }

  Widget _listPesertaTile() {
    return ListView.builder(
      itemCount: controller.listPeserta.length,
      itemBuilder: (content, index) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  var data = await GetToPage.toNamed<
                          ListHalamanPesertaDetailPenawaranController>(
                      Routes.LIST_HALAMAN_PESERTA_DETAIL_PENAWARAN,
                      arguments: [
                        controller.dataRuteTender,
                        controller.satuanTender,
                        controller.satuanVolume,
                        controller.listPeserta[index]['transporter'] +
                            " (" +
                            controller.listPeserta[index]['kota'] +
                            ")",
                        controller.listPeserta[index]['tanggalDibuat'] +
                            " " +
                            controller.listPeserta[index]['jamDibuat'] +
                            " " +
                            controller.listPeserta[index]['zonaWaktu'],
                        controller.idTender,
                        controller.listPeserta[index]['idtransporter']
                      ]);
                  if (data != null) {}
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
                              GlobalVariable.ratioWidth(Get.context) * 8,
                              GlobalVariable.ratioWidth(Get.context) * 13,
                              GlobalVariable.ratioWidth(Get.context) * 7),
                          decoration: BoxDecoration(
                              color: Color(ListColor.colorHeaderListTender),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                  topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          controller.listPeserta[index]
                                              ['transporter'],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          wrapSpace: true,
                                          height: 1.2),
                                      CustomText(
                                          controller.listPeserta[index]['kota'],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                          color: Color(ListColor.colorGrey3),
                                          height: 1.2)
                                    ]),
                              )),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 22,
                              ),
                              Container(
                                child: CustomText(
                                    controller.listPeserta[index]
                                            ['tanggalDibuat'] +
                                        "\n" +
                                        controller.listPeserta[index]
                                            ['jamDibuat'] +
                                        " " +
                                        controller.listPeserta[index]
                                            ['zonaWaktu'],
                                    fontSize: 10,
                                    height: 1.3,
                                    textAlign: TextAlign.right,
                                    color: Color(ListColor.colorBlue),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 5,
                              ),
                              GestureDetector(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            2,
                                      ),
                                      child: SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              "more_vert.svg",
                                          color: Color(ListColor.colorIconVert),
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24)),
                                  onTap: () {
                                    controller.opsi(controller
                                        .listPeserta[index]['idtransporter']);
                                  }),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 16),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "hargapenawaran.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          Expanded(
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          2),
                                                  child: CustomText(
                                                    "ProsesTenderLihatPesertaLabelHargaPenawaran"
                                                        .tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    //
                                                    color: Colors.black,
                                                  )))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24),
                                          Expanded(
                                              child: Container(
                                                  child: CustomText(
                                            controller.listPeserta[index]['hargaPenawaranTerkecil'] !=
                                                    controller.listPeserta[index][
                                                        'hargaPenawaranTerbesar']
                                                ? ('Rp' +
                                                    GlobalVariable.formatCurrencyDecimal(
                                                        controller.listPeserta[index][
                                                            'hargaPenawaranTerkecil']) +
                                                    ' - Rp' +
                                                    GlobalVariable.formatCurrencyDecimal(
                                                        controller.listPeserta[index]
                                                            [
                                                            'hargaPenawaranTerbesar']))
                                                : ('Rp' +
                                                    GlobalVariable.formatCurrencyDecimal(
                                                        controller.listPeserta[index]
                                                            ['hargaPenawaranTerkecil'])),
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            height: 1.2,
                                            fontWeight: FontWeight.w500,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          )))
                                        ],
                                      ),
                                    )
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
                        Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                top: GlobalVariable.ratioWidth(Get.context) *
                                    7.5,
                                bottom:
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                    bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(""),
                                  ],
                                )),
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20),
                                  color: Color(ListColor.colorBlue),
                                  child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18),
                                      ),
                                      onTap: () async {
                                        var data = await GetToPage.toNamed<
                                                ListHalamanPesertaDetailPenawaranController>(
                                            Routes
                                                .LIST_HALAMAN_PESERTA_DETAIL_PENAWARAN,
                                            arguments: [
                                              controller.dataRuteTender,
                                              controller.satuanTender,
                                              controller.satuanVolume,
                                              controller.listPeserta[index]
                                                      ['transporter'] +
                                                  " (" +
                                                  controller.listPeserta[index]
                                                      ['kota'] +
                                                  ")",
                                              controller.listPeserta[index]
                                                      ['tanggalDibuat'] +
                                                  " " +
                                                  controller.listPeserta[index]
                                                      ['jamDibuat'] +
                                                  " " +
                                                  controller.listPeserta[index]
                                                      ['zonaWaktu'],
                                              controller.idTender,
                                              controller.listPeserta[index]
                                                  ['idtransporter']
                                            ]);
                                        if (data != null) {}
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                              vertical:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      7),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          20)),
                                          child: Center(
                                            child: CustomText(
                                                'ProsesTenderLihatPesertaButtonDetail'
                                                    .tr, //'Detail'.tr,
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ))),
                                )
                              ],
                            ))
                      ],
                    )),
              )
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
