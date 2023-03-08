import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/create_info_pra_tender/create_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/detail_info_pra_tender/detail_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/info_pra_tender/info_pra_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_with_Tab2.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/global_variable.dart' as gv;

class InfoPraTenderView extends GetView<InfoPraTenderController> {
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
                          onClose: () async {
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              Get.back();
                            });
                          },
                          hintText: 'InfoPraTenderIndexLabelSearchPlaceholder'
                              .tr, //"Cari Info Pra Tender".tr,
                          onClickSearch: ((controller.jenisTab.value ==
                                              "Aktif" &&
                                          controller.listInfoPraTenderAktif
                                                  .length !=
                                              0) ||
                                      controller.isFilterAktif) ||
                                  ((controller.jenisTab.value == "History" &&
                                          controller.listInfoPraTenderHistory
                                                  .length !=
                                              0) ||
                                      controller.isFilterHistory)
                              ? controller.goToSearchPage
                              : null,
                          listTab: [
                            'InfoPraTenderIndexLabelTabAktif'.tr, //"Aktif".tr,
                            'InfoPraTenderIndexLabelTabHistory'
                                .tr, //"History".tr
                          ],
                          positionTab: controller.posTab.value,
                          onClickTab:
                              (controller.listInfoPraTenderAktif.length == 0 &&
                                          !controller.isFilterAktif) &&
                                      (controller.listInfoPraTenderHistory
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
                                  if(controller.jenisTab.value ==
                                              'Aktif')
                                              {
                                   controller.cekShareAktif = await SharedPreferencesHelper.getHakAkses(
        "Export List Info Pra Tender Aktif",denganLoading:true);
                                              }
                                              else
                                              {
   controller. cekShareHistory = await SharedPreferencesHelper.getHakAkses(
        "Export List Info Pra Tender History",denganLoading:true);
                                              }

                                  if ((controller.cekShareAktif &&
                                          controller.jenisTab.value ==
                                              'Aktif') ||
                                      (controller.cekShareHistory &&
                                          controller.jenisTab.value ==
                                              'History')) {
                                    //Untuk Share Data Info Pra Tender
                                    if (((controller.jenisTab.value ==
                                                "Aktif" &&
                                            controller.listInfoPraTenderAktif
                                                    .length !=
                                                0)) ||
                                        ((controller.jenisTab.value ==
                                                "History" &&
                                            controller.listInfoPraTenderHistory
                                                    .length !=
                                                0)))
                                      controller.shareListInfoPraTender();
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
                                    ((controller.jenisTab.value == "Aktif" && controller.listInfoPraTenderAktif.length != 0 && controller.cekShareAktif)) ||
                                            ((controller.jenisTab.value == "History" &&
                                                controller
                                                        .listInfoPraTenderHistory
                                                        .length !=
                                                    0 &&
                                                controller.cekShareHistory))
                                        ? GlobalVariable.imagePath +
                                            "share_active.svg"
                                        : GlobalVariable.imagePath +
                                            "share_disable.svg",
                                    color: ((controller.jenisTab.value == "Aktif" &&
                                                controller.listInfoPraTenderAktif.length !=
                                                    0 &&
                                                controller.cekShareAktif)) ||
                                            ((controller.jenisTab.value == "History" &&
                                                controller.listInfoPraTenderHistory.length != 0 &&
                                                controller.cekShareHistory))
                                        ? GlobalVariable.tabButtonMainColor
                                        : GlobalVariable.tabDetailAcessoriesDisableColor,
                                    width: GlobalVariable.ratioWidth(Get.context) * 24,
                                    height: GlobalVariable.ratioWidth(Get.context) * 24)),
                            GestureDetector(
                                onTap: () {
                                  if (((controller.jenisTab.value == "Aktif" &&
                                          controller.listInfoPraTenderAktif
                                                  .length !=
                                              0)) ||
                                      ((controller.jenisTab.value ==
                                              "History" &&
                                          controller.listInfoPraTenderHistory
                                                  .length !=
                                              0)))
                                    controller.showSortingDialog();
                                },
                                child: Obx(() => ((controller.jenisTab.value == "Aktif" &&
                                            controller.listInfoPraTenderAktif.length !=
                                                0)) ||
                                        ((controller.jenisTab.value == "History" &&
                                            controller.listInfoPraTenderHistory.length !=
                                                0))
                                    ? (((controller.sortByAktif.value != "" && controller.jenisTab.value == "Aktif") ||
                                            ((controller.sortByHistory.value != "" &&
                                                controller.jenisTab.value ==
                                                    "History")))
                                        ? SvgPicture.asset(GlobalVariable.imagePath + "ic_sort_blue_on.svg",
                                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                                            height: GlobalVariable.ratioWidth(Get.context) * 24)
                                        : SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg", width: GlobalVariable.ratioWidth(Get.context) * 24, height: GlobalVariable.ratioWidth(Get.context) * 24))
                                    : SvgPicture.asset(GlobalVariable.imagePath + "sorting_disable.svg", color: GlobalVariable.tabDetailAcessoriesDisableColor, width: GlobalVariable.ratioWidth(Get.context) * 24, height: GlobalVariable.ratioWidth(Get.context) * 24)))
                          ],
                        ),
                        backgroundColor: Color(ListColor.colorBackgroundTender),
                        body: TabBarView(
                            physics:
                                controller.listInfoPraTenderAktif.length == 0 &&
                                        controller.listInfoPraTenderHistory
                                                .length ==
                                            0
                                    ? NeverScrollableScrollPhysics()
                                    : null,
                            controller: controller.tabController,
                            children: [
                              _listInfoPraTenderAktif(),
                              _listInfoPraTenderHistory(),
                            ]),
                        bottomNavigationBar: BottomAppBarMuat(
                          centerItemText: '',
                          color: Colors.grey,
                          backgroundColor: Colors.white,
                          selectedColor:
                              Color(ListColor.colorSelectedBottomMenu),
                          notchedShape: CircularNotchedRectangle(),
                          height: GlobalVariable.ratioWidth(Get.context) * 55,
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
        await SharedPreferencesHelper.getHakAkses("Buat Info Pra Tender",denganLoading:true);
                              if (SharedPreferencesHelper.cekAkses(
                                  controller.cekTambah)) {
                                if (controller.showFirstTime.value) {
                                  await SharedPreferencesHelper
                                      .setInfoPraTenderPertamaKali(false);
                                  controller.showFirstTime.value = false;
                                }
                                var data = await GetToPage.toNamed<
                                    CreateInfoPraTenderController>(
                                  Routes.CREATE_INFO_PRA_TENDER,
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
                            controller.listInfoPraTenderAktif.length == 0 &&
                            controller.listInfoPraTenderHistory.length == 0 &&
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
                      'InfoPraTenderIndexLabelTeksPopUpButtonTambah'
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

  Widget _listInfoPraTenderAktif() {
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
                      bottom: (controller.listInfoPraTenderAktif.length == 0 &&
                              !controller.isLoadingData.value &&
                              !controller.popUpYellow
                                  .value) // ni muncul ketika belum ada info pra tender
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
                                  if (controller
                                              .listInfoPraTenderAktif.length !=
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
                                          'InfoPraTenderIndexLabelButtonFilter'
                                              .tr, //"Filter",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: controller.isFilterAktif
                                              ? Color(ListColor.colorBlue)
                                              : (controller
                                                          .listInfoPraTenderAktif
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
                                        (controller.listInfoPraTenderAktif
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
                                    (controller.listInfoPraTenderAktif.length ==
                                            0 &&
                                        controller.isFilterAktif)
                                ? GlobalVariable.imagePath + "info_disable.svg"
                                : GlobalVariable.imagePath + "info_active.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                          ),
                          onTap: () async {
                            await SharedPreferencesHelper
                                .setInfoPraTenderYellowPopUp(true);
                            controller.popUpYellow.value = true;
                          },
                        ),
                        Expanded(child: SizedBox()),
                        (controller.listInfoPraTenderAktif.length > 0 ||
                                    controller.isFilterAktif) &&
                                !controller.isLoadingData.value
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CustomText(
                                    'InfoPraTenderIndexLabelTotalInfoPraTender'
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
                          controller.listInfoPraTenderAktif.length == 0 &&
                          !controller.isFilterAktif &&
                          !controller.isLoadingData.value
                      ? controller.firstTimeYellowBox()
                      : SizedBox(),
                  Expanded(child: _showListInfoPraTenderAktif()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _listInfoPraTenderHistory() {
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
                      bottom: (controller.listInfoPraTenderHistory.length ==
                                  0 &&
                              !controller.isLoadingData.value &&
                              !controller.popUpYellow
                                  .value) // ni muncul ketika belum ada info pra tender
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
                                  if (controller.listInfoPraTenderHistory
                                              .length !=
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
                                          'InfoPraTenderIndexLabelButtonFilter'
                                              .tr, //"Filter",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: controller.isFilterHistory
                                              ? Color(ListColor.colorBlue)
                                              : (controller
                                                          .listInfoPraTenderHistory
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
                                          controller.listInfoPraTenderHistory
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
                                      (controller.listInfoPraTenderHistory
                                                  .length ==
                                              0 &&
                                          !controller.isFilterHistory)
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
                                .setInfoPraTenderYellowPopUp(true);
                            controller.popUpYellow.value = true;
                          },
                        ),
                        Expanded(child: SizedBox()),
                        (controller.listInfoPraTenderHistory.length > 0 ||
                                    controller.isFilterHistory) &&
                                !controller.isLoadingData.value
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CustomText(
                                    'InfoPraTenderIndexLabelTotalInfoPraTender'
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
                          controller.listInfoPraTenderHistory.length == 0 &&
                          !controller.isFilterHistory &&
                          !controller.isLoadingData.value
                      ? controller.firstTimeYellowBox()
                      : SizedBox(),
                  Expanded(child: _showListInfoPraTenderHistory()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showListInfoPraTenderAktif() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value || controller.firstTimeAktif
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA, TAPI MENGGUNAKAN FILTER
          (controller.listInfoPraTenderAktif.length == 0 &&
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
                        'InfoPraTenderIndexLabelDataTidakDitemukan'
                                .tr + // Data Tidak Ditemukan
                            '\n' +
                            'InfoPraTenderIndexLabelHapusFilter'
                                .tr, // Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('InfoPraTenderIndexLabelAtau'.tr, //Atau
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
                                        'InfoPraTenderIndexButtonAturUlangFilter'
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
              (controller.listInfoPraTenderAktif.length == 0 &&
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
                            'InfoPraTenderIndexLabelTeksBelumAdaData'.tr +
                                '\n' +
                                'TenderMenuIndexLabelJudulMenuInfoPraTender'
                                    .tr, //"Anda belum membuat Info Pra Tender".tr,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.2,
                            color: Color(ListColor.colorGrey3))
                      ],
                    )))
                  : _listInfoPraTenderAktifRefresher()
    ]);
  }

  Widget _showListInfoPraTenderHistory() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value || controller.firstTimeHistory
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          : //KALAU TIDAK ADA DATA, TAPI MENGGUNAKAN FILTER
          (controller.listInfoPraTenderHistory.length == 0 &&
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
                        'InfoPraTenderIndexLabelDataTidakDitemukan'
                                .tr + // Data Tidak Ditemukan
                            '\n' +
                            'InfoPraTenderIndexLabelHapusFilter'
                                .tr, // Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('InfoPraTenderIndexLabelAtau'.tr, //Atau
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
                                        'InfoPraTenderIndexButtonAturUlangFilter'
                                            .tr, //'Atur Ulang Filter'.tr,
                                        fontSize: 12,
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600),
                                  )))),
                    )
                  ],
                )))
              : (controller.listInfoPraTenderHistory.length == 0 &&
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
                            'InfoPraTenderIndexLabelTeksBelumAdaData'.tr +
                                '\n' +
                                'TenderMenuIndexLabelJudulMenuInfoPraTender'
                                    .tr, //"Anda belum membuat Info Pra Tender".tr,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.2,
                            color: Color(ListColor.colorGrey3))
                      ],
                    )))
                  : _listInfoPraTenderHistoryRefresher()
    ]);
  }

  Widget _listInfoPraTenderAktifRefresher() {
    return SmartRefresher(
        enablePullUp: controller.listInfoPraTenderAktif.length ==
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
          controller.listInfoPraTenderAktif.clear();
          controller.isLoadingData.value = true;
          controller.countDataAktif.value = 1;
          await controller.getListTender(
              1, controller.jenisTab.value, controller.filterAktif);
        },
        child: _listInfoPraTenderTileAktif());
  }

  Widget _listInfoPraTenderHistoryRefresher() {
    return SmartRefresher(
        enablePullUp: controller.listInfoPraTenderHistory.length ==
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
          controller.listInfoPraTenderHistory.clear();
          controller.isLoadingData.value = true;
          controller.countDataHistory.value = 1;
          await controller.getListTender(
              1, controller.jenisTab.value, controller.filterHistory);
        },
        child: _listInfoPraTenderTileHistory());
  }

  Widget _listInfoPraTenderTileAktif() {
    return ListView.builder(
      itemCount: controller.listInfoPraTenderAktif.length,
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
              GestureDetector(
                onTap: () async {
                  controller.cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Pra Tender",denganLoading:true);
                  if (SharedPreferencesHelper.cekAkses(controller.cekDetail)) {
                    var data =
                        await GetToPage.toNamed<DetailInfoPraTenderController>(
                            Routes.DETAIL_INFO_PRA_TENDER,
                            arguments: [
                          controller.listInfoPraTenderAktif[index]['id'],
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
                                      controller.listInfoPraTenderAktif[index]
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
                                    controller.listInfoPraTenderAktif[index]
                                            ['tanggalDibuat'] +
                                        "\n" +
                                        controller.listInfoPraTenderAktif[index]
                                            ['jamDibuat'] +
                                        " " +
                                        controller.listInfoPraTenderAktif[index]
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
                                        .listInfoPraTenderAktif[index]['id']);
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
                                            controller.listInfoPraTenderAktif[
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
                                            controller.listInfoPraTenderAktif[
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
                                                        .listInfoPraTenderAktif[
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
                                            controller.listInfoPraTenderAktif[
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
                                    CustomText(""),
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
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Pra Tender",denganLoading:true);
                                        if (SharedPreferencesHelper.cekAkses(
                                            controller.cekDetail)) {
                                          var data = await GetToPage.toNamed<
                                                  DetailInfoPraTenderController>(
                                              Routes.DETAIL_INFO_PRA_TENDER,
                                              arguments: [
                                                controller
                                                        .listInfoPraTenderAktif[
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          20)),
                                          child: Center(
                                            child: CustomText(
                                                'InfoPraTenderIndexLabelButtonDetail'
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
              index == controller.listInfoPraTenderAktif.length - 1
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 16)
                  : SizedBox(),
            ]);
      },
    );
  }

  Widget _listInfoPraTenderTileHistory() {
    return ListView.builder(
      itemCount: controller.listInfoPraTenderHistory.length,
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
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Pra Tender",denganLoading:true);
                  if (SharedPreferencesHelper.cekAkses(controller.cekDetail)) {
                    var data =
                        await GetToPage.toNamed<DetailInfoPraTenderController>(
                            Routes.DETAIL_INFO_PRA_TENDER,
                            arguments: [
                          controller.listInfoPraTenderHistory[index]['id'],
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
                                      controller.listInfoPraTenderHistory[index]
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
                                    controller.listInfoPraTenderHistory[index]
                                            ['tanggalDibuat'] +
                                        "\n" +
                                        controller
                                                .listInfoPraTenderHistory[index]
                                            ['jamDibuat'] +
                                        " " +
                                        controller
                                                .listInfoPraTenderHistory[index]
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
                                        .listInfoPraTenderHistory[index]['id']);
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
                                            controller.listInfoPraTenderHistory[
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
                                            controller.listInfoPraTenderHistory[
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
                                            GlobalVariable.formatMuatan(controller
                                                    .listInfoPraTenderHistory[
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
                                            controller.listInfoPraTenderHistory[
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
                                    controller.listInfoPraTenderHistory[index]
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
                                            child: CustomText("InfoPraTenderIndexLabelSelesai".tr, // Selesai
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(ListColor.colorLabelSelesai)))
                                        : controller.listInfoPraTenderHistory[index]['status'].toString() == "3"
                                            ? Container(
                                                padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 4, horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                                                decoration: BoxDecoration(color: Color(ListColor.colorBackgroundLabelBatal), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                child: CustomText("InfoPraTenderIndexLabelBatal".tr, // Batal
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(ListColor.colorLabelBatal)))
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
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Pra Tender",denganLoading:true);
                                        if (SharedPreferencesHelper.cekAkses(
                                            controller.cekDetail)) {
                                          var data = await GetToPage.toNamed<
                                                  DetailInfoPraTenderController>(
                                              Routes.DETAIL_INFO_PRA_TENDER,
                                              arguments: [
                                                controller
                                                        .listInfoPraTenderHistory[
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
                                                'InfoPraTenderIndexLabelButtonDetail'
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
              index == controller.listInfoPraTenderHistory.length - 1
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 16)
                  : SizedBox(),
            ]);
      },
    );
  }
}
