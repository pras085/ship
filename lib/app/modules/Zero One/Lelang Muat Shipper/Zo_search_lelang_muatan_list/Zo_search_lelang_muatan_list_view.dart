import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/Zo_search_lelang_muatan_list/Zo_search_lelang_muatan_list_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoSearchLelangMuatanView extends GetView<ZoSearchLelangMuatanController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(context) * 53),
            child: Container(
              // height: GlobalVariable.ratioWidth(context) * 56.6,
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
                                  color: Color(ListColor.color4),
                                  child: InkWell(
                                      onTap: () {
                                        // controller.onClearSearch();
                                        Get.back();
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
                                  key: ValueKey("CariLelangMuatan"),
                                  context: Get.context,
                                  autofocus: true,
                                  // onTap: () {
                                  //   controller.onTapTextField.value = true;
                                  // },
                                  onChanged: (value) {
                                    controller.addTextSearch(value);
                                    // if (value != "") {
                                    //   controller.addTextSearch(value);
                                    //   controller.onTapTextField.value = true;
                                    //   if (controller.type.value == "aktif") {
                                    //     controller.istidakadadata.value = false;
                                    //   }
                                    //   if (controller.type.value == "history") {
                                    //     controller.istidakadadatahistory.value =
                                    //         false;
                                    //   }
                                    // } else {
                                    //   controller.onClearSearch();
                                    //   controller.onTapTextField.value = false;
                                    //   if (controller.type.value == "aktif") {
                                    //     controller.istidakadadata.value = false;
                                    //   }
                                    //   if (controller.type.value == "history") {
                                    //     controller.istidakadadatahistory.value =
                                    //         false;
                                    //   }
                                    // }
                                  },
                                  controller: controller.cari.value,
                                  textInputAction: TextInputAction.search,
                                  // onSubmitted: (value) {
                                  //   controller.onSubmitSearch();
                                  // },
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  newContentPadding: EdgeInsets.symmetric(
                                      horizontal: 42,
                                      vertical:
                                          GlobalVariable.ratioWidth(context) *
                                              6),
                                  textSize:
                                      GlobalVariable.ratioFontSize(context) *
                                          14,
                                  newInputDecoration: InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText:
                                        "LelangMuatTabAktifTabAktifLabelTitleSearchCargoBid"
                                            .tr, // "Cari Area Pick Up",
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Color(ListColor.colorLightGrey2),
                                        fontWeight: FontWeight.w600),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color(ListColor.colorLightGrey7),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
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
                                  ),
                                ),
                                if (controller.onTapTextField.value)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.onClearSearch();
                                        controller.onTapTextField.value = false;
                                        if (controller.type.value == "aktif") {
                                          controller.istidakadadata.value =
                                              false;
                                        }
                                        if (controller.type.value == "aktif") {
                                          controller.istidakadadatahistory
                                              .value = false;
                                        }
                                        controller.addTextSearch("");
                                        controller.onSubmitSearch();
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: Color(ListColor.colorGrey3),
                                            size: GlobalVariable.ratioFontSize(
                                                    Get.context) *
                                                28,
                                          )),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(context) * 4,
                          ),
                          Obx(() => GestureDetector(
                              onTap: () {
                                if (controller.type.value == "aktif") {
                                  if (controller
                                          .listDataLelangMuatan.value.length >
                                      0) {
                                    controller.showSort();
                                  }
                                } else {
                                  if (controller.listDataLelangMuatanHistory
                                          .value.length >
                                      0) {
                                    controller.showSortHistory();
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
                                  child: controller.type.value == "aktif"
                                      ? controller.issort.value
                                          ? SvgPicture.asset(
                                              "assets/ic_sort_aktif_black.svg",
                                              width:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      22,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      22,
                                            )
                                          : SvgPicture.asset(
                                              "assets/sorting_icon.svg",
                                              width:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      22,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      22,
                                              color: controller
                                                          .listDataLelangMuatan
                                                          .length >
                                                      0
                                                  ? Colors.black
                                                  : Color(
                                                      ListColor.colorStroke),
                                            )
                                      : controller.issortHistory.value
                                          ? SvgPicture.asset(
                                              "assets/ic_sort_aktif_black.svg",
                                              width:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      22,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      22,
                                            )
                                          : SvgPicture.asset(
                                              "assets/sorting_icon.svg",
                                              width:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      22,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      22,
                                              color: controller
                                                          .listDataLelangMuatanHistory
                                                          .length >
                                                      0
                                                  ? Colors.black
                                                  : Color(
                                                      ListColor.colorStroke),
                                            ))))
                        ],
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
          ),
          body: Obx(() => controller.type.value == "aktif"
              ? (controller.listDataLelangMuatan.value.length > 0 &&
                      !controller.istidakadadata.value)
                  ? _adaDataPencarian()
                  : Obx(() =>
                      (controller.listDataLelangMuatan.value.length == 0 &&
                              controller.istidakadadata.value)
                          ? controller.isLoadingTabAktif.isTrue
                              ? Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : _tidakAdaDataPencarian()
                          : controller.isLoadingTabAktif.isTrue
                              ? Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : _awalKetik())
              : (controller.listDataLelangMuatanHistory.value.length > 0 &&
                      !controller.istidakadadatahistory.value)
                  ? _adaDataPencarianHistory()
                  : Obx(() =>
                      (controller.listDataLelangMuatanHistory.value.length ==
                                  0 &&
                              controller.istidakadadatahistory.value)
                          ? controller.isLoadingTabHistory.isTrue
                              ? Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : _tidakAdaDataPencarian()
                          : controller.isLoadingTabHistory.isTrue
                              ? Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : _awalKetik()))),
    );
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
                data: '<span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 500; color: #7C9CBF;">' +
                    'LelangMuatBuatLelangBuatLelangLabelTitleTidakDitemukanHasil'
                        .tr +
                    '</span> <span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000;">"${controller.cari.value.text}"</span>')),
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

  _awalKetik() {
    return Padding(
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
                      "LelangMuatBuatLelangBuatLelangLabelTitleTerakhirCari".tr,
                      fontWeight: FontWeight.w600,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                      child: GestureDetector(
                    onTap: () {
                      if (controller.type.value == "aktif") {
                        controller.deleteAllLastSearch();
                      }
                      if (controller.type.value == "history") {
                        controller.deleteAllLastSearchHistory();
                      }
                    },
                    child: CustomText(
                      "LelangMuatBuatLelangBuatLelangLabelTitleHapusSemua".tr,
                      fontWeight: FontWeight.w600,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      color: Color(ListColor.colorRed2),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 18,
            ),
            if (controller.listChoosenReturn.value.length > 0)
              for (var i = 0;
                  i < controller.listChoosenReturn.value.length;
                  i++)
                _riwayatSeacrh(i)
          ],
        ));
  }

  _riwayatSeacrh(int idx) {
    return Column(
      children: [
        Container(
          child: GestureDetector(
            onTap: () {
              controller.onTapTextField.value = true;
              controller.cari.value.text =
                  controller.listChoosenReturn.value[idx].toString();
              controller.addTextSearch(controller.cari.value.text);
              controller.onSubmitSearch();
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
                      if (controller.type.value == "aktif") {
                        controller.deletLastSearch(idx);
                      }
                      if (controller.type.value == "history") {
                        controller.deletLastSearchHistory(idx);
                      }
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
    );
  }

  _adaDataPencarian() {
    return Obx(
      () => SmartRefresher(
          enablePullUp: true,
          enablePullDown: true,
          controller: controller.refreshLelangMuatanTabAktifController,
          onLoading: () {
            controller.loadDataSearch();
          },
          onRefresh: () {
            controller.refreshDataSmartSearch();
          },
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                      top: GlobalVariable.ratioWidth(Get.context) * 20),
                  child: Html(
                      style: {
                        "body": Style(
                            margin: EdgeInsets.zero, padding: EdgeInsets.zero)
                      },
                      data: '<span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 500; color: #7C9CBF;">' +
                          'LelangMuatBuatLelangBuatLelangLabelTitleMenampilkan'
                              .tr +
                          ' ${controller.listDataLelangMuatan.value.length} ' +
                          'LelangMuatBuatLelangBuatLelangLabelTitleHasilUntuk'
                              .tr +
                          '</span> <span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000;">"${controller.cari.value.text}"</span>')),
              for (var i = 0;
                  i < controller.listDataLelangMuatan.value.length;
                  i++)
                listPerItem(i)
            ],
          )),
    );
  }

  _adaDataPencarianHistory() {
    return Obx(() => SmartRefresher(
          enablePullUp: true,
          enablePullDown: true,
          controller: controller.refreshLelangMuatanTabHistoryController,
          onLoading: () {
            controller.loadDataHistorySearch();
          },
          onRefresh: () {
            controller.refreshDataSmartHistorySearch();
          },
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                      top: GlobalVariable.ratioWidth(Get.context) * 20),
                  child: Html(
                      style: {
                        "body": Style(
                            margin: EdgeInsets.zero, padding: EdgeInsets.zero)
                      },
                      data: '<span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 500; color: #7C9CBF;">' +
                          'LelangMuatBuatLelangBuatLelangLabelTitleMenampilkan'
                              .tr +
                          ' ${controller.listDataLelangMuatanHistory.value.length} ' +
                          'LelangMuatBuatLelangBuatLelangLabelTitleHasilUntuk'
                              .tr +
                          '</span> <span style="font-size: ${GlobalVariable.ratioWidth(Get.context) * 12}; font-weight: 600; color: #000000;">"${controller.cari.value.text}"</span>')),
              for (var i = 0;
                  i < controller.listDataLelangMuatanHistory.value.length;
                  i++)
                listPerItemHistory(i)
            ],
          ),
        ));
  }

  Widget listPerItem(int index) {
    double borderRadius = 10;
    return Obx(() => Container(
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
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8.5,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorLightBlue9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius))),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      child: CustomText(
                          controller.listDataLelangMuatan.value[index]['BidNo'],
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 12,
                          fontWeight: FontWeight.w600),
                    )),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _opsi(index);
                          },
                          child: Container(
                              child: Icon(
                            Icons.more_vert,
                            size:
                                GlobalVariable.ratioFontSize(Get.context) * 27,
                          )),
                        ))
                  ],
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 14),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    height: GlobalVariable.ratioFontSize(Get.context) * 104,
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Container(
                          // height: 300,
                          width: MediaQuery.of(Get.context).size.width,
                          // color: Colors.green,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          0),
                                  child: Container(
                                    child: SvgPicture.asset(
                                      "assets/titik_biru_pickup.svg",
                                      width: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          16,
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          16,
                                    ),
                                  )),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 10,
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: CustomText(
                                      controller.listDataLelangMuatan
                                                  .value[index]['CityPickup'] ==
                                              null
                                          ? ""
                                          : controller.listDataLelangMuatan
                                              .value[index]['CityPickup'],
                                      fontWeight: FontWeight.w500,
                                      // maxLines: 1,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          14,
                                      // height: GlobalVariable.ratioFontSize(
                                      //         Get.context) *
                                      //     (17 / 14),
                                    ),
                                  ),
                                  Container(
                                    child: CustomText(
                                      controller.listDataLelangMuatan
                                          .value[index]['PickupEta'],
                                      fontWeight: FontWeight.w400,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          12,
                                      color: Color(ListColor.colorLightGrey4),
                                    ),
                                  ),
                                  if (controller.lengthPickup[index] > 1)
                                    GestureDetector(
                                        onTap: () {
                                          controller.toDetailLelangMuatCari(
                                              controller.listDataLelangMuatan
                                                  .value[index]['ID']
                                                  .toString(),
                                              3);
                                        },
                                        child: Container(
                                          child: CustomText(
                                            "LelangMuatTabHistoryTabHistoryLabelTitleLihatSelengkapnya"
                                                .tr,
                                            fontWeight: FontWeight.w600,
                                            // maxLines: 1,
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    10,
                                            // height:
                                            //     GlobalVariable.ratioFontSize(
                                            //             Get.context) *
                                            //         (12 / 14),
                                            color: Color(ListColor.colorBlue),
                                          ),
                                        )),
                                ],
                              )),
                            ],
                          ),
                        ),
                        Positioned(
                            top: GlobalVariable.ratioFontSize(Get.context) * 18,
                            child: Container(
                              // height: 200,
                              width: MediaQuery.of(Get.context).size.width,
                              // color: Colors.blue,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        16,
                                    child: SvgPicture.asset(
                                      "assets/garis_alur_perjalanan.svg",
                                      // width: GlobalVariable.ratioWidth(Get.context) * 12,
                                      // height: GlobalVariable.ratioWidth(Get.context) * 30.5,
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          38,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10,
                                  ),
                                  Expanded(child: CustomText("")),
                                ],
                              ),
                            )),
                        Positioned(
                            top: GlobalVariable.ratioFontSize(Get.context) * 53,
                            child: Container(
                              // height: 200,
                              width: MediaQuery.of(Get.context).size.width,
                              // color: Colors.red,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            0),
                                    child: Container(
                                      child: SvgPicture.asset(
                                        "assets/titik_biru_kuning_destinasi.svg",
                                        width: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            16,
                                        height: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: CustomText(
                                          controller.listDataLelangMuatan
                                                          .value[index]
                                                      ['CityDestination'] ==
                                                  null
                                              ? ""
                                              : controller.listDataLelangMuatan
                                                      .value[index]
                                                  ['CityDestination'],
                                          fontWeight: FontWeight.w500,
                                          // maxLines: 1,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  14,
                                          // height: GlobalVariable.ratioFontSize(
                                          //         Get.context) *
                                          //     (17 / 14),
                                        ),
                                      ),
                                      Container(
                                        child: CustomText(
                                          controller.listDataLelangMuatan
                                              .value[index]['DestinationEta'],
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  12,
                                          color:
                                              Color(ListColor.colorLightGrey4),
                                        ),
                                      ),
                                      if (controller.lengthDestinasi[index] > 1)
                                        GestureDetector(
                                            onTap: () {
                                              controller.toDetailLelangMuatCari(
                                                  controller
                                                      .listDataLelangMuatan
                                                      .value[index]['ID']
                                                      .toString(),
                                                  4);
                                            },
                                            child: Container(
                                              child: CustomText(
                                                "LelangMuatTabHistoryTabHistoryLabelTitleLihatSelengkapnya"
                                                    .tr,
                                                fontWeight: FontWeight.w600,
                                                // maxLines: 1,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    10,
                                                // height: GlobalVariable
                                                //         .ratioFontSize(
                                                //             Get.context) *
                                                //     (12 / 14),
                                                color:
                                                    Color(ListColor.colorBlue),
                                              ),
                                            )),
                                    ],
                                  )),
                                ],
                              ),
                            )),
                        // Positioned(
                        //     top: 100,
                        //     child: Container(
                        //       // height: 200,
                        //       width: MediaQuery.of(Get.context).size.width,
                        //       // color: Colors.blue,
                        //       child: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           Padding(
                        //             padding: EdgeInsets.only(top: 4),
                        //             child: Container(
                        //               child: SvgPicture.asset(
                        //                 "assets/truck_plus_blue.svg",
                        //                 width: GlobalVariable.ratioWidth(
                        //                         Get.context) *
                        //                     16,
                        //                 height: GlobalVariable.ratioWidth(
                        //                         Get.context) *
                        //                     16,
                        //               ),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width:
                        //                 GlobalVariable.ratioWidth(Get.context) *
                        //                     10,
                        //           ),
                        //           Expanded(
                        //             child: Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.start,
                        //               children: [
                        //                 Container(
                        //                   child: CustomText(
                        //                       "${controller.listDataLelangMuatan.value[index]['HeadName']} - ${controller.listDataLelangMuatan.value[index]['CarrierName']}",
                        //                       fontWeight: FontWeight.w500,
                        //                       // maxLines: 1,
                        //                       fontSize:
                        //                           GlobalVariable.ratioFontSize(
                        //                                   Get.context) *
                        //                               14,
                        //                       height:
                        //                           GlobalVariable.ratioFontSize(
                        //                                   Get.context) *
                        //                               (17 / 14)),
                        //                 ),
                        //                 Container(
                        //                     child: Html(
                        //                         style: {
                        //                       "body": Style(
                        //                           margin: EdgeInsets.zero,
                        //                           padding: EdgeInsets.zero)
                        //                     },
                        //                         data: '<span style="font-weight: 400; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #676767;">' +
                        //                             'LelangMuatBuatLelangBuatLelangLabelTitleJumlah'
                        //                                 .tr +
                        //                             ' <span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #000000;">${controller.listDataLelangMuatan.value[index]['TruckQty']}</span> Unit, ' +
                        //                             'LelangMuatBuatLelangBuatLelangLabelTitleKurang'
                        //                                 .tr +
                        //                             ' <span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #000000;">${controller.listDataLelangMuatan.value[index]['RemainingNeeds']}</span> Unit</span>')),
                        //               ],
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     )),
                        // Positioned(
                        //     top: 150,
                        //     child: Container(
                        //         // height: 200,
                        //         width: MediaQuery.of(Get.context).size.width,
                        //         // color: Colors.blue,
                        //         child: Row(
                        //           // crossAxisAlignment: CrossAxisAlignment.start,
                        //           // mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             Padding(
                        //               padding: EdgeInsets.only(top: 4),
                        //               child: Container(
                        //                 child: SvgPicture.asset(
                        //                   "assets/ic_timer_pasir.svg",
                        //                   width: GlobalVariable.ratioWidth(
                        //                           Get.context) *
                        //                       16,
                        //                   height: GlobalVariable.ratioWidth(
                        //                           Get.context) *
                        //                       16,
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(
                        //               width: GlobalVariable.ratioWidth(
                        //                       Get.context) *
                        //                   10,
                        //             ),
                        //             Expanded(
                        //               child: Container(
                        //                 child: CustomText(
                        //                     "${controller.listDataLelangMuatan.value[index]['StartDate']} - ${controller.listDataLelangMuatan.value[index]['EndDate']}",
                        //                     fontWeight: FontWeight.w500,
                        //                     // maxLines: 1,
                        //                     fontSize:
                        //                         GlobalVariable.ratioFontSize(
                        //                                 Get.context) *
                        //                             14,
                        //                     height:
                        //                         GlobalVariable.ratioFontSize(
                        //                                 Get.context) *
                        //                             (17 / 14)),
                        //               ),
                        //             ),
                        //           ],
                        //         ))),
                      ],
                    ),
                  ),

                  // pemisah
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //           top: GlobalVariable.ratioWidth(Get.context) * 3.5),
                  //       child: _titikSimbolDestinasi(),
                  //     ),
                  //     SizedBox(
                  //       width: GlobalVariable.ratioWidth(Get.context) * 10,
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             child: CustomText(
                  //               controller.listDataLelangMuatan.value[index]
                  //                           ['CityPickup'] ==
                  //                       null
                  //                   ? ""
                  //                   : controller.listDataLelangMuatan
                  //                       .value[index]['CityPickup'],
                  //               fontWeight: FontWeight.w500,
                  //               // maxLines: 1,
                  //               fontSize:
                  //                   GlobalVariable.ratioFontSize(Get.context) *
                  //                       14,
                  //               height:
                  //                   GlobalVariable.ratioFontSize(Get.context) *
                  //                       (17 / 14),
                  //             ),
                  //           ),
                  //           Container(
                  //             child: CustomText(
                  //               controller.listDataLelangMuatan.value[index]
                  //                   ['PickupEta'],
                  //               fontWeight: FontWeight.w400,
                  //               fontSize:
                  //                   GlobalVariable.ratioFontSize(Get.context) *
                  //                       12,
                  //               color: Color(ListColor.colorLightGrey4),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height:
                  //                 GlobalVariable.ratioWidth(Get.context) * 10,
                  //           ),
                  //           Container(
                  //             child: CustomText(
                  //                 controller.listDataLelangMuatan.value[index]
                  //                             ['CityDestination'] ==
                  //                         null
                  //                     ? ""
                  //                     : controller.listDataLelangMuatan
                  //                         .value[index]['CityDestination'],
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: GlobalVariable.ratioFontSize(
                  //                         Get.context) *
                  //                     14,
                  //                 height: GlobalVariable.ratioFontSize(
                  //                         Get.context) *
                  //                     (17 / 14)),
                  //           ),
                  //           Container(
                  //             child: CustomText(
                  //               controller.listDataLelangMuatan.value[index]
                  //                   ['DestinationEta'],
                  //               fontWeight: FontWeight.w400,
                  //               fontSize:
                  //                   GlobalVariable.ratioFontSize(Get.context) *
                  //                       12,
                  //               color: Color(ListColor.colorLightGrey4),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: GlobalVariable.ratioWidth(Get.context) * 10,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Container(
                            child: SvgPicture.asset(
                              "assets/truck_plus_blue.svg",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  18,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      18,
                            ),
                          )),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: CustomText(
                                  "${controller.listDataLelangMuatan.value[index]['HeadName']} - ${controller.listDataLelangMuatan.value[index]['CarrierName']}",
                                  fontWeight: FontWeight.w500,
                                  // maxLines: 1,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14,
                                  height: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      (17 / 14)),
                            ),
                            Container(
                                child: Html(
                                    style: {
                                  "body": Style(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero)
                                },
                                    data: '<span style="font-weight: 400; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #676767;">' +
                                        'LelangMuatBuatLelangBuatLelangLabelTitleJumlah'
                                            .tr +
                                        ' <span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #000000;">${controller.listDataLelangMuatan.value[index]['TruckQty']}</span> Unit, ' +
                                        'LelangMuatBuatLelangBuatLelangLabelTitleKurang'
                                            .tr +
                                        ' <span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #000000;">${controller.listDataLelangMuatan.value[index]['RemainingNeeds']}</span> Unit</span>')),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioFontSize(Get.context) * 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Container(
                            child: SvgPicture.asset(
                              "assets/ic_timer_pasir.svg",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  18,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      18,
                            ),
                          )),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                        child: Container(
                          child: CustomText(
                              "${controller.listDataLelangMuatan.value[index]['StartDate']} - ${controller.listDataLelangMuatan.value[index]['EndDate']}",
                              fontWeight: FontWeight.w500,
                              // maxLines: 1,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (17 / 14)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              //garis
              width: MediaQuery.of(Get.context).size.width,
              height: 0.5,
              color: Color(ListColor.colorLightGrey10),
            ),
            Container(
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
                  Container(
                    child: CustomText(
                      controller.listDataLelangMuatan.value[index]['Created'],
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue),
                    ),
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioFontSize(Get.context) * 8,
                        GlobalVariable.ratioFontSize(Get.context) * 6,
                        GlobalVariable.ratioFontSize(Get.context) * 8,
                        GlobalVariable.ratioFontSize(Get.context) * 6),
                    decoration: BoxDecoration(
                        color: Color(ListColor.colorLightBlue3),
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: Row(
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            "assets/ic_view_blue.svg",
                            width:
                                GlobalVariable.ratioFontSize(Get.context) * 18,
                            height:
                                GlobalVariable.ratioFontSize(Get.context) * 18,
                            color: Color(ListColor.colorBlue),
                          ),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 6.32,
                        ),
                        CustomText(
                          controller
                              .listDataLelangMuatan.value[index]['Viewers']
                              .toString(),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 12,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorBlue),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox.shrink()),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onTap: () {
                          controller.toDetailLelangMuatCari(
                              controller.listDataLelangMuatan.value[index]['ID']
                                  .toString(),
                              0);
                          // controller.toDetailLelangMuatan(controller
                          //     .listDataLelangMuatan.value[index]['ID']
                          //     .toString());
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: CustomText(
                                  'LoadRequestInfoButtonLabelDetail'.tr,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ))),
                  ),
                ],
              ),
            )
          ],
        )));
  }

  Widget listPerItemHistory(int index) {
    double borderRadius = 10;
    String created = "";
    String createdBotom = "";
    if (controller.listDataLelangMuatanHistory.value[index]['Created'] !=
        null) {
      var expCreated = controller
          .listDataLelangMuatanHistory.value[index]['Created']
          .toString()
          .split(" ");
      created = "${expCreated[0]} ${expCreated[1]} ${expCreated[2]}";
      createdBotom = "${expCreated[3]} ${expCreated[4]}";
    }
    String status = "";
    Color colorFont;
    Color colorBG;
    // if (controller.listDataLelangMuatanHistory.value[index]['Status'] == 1) {
    //   status = "LelangMuatTabHistoryTabHistoryLabelTitleSelesai".tr;
    //   colorFont = Color(ListColor.colorGreen6);
    //   colorBG = Color(ListColor.colorLightGreen2);
    // }
    if (controller.listDataLelangMuatanHistory.value[index]['Status'] == 3) {
      status = "LelangMuatTabHistoryTabHistoryLabelTitleBatal".tr;
      colorFont = Color(ListColor.colorRed);
      colorBG = Color(ListColor.colorLightRed3);
    }

    var expDate = controller.listDataLelangMuatanHistory.value[index]['EndDate']
        .toString()
        .split(" ");

    var bln = MonthIndoToInt().monthToIndo(expDate[1]);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final endperiode =
        DateTime(int.parse(expDate[2]), int.parse(bln), int.parse(expDate[0]))
            .millisecondsSinceEpoch;

    if (controller.listDataLelangMuatanHistory.value[index]['Status'] == 4 &&
        today > endperiode) {
      status = "LelangMuatTabHistoryTabHistoryLabelTitleSelesai".tr;
      colorFont = Color(ListColor.colorGreen6);
      colorBG = Color(ListColor.colorLightGreen2);
    }

    if (controller.listDataLelangMuatanHistory.value[index]['Status'] == 4 &&
        today < endperiode) {
      status = "LelangMuatTabHistoryTabHistoryLabelTitleDitutup".tr;
      colorFont = Color(ListColor.colorGrey3);
      colorBG = Color(ListColor.colorLightGrey12);
    }

    if (controller.listDataLelangMuatanHistory.value[index]['Status'] == 1 &&
        today > endperiode) {
      status = "LelangMuatTabHistoryTabHistoryLabelTitleKadaluarsa".tr;
      colorFont = Color(ListColor.colorYellow5);
      colorBG = Color(ListColor.colorLightYellow1);
    }

    var isBlmDitentukan = false;
    if (controller.listDataLelangMuatanHistory.value[index]['Status'] == 1 &&
        today < endperiode) {
      status = "LelangMuatTabHistoryTabHistoryLabelTitleBelumDitentukan".tr;
      colorFont = Color(ListColor.colorRed5);
      colorBG = Color(ListColor.colorRed4);
      isBlmDitentukan = true;
    }
    return Obx(() => Container(
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
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8.5,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorLightBlue9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius))),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      child: CustomText(
                          controller.listDataLelangMuatanHistory.value[index]
                              ['BidNo'],
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 12,
                          fontWeight: FontWeight.w600),
                    )),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(created,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      10,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorBlue)),
                          CustomText(createdBotom,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      10,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorBlue)),
                        ],
                      ),
                    ),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _opsi(index);
                          },
                          child: Container(
                              child: Icon(
                            Icons.more_vert,
                            size:
                                GlobalVariable.ratioFontSize(Get.context) * 27,
                          )),
                        ))
                  ],
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 14),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: GlobalVariable.ratioFontSize(Get.context) * 104,
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Container(
                          // height: 300,
                          width: MediaQuery.of(Get.context).size.width,
                          // color: Colors.green,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          0),
                                  child: Container(
                                    child: SvgPicture.asset(
                                      "assets/titik_biru_pickup.svg",
                                      width: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          16,
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          16,
                                    ),
                                  )),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 10,
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: CustomText(
                                      controller.listDataLelangMuatanHistory
                                                  .value[index]['CityPickup'] ==
                                              null
                                          ? ""
                                          : controller
                                              .listDataLelangMuatanHistory
                                              .value[index]['CityPickup'],
                                      fontWeight: FontWeight.w500,
                                      // maxLines: 1,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          14,
                                      // height: GlobalVariable.ratioFontSize(
                                      //         Get.context) *
                                      //     (17 / 14),
                                    ),
                                  ),
                                  Container(
                                    child: CustomText(
                                      controller.listDataLelangMuatanHistory
                                          .value[index]['PickupEta'],
                                      fontWeight: FontWeight.w400,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          12,
                                      color: Color(ListColor.colorLightGrey4),
                                    ),
                                  ),
                                  if (controller.lengthPickupHistory[index] > 1)
                                    GestureDetector(
                                        onTap: () {
                                          controller.toDetailLelangMuatCari(
                                              controller
                                                  .listDataLelangMuatanHistory
                                                  .value[index]['ID']
                                                  .toString(),
                                              3);
                                        },
                                        child: Container(
                                          child: CustomText(
                                            "LelangMuatTabHistoryTabHistoryLabelTitleLihatSelengkapnya"
                                                .tr,
                                            fontWeight: FontWeight.w600,
                                            // maxLines: 1,
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    10,
                                            // height:
                                            //     GlobalVariable.ratioFontSize(
                                            //             Get.context) *
                                            //         (12 / 14),
                                            color: Color(ListColor.colorBlue),
                                          ),
                                        )),
                                ],
                              )),
                            ],
                          ),
                        ),
                        Positioned(
                            top: GlobalVariable.ratioFontSize(Get.context) * 18,
                            child: Container(
                              // height: 200,
                              width: MediaQuery.of(Get.context).size.width,
                              // color: Colors.blue,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        16,
                                    child: SvgPicture.asset(
                                      "assets/garis_alur_perjalanan.svg",
                                      // width: GlobalVariable.ratioWidth(Get.context) * 12,
                                      // height: GlobalVariable.ratioWidth(Get.context) * 30.5,
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          38,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10,
                                  ),
                                  Expanded(child: CustomText("")),
                                ],
                              ),
                            )),
                        Positioned(
                            top: GlobalVariable.ratioFontSize(Get.context) * 53,
                            child: Container(
                              // height: 200,
                              width: MediaQuery.of(Get.context).size.width,
                              // color: Colors.red,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            0),
                                    child: Container(
                                      child: SvgPicture.asset(
                                        "assets/titik_biru_kuning_destinasi.svg",
                                        width: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            16,
                                        height: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: CustomText(
                                          controller.listDataLelangMuatanHistory
                                                          .value[index]
                                                      ['CityDestination'] ==
                                                  null
                                              ? ""
                                              : controller
                                                      .listDataLelangMuatanHistory
                                                      .value[index]
                                                  ['CityDestination'],
                                          fontWeight: FontWeight.w500,
                                          // maxLines: 1,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  14,
                                          // height: GlobalVariable.ratioFontSize(
                                          //         Get.context) *
                                          //     (17 / 14),
                                        ),
                                      ),
                                      Container(
                                        child: CustomText(
                                          controller.listDataLelangMuatanHistory
                                              .value[index]['DestinationEta'],
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  12,
                                          color:
                                              Color(ListColor.colorLightGrey4),
                                        ),
                                      ),
                                      if (controller
                                              .lengthDestinasiHistory[index] >
                                          1)
                                        GestureDetector(
                                            onTap: () {
                                              controller.toDetailLelangMuatCari(
                                                  controller
                                                      .listDataLelangMuatanHistory
                                                      .value[index]['ID']
                                                      .toString(),
                                                  4);
                                            },
                                            child: Container(
                                              child: CustomText(
                                                "LelangMuatTabHistoryTabHistoryLabelTitleLihatSelengkapnya"
                                                    .tr,
                                                fontWeight: FontWeight.w600,
                                                // maxLines: 1,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    10,
                                                // height: GlobalVariable
                                                //         .ratioFontSize(
                                                //             Get.context) *
                                                //     (12 / 14),
                                                color:
                                                    Color(ListColor.colorBlue),
                                              ),
                                            )),
                                    ],
                                  )),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),

                  // pemisah
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Container(
                            child: SvgPicture.asset(
                              "assets/truck_plus_blue.svg",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  18,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      18,
                            ),
                          )),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: CustomText(
                                  "${controller.listDataLelangMuatanHistory.value[index]['HeadName']} - ${controller.listDataLelangMuatanHistory.value[index]['CarrierName']}",
                                  fontWeight: FontWeight.w500,
                                  // maxLines: 1,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14,
                                  height: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      (17 / 14)),
                            ),
                            Container(
                                child: Html(
                                    style: {
                                  "body": Style(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero)
                                },
                                    data: '<span style="font-weight: 400; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #676767;">' +
                                        'LelangMuatBuatLelangBuatLelangLabelTitleJumlah'
                                            .tr +
                                        ' <span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #000000;">${controller.listDataLelangMuatanHistory.value[index]['TruckQty']}</span> Unit, ' +
                                        'LelangMuatBuatLelangBuatLelangLabelTitleKurang'
                                            .tr +
                                        ' <span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #000000;">${controller.listDataLelangMuatanHistory.value[index]['RemainingNeeds']}</span> Unit</span>')),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioFontSize(Get.context) * 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Container(
                            child: SvgPicture.asset(
                              "assets/ic_timer_pasir.svg",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  18,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      18,
                            ),
                          )),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                        child: Container(
                          child: CustomText(
                              "${controller.listDataLelangMuatanHistory.value[index]['StartDate']} - ${controller.listDataLelangMuatanHistory.value[index]['EndDate']}",
                              fontWeight: FontWeight.w500,
                              // maxLines: 1,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (17 / 14)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              //garis
              width: MediaQuery.of(Get.context).size.width,
              height: 0.5,
              color: Color(ListColor.colorLightGrey10),
            ),
            Container(
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
                  if (status != "")
                    Container(
                        padding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioFontSize(Get.context) * 8,
                            GlobalVariable.ratioFontSize(Get.context) * 6,
                            GlobalVariable.ratioFontSize(Get.context) * 8,
                            GlobalVariable.ratioFontSize(Get.context) * 6),
                        decoration: BoxDecoration(
                            color: colorBG,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        child: isBlmDitentukan == false
                            ? CustomText(
                                status,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        12,
                                fontWeight: FontWeight.w600,
                                color: colorFont,
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    status,
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        12,
                                    fontWeight: FontWeight.w600,
                                    color: colorFont,
                                  ),
                                  SizedBox(
                                      width: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          4),
                                  SvgPicture.asset(
                                    "assets/info_merah.svg",
                                    height: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                    width: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                  )
                                ],
                              )),
                  if (status != "")
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioFontSize(Get.context) * 8,
                        GlobalVariable.ratioFontSize(Get.context) * 6,
                        GlobalVariable.ratioFontSize(Get.context) * 8,
                        GlobalVariable.ratioFontSize(Get.context) * 6),
                    decoration: BoxDecoration(
                        color: Color(ListColor.colorLightBlue3),
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: Row(
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            "assets/ic_view_blue.svg",
                            width:
                                GlobalVariable.ratioFontSize(Get.context) * 18,
                            height:
                                GlobalVariable.ratioFontSize(Get.context) * 18,
                            color: Color(ListColor.colorBlue),
                          ),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 6.32,
                        ),
                        CustomText(
                          controller.listDataLelangMuatanHistory
                              .value[index]['Viewers']
                              .toString(),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 12,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorBlue),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox.shrink()),
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onTap: () {
                          controller.toDetailLelangMuatCari(
                              controller.listDataLelangMuatanHistory
                                  .value[index]['ID']
                                  .toString(),
                              0);
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: CustomText(
                                  'LoadRequestInfoButtonLabelDetail'.tr,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ))),
                  ),
                ],
              ),
            )
          ],
        )));
  }

  _opsi(int index) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20),
                topRight: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 3,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 16),
                  child: Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 38,
                    height: 3,
                    decoration: BoxDecoration(
                        color: Color(ListColor.colorLightGrey16),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  )),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: CustomText(
                            "LelangMuatBuatLelangBuatLelangLabelTitleOpsi".tr,
                            fontWeight: FontWeight.w700,
                            color: Color(ListColor.colorBlue),
                            fontSize:
                                GlobalVariable.ratioFontSize(context) * 14),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          top: FontTopPadding.getSize(14),
                          left: GlobalVariable.ratioWidth(Get.context) * 12),
                      child: GestureDetector(
                        child: Icon(
                          Icons.close_rounded,
                          size: GlobalVariable.ratioFontSize(Get.context) * 27,
                        ),
                        onTap: () {
                          Get.back();
                        },
                      )),
                ],
              ),
              if (controller.type.value == "aktif")
                _opsiList(context, index)
              else
                _opsiListHistory(context, index),
            ],
          );
        });
  }

  _opsiList(BuildContext context, int idx) {
    return Column(
      children: [
        ListTile(
          leading: CustomText(
            "LelangMuatTabAktifTabAktifLabelTitleBidParticipant".tr,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            fontWeight: FontWeight.w600,
          ),
          onTap: () {
            Get.back();
            controller.toPesertaLelangSearch(
                controller.listDataLelangMuatan.value[idx]['ID'].toString(),
                controller.type.value);
          },
        ),
        _lineSaparator(),
        ListTile(
          leading: CustomText(
            "LelangMuatTabAktifTabAktifLabelTitleCloseBid".tr,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorRed),
          ),
          onTap: () {
            Get.back();
            GlobalAlertDialog.showAlertDialogCustom(
                context: Get.context,
                title:
                    "LelangMuatBuatLelangBuatLelangLabelTitleKonfirmasiPenutupan"
                        .tr,
                message:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmTutupLelang"
                        .tr
                        .replaceAll("\\n", "\n"),
                isShowCloseButton: true,
                isDismissible: true,
                positionColorPrimaryButton:
                    PositionColorPrimaryButton.PRIORITY1,
                labelButtonPriority1:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmYes".tr,
                labelButtonPriority2:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmNo".tr,
                onTapPriority1: () {
                  if (controller.listDataLelangMuatan.value[idx]['isClosed'] ==
                      false) {
                    GlobalAlertDialog.showAlertDialogCustom(
                        context: Get.context,
                        title: "",
                        message:
                            "LelangMuatTabAktifTabAktifLabelTitleConfirmFailCloseBid"
                                .tr,
                        isShowCloseButton: true,
                        isDismissible: true,
                        positionColorPrimaryButton:
                            PositionColorPrimaryButton.PRIORITY1,
                        labelButtonPriority1: "Ok");
                  } else {
                    controller.tutupLelang(
                      controller.listDataLelangMuatan.value[idx]["ID"]
                          .toString(),
                    );
                  }
                });
          },
        ),
        _lineSaparator(),
        ListTile(
          leading: CustomText(
            "LelangMuatTabAktifTabAktifLabelTitleCancelBid".tr,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorRed),
          ),
          onTap: () {
            Get.back();
            GlobalAlertDialog.showAlertDialogCustom(
                context: Get.context,
                title: "LelangMuatBuatLelangBuatLelangLabelTitleConfirmasiBatal"
                    .tr,
                message:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmBatalLelang"
                        .tr
                        .replaceAll("\\n", "\n"),
                isShowCloseButton: true,
                isDismissible: true,
                positionColorPrimaryButton:
                    PositionColorPrimaryButton.PRIORITY1,
                labelButtonPriority1:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmYes".tr,
                labelButtonPriority2:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmNo".tr,
                onTapPriority2: () {
                  controller.batalLelang(controller
                      .listDataLelangMuatan.value[idx]["ID"]
                      .toString());
                });
          },
        ),
      ],
    );
  }

  _opsiListHistory(BuildContext context, int idx) {
    return Column(
      children: [
        ListTile(
          leading: CustomText(
            "LelangMuatTabHistoryTabHistoryLabelTitleSalinLelangg".tr,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            fontWeight: FontWeight.w600,
          ),
          onTap: () {
            Get.back();
            controller.salinData(controller
                .listDataLelangMuatanHistory.value[idx]["ID"]
                .toString());
          },
        ),
        _lineSaparator(),
        ListTile(
          leading: CustomText(
            controller.listDataLelangMuatanHistory.value[idx]["Participant"] > 0
                ? "LelangMuatTabHistoryTabHistoryLabelTitlePesertaLelang".tr
                : "LelangMuatTabHistoryTabHistoryLabelTitlePesertaLelangNoPeserta"
                    .tr,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            fontWeight: FontWeight.w600,
            color: controller.listDataLelangMuatanHistory.value[idx]
                        ["Participant"] >
                    0
                ? Colors.black
                : Color(ListColor.colorLightGrey2),
          ),
          onTap: () {
            if (controller.listDataLelangMuatanHistory.value[idx]
                    ["Participant"] >
                0) {
              Get.back();
              controller.toPesertaLelangSearch(
                  controller.listDataLelangMuatanHistory.value[idx]['ID']
                      .toString(),
                  controller.type.value);
            }
          },
        ),
        _lineSaparator(),
        ListTile(
          leading: CustomText(
            controller.listDataLelangMuatanHistory.value[idx]["Participant"] >
                        0 &&
                    controller.listDataLelangMuatanHistory.value[idx]
                            ["WinnerParticipant"] ==
                        0
                ? "LelangMuatTabHistoryTabHistoryLabelTitlePemenangLelangNoPemenang"
                    .tr
                : "LelangMuatTabHistoryTabHistoryLabelTitlePemenangLelang".tr,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            fontWeight: FontWeight.w600,
            color: controller.listDataLelangMuatanHistory.value[idx]
                        ["WinnerParticipant"] >
                    0
                ? Colors.black
                : Color(ListColor.colorLightGrey2),
          ),
          onTap: () {
            if (controller.listDataLelangMuatanHistory.value[idx]
                    ["WinnerParticipant"] >
                0) {
              Get.back();
              controller.toPemenangLelang(controller
                  .listDataLelangMuatanHistory.value[idx]["ID"]
                  .toString());
            }
          },
        ),
      ],
    );
  }

  Widget _lineSaparator() {
    return Container(
        height: GlobalVariable.ratioWidth(Get.context) * 1,
        margin: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * 16,
            right: GlobalVariable.ratioWidth(Get.context) * 16),
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey10));
  }

  _titikSimbolDestinasi() {
    return Column(
      children: [
        Container(
          child: SvgPicture.asset(
            "assets/titik_biru_pickup.svg",
            width: GlobalVariable.ratioWidth(Get.context) * 16,
            height: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
        ),
        Container(
          child: SvgPicture.asset(
            "assets/garis_alur_perjalanan.svg",
            // width: GlobalVariable.ratioWidth(Get.context) * 12,
            height: GlobalVariable.ratioWidth(Get.context) * 34,
          ),
        ),
        Container(
          child: SvgPicture.asset(
            "assets/titik_biru_kuning_destinasi.svg",
            width: GlobalVariable.ratioWidth(Get.context) * 16,
            height: GlobalVariable.ratioWidth(Get.context) * 16,
          ),
        ),
      ],
    );
  }
}

class MonthIndoToInt {
  monthToIndo(String bulan) {
    var bul;
    if (bulan == "Jan") {
      bul = "01";
    }
    if (bulan == "Feb") {
      bul = "02";
    }
    if (bulan == "Mar") {
      bul = "03";
    }
    if (bulan == "Apr") {
      bul = "04";
    }
    if (bulan == "Mei") {
      bul = "05";
    }
    if (bulan == "Jun") {
      bul = "06";
    }
    if (bulan == "Jul") {
      bul = "07";
    }
    if (bulan == "Agust") {
      bul = "08";
    }
    if (bulan == "Sep") {
      bul = "09";
    }
    if (bulan == "Okt") {
      bul = "10";
    }
    if (bulan == "Nop") {
      bul = "11";
    }
    if (bulan == "Des") {
      bul = "12";
    }
    return bul;
  }
}
