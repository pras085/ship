import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_list_harga_promo/ZO_helper/ZO_helper_widget.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_list_harga_promo/ZO_list_harga_promo_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoSearchPageManajementPromoView
    extends GetView<ZoListHargaPromoController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {},
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioFontSize(context) * 63),
            child: Container(
              // height: GlobalVariable.ratioWidth(context) * 58,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ], color: Colors.white),
              child: Obx(
                () => Stack(alignment: Alignment.bottomCenter, children: [
                  Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(context) * 10.0,
                          GlobalVariable.ratioWidth(context) * 12.0,
                          GlobalVariable.ratioWidth(context) * 10.0,
                          GlobalVariable.ratioWidth(context) * 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            child: ClipOval(
                              child: Material(
                                  shape: CircleBorder(),
                                  color: Color(ListColor.colorBlue),
                                  child: InkWell(
                                      onTap: () {
                                        // controller.onClearSearch();
                                        controller.cari.value.text = "";
                                        Get.back(result: true);
                                      },
                                      child: Container(
                                          width:
                                              GlobalVariable.ratioFontSize(
                                                      context) *
                                                  28,
                                          height: GlobalVariable.ratioFontSize(
                                                  context) *
                                              28,
                                          child: Center(
                                              child: Icon(
                                            Icons.arrow_back_ios_rounded,
                                            size: GlobalVariable.ratioFontSize(
                                                    context) *
                                                19,
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
                                    key: ValueKey("CariHargaPromoSearch"),
                                    context: Get.context,
                                    autofocus: true,
                                    onTap: () {},
                                    onChanged: (value) {
                                      controller.clearSearch(
                                          value, Get.arguments[0]);
                                      if (value.length > 0) {
                                        controller.typingSearch.value = true;
                                      } else {
                                        controller.typingSearch.value = false;
                                      }
                                    },
                                    controller: controller.cari.value,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) {
                                      controller.cari.value.text = value;
                                      controller.submitSearch(
                                          value, Get.arguments[0]);
                                      if (Get.arguments[0] ==
                                          "data-promo-aktif") {
                                        controller.setLastSearch(value);
                                      } else {
                                        controller.setLastSearchHistory(value);
                                      }
                                    },
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    newContentPadding: EdgeInsets.symmetric(
                                        horizontal: 42,
                                        vertical: GlobalVariable.ratioWidth(
                                                context) *
                                            6),
                                    textSize:
                                        GlobalVariable.ratioFontSize(context) *
                                            14,
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      hintText: "Cari Harga Promo"
                                          .tr, // "Cari Area Pick Up",
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color:
                                              Color(ListColor.colorLightGrey22),
                                          fontWeight: FontWeight.w600),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey10),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey10),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey10),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(left: 7),
                                  child: SvgPicture.asset(
                                    "assets/search_magnifition_icon.svg",
                                    width: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        28,
                                    height: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        28,
                                    color: Color(ListColor.colorBlue),
                                  ),
                                ),
                                if (controller.typingSearch.isTrue)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.cari.value.text = "";
                                        controller.typingSearch.value = false;
                                        controller.clearSearch(
                                            "", Get.arguments[0]);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Color(ListColor.colorGrey3),
                                            size: GlobalVariable.ratioFontSize(
                                                    Get.context) *
                                                24,
                                          )),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          sizeBoxWidth(4),
                          GestureDetector(
                              onTap: () {
                                if (Get.arguments[0] == "data-promo-aktif") {
                                  if (controller.listManajementPromoDataSearch
                                          .length >
                                      0) {
                                    controller.showSort(Get.arguments[0]);
                                  }
                                } else {
                                  if (controller
                                          .listManajementPromoDataSearchHistory
                                          .length >
                                      0) {
                                    controller.showSort(Get.arguments[0]);
                                  }
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/sorting_icon.svg",
                                    width:
                                        GlobalVariable.ratioFontSize(context) *
                                            22,
                                    height:
                                        GlobalVariable.ratioFontSize(context) *
                                            22,
                                    color: Get.arguments[0] ==
                                            "data-promo-aktif"
                                        ? controller.listManajementPromoDataSearch
                                                    .length >
                                                0
                                            ? Colors.black
                                            : Color(ListColor.colorLightGrey23)
                                        : controller.listManajementPromoDataSearchHistory
                                                    .length >
                                                0
                                            ? Colors.black
                                            : Color(ListColor.colorLightGrey23),
                                  ))),
                        ],
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
          ),
          body: Obx(
            () => Get.arguments[0] == "data-promo-aktif"
                ? controller.listManajementPromoDataSearch.length > 0
                    ? _adadataSearch()
                    : controller.cari.value.text == ""
                        ? _awalKetik()
                        : controller.isLoading.isTrue
                            ? Center(
                                child: SizedBox(
                                  child: CircularProgressIndicator(),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            : _tidakAdaDataPencarian()
                : controller.listManajementPromoDataSearchHistory.length > 0
                    ? _adadataSearch()
                    : controller.cari.value.text == ""
                        ? _awalKetik()
                        : controller.isLoading.isTrue
                            ? Center(
                                child: SizedBox(
                                  child: CircularProgressIndicator(),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            : _tidakAdaDataPencarian(),
          ),
        ),
      ),
    );
  }

  _awalKetik() {
    return Obx(
      () => Padding(
          padding: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 16,
              right: GlobalVariable.ratioWidth(Get.context) * 16,
              bottom: GlobalVariable.ratioWidth(Get.context) * 0,
              top: GlobalVariable.ratioWidth(Get.context) * 20),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        "LelangMuatBuatLelangBuatLelangLabelTitleTerakhirCari"
                            .tr,
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                        child: GestureDetector(
                      onTap: () {
                        if (Get.arguments[0] == "data-promo-aktif") {
                          controller.deleteAllLastSearch();
                        } else {
                          controller.deleteAllLastSearchHistory();
                        }
                      },
                      child: CustomText(
                        "LelangMuatBuatLelangBuatLelangLabelTitleHapusSemua".tr,
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 10,
                        color: Color(ListColor.colorRed2),
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(Get.context) * 18,
              ),
              if (Get.arguments[0] == "data-promo-aktif")
                if (controller.listChoosenReturn.length < 3)
                  for (var i = 0;
                      i < controller.listChoosenReturn.value.length;
                      i++)
                    _riwayatSeacrh(i)
                else
                  for (var i = 0; i < 3; i++) _riwayatSeacrh(i),
              if (Get.arguments[0] == "data-promo-history")
                if (controller.listChoosenReturnHistory.length < 3)
                  for (var i = 0;
                      i < controller.listChoosenReturnHistory.value.length;
                      i++)
                    _riwayatSeacrhHistory(i)
                else
                  for (var i = 0; i < 3; i++) _riwayatSeacrhHistory(i)
            ],
          )),
    );
  }

  _riwayatSeacrh(int idx) {
    return Obx(
      () => Column(
        children: [
          Container(
            child: GestureDetector(
              onTap: () {
                controller.typingSearch.value = true;
                controller.cari.value.text =
                    controller.listChoosenReturn.value[idx].toString();
              },
              child: Row(
                children: [
                  Container(
                    child: SvgPicture.asset(
                      "assets/timer_icon.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 18,
                      height: GlobalVariable.ratioFontSize(Get.context) * 18,
                    ),
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                  ),
                  Expanded(
                    child: CustomText(
                      controller.listChoosenReturn.value[idx].toString(),
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.black,
                        size: GlobalVariable.ratioFontSize(Get.context) * 18,
                      ),
                      onTap: () {
                        controller.deletLastSearch(idx);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 17,
          ),
        ],
      ),
    );
  }

  _riwayatSeacrhHistory(int idx) {
    return Obx(
      () => Column(
        children: [
          Container(
            child: GestureDetector(
              onTap: () {
                controller.typingSearch.value = true;
                controller.cari.value.text =
                    controller.listChoosenReturnHistory.value[idx].toString();
              },
              child: Row(
                children: [
                  Container(
                    child: SvgPicture.asset(
                      "assets/timer_icon.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 18,
                      height: GlobalVariable.ratioFontSize(Get.context) * 18,
                    ),
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 16,
                  ),
                  Expanded(
                    child: CustomText(
                      controller.listChoosenReturnHistory.value[idx].toString(),
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.black,
                        size: GlobalVariable.ratioFontSize(Get.context) * 18,
                      ),
                      onTap: () {
                        controller.deletLastSearchHistory(idx);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 17,
          ),
        ],
      ),
    );
  }

  _adadataSearch() {
    return ListView(
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                top: GlobalVariable.ratioWidth(Get.context) * 20),
            child: Html(
                style: {
                  "body":
                      Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero)
                },
                data: '<span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #7C9CBF;">' +
                    'Ditemukan hasil pencarian untuk'.tr +
                    ' "</span><span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000;">${controller.cari.value.text}</span><span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #7C9CBF;">"</span>')),
        if (Get.arguments[0] == "data-promo-aktif")
          for (var i = 0;
              i < controller.listManajementPromoDataSearch.value.length;
              i++)
            listPerItem(i)
        else
          for (var i = 0;
              i < controller.listManajementPromoDataSearchHistory.value.length;
              i++)
            listPerItemHistory(i)
      ],
    );

    // SmartRefresher(
    //     enablePullUp: true,
    //     enablePullDown: true,
    //     controller: controller.refreshManajementPromoTabAktifController,
    //     // onLoading: () {
    //     //   // controller.loadData();
    //     // },
    //     // onRefresh: () {
    //     //   // controller.refreshDataSmart();
    //     // },
    //     child: );
  }

  _tidakAdaDataPencarian() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                top: GlobalVariable.ratioWidth(Get.context) * 20),
            child: Html(
                style: {
                  "body":
                      Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero)
                },
                data: '<span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #7C9CBF;">' +
                    'LelangMuatBuatLelangBuatLelangLabelTitleTidakDitemukanHasil'
                        .tr +
                    ' "</span><span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000;">${controller.cari.value.text}</span><span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #7C9CBF;">"</span>')),
        Expanded(
            child: Center(
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            child: SvgPicture.asset(
                          "assets/ic_management_lokasi_no_search.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 82.3,
                          height: GlobalVariable.ratioWidth(Get.context) * 75,
                        )),
                        Container(
                          height: 12,
                        ),
                        Container(
                            child: CustomText(
                          "LelangMuatBuatLelangBuatLelangLabelTitleKeywordTidakDitemukan"
                              .tr
                              .replaceAll("\\n", "\n"),
                          textAlign: TextAlign.center,
                          color: Color(ListColor.colorLightGrey14),
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          height: 1.2,
                        ))
                      ],
                    ))))
      ],
    );
  }

  Widget listPerItem(int index) {
    double borderRadius = 10;

    return Container(
        margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
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
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorYellow),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius))),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: GlobalVariable.ratioFontSize(Get.context) * 0,
                    ),
                    child: pointRutePickToDestinasi(),
                  ),
                  sizeBoxWidth(4),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CustomText(
                              controller.listManajementPromoDataSearch[index]
                                      ["key"]["pickup_location_name"] ??
                                  "",
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14)),
                        ),
                        sizeBoxHeight(9.91),
                        Container(
                          child: CustomText(
                              controller.listManajementPromoDataSearch[index]
                                      ["key"]["destination_location_name"] ??
                                  "",
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14)),
                        )
                      ]),
                ],
              ),
            ),
            Obx(
              () => Container(
                padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey10),
                          border: Border.all(
                              width: 1,
                              color: Color(ListColor.colorLightGrey10)),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      width: MediaQuery.of(Get.context).size.width,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                              controller.listManajementPromoDataSearch[index]
                                      ["key"]["Link"] ??
                                  "",
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    sizeBoxHeight(14),
                    if (controller.lihatLebihBanyakSearch[index])
                      for (var i = 0;
                          i <
                              controller
                                  .listManajementPromoDataSearch[index]
                                      ["detail"]
                                  .length;
                          i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            labelText(
                                controller.listManajementPromoDataSearch[index]
                                        ["detail"][i]["head_name"] +
                                    " - " +
                                    controller.listManajementPromoDataSearch[
                                        index]["detail"][i]["carrier_name"] +
                                    " (${controller.listManajementPromoDataSearch[index]["detail"][i]["min_capacity"].toString()} ~ ${controller.listManajementPromoDataSearch[index]["detail"][i]["max_capacity"].toString()} ${controller.listManajementPromoDataSearch[index]["detail"][i]["capacity_unit"]})",
                                Colors.black,
                                14,
                                FontWeight.w700,
                                linespacing:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        (16.8 / 14)),
                            sizeBoxHeight(8),
                            if (controller.listManajementPromoDataSearch[index]
                                    ["detail"][i]["normal_price"] !=
                                "0")
                              CustomText(
                                "Rp " +
                                        controller.listManajementPromoDataSearch[
                                                index]["detail"][i]
                                            ["normal_price"] ??
                                    "",
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14,
                                color: Color(ListColor.colorGrey3),
                                decoration: TextDecoration.lineThrough,
                              ),
                            if (controller.listManajementPromoDataSearch[index]
                                    ["detail"][i]["normal_price"] !=
                                "0")
                              sizeBoxHeight(4),
                            Row(
                              children: [
                                labelText(
                                    "Rp " +
                                            controller.listManajementPromoDataSearch[
                                                    index]["detail"][i]
                                                ["promo_price"] ??
                                        "",
                                    Color(ListColor.colorRed),
                                    18,
                                    FontWeight.w600),
                                labelText(" /Unit", Colors.black, 18,
                                    FontWeight.w600),
                              ],
                            ),
                            sizeBoxHeight(12),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/ic_duit_blue.png",
                                  height: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      15.75,
                                  width: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      21,
                                ),
                                sizeBoxWidth(4),
                                Expanded(
                                    child: labelText(
                                        controller.listManajementPromoDataSearch[
                                                index]["key"]["payment"] ??
                                            "",
                                        Colors.black,
                                        12,
                                        FontWeight.w600)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          4,
                                      horizontal: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          7),
                                  decoration: BoxDecoration(
                                    color: Color(ListColor.colorLightGrey12),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/ic_view_hitam.svg",
                                        height: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            15,
                                        width: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            15,
                                      ),
                                      sizeBoxWidth(4),
                                      labelText(
                                          controller
                                              .listManajementPromoDataSearch[
                                                  index]["detail"][i]
                                                  ["counter_seen"]
                                              .toString(),
                                          Colors.black,
                                          12,
                                          FontWeight.w600),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            _listseparator(),
                          ],
                        )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          labelText(
                              controller.listManajementPromoDataSearch[index]
                                      ["detail"][0]["head_name"] +
                                  " - " +
                                  controller
                                          .listManajementPromoDataSearch[index]
                                      ["detail"][0]["carrier_name"] +
                                  " (${controller.listManajementPromoDataSearch[index]["detail"][0]["min_capacity"].toString()} ~ ${controller.listManajementPromoDataSearch[index]["detail"][0]["max_capacity"].toString()} ${controller.listManajementPromoDataSearch[index]["detail"][0]["capacity_unit"]})",
                              Colors.black,
                              14,
                              FontWeight.w700,
                              linespacing:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14)),
                          sizeBoxHeight(8),
                          if (controller.listManajementPromoDataSearch[index]
                                  ["detail"][0]["normal_price"] !=
                              "0")
                            CustomText(
                              "Rp " +
                                      controller.listManajementPromoDataSearch[
                                          index]["detail"][0]["normal_price"] ??
                                  "",
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              color: Color(ListColor.colorGrey3),
                              decoration: TextDecoration.lineThrough,
                            ),
                          if (controller.listManajementPromoDataSearch[index]
                                  ["detail"][0]["normal_price"] !=
                              "0")
                            sizeBoxHeight(4),
                          Row(
                            children: [
                              labelText(
                                  "Rp " +
                                          controller.listManajementPromoDataSearch[
                                                  index]["detail"][0]
                                              ["promo_price"] ??
                                      "",
                                  Color(ListColor.colorRed),
                                  18,
                                  FontWeight.w600),
                              labelText(
                                  " /Unit", Colors.black, 18, FontWeight.w600),
                            ],
                          ),
                          sizeBoxHeight(12),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/ic_duit_blue.svg",
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        15.75,
                                width:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        21,
                              ),
                              sizeBoxWidth(4),
                              Expanded(
                                  child: labelText(
                                      controller.listManajementPromoDataSearch[
                                              index]["key"]["payment"] ??
                                          "",
                                      Colors.black,
                                      12,
                                      FontWeight.w600)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        4,
                                    horizontal: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        7),
                                decoration: BoxDecoration(
                                  color: Color(ListColor.colorLightGrey12),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/ic_view_hitam.svg",
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          15,
                                      width: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          15,
                                    ),
                                    sizeBoxWidth(4),
                                    labelText(
                                        controller
                                            .listManajementPromoDataSearch[
                                                index]["detail"][0]
                                                ["counter_seen"]
                                            .toString(),
                                        Colors.black,
                                        12,
                                        FontWeight.w600),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    if (!controller.lihatLebihBanyakSearch[index])
                      sizeBoxHeight(9),
                    Row(
                      children: [
                        Expanded(
                            child: labelText(
                                controller.listManajementPromoDataSearch[index]
                                        ["key"]["start_date"] +
                                    " - " +
                                    controller.listManajementPromoDataSearch[
                                        index]["key"]["end_date"],
                                Colors.black,
                                12,
                                FontWeight.w600)),
                        GestureDetector(
                          onTap: () {
                            if (controller.lihatLebihBanyakSearch[index]) {
                              controller.lihatLebihBanyakSearch[index] = false;
                            } else {
                              controller.lihatLebihBanyakSearch[index] = true;
                            }
                          },
                          child: CustomText(
                            controller.lihatLebihBanyakSearch[index]
                                ? "Lihat Lebih Sedikit"
                                : "Lihat Lebih Banyak",
                            fontWeight: FontWeight.w500,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 12,
                            color: Color(ListColor.colorBlue),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              //garis
              width: MediaQuery.of(Get.context).size.width,
              height: 0.5,
              color: Color(ListColor.colorLightGrey10),
            ),
            Obx(
              () => Container(
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlutterSwitch(
                      width: GlobalVariable.ratioFontSize(Get.context) * 40,
                      height: GlobalVariable.ratioFontSize(Get.context) * 24,
                      padding: GlobalVariable.ratioFontSize(Get.context) * 2,
                      toggleSize:
                          GlobalVariable.ratioFontSize(Get.context) * 20,
                      activeColor: Color(ListColor.colorBlue),
                      inactiveColor: Color(ListColor.colorLightGrey2),
                      value: controller.statusSearch[index],
                      onToggle: (value) {
                        var strVAL = "";
                        if (value) {
                          strVAL = "1";
                          GlobalAlertDialog.showAlertDialogCustom(
                              context: Get.context,
                              title: "Konfirmasi Aktif".tr,
                              message:
                                  "Apakah Anda yakin ingin mengaktifkan \npromo ini kembali?"
                                      .tr
                                      .replaceAll("\\n", "\n"),
                              isShowCloseButton: true,
                              isDismissible: true,
                              positionColorPrimaryButton:
                                  PositionColorPrimaryButton.PRIORITY1,
                              labelButtonPriority1:
                                  "LelangMuatTabAktifTabAktifLabelTitleConfirmYes"
                                      .tr,
                              labelButtonPriority2:
                                  "LelangMuatTabAktifTabAktifLabelTitleConfirmNo"
                                      .tr,
                              onTapPriority2: () {
                                controller.postStatusCard(
                                    controller
                                        .listManajementPromoDataSearch[index]
                                            ["key"]["ID"]
                                        .toString(),
                                    strVAL,
                                    "data-promo-aktif");
                                controller.statusSearch[index] = value;
                                controller.strSwitchButon[index] = "Aktif";
                              });
                        } else {
                          strVAL = "0";
                          GlobalAlertDialog.showAlertDialogCustom(
                              context: Get.context,
                              title: "Konfirmasi Non Aktif".tr,
                              message:
                                  "Apakah Anda yakin ingin menonaktifkan \npromo ini?"
                                      .tr
                                      .replaceAll("\\n", "\n"),
                              isShowCloseButton: true,
                              isDismissible: true,
                              positionColorPrimaryButton:
                                  PositionColorPrimaryButton.PRIORITY1,
                              labelButtonPriority1:
                                  "LelangMuatTabAktifTabAktifLabelTitleConfirmYes"
                                      .tr,
                              labelButtonPriority2:
                                  "LelangMuatTabAktifTabAktifLabelTitleConfirmNo"
                                      .tr,
                              onTapPriority2: () {
                                controller.postStatusCard(
                                    controller
                                        .listManajementPromoDataSearch[index]
                                            ["key"]["ID"]
                                        .toString(),
                                    strVAL,
                                    "data-promo-aktif");
                                controller.statusSearch[index] = value;
                                controller.strSwitchButon[index] =
                                    "Tidak Aktif";
                              });
                        }
                      },
                    ),
                    sizeBoxWidth(8),
                    labelText("Aktif", Colors.black, 14, FontWeight.w600),
                    Expanded(child: SizedBox.shrink()),
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(ListColor.colorBlue),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: CustomText('Edit',
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget listPerItemHistory(int index) {
    double borderRadius = 10;

    return Container(
        margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
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
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorYellow),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius))),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: GlobalVariable.ratioFontSize(Get.context) * 0,
                    ),
                    child: pointRutePickToDestinasi(),
                  ),
                  ZoWidgetHelper().sizeBoxWidth(4),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CustomText(
                              controller.listManajementPromoDataSearchHistory[
                                      index]["key"]["pickup_location_name"] ??
                                  "",
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14)),
                        ),
                        ZoWidgetHelper().sizeBoxHeight(9.91),
                        Container(
                          child: CustomText(
                              controller.listManajementPromoDataSearchHistory[
                                          index]["key"]
                                      ["destination_location_name"] ??
                                  "",
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14)),
                        )
                      ]),
                ],
              ),
            ),
            Obx(
              () => Container(
                padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey10),
                          border: Border.all(
                              width: 1,
                              color: Color(ListColor.colorLightGrey10)),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      width: MediaQuery.of(Get.context).size.width,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                              controller.listManajementPromoDataSearchHistory[
                                      index]["key"]["Link"] ??
                                  "",
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    ZoWidgetHelper().sizeBoxHeight(14),
                    if (controller.lihatLebihBanyakSearchHistory[index])
                      for (var i = 0;
                          i <
                              controller
                                  .listManajementPromoDataSearchHistory[index]
                                      ["detail"]
                                  .length;
                          i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ZoWidgetHelper().labelText(
                                controller.listManajementPromoDataSearchHistory[
                                        index]["detail"][i]["head_name"] +
                                    " - " +
                                    controller
                                            .listManajementPromoDataSearchHistory[
                                        index]["detail"][i]["carrier_name"] +
                                    " (${controller.listManajementPromoDataSearchHistory[index]["detail"][i]["min_capacity"].toString()} ~ ${controller.listManajementPromoDataSearchHistory[index]["detail"][i]["max_capacity"].toString()} ${controller.listManajementPromoDataSearchHistory[index]["detail"][i]["capacity_unit"]})",
                                Colors.black,
                                14,
                                FontWeight.w700,
                                linespacing:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        (16.8 / 14)),
                            ZoWidgetHelper().sizeBoxHeight(8),
                            if (controller.listManajementPromoDataSearchHistory[
                                    index]["detail"][i]["normal_price"] !=
                                "0")
                              CustomText(
                                "Rp " +
                                        controller.listManajementPromoDataSearchHistory[
                                                index]["detail"][i]
                                            ["normal_price"] ??
                                    "",
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14,
                                color: Color(ListColor.colorGrey3),
                                decoration: TextDecoration.lineThrough,
                              ),
                            if (controller.listManajementPromoDataSearchHistory[
                                    index]["detail"][i]["normal_price"] !=
                                "0")
                              ZoWidgetHelper().sizeBoxHeight(4),
                            Row(
                              children: [
                                ZoWidgetHelper().labelText(
                                    "Rp " +
                                            controller.listManajementPromoDataSearchHistory[
                                                    index]["detail"][i]
                                                ["promo_price"] ??
                                        "",
                                    Color(ListColor.colorRed),
                                    18,
                                    FontWeight.w600),
                                ZoWidgetHelper().labelText(" /Unit",
                                    Colors.black, 18, FontWeight.w600),
                              ],
                            ),
                            ZoWidgetHelper().sizeBoxHeight(12),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/ic_duit_blue.png",
                                  height: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      15.75,
                                  width: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      21,
                                ),
                                ZoWidgetHelper().sizeBoxWidth(4),
                                Expanded(
                                    child: ZoWidgetHelper().labelText(
                                        controller.listManajementPromoDataSearchHistory[
                                                index]["key"]["payment"] ??
                                            "",
                                        Colors.black,
                                        12,
                                        FontWeight.w600)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          4,
                                      horizontal: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          7),
                                  decoration: BoxDecoration(
                                    color: Color(ListColor.colorLightGrey12),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/ic_view_hitam.svg",
                                        height: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            15,
                                        width: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            15,
                                      ),
                                      ZoWidgetHelper().sizeBoxWidth(4),
                                      ZoWidgetHelper().labelText(
                                          controller
                                              .listManajementPromoDataSearchHistory[
                                                  index]["detail"][i]
                                                  ["counter_seen"]
                                              .toString(),
                                          Colors.black,
                                          12,
                                          FontWeight.w600),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            _listseparator(),
                          ],
                        )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ZoWidgetHelper().labelText(
                              controller.listManajementPromoDataSearchHistory[
                                      index]["detail"][0]["head_name"] +
                                  " - " +
                                  controller
                                          .listManajementPromoDataSearchHistory[
                                      index]["detail"][0]["carrier_name"] +
                                  " (${controller.listManajementPromoDataSearchHistory[index]["detail"][0]["min_capacity"].toString()} ~ ${controller.listManajementPromoDataSearchHistory[index]["detail"][0]["max_capacity"].toString()} ${controller.listManajementPromoDataSearchHistory[index]["detail"][0]["capacity_unit"]})",
                              Colors.black,
                              14,
                              FontWeight.w700,
                              linespacing:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14)),
                          ZoWidgetHelper().sizeBoxHeight(8),
                          if (controller.listManajementPromoDataSearchHistory[
                                  index]["detail"][0]["normal_price"] !=
                              "0")
                            CustomText(
                              "Rp " +
                                      controller
                                              .listManajementPromoDataSearchHistory[
                                          index]["detail"][0]["normal_price"] ??
                                  "",
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              color: Color(ListColor.colorGrey3),
                              decoration: TextDecoration.lineThrough,
                            ),
                          if (controller.listManajementPromoDataSearchHistory[
                                  index]["detail"][0]["normal_price"] !=
                              "0")
                            ZoWidgetHelper().sizeBoxHeight(4),
                          Row(
                            children: [
                              ZoWidgetHelper().labelText(
                                  "Rp " +
                                          controller.listManajementPromoDataSearchHistory[
                                                  index]["detail"][0]
                                              ["promo_price"] ??
                                      "",
                                  Color(ListColor.colorRed),
                                  18,
                                  FontWeight.w600),
                              ZoWidgetHelper().labelText(
                                  " /Unit", Colors.black, 18, FontWeight.w600),
                            ],
                          ),
                          ZoWidgetHelper().sizeBoxHeight(12),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/ic_duit_blue.svg",
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        15.75,
                                width:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        21,
                              ),
                              ZoWidgetHelper().sizeBoxWidth(4),
                              Expanded(
                                  child: ZoWidgetHelper().labelText(
                                      controller.listManajementPromoDataSearchHistory[
                                              index]["key"]["payment"] ??
                                          "",
                                      Colors.black,
                                      12,
                                      FontWeight.w600)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        4,
                                    horizontal: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        7),
                                decoration: BoxDecoration(
                                  color: Color(ListColor.colorLightGrey12),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/ic_view_hitam.svg",
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          15,
                                      width: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          15,
                                    ),
                                    ZoWidgetHelper().sizeBoxWidth(4),
                                    ZoWidgetHelper().labelText(
                                        controller
                                            .listManajementPromoDataSearchHistory[
                                                index]["detail"][0]
                                                ["counter_seen"]
                                            .toString(),
                                        Colors.black,
                                        12,
                                        FontWeight.w600),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    if (!controller.lihatLebihBanyakSearchHistory[index])
                      ZoWidgetHelper().sizeBoxHeight(9),
                    Row(
                      children: [
                        Expanded(
                            child: ZoWidgetHelper().labelText(
                                controller.listManajementPromoDataSearchHistory[
                                        index]["key"]["start_date"] +
                                    " - " +
                                    controller
                                            .listManajementPromoDataSearchHistory[
                                        index]["key"]["end_date"],
                                Colors.black,
                                12,
                                FontWeight.w600)),
                        if (controller
                                .listManajementPromoDataSearchHistory[index]
                                    ["detail"]
                                .length >
                            1)
                          GestureDetector(
                            onTap: () {
                              if (controller
                                  .lihatLebihBanyakSearchHistory[index]) {
                                controller
                                        .lihatLebihBanyakSearchHistory[index] =
                                    false;
                              } else {
                                controller
                                        .lihatLebihBanyakSearchHistory[index] =
                                    true;
                              }
                            },
                            child: CustomText(
                              controller.lihatLebihBanyakSearchHistory[index]
                                  ? "Lihat Lebih Sedikit"
                                  : "Lihat Lebih Banyak",
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      12,
                              color: Color(ListColor.colorBlue),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              //garis
              width: MediaQuery.of(Get.context).size.width,
              height: 0.5,
              color: Color(ListColor.colorLightGrey10),
            ),
            Obx(
              () => Container(
                padding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlutterSwitch(
                      width: GlobalVariable.ratioFontSize(Get.context) * 40,
                      height: GlobalVariable.ratioFontSize(Get.context) * 24,
                      padding: GlobalVariable.ratioFontSize(Get.context) * 2,
                      toggleSize:
                          GlobalVariable.ratioFontSize(Get.context) * 20,
                      activeColor: Color(ListColor.colorBlue),
                      inactiveColor: Color(ListColor.colorLightGrey2),
                      value: controller.statusSearchHistory[index],
                      onToggle: (value) {
                        var strVAL = "";
                        if (value) {
                          strVAL = "1";
                          GlobalAlertDialog.showAlertDialogCustom(
                              context: Get.context,
                              title: "Konfirmasi Aktif".tr,
                              message:
                                  "Apakah Anda yakin ingin mengaktifkan \npromo ini kembali?"
                                      .tr
                                      .replaceAll("\\n", "\n"),
                              isShowCloseButton: true,
                              isDismissible: true,
                              positionColorPrimaryButton:
                                  PositionColorPrimaryButton.PRIORITY1,
                              labelButtonPriority1:
                                  "LelangMuatTabAktifTabAktifLabelTitleConfirmYes"
                                      .tr,
                              labelButtonPriority2:
                                  "LelangMuatTabAktifTabAktifLabelTitleConfirmNo"
                                      .tr,
                              onTapPriority2: () {
                                controller.postStatusCard(
                                    controller
                                        .listManajementPromoDataSearchHistory[
                                            index]["key"]["ID"]
                                        .toString(),
                                    strVAL,
                                    "data-promo-history");
                                controller.statusSearchHistory[index] = value;
                                controller.strSwitchButonHistory[index] =
                                    "Aktif";
                              });
                        } else {
                          strVAL = "0";
                          GlobalAlertDialog.showAlertDialogCustom(
                              context: Get.context,
                              title: "Konfirmasi Non Aktif".tr,
                              message:
                                  "Apakah Anda yakin ingin menonaktifkan \npromo ini?"
                                      .tr
                                      .replaceAll("\\n", "\n"),
                              isShowCloseButton: true,
                              isDismissible: true,
                              positionColorPrimaryButton:
                                  PositionColorPrimaryButton.PRIORITY1,
                              labelButtonPriority1:
                                  "LelangMuatTabAktifTabAktifLabelTitleConfirmYes"
                                      .tr,
                              labelButtonPriority2:
                                  "LelangMuatTabAktifTabAktifLabelTitleConfirmNo"
                                      .tr,
                              onTapPriority2: () {
                                controller.postStatusCard(
                                    controller
                                        .listManajementPromoDataSearchHistory[
                                            index]["key"]["ID"]
                                        .toString(),
                                    strVAL,
                                    "data-promo-history");
                                controller.statusSearchHistory[index] = value;
                                controller.strSwitchButonHistory[index] =
                                    "Tidak Aktif";
                              });
                        }
                      },
                    ),
                    ZoWidgetHelper().sizeBoxWidth(8),
                    ZoWidgetHelper().labelText(
                        controller.strSwitchButonHistory[index],
                        Colors.black,
                        14,
                        FontWeight.w600),
                    Expanded(child: SizedBox.shrink()),
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(ListColor.colorBlue),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: CustomText('Edit',
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  pointRutePickToDestinasi() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/titik_awal_hitam.svg",
          height: GlobalVariable.ratioFontSize(Get.context) * 16,
          width: GlobalVariable.ratioFontSize(Get.context) * 16,
        ),
        SvgPicture.asset(
          "assets/garis_sambung_hitam.svg",
          height: GlobalVariable.ratioFontSize(Get.context) * 14,
          width: GlobalVariable.ratioFontSize(Get.context) * 16,
        ),
        SvgPicture.asset(
          "assets/titik_akhir_hitam.svg",
          height: GlobalVariable.ratioFontSize(Get.context) * 16,
          width: GlobalVariable.ratioFontSize(Get.context) * 16,
        )
      ],
    );
  }

  _listseparator() {
    return Container(
        height: 0.5,
        color: Color(ListColor.colorGrey3),
        margin: EdgeInsets.only(
            top: GlobalVariable.ratioWidth(Get.context) * 9,
            bottom: GlobalVariable.ratioWidth(Get.context) * 14));
  }

  Widget sizeBoxHeight(double height) {
    return SizedBox(height: GlobalVariable.ratioFontSize(Get.context) * height);
  }

  Widget sizeBoxWidth(double width) {
    return SizedBox(width: GlobalVariable.ratioFontSize(Get.context) * width);
  }

  Widget labelText(
      String title, Color color, double sizeFont, FontWeight fontweight,
      {double linespacing = 1}) {
    return CustomText(
      title,
      fontWeight: fontweight,
      fontSize: GlobalVariable.ratioFontSize(Get.context) * sizeFont,
      color: color,
      height: linespacing,
    );
  }
}
