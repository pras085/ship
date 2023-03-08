import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/create_proses_tender/create_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/proses_tender/proses_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_with_Tab2.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_below_app_header_theme1_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_filter_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:math' as math;
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/global_variable.dart' as gv;
import 'package:simple_shadow/simple_shadow.dart';

class ProsesTenderView extends GetView<ProsesTenderController> {
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
                        appBar: AppBarWithTab2(
                          hintText: 'ProsesTenderIndexLabelSearchPlaceholder'
                              .tr, //"Cari Proses Tender".tr,
                          onClickSearch: ((controller.jenisTab.value ==
                                              "Aktif" &&
                                          controller.listProsesTenderAktif
                                                  .length !=
                                              0) ||
                                      controller.isFilterAktif) ||
                                  ((controller.jenisTab.value == "History" &&
                                          controller.listProsesTenderHistory
                                                  .length !=
                                              0) ||
                                      controller.isFilterHistory)
                              ? controller.goToSearchPage
                              : null,
                          listTab: [
                            'ProsesTenderIndexLabelTabAktif'.tr, //"Aktif".tr,
                            'ProsesTenderIndexLabelTabHistory'
                                .tr, //"History".tr
                          ],
                          positionTab: controller.posTab.value,
                          onClickTab:
                              (controller.listProsesTenderAktif.length == 0 &&
                                          !controller.isFilterAktif) &&
                                      (controller.listProsesTenderHistory
                                                  .length ==
                                              0 &&
                                          !controller.isFilterHistory)
                                  ? null
                                  : (pos) {
                                      controller.onChangeTab(pos);
                                    },
                          listIconWidgetOnRight: [
                            GestureDetector(
                                onTap: () async {
                                  if (controller.jenisTab.value == 'Aktif') {
                                    controller.cekShareAktif =
                                        await SharedPreferencesHelper.getHakAkses(
                                            "Export List Proses Tender Aktif",
                                            denganLoading: true);
                                  } else {
                                    controller.cekShareHistory =
                                        await SharedPreferencesHelper.getHakAkses(
                                            "Export List Proses Tender History",
                                            denganLoading: true);
                                  }

                                  if ((controller.cekShareAktif &&
                                          controller.jenisTab.value ==
                                              'Aktif') ||
                                      (controller.cekShareHistory &&
                                          controller.jenisTab.value ==
                                              'History')) {
                                    //Untuk Share Data Proses Tender
                                    if (((controller.jenisTab.value ==
                                                "Aktif" &&
                                            controller.listProsesTenderAktif
                                                    .length !=
                                                0)) ||
                                        ((controller.jenisTab.value ==
                                                "History" &&
                                            controller.listProsesTenderHistory
                                                    .length !=
                                                0)))
                                      controller.shareListProsesTender();
                                  } else if (controller.jenisTab.value ==
                                      'Aktif') {
                                    SharedPreferencesHelper.cekAkses(
                                        controller.cekShareAktif);
                                  } else if (controller.jenisTab.value ==
                                      'History') {
                                    SharedPreferencesHelper.cekAkses(
                                        controller.cekShareHistory);
                                  }
                                },
                                child: SvgPicture.asset(
                                    ((controller.jenisTab.value == "Aktif" && controller.listProsesTenderAktif.length != 0 && controller.cekShareAktif)) ||
                                            ((controller.jenisTab.value == "History" &&
                                                controller
                                                        .listProsesTenderHistory
                                                        .length !=
                                                    0 &&
                                                controller.cekShareHistory))
                                        ? GlobalVariable.imagePath +
                                            "share_active.svg"
                                        : GlobalVariable.imagePath +
                                            "share_disable.svg",
                                    color: ((controller.jenisTab.value == "Aktif" &&
                                                controller.listProsesTenderAktif.length !=
                                                    0 &&
                                                controller.cekShareAktif)) ||
                                            ((controller.jenisTab.value == "History" &&
                                                controller.listProsesTenderHistory.length != 0 &&
                                                controller.cekShareHistory))
                                        ? GlobalVariable.tabButtonMainColor
                                        : GlobalVariable.tabDetailAcessoriesDisableColor,
                                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                                    height: GlobalVariable.ratioWidth(Get.context) * 24)),
                            GestureDetector(
                                onTap: () {
                                  if (((controller.jenisTab.value == "Aktif" &&
                                          controller.listProsesTenderAktif
                                                  .length !=
                                              0)) ||
                                      ((controller.jenisTab.value ==
                                              "History" &&
                                          controller.listProsesTenderHistory
                                                  .length !=
                                              0)))
                                    controller.showSortingDialog();
                                },
                                child: Obx(() => ((controller.jenisTab.value == "Aktif" &&
                                            controller.listProsesTenderAktif.length !=
                                                0)) ||
                                        ((controller.jenisTab.value == "History" &&
                                            controller.listProsesTenderHistory.length !=
                                                0))
                                    ? (((controller.sortByAktif.value != "" && controller.jenisTab.value == "Aktif") ||
                                            ((controller.sortByHistory.value != "" &&
                                                controller.jenisTab.value ==
                                                    "History")))
                                        ? SvgPicture.asset(
                                            GlobalVariable.imagePath + "ic_sort_blue_on.svg",
                                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                                            height: GlobalVariable.ratioWidth(Get.context) * 24)
                                        : SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg", width: GlobalVariable.ratioWidth(Get.context) * 24, height: GlobalVariable.ratioWidth(Get.context) * 24))
                                    : SvgPicture.asset(GlobalVariable.imagePath + "sorting_disable.svg", color: GlobalVariable.tabDetailAcessoriesDisableColor, width: GlobalVariable.ratioWidth(Get.context) * 24, height: GlobalVariable.ratioWidth(Get.context) * 24)))
                          ],
                        ),
                        backgroundColor: Color(ListColor.colorBackgroundTender),
                        body: TabBarView(
                            physics: controller.listProsesTenderAktif.length ==
                                        0 &&
                                    controller.listProsesTenderHistory.length ==
                                        0
                                ? NeverScrollableScrollPhysics()
                                : null,
                            controller: controller.tabController,
                            children: [
                              _listProsesTenderAktif(),
                              _listProsesTenderHistory(),
                            ]),
                        bottomNavigationBar: BottomAppBarMuat(
                          centerItemText: '',
                          color: Colors.grey,
                          backgroundColor: Colors.white,
                          selectedColor:
                              Color(ListColor.colorSelectedBottomMenu),
                          notchedShape: CircularNotchedRectangle(),
                          onTabSelected: (index) async {
                            switch (index) {
                              case 0:
                                {
                                  // Get.toNamed(Routes.INBOX);
                                  await Chat.init(GlobalVariable.docID, gv.GlobalVariable.fcmToken);
                                  Chat.toInbox();
                                  break;
                                }
                              case 1:
                                {
                                  Get.toNamed(Routes.PROFIL);
                                  break;
                                }
                            }
                          },
                          height: GlobalVariable.ratioWidth(Get.context) * 55,
                          items: [
                            BottomAppBarItemModel(
                                iconName: 'message_menu_icon.svg', text: ''),
                            BottomAppBarItemModel(
                                iconName: 'user_menu_icon.svg', text: ''),
                          ],
                          iconSize: 40,
                        ),
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.centerDocked,
                        floatingActionButton: Container(
                          width: GlobalVariable.ratioWidth(context) * 62,
                          height: GlobalVariable.ratioWidth(context) * 62,
                          decoration: BoxDecoration(),
                          child: FloatingActionButton(
                            backgroundColor: controller.cekTambah
                                ? Color(ListColor.colorOrangeButtonPlus)
                                : Color(ListColor.colorAksesDisable),
                            onPressed: () async {
                              controller.cekTambah =
                                  await SharedPreferencesHelper.getHakAkses(
                                      "Buat Proses Tender",
                                      denganLoading: true);
                              if (SharedPreferencesHelper.cekAkses(
                                  controller.cekTambah)) {
                                if (controller.showFirstTime.value) {
                                  await SharedPreferencesHelper
                                      .setProsesTenderPertamaKali(false);
                                  controller.showFirstTime.value = false;
                                }
                                var data = await GetToPage.toNamed<
                                    CreateProsesTenderController>(
                                  Routes.CREATE_PROSES_TENDER,
                                );
                                if (data != null) {
                                  controller.tabController.animateTo(0);
                                  controller.reset();
                                }
                              }
                            },
                            child: Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: GlobalVariable.ratioWidth(context) * 35,
                            ),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        90.0)),
                                side: BorderSide(
                                    color: Colors.white, width: 4.0)),
                          ),
                        ),
                      ),
                    ),
                    controller.showFirstTime.value &&
                            controller.listProsesTenderAktif.length == 0 &&
                            controller.listProsesTenderHistory.length == 0 &&
                            !controller.isLoadingData.value
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: _messageBottomNav,
                          )
                        : SizedBox()
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget get _messageBottomNav {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          margin: EdgeInsets.fromLTRB(
              0, 0, 0, GlobalVariable.ratioWidth(Get.context) * 90),
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
                        color: Colors.black,
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
                width: GlobalVariable.ratioWidth(Get.context) * 148,
                // height: GlobalVariable.ratioWidth(Get.context) * 59,
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 13,
                    left: GlobalVariable.ratioWidth(Get.context) * 8,
                    right: GlobalVariable.ratioWidth(Get.context) * 8,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(ListColor.colorDarkGrey5),
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 9),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: CustomText(
                      'ProsesTenderIndexLabelTeksPopUpButtonTambah'
                          .tr, //"Tekan tombol di bawah ini untuk memulai",
                      fontSize: 12,
                      height: 1.3,
                      fontWeight: FontWeight.w500,
                      color: Color(ListColor.color2),
                      textAlign: TextAlign.center),
                ))
          ])),
    ]);
  }

  Widget _periodeTenderLabelWidget(int index) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 7,
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
                width: GlobalVariable.ratioWidth(Get.context) * 148,
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
                                    controller.listProsesTenderAktif[index]
                                        ['labelPeriode'] = false;
                                    controller.listProsesTenderAktif.refresh();
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
                                  'ProsesTenderIndexLabelPeriodeTender'
                                      .tr, //"Periode Tender", ProsesTenderIndexLabelPeriodeTender
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

  Widget _listProsesTenderAktif() {
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
                      bottom: (controller.listProsesTenderAktif.length == 0 &&
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
                                  if (controller.listProsesTenderAktif.length !=
                                          0 ||
                                      controller.isFilterAktif)
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
                                      color: controller.isFilterAktif
                                          ? Color(ListColor
                                              .colorBackgroundFilterTender)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      border: Border.all(
                                          width: 1,
                                          color: controller.isFilterAktif
                                              ? Color(ListColor.colorBlue)
                                              : Color(
                                                  ListColor.colorLightGrey7))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                          'ProsesTenderIndexLabelButtonFilter'
                                              .tr, //"Filter",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: controller.isFilterAktif
                                              ? Color(ListColor.colorBlue)
                                              : (controller
                                                          .listProsesTenderAktif
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
                                        (controller.listProsesTenderAktif
                                                        .length ==
                                                    0 &&
                                                !controller.isFilterAktif)
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
                            controller.popUpYellow.value ||
                                    (controller.listProsesTenderAktif.length ==
                                            0 &&
                                        controller.isFilterAktif)
                                ? GlobalVariable.imagePath + "info_disable.svg"
                                : GlobalVariable.imagePath + "info_active.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                          ),
                          onTap: () async {
                            await SharedPreferencesHelper
                                .setProsesTenderYellowPopUp(true);
                            controller.popUpYellow.value = true;
                          },
                        ),
                        Expanded(child: SizedBox()),
                        (controller.listProsesTenderAktif.length > 0 ||
                                    controller.isFilterAktif) &&
                                !controller.isLoadingData.value
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CustomText(
                                    'ProsesTenderIndexLabelTotalProsesTender'
                                            .tr +
                                        " : ${GlobalVariable.formatCurrencyDecimal(controller.jumlahDataAktif.value.toString()).toString()}"
                                            .tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600))
                            : SizedBox()
                      ],
                    ),
                  ),
                  controller.popUpYellow.value &&
                          controller.listProsesTenderAktif.length == 0 &&
                          !controller.isFilterAktif &&
                          !controller.isLoadingData.value
                      ? controller.firstTimeYellowBox()
                      : SizedBox(),
                  Expanded(child: _showListProsesTenderAktif()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _listProsesTenderHistory() {
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
                      bottom: (controller.listProsesTenderHistory.length == 0 &&
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
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: Offset(0, 5),
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
                                  if (controller
                                              .listProsesTenderHistory.length !=
                                          0 ||
                                      controller.isFilterHistory)
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
                                      color: controller.isFilterHistory
                                          ? Color(ListColor
                                              .colorBackgroundFilterTender)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      border: Border.all(
                                          width: 1,
                                          color: controller.isFilterHistory
                                              ? Color(ListColor.colorBlue)
                                              : Color(
                                                  ListColor.colorLightGrey7))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                          'ProsesTenderIndexLabelButtonFilter'
                                              .tr, //"Filter",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: controller.isFilterHistory
                                              ? Color(ListColor.colorBlue)
                                              : (controller
                                                          .listProsesTenderHistory
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
                                          controller.listProsesTenderHistory
                                                          .length ==
                                                      0 &&
                                                  !controller.isFilterHistory
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
                              controller.popUpYellow.value ||
                                      (controller.listProsesTenderHistory
                                                  .length ==
                                              0 &&
                                          controller.isFilterHistory)
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
                                .setProsesTenderYellowPopUp(true);
                            controller.popUpYellow.value = true;
                          },
                        ),
                        Expanded(child: SizedBox()),
                        (controller.listProsesTenderHistory.length > 0 ||
                                    controller.isFilterHistory) &&
                                !controller.isLoadingData.value
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CustomText(
                                    'ProsesTenderIndexLabelTotalProsesTender'
                                            .tr +
                                        " : ${GlobalVariable.formatCurrencyDecimal(controller.jumlahDataHistory.value.toString()).toString()}"
                                            .tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  controller.popUpYellow.value &&
                          controller.listProsesTenderHistory.length == 0 &&
                          !controller.isFilterHistory &&
                          !controller.isLoadingData.value
                      ? controller.firstTimeYellowBox()
                      : SizedBox(),
                  Expanded(child: _showListProsesTenderHistory()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showListProsesTenderAktif() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value || controller.firstTimeAktif
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA, TAPI MENGGUNAKAN FILTER
          (controller.listProsesTenderAktif.length == 0 &&
                  !controller.isLoadingData.value &&
                  // !controller.popUpYellow.value &&
                  controller.isFilterAktif)
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
                        'ProsesTenderIndexLabelDataTidakDitemukan'
                                .tr + // Data Tidak Ditemukan
                            '\n' +
                            'ProsesTenderIndexLabelHapusFilter'
                                .tr, // Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('ProsesTenderIndexLabelAtau'.tr, //Atau
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
                                        'ProsesTenderIndexButtonAturUlangFilter'
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
              (controller.listProsesTenderAktif.length == 0 &&
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
                            'ProsesTenderIndexLabelTeksBelumAdaData'.tr +
                                '\n' +
                                'TenderMenuIndexLabelJudulMenuProsesTender'
                                    .tr, //"Belum ada Proses Tender".tr,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.2,
                            color: Color(ListColor.colorGrey3))
                      ],
                    )))
                  : _listProsesTenderAktifRefresher()
    ]);
  }

  Widget _showListProsesTenderHistory() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value || controller.firstTimeHistory
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          : //KALAU TIDAK ADA DATA, TAPI MENGGUNAKAN FILTER
          (controller.listProsesTenderHistory.length == 0 &&
                  !controller.isLoadingData.value &&
                  // !controller.popUpYellow.value &&
                  controller.isFilterHistory)
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
                        'ProsesTenderIndexLabelDataTidakDitemukan'
                                .tr + // Data Tidak Ditemukan
                            '\n' +
                            'ProsesTenderIndexLabelHapusFilter'
                                .tr, // Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('ProsesTenderIndexLabelAtau'.tr, //Atau
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
                                        'ProsesTenderIndexButtonAturUlangFilter'
                                            .tr, //'Atur Ulang Filter'.tr,
                                        fontSize: 12,
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600),
                                  )))),
                    )
                  ],
                )))
              : (controller.listProsesTenderHistory.length == 0 &&
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
                            'ProsesTenderIndexLabelTeksBelumAdaData'.tr +
                                '\n' +
                                'TenderMenuIndexLabelJudulMenuProsesTender'
                                    .tr, //"Belum ada Proses Tender".tr,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.2,
                            color: Color(ListColor.colorGrey3))
                      ],
                    )))
                  : _listProsesTenderHistoryRefresher()
    ]);
  }

  Widget _listProsesTenderAktifRefresher() {
    return SmartRefresher(
        enablePullUp: controller.listProsesTenderAktif.length ==
                controller.jumlahDataAktif.value
            ? false
            : true,
        controller: controller.refreshAktifController,
        onLoading: () async {
          controller.countDataAktif.value += 1;
          await controller.getListTender(controller.countDataAktif.value,
              controller.jenisTab.value, controller.filterAktif);
        },
        onRefresh: () async {
          controller.listProsesTenderAktif.clear();
          controller.isLoadingData.value = true;
          controller.countDataAktif.value = 1;
          await controller.getListTender(
              1, controller.jenisTab.value, controller.filterAktif);
        },
        child: _listProsesTenderTileAktif());
  }

  Widget _listProsesTenderHistoryRefresher() {
    return SmartRefresher(
        enablePullUp: controller.listProsesTenderHistory.length ==
                controller.jumlahDataHistory.value
            ? false
            : true,
        controller: controller.refreshHistoryController,
        onLoading: () async {
          controller.countDataHistory.value += 1;
          await controller.getListTender(controller.countDataHistory.value,
              controller.jenisTab.value, controller.filterHistory);
        },
        onRefresh: () async {
          controller.countDataHistory.value = 1;
          controller.listProsesTenderHistory.clear();
          controller.isLoadingData.value = true;
          await controller.getListTender(
              1, controller.jenisTab.value, controller.filterHistory);
        },
        child: _listProsesTenderTileHistory());
  }

  Widget _listProsesTenderTileAktif() {
    return ListView.builder(
      itemCount: controller.listProsesTenderAktif.length,
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

              Obx(() => Stack(
                    children: [
                      Positioned(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () async {
                                controller.cekDetail =
                                    await SharedPreferencesHelper.getHakAkses(
                                        "Lihat Detail Tender",
                                        denganLoading: true);
                                if (SharedPreferencesHelper.cekAkses(
                                    controller.cekDetail)) {
                                  var data = await GetToPage.toNamed<
                                          DetailProsesTenderController>(
                                      Routes.DETAIL_PROSES_TENDER,
                                      arguments: [
                                        controller.listProsesTenderAktif[index]
                                            ['id'],
                                        controller.jenisTab.value
                                      ]);
                                  print('LIST AKTIF');
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
                                                CustomText(
                                                    controller
                                                            .listProsesTenderAktif[
                                                        index]['judul'],
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                  controller.listProsesTenderAktif[
                                                              index]
                                                          ['tanggalDibuat'] +
                                                      "\n" +
                                                      controller
                                                              .listProsesTenderAktif[
                                                          index]['jamDibuat'] +
                                                      " " +
                                                      controller
                                                              .listProsesTenderAktif[
                                                          index]['zonaWaktu'],
                                                  fontSize: 10,
                                                  height: 1.3,
                                                  textAlign: TextAlign.right,
                                                  color: Color(
                                                      ListColor.colorBlue),
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
                                                  controller.opsi(controller
                                                          .listProsesTenderAktif[
                                                      index]['id']);
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
                                                                  .listProsesTenderAktif[
                                                              index]['kode'],
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
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller.listProsesTenderAktif[
                                                                    index][
                                                                'labelPeriode'] =
                                                            true;
                                                        print(controller
                                                                .listProsesTenderAktif[
                                                            index]['labelPeriode']);
                                                        controller
                                                            .listProsesTenderAktif
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
                                                                    "periode.svg",
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
                                                              controller.listProsesTenderAktif[
                                                                      index]
                                                                  ['periode'],
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
                                                      )),
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
                                                                  .listProsesTenderAktif[
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
                                                                  controller.listProsesTenderAktif[
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
                                                                "peserta.svg",
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
                                                          GlobalVariable.formatCurrencyDecimal(controller
                                                                      .listProsesTenderAktif[
                                                                          index]
                                                                          [
                                                                          'peserta']
                                                                      .toString())
                                                                  .toString() +
                                                              " Peserta",
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
                                              Expanded(child: CustomText('')),
                                              Material(
                                                borderRadius: BorderRadius
                                                    .circular(GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        20),
                                                color: controller.cekDetail
                                                    ? Color(ListColor.colorBlue)
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
                                                      controller.cekDetail =
                                                          await SharedPreferencesHelper
                                                              .getHakAkses(
                                                                  "Lihat Detail Tender",
                                                                  denganLoading:
                                                                      true);
                                                      if (SharedPreferencesHelper
                                                          .cekAkses(controller
                                                              .cekDetail)) {
                                                        var data = await GetToPage
                                                            .toNamed<
                                                                    DetailProsesTenderController>(
                                                                Routes
                                                                    .DETAIL_PROSES_TENDER,
                                                                arguments: [
                                                              controller
                                                                      .listProsesTenderAktif[
                                                                  index]['id'],
                                                              controller
                                                                  .jenisTab
                                                                  .value
                                                            ]);
                                                        print('LIST AKTIF');
                                                        print(data);
                                                        if (data == null) {
                                                          controller
                                                              .refreshAll();
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GlobalVariable.ratioWidth(Get
                                                                        .context) *
                                                                    24,
                                                            vertical: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                7),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        20)),
                                                        child: Center(
                                                          child: CustomText(
                                                              'ProsesTenderIndexLabelButtonDetail'
                                                                  .tr, //'Detail'.tr,
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
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
                      Obx(() => controller.listProsesTenderAktif[index]
                              ['labelPeriode']
                          ? Positioned.fill(
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: _periodeTenderLabelWidget(index)),
                            )
                          : SizedBox(
                              child: Container(color: Colors.red),
                            ))
                    ],
                  )),
              index == controller.listProsesTenderAktif.length - 1
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 16)
                  : SizedBox(),
            ]);
      },
    );
  }

  Widget _listProsesTenderTileHistory() {
    return ListView.builder(
      itemCount: controller.listProsesTenderHistory.length,
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
              GestureDetector(
                onTap: () async {
                  controller.cekDetail =
                      await SharedPreferencesHelper.getHakAkses(
                          "Lihat Detail Tender",
                          denganLoading: true);
                  if (SharedPreferencesHelper.cekAkses(controller.cekDetail)) {
                    var data =
                        await GetToPage.toNamed<DetailProsesTenderController>(
                            Routes.DETAIL_PROSES_TENDER,
                            arguments: [
                          controller.listProsesTenderHistory[index]['id'],
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
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10),
                                  topRight: Radius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10))),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Container(
                                child: Wrap(children: [
                                  CustomText(
                                      controller.listProsesTenderHistory[index]
                                          ['judul'],
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
                                    GlobalVariable.ratioWidth(Get.context) * 22,
                              ),
                              Container(
                                child: CustomText(
                                    controller.listProsesTenderHistory[index]
                                            ['tanggalDibuat'] +
                                        "\n" +
                                        controller
                                                .listProsesTenderHistory[index]
                                            ['jamDibuat'] +
                                        " " +
                                        controller
                                                .listProsesTenderHistory[index]
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
                                        .listProsesTenderHistory[index]['id']);
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
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "kode.svg",
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
                                            controller.listProsesTenderHistory[
                                                index]['kode'],
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
                                          12,
                                    ),
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
                                            controller.listProsesTenderHistory[
                                                index]['rute'],
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
                                          12,
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
                                                controller
                                                        .listProsesTenderHistory[
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
                                          12,
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
                                            controller.listProsesTenderHistory[
                                                index]['transporter'],
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
                                          12,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "peserta.svg",
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
                                            GlobalVariable.formatCurrencyDecimal(
                                                        controller
                                                            .listProsesTenderHistory[
                                                                index]
                                                                ['peserta']
                                                            .toString())
                                                    .toString() +
                                                " Peserta",
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
                                    bottomLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                    bottomRight: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10))),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    controller.listProsesTenderHistory[index]
                                                    ['status']
                                                .toString() ==
                                            "2"
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    4,
                                                horizontal:
                                                    GlobalVariable.ratioWidth(Get.context) *
                                                        8),
                                            decoration: BoxDecoration(
                                                color: Color(ListColor
                                                    .colorBackgroundLabelSelesai),
                                                borderRadius: BorderRadius.circular(
                                                    GlobalVariable.ratioWidth(Get.context) * 6)),
                                            child: CustomText("ProsesTenderIndexLabelSelesai".tr, // Selesai
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(ListColor.colorLabelSelesai)))
                                        : controller.listProsesTenderHistory[index]['status'].toString() == "3"
                                            ? Container(
                                                padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                decoration: BoxDecoration(color: Color(ListColor.colorBackgroundLabelBatal), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                child: CustomText("ProsesTenderIndexLabelBatal".tr, // Batal
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(ListColor.colorLabelBatal)))
                                            : controller.listProsesTenderHistory[index]['status'].toString() == "4"
                                                ? Container(
                                                    padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                    decoration: BoxDecoration(color: Color(ListColor.colorBackgroundLabelBelumDitentukanPemenang), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                    child: CustomText("ProsesTenderIndexLabelBelumDitentukanPemenang".tr, // Belum Ditentukan Pemenang
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(ListColor.colorLabelBelumDitentukanPemenang)))
                                                : controller.listProsesTenderHistory[index]['status'].toString() == "5"
                                                    ? Container(
                                                        padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                        decoration: BoxDecoration(color: Color(ListColor.colorBackgroundLabelTidakAdaPeserta), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                        child: CustomText("ProsesTenderIndexLabelTidakAdaPeserta".tr, // Tidak Ada Peserta
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(ListColor.colorLabelTidakAdaPeserta)))
                                                    : SizedBox()
                                  ],
                                )),
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20),
                                  color: controller.cekDetail
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
                                        controller.cekDetail =
                                            await SharedPreferencesHelper
                                                .getHakAkses(
                                                    "Lihat Detail Tender",
                                                    denganLoading: true);
                                        if (SharedPreferencesHelper.cekAkses(
                                            controller.cekDetail)) {
                                          var data = await GetToPage.toNamed<
                                                  DetailProsesTenderController>(
                                              Routes.DETAIL_PROSES_TENDER,
                                              arguments: [
                                                controller
                                                        .listProsesTenderHistory[
                                                    index]['id'],
                                                controller.jenisTab.value
                                              ]);

                                          if (data == null) {
                                            controller.refreshAll();
                                          }
                                        }
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
                                              border: Border.all(
                                                  color: Color(
                                                      ListColor.colorBlue)),
                                              borderRadius: BorderRadius.circular(
                                                  GlobalVariable.ratioWidth(Get.context) * 20)),
                                          child: Center(
                                            child: CustomText(
                                                'ProsesTenderIndexLabelButtonDetail'
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
              ),
              index == controller.listProsesTenderHistory.length - 1
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 16)
                  : SizedBox(),
            ]);
      },
    );
  }
}
