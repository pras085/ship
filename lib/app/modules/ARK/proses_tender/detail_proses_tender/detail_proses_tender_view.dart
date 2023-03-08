import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/edit_proses_tender/edit_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta/list_halaman_peserta_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_pemenang/list_halaman_peserta_detail_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_invited_transporter_tender/list_invited_transporter_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_rute_tender/select_rute_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/text_form_field_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:latlong/latlong.dart';

import 'detail_proses_tender_controller.dart';

class DetailProsesTenderView extends GetView<DetailProsesTenderController> {
  AppBar _appBar = AppBar(
    title: Text('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: onWillPop,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: Color(ListColor.colorBlue),
                statusBarIconBrightness: Brightness.light),
            child: SafeArea(
                child: Scaffold(
                    extendBody: true,
                    appBar: AppBar(
                      toolbarHeight:
                          GlobalVariable.ratioWidth(Get.context) * 135,
                      backgroundColor: GlobalVariable.appsMainColor,
                      leadingWidth:
                          GlobalVariable.ratioWidth(Get.context) * (24 + 16),
                      leading: Container(
                          padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16,
                          ),
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      "ic_back_button.svg",
                                  color: GlobalVariable
                                      .tabDetailAcessoriesMainColor))),
                      titleSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
                      title: Obx(() => controller.slideIndex.value > 0
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(Get
                                              .context) *
                                          8,
                                      bottom: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          "ProsesTenderDetailLabelNomorProsesTender"
                                              .tr, // Nomor Proses Tender
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: GlobalVariable
                                              .tabDetailAcessoriesMainColor),
                                      CustomText(controller.kodeTender.value,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: GlobalVariable
                                              .tabDetailAcessoriesMainColor)
                                    ],
                                  )))
                          : CustomText(
                              controller
                                          .jenisTab ==
                                      "History"
                                  ? "ProsesTenderDetailLabelDetailHistoryProsesTender"
                                      .tr
                                  : "ProsesTenderDetailLabelDetailProsesTender"
                                      .tr, // Detail Proses Tender
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color:
                                  GlobalVariable.tabDetailAcessoriesMainColor)),
                      actions: [
                        Obx(() => !controller.isLoading.value
                            ? GestureDetector(
                                onTap: () async {
                                  controller.cekShare =
                                      await SharedPreferencesHelper.getHakAkses(
                                          "Export Detail Proses Tender",
                                          denganLoading: true);
                                  if (SharedPreferencesHelper.cekAkses(
                                      controller.cekShare)) {
                                    //Untuk Share Data Info Pra Tender
                                    controller.shareDetailProsesTender();
                                  }
                                },
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "share_active.svg",
                                    color: controller.cekShare
                                        ? GlobalVariable.tabButtonMainColor
                                        : Color(ListColor.colorAksesDisable),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20))
                            : SizedBox()),
                        Obx(() => !controller.isLoading.value
                            ? controller.jenisTab != "Aktif"
                                ? SizedBox()
                                : Row(
                                    children: [
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14),
                                      GestureDetector(
                                          onTap: () async {
                                            controller.cekEdit =
                                                await SharedPreferencesHelper
                                                    .getHakAkses(
                                                        "Edit Proses Tender",
                                                        denganLoading: true);
                                            if (SharedPreferencesHelper
                                                .cekAkses(controller.cekEdit)) {
                                              var data = await GetToPage.toNamed<
                                                      EditProsesTenderController>(
                                                  Routes.EDIT_PROSES_TENDER,
                                                  arguments: [
                                                    controller.idTender,
                                                    controller.slideIndex.value
                                                  ]);

                                              if (data != null) {
                                                print('asd');
                                                controller.pageController
                                                    .jumpToPage(0);

                                                controller.getDetail("");
                                              }
                                            }
                                          },
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "ic_edit_white.svg",
                                              color: controller.cekEdit
                                                  ? Colors.white
                                                  : Color(ListColor
                                                      .colorAksesDisable),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20)),
                                    ],
                                  )
                            : SizedBox()),
                        SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 16),
                      ],
                      elevation: 0.0,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(
                            GlobalVariable.ratioWidth(Get.context) * 87),
                        child: Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 87,
                          //color: Color(ListColor.color4),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                  ),
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0.5,
                                  child: Container(
                                      color: Color(ListColor.colorLightBlue5))),
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Obx(() => CustomText(
                                              controller.title.value.tr,
                                              color: GlobalVariable
                                                  .tabDetailAcessoriesMainColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                        )),
                                        Obx(() => !controller.isLoading.value
                                            ? Obx(
                                                () => Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            (controller.satuanTender
                                                                        .value ==
                                                                    2
                                                                ? 5
                                                                : 4);
                                                        i++)
                                                      _buildPageIndicator(
                                                          i ==
                                                              controller
                                                                  .slideIndex
                                                                  .value,
                                                          i)
                                                  ],
                                                ),
                                              )
                                            : SizedBox())
                                      ],
                                    )),
                              ),
                              Obx(() => controller.isLoading.value
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(ListColor
                                                  .colorBackgroundTender),
                                              blurRadius: 0,
                                              spreadRadius: 0, // 1
                                              offset: Offset(0, 1), //0,5
                                            ),
                                          ]),
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          32,
                                    )
                                  : Container(
                                      //Color(ListColor.colorLightGrey2),
                                      decoration: BoxDecoration(
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(ListColor
                                                  .colorBackgroundTender),
                                              blurRadius: 0,
                                              spreadRadius: 0, // 1
                                              offset: Offset(0, 1), //0,5
                                            ),
                                          ]),
                                      // height:
                                      //     GlobalVariable.ratioWidth(Get.context) * 32,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              "ProsesTenderDetailLabelTotalPeserta"
                                                      .tr +
                                                  " : " +
                                                  GlobalVariable
                                                          .formatCurrencyDecimal(
                                                              controller
                                                                  .jumlahPeserta
                                                                  .value
                                                                  .toString())
                                                      .toString(), //Total Peserta Tender
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(
                                                  ListColor.colorBlack1B)),
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          100),
                                                ),
                                                onTap: () async {
                                                  controller.cekPeserta =
                                                      await SharedPreferencesHelper
                                                          .getHakAkses(
                                                              "Lihat Peserta",
                                                              denganLoading:
                                                                  true);
                                                  if (SharedPreferencesHelper
                                                      .cekAkses(controller
                                                          .cekPeserta)) {
                                                    var data = await GetToPage.toNamed<
                                                            ListHalamanPesertaController>(
                                                        Routes
                                                            .LIST_HALAMAN_PESERTA,
                                                        arguments: [
                                                          controller.idTender,
                                                          controller
                                                              .kodeTender.value,
                                                          controller
                                                              .kodePraTender
                                                              .value,
                                                          controller.judulTender
                                                              .value,
                                                          controller.namaMuatan
                                                                  .value +
                                                              " (" +
                                                              controller
                                                                  .jenisMuatan
                                                                  .value +
                                                              ") ",
                                                          controller
                                                                  .dataTahapTender[3]
                                                              [
                                                              'show_first_date'],
                                                          controller
                                                                  .dataTahapTender[3]
                                                              [
                                                              'show_last_date'],
                                                          controller
                                                                  .dataTahapTender[
                                                              3]['min_date'],
                                                          controller
                                                              .dataRuteTender,
                                                          controller
                                                              .satuanTender
                                                              .value,
                                                          controller
                                                              .satuanVolume
                                                              .value,
                                                          controller
                                                              .jumlahYangDigunakan
                                                              .value,
                                                          controller
                                                                  .dataTahapTender[
                                                              2]['min_date'],
                                                        ]);
                                                    if (data != null) {}
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        4,
                                                    bottom: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        4,
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        13,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        13,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color: Color(ListColor
                                                                  .colorShadow)
                                                              .withOpacity(
                                                                  0.01),
                                                          blurRadius: 10,
                                                          spreadRadius: 2,
                                                          offset: Offset(0, 8),
                                                        ),
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              GlobalVariable.ratioWidth(Get
                                                                      .context) *
                                                                  20),
                                                      border: Border.all(
                                                          width: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              1,
                                                          color: Color(ListColor
                                                              .colorLightGrey10))),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CustomText(
                                                          'ProsesTenderDetailLabelLihatPeserta'
                                                              .tr, //"Lihat Peserta"
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: controller
                                                                  .cekPeserta
                                                              ? Color(ListColor
                                                                  .colorBlue)
                                                              : Color(ListColor
                                                                  .colorAksesDisable)),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            6,
                                      ),
                                    ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottomNavigationBar: Container(
                        child: Obx(
                      () => controller.isLoading.value
                          ? Container()
                          : Column(
                              children: [
                                Expanded(child: Container()),
                                controller.jenisTab == "BelumDiumumkan" ||
                                        controller.jenisTab == "Diumumkan"
                                    ? Container(
                                        padding: EdgeInsets.fromLTRB(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              4,
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              4,
                                        ),
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            36,
                                        decoration: BoxDecoration(
                                          color: Color(ListColor.colorBlue),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children:
                                              !controller.sudahAdaPemenang.value
                                                  ? [
                                                      CustomText(
                                                        "ProsesTenderDetailLabelAyoPilihPemenang"
                                                            .tr,
                                                        // "Ayo, pilih pemenang Anda!",
                                                        color: Color(ListColor
                                                            .colorWhite),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          100),
                                                            ),
                                                            onTap: () async {
                                                              controller
                                                                      .cekPilihPemenang =
                                                                  await SharedPreferencesHelper.getHakAkses(
                                                                      "Pilih Pemenang",
                                                                      denganLoading:
                                                                          true);
                                                              if (SharedPreferencesHelper
                                                                  .cekAkses(
                                                                      controller
                                                                          .cekPilihPemenang)) {
                                                                var res = await GetToPage.toNamed<
                                                                        ListHalamanPesertaController>(
                                                                    Routes
                                                                        .LIST_HALAMAN_PESERTA,
                                                                    arguments: [
                                                                      controller
                                                                          .idTender,
                                                                      controller
                                                                          .kodeTender
                                                                          .value,
                                                                      controller
                                                                          .kodePraTender
                                                                          .value,
                                                                      controller
                                                                          .judulTender
                                                                          .value,
                                                                      controller
                                                                              .namaMuatan
                                                                              .value +
                                                                          " (" +
                                                                          controller
                                                                              .jenisMuatan
                                                                              .value +
                                                                          ") ",
                                                                      controller
                                                                              .dataTahapTender[3]
                                                                          [
                                                                          'show_first_date'],
                                                                      controller
                                                                              .dataTahapTender[3]
                                                                          [
                                                                          'show_last_date'],
                                                                      controller
                                                                              .dataTahapTender[3]
                                                                          [
                                                                          'min_date'],
                                                                      controller
                                                                          .dataRuteTender,
                                                                      controller
                                                                          .satuanTender
                                                                          .value,
                                                                      controller
                                                                          .satuanVolume
                                                                          .value,
                                                                      controller
                                                                          .jumlahYangDigunakan
                                                                          .value,
                                                                      controller
                                                                              .dataTahapTender[2]
                                                                          [
                                                                          'min_date'],
                                                                    ]);
                                                                if (res ==
                                                                    true) {
                                                                  controller
                                                                      .getDetail(
                                                                          "");
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    4,
                                                                bottom: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    4,
                                                                left: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    13,
                                                                right: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    13,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  boxShadow: <
                                                                      BoxShadow>[
                                                                    BoxShadow(
                                                                      color: Color(ListColor
                                                                              .colorShadow)
                                                                          .withOpacity(
                                                                              0.01),
                                                                      blurRadius:
                                                                          10,
                                                                      spreadRadius:
                                                                          2,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              8),
                                                                    ),
                                                                  ],
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              20),
                                                                  border: Border.all(
                                                                      width:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              1,
                                                                      color: controller
                                                                              .cekPilihPemenang
                                                                          ? Color(ListColor
                                                                              .colorBlue)
                                                                          : Color(
                                                                              ListColor.colorAksesDisable))),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  CustomText(
                                                                    "ProsesTenderDetailButtonPilih"
                                                                        .tr, // pilih
                                                                    color: controller
                                                                            .cekPilihPemenang
                                                                        ? Color(ListColor
                                                                            .colorBlue)
                                                                        : Color(
                                                                            ListColor.colorAksesDisable),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    ]
                                                  : [
                                                      Container(),
                                                      Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          100),
                                                            ),
                                                            onTap: () async {
                                                              controller
                                                                      .cekLihatPemenang =
                                                                  await SharedPreferencesHelper.getHakAkses(
                                                                      "Lihat Pemenang",
                                                                      denganLoading:
                                                                          true);
                                                              if (SharedPreferencesHelper
                                                                  .cekAkses(
                                                                      controller
                                                                          .cekLihatPemenang)) {
                                                                var tipeListPeserta;
                                                                if (controller
                                                                        .dataTahapTender[
                                                                            3][
                                                                            'min_date']
                                                                        .compareTo(
                                                                            controller.dateNow) <=
                                                                    0) {
                                                                  tipeListPeserta =
                                                                      "SEKARANG";
                                                                } else if (controller
                                                                        .dataTahapTender[
                                                                            3][
                                                                            'min_date']
                                                                        .compareTo(
                                                                            controller.dateNow) >
                                                                    0) {
                                                                  tipeListPeserta =
                                                                      "SEBELUM";
                                                                }

                                                                await GetToPage.toNamed<
                                                                        ListHalamanPesertaDetailPemenangController>(
                                                                    Routes
                                                                        .LIST_HALAMAN_PESERTA_DETAIL_PEMENANG,
                                                                    arguments: [
                                                                      controller
                                                                          .dataRuteTender
                                                                          .value,
                                                                      controller
                                                                          .satuanTender
                                                                          .value,
                                                                      controller
                                                                          .satuanVolume
                                                                          .value,
                                                                      controller
                                                                          .idTender,
                                                                      controller
                                                                          .kodeTender
                                                                          .value,
                                                                      controller
                                                                          .judulTender
                                                                          .value,
                                                                      controller
                                                                              .namaMuatan
                                                                              .value +
                                                                          " (" +
                                                                          controller
                                                                              .jenisMuatan
                                                                              .value +
                                                                          ") ",
                                                                      controller
                                                                          .jumlahYangDigunakan
                                                                          .value
                                                                          .toString(),
                                                                      tipeListPeserta,
                                                                    ]);
                                                              }
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    4,
                                                                bottom: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    4,
                                                                left: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    13,
                                                                right: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    13,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  boxShadow: <
                                                                      BoxShadow>[
                                                                    BoxShadow(
                                                                      color: Color(ListColor
                                                                              .colorShadow)
                                                                          .withOpacity(
                                                                              0.01),
                                                                      blurRadius:
                                                                          10,
                                                                      spreadRadius:
                                                                          2,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              8),
                                                                    ),
                                                                  ],
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              20),
                                                                  border: Border.all(
                                                                      width:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              1,
                                                                      color: controller
                                                                              .cekLihatPemenang
                                                                          ? Color(ListColor
                                                                              .colorBlue)
                                                                          : Color(
                                                                              ListColor.colorAksesDisable))),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  CustomText(
                                                                    "ProsesTenderDetailButtonLihatPemenang"
                                                                        .tr, // Lihat Pemenang
                                                                    color: controller
                                                                            .cekLihatPemenang
                                                                        ? Color(ListColor
                                                                            .colorBlue)
                                                                        : Color(
                                                                            ListColor.colorAksesDisable),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                        ),
                                      )
                                    : Container(),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  10),
                                          topRight: Radius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                          offset: Offset(0, -5),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            11,
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            22),
                                    child: Row(children: [
                                      Expanded(
                                        flex: 1,
                                        child: Obx(() => Opacity(
                                              opacity:
                                                  controller.slideIndex == 0
                                                      ? 0
                                                      : 1,
                                              child: MaterialButton(
                                                elevation: 0,
                                                padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20)),
                                                    side: BorderSide(
                                                        width: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            1,
                                                        color: Color(
                                                            ListColor.color4))),
                                                color:
                                                    Color(ListColor.colorWhite),
                                                onPressed:
                                                    !controller.isLoading.value
                                                        ? () {
                                                            if (controller
                                                                    .slideIndex
                                                                    .value !=
                                                                0) {
                                                              controller
                                                                  .slideIndex
                                                                  .value--;
                                                              controller.pageController.animateToPage(
                                                                  controller
                                                                      .slideIndex
                                                                      .value,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  curve: Curves
                                                                      .linear);
                                                            }
                                                          }
                                                        : null,
                                                child: CustomText(
                                                  "ProsesTenderDetailLabelSebelumnya"
                                                      .tr, // Sebelumnya
                                                  color:
                                                      Color(ListColor.color4),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      Expanded(
                                          flex: 1,
                                          child: Obx(() => MaterialButton(
                                                elevation: 0,
                                                padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20))),
                                                color: Color(ListColor.color4),
                                                onPressed:
                                                    !controller.isLoading.value
                                                        ? () {
                                                            FocusScope.of(
                                                                    Get.context)
                                                                .unfocus();
                                                            int saveIndex = 0;
                                                            if (controller
                                                                    .satuanTender
                                                                    .value ==
                                                                2) {
                                                              saveIndex = 4;
                                                            } else {
                                                              saveIndex = 3;
                                                            }
                                                            if (controller
                                                                    .slideIndex
                                                                    .value !=
                                                                saveIndex) {
                                                              controller
                                                                  .slideIndex
                                                                  .value++;
                                                              controller.pageController.animateToPage(
                                                                  controller
                                                                      .slideIndex
                                                                      .value,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  curve: Curves
                                                                      .linear);
                                                            } else {
                                                              controller
                                                                  .onSave();
                                                            }
                                                          }
                                                        : null,
                                                child: controller.satuanTender
                                                            .value ==
                                                        2
                                                    ? Obx(() => CustomText(
                                                          controller.slideIndex
                                                                      .value ==
                                                                  4
                                                              ? "ProsesTenderDetailLabelKembaliKeList"
                                                                  .tr // Kembali ke List
                                                              : "ProsesTenderDetailLabelSelanjutnya"
                                                                  .tr, // Selanjutnya
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                        ))
                                                    : Obx(() => CustomText(
                                                          controller.slideIndex
                                                                      .value ==
                                                                  3
                                                              ? "ProsesTenderDetailLabelKembaliKeList"
                                                                  .tr // Kembali ke List
                                                              : "ProsesTenderDetailLabelSelanjutnya"
                                                                  .tr, // Selanjutnya
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                        )),
                                              ))),
                                    ])),
                              ],
                            ),
                    )),
                    body: Container(
                        child: Obx(() => !controller.isLoading.value
                            ? Stack(
                                children: [
                                  Container(
                                    color:
                                        Color(ListColor.colorBackgroundTender),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            child: Obx(
                                          () => PageView(
                                            //physics: NeverScrollableScrollPhysics(),
                                            onPageChanged: (index) {
                                              controller.slideIndex.value =
                                                  index;
                                              controller.updateTitle();
                                            },
                                            controller:
                                                controller.pageController,
                                            children:
                                                controller.satuanTender.value ==
                                                        2
                                                    ? [
                                                        firstPage(context),
                                                        secondPage(context),
                                                        thirdPage(context),
                                                        fourthPage(context),
                                                        fifthPage(context),
                                                      ]
                                                    : [
                                                        firstPage(context),
                                                        secondPage(context),
                                                        fourthPage(context),
                                                        fifthPage(context),
                                                      ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )))))));
  }

  Widget _buildPageIndicator(bool isCurrentPage, int index) {
    int saveIndex = 0;
    if (controller.satuanTender.value == 2) {
      saveIndex = 4;
    } else {
      saveIndex = 3;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: GlobalVariable.ratioWidth(Get.context) * 10,
            backgroundColor: GlobalVariable.tabDetailBorderPageIndicatorColor,
            child: CircleAvatar(
                radius: GlobalVariable.ratioWidth(Get.context) * 8,
                backgroundColor: isCurrentPage
                    ? GlobalVariable
                        .tabDetailBackgroundPageIndicatorCurrentColor
                    : GlobalVariable.appsMainColor,
                child: CustomText(
                  (index + 1).toString(),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: isCurrentPage
                      ? GlobalVariable.appsMainColor
                      : GlobalVariable.tabDetailAcessoriesMainColor,
                ))),
        index == saveIndex
            ? SizedBox.shrink()
            : Container(
                height: GlobalVariable.ratioWidth(Get.context) * 2,
                width: GlobalVariable.ratioWidth(Get.context) * 8,
                color: GlobalVariable.tabDetailBorderPageIndicatorColor)
      ],
    );
  }

  Widget firstPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formOne,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 20,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  "ProsesTenderDetailLabelNomorTender".tr, // Nomor Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              Row(
                children: [
                  CustomText(
                    controller.kodeTender.value,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  controller.jenisTab == 'BelumDiumumkan' &&
                          controller.sudahAdaPemenang.value
                      ? SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 16)
                      : SizedBox(),
                  controller.jenisTab == 'BelumDiumumkan' &&
                          controller.sudahAdaPemenang.value &&
                          controller.cekUmumkan
                      ? GestureDetector(
                          child: CustomText(
                            "PemenangTenderIndexLabelUmumkanLebihAwalKecil"
                                .tr, // Umumkan Lebih Awal
                            color: Colors.blue,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: () {
                            controller.umumkan(controller.idTender);
                          },
                        )
                      : SizedBox()
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),

              controller.kodePraTender.value != "-"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          CustomText(
                              "ProsesTenderDetailLabelNomorPraTender"
                                  .tr, // Nomor Pra Tender
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(ListColor.colorGrey3)),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          CustomText(
                            controller.kodePraTender.value,
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24),
                        ])
                  : SizedBox(),
              CustomText(
                  "ProsesTenderDetailLabelTanggalDibuat".tr, // Tanggal Dibuat
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(
                controller.tanggalDibuat.value,
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "ProsesTenderDetailLabelDiumumkanKepada"
                      .tr, // Diumumkan Kepada
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              controller.dataSelectedTampil.value.length > 0
                  ? SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 2)
                  : SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 8),
              controller.dataSelectedTampil.value.length > 0
                  ? Obx(() => Column(
                        children: [
                          Wrap(
                            children: [
                              for (var index = 0;
                                  index <
                                      (controller.dataSelectedTampil.value
                                                  .length >
                                              6
                                          ? 6
                                          : controller
                                              .dataSelectedTampil.value.length);
                                  index++)
                                controller.selectedTransporterWidget(
                                    controller.dataSelectedTampil[index], index)
                            ],
                          ),
                        ],
                      ))
                  : SizedBox(),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              controller.jenisTab == "History" ||
                      controller.dataEmailTransporter.length == 0
                  ? SizedBox()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          CustomText(
                              "ProsesTenderDetailLabelInvitedTransporter"
                                  .tr, // Invited Transporter
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(ListColor.colorGrey3)),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 9),
                          controller.jenisTab == "Aktif" &&
                                  !controller.masaSeleksi
                              ? Column(
                                  children: [
                                    Material(
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      color: controller.cekKirim
                                          ? Color(ListColor.colorBlue)
                                          : Color(ListColor.colorAksesDisable),
                                      child: InkWell(
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    18),
                                          ),
                                          onTap: () async {
                                            controller.cekKirim =
                                                await SharedPreferencesHelper
                                                    .getHakAkses(
                                                        "Undang Invited Transporter Proses Tender",
                                                        denganLoading: true);
                                            if (SharedPreferencesHelper
                                                .cekAkses(
                                                    controller.cekKirim)) {
                                              var data = await GetToPage.toNamed<
                                                      ListInvitedTransporterTenderController>(
                                                  Routes
                                                      .LIST_INVITED_TRANSPORTER_TENDER,
                                                  arguments: [
                                                    controller.idTender,
                                                    controller.dataEmail.value,
                                                    'TD'
                                                  ]);
                                              if (data != null) {
                                                controller.time.cancel();
                                                controller.getDetail("");
                                              }
                                            }
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      GlobalVariable.ratioWidth(Get.context) *
                                                          11,
                                                  vertical: GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      6),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          20)),
                                              child: CustomText(
                                                  'ProsesTenderDetailLabelKirimLink'
                                                      .tr, // Kirim Link
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600))),
                                    ),
                                    controller.dataEmailTransporter.length > 0
                                        ? SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20)
                                        : SizedBox(),
                                  ],
                                )
                              : SizedBox(),
                          for (var x = 0;
                              x < controller.dataEmailTransporter.length;
                              x++)
                            for (var y = 0;
                                y <
                                    controller
                                        .dataEmailTransporter[x]['data'].length;
                                y++)
                              Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              90,
                                          child: CustomText(
                                              y == 0
                                                  ? controller
                                                          .dataEmailTransporter[
                                                      x]['tanggal']
                                                  : "",
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.black)),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              controller.dataEmailTransporter[x]
                                                  ['data'][y]['name'],
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  4),
                                          controller.jenisTab == "Aktif" &&
                                                  !controller.masaSeleksi
                                              ? GestureDetector(
                                                  onTap:
                                                      controller.dataEmailTransporter[
                                                                      x]['data']
                                                                  [
                                                                  y]['waktu'] !=
                                                              0
                                                          ? null
                                                          : () async {
                                                              controller
                                                                      .cekKirim =
                                                                  await SharedPreferencesHelper.getHakAkses(
                                                                      "Undang Invited Transporter Proses Tender",
                                                                      denganLoading:
                                                                          true);
                                                              if (SharedPreferencesHelper
                                                                  .cekAkses(
                                                                      controller
                                                                          .cekKirim)) {
                                                                controller.kirimUlang(
                                                                    controller.dataEmailTransporter[x]
                                                                            [
                                                                            'data']
                                                                        [
                                                                        y]['id'],
                                                                    x);
                                                              }
                                                            },
                                                  child: RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "AvenirNext",
                                                            color: Color(
                                                                ListColor
                                                                    .color4)),
                                                        children: [
                                                          TextSpan(
                                                              text: "ProsesTenderDetailLabelKirimUlang"
                                                                  .tr, // Kirim Ulang
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "AvenirNext",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      GlobalVariable.ratioFontSize(Get.context) *
                                                                          14,
                                                                  color: controller
                                                                          .cekKirim
                                                                      ? controller.dataEmailTransporter[x]['data'][y]['waktu'] !=
                                                                              0
                                                                          ? Color(ListColor
                                                                              .colorLightGrey2)
                                                                          : Color(ListColor
                                                                              .colorBlue)
                                                                      : Color(ListColor
                                                                          .colorAksesDisable))),
                                                          WidgetSpan(
                                                              child: SizedBox(
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      14)),
                                                          TextSpan(
                                                              text: controller.dataEmailTransporter[x]['data']
                                                                              [y][
                                                                          'waktu'] !=
                                                                      0
                                                                  ? (Duration(
                                                                          seconds: controller.dataEmailTransporter[x]['data'][y][
                                                                              'waktu'])
                                                                      .toString()
                                                                      .substring(
                                                                          2,
                                                                          Duration(seconds: controller.dataEmailTransporter[x]['data'][y]['waktu']).toString().length -
                                                                              7))
                                                                  : "",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "AvenirNext",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorLightGrey4),
                                                                fontSize: GlobalVariable
                                                                        .ratioFontSize(
                                                                            Get.context) *
                                                                    14,
                                                              )),
                                                        ]),
                                                  ),
                                                )
                                              : SizedBox(),
                                          y !=
                                                  controller
                                                          .dataEmailTransporter[
                                                              x]['data']
                                                          .length -
                                                      1
                                              ? SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8)
                                              : SizedBox()
                                        ],
                                      ))
                                    ],
                                  )),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24),
                        ]),
              CustomText("ProsesTenderDetailLabelJudul".tr, //Judul
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(controller.judulTender.value,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "ProsesTenderDetailLabelJenisTender"
                      .tr, // Jenis Proses Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),

              GestureDetector(
                  onTap: () {
                    if (controller.lihattertutup.value) {
                      controller.lihattertutup.value = false;
                    } else {
                      controller.lihattertutup.value = true;
                    }
                    print("TERTUTUP : " +
                        controller.lihattertutup.value.toString());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                          controller
                              .arrJenisTender[controller.jenisTender.value].tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(ListColor.colorBlack1B)),
                      controller.jenisTender.value == 2
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 3,
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 6,
                              ),
                              child: Transform.rotate(
                                  angle: (controller.lihattertutup.value
                                          ? 90
                                          : 270) *
                                      3.14 /
                                      180,
                                  child: Icon(Icons.chevron_left_rounded,
                                      color: Color(ListColor.colorLightGrey4),
                                      size: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20)),
                            )
                          : SizedBox()
                    ],
                  )),
              (controller.lihattertutup.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 21),
                        RichText(
                          text: TextSpan(
                              text: "ProsesTenderDetailLabelInformasiYang".tr +
                                  " ", //Informasi yang
                              style: TextStyle(
                                fontFamily: "AvenirNext",
                                color: Color(ListColor.colorBlack1B),
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        12,
                                height: 1.2,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                    text: "\"" +
                                        "ProsesTenderDetailLabelTidakDapatDilihatPeserta"
                                            .tr +
                                        "\"",
                                    style: TextStyle(
                                      fontFamily: "AvenirNext",
                                      color: Color(ListColor.colorRed),
                                      fontSize: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          12,
                                      height: 1.2,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: " :",
                                          style: TextStyle(
                                            fontFamily: "AvenirNext",
                                            color:
                                                Color(ListColor.colorBlack1B),
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    12,
                                            height: 1.2,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [])
                                    ])
                              ]),
                        ),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 14),
                        controller.cekdaftarpeserta.value ||
                                controller.cekdatarutedanhargapenawaran.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      "ProsesTenderDetailLabelPesertaTender"
                                          .tr, // Peserta Tender
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(ListColor.colorBlack1B)),
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  controller.cekdaftarpeserta.value
                                      ? Row(
                                          children: [
                                            CustomText(
                                              controller.bullet,
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8,
                                            ),
                                            CustomText(
                                              "ProsesTenderDetailLabelDaftarPesertaTender"
                                                  .tr, // Daftar Peserta Tender
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                  controller.cekdaftarpeserta.value
                                      ? SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              6)
                                      : SizedBox(),
                                  controller.cekdatarutedanhargapenawaran.value
                                      ? Row(
                                          children: [
                                            CustomText(
                                              controller.bullet,
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8,
                                            ),
                                            CustomText(
                                              "ProsesTenderDetailLabelHargaPenawaranPesertaLainnya"
                                                  .tr, // Harga Penawaran Peserta Lainnya
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              )
                            : SizedBox(),
                        controller.cekdaftarpeserta.value ||
                                controller.cekdatarutedanhargapenawaran.value
                            ? SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 8)
                            : SizedBox(),
                        controller.cekdaftarpemenang.value ||
                                controller.cekdataalokasipemenang.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      "ProsesTenderDetailLabelPemenangTender"
                                          .tr, // Pemenang Tender
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(ListColor.colorBlack1B)),
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  controller.cekdaftarpemenang.value
                                      ? Row(
                                          children: [
                                            CustomText(
                                              controller.bullet,
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8,
                                            ),
                                            CustomText(
                                              "ProsesTenderDetailLabelDaftarPemenang"
                                                  .tr, // Daftar Pemenang
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                  controller.cekdaftarpemenang.value
                                      ? SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              6)
                                      : SizedBox(),
                                  controller.cekdataalokasipemenang.value
                                      ? Row(
                                          children: [
                                            CustomText(
                                              controller.bullet,
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8,
                                            ),
                                            CustomText(
                                              "ProsesTenderDetailLabelDataAlokasiPemenang"
                                                  .tr, // Data Alokasi Pemenang
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        )
                                      : SizedBox()
                                ],
                              )
                            : SizedBox(),
                      ],
                    )
                  : SizedBox()),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "ProsesTenderDetailLabelTahapTender".tr, // Tahap Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 14),
              //DETAIL TAHAP TENDER
              for (var index = 1;
                  index < controller.dataTahapTender.length;
                  index++)
                controller.listTahapTenderWidget(index),
              //DETAIL TAHAP TENDER
              CustomText(
                  "ProsesTenderDetailLabelSatuanTender".tr, // Satuan Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),

              CustomText(controller.namaSatuanTender.value,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 80),
            ],
          ),
        ),
      ),
    ));
  }

  Widget secondPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formTwo,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 20,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText("ProsesTenderDetailLabelNamaMuatan".tr, // Nama Muatan
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.namaMuatan.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
            CustomText("ProsesTenderDetailLabelJenisMuatan".tr, // Jenis Muatan
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.jenisMuatan.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection:
                    //KHUSUS SATUAN TENDER VOLUME, DIATAS BERAT
                    controller.satuanTender.value == 3
                        ? VerticalDirection.up
                        : VerticalDirection.down,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("ProsesTenderDetailLabelBerat".tr, // Berat
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8),
                        CustomText(controller.berat.value,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("ProsesTenderDetailLabelVolume".tr, //Volume
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8),
                        CustomText(controller.volume.value,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                      ])
                ]),
            CustomText(
                "ProsesTenderDetailLabelDimensiMuatanKoli"
                    .tr, // Dimensi Muatan / Koli
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.dimensiMuatanKoli.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
            CustomText("ProsesTenderDetailLabelJumlahKoli".tr, // Jumlah Koli
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.jumlahKoli.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 56),
          ],
        ),
      ),
    ));
  }

  Widget thirdPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: controller.formThree,
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //KEBUTUHAN
                  for (var index = 0;
                      index < controller.dataTrukTender.length;
                      index++)
                    controller.kebutuhanTrukWidget(index),
                  //KEBUTUHAN
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 80),
                ],
              ),
            ),
          )),
    );
  }

  Widget fourthPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formFour,
        child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //JUMLAH RUTE
              for (var index = 0;
                  index < controller.dataRuteTender.length;
                  index++)
                controller.satuanTender.value == 2
                    ? controller.unitTrukRuteDitenderkanWidget(index)
                    : controller.satuanTender.value == 1
                        ? controller.beratRuteDitenderkanWidget(index)
                        : controller.volumeRuteDitenderkanWidget(index),
              //JUMLAH RUTE
              controller.satuanTender.value == 2
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24)
                  : SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 14),

              Container(
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 10,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(ListColor.colorBorderTextbox)),
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      controller.satuanTender.value == 1
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      4,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15),
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath + 'ic_berat.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17),
                            )
                          : controller.satuanTender.value == 3
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          15),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          'volume_icon.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          17,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          17),
                                )
                              : controller.satuanTender.value == 2
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          right: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              9),
                                      child: SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              'ic_truck_grey.svg',
                                          color: Color(ListColor.colorBlue),
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              18,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              18),
                                    )
                                  : SizedBox(),
                      Expanded(
                          child: CustomText(
                              'ProsesTenderDetailLabelTotal'.tr +
                                  ' ' +
                                  (controller.satuanTender.value == 2
                                      ? ''
                                      : controller.arrSatuanTender[controller
                                          .satuanTender.value]), //Total
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(ListColor.colorGrey3))),
                      Container(
                          alignment: controller.satuanTender.value == 2
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          constraints: BoxConstraints(
                              minWidth:
                                  GlobalVariable.ratioWidth(Get.context) * 52),
                          child: Obx(
                            () => CustomText(
                                GlobalVariable.formatCurrencyDecimal(controller
                                        .jumlahYangDigunakan
                                        .toString()) +
                                    (controller.satuanTender.value == 2
                                            ? ' Unit'
                                            : controller.satuanTender.value == 1
                                                ? ' Ton'
                                                : ' ' +
                                                    controller
                                                        .satuanVolume.value)
                                        .tr,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                textAlign: controller.satuanTender.value == 2
                                    ? TextAlign.right
                                    : null,
                                color: Colors.black),
                          ))
                    ],
                  )),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 80),
            ])),
      ),
    );
  }

  Widget fifthPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formFive,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(Get.context) * 20,
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  'ProsesTenderDetailLabelPersyaratanKualifikasiLampiran'
                      .tr, //Persyaratan & Informasi/ Lampiran
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(ListColor.colorGrey3)),
              controller.dataKualifikasiProsesTender.length > 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 8),
                          for (var index = 0;
                              index <
                                  controller.dataKualifikasiProsesTender.length;
                              index++)
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      controller.dataKualifikasiProsesTender[
                                          index]['tglDibuat'],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor
                                          .colorTimePersyaratanKualifikasi)),
                                  CustomText(
                                      controller.dataKualifikasiProsesTender[
                                          index]['isi'],
                                      fontSize: 14,
                                      height: 1.4,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  index !=
                                          controller.dataKualifikasiProsesTender
                                                  .length -
                                              1
                                      ? SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                      : SizedBox(),
                                ]),
                        ])
                  : controller.nama_file.value == ""
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              CustomText("-",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ])
                      : SizedBox(),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              controller.nama_file.value != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            controller.cekPeserta =
                                await SharedPreferencesHelper.getHakAkses(
                                    "Lihat Peserta",
                                    denganLoading: true);
                            if (SharedPreferencesHelper.cekAkses(
                                controller.cekPeserta)) {
                              controller.lihat(controller.link.value,
                                  controller.nama_file.value);
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          18,
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: controller.cekLampiran
                                          ? Color(ListColor.colorBlue)
                                          : Color(ListColor.colorAksesDisable)),
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          50)),
                              child: CustomText(
                                  'ProsesTenderDetailLabelLihatLampiran'
                                      .tr, // Lihat
                                  fontSize: 12,
                                  color: controller.cekLampiran
                                      ? Color(ListColor.colorBlue)
                                      : Color(ListColor.colorAksesDisable),
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            controller.cekLampiran =
                                await SharedPreferencesHelper.getHakAkses(
                                    "Lihat dan Download File Persyaratan/Lampiran Proses Tender",
                                    denganLoading: true);
                            if (SharedPreferencesHelper.cekAkses(
                                controller.cekLampiran)) {
                              controller.shareData(controller.link.value, true);
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          11,
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4),
                              decoration: BoxDecoration(
                                  color: controller.cekLampiran
                                      ? Color(ListColor.colorBlue)
                                      : Color(ListColor.colorAksesDisable),
                                  border: Border.all(
                                      color: controller.cekLampiran
                                          ? Color(ListColor.colorBlue)
                                          : Color(ListColor.colorAksesDisable)),
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          50)),
                              child: CustomText(
                                  'InfoPraTenderDetailLabelBagikan'
                                      .tr, // Download
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
              CustomText(
                  'ProsesTenderDetailLabelCatatanTambahan'
                      .tr, // Peringatan Penting
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              controller.dataNote.length > 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          for (var index = 0;
                              index < controller.dataNote.length;
                              index++)
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      controller.dataNote[index]['tglDibuat'],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor
                                          .colorTimePersyaratanKualifikasi)),
                                  CustomText(controller.dataNote[index]['isi'],
                                      fontSize: 14,
                                      height: 1.4,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  index != controller.dataNote.length - 1
                                      ? SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                      : SizedBox()
                                ]),
                        ])
                  : CustomText("-",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
              controller.keteranganFormatDokumenController.text != ""
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 24,
                        ),
                        CustomText(
                            'ProsesTenderDetailLabelFormatDokumen'
                                .tr, // Format Dokumen Penawaran yang Diminta
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8),
                        RichText(
                            text: TextSpan(
                                text: controller
                                    .arrJenisFile[controller.jenisFile.value],
                                style: TextStyle(
                                  fontFamily: "AvenirNext",
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorBlack1B),
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14,
                                ),
                                children: [
                              TextSpan(
                                  text: " (" +
                                      "ProsesTenderDetailLabelFormatNamaFile"
                                          .tr +
                                      " : " +
                                      controller
                                          .keteranganFormatDokumenController
                                          .text +
                                      ")",
                                  style: TextStyle(
                                    fontFamily: "AvenirNext",
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                    color: Color(ListColor.colorBlack1B),
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                  ),
                                  children: [])
                            ]))
                      ],
                    )
                  : SizedBox(),
              // controller.status.value.toString() != "1"
              //     ? SizedBox(
              //         height: GlobalVariable.ratioWidth(Get.context) * 24,
              //       )
              //     : SizedBox(),
              // controller.status.value.toString() != "1"
              //     ? Obx(
              //         () => Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             CustomText(
              //                 'ProsesTenderDetailLabelStatus'
              //                     .tr, // Status Proses Tender
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w700,
              //                 color: Color(ListColor.colorGrey3)),
              //             SizedBox(
              //                 height:
              //                     GlobalVariable.ratioWidth(Get.context) * 8),
              //             CustomText(
              //                 controller.status.value.toString() == "2"
              //                     ? 'ProsesTenderDetailLabelSelesai'
              //                         .tr // Selesai
              //                     : controller.status.value.toString() == "3"
              //                         ? 'ProsesTenderDetailLabelBatal'
              //                             .tr // Batal
              //                         : controller.status.value.toString() ==
              //                                 "4"
              //                             ? 'ProsesTenderDetailLabelBelumDitentukanPemenang'
              //                                 .tr // Belum Ditentukan Pemenang
              //                             : controller.status.value
              //                                         .toString() ==
              //                                     "5"
              //                                 ? 'ProsesTenderDetailLabelTidakAdaPeserta'
              //                                     .tr // Tidak Ada Peserta
              //                                 : "",
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w600,
              //                 color: controller.status.value.toString() == "2"
              //                     ? Color(ListColor.colorLabelSelesai)
              //                     : controller.status.value.toString() == "3"
              //                         ? Color(ListColor.colorLabelBatal)
              //                         : Color(ListColor.colorBlack1B))
              //           ],
              //         ),
              //       )
              //     : SizedBox(),
              // SizedBox(
              //   height: GlobalVariable.ratioWidth(Get.context) * 24,
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     CustomText(
              //         'ProsesTenderDetailLabelJumlahPeserta'
              //             .tr, // Jumlah Peserta
              //         fontSize: 14,
              //         fontWeight: FontWeight.w700,
              //         color: Color(ListColor.colorGrey3)),
              //     SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              //     CustomText(controller.jumlahPeserta.value.toString(),
              //         fontWeight: FontWeight.w600,
              //         fontSize: 14,
              //         color: Colors.black)
              //   ],
              // ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 80),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (controller.time != null) {
      controller.time.cancel();
    }

    Get.back();
  }
}
