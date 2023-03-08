import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_with_search_bar.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:flutter/services.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_tentukan_pemenang_tender/list_tentukan_pemenang_tender_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListTentukanPemenangTenderView
    extends GetView<ListTentukanPemenangTenderController> {
  String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(statusBarColor: Color(ListColor.colorBlue)));
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });

        return null;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Color(ListColor.colorBlue),
            statusBarIconBrightness: Brightness.light),
        child: Container(
          child: SafeArea(
            child: Obx(() => Stack(
                  children: [
                    Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBarWithSearchBar(
                        titleText: 'PemenangTenderIndexLabelPemenangTender'
                            .tr, // Pemenang Tender
                        hintText: 'PemenangTenderIndexLabelSearchPlaceholder'
                            .tr, //"Cari Tender".tr,
                        onClickSearch: ((controller
                                    .listProsesTenderBelumDiumumkan.length !=
                                0))
                            ? controller.goToSearchPage
                            : null,
                        listIconWidgetOnRight: [
                          // GestureDetector(
                          //     onTap: () {
                          //       //Untuk Share Data Proses Tender
                          //       if (((controller.listProsesTenderBelumDiumumkan
                          //               .length !=
                          //           0))) controller.shareListProsesTender();
                          //     },
                          //     child: SvgPicture.asset(
                          //         ((controller.listProsesTenderBelumDiumumkan
                          //                     .length !=
                          //                 0))
                          //             ? GlobalVariable.imagePath+"share_active.svg"
                          //             : GlobalVariable.imagePath+"share_disable.svg",
                          //         width:
                          //             GlobalVariable.ratioWidth(Get.context) *
                          //                 24,
                          //         height:
                          //             GlobalVariable.ratioWidth(Get.context) *
                          //                 24)),
                          GestureDetector(
                              onTap: () {
                                if (((controller.listProsesTenderBelumDiumumkan
                                        .length !=
                                    0))) controller.showSortingDialog();
                              },
                              child: Obx(() => ((controller.listProsesTenderBelumDiumumkan.length != 0))
                                  ? (((controller.sortByBelumDiumumkan.value != ""))
                                      ? SvgPicture.asset(GlobalVariable.imagePath + "ic_sort_blue_on.svg",
                                          width: GlobalVariable.ratioWidth(Get.context) *
                                              24,
                                          height: GlobalVariable.ratioWidth(Get.context) *
                                              24)
                                      : SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg",
                                          width: GlobalVariable.ratioWidth(Get.context) *
                                              24,
                                          height: GlobalVariable.ratioWidth(Get.context) *
                                              24))
                                  : SvgPicture.asset(
                                      GlobalVariable.imagePath + "sorting_disable.svg",
                                      color: GlobalVariable.tabDetailAcessoriesDisableColor,
                                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                                      height: GlobalVariable.ratioWidth(Get.context) * 24)))
                        ],
                      ),
                      backgroundColor: Color(ListColor.colorBackgroundTender),
                      body: _listProsesTenderBelumDiumumkan(),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _listProsesTenderBelumDiumumkan() {
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
                      top: GlobalVariable.ratioWidth(Get.context) * 13,
                      bottom: (controller
                                      .listProsesTenderBelumDiumumkan.length ==
                                  0 &&
                              !controller.isLoadingData
                                  .value) // ni muncul ketika belum ada Proses Tender
                          ? GlobalVariable.ratioWidth(Get.context) * 0
                          : GlobalVariable.ratioWidth(Get.context) * 13,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: (controller.listProsesTenderBelumDiumumkan
                                                .length >
                                            0 ||
                                        controller.isFilterBelumDiumumkan) &&
                                    !controller.isLoadingData.value
                                ? CustomText(
                                    (controller.jenisTender == 'BERAKHIR'
                                            ? 'PemenangTenderIndexLabelTenderYangTelah' // Tender yang Telah atau Berakhir Hari Ini
                                            : 'PemenangTenderIndexLabelTenderYangBerakhirDalam3') // Tender yang berakhir dalam 3 hari
                                        .tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)
                                : SizedBox()),
                        (controller.listProsesTenderBelumDiumumkan.length > 0 ||
                                    controller.isFilterBelumDiumumkan) &&
                                !controller.isLoadingData.value
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CustomText(
                                    'PemenangTenderIndexLabelTotal' // Total
                                            .tr +
                                        " : ${controller.jumlahDataBelumDiumumkan.value}"
                                            .tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600))
                            : SizedBox()
                      ],
                    ),
                  ),
                  Expanded(child: _showListProsesTenderBelumDiumumkan()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showListProsesTenderBelumDiumumkan() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value || controller.firstTimeBelumDiumumkan
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :

          //KALAU TIDAK ADA DATA
          (controller.listProsesTenderBelumDiumumkan.length == 0 &&
                  !controller.isLoadingData.value)
              ? Center(
                  child: Container(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 83,
                        height: GlobalVariable.ratioWidth(Get.context) * 75,
                        child: Image.asset(
                            GlobalVariable.imagePath + "tidak_ada_data.png")),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 15),
                    CustomText(
                        'PemenangTenderIndexLabelTeksBelumAdaPemenang'.tr +
                            '\n' +
                            'PemenangTenderIndexLabelYangBelumDiumumkan'
                                .tr, //"Belum ada Pemenang yang Belum Diumumkan".tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3))
                  ],
                )))
              : _listProsesTenderBelumDiumumkanRefresher()
    ]);
  }

  Widget _listProsesTenderBelumDiumumkanRefresher() {
    return SmartRefresher(
        enablePullUp: controller.listProsesTenderBelumDiumumkan.length ==
                controller.jumlahDataBelumDiumumkan.value
            ? false
            : true,
        controller: controller.refreshBelumDiumumkanController,
        onLoading: () async {
          controller.countDataBelumDiumumkan.value += 1;
          await controller.getListTender(
              controller.countDataBelumDiumumkan.value,
              "BelumDiumumkan",
              controller.filterBelumDiumumkan);
        },
        onRefresh: () async {
          controller.listProsesTenderBelumDiumumkan.clear();
          controller.isLoadingData.value = true;
          controller.countDataBelumDiumumkan.value = 1;
          await controller.getListTender(
              1, "BelumDiumumkan", controller.filterBelumDiumumkan);
        },
        child: _listProsesTenderTileBelumDiumumkan());
  }

  Widget _listProsesTenderTileBelumDiumumkan() {
    return ListView.builder(
      itemCount: controller.listProsesTenderBelumDiumumkan.length,
      itemBuilder: (content, index) {
        return Column(
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
                                var data = await GetToPage.toNamed<
                                        DetailProsesTenderController>(
                                    Routes.DETAIL_PROSES_TENDER,
                                    arguments: [
                                      controller.listProsesTenderBelumDiumumkan[
                                          index]['id'],
                                      "BelumDiumumkan"
                                    ]);
                                print('LIST BELUMDIUMUMKAN');
                                print(data);
                                if (data == null) {
                                  controller.refreshAll();
                                }
                              },
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                      0,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
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
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                                topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: Wrap(children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomText(
                                                        controller
                                                                .listProsesTenderBelumDiumumkan[
                                                            index]['judul'],
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        wrapSpace: true,
                                                        height: 1.4),
                                                    SizedBox(
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            2),
                                                    CustomText(
                                                      controller
                                                              .listProsesTenderBelumDiumumkan[
                                                          index]['kode'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      //
                                                      color: Color(
                                                          ListColor.colorBlue),
                                                    )
                                                  ],
                                                )
                                              ]),
                                            )),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  22,
                                            ),
                                            controller.cekUmumkan != controller.cekDetail?
                                            GestureDetector(
                                                child: Container(
                                                    padding: EdgeInsets.only(
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
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            24)),
                                                onTap: () {
                                                  controller.opsi(
                                                      controller.listProsesTenderBelumDiumumkan[
                                                          index]['id'],
                                                      controller.listProsesTenderBelumDiumumkan[
                                                              index]
                                                          ['sudahAdaPemenang']);
                                                })
                                                :
                                                SizedBox(   width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            24),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: GlobalVariable.ratioWidth(
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
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
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
                                                            child: Container(
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                              CustomText(
                                                                "PemenangTenderIndexLabelPeriodeSeleksi"
                                                                    .tr, //Periode Seleksi
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                //
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey4),
                                                              ),
                                                              SizedBox(
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      3),
                                                              CustomText(
                                                                controller.listProsesTenderBelumDiumumkan[
                                                                        index][
                                                                    'periodeSeleksi'],
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
                                                                        .colorBlack),
                                                              )
                                                            ])))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
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
                                                            child: Container(
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                              CustomText(
                                                                "PemenangTenderIndexLabelPeriodePengumuman"
                                                                    .tr, //Periode Pengumuman
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                //
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey4),
                                                              ),
                                                              SizedBox(
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      3),
                                                              CustomText(
                                                                controller.listProsesTenderBelumDiumumkan[
                                                                        index][
                                                                    'periodePengumuman'],
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
                                                                        .colorBlack),
                                                              )
                                                            ])))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: GlobalVariable
                                                            .ratioWidth(
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
                                                          controller
                                                                  .listProsesTenderBelumDiumumkan[
                                                              index]['rute'],
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
                                                  ),
                                                  SizedBox(
                                                    height: GlobalVariable
                                                            .ratioWidth(
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
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                12),
                                                        SizedBox(
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20),
                                                        Expanded(
                                                            child: CustomText(
                                                          GlobalVariable
                                                              .formatMuatan(
                                                                  controller.listProsesTenderBelumDiumumkan[
                                                                          index]
                                                                      [
                                                                      'muatan']),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          //
                                                          color: Color(ListColor
                                                              .colorGrey4),
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: GlobalVariable
                                                            .ratioWidth(
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
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                14),
                                                        SizedBox(
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20),
                                                        Expanded(
                                                            child: CustomText(
                                                          controller
                                                              .listProsesTenderBelumDiumumkan[
                                                                  index]
                                                                  ['pemenang']
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          //
                                                          color: Color(ListColor
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
                                        color: Color(ListColor.colorLightGrey2),
                                      ),
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              top:
                                                  GlobalVariable.ratioWidth(Get.context) *
                                                      7.5,
                                              bottom:
                                                  GlobalVariable.ratioWidth(Get.context) *
                                                      7),
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
                                                  // BERAKHIR HARI INI
                                                  int.parse(controller
                                                              .listProsesTenderBelumDiumumkan[index]
                                                                  ['sisaHari']
                                                              .toString()) ==
                                                          0
                                                      ? Container(
                                                          padding: EdgeInsets.symmetric(
                                                              vertical:
                                                                  GlobalVariable.ratioWidth(Get.context) *
                                                                      4,
                                                              horizontal:
                                                                  GlobalVariable.ratioWidth(Get.context) *
                                                                      8),
                                                          decoration: BoxDecoration(
                                                              color: Color(ListColor
                                                                  .colorBackgroundLabelBatal),
                                                              borderRadius:
                                                                  BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                          child: Row(children: [
                                                            CustomText(
                                                                "PemenangTenderIndexLabelBerakhirHariIni"
                                                                        .tr +
                                                                    " ", // Berakhir hari ini
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorRed)),
                                                            Image.asset(
                                                              GlobalVariable
                                                                      .imagePath +
                                                                  "warning_icon.png",
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  14,
                                                            ),
                                                          ]))
                                                      : int.parse(controller.listProsesTenderBelumDiumumkan[index]['sisaHari'].toString()) < 0
                                                          ?

                                                          // TELAH BERAKHIR
                                                          Container(
                                                              padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                              decoration: BoxDecoration(color: Color(ListColor.colorBackgroundLabelBatal), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                              child: Row(children: [
                                                                CustomText(
                                                                    "PemenangTenderIndexLabelTelahBerakhir"
                                                                            .tr +
                                                                        " ", // Telah Berakhir
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorRed)),
                                                                Image.asset(
                                                                  GlobalVariable
                                                                          .imagePath +
                                                                      "warning_icon.png",
                                                                  width: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      14,
                                                                ),
                                                              ]))
                                                          : int.parse(controller.listProsesTenderBelumDiumumkan[index]['sisaHari'].toString()) < 4
                                                              ?

                                                              // BERAKHIR DALAM 3 HARI
                                                              Container(
                                                                  padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                                  decoration: BoxDecoration(color: Color(ListColor.colorWarningTile), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                                  child: Row(children: [
                                                                    CustomText(
                                                                        "PemenangTenderIndexLabelBerakhirDalam".tr +
                                                                            " " +
                                                                            controller.listProsesTenderBelumDiumumkan[index][
                                                                                'sisaHari'] +
                                                                            " " +
                                                                            "PemenangTenderIndexLabelHari"
                                                                                .tr, // Berakhir Dalam 3 Hari
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            ListColor.colorBackgroundLabelTidakAdaPeserta)),
                                                                  ]))
                                                              : int.parse(controller.listProsesTenderBelumDiumumkan[index]['sisaHari'].toString()) < 8
                                                                  ?
                                                                  // BERAKHIR DALAM 7 HARI
                                                                  Container(
                                                                      padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                                      decoration: BoxDecoration(color: Color(ListColor.colorLightGrey12), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                                      child: Row(children: [
                                                                        CustomText(
                                                                            "PemenangTenderIndexLabelBerakhirDalam".tr +
                                                                                " " +
                                                                                controller.listProsesTenderBelumDiumumkan[index]['sisaHari'].toString() +
                                                                                " " +
                                                                                "PemenangTenderIndexLabelHari".tr, // Berakhir Dalam 3 Hari
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
                                                            .ratioWidth(
                                                                Get.context) *
                                                        20),
                                                color: controller.cekPilihPemenang
                                                    ? Color(ListColor.colorBlue)
                                                    : Color(ListColor.colorAksesDisable),
                                                child: InkWell(
                                                    customBorder:
                                                        RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              18),
                                                    ),
                                                    onTap: () async {
                                                      controller.peserta(controller
                                                              .listProsesTenderBelumDiumumkan[
                                                          index]['id']);
                                                    },
                                                    child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    24,
                                                            vertical:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    6),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        1,
                                                                color: 
                                                                controller.cekPilihPemenang?
                                                                Color(
                                                                    ListColor
                                                                        .colorBlue)
                                                                        :
                                                                          Color(
                                                                    ListColor
                                                                        .colorAksesDisable)),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    GlobalVariable.ratioWidth(Get.context) * 20)),
                                                        child: Center(
                                                          child: CustomText(
                                                              ('PemenangTenderIndexLabelPilihPemenang') //'Pilih Pemenang'.tr,
                                                                  .tr,
                                                              fontSize: 12,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
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
            ]);
      },
    );
  }
}
