import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang/ZO_peserta_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class ZoPesertaLelangView extends GetView<ZoPesertaLelangController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: WillPopScope(
          onWillPop: () {},
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  GlobalVariable.ratioWidth(context) *
                      (_appBar.preferredSize.height + 83)),
              child: Container(
                  height: _appBar.preferredSize.height + 83,
                  color: Color(ListColor.color4),
                  child: Stack(alignment: Alignment.center, children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image(
                        image: AssetImage("assets/fallin_star_3_icon.png"),
                        height: _appBar.preferredSize.height + 31,
                        // width: ,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 16,
                          right: GlobalVariable.ratioWidth(Get.context) * 14,
                          top: GlobalVariable.ratioFontSize(Get.context) * 13),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                child: ClipOval(
                                  child: Material(
                                      shape: CircleBorder(),
                                      color: Colors.white,
                                      child: InkWell(
                                          onTap: () {
                                            // controller.onClearSearch();
                                            Get.back(result: "back");
                                          },
                                          child: Container(
                                              width:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      28,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          context) *
                                                      28,
                                              child: Center(
                                                  child: Icon(
                                                Icons.arrow_back_ios_rounded,
                                                size: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    19,
                                                color: Color(ListColor.color4),
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
                                      // key: ValueKey("CariPesertaLelang"),
                                      context: Get.context,
                                      readOnly: true,
                                      onTap: () {
                                        controller.searchPesertaLelang();
                                      },
                                      onChanged: (value) {},
                                      // controller: controller
                                      //     .searchTextEditingController.value,
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) {},
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      newContentPadding: EdgeInsets.symmetric(
                                          horizontal: 42,
                                          vertical: GlobalVariable.ratioWidth(
                                                  context) *
                                              6),
                                      textSize: GlobalVariable.ratioFontSize(
                                              context) *
                                          14,
                                      newInputDecoration: InputDecoration(
                                        isDense: true,
                                        isCollapsed: true,
                                        hintText:
                                            "LelangMuatTabHistoryTabHistoryLabelTitleCariPesertaLelang"
                                                .tr, // "Cari Area Pick Up",
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
                                              BorderRadius.circular(8),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey7),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey7),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                    // Align(
                                    //     alignment: Alignment.centerRight,
                                    //     child: GestureDetector(
                                    //       onTap: () {},
                                    //       child: Container(
                                    //           margin: EdgeInsets.only(right: 10),
                                    //           child: Icon(
                                    //             Icons.close_rounded,
                                    //             color:
                                    //                 Color(ListColor.colorGrey3),
                                    //             size:
                                    //                 GlobalVariable.ratioFontSize(
                                    //                         Get.context) *
                                    //                     28,
                                    //           )),
                                    //     )),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          0),
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.showSort();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: controller.issort.isTrue
                                              ? SvgPicture.asset(
                                                  "assets/sort_active_white.svg",
                                                  width: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      22,
                                                  height: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      22,
                                                )
                                              : SvgPicture.asset(
                                                  "assets/sorting_icon.svg",
                                                  width: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      22,
                                                  height: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      22,
                                                  color: Colors.white,
                                                )))),
                            ],
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioFontSize(context) * 26,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioFontSize(context) * 16,
                                  GlobalVariable.ratioFontSize(context) * 13,
                                  GlobalVariable.ratioFontSize(context) * 16,
                                  GlobalVariable.ratioFontSize(context) * 13),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: CustomText(
                                    "LelangMuatTabHistoryTabHistoryLabelTitlePesertaLelang"
                                        .tr,
                                    fontSize:
                                        GlobalVariable.ratioFontSize(context) *
                                            14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(ListColor.colorLightGrey4),
                                  )),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: controller.isLoading.isTrue
                                        ? SizedBox(
                                            height:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                14,
                                            child:
                                                const CircularProgressIndicator(),
                                          )
                                        : CustomText(
                                            controller.noBid.value,
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(ListColor.color4),
                                          ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioFontSize(context) * 14,
                          )
                        ],
                      ),
                    )
                  ])),
            ),
            body: Obx(
              () => controller.isLoading.isTrue
                  ? Center(
                      child: SizedBox(
                        height: GlobalVariable.ratioFontSize(context) * 50,
                        width: GlobalVariable.ratioFontSize(context) * 50,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                        child: SmartRefresher(
                          enablePullUp: true,
                          enablePullDown: true,
                          controller: controller.refreshPesertaLelang,
                          onLoading: () {
                            controller.loadData();
                          },
                          onRefresh: () {
                            controller.refreshDataSmart();
                          },
                          child:
                              // Column(
                              //   mainAxisSize: MainAxisSize.max,
                              //   children: [
                              SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  color: Color(ListColor.color4),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioFontSize(context) *
                                            16,
                                        GlobalVariable.ratioFontSize(context) *
                                            0,
                                        GlobalVariable.ratioFontSize(context) *
                                            16,
                                        GlobalVariable.ratioFontSize(context) *
                                            14),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            GlobalVariable.ratioFontSize(
                                                    context) *
                                                16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      90,
                                              child: Stack(
                                                alignment: AlignmentDirectional
                                                    .topStart,
                                                children: [
                                                  Container(
                                                    // height: 300,
                                                    width: MediaQuery.of(
                                                            Get.context)
                                                        .size
                                                        .width,
                                                    // color: Colors.green,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                top: GlobalVariable
                                                                        .ratioFontSize(
                                                                            Get.context) *
                                                                    0),
                                                            child: Container(
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/titik_biru_pickup.svg",
                                                                width: GlobalVariable
                                                                        .ratioFontSize(
                                                                            Get.context) *
                                                                    16,
                                                                height: GlobalVariable
                                                                        .ratioFontSize(
                                                                            Get.context) *
                                                                    16,
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          width: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              10,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            child: CustomText(
                                                              controller.listPick
                                                                          .length >
                                                                      0
                                                                  ? controller
                                                                          .listPick
                                                                          .value[
                                                                      0]["City"]
                                                                  : "",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              // maxLines: 1,
                                                              fontSize: GlobalVariable
                                                                      .ratioFontSize(
                                                                          Get.context) *
                                                                  14,
                                                              // height: GlobalVariable
                                                              //         .ratioFontSize(
                                                              //             Get.context) *
                                                              //     (17 / 14),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          18,
                                                      child: Container(
                                                        // height: 200,
                                                        width: MediaQuery.of(
                                                                Get.context)
                                                            .size
                                                            .width,
                                                        // color: Colors.blue,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: GlobalVariable
                                                                      .ratioFontSize(
                                                                          Get.context) *
                                                                  16,
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/garis_alur_perjalanan.svg",
                                                                // width: GlobalVariable.ratioWidth(Get.context) * 12,
                                                                // height: GlobalVariable.ratioWidth(Get.context) * 30.5,
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    35,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: GlobalVariable
                                                                      .ratioFontSize(
                                                                          Get.context) *
                                                                  10,
                                                            ),
                                                            Expanded(
                                                                child:
                                                                    CustomText(
                                                                        "")),
                                                          ],
                                                        ),
                                                      )),
                                                  Positioned(
                                                      top: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          50,
                                                      child: Container(
                                                        // height: 200,
                                                        width: MediaQuery.of(
                                                                Get.context)
                                                            .size
                                                            .width,
                                                        // color: Colors.red,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: GlobalVariable
                                                                          .ratioFontSize(
                                                                              Get.context) *
                                                                      0),
                                                              child: Container(
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "assets/titik_biru_kuning_destinasi.svg",
                                                                  width: GlobalVariable
                                                                          .ratioFontSize(
                                                                              Get.context) *
                                                                      16,
                                                                  height: GlobalVariable
                                                                          .ratioFontSize(
                                                                              Get.context) *
                                                                      16,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  10,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                child:
                                                                    CustomText(
                                                                  controller.listDest
                                                                              .length >
                                                                          0
                                                                      ? controller
                                                                          .listDest
                                                                          .value[0]["City"]
                                                                      : "",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  // maxLines: 1,
                                                                  fontSize:
                                                                      GlobalVariable.ratioFontSize(
                                                                              Get.context) *
                                                                          14,
                                                                  // height: GlobalVariable
                                                                  //         .ratioFontSize(
                                                                  //             Get.context) *
                                                                  //     (17 / 14),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),

                                            // pemisah
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 0),
                                                    child: Container(
                                                      child: SvgPicture.asset(
                                                        "assets/ic_calendar.svg",
                                                        width: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            16,
                                                        height: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            16,
                                                        color: Color(
                                                            ListColor.color4),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: CustomText(
                                                      controller.listDataBid
                                                                  .length >
                                                              0
                                                          ? controller
                                                                  .listDataBid
                                                                  .value[0]
                                                              ["Created"]
                                                          : "",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      // maxLines: 1,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                      // height: GlobalVariable
                                                      //         .ratioFontSize(
                                                      //             Get.context) *
                                                      //     (17 / 14)
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      16,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 0),
                                                    child: Container(
                                                      child: SvgPicture.asset(
                                                        "assets/ic_timer_pasir.svg",
                                                        width: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            16,
                                                        height: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            16,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: CustomText(
                                                      controller.listDataBid
                                                                  .length >
                                                              0
                                                          ? controller.listDataBid
                                                                      .value[0][
                                                                  "StartDate"] +
                                                              " - " +
                                                              controller
                                                                      .listDataBid
                                                                      .value[0]
                                                                  ["EndDate"]
                                                          : "",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      // maxLines: 1,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14,
                                                      // height: GlobalVariable.ratioFontSize(
                                                      //         Get.context) *
                                                      //     (17 / 14)
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      11.49,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            4.51),
                                                    child: Container(
                                                      child: SvgPicture.asset(
                                                        "assets/truck_plus_blue.svg",
                                                        width: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            16,
                                                        height: GlobalVariable
                                                                .ratioFontSize(
                                                                    Get.context) *
                                                            16,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: CustomText(
                                                        controller.listDataBid.length > 0
                                                            ? controller.listDataBid.value[0][
                                                                    "HeadName"] +
                                                                " - " +
                                                                controller
                                                                        .listDataBid
                                                                        .value[0][
                                                                    "CarrierName"]
                                                            : "",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        // maxLines: 1,
                                                        fontSize:
                                                            GlobalVariable.ratioFontSize(Get.context) *
                                                                14,
                                                        height:
                                                            GlobalVariable.ratioFontSize(
                                                                    Get.context) *
                                                                (17 / 14)),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (controller.listParticipant.length > 0)
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioFontSize(context) *
                                            16,
                                        GlobalVariable.ratioFontSize(context) *
                                            14,
                                        GlobalVariable.ratioFontSize(context) *
                                            16,
                                        GlobalVariable.ratioFontSize(context) *
                                            14),
                                    child: Row(
                                      children: [
                                        Container(child: SizedBox.shrink()),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: CustomText(
                                            controller.listParticipant.length >
                                                    0
                                                ? "LelangMuatTabHistoryTabHistoryLabelTitleTotalPesertaLelang"
                                                        .tr +
                                                    " : ${controller.listParticipant.length}"
                                                : "",
                                            color: Colors.black,
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                if (controller.listParticipant.length > 0)
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          GlobalVariable.ratioFontSize(
                                                  context) *
                                              16,
                                          GlobalVariable.ratioFontSize(
                                                  context) *
                                              0,
                                          GlobalVariable.ratioFontSize(
                                                  context) *
                                              16,
                                          GlobalVariable.ratioFontSize(
                                                  context) *
                                              14),
                                      child: Column(
                                        children: [
                                          if (controller
                                                  .listParticipant.length >
                                              0)
                                            for (var i = 0;
                                                i <
                                                    controller
                                                        .listParticipant.length;
                                                i++)
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: GlobalVariable
                                                            .ratioFontSize(
                                                                context) *
                                                        14),
                                                child: listPerItem(i),
                                              ),
                                        ],
                                      )),

                                if (controller.listParticipant.length == 0)
                                  // Expanded(
                                  //   child:
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            GlobalVariable.ratioWidth(context) *
                                                55),
                                    child: Container(
                                        child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: SvgPicture.asset(
                                            "assets/ic_management_lokasi_no_data.svg",
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                82.3,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                75,
                                          )),
                                          Container(
                                            height: 12,
                                          ),
                                          Container(
                                              child: CustomText(
                                            "LelangMuatBuatLelangBuatLelangLabelTitleNoPesertaLelang"
                                                .tr
                                                .replaceAll("\\n", "\n"),
                                            textAlign: TextAlign.center,
                                            color: Color(
                                                ListColor.colorLightGrey14),
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    14,
                                            height: 1.2,
                                          ))
                                        ],
                                      ),
                                    )),
                                  ),
                                // ),
                              ],
                            ),
                          ),

                          //   ],
                          // ),
                        ),
                      ),
                      if (controller.type.value == "aktif")
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      16,
                              vertical:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withAlpha(70),
                                    offset: Offset(0, -2),
                                    blurRadius: 2,
                                    spreadRadius: 3)
                              ]),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  "assets/ic_blue_piala.svg",
                                  height:
                                      GlobalVariable.ratioFontSize(context) *
                                          30,
                                  width: GlobalVariable.ratioFontSize(context) *
                                      30,
                                ),
                              ),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioFontSize(context) * 12,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        "LelangMuatTabHistoryTabHistoryLabelTitlePemenangLelang"
                                            .tr,
                                        fontWeight: FontWeight.w600,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                context) *
                                            12,
                                        color: Colors.black),
                                    SizedBox(
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          4,
                                    ),
                                    CustomText(
                                        "LelangMuatPesertaLelangPesertaLelangLabelTitleSisaKebutuhan"
                                                .tr +
                                            " : 1000 Unit",
                                        fontWeight: FontWeight.w500,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                context) *
                                            10,
                                        color:
                                            Color(ListColor.colorLightGrey4)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioFontSize(context) * 8,
                              ),
                              Obx(() {
                                var onPressed;
                                if (controller.listDataBid.isNotEmpty) {
                                  var endDateString;
                                  try {
                                    endDateString =
                                        controller.listDataBid[0]["EndDate"];
                                    var endDate = DateFormat('dd MMM yyyy')
                                        .parse(endDateString);
                                    endDate = DateTime(endDate.year,
                                        endDate.month, endDate.day, 23, 59, 59);
                                    final now = DateTime.now();
                                    if (now.isBefore(endDate)) {
                                      onPressed = () {
                                        if (controller.listParticipant.length >
                                            0) controller.topilihpemenang();
                                      };
                                    }
                                  } catch (e) {
                                    debugPrint('endDateString: $endDateString');
                                    debugPrint(e);
                                  }
                                }
                                return Container(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      color: controller.listParticipant.length >
                                              0
                                          ? Color(ListColor.color4)
                                          : Color(ListColor.colorLightGrey2),
                                      disabledColor:
                                          Color(ListColor.colorLightGrey2),
                                      disabledTextColor:
                                          Color(ListColor.colorLightGrey4),
                                      onPressed: onPressed,
                                      child: CustomText(
                                        "LelangMuatPesertaLelangPesertaLelangLabelTitlePilihPemenang"
                                            .tr,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        )
                    ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget listPerItem(int index) {
    double borderRadius = 10;
    String created;
    String createdBottom;
    var expCreate = controller.listParticipant.value[index]["Created"]
        .toString()
        .split(" ");
    created = expCreate[0] + " " + expCreate[1] + " " + expCreate[2];
    createdBottom = expCreate[3] + " " + expCreate[4];

    String status = "";
    Color colorFont;
    Color colorBG;
    if (controller.listParticipant.value[index]['status'] != 3 &&
        controller.listParticipant.value[index]['nego_status'] == "1") {
      status =
          "LelangMuatPesertaLelangPesertaLelangLabelTitleNegosiasiHarga".tr;
      colorFont = Color(ListColor.colorYellow5);
      colorBG = Color(ListColor.colorLightYellow1);
    }
    if (controller.listParticipant.value[index]['status'] != 3 &&
        controller.listParticipant.value[index]['nego_status'] == "4") {
      status =
          "LelangMuatPesertaLelangPesertaLelangLabelTitleNegosiasiHarga".tr;
      colorFont = Color(ListColor.colorYellow5);
      colorBG = Color(ListColor.colorLightYellow1);
    }
    if (controller.listParticipant.value[index]['status'] != 3 &&
        controller.listParticipant.value[index]['nego_status'] == "2") {
      status =
          "LelangMuatPesertaLelangPesertaLelangLabelTitleNegosiasiDitolak".tr;
      colorFont = Color(ListColor.colorRed);
      colorBG = Color(ListColor.colorLightRed3);
    }
    if (controller.listParticipant.value[index]['status'] != 3 &&
        controller.listParticipant.value[index]['nego_status'] == "3") {
      status =
          "LelangMuatPesertaLelangPesertaLelangLabelTitleNegosiasiDiterima".tr;
      colorFont = Color(ListColor.colorGreen6);
      colorBG = Color(ListColor.colorLightGreen2);
    }
    if (controller.listParticipant.value[index]['status'] == 3) {
      status = "LelangMuatPesertaLelangPesertaLelangLabelTitlePemenang".tr;
      colorFont = Color(ListColor.colorIndicatorSelectedBigFleet2);
      colorBG = Colors.black;
    }
    return Container(
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
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8,
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
                    Container(
                        height: GlobalVariable.ratioFontSize(Get.context) * 32,
                        width: GlobalVariable.ratioFontSize(Get.context) * 32,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(controller
                              .listParticipant
                              .value[index]["TransporterAvatar"]),
                        )),
                    SizedBox(
                        width: GlobalVariable.ratioFontSize(Get.context) * 16),
                    Expanded(
                      child: Container(
                        child: CustomText(
                            controller.listParticipant.value[index]
                                ["TransporterName"],
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            height: GlobalVariable.ratioFontSize(Get.context) *
                                (17 / 14),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (controller.listParticipant.value[index]["IsGold"] ==
                        "1")
                      SizedBox(
                          width: GlobalVariable.ratioFontSize(Get.context) * 4),
                    if (controller.listParticipant.value[index]["IsGold"] ==
                        "1")
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: Get.context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return Dialog(
                                  key: GlobalKey<State>(),
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: 34.0, vertical: 24.0),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Image.asset(
                                                      "assets/ic_gold.png",
                                                      height: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          22.88,
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          17.29,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: GlobalVariable
                                                            .ratioFontSize(
                                                                context) *
                                                        4,
                                                  ),
                                                  CustomText("Gold Transporter",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          12,
                                                      color: Colors.black),
                                                ],
                                              ),
                                            ),
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 3, top: 3),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Icon(
                                                            Icons.close_rounded,
                                                            color: Color(
                                                                ListColor
                                                                    .color4),
                                                            size: GlobalVariable
                                                                    .ratioFontSize(
                                                                        context) *
                                                                24,
                                                          ))),
                                                )),
                                          ]),
                                      SizedBox(
                                        height: GlobalVariable.ratioFontSize(
                                                context) *
                                            12,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: GlobalVariable.ratioFontSize(
                                                    context) *
                                                16,
                                            right: GlobalVariable.ratioFontSize(
                                                    context) *
                                                16,
                                            bottom:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    8),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                  "    " +
                                                      "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldHead"
                                                          .tr,
                                                  textAlign: TextAlign.justify,
                                                  fontSize: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      12,
                                                  height: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      (14.4 / 12),
                                                  color: Color(
                                                      ListColor.colorDarkGrey3),
                                                  fontWeight: FontWeight.w500),
                                              SizedBox(
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    12,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: SvgPicture.asset(
                                                      "assets/check_blue_ic.svg",
                                                      height: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          4),
                                                  Expanded(
                                                    child: CustomText(
                                                        "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldSatu"
                                                            .tr,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            12,
                                                        height: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            (14.4 / 12),
                                                        color: Color(ListColor
                                                            .colorDarkGrey3),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    8,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: SvgPicture.asset(
                                                      "assets/check_blue_ic.svg",
                                                      height: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          4),
                                                  Expanded(
                                                    child: CustomText(
                                                        "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldDua"
                                                            .tr,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        fontSize: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            12,
                                                        height: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            (14.4 / 12),
                                                        color: Color(ListColor
                                                            .colorDarkGrey3),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    8,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: SvgPicture.asset(
                                                      "assets/check_blue_ic.svg",
                                                      height: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          4),
                                                  Expanded(
                                                      child: CustomText(
                                                          "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldTiga"
                                                              .tr,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      context) *
                                                              12,
                                                          height: GlobalVariable
                                                                  .ratioFontSize(
                                                                      context) *
                                                              (14.4 / 12),
                                                          color: Color(ListColor
                                                              .colorDarkGrey3),
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    8,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: SvgPicture.asset(
                                                      "assets/check_blue_ic.svg",
                                                      height: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          4),
                                                  Expanded(
                                                      child: CustomText(
                                                          "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldEmpat"
                                                              .tr,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      context) *
                                                              12,
                                                          height: GlobalVariable
                                                                  .ratioFontSize(
                                                                      context) *
                                                              (14.4 / 12),
                                                          color: Color(ListColor
                                                              .colorDarkGrey3),
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    8,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 3.0),
                                                    child: SvgPicture.asset(
                                                      "assets/check_blue_ic.svg",
                                                      height: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          14,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  context) *
                                                          4),
                                                  Expanded(
                                                      child: CustomText(
                                                          "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldLima"
                                                              .tr,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          fontSize: GlobalVariable
                                                                  .ratioFontSize(
                                                                      context) *
                                                              12,
                                                          height: GlobalVariable
                                                                  .ratioFontSize(
                                                                      context) *
                                                              (14.4 / 12),
                                                          color: Color(ListColor
                                                              .colorDarkGrey3),
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    12,
                                              ),
                                              CustomText(
                                                  "    " +
                                                      "LelangMuatPesertaLelangPesertaLelangLabelTitlePopGoldFooter"
                                                          .tr,
                                                  textAlign: TextAlign.justify,
                                                  fontSize: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      12,
                                                  height: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      (14.4 / 12),
                                                  color: Color(
                                                      ListColor.colorDarkGrey3),
                                                  fontWeight: FontWeight.w500),
                                            ]),
                                      ),
                                    ],
                                  )),
                                );
                              });
                        },
                        child: Container(
                          child: Image.asset(
                            "assets/ic_gold.png",
                            height:
                                GlobalVariable.ratioFontSize(Get.context) * 27,
                            width:
                                GlobalVariable.ratioFontSize(Get.context) * 21,
                          ),
                        ),
                      ),
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
                          CustomText(createdBottom,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Container(
                            child: Image.asset(
                              "assets/ic_menu_dashboard_promo_transport.png",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  16,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      16,
                              color: Color(ListColor.color4),
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
                            Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                      controller.converttoIDR(controller
                                          .listParticipant
                                          .value[index]["initialPrice"]),
                                      fontWeight: FontWeight.w500,
                                      color: Color(ListColor.colorGrey4),
                                      // maxLines: 1,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          14,
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          (17 / 14)),
                                ),
                                Expanded(
                                  child: controller.listParticipant.value[index]
                                              ['nego_status'] ==
                                          "2"
                                      ? Align(
                                          alignment: Alignment.centerRight,
                                          child: CustomText(
                                              controller.listParticipant
                                                              .value[index]
                                                          ["offer_price"] !=
                                                      null
                                                  ? "Nego : " +
                                                      controller.converttoIDR(
                                                          controller
                                                                  .listParticipant
                                                                  .value[index]
                                                              ["offer_price"])
                                                  : "",
                                              fontWeight: FontWeight.w500,
                                              color: Color(ListColor.color4),
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              // maxLines: 1,
                                              fontSize:
                                                  GlobalVariable.ratioFontSize(Get.context) *
                                                      14,
                                              height:
                                                  GlobalVariable.ratioFontSize(Get.context) *
                                                      (17 / 14)),
                                        )
                                      : Align(
                                          alignment: Alignment.centerRight,
                                          child: CustomText(
                                              controller.listParticipant.value[index]
                                                          ["offer_price"] !=
                                                      null
                                                  ? "Nego : " +
                                                      controller.converttoIDR(
                                                          controller
                                                                  .listParticipant
                                                                  .value[index]
                                                              ["offer_price"])
                                                  : "",
                                              fontWeight: FontWeight.w500,
                                              color: Color(ListColor.color4),
                                              // maxLines: 1,
                                              fontSize:
                                                  GlobalVariable.ratioFontSize(Get.context) *
                                                      14,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      (17 / 14)),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: GlobalVariable.ratioFontSize(Get.context) * 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Container(
                            child: SvgPicture.asset(
                              "assets/ic_truck_blue.svg",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  16,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      16,
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
                                  controller.listParticipant
                                          .value[index]["truckOffer"]
                                          .toString() +
                                      " Unit",
                                  fontWeight: FontWeight.w500,
                                  color: Color(ListColor.colorGrey4),
                                  // maxLines: 1,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14,
                                  height: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      (17 / 14)),
                            ),
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
                              "assets/ic_list_paper.svg",
                              width: GlobalVariable.ratioFontSize(Get.context) *
                                  16,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      16,
                            ),
                          )),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: Get.context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    // key: GlobalKey<State>(),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: CustomText(
                                                    "LelangMuatPesertaLelangPesertaLelangLabelTitleCatatanHarga"
                                                        .tr,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: GlobalVariable
                                                            .ratioFontSize(
                                                                context) *
                                                        16,
                                                    color: Colors.black),
                                              ),
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 3, top: 3),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Icon(
                                                              Icons
                                                                  .close_rounded,
                                                              color: Color(
                                                                  ListColor
                                                                      .color4),
                                                              size: GlobalVariable
                                                                      .ratioFontSize(
                                                                          context) *
                                                                  24,
                                                            ))),
                                                  )),
                                            ]),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15, bottom: 20),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    controller.listParticipant
                                                                        .value[index]
                                                                    ["notes"] ==
                                                                null ||
                                                            controller.listParticipant
                                                                        .value[index]
                                                                    ["notes"] ==
                                                                ""
                                                        ? ""
                                                        : controller
                                                                .listParticipant
                                                                .value[index]
                                                            ["notes"],
                                                    textAlign: TextAlign.center,
                                                    fontSize:
                                                        GlobalVariable.ratioFontSize(context) *
                                                            12,
                                                    height:
                                                        GlobalVariable.ratioFontSize(context) *
                                                            (14.4 / 12),
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500),
                                                SizedBox(
                                                  height: 24,
                                                ),
                                              ]),
                                        ),
                                      ],
                                    )),
                                  );
                                });
                          },
                          child: Container(
                            child: CustomText(
                                controller.listParticipant.value[index]
                                                ["notes"] ==
                                            "" ||
                                        controller.listParticipant.value[index]
                                                ["notes"] ==
                                            null
                                    ? "-"
                                    : controller.listParticipant.value[index]
                                        ["notes"],
                                fontWeight: FontWeight.w500,
                                color: Color(ListColor.colorGrey4),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14,
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        (17 / 14)),
                          ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.listParticipant.value[index]["status"] != 3 &&
                      (controller.listParticipant.value[index]["nego_status"] !=
                              null ||
                          controller.listParticipant.value[index]
                                  ["nego_status"] !=
                              "" ||
                          controller.listParticipant.value[index]
                                  ["nego_status"] !=
                              "0"))
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioFontSize(Get.context) * 8,
                            GlobalVariable.ratioFontSize(Get.context) * 4,
                            GlobalVariable.ratioFontSize(Get.context) * 8,
                            GlobalVariable.ratioFontSize(Get.context) * 4),
                        decoration: BoxDecoration(
                            color: colorBG,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: CustomText(
                          status,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 12,
                          fontWeight: FontWeight.w600,
                          color: colorFont,
                        ),
                      ),
                    ),
                  if (controller.listParticipant.value[index]["status"] == 3 &&
                      (controller.listParticipant.value[index]["nego_status"] !=
                              null ||
                          controller.listParticipant.value[index]
                                  ["nego_status"] !=
                              "" ||
                          controller.listParticipant.value[index]
                                  ["nego_status"] !=
                              "0"))
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorBG,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        8,
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        4,
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        8,
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        4),
                                child: CustomText(
                                  status,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      12,
                                  fontWeight: FontWeight.w600,
                                  color: colorFont,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                GlobalVariable.ratioFontSize(Get.context) * 4,
                          ),
                          Image.asset(
                            "assets/ic_piala.png",
                            height:
                                GlobalVariable.ratioFontSize(Get.context) * 20,
                            width:
                                GlobalVariable.ratioFontSize(Get.context) * 20,
                          )
                        ],
                      ),
                    ),
                  // Expanded(child: SizedBox.shrink()),
                  Container(
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(ListColor.colorBlue),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onTap: () {
                            controller.getContactTransporter(controller
                                .listParticipant.value[index]["transporterID"]
                                .toString());
                            _hubungiTransporter(index);
                          },
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
                                child: CustomText(
                                    "LelangMuatTabHistoryTabHistoryLabelTitleHubungiTransporter"
                                        .tr,
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  _opsi(int idx) {
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
              _opsiList(context, idx)
            ],
          );
        });
  }

  _opsiList(BuildContext context, int idx) {
    return Column(
      children: [
        if (controller.type.value == "aktif")
          if (controller.listParticipant.value[idx]['nego_status'] == null ||
              controller.listParticipant.value[idx]['nego_status'] == "" ||
              controller.listParticipant.value[idx]["nego_status"] != "0")
            ListTile(
              leading: CustomText(
                "LelangMuatPesertaLelangPesertaLelangLabelTitleNego".tr,
                fontSize: GlobalVariable.ratioFontSize(context) * 14,
                fontWeight: FontWeight.w600,
                color: ((controller.listParticipant.value[idx]['status'] != 3 &&
                            controller.listParticipant.value[idx]
                                    ['nego_status'] !=
                                "3") ||
                        (controller.listParticipant.value[idx]['status'] != 3 &&
                            controller.listParticipant.value[idx]
                                    ['nego_status'] !=
                                "4"))
                    ? Colors.black
                    : Color(ListColor.colorStroke),
              ),
              onTap: () {
                if ((controller.listParticipant.value[idx]['status'] != 3 &&
                        controller.listParticipant.value[idx]['nego_status'] !=
                            "3") ||
                    (controller.listParticipant.value[idx]['status'] != 3 &&
                        controller.listParticipant.value[idx]['nego_status'] !=
                            "4")) {
                  Get.back();
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return Dialog(
                          // key: GlobalKey<State>(),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(right: 3, top: 3),
                                          child: GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.only(
                                                      right: 5, top: 5),
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color:
                                                        Color(ListColor.color4),
                                                    size: GlobalVariable
                                                            .ratioFontSize(
                                                                context) *
                                                        24,
                                                  ))),
                                        )),
                                  ]),
                              Container(
                                child: Column(
                                  children: [
                                    CustomText(
                                        "LelangMuatPesertaLelangPesertaLelangLabelTitleReqNegoHarga"
                                            .tr,
                                        fontWeight: FontWeight.w700,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                context) *
                                            14,
                                        color: Colors.black),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    CustomText(
                                        controller.listParticipant.value[idx]
                                            ["TransporterName"],
                                        fontWeight: FontWeight.w600,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                context) *
                                            12,
                                        color:
                                            Color(ListColor.colorLightGrey4)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 24),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                                "LelangMuatPesertaLelangPesertaLelangLabelTitleHargaAwal"
                                                    .tr,
                                                fontWeight: FontWeight.w600,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    14,
                                                color: Colors.black),
                                          ),
                                          Expanded(
                                            child: CustomText(
                                                controller.converttoIDR(
                                                    controller.listParticipant
                                                            .value[idx]
                                                        ["initialPrice"]),
                                                fontWeight: FontWeight.w600,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    14,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                                "LelangMuatPesertaLelangPesertaLelangLabelTitlePermintaanHarga"
                                                    .tr,
                                                fontWeight: FontWeight.w600,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    14,
                                                color: Colors.black),
                                          ),
                                          Expanded(
                                            child: CustomTextField(
                                                key:
                                                    ValueKey("PermintaanHarga"),
                                                context: Get.context,
                                                controller: controller
                                                    .permintaanHarga.value,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  ThousanSeparatorFormater()
                                                ],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(ListColor
                                                        .colorLightGrey4),
                                                    fontSize:
                                                        GlobalVariable.ratioFontSize(
                                                                Get.context) *
                                                            14),
                                                newContentPadding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            12,
                                                    vertical:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            8),
                                                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                                                newInputDecoration: InputDecoration(
                                                  isDense: true,
                                                  isCollapsed: true,
                                                  hintText:
                                                      "Rp 900.000", // "Cari Area Pick Up",
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: Color(ListColor
                                                          .colorLightGrey2),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          14),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(ListColor
                                                            .colorLightGrey19),
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(ListColor
                                                            .colorLightGrey19),
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(ListColor
                                                            .colorLightGrey19),
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                Color(ListColor.color4),
                                            side: BorderSide(
                                                width: 2,
                                                color: Color(ListColor.color4)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            )),
                                        onPressed: () {
                                          Get.back();
                                          controller.kirimPermintaanHarga(
                                              controller.idBid.value,
                                              controller.listParticipant
                                                  .value[idx]['ID']
                                                  .toString(),
                                              controller
                                                  .permintaanHarga.value.text,
                                              controller.listParticipant
                                                      .value[idx]
                                                  ["TransporterName"]);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 35, vertical: 10),
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                CustomText("Kirim",
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ]),
                                        ),
                                      )
                                    ]),
                              ),
                            ],
                          )),
                        );
                      });
                }
              },
            ),
        if (controller.type.value == "aktif")
          if (controller.listParticipant.value[idx]['nego_status'] == null ||
              controller.listParticipant.value[idx]['nego_status'] == "" ||
              controller.listParticipant.value[idx]["nego_status"] != "0")
            _lineSaparator(),
        ListTile(
          leading: CustomText(
            "LelangMuatPesertaLelangPesertaLelangLabelTitleLihatProfilTransporter"
                .tr,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            fontWeight: FontWeight.w600,
          ),
          onTap: () {
            Get.back();
          },
        ),
        if (controller.type.value == "aktif")
          _lineSaparator()
        else if (controller.listParticipant.value[idx]['link'] != null)
          _lineSaparator(),
        if (controller.type.value == "aktif")
          ListTile(
            leading: CustomText(
              "LelangMuatPesertaLelangPesertaLelangLabelTitleLihatFilePenawaran"
                  .tr,
              fontSize: GlobalVariable.ratioFontSize(context) * 14,
              fontWeight: FontWeight.w600,
            ),
            onTap: () {
              Get.back();
              controller
                  .download(controller.listParticipant.value[idx]['link']);
              // launch(controller.listParticipant.value[idx]['link']);
            },
          )
        else if (controller.listParticipant.value[idx]['link'] != null)
          ListTile(
            leading: CustomText(
              "LelangMuatPesertaLelangPesertaLelangLabelTitleLihatFilePenawaran"
                  .tr,
              fontSize: GlobalVariable.ratioFontSize(context) * 14,
              fontWeight: FontWeight.w600,
            ),
            onTap: () {
              Get.back();
              controller
                  .download(controller.listParticipant.value[idx]['link']);
              // launch(controller.listParticipant.value[idx]['link']);
            },
          ),
      ],
    );
  }

  _hubungiTransporter(int idx) {
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
                            "LelangMuatPesertaLelangPesertaLelangLabelTitleAndaInginMenghubungiVia"
                                .tr,
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
              _hubungiTransporterList(context, idx)
            ],
          );
        });
  }

  _hubungiTransporterList(BuildContext context, int idx) {
    return Obx(() => controller.isloadingHubTransportasi.isTrue
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Column(
            children: [
              ListTile(
                leading: CustomText(
                  "PIC 1".tr,
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorGrey3),
                ),
                title: CustomText(
                  controller.dataHubTransporter.value["NamePic1"],
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: CustomText(
                  controller.dataHubTransporter.value["ContactPic1"],
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                ),
                trailing: SvgPicture.asset("assets/ic_telp.svg",
                    width: GlobalVariable.ratioFontSize(context) * 17.89,
                    height: GlobalVariable.ratioFontSize(context) * 18),
                onTap: () {
                  Get.back();
                  launch(
                      "tel://${controller.dataHubTransporter.value["ContactPic1"]}");
                },
              ),
              _lineSaparator(),
              ListTile(
                leading: CustomText(
                  "PIC 2".tr,
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorGrey3),
                ),
                title: CustomText(
                  controller.dataHubTransporter.value["NamePic2"],
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: CustomText(
                  controller.dataHubTransporter.value["ContactPic2"],
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => launch(
                          "tel://${controller.dataHubTransporter.value["ContactPic2"]}"),
                      child: Container(
                        child: SvgPicture.asset("assets/ic_telp.svg",
                            width:
                                GlobalVariable.ratioFontSize(context) * 17.89,
                            height: GlobalVariable.ratioFontSize(context) * 18),
                      ),
                    ),
                    SizedBox(width: GlobalVariable.ratioFontSize(context) * 16),
                    GestureDetector(
                        onTap: () => controller
                                    .dataHubTransporter.value["IsWa2"] ==
                                1
                            ? launch(
                                "https://wa.me/${controller.dataHubTransporter.value["ContactPic2"]}")
                            : "",
                        child: Container(
                          child: Image.asset("assets/ic_wa.png",
                              width: GlobalVariable.ratioFontSize(context) * 18,
                              height:
                                  GlobalVariable.ratioFontSize(context) * 18),
                        ))
                  ],
                ),
              ),
              _lineSaparator(),
              ListTile(
                leading: CustomText(
                  "PIC 3".tr,
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorGrey3),
                ),
                title: CustomText(
                  controller.dataHubTransporter.value["NamePic3"],
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  fontWeight: FontWeight.w600,
                ),
                subtitle: CustomText(
                  controller.dataHubTransporter.value["ContactPic3"],
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () => launch(
                            "tel://${controller.dataHubTransporter.value["ContactPic3"]}"),
                        child: Container(
                            child: SvgPicture.asset("assets/ic_telp.svg",
                                width: GlobalVariable.ratioFontSize(context) *
                                    17.89,
                                height: GlobalVariable.ratioFontSize(context) *
                                    18))),
                    SizedBox(width: GlobalVariable.ratioFontSize(context) * 16),
                    GestureDetector(
                        onTap: () => controller
                                    .dataHubTransporter.value["IsWa3"] ==
                                1
                            ? launch(
                                "https://wa.me/${controller.dataHubTransporter.value["ContactPic3"]}")
                            : "",
                        child: Container(
                            child: Image.asset("assets/ic_wa.png",
                                width:
                                    GlobalVariable.ratioFontSize(context) * 18,
                                height: GlobalVariable.ratioFontSize(context) *
                                    18))),
                  ],
                ),
                onTap: () {
                  Get.back();
                },
              ),
              _lineSaparator(),
              ListTile(
                title: CustomText(
                  "LelangMuatPesertaLelangPesertaLelangLabelTitleNoDarurat".tr,
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorGrey3),
                ),
                subtitle: CustomText(
                  controller.dataHubTransporter.value["EmergencyHp"],
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                ),
                trailing: SvgPicture.asset("assets/ic_telp.svg",
                    width: GlobalVariable.ratioFontSize(context) * 21.87,
                    height: GlobalVariable.ratioFontSize(context) * 22),
                onTap: () {
                  Get.back();
                  launch(
                      "tel://${controller.dataHubTransporter.value["EmergencyHp"]}");
                },
              ),
              _lineSaparator(),
              ListTile(
                title: CustomText(
                  "LelangMuatPesertaLelangPesertaLelangLabelTitleWADarurat".tr,
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorGrey3),
                ),
                subtitle: CustomText(
                  controller.dataHubTransporter.value["EmergencyWA"],
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                ),
                trailing: Image.asset("assets/ic_wa.png",
                    width: GlobalVariable.ratioFontSize(context) * 22,
                    height: GlobalVariable.ratioFontSize(context) * 22),
                onTap: () {
                  Get.back();
                  launch(
                      "https://wa.me/${controller.dataHubTransporter.value["EmergencyWA"]}");
                },
              ),
              _lineSaparator(),
              ListTile(
                title: CustomText(
                  "Inbox".tr,
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorGrey3),
                ),
                subtitle: CustomText(
                  "Terhubung dengan inbox Transporter".tr,
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  fontWeight: FontWeight.w600,
                ),
                trailing: SvgPicture.asset("assets/ic_message_local.svg",
                    width: GlobalVariable.ratioFontSize(context) * 21.87,
                    height: GlobalVariable.ratioFontSize(context) * 22),
                onTap: () {
                  Get.back();
                  controller.hubungiInbox("219");
                },
              ),
              _lineSaparator(),
              ListTile(
                title: CustomText(
                  "Email".tr,
                  fontSize: GlobalVariable.ratioFontSize(context) * 12,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorGrey3),
                ),
                subtitle: CustomText(
                  controller.dataHubTransporter.value["Email"] != ""
                      ? controller.dataHubTransporter.value["Email"]
                      : "-",
                  fontSize: GlobalVariable.ratioFontSize(context) * 14,
                  fontWeight: FontWeight.w600,
                ),
                trailing: SvgPicture.asset("assets/ic_message_email.svg",
                    width: GlobalVariable.ratioFontSize(context) * 21.87,
                    height: GlobalVariable.ratioFontSize(context) * 22),
                onTap: () {
                  Get.back();
                  launch(
                      "mailto:${controller.dataHubTransporter.value["Email"]}");
                },
              ),
            ],
          ));
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
}
