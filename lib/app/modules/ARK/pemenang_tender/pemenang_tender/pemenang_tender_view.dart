import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_with_tab2_search_bar.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/pemenang_tender/pemenang_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_with_Tab2.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_below_app_header_theme1_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_filter_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:math' as math;
import 'package:simple_shadow/simple_shadow.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class PemenangTenderView extends GetView<PemenangTenderController> {
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
                    DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        resizeToAvoidBottomInset: false,
                        appBar: AppBarWithTab2SearchBar(
                          titleText: 'PemenangTenderIndexLabelPemenangTender'
                              .tr, // Pemenang Tender
                          hintText: 'PemenangTenderIndexLabelSearchPlaceholder'
                              .tr, //"Cari Tender".tr,
                          onClickSearch: ((controller.jenisTab.value ==
                                              "BelumDiumumkan" &&
                                          controller
                                                  .listProsesTenderBelumDiumumkan
                                                  .length !=
                                              0) ||
                                      controller.isFilterBelumDiumumkan) ||
                                  ((controller.jenisTab.value == "Diumumkan" &&
                                          controller.listProsesTenderDiumumkan
                                                  .length !=
                                              0) ||
                                      controller.isFilterDiumumkan)
                              ? controller.goToSearchPage
                              : null,
                          listTab: [
                            'PemenangTenderIndexLabelTabBelumDiumumkan'
                                .tr, //"BelumDiumumkan".tr,
                            'PemenangTenderIndexLabelTabDiumumkan'
                                .tr, //"Diumumkan".tr
                          ],
                          positionTab: controller.posTab.value,
                          onClickTab: (controller.listProsesTenderBelumDiumumkan
                                              .length ==
                                          0 &&
                                      !controller.isFilterBelumDiumumkan) &&
                                  (controller.listProsesTenderDiumumkan
                                              .length ==
                                          0 &&
                                      !controller.isFilterDiumumkan)
                              ? null
                              : (pos) {
                                  controller.onChangeTab(pos);
                                },
                          listIconWidgetOnRight: [
                            GestureDetector(
                                onTap: () async {
                                  if( controller.jenisTab.value ==
                                              'BelumDiumumkan')
                                  {
                                      controller.cekShareBelumDiumumkan = await SharedPreferencesHelper.getHakAkses(
        "Export List Pemenang Tender Belum Diumukan",denganLoading:true);
                                  }
                                  else
                                  {
controller.cekShareDiumumkan = await SharedPreferencesHelper.getHakAkses(
        "Export List Pemenang Tender Diumumkan",denganLoading:true);
                                  }

                                  if ((controller.cekShareBelumDiumumkan &&
                                          controller.jenisTab.value ==
                                              'BelumDiumumkan') ||
                                      (controller.cekShareDiumumkan &&
                                          controller.jenisTab.value ==
                                              'Diumumkan')) {
                                    //Untuk Share Data Proses Tender
                                    if (((controller.jenisTab.value ==
                                                "BelumDiumumkan" &&
                                            controller
                                                    .listProsesTenderBelumDiumumkan
                                                    .length !=
                                                0)) ||
                                        ((controller.jenisTab.value ==
                                                "Diumumkan" &&
                                            controller.listProsesTenderDiumumkan
                                                    .length !=
                                                0)))
                                      controller.shareListProsesTender();
                                  } else if (controller.jenisTab.value ==
                                      'Diumumkan') {
                                    SharedPreferencesHelper.cekAkses(
                                        controller.cekShareDiumumkan);
                                  } else if (controller.jenisTab.value ==
                                      'BelumDiumumkan') {
                                    SharedPreferencesHelper.cekAkses(
                                        controller.cekShareBelumDiumumkan);
                                  }
                                },
                                child: SvgPicture.asset(
                                    ((controller.jenisTab.value == "BelumDiumumkan" &&
                                                controller.listProsesTenderBelumDiumumkan.length !=
                                                    0 &&
                                                controller
                                                    .cekShareBelumDiumumkan)) ||
                                            ((controller.jenisTab.value == "Diumumkan" &&
                                                controller.listProsesTenderDiumumkan.length !=
                                                    0 &&
                                                controller.cekShareDiumumkan))
                                        ? GlobalVariable.imagePath +
                                            "share_active.svg"
                                        : GlobalVariable.imagePath +
                                            "share_disable.svg",
                                    color: ((controller.jenisTab.value == "BelumDiumumkan" &&
                                                controller.listProsesTenderBelumDiumumkan.length != 0 &&
                                                controller.cekShareBelumDiumumkan)) ||
                                            ((controller.jenisTab.value == "Diumumkan" && controller.listProsesTenderDiumumkan.length != 0 && controller.cekShareDiumumkan))
                                        ? GlobalVariable.tabButtonMainColor
                                        : GlobalVariable.tabDetailAcessoriesDisableColor,
                                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                                    height: GlobalVariable.ratioWidth(Get.context) * 24)),
                            GestureDetector(
                                onTap: () {
                                  if (((controller.jenisTab.value ==
                                              "BelumDiumumkan" &&
                                          controller
                                                  .listProsesTenderBelumDiumumkan
                                                  .length !=
                                              0)) ||
                                      ((controller.jenisTab.value ==
                                              "Diumumkan" &&
                                          controller.listProsesTenderDiumumkan
                                                  .length !=
                                              0)))
                                    controller.showSortingDialog();
                                },
                                child: Obx(() => ((controller.jenisTab.value == "BelumDiumumkan" && controller.listProsesTenderBelumDiumumkan.length != 0)) ||
                                        ((controller.jenisTab.value == "Diumumkan" &&
                                            controller.listProsesTenderDiumumkan.length !=
                                                0))
                                    ? (((controller.sortByBelumDiumumkan.value != "" &&
                                                controller.jenisTab.value ==
                                                    "BelumDiumumkan") ||
                                            ((controller.sortByDiumumkan.value != "" &&
                                                controller.jenisTab.value ==
                                                    "Diumumkan")))
                                        ? SvgPicture.asset(GlobalVariable.imagePath + "ic_sort_blue_on.svg",
                                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                                            height: GlobalVariable.ratioWidth(Get.context) * 24)
                                        : SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg", width: GlobalVariable.ratioWidth(Get.context) * 24, height: GlobalVariable.ratioWidth(Get.context) * 24))
                                    : SvgPicture.asset(GlobalVariable.imagePath + "sorting_disable.svg", color: GlobalVariable.tabDetailAcessoriesDisableColor, width: GlobalVariable.ratioWidth(Get.context) * 24, height: GlobalVariable.ratioWidth(Get.context) * 24)))
                          ],
                        ),
                        backgroundColor: Color(ListColor.colorBackgroundTender),
                        body: TabBarView(
                            physics: controller.listProsesTenderBelumDiumumkan
                                            .length ==
                                        0 &&
                                    controller
                                            .listProsesTenderDiumumkan.length ==
                                        0
                                ? NeverScrollableScrollPhysics()
                                : null,
                            controller: controller.tabController,
                            children: [
                              _listProsesTenderBelumDiumumkan(),
                              _listProsesTenderDiumumkan(),
                            ]),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
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
                                    controller.listProsesTenderDiumumkan[index]
                                        ['labelPeriode'] = false;
                                    controller.listProsesTenderDiumumkan
                                        .refresh();
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
                              !controller.isLoadingData.value &&
                              (!controller.popUpYellow.value &&
                                  controller.jumlahDanger.value == 0 &&
                                  controller.jumlahWarning.value ==
                                      0)) // ni muncul ketika belum ada Proses Tender
                          ? GlobalVariable.ratioWidth(Get.context) * 0
                          : GlobalVariable.ratioWidth(Get.context) * 13,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(ListColor.colorDarkGrey5),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 100),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(ListColor.colorShadow)
                                      .withOpacity(0.05),
                                  blurRadius: 2, //5
                                  spreadRadius: 2,
                                  offset: Offset(0, 2), // 5
                                ),
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          100),
                                ),
                                onTap: () {
                                  if (controller.listProsesTenderBelumDiumumkan
                                              .length !=
                                          0 ||
                                      controller.isFilterBelumDiumumkan)
                                    controller.showFilter();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            2,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            13,
                                  ),
                                  decoration: BoxDecoration(
                                      color: controller.isFilterBelumDiumumkan
                                          ? Color(ListColor
                                              .colorBackgroundFilterTender)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      border: Border.all(
                                          width: 1,
                                          color: controller
                                                  .isFilterBelumDiumumkan
                                              ? Color(ListColor.colorBlue)
                                              : Color(
                                                  ListColor.colorLightGrey7))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                          'PemenangTenderIndexLabelButtonFilter'
                                              .tr, //"Filter",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: controller
                                                  .isFilterBelumDiumumkan
                                              ? Color(ListColor.colorBlue)
                                              : (controller
                                                          .listProsesTenderBelumDiumumkan
                                                          .length ==
                                                      0)
                                                  ? Color(
                                                      ListColor.colorLightGrey2)
                                                  : Color(ListColor
                                                      .colorDarkBlue2)),
                                      SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            7,
                                      ),
                                      SvgPicture.asset(
                                        (controller.listProsesTenderBelumDiumumkan
                                                        .length ==
                                                    0 &&
                                                !controller
                                                    .isFilterBelumDiumumkan)
                                            ? GlobalVariable.imagePath +
                                                "filter_disable.svg"
                                            : GlobalVariable.imagePath +
                                                "filter_active.svg",
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        GestureDetector(
                          child: SvgPicture.asset(
                            controller.popUpYellow.value
                                ? GlobalVariable.imagePath + "info_disable.svg"
                                : GlobalVariable.imagePath + "info_active.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                          ),
                          onTap: () async {
                            await SharedPreferencesHelper
                                .setPemenangTenderYellowPopUp(true);
                            controller.popUpYellow.value = true;
                          },
                        ),
                        Expanded(child: SizedBox()),
                        (controller.listProsesTenderBelumDiumumkan.length > 0 ||
                                    controller.isFilterBelumDiumumkan) &&
                                !controller.isLoadingData.value
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CustomText(
                                    'PemenangTenderIndexLabelTotalBelumDiumumkan' // Total Belum Diumumkan
                                            .tr +
                                        " : ${GlobalVariable.formatCurrencyDecimal(controller.jumlahDataBelumDiumumkan.value.toString()).toString()}"
                                            .tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600))
                            : SizedBox()
                      ],
                    ),
                  ),
                  controller.popUpYellow.value &&
                          controller.listProsesTenderBelumDiumumkan.length ==
                              0 &&
                          !controller.isFilterBelumDiumumkan &&
                          !controller.isLoadingData.value
                      ? controller.firstTimeYellowBox()
                      : SizedBox(),
                  controller.jumlahDanger.value > 0 &&
                          controller.listProsesTenderBelumDiumumkan.length ==
                              0 &&
                          !controller.isFilterBelumDiumumkan &&
                          !controller.isLoadingData.value
                      ? controller.dangerBox()
                      : SizedBox(),
                  controller.jumlahWarning.value > 0 &&
                          controller.listProsesTenderBelumDiumumkan.length ==
                              0 &&
                          !controller.isFilterBelumDiumumkan &&
                          !controller.isLoadingData.value
                      ? controller.warningBox()
                      : SizedBox(),
                  Expanded(child: _showListProsesTenderBelumDiumumkan()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _listProsesTenderDiumumkan() {
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
                      bottom: (controller.listProsesTenderDiumumkan.length ==
                                  0 &&
                              !controller.isLoadingData.value &&
                              !controller.popUpYellow
                                  .value) // ni muncul ketika belum ada Proses Tender
                          ? GlobalVariable.ratioWidth(Get.context) * 0
                          : GlobalVariable.ratioWidth(Get.context) * 13,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(ListColor.colorDarkGrey5),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 100),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(ListColor.colorShadow)
                                      .withOpacity(0.05),
                                  blurRadius: 2, //5
                                  spreadRadius: 2,
                                  offset: Offset(0, 2), // 5
                                ),
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          100),
                                ),
                                onTap: () {
                                  if (controller.listProsesTenderDiumumkan
                                              .length !=
                                          0 ||
                                      controller.isFilterDiumumkan)
                                    controller.showFilter();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            2,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            13,
                                  ),
                                  decoration: BoxDecoration(
                                      color: controller.isFilterDiumumkan
                                          ? Color(ListColor
                                              .colorBackgroundFilterTender)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      border: Border.all(
                                          width: 1,
                                          color: controller.isFilterDiumumkan
                                              ? Color(ListColor.colorBlue)
                                              : Color(
                                                  ListColor.colorLightGrey7))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                          'PemenangTenderIndexLabelButtonFilter'
                                              .tr, //"Filter",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: controller.isFilterDiumumkan
                                              ? Color(ListColor.colorBlue)
                                              : (controller
                                                          .listProsesTenderDiumumkan
                                                          .length ==
                                                      0)
                                                  ? Color(
                                                      ListColor.colorLightGrey2)
                                                  : Color(ListColor
                                                      .colorDarkBlue2)),
                                      SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            7,
                                      ),
                                      SvgPicture.asset(
                                          controller.listProsesTenderDiumumkan
                                                          .length ==
                                                      0 &&
                                                  !controller.isFilterDiumumkan
                                              ? GlobalVariable.imagePath +
                                                  "filter_disable.svg"
                                              : GlobalVariable.imagePath +
                                                  "filter_active.svg",
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 8,
                        ),
                        GestureDetector(
                          child: SvgPicture.asset(
                              controller.popUpYellow.value
                                  ? GlobalVariable.imagePath +
                                      "info_disable.svg"
                                  : GlobalVariable.imagePath +
                                      "info_active.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 24,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24),
                          onTap: () async {
                            await SharedPreferencesHelper
                                .setPemenangTenderYellowPopUp(true);
                            controller.popUpYellow.value = true;
                          },
                        ),
                        Expanded(child: SizedBox()),
                        (controller.listProsesTenderDiumumkan.length > 0 ||
                                    controller.isFilterDiumumkan) &&
                                !controller.isLoadingData.value
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CustomText(
                                    'PemenangTenderIndexLabelTotalPemenangDiumumkan' // Total Pemenang Diumumkan'
                                            .tr +
                                        " : ${GlobalVariable.formatCurrencyDecimal(controller.jumlahDataDiumumkan.value.toString()).toString()}"
                                            .tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  controller.popUpYellow.value &&
                          controller.listProsesTenderDiumumkan.length == 0 &&
                          !controller.isFilterDiumumkan &&
                          !controller.isLoadingData.value
                      ? controller.firstTimeYellowBox()
                      : SizedBox(),
                  Expanded(child: _showListProsesTenderDiumumkan()),
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
          //KALAU TIDAK ADA DATA, TAPI MENGGUNAKAN FILTER
          (controller.listProsesTenderBelumDiumumkan.length == 0 &&
                  !controller.isLoadingData.value &&
                  // !controller.popUpYellow.value &&
                  controller.isFilterBelumDiumumkan)
              ? Center(
                  child: Container(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                        GlobalVariable.imagePath +
                            "ic_pencarian_tidak_ditemukan.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 82,
                        height: GlobalVariable.ratioWidth(Get.context) * 93),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 15),
                    CustomText(
                        'PemenangTenderIndexLabelDataTidakDitemukan'
                                .tr + // Data Tidak Ditemukan
                            '\n' +
                            'PemenangTenderIndexLabelHapusFilter'
                                .tr, // Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('PemenangTenderIndexLabelAtau'.tr, //Atau
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorLightGrey4)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 20),
                    Material(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 20),
                      color: Color(ListColor.colorBlue),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 18),
                          ),
                          onTap: () async {
                            controller.showFilter();
                          },
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      vertical: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20)),
                                  child: Center(
                                    child: CustomText(
                                        'PemenangTenderIndexButtonAturUlangFilter'
                                            .tr, //'Atur Ulang Filter'.tr,
                                        fontSize: 12,
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600),
                                  )))),
                    )
                  ],
                )))
              :
              //KALAU TIDAK ADA DATA
              (controller.listProsesTenderBelumDiumumkan.length == 0 &&
                      !controller.isLoadingData.value &&
                      !controller.popUpYellow.value)
                  ? Center(
                      child: Container(
                          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 83,
                            height: GlobalVariable.ratioWidth(Get.context) * 75,
                            child: Image.asset(GlobalVariable.imagePath +
                                "tidak_ada_data.png")),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 15),
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

  Widget _showListProsesTenderDiumumkan() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value || controller.firstTimeDiumumkan
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          : //KALAU TIDAK ADA DATA, TAPI MENGGUNAKAN FILTER
          (controller.listProsesTenderDiumumkan.length == 0 &&
                  !controller.isLoadingData.value &&
                  // !controller.popUpYellow.value &&
                  controller.isFilterDiumumkan)
              ? Center(
                  child: Container(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                        GlobalVariable.imagePath +
                            "ic_pencarian_tidak_ditemukan.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 82,
                        height: GlobalVariable.ratioWidth(Get.context) * 93),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 15),
                    CustomText(
                        'PemenangTenderIndexLabelDataTidakDitemukan'
                                .tr + // Data Tidak Ditemukan
                            '\n' +
                            'PemenangTenderIndexLabelHapusFilter'
                                .tr, // Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('PemenangTenderIndexLabelAtau'.tr, //Atau
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 20),
                    Material(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 20),
                      color: Color(ListColor.colorBlue),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 18),
                          ),
                          onTap: () async {
                            controller.showFilter();
                          },
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      vertical: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20)),
                                  child: Center(
                                    child: CustomText(
                                        'PemenangTenderIndexButtonAturUlangFilter'
                                            .tr, //'Atur Ulang Filter'.tr,
                                        fontSize: 12,
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600),
                                  )))),
                    )
                  ],
                )))
              : (controller.listProsesTenderDiumumkan.length == 0 &&
                      !controller.isLoadingData.value &&
                      !controller.popUpYellow.value)
                  ? Center(
                      child: Container(
                          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: GlobalVariable.ratioWidth(Get.context) * 83,
                            height: GlobalVariable.ratioWidth(Get.context) * 75,
                            child: Image.asset(GlobalVariable.imagePath +
                                "tidak_ada_data.png")),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 15),
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
                  : _listProsesTenderDiumumkanRefresher()
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
              controller.jenisTab.value,
              controller.filterBelumDiumumkan);
        },
        onRefresh: () async {
          controller.listProsesTenderBelumDiumumkan.clear();
          controller.isLoadingData.value = true;
          controller.countDataBelumDiumumkan.value = 1;
          await controller.getListTender(
              1, controller.jenisTab.value, controller.filterBelumDiumumkan);
        },
        child: _listProsesTenderTileBelumDiumumkan());
  }

  Widget _listProsesTenderDiumumkanRefresher() {
    return SmartRefresher(
        enablePullUp: controller.listProsesTenderDiumumkan.length ==
                controller.jumlahDataDiumumkan.value
            ? false
            : true,
        controller: controller.refreshDiumumkanController,
        onLoading: () async {
          controller.countDataDiumumkan.value += 1;
          await controller.getListTender(controller.countDataDiumumkan.value,
              controller.jenisTab.value, controller.filterDiumumkan);
        },
        onRefresh: () async {
          controller.countDataDiumumkan.value = 1;
          controller.listProsesTenderDiumumkan.clear();
          controller.isLoadingData.value = true;
          await controller.getListTender(
              1, controller.jenisTab.value, controller.filterDiumumkan);
        },
        child: _listProsesTenderTileDiumumkan());
  }

  Widget _listProsesTenderTileBelumDiumumkan() {
    return ListView.builder(
      itemCount: controller.listProsesTenderBelumDiumumkan.length,
      itemBuilder: (content, index) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //KALAU DIA ADA DATA, MUNCUL DISINI, JIKA TIDAK
              index == 0
                  ? controller.popUpYellow.value &&
                          !controller.isLoadingData.value
                      ? controller.firstTimeYellowBox()
                      : SizedBox()
                  : SizedBox(),

              index == 0 &&
                      controller.jumlahDanger.value > 0 &&
                      !controller.isLoadingData.value
                  ? controller.dangerBox()
                  : SizedBox(),

              index == 0 &&
                      controller.jumlahWarning.value > 0 &&
                      !controller.isLoadingData.value
                  ? controller.warningBox()
                  : SizedBox(),

              Obx(() => Stack(
                    children: [
                      Positioned(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () async {
                                controller.cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Tender",denganLoading:true);
                                if (SharedPreferencesHelper.cekAkses(
                                    controller.cekDetail)) {
                                  var data = await GetToPage.toNamed<
                                          DetailProsesTenderController>(
                                      Routes.DETAIL_PROSES_TENDER,
                                      arguments: [
                                        controller
                                                .listProsesTenderBelumDiumumkan[
                                            index]['id'],
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
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                      0,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                      GlobalVariable.ratioWidth(Get.context) *
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
                                                }),
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
                                              left: GlobalVariable.ratioWidth(Get.context) *
                                                  16,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
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
                                                color: ((controller
                                                                .cekPilihPemenang &&
                                                            !controller
                                                                        .listProsesTenderBelumDiumumkan[
                                                                    index][
                                                                'sudahAdaPemenang']) ||
                                                        (controller
                                                                .cekLihatPemenang &&
                                                            controller.listProsesTenderBelumDiumumkan[
                                                                    index][
                                                                'sudahAdaPemenang']))
                                                    ? !controller.listProsesTenderBelumDiumumkan[
                                                                index]
                                                            ['sudahAdaPemenang']
                                                        ? Color(
                                                            ListColor.colorBlue)
                                                        : Colors.white
                                                    : Color(ListColor
                                                        .colorAksesDisable),
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
                                                      controller.getDetail(
                                                          controller
                                                                  .listProsesTenderBelumDiumumkan[
                                                              index]['id'],
                                                          (!controller.listProsesTenderBelumDiumumkan[
                                                                      index][
                                                                  'sudahAdaPemenang']
                                                              ? 'PILIH'
                                                              : 'LIHAT'));
                                                    },
                                                    child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    24,
                                                            vertical: GlobalVariable.ratioWidth(Get
                                                                    .context) *
                                                                6),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: GlobalVariable.ratioWidth(Get.context) *
                                                                    1,
                                                                color: ((controller.cekPilihPemenang && !controller.listProsesTenderBelumDiumumkan[index]['sudahAdaPemenang']) ||
                                                                        (controller.cekLihatPemenang &&
                                                                            controller.listProsesTenderBelumDiumumkan[index]['sudahAdaPemenang']))
                                                                    ? Color(ListColor.colorBlue)
                                                                    : Color(ListColor.colorAksesDisable)),
                                                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                                                        child: Center(
                                                          child: CustomText(
                                                              (!controller.listProsesTenderBelumDiumumkan[
                                                                              index][
                                                                          'sudahAdaPemenang']
                                                                      ? 'PemenangTenderIndexLabelPilihPemenang' //'Pilih Pemenang'.tr,
                                                                      : 'PemenangTenderIndexLabelLihatPemenang') //'Lihat Pemenang'.tr,
                                                                  .tr,
                                                              fontSize: 12,
                                                              color: !controller
                                                                              .listProsesTenderBelumDiumumkan[
                                                                          index]
                                                                      [
                                                                      'sudahAdaPemenang']
                                                                  ? Colors.white
                                                                  : controller
                                                                          .cekLihatPemenang
                                                                      ? Color(ListColor
                                                                          .colorBlue)
                                                                      : Color(ListColor
                                                                          .colorAksesDisable),
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

  Widget _listProsesTenderTileDiumumkan() {
    return ListView.builder(
      itemCount: controller.listProsesTenderDiumumkan.length,
      itemBuilder: (content, index) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              index == 0
                  ? controller.popUpYellow.value &&
                          !controller.isLoadingData.value
                      ? controller.firstTimeYellowBox()
                      : SizedBox()
                  : SizedBox(),
              Stack(children: [
                Positioned(
                    child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () async {
                      controller.cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Tender",denganLoading:true);
                      if (SharedPreferencesHelper.cekAkses(
                          controller.cekDetail)) {
                        var data = await GetToPage.toNamed<
                                DetailProsesTenderController>(
                            Routes.DETAIL_PROSES_TENDER,
                            arguments: [
                              controller.listProsesTenderDiumumkan[index]['id'],
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
                              GlobalVariable.ratioWidth(Get.context) * 12)),
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
                                  GlobalVariable.ratioWidth(Get.context) * 9,
                                  GlobalVariable.ratioWidth(Get.context) * 13,
                                  GlobalVariable.ratioWidth(Get.context) * 11),
                              decoration: BoxDecoration(
                                  color: Color(ListColor.colorHeaderListTender),
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
                                          controller.listProsesTenderDiumumkan[
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
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            22,
                                  ),
                                  Container(
                                    child: CustomText(
                                        controller.listProsesTenderDiumumkan[
                                                index]['tanggalDiputuskan'] +
                                            "\n" +
                                            controller
                                                    .listProsesTenderDiumumkan[
                                                index]['jamDiputuskan'] +
                                            " " +
                                            controller
                                                    .listProsesTenderDiumumkan[
                                                index]['zonaWaktu'],
                                        fontSize: 10,
                                        height: 1.3,
                                        textAlign: TextAlign.right,
                                        color: Color(ListColor.colorBlue),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            5,
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
                                              color: Color(
                                                  ListColor.colorIconVert),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24)),
                                      onTap: () {
                                        controller.opsi(
                                            controller
                                                    .listProsesTenderDiumumkan[
                                                index]['id'],
                                            controller
                                                    .listProsesTenderDiumumkan[
                                                index]['sudahAdaPemenang']);
                                      }),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          14,
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
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
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "kode.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          14,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          14),
                                              SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          20),
                                              Expanded(
                                                  child: Container(
                                                      child: CustomText(
                                                controller
                                                        .listProsesTenderDiumumkan[
                                                    index]['kode'],
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                //
                                                color:
                                                    Color(ListColor.colorGrey4),
                                              )))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              controller
                                                      .listProsesTenderDiumumkan[
                                                  index]['labelPeriode'] = true;
                                              print(controller
                                                      .listProsesTenderDiumumkan[
                                                  index]['labelPeriode']);
                                              controller
                                                  .listProsesTenderDiumumkan
                                                  .refresh();
                                            },
                                            child: Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SvgPicture.asset(
                                                      GlobalVariable.imagePath +
                                                          "periode_pengumuman.svg",
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
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
                                                          child: CustomText(
                                                    controller.listProsesTenderDiumumkan[
                                                            index]
                                                        ['periodePengumuman'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    //
                                                    color: Color(
                                                        ListColor.colorGrey4),
                                                  )))
                                                ],
                                              ),
                                            )),
                                        SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "rute.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          14,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          14),
                                              SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          20),
                                              Expanded(
                                                  child: CustomText(
                                                controller
                                                        .listProsesTenderDiumumkan[
                                                    index]['rute'],
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                //
                                                color:
                                                    Color(ListColor.colorGrey4),
                                              ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "muatan.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                              SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          20),
                                              Expanded(
                                                  child: CustomText(
                                                GlobalVariable.formatMuatan(
                                                    controller
                                                            .listProsesTenderDiumumkan[
                                                        index]['muatan']),
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                //
                                                color:
                                                    Color(ListColor.colorGrey4),
                                              ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "pemenang_blue.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          14,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          14),
                                              SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          20),
                                              Expanded(
                                                  child: CustomText(
                                                controller
                                                    .listProsesTenderDiumumkan[
                                                        index]['pemenang']
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                //
                                                color:
                                                    Color(ListColor.colorGrey4),
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
                            Container(
                                padding: EdgeInsets.only(
                                    left: GlobalVariable.ratioWidth(Get.context) *
                                        16,
                                    right: GlobalVariable.ratioWidth(Get.context) *
                                        16,
                                    top: GlobalVariable.ratioWidth(Get.context) *
                                        7.5,
                                    bottom: GlobalVariable.ratioWidth(Get.context) *
                                        7),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            GlobalVariable.ratioWidth(Get.context) *
                                                10),
                                        bottomRight:
                                            Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
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
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    18),
                                          ),
                                          onTap: () async {
                                            controller.getDetail(
                                                controller
                                                        .listProsesTenderDiumumkan[
                                                    index]['id'],
                                                'LIHAT');
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24,
                                                  vertical: GlobalVariable
                                                          .ratioWidth(
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
                    controller.listProsesTenderDiumumkan[index]['labelPeriode']
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
}
