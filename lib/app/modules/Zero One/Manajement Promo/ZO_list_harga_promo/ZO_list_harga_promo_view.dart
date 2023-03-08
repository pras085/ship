import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_list_harga_promo/ZO_helper/ZO_helper_widget.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_list_harga_promo/ZO_list_harga_promo_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';

class ZoListHargaPromoView extends GetView<ZoListHargaPromoController> {
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
                ], color: Color(ListColor.colorYellow)),
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
                                  color: Colors.black,
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
                                            color: Color(ListColor.colorYellow),
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
                                    key: ValueKey("CariHargaPromo"),
                                    context: Get.context,
                                    readOnly: true,
                                    onTap: () {
                                      controller
                                          .toSearchPage(controller.type.value);
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
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {},
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
                          ZoWidgetHelper().sizeBoxWidth(4),
                          Obx(
                            () => GestureDetector(
                                onTap: () {
                                  controller.showSort(controller.type.value);
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: controller.type.value ==
                                            "data-promo-aktif"
                                        ? controller.issort.isTrue
                                            ? ClipOval(
                                                child: Material(
                                                    shape: CircleBorder(),
                                                    color: Colors.black,
                                                    child: SvgPicture.asset(
                                                        "assets/sorting_icon.svg",
                                                        width: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            26,
                                                        height: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            26,
                                                        color: Color(ListColor
                                                            .colorYellow))),
                                              )
                                            : Container(
                                                child: SvgPicture.asset(
                                                "assets/sorting_icon.svg",
                                                width: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    22,
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    22,
                                                color: Colors.black,
                                              ))
                                        : controller.issortHistory.isTrue
                                            ? ClipOval(
                                                child: Material(
                                                    shape: CircleBorder(),
                                                    color: Colors.black,
                                                    child: SvgPicture.asset(
                                                        "assets/sorting_icon.svg",
                                                        width: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            26,
                                                        height: GlobalVariable
                                                                .ratioFontSize(
                                                                    context) *
                                                            26,
                                                        color: Color(ListColor
                                                            .colorYellow))),
                                              )
                                            : Container(
                                                child: SvgPicture.asset(
                                                "assets/sorting_icon.svg",
                                                width: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    22,
                                                height: GlobalVariable
                                                        .ratioFontSize(
                                                            context) *
                                                    22,
                                                color: Colors.black,
                                              )))),
                          )
                        ],
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
            body: Container(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(Get.context).size.width,
                  height: GlobalVariable.ratioWidth(Get.context) * 159,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/background_header_lelang_muatan.png"),
                          fit: BoxFit.cover)),
                  child: Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 20,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 38),
                          child:

                              // SvgPicture.asset(
                              //   "assets/truck_jejer_tiga.svg",
                              //   width: GlobalVariable.ratioWidth(
                              //           Get.context) *
                              //       92,
                              //   height: GlobalVariable.ratioWidth(
                              //           Get.context) *
                              //       91,
                              // )

                              Image(
                            image: AssetImage(
                                "assets/ic_mobile_header_lelang_muatan.png"),
                            width: GlobalVariable.ratioWidth(Get.context) * 92,
                            height: GlobalVariable.ratioWidth(Get.context) * 91,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            "Yuk".tr + ",",
                            color: Colors.white,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 24,
                            fontWeight: FontWeight.w600,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            child: CustomText(
                              "Layani pelanggan lebih baik \nagar Perusahaan Anda \nBerkembang dan Survive"
                                  .tr,
                              color: Colors.white,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w600,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14),
                            ),
                          ),
                        ],
                      ))
                    ],
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
                                            color: Color(
                                                ListColor.colorLightGrey10),
                                            width: 2.0))),
                              )),
                              TabBar(
                                unselectedLabelColor:
                                    Color(ListColor.colorLightGrey10),
                                unselectedLabelStyle: TextStyle(
                                    fontSize:
                                        GlobalVariable.ratioFontSize(context) *
                                            14,
                                    fontWeight: FontWeight.w600),
                                indicatorWeight: 2.0,
                                labelColor: Color(ListColor.color4),
                                labelStyle: TextStyle(
                                    fontSize:
                                        GlobalVariable.ratioFontSize(context) *
                                            14,
                                    fontWeight: FontWeight.w700),
                                controller: controller.tabController,
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
                                physics: PageScrollPhysics(),
                                controller: controller.tabController,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      _aktifPage(),
                                      // controller
                                      //                     .firsttimelelangMuatan
                                      //                     .value
                                      //                 ?
                                      // ZoWidgetHelper().messageBottomNav(
                                      //     context,
                                      //     "Tekan tombol di bawah ini untuk membuat Harga Promo"
                                      //         .tr)
                                      // : SizedBox.shrink()
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
            bottomNavigationBar: BottomAppBarMuat(
              centerItemText: '',
              color: Colors.grey,
              backgroundColor: Colors.white,
              selectedColor: Color(ListColor.colorSelectedBottomMenu),
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: (index) async {
                // if (index == 0)
                //   Get.toNamed(Routes.INBOX);
                // else
                //   Get.back();
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
                backgroundColor: Color(ListColor
                    .colorDashboardTransporterMarketMenuPromoTranspoter),
                onPressed: () {},
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 60,
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
    return Container(
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          color: Color(ListColor.colorWhite),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: Color(ListColor.colorLightGrey7),
          )),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: () {
              controller.showFilter(type);
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
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Color(ListColor.colorDarkBlue2)),
                  ),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset("assets/filter_icon.svg",
                        height: GlobalVariable.ratioFontSize(Get.context) * 14,
                        width: GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Color(ListColor.colorBlue))
                  ])
                ],
              ),
            )),
      ),
    );
  }

  _aktifPage() {
    return Column(
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
              _filter("data-promo-aktif"),
              Container(
                width: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              Obx(
                () => Container(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.showInfoTooltip.value = true;
                      controller.munculIconDataKosong.value = false;
                    },
                    child: Container(
                        child: controller.showInfoTooltip.value
                            ? SvgPicture.asset(
                                "assets/info_disable.svg",
                                width:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        28,
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        28,
                              )
                            : SvgPicture.asset(
                                "assets/info_active.svg",
                                width:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        28,
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        28,
                              )),
                  ),
                )),
              ),
              Expanded(
                child: Container(),
              ),
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(
                      right: GlobalVariable.ratioWidth(Get.context) * 8),
                  child: Container(
                    child: CustomText(
                      "LelangMuatBuatLelangBuatLelangLabelTitleTotalLelangMuatan"
                              .tr +
                          " : ${controller.listManajementPromoDataCount.length}",
                      fontWeight: FontWeight.w600,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox.shrink(),
        Obx(
          () => Expanded(
              child: Stack(
            children: [
              SmartRefresher(
                enablePullUp: true,
                enablePullDown: true,
                controller: controller.refreshManajementPromoTabAktifController,
                onLoading: () {
                  controller.loadData();
                },
                onRefresh: () {
                  controller.refreshDataSmart();
                },
                child: controller.listManajementPromoData.length == 0
                    ? Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 50,
                          width: 50,
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.listManajementPromoData.length,
                        itemBuilder: (context, index) {
                          return _listPerItem(index);
                        },
                      ),
              ),
              if (controller.listManajementPromoData.length == 1 &&
                  controller.munculIconDataKosong.isTrue)
                Positioned.fill(
                    child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: SvgPicture.asset(
                              "assets/ic_management_lokasi_no_data.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 82.3,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 75,
                            )),
                            Container(
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      20,
                            ),
                            Container(
                                child: CustomText(
                              "Buat Promo Sebanyak \n mungkin untuk menarik \n Pelanggan Baru"
                                  .tr
                                  .replaceAll("\\n", "\n"),
                              textAlign: TextAlign.center,
                              color: Color(ListColor.colorLightGrey14),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      16,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (19.2 / 16),
                            ))
                          ],
                        ))),
            ],
          )),
        )
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
                        controller.showInfoTooltip.value = false;
                        controller.munculIconDataKosong.value = true;
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
                              text: "Buat Harga Promo".tr + " ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14)),
                          TextSpan(
                              text:
                                  "adalah fitur dari Transport Market untuk meningkatkan utilitas Armada Anda dan menghindari trip kosong, mengingat harga BBM yang semakin mahal. Promo Transport Market dapat meningkatkan revenue dan mengurangi biaya Anda."
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
                                  "Buat promo-promo menraik untuk mendapatkan Shipper baru !"
                                      .tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
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
    return Column(
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
              _filter("data-promo-history"),
              Expanded(
                child: Container(),
              ),
              // if (controller.listDataLelangMuatanHistory.value.length > 0)
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(
                      right: GlobalVariable.ratioWidth(Get.context) * 8),
                  child: Container(
                    child: CustomText(
                      "Total Harga Promo".tr +
                          " : ${controller.listManajementPromoDataHistory.length}",
                      fontWeight: FontWeight.w600,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox.shrink(),
        Obx(
          () => Expanded(
              child: Stack(
            children: [
              SmartRefresher(
                enablePullUp: true,
                enablePullDown: true,
                controller:
                    controller.refreshManajementPromoTabHistoryController,
                onLoading: () {
                  controller.loadDataHistory();
                },
                onRefresh: () {
                  controller.refreshDataSmartHistory();
                },
                child: controller.listManajementPromoDataHistory.length == 0
                    ? Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 50,
                          width: 50,
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            controller.listManajementPromoDataHistory.length,
                        itemBuilder: (context, index) {
                          return _listPerItemHistory(index);
                        },
                      ),
              ),
              if (controller.listManajementPromoDataHistory.length == 1 &&
                  controller.munculIconDataKosongHistory.isTrue)
                Positioned.fill(
                    child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: SvgPicture.asset(
                              "assets/ic_management_lokasi_no_data.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 82.3,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 75,
                            )),
                            Container(
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      20,
                            ),
                            Container(
                                child: CustomText(
                              "Buat Promo Sebanyak \n mungkin untuk menarik \n Pelanggan Baru"
                                  .tr
                                  .replaceAll("\\n", "\n"),
                              textAlign: TextAlign.center,
                              color: Color(ListColor.colorLightGrey14),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      16,
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (19.2 / 16),
                            ))
                          ],
                        ))),
            ],
          )),
        )
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
              // if (controller.isSearchAktifOrHistory.value == "aktif")
              //   _opsiList(context, idx)
              // else
              //   _opsiListHistory(context, idx),
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
          },
        ),
        _lineSaparator(),
        ListTile(
          leading: CustomText(
            "LelangMuatTabHistoryTabHistoryLabelTitlePesertaLelang".tr,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          onTap: () {},
        ),
        _lineSaparator(),
        ListTile(
          leading: CustomText(
            "LelangMuatTabHistoryTabHistoryLabelTitlePemenangLelangNoPemenang"
                .tr,
            fontSize: GlobalVariable.ratioFontSize(context) * 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          onTap: () {},
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
                              controller.listManajementPromoData[index]["key"]
                                      ["pickup_location_name"] ??
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
                              controller.listManajementPromoData[index]["key"]
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
                              controller.listManajementPromoData[index]["key"]
                                      ["Link"] ??
                                  "",
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    ZoWidgetHelper().sizeBoxHeight(14),
                    if (controller.lihatLebihBanyak[index])
                      for (var i = 0;
                          i <
                              controller
                                  .listManajementPromoData[index]["detail"]
                                  .length;
                          i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ZoWidgetHelper().labelText(
                                controller.listManajementPromoData[index]
                                        ["detail"][i]["head_name"] +
                                    " - " +
                                    controller.listManajementPromoData[index]
                                        ["detail"][i]["carrier_name"] +
                                    " (${controller.listManajementPromoData[index]["detail"][i]["min_capacity"].toString()} ~ ${controller.listManajementPromoData[index]["detail"][i]["max_capacity"].toString()} ${controller.listManajementPromoData[index]["detail"][i]["capacity_unit"]})",
                                Colors.black,
                                14,
                                FontWeight.w700,
                                linespacing:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        (16.8 / 14)),
                            ZoWidgetHelper().sizeBoxHeight(8),
                            if (controller.listManajementPromoData[index]
                                    ["detail"][i]["normal_price"] !=
                                "0")
                              CustomText(
                                "Rp " +
                                        controller
                                                .listManajementPromoData[index]
                                            ["detail"][i]["normal_price"] ??
                                    "",
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14,
                                color: Color(ListColor.colorGrey3),
                                decoration: TextDecoration.lineThrough,
                              ),
                            if (controller.listManajementPromoData[index]
                                    ["detail"][i]["normal_price"] !=
                                "0")
                              ZoWidgetHelper().sizeBoxHeight(4),
                            Row(
                              children: [
                                ZoWidgetHelper().labelText(
                                    "Rp " +
                                            controller.listManajementPromoData[
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
                                        controller.listManajementPromoData[
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
                                              .listManajementPromoData[index]
                                                  ["detail"][i]["counter_seen"]
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
                              controller.listManajementPromoData[index]
                                      ["detail"][0]["head_name"] +
                                  " - " +
                                  controller.listManajementPromoData[index]
                                      ["detail"][0]["carrier_name"] +
                                  " (${controller.listManajementPromoData[index]["detail"][0]["min_capacity"].toString()} ~ ${controller.listManajementPromoData[index]["detail"][0]["max_capacity"].toString()} ${controller.listManajementPromoData[index]["detail"][0]["capacity_unit"]})",
                              Colors.black,
                              14,
                              FontWeight.w700,
                              linespacing:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14)),
                          ZoWidgetHelper().sizeBoxHeight(8),
                          if (controller.listManajementPromoData[index]
                                  ["detail"][0]["normal_price"] !=
                              "0")
                            CustomText(
                              "Rp " +
                                      controller.listManajementPromoData[index]
                                          ["detail"][0]["normal_price"] ??
                                  "",
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              color: Color(ListColor.colorGrey3),
                              decoration: TextDecoration.lineThrough,
                            ),
                          if (controller.listManajementPromoData[index]
                                  ["detail"][0]["normal_price"] !=
                              "0")
                            ZoWidgetHelper().sizeBoxHeight(4),
                          Row(
                            children: [
                              ZoWidgetHelper().labelText(
                                  "Rp " +
                                          controller.listManajementPromoData[
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
                                      controller.listManajementPromoData[index]
                                              ["key"]["payment"] ??
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
                                            .listManajementPromoData[index]
                                                ["detail"][0]["counter_seen"]
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
                    if (!controller.lihatLebihBanyak[index])
                      ZoWidgetHelper().sizeBoxHeight(9),
                    Row(
                      children: [
                        Expanded(
                            child: ZoWidgetHelper().labelText(
                                controller.listManajementPromoData[index]["key"]
                                        ["start_date"] +
                                    " - " +
                                    controller.listManajementPromoData[index]
                                        ["key"]["end_date"],
                                Colors.black,
                                12,
                                FontWeight.w600)),
                        if (controller.listManajementPromoData[index]["detail"]
                                .length >
                            1)
                          GestureDetector(
                            onTap: () {
                              if (controller.lihatLebihBanyak[index]) {
                                controller.lihatLebihBanyak[index] = false;
                              } else {
                                controller.lihatLebihBanyak[index] = true;
                              }
                            },
                            child: CustomText(
                              controller.lihatLebihBanyak[index]
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
                      value: controller.status[index],
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
                                    controller.listManajementPromoData[index]
                                            ["key"]["ID"]
                                        .toString(),
                                    strVAL,
                                    "data-promo-aktif");
                                controller.status[index] = value;
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
                                    controller.listManajementPromoData[index]
                                            ["key"]["ID"]
                                        .toString(),
                                    strVAL,
                                    "data-promo-aktif");
                                controller.status[index] = value;
                                controller.strSwitchButon[index] =
                                    "Tidak Aktif";
                              });
                        }
                      },
                    ),
                    ZoWidgetHelper().sizeBoxWidth(8),
                    ZoWidgetHelper().labelText(controller.strSwitchButon[index],
                        Colors.black, 14, FontWeight.w600),
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

  _listseparator() {
    return Container(
        height: 0.5,
        color: Color(ListColor.colorGrey3),
        margin: EdgeInsets.only(
            top: GlobalVariable.ratioWidth(Get.context) * 9,
            bottom: GlobalVariable.ratioWidth(Get.context) * 14));
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
                              controller.listManajementPromoDataHistory[index]
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
                        ZoWidgetHelper().sizeBoxHeight(9.91),
                        Container(
                          child: CustomText(
                              controller.listManajementPromoDataHistory[index]
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
                              controller.listManajementPromoDataHistory[index]
                                      ["key"]["Link"] ??
                                  "",
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    ZoWidgetHelper().sizeBoxHeight(14),
                    if (controller.lihatLebihBanyakHistory[index])
                      for (var i = 0;
                          i <
                              controller
                                  .listManajementPromoDataHistory[index]
                                      ["detail"]
                                  .length;
                          i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ZoWidgetHelper().labelText(
                                controller.listManajementPromoDataHistory[index]
                                        ["detail"][i]["head_name"] +
                                    " - " +
                                    controller.listManajementPromoDataHistory[
                                        index]["detail"][i]["carrier_name"] +
                                    " (${controller.listManajementPromoDataHistory[index]["detail"][i]["min_capacity"].toString()} ~ ${controller.listManajementPromoDataHistory[index]["detail"][i]["max_capacity"].toString()} ${controller.listManajementPromoDataHistory[index]["detail"][i]["capacity_unit"]})",
                                Colors.black,
                                14,
                                FontWeight.w700,
                                linespacing:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        (16.8 / 14)),
                            ZoWidgetHelper().sizeBoxHeight(8),
                            if (controller.listManajementPromoDataHistory[index]
                                    ["detail"][i]["normal_price"] !=
                                "0")
                              CustomText(
                                "Rp " +
                                        controller.listManajementPromoDataHistory[
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
                            if (controller.listManajementPromoDataHistory[index]
                                    ["detail"][i]["normal_price"] !=
                                "0")
                              ZoWidgetHelper().sizeBoxHeight(4),
                            Row(
                              children: [
                                ZoWidgetHelper().labelText(
                                    "Rp " +
                                            controller.listManajementPromoDataHistory[
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
                                        controller.listManajementPromoDataHistory[
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
                                              .listManajementPromoDataHistory[
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
                              controller.listManajementPromoDataHistory[index]
                                      ["detail"][0]["head_name"] +
                                  " - " +
                                  controller
                                          .listManajementPromoDataHistory[index]
                                      ["detail"][0]["carrier_name"] +
                                  " (${controller.listManajementPromoDataHistory[index]["detail"][0]["min_capacity"].toString()} ~ ${controller.listManajementPromoDataHistory[index]["detail"][0]["max_capacity"].toString()} ${controller.listManajementPromoDataHistory[index]["detail"][0]["capacity_unit"]})",
                              Colors.black,
                              14,
                              FontWeight.w700,
                              linespacing:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      (16.8 / 14)),
                          ZoWidgetHelper().sizeBoxHeight(8),
                          if (controller.listManajementPromoDataHistory[index]
                                  ["detail"][0]["normal_price"] !=
                              "0")
                            CustomText(
                              "Rp " +
                                      controller.listManajementPromoDataHistory[
                                          index]["detail"][0]["normal_price"] ??
                                  "",
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              color: Color(ListColor.colorGrey3),
                              decoration: TextDecoration.lineThrough,
                            ),
                          if (controller.listManajementPromoDataHistory[index]
                                  ["detail"][0]["normal_price"] !=
                              "0")
                            ZoWidgetHelper().sizeBoxHeight(4),
                          Row(
                            children: [
                              ZoWidgetHelper().labelText(
                                  "Rp " +
                                          controller.listManajementPromoDataHistory[
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
                                      controller.listManajementPromoDataHistory[
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
                                            .listManajementPromoDataHistory[
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
                    if (!controller.lihatLebihBanyakHistory[index])
                      ZoWidgetHelper().sizeBoxHeight(9),
                    Row(
                      children: [
                        Expanded(
                            child: ZoWidgetHelper().labelText(
                                controller.listManajementPromoDataHistory[index]
                                        ["key"]["start_date"] +
                                    " - " +
                                    controller.listManajementPromoDataHistory[
                                        index]["key"]["end_date"],
                                Colors.black,
                                12,
                                FontWeight.w600)),
                        if (controller
                                .listManajementPromoDataHistory[index]["detail"]
                                .length >
                            1)
                          GestureDetector(
                            onTap: () {
                              if (controller.lihatLebihBanyakHistory[index]) {
                                controller.lihatLebihBanyakHistory[index] =
                                    false;
                              } else {
                                controller.lihatLebihBanyakHistory[index] =
                                    true;
                              }
                            },
                            child: CustomText(
                              controller.lihatLebihBanyakHistory[index]
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
                      value: controller.statusHistory[index],
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
                                DateTime now = DateTime.now();
                                DateTime date = DateTime.parse(controller
                                        .listManajementPromoDataHistory[index]
                                    ["key"]["end_date_raw"]);

                                if (now.millisecondsSinceEpoch <
                                    date.millisecondsSinceEpoch) {
                                  controller.postStatusCard(
                                      controller
                                          .listManajementPromoDataHistory[index]
                                              ["key"]["ID"]
                                          .toString(),
                                      strVAL,
                                      "data-promo-history");
                                  controller.statusHistory[index] = value;
                                  controller.strSwitchButonHistory[index] =
                                      "Aktif";
                                } else {
                                  showDialog(
                                      context: Get.context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          // key: GlobalKey<State>(),
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 32.0, vertical: 24.0),
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
                                                            // padding:
                                                            //     EdgeInsets.all(5),
                                                            child: Icon(
                                                          Icons.close_rounded,
                                                          color: Color(
                                                              ListColor.color4),
                                                          size: GlobalVariable
                                                                  .ratioFontSize(
                                                                      context) *
                                                              24,
                                                        ))),
                                                  )),
                                              ZoWidgetHelper().labelText(
                                                  "Promo sudah tidak berlaku pada\nperiode yang dicantumkan. Silahkan\nedit periode promo terlebih dahulu\nuntuk mengaktifkan kembali",
                                                  Colors.black,
                                                  14,
                                                  FontWeight.w500,
                                                  align: TextAlign.center,
                                                  linespacing: GlobalVariable
                                                          .ratioFontSize(
                                                              context) *
                                                      (19.6 / 14)),
                                              ZoWidgetHelper()
                                                  .sizeBoxHeight(20),
                                              OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(ListColor.color4),
                                                    side: BorderSide(
                                                        width: 2,
                                                        color: Color(
                                                            ListColor.color4)),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                    )),
                                                onPressed: () {
                                                  Get.back();
                                                  // filterAction(type);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 10),
                                                  child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        ZoWidgetHelper()
                                                            .labelText(
                                                                "Edit Promo",
                                                                Colors.white,
                                                                14,
                                                                FontWeight.w600)
                                                      ]),
                                                ),
                                              ),
                                              ZoWidgetHelper()
                                                  .sizeBoxHeight(24),
                                            ],
                                          )),
                                        );
                                      });
                                }
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
                                        .listManajementPromoDataHistory[index]
                                            ["key"]["ID"]
                                        .toString(),
                                    strVAL,
                                    "data-promo-history");
                                controller.statusHistory[index] = value;
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
