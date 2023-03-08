import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_lelang_muatan/ZO_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_banner_widget.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';

class ZoLelangMuatanView extends GetView<ZoLelangMuatanController> {
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
                child: Stack(alignment: Alignment.bottomCenter, children: [
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
                                Obx(
                                  () => CustomTextField(
                                      key: ValueKey("CariLelangMuatan"),
                                      context: Get.context,
                                      readOnly: true,
                                      onTap: () {
                                        if (!controller
                                            .firsttimelelangMuatan.value) {
                                          controller.searchLelangMuatan(
                                              controller.isSearchAktifOrHistory
                                                  .value);
                                        }
                                      },
                                      onChanged: (value) {
                                        controller.addTextSearchCity(
                                            value,
                                            controller
                                                .isSearchAktifOrHistory.value);
                                      },
                                      controller: controller
                                          .searchTextEditingController.value,
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) {
                                        controller.onSubmitSearch(controller
                                            .isSearchAktifOrHistory.value);
                                      },
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
                                            "LelangMuatTabAktifTabAktifLabelTitleSearchCargoBid"
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
                                              BorderRadius.circular(10),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey7),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey7),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      )),
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
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Obx(() => controller
                                          .isShowClearSearch.value
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.onClearSearch(controller
                                                .isSearchAktifOrHistory.value);
                                          },
                                          child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.close_rounded,
                                                color:
                                                    Color(ListColor.colorGrey3),
                                                size: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    28,
                                              )),
                                        )
                                      : SizedBox.shrink()),
                                ),
                              ],
                            ),
                          ),
                          Obx(() => Padding(
                              padding: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      12,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8),
                              child: GestureDetector(
                                onTap: () {
                                  if (!controller.firsttimelelangMuatan.value) {
                                    if (controller
                                            .isSearchAktifOrHistory.value ==
                                        "aktif") {
                                      if (controller.listcountDataLelangmuatan
                                              .value.length >
                                          0) {
                                        // _share();
                                        Share.share(
                                            controller.linkShareBid.value);
                                      }
                                    } else {
                                      if (controller.listDataLelangMuatanHistory
                                              .value.length >
                                          0) {
                                        // _share();
                                        Share.share(
                                            controller.linkShareBid.value);
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                    child: controller
                                            .firsttimelelangMuatan.value
                                        ? SvgPicture.asset(
                                            "assets/ic_share_disable.svg",
                                            width: GlobalVariable.ratioFontSize(
                                                    context) *
                                                20,
                                            height:
                                                GlobalVariable.ratioFontSize(
                                                        context) *
                                                    20,
                                          )
                                        : controller.listcountDataLelangmuatan
                                                    .value.length >
                                                0
                                            ? SvgPicture.asset(
                                                "assets/ic_share.svg",
                                                width: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    20,
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    20,
                                              )
                                            : SvgPicture.asset(
                                                "assets/ic_share_disable.svg",
                                                width: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    20,
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    20,
                                              )

                                    // Icon(
                                    //   Icons.share_outlined,
                                    //   color: controller
                                    //           .firsttimelelangMuatan.value
                                    //       ? Color(ListColor.colorLightGrey2)
                                    //       : controller.listcountDataLelangmuatan
                                    //                   .value.length >
                                    //               0
                                    //           ? Color(ListColor.colorBlue)
                                    //           : Color(ListColor.colorLightGrey2),
                                    // ),
                                    ),
                              ))),
                          Obx(() => GestureDetector(
                              onTap: () {
                                if (!controller.firsttimelelangMuatan.value) {
                                  if (controller.isSearchAktifOrHistory.value ==
                                      "aktif") {
                                    if (controller.listcountDataLelangmuatan
                                            .value.length >
                                        0) {
                                      controller.showSort();
                                    }
                                  }

                                  if (controller.isSearchAktifOrHistory.value ==
                                      "history") {
                                    if (controller.listDataLelangMuatanHistory
                                            .value.length >
                                        0) {
                                      controller.showSortHistory();
                                    }
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
                                  child: controller.firsttimelelangMuatan.value
                                      ? SvgPicture.asset(
                                          "assets/sorting_icon.svg",
                                          width: GlobalVariable.ratioFontSize(
                                                  context) *
                                              22,
                                          height: GlobalVariable.ratioFontSize(
                                                  context) *
                                              22,
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                        )
                                      : controller.isSearchAktifOrHistory
                                                  .value ==
                                              "aktif"
                                          ? controller.issort.value
                                              ? SvgPicture.asset(
                                                  "assets/ic_sort_aktif.svg",
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
                                                  color: controller
                                                              .listcountDataLelangmuatan
                                                              .value
                                                              .length >
                                                          0
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Color(ListColor
                                                          .colorLightGrey2),
                                                )
                                          : controller.issortHistory.value
                                              ? SvgPicture.asset(
                                                  "assets/ic_sort_aktif.svg",
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
                                                  color: controller
                                                              .listcountDataLelangmuatan
                                                              .value
                                                              .length >
                                                          0
                                                      ? Color(
                                                          ListColor.colorBlue)
                                                      : Color(ListColor
                                                          .colorLightGrey2),
                                                )))),
                        ],
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
            body: Container(
              child: Obx(() => controller.isShowClearSearch.value &&
                      controller.istidakadadata.value == false
                  ? controller.listcountDataLelangmuatan.value.length > 0
                      ? _listDataSearch()
                      : Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()))
                  : controller.istidakadadata.value &&
                          controller.searchTextEditingController.value.text !=
                              ""
                      ? _tidakAdaDataPencarian()
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Obx(
                              () => ZoBannerWidget(
                                carouselController: CarouselController(),
                                items: controller.bannerItems.isNotEmpty
                                    ? controller.bannerItems
                                        .map(
                                          (item) => Builder(
                                            builder: (context) => AspectRatio(
                                              aspectRatio: 360 / 134,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image:
                                                        NetworkImage('$item'),
                                                    fit: BoxFit.contain,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList()
                                    : [1].map((e) {
                                        return Builder(
                                            builder: (BuildContext context) {
                                          return Container(
                                            width: MediaQuery.of(Get.context)
                                                .size
                                                .width,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                159,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/background_header_lelang_muatan.png",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          20,
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          23,
                                                    ),
                                                    child: Image(
                                                      image: AssetImage(
                                                        "assets/ic_mobile_header_lelang_muatan.png",
                                                      ),
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          92,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          91,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  context) *
                                                          20,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomText(
                                                          "LelangMuatBuatLelangBuatLelangLabelTitleAyo"
                                                                  .tr +
                                                              ",",
                                                          color: Colors.white,
                                                          fontSize: 24,
                                                          height: 28.8 / 24,
                                                          withoutExtraPadding:
                                                              true,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: GlobalVariable
                                                                    .ratioWidth(
                                                                        context) *
                                                                9,
                                                          ),
                                                          child: CustomText(
                                                            "LelangMuatBuatLelangBuatLelangLabelTitleCariArmada"
                                                                .tr,
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: (16.8 / 14),
                                                            withoutExtraPadding:
                                                                true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                      }).toList(),
                              ),
                            ),
                            Expanded(
                              // height: MediaQuery.of(context).size.height -
                              //     (GlobalVariable.ratioWidth(Get.context) * 236),
                              child: DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    children: [
                                      Container(
                                          child: Stack(
                                        children: [
                                          Positioned.fill(
                                              child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Color(ListColor
                                                            .colorLightGrey10),
                                                        width: 2.0))),
                                          )),
                                          TabBar(
                                            unselectedLabelColor: Color(
                                                ListColor.colorLightGrey10),
                                            unselectedLabelStyle: TextStyle(
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    14,
                                                fontWeight: FontWeight.w600),
                                            indicatorWeight: 2.0,
                                            labelColor: Color(ListColor.color4),
                                            labelStyle: TextStyle(
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    14,
                                                fontWeight: FontWeight.w700),
                                            controller:
                                                controller.tabController,
                                            tabs: [
                                              Tab(
                                                  child: Text(
                                                      "LelangMuatTabAktifTabAktifLabelTitleActive"
                                                          .tr)),
                                              Tab(
                                                  child: Text(
                                                "History",
                                              )),
                                              // Tab(child: Text("PartnerManagementTabRequest".tr)),
                                              // Tab(child: Text("PartnerManagementTabPending".tr)),
                                            ],
                                          ),
                                        ],
                                      )),
                                      // Container(
                                      //     color: Colors.black,
                                      //     height: 2,
                                      //     width: MediaQuery.of(context)
                                      //         .size
                                      //         .width),
                                      Expanded(
                                        // height: MediaQuery.of(context).size.height -
                                        //     (GlobalVariable.ratioWidth(Get.context) *
                                        //         278),
                                        child: TabBarView(
                                            physics: controller
                                                    .firsttimelelangMuatan.value
                                                ? NeverScrollableScrollPhysics()
                                                : PageScrollPhysics(),
                                            controller:
                                                controller.tabController,
                                            children: [
                                              Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  _aktifPage(),
                                                  controller
                                                          .firsttimelelangMuatan
                                                          .value
                                                      ? controller
                                                          .messageBottomNav
                                                      : SizedBox.shrink()
                                                ],
                                              ),
                                              _historyPage()
                                            ]),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        )),
            ),
            bottomNavigationBar: BottomAppBarMuat(
              centerItemText: '',
              color: Colors.grey,
              backgroundColor: Colors.white,
              selectedColor: Color(ListColor.colorSelectedBottomMenu),
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: (index) {
                // if (index == 0)
                //   Get.toNamed(Routes.INBOX);
                // else
                //   Get.back();
                if (!controller.firsttimelelangMuatan.value) {
                  switch (index) {
                    case 0:
                      {
                        Get.toNamed(Routes.INBOX);
                        break;
                      }
                    case 1:
                      {
                        Get.toNamed(Routes.PROFILE_SHIPPER);
                        break;
                      }
                  }
                }
              },
              items: [
                BottomAppBarItemModel(
                    iconName: 'message_menu_icon.svg', text: ''),
                BottomAppBarItemModel(iconName: 'user_menu_icon.svg', text: ''),
              ],
              iconSize: 40,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              width: GlobalVariable.ratioWidth(Get.context) * 59.15,
              height: GlobalVariable.ratioWidth(Get.context) * 59.15,
              decoration: BoxDecoration(),
              child: FloatingActionButton(
                backgroundColor: Color(
                    ListColor.colorDashboardTransporterMarketMenuLelangMuatan),
                onPressed: () {
                  controller.toBuatLelang("aktif");
                  controller.setFirstTimeResult(false);
                },
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    side: BorderSide(color: Colors.white, width: 4.0)),
              ),
            ),
          )),
    );
  }

  Widget _filter(String type) {
    return Obx(() => Container(
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.3),
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
              color: type == "aktif"
                  ? controller.isFilter.value
                      ? Color(ListColor.colorLightBlue1)
                      : Color(ListColor.colorWhite)
                  : controller.isFilterHistory.value
                      ? Color(ListColor.colorLightBlue1)
                      : Color(ListColor.colorWhite),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: controller.firsttimelelangMuatan.value
                    ? Color(ListColor.colorLightGrey2)
                    : type == "aktif"
                        ? controller.isFilter.value
                            ? Color(ListColor.colorBlue)
                            : Color(ListColor.colorLightGrey2)
                        : controller.isFilterHistory.value
                            ? Color(ListColor.colorBlue)
                            : Color(ListColor.colorLightGrey2),
              )),
          child: Material(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onTap: () {
                  if (!controller.firsttimelelangMuatan.value) {
                    if (type == "aktif") {
                      if (controller.listcountDataLelangmuatan.value.length >
                              0 ||
                          controller.isFilter.value) {
                        controller.getListMuatan(type);
                        controller.showFilter(type);
                      }
                    }

                    if (type == "history") {
                      if (controller.listDataLelangMuatanHistory.value.length >
                              0 ||
                          controller.isFilterHistory.value) {
                        controller.getListMuatan(type);
                        controller.showFilter(type);
                      }
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: CustomText("GlobalFilterLabelButtonFilter".tr,
                            fontWeight: FontWeight.w500,
                            color: controller.firsttimelelangMuatan.value
                                ? Color(ListColor.colorLightGrey2)
                                : (type == "aktif"
                                        ? controller.isFilter.value
                                        : controller.isFilterHistory.value)
                                    ? Color(ListColor.colorBlue)
                                    : type == "aktif"
                                        ? (controller.listcountDataLelangmuatan
                                                    .value.length >
                                                0)
                                            ? Color(ListColor.colorDarkBlue2)
                                            : Color(ListColor.colorLightGrey2)
                                        : (controller
                                                    .listDataLelangMuatanHistory
                                                    .value
                                                    .length >
                                                0)
                                            ? Color(ListColor.colorDarkBlue2)
                                            : Color(ListColor.colorLightGrey2)),
                      ),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          "assets/filter_icon.svg",
                          height: GlobalVariable.ratioWidth(Get.context) * 12.5,
                          color: controller.firsttimelelangMuatan.value
                              ? Color(ListColor.colorLightGrey2)
                              : type == "aktif"
                                  ? (controller.listcountDataLelangmuatan.value
                                                  .length >
                                              0 ||
                                          controller.isFilter.value)
                                      ? Color(ListColor.colorBlue)
                                      : Color(ListColor.colorLightGrey2)
                                  : (controller.listDataLelangMuatanHistory
                                                  .value.length >
                                              0 ||
                                          controller.isFilterHistory.value)
                                      ? Color(ListColor.colorBlue)
                                      : Color(ListColor.colorLightGrey2),
                        )
                      ])
                    ],
                  ),
                )),
          ),
        ));
  }

  _aktifPage() {
    return controller.isLoadingTabAktif.isTrue
        ? Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: Get.context.mediaQuery.size.width,
                margin: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 12,
                    GlobalVariable.ratioWidth(Get.context) * 8,
                    GlobalVariable.ratioWidth(Get.context) * 15),
                child: Row(
                  children: [
                    _filter("aktif"),
                    Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    Obx(() => Container(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (!controller.firsttimelelangMuatan.value) {
                                  if (controller.listcountDataLelangmuatan.value
                                          .length >
                                      0) {
                                    if (controller
                                            .listDataNotifikasi.value.length >
                                        0) {
                                      controller.toNotification();
                                    }
                                  }
                                }

                                // controller.showInfoTooltip.value = true;
                                // GetToPage.toNamed<ZoListNotifikasiShipperController>(
                                //     Routes.ZO_LIST_NOTIFIKASI_SHIPPER,
                                //     preventDuplicates: false,
                                //     arguments: [""]);
                              },
                              child: Container(
                                  child: controller.firsttimelelangMuatan.value
                                      ? SvgPicture.asset(
                                          "assets/notif_non_aktif.svg",
                                          width: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              28,
                                          height: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              28,
                                        )
                                      : controller.listcountDataLelangmuatan
                                                      .value.length ==
                                                  0 &&
                                              !controller.isFilter.value
                                          ? SvgPicture.asset(
                                              "assets/notif_non_aktif.svg",
                                              width:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      28,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      28,
                                            )
                                          : (controller.listcountDataLelangmuatan
                                                          .value.length >
                                                      0 ||
                                                  controller.isFilter.value)
                                              ? controller.isNewNotif.isTrue
                                                  ? SvgPicture.asset(
                                                      "assets/notif_aktif.svg",
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          28,
                                                      height: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          28,
                                                    )
                                                  : SvgPicture.asset(
                                                      "assets/notif_inactive.svg",
                                                      width: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          28,
                                                      height: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          28,
                                                    )
                                              : SvgPicture.asset(
                                                  "assets/notif_non_aktif.svg",
                                                  width: GlobalVariable
                                                          .ratioFontSize(
                                                              Get.context) *
                                                      28,
                                                  height: GlobalVariable
                                                          .ratioFontSize(
                                                              Get.context) *
                                                      28,
                                                )

                                  //     Image(
                                  //   image: controller
                                  //               .listcountDataLelangmuatan.value.length >
                                  //           0
                                  //       ? AssetImage("assets/lonceng_enable.png")
                                  //       : AssetImage("assets/lonceng_disable.png"),
                                  //   width: GlobalVariable.ratioWidth(Get.context) * 25,
                                  //   height: GlobalVariable.ratioWidth(Get.context) * 25,
                                  //   fit: BoxFit.fitWidth,
                                  // )

                                  ),
                            ),
                          ),
                        )),
                    Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    Obx(() => Container(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // if (!controller.firsttimelelangMuatan.value) {
                                controller.showInfoTooltip.value = true;
                                // }
                              },
                              child: Container(
                                  child: controller.showInfoTooltip.value
                                      ? SvgPicture.asset(
                                          "assets/info_disable.svg",
                                          width: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              28,
                                          height: GlobalVariable.ratioFontSize(
                                                  Get.context) *
                                              28,
                                        )
                                      : controller.showInfoTooltip.value
                                          ? SvgPicture.asset(
                                              "assets/info_disable.svg",
                                              width:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      28,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      28,
                                            )
                                          : SvgPicture.asset(
                                              "assets/info_active.svg",
                                              width:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      28,
                                              height:
                                                  GlobalVariable.ratioFontSize(
                                                          Get.context) *
                                                      28,
                                            )),
                            ),
                          ),
                        )),
                    Expanded(
                      child: Container(),
                    ),
                    if (controller.listcountDataLelangmuatan.value.length > 0)
                      Padding(
                        padding: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 8),
                        child: Obx(() => Container(
                              child: CustomText(
                                "LelangMuatBuatLelangBuatLelangLabelTitleTotalLelangMuatan"
                                        .tr +
                                    " : ${controller.listcountDataLelangmuatan.value.length}",
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        12,
                              ),
                            )),
                      )
                  ],
                ),
              ),
              SizedBox.shrink(),
              Expanded(
                child: Obx(() {
                  Widget child = const SizedBox.shrink();
                  if (controller.showInfoTooltip.isFalse) {
                    if (controller.listDataLelangMuatan.isEmpty ||
                        controller.listDataLelangMuatan.length == 1 &&
                            controller.listDataLelangMuatan[0] is Map &&
                            (controller.listDataLelangMuatan[0] as Map)
                                .containsKey('tooltip')) {
                      child = Container(
                        alignment: Alignment.center,
                        child: noDataWidget(
                          Get.context,
                          isFilter: controller.isFilter.isTrue,
                          onResetFilterTap: () =>
                              controller.showFilter('aktif'),
                        ),
                      );
                    } else {
                      child = ListView.builder(
                        itemCount: controller.listDataLelangMuatan.length,
                        itemBuilder: (context, index) {
                          return _listPerItem(index);
                        },
                      );
                    }
                    // else {
                    //   child = Container(
                    //     alignment: Alignment.center,
                    //     child: noDataWidget(
                    //       Get.context,
                    //       isFilter: controller.isFilter.isTrue,
                    //       onResetFilterTap: () =>
                    //           controller.showFilter('aktif'),
                    //     ),
                    //   );
                    // }
                  } else {
                    child = ListView.builder(
                      itemCount: controller.listDataLelangMuatan.length,
                      itemBuilder: (context, index) {
                        return _listPerItem(index);
                      },
                    );
                  }
                  return SmartRefresher(
                    enablePullUp: true,
                    enablePullDown: true,
                    controller:
                        controller.refreshLelangMuatanTabAktifController,
                    onLoading: () {
                      controller.loadData();
                    },
                    onRefresh: () {
                      controller.refreshDataSmart();
                    },
                    child: child,
                  );
                }),
              ),
            ],
          );
  }

  Widget noDataWidget(
    BuildContext context, {
    bool isFilter = false,
    void Function() onResetFilterTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: SvgPicture.asset(
            isFilter
                ? "assets/ic_management_lokasi_no_search.svg"
                : "assets/ic_management_lokasi_no_data.svg",
            width:
                GlobalVariable.ratioWidth(context) * (isFilter ? 81.18 : 82.32),
            height:
                GlobalVariable.ratioWidth(context) * (isFilter ? 92.74 : 75),
          ),
        ),
        SizedBox(
          height: GlobalVariable.ratioWidth(context) * (isFilter ? 18.26 : 20),
        ),
        CustomText(
          isFilter
              ? "Data tidak Ditemukan.\nMohon coba hapus beberapa filter.".tr
              : "LelangMuatBuatLelangBuatLelangLabelTitleBelumAda"
                  .tr
                  .replaceAll("\\n", "\n"),
          textAlign: TextAlign.center,
          color: Color(ListColor.colorLightGrey14),
          fontWeight: FontWeight.w600,
          fontSize: 14,
          height: 16.8 / 14,
          withoutExtraPadding: true,
        ),
        if (isFilter) ...[
          SizedBox(height: GlobalVariable.ratioWidth(context) * 18),
          CustomText(
            "atau".tr,
            textAlign: TextAlign.center,
            color: Color(ListColor.colorLightGrey4),
            fontWeight: FontWeight.w600,
            fontSize: 14,
            height: 16.8 / 14,
            withoutExtraPadding: true,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 18),
          Material(
            color: Color(ListColor.colorBlue),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            child: InkWell(
              onTap: () => onResetFilterTap?.call(),
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioFontSize(Get.context) * 24,
                  vertical: GlobalVariable.ratioFontSize(Get.context) * 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                child: CustomText(
                  'Atur Ulang Filter'.tr,
                  color: Color(ListColor.colorWhite),
                  fontSize: 12,
                  withoutExtraPadding: true,
                  height: 14.4 / 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _listPerItem(int index) {
    if (index == 0) {
      return Obx(() =>
          controller.showInfoTooltip.value ? _infoTooltip() : Container());
    } else {
      return listPerItem(index);
      // return controller.listPerItem(index, data);
    }
  }

  Widget _listPerItemHistory(int index) {
    return listPerItemHistory(index);
  }

  Widget _infoTooltip() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorLightGrey).withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(ListColor.colorYellow4)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: GlobalVariable.ratioWidth(Get.context) * 7,
                  top: GlobalVariable.ratioWidth(Get.context) * 11,
                  bottom: GlobalVariable.ratioWidth(Get.context) * 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // if (!controller.firsttimelelangMuatan.value) {
                        controller.showInfoTooltip.value = false;
                        // }
                      },
                      child: Container(
                          child: SvgPicture.asset(
                        "assets/ic_close_zo.svg",
                        height: GlobalVariable.ratioFontSize(Get.context) * 10,
                        color: Color(ListColor.colorBlack),
                      )
                          //     child: Icon(
                          //   Icons.close_rounded,
                          //   size: GlobalVariable.ratioWidth(Get.context) * 16,
                          // )
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 18,
                  0,
                  GlobalVariable.ratioWidth(Get.context) * 18,
                  GlobalVariable.ratioWidth(Get.context) * 14),
              child: Row(
                children: [
                  Expanded(
                      child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: TextStyle(
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            color: Colors.black,
                            height: 1.857,
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text:
                                  "LelangMuatBuatLelangBuatLelangLabelTitleLelangMuatan"
                                          .tr +
                                      " ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14)),
                          TextSpan(
                              text:
                                  "LelangMuatBuatLelangBuatLelangLabelTitleAdalahFitur"
                                      .tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14)),
                        ]),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _historyPage() {
    return controller.isLoadingTabHistory.isTrue
        ? Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: Get.context.mediaQuery.size.width,
                margin: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 12,
                    GlobalVariable.ratioWidth(Get.context) * 8,
                    GlobalVariable.ratioWidth(Get.context) * 15),
                child: Row(
                  children: [
                    _filter("history"),
                    Expanded(
                      child: Container(),
                    ),
                    if (controller.listDataLelangMuatanHistory.value.length > 0)
                      Padding(
                        padding: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 8),
                        child: Obx(() => Container(
                              child: CustomText(
                                "LelangMuatBuatLelangBuatLelangLabelTitleTotalLelangMuatan"
                                        .tr +
                                    " : ${controller.listDataLelangMuatanHistory.value.length}",
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        12,
                              ),
                            )),
                      )
                  ],
                ),
              ),
              SizedBox.shrink(),
              Expanded(
                child: Obx(() {
                  Widget child = const SizedBox.shrink();
                  if (controller.listDataLelangMuatanHistory.length > 0) {
                    child = ListView.builder(
                      itemCount:
                          controller.listDataLelangMuatanHistory.value.length,
                      itemBuilder: (context, index) {
                        return _listPerItemHistory(index);
                      },
                    );
                  } else {
                    child = Container(
                      alignment: Alignment.center,
                      child: noDataWidget(
                        Get.context,
                        isFilter: controller.isFilterHistory.isTrue,
                        onResetFilterTap: () =>
                            controller.showFilter('history'),
                      ),
                    );
                  }
                  return SmartRefresher(
                    enablePullUp: true,
                    enablePullDown: true,
                    controller:
                        controller.refreshLelangMuatanTabHistoryController,
                    onLoading: () {
                      controller.loadDataHistory();
                    },
                    onRefresh: () {
                      controller.refreshDataSmartHistory();
                    },
                    child: child,
                  );
                }),
              ),
            ],
          );
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
              if (controller.isSearchAktifOrHistory.value == "aktif")
                _opsiList(context, idx)
              else
                _opsiListHistory(context, idx),
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
            controller.toPesertaLelang(
                controller.listDataLelangMuatan.value[idx]['ID'].toString(),
                "aktif");
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
                isDismissible: false,
                positionColorPrimaryButton:
                    PositionColorPrimaryButton.PRIORITY1,
                labelButtonPriority1:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmYes".tr,
                labelButtonPriority2:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmNo".tr,
                onTapPriority2: () {
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
                        "aktif");
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
            var participantCount = 0;
            if (controller.listDataLelangMuatan != null &&
                idx >= 0 &&
                idx < controller.listDataLelangMuatan.length &&
                controller.listDataLelangMuatan[idx] != null &&
                controller.listDataLelangMuatan[idx]['Participant'] != null) {
              final participantCountString =
                  '${controller.listDataLelangMuatan[idx]['Participant']}'
                      .trim();
              participantCount = int.tryParse(participantCountString) ?? 0;
            }
            GlobalAlertDialog.showAlertDialogCustom(
                context: Get.context,
                title: "LelangMuatBuatLelangBuatLelangLabelTitleConfirmasiBatal"
                    .tr,
                customMessage: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Color(ListColor.colorBlack),
                      fontFamily: 'AvenirNext',
                      fontSize: GlobalVariable.ratioFontSize(context) * 14,
                      height: GlobalVariable.ratioFontSize(context) * 16.8 / 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "LelangMuatTabAktifTabAktifLabelTitleConfirmBatalLelang"
                                .tr
                                .replaceAll("\\n", "\n"),
                      ),
                      if (participantCount > 0) ...[
                        TextSpan(
                          text: ' ' +
                              'Lelang yang Anda buat sudah diikuti oleh'.tr +
                              ' ',
                        ),
                        TextSpan(
                          text: '$participantCount ' 'Peserta'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                isShowCloseButton: true,
                isDismissible: true,
                positionColorPrimaryButton:
                    PositionColorPrimaryButton.PRIORITY1,
                labelButtonPriority1:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmYes".tr,
                labelButtonPriority2:
                    "LelangMuatTabAktifTabAktifLabelTitleConfirmNo".tr,
                onTapPriority2: () {
                  controller.batalLelang(
                      controller.listDataLelangMuatan.value[idx]["ID"]
                          .toString(),
                      "aktif");
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
            "LelangMuatTabHistoryTabHistoryLabelTitleSalinLelang".tr,
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
              controller.toPesertaLelang(
                  controller.listDataLelangMuatanHistory.value[idx]["ID"]
                      .toString(),
                  "history");
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

  _share() {
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
                        child: CustomText("Share",
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
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 42.26,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(context) * 19.11,
                    right: GlobalVariable.ratioWidth(context) * 19.11),
                child: _shareList(),
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(context) * 64,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(context) * 30.18,
                    right: GlobalVariable.ratioWidth(context) * 30.18,
                    bottom: GlobalVariable.ratioWidth(context) * 15),
                child: _buttonPrioritySecondary(),
              )
            ],
          );
        });
  }

  _shareList() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Column(
          children: [
            Image(
              image: AssetImage("assets/image_wa.png"),
              width: GlobalVariable.ratioWidth(Get.context) * 41.52,
              height: GlobalVariable.ratioWidth(Get.context) * 41.52,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 7.12,
            ),
            CustomText(
              "Whatsapp",
              textAlign: TextAlign.center,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
              fontWeight: FontWeight.w500,
            )
          ],
        )),
        Expanded(
            child: Column(
          children: [
            SvgPicture.asset(
              "assets/image_line.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 41.52,
              height: GlobalVariable.ratioWidth(Get.context) * 41.52,
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 7.12,
            ),
            CustomText(
              "Line",
              textAlign: TextAlign.center,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
              fontWeight: FontWeight.w500,
            )
          ],
        )),
        Expanded(
            child: Column(
          children: [
            SvgPicture.asset(
              "assets/image_gmail.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 41.52,
              height: GlobalVariable.ratioWidth(Get.context) * 41.52,
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 7.12,
            ),
            CustomText(
              "Gmail",
              textAlign: TextAlign.center,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
              fontWeight: FontWeight.w500,
            )
          ],
        )),
        Expanded(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/image_google_drive.svg",
                width: GlobalVariable.ratioWidth(Get.context) * 41.52,
                height: GlobalVariable.ratioWidth(Get.context) * 41.52,
              ),
              SizedBox(
                height: GlobalVariable.ratioWidth(Get.context) * 7.12,
              ),
              CustomText(
                "Google \n Drive",
                textAlign: TextAlign.center,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buttonPrioritySecondary() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        Get.back();
      },
      child: Container(
        width: MediaQuery.of(Get.context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Stack(alignment: Alignment.center, children: [
          // CustomText("tes",
          //     fontWeight: FontWeight.w600, color: Colors.transparent),
          CustomText("LelangMuatTabAktifTabAktifLabelTitleCancelFilter".tr,
              fontWeight: FontWeight.w600, color: Color(ListColor.color4)),
        ]),
      ),
    );
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
                            if (!controller.firsttimelelangMuatan.value) {
                              _opsi(index);
                            }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          2),
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
                                        controller.toDetailLelangMuatan(
                                            controller.listDataLelangMuatan
                                                .value[index]['ID']
                                                .toString(),
                                            "aktif",
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
                                          // height: GlobalVariable.ratioFontSize(
                                          //         Get.context) *
                                          //     (12 / 14),
                                          color: Color(ListColor.colorBlue),
                                        ),
                                      ),
                                    ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        Positioned(
                            top: GlobalVariable.ratioFontSize(Get.context) * 16,
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
                                            2),
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
                                              controller.toDetailLelangMuatan(
                                                  controller
                                                      .listDataLelangMuatan
                                                      .value[index]['ID']
                                                      .toString(),
                                                  "aktif",
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
                        child: Container(
                          child: CustomText(
                            "${controller.listDataLelangMuatan.value[index]['StartDate']} - ${controller.listDataLelangMuatan.value[index]['EndDate']}",
                            fontWeight: FontWeight.w500,
                            // maxLines: 1,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            // height:
                            //     GlobalVariable.ratioFontSize(Get.context) *
                            //         (17 / 14)
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
                          if (!controller.firsttimelelangMuatan.value) {
                            controller.toDetailLelangMuatan(
                                controller
                                    .listDataLelangMuatan.value[index]['ID']
                                    .toString(),
                                "aktif",
                                0);
                          }
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
                            if (!controller.firsttimelelangMuatan.value) {
                              _opsi(index);
                            }
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
                                          2),
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
                                          controller.toDetailLelangMuatan(
                                              controller
                                                  .listDataLelangMuatanHistory
                                                  .value[index]['ID']
                                                  .toString(),
                                              "history",
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
                                        ))
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
                                            2),
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
                                              controller.toDetailLelangMuatan(
                                                  controller
                                                      .listDataLelangMuatanHistory
                                                      .value[index]['ID']
                                                      .toString(),
                                                  "history",
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
                                            ))
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
                        child: Container(
                          child: CustomText(
                            "${controller.listDataLelangMuatanHistory.value[index]['StartDate']} - ${controller.listDataLelangMuatanHistory.value[index]['EndDate']}",
                            fontWeight: FontWeight.w500,
                            // maxLines: 1,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            // height:
                            //     GlobalVariable.ratioFontSize(Get.context) *
                            //         (17 / 14)
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
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
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
                            ),
                    ),
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
                          if (!controller.firsttimelelangMuatan.value) {
                            controller.toDetailLelangMuatan(
                                controller.listDataLelangMuatanHistory
                                    .value[index]['ID']
                                    .toString(),
                                "history",
                                0);
                          }
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
            height: GlobalVariable.ratioWidth(Get.context) * 30.5,
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

  _listDataSearch() {
    return Obx(() => Container(
        color: Color(ListColor.colorWhite1),
        height: MediaQuery.of(Get.context).size.height,
        child: SingleChildScrollView(
            child: controller.listcountDataLelangmuatan.value.length > 0
                ? _adaDataPencarian()
                : _tidakAdaDataPencarian())));
  }

  _adaDataPencarian() {
    return Obx(() => Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                    top: GlobalVariable.ratioWidth(Get.context) * 20),
                child: Row(
                  children: [
                    Container(
                      child: CustomText(
                        "LelangMuatBuatLelangBuatLelangLabelTitleMenampilkan"
                                .tr +
                            " ${controller.listcountDataLelangmuatan.value.length} " +
                            "LelangMuatBuatLelangBuatLelangLabelTitleHasilUntuk"
                                .tr,
                        fontWeight: FontWeight.w500,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 12,
                        color: Color(ListColor.colorDarkBlue2),
                      ),
                    ),
                    Container(
                      child: CustomText(
                        '"',
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 12,
                        color: Color(ListColor.colorBlack),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Container(
                      child: CustomText(
                        controller.searchTextEditingController.value.text,
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 12,
                        color: Color(ListColor.colorBlack),
                      ),
                    ),
                    Container(
                      child: CustomText(
                        '"',
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 12,
                        color: Color(ListColor.colorBlack),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )),
            for (var i = 0;
                i < controller.listcountDataLelangmuatan.value.length;
                i++)
              listPerItem(i + 1)
          ],
        ));
  }

  _tidakAdaDataPencarian() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                top: GlobalVariable.ratioWidth(Get.context) * 20),
            child: Row(
              children: [
                Container(
                  child: CustomText(
                    "LelangMuatBuatLelangBuatLelangLabelTitleTidakDitemukanHasil"
                            .tr +
                        " ",
                    fontWeight: FontWeight.w500,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    color: Color(ListColor.colorDarkBlue2),
                  ),
                ),
                Container(
                  child: CustomText(
                    '"',
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    color: Color(ListColor.colorBlack),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Container(
                  child: CustomText(
                    controller.searchTextEditingController.value.text,
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    color: Color(ListColor.colorBlack),
                  ),
                ),
                Container(
                  child: CustomText(
                    '"',
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    color: Color(ListColor.colorBlack),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            )),
        Expanded(
            child: Center(
          child: Positioned.fill(
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
                  ))),
        ))
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
