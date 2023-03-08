import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/bigfleets/big_fleets_menu_icon.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet/bigfleets2_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/list_transporter/list_transporter_controller.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_home/subscription_home_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class Bigfleets2View extends GetView<Bigfleets2Controller> {
  double _heightAppBar = 96; //AppBar().preferredSize.height;
  // double _spaceMenu = 9; //AppBar().preferredSize.height;
  double _spaceMenu(BuildContext context) =>
      GlobalVariable.ratioWidth(context) * 10; //AppBar().preferredSize.height;
  double _fontSizeDetailTitleMenuDashboard = 12.0;
  double _spaceBetweenDetailDashboard = 10.0;

  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );

  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) =>
      _getWidthOfScreen(context) < _getHeightOfScreen(context)
          ? _getWidthOfScreen(context)
          : _getHeightOfScreen(context);

  List<BigfleetMenuIcon> _listMenuIcon = [
    BigfleetMenuIcon('Subscription', "subscription.png",
        ListColor.colorBackgroundCircleBigFleetSubscription, () async {
          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAkses(Get.context, "589");
          if (!hasAccess) {
            return;
          }
          GetToPage.toNamed<SubscriptionHomeController>(Routes.SUBSCRIPTION_HOME);
    }),
    BigfleetMenuIcon('BigFleetsLabelMenuTransporter'.tr, "truck_icon.png",
        ListColor.colorBackgroundCircleBigFleetTransporter, () {
      GetToPage.toNamed<ListTransporterController>(Routes.LIST_TRANSPORTER);
    }),
    BigfleetMenuIcon(
        'BigFleetsLabelMenuManagementPartners'.tr,
        "manajemen_mitra_icon.png",
        ListColor.colorBackgroundCircleBigFleetManajemenMitra, () {
      GetToPage.toNamed<ManajemenMitraController>(Routes.MANAJEMEN_MITRA);
    }),
    // BigfleetMenuIcon(
    //     'BigFleetsLabelMenuInfoPraTender'.tr,
    //     "info_pra_tender_icon.png",
    //     ListColor.colorBackgroundCircleBigFleetInfoPraTender, () {
    //   Get.toNamed(Routes.PRATENDER);
    // }),
    BigfleetMenuIcon(
        // 'BigFleetsLabelMenuInfoPraTender'.tr,
        'Tender'.tr,
        "info_pra_tender_icon.png",
        ListColor.colorBackgroundCircleBigFleetInfoPraTender, () {
      Get.toNamed(Routes.TENDER);
    }),
    // BigfleetMenuIcon(
    //     'BigFleetsLabelMenuOrderEntryManagement'.tr,
    //     "manajemen_order_entry_icon.png",
    //     ListColor.colorBackgroundCircleBigFleetManajemenOrderEntry, () {
    //   Get.toNamed(Routes.MANAJEMEN_ORDER_ENTRY);
    // }),
    BigfleetMenuIcon(
        'BigFleetsLabelMenuTruckLocationsReadytoLoad'.tr,
        "lokasi_truk_siap_muat_icon.png",
        ListColor.colorBackgroundCircleBigFleetLokasiTrukSiapMuat, () {
      //Get.toNamed(Routes.DETAIL_LTSM, arguments: [false, "59", "test", true]);

      GetToPage.toNamed<LokasiTrukSiapMuatController>(
          Routes.LOKASI_TRUK_SIAP_MUAT);
      //Get.toNamed(Routes.LOKASI_TRUK_SIAP_MUAT);

      //Get.toNamed(Routes.LOCATION_TRUCK_READY_SEARCH);
      // Get.toNamed(Routes.LIST_SEARCH_TRUCK_SIAP_MUAT);
    }),
    BigfleetMenuIcon(
        'BigFleetsLabelMenuLoadRequestInfo'.tr,
        "info_permintaan_muat_icon.png",
        ListColor.colorBackgroundCircleBigFleetInfoPermintaanMuat, () {
      Get.toNamed(Routes.LIST_INFO_PERMINTAAN_MUAT);
    }),
  ];
  List<Widget> _listWidgetMenuIcon = [];

  @override
  Widget build(BuildContext context) {
    _heightAppBar = _appBar.preferredSize.height;
    _generateLisMenuIcon(context);
    return Container(
      color: Color(ListColor.color4),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(ListColor.colorBlue),
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_appBar.preferredSize.height),
            child: Container(
              height: _heightAppBar,
              width: _getWidthOfScreen(context),
              decoration: BoxDecoration(
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //     color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  //     blurRadius: 10,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                  color: Color(ListColor.color4)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ClipOval(
                          child: Material(
                              shape: CircleBorder(),
                              color: Color(ListColor.color4),
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      width: _heightAppBar - 20,
                                      height: _heightAppBar - 20,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: (_heightAppBar * 1.7 / 4) * 0.7,
                                        color: Colors.white,
                                      ))))),
                        ),
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        'HomeLabelLogisticBigFleets'.tr,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: (_heightAppBar / 3) - 2,
                      )
                    ]),
                  ),
                  // Align(
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       'HomeLabelLogisticBigFleets'.tr,
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: _heightAppBar / 3),
                  //     )),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Opacity(
                  //     opacity: 0.3,
                  //     child: Image(
                  //       image: AssetImage("assets/big_fleet_icon.png"),
                  //       width: 89,
                  //       height: 89,
                  //       fit: BoxFit.fitWidth,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          // PreferredSize(
          //   preferredSize: Size.fromHeight(_heightAppBar + 2.0),
          //   child: SafeArea(
          //     child: Container(
          //       color: Colors.white,
          //       width: MediaQuery.of(context).size.width,
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Stack(
          //             children: [
          //               Align(
          //                   alignment: Alignment.centerLeft,
          //                   child: IconButton(
          //                     icon: Icon(Icons.arrow_back),
          //                     onPressed: () {
          //                       Get.back();
          //                     },
          //                   )),
          //               Align(
          //                 alignment: Alignment.center,
          //                 child: Container(
          //                   height: _heightAppBar,
          //                   child: Row(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: [
          //                       Image(
          //                         image: AssetImage("assets/big_fleet_icon.png"),
          //                         width: 40,
          //                         height: 40,
          //                         fit: BoxFit.fitWidth,
          //                       ),
          //                       SizedBox(
          //                         width: 10.0,
          //                       ),
          //                       Text(
          //                         'HomeLabelLogisticBigFleets'.tr,
          //                         style: TextStyle(
          //                             fontWeight: FontWeight.w700,
          //                             fontSize: getFontSize(21.0)),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           Container(
          //             width: MediaQuery.of(context).size.width,
          //             height: 2.0,
          //             color: Color(ListColor.colorBlue),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          body: Container(
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                SingleChildScrollView(
                  child: Container(
                    //padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 100.0),
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.only(bottom: 100.0),
                    child: Column(
                      children: [
                        Container(
                          width: _getWidthOfScreen(context),
                          height: 144,
                          child: CarouselSlider(
                            items: controller.imageSliders.value,
                            options: CarouselOptions(
                                autoPlay: false,
                                enlargeCenterPage: false,
                                aspectRatio: 2.0,
                                onPageChanged: (index, reason) {
                                  controller.indexImageSlider.value = index;
                                }),
                          ),
                        ),
                        Obx(
                          () => Container(
                            margin: EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < controller.imageSliders.value.length;
                                    i++)
                                  i == controller.indexImageSlider.value
                                      ? _buildPageIndicator(true)
                                      : _buildPageIndicator(false),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          width: _getWidthOfScreen(context),
                          //padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                          child: Center(
                            child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.center,
                              spacing: _spaceMenu(Get.context),
                              runSpacing: _spaceMenu(Get.context),
                              children: _listWidgetMenuIcon,
                            ),
                          ),
                        ),
                        _getMenuDetail(
                            title: 'Info Pra Tender'.tr,
                            detailTitle: 'BigFleetsLabelIPTDetailActivity'.tr +
                                " Februari 2020",
                            detailRowTitle1: 'Selesai',
                            detailRowValue1: "12",
                            detailRowTitleTop2: 'Aktif hari ini',
                            detailRowValueTop2: "10",
                            detailRowTitleBottom2: 'Total dibuat',
                            detailRowValueBottom2: "7",
                            colorDetailRowValueBottom2: ListColor.colorGreen,
                            detailRowTitleTop3: 'Dibuat hari ini',
                            detailRowValueTop3: "2",
                            detailRowTitleBottom3: 'Kadaluarsa',
                            detailRowValueBottom3: "10",
                            colorDetailRowValueBottom3: ListColor.colorRed,
                            iconBackgroundColor: ListColor
                                .colorBackgroundCircleBigFleetInfoPraTender,
                            urlIcon: "info_pra_tender_icon.png"),
                        _getMenuDetail(
                            title: 'Order Entry'.tr,
                            detailTitle: 'BigFleetsLabelIPTDetailActivity'.tr +
                                " 12 Februari 2020",
                            detailRowTitle1: 'Selesai',
                            detailRowValue1: "2",
                            detailRowTitleTop2: 'Dalam Proses',
                            detailRowValueTop2: "12",
                            detailRowTitleBottom2: 'Total dibuat',
                            detailRowValueBottom2: "7",
                            colorDetailRowValueBottom2: ListColor.colorGreen,
                            detailRowTitleTop3: 'Dibuat hari ini',
                            detailRowValueTop3: "2",
                            detailRowTitleBottom3: 'Ditunda',
                            detailRowValueBottom3: "3",
                            colorDetailRowValueBottom3: ListColor.colorRed,
                            iconBackgroundColor:
                                ListColor.colorIconHeaderOrderEntryDashboard,
                            urlIcon: "manajemen_order_entry_icon.png"),
                        _getMenuDetail(
                            title: 'Info Permintaan Muat'.tr,
                            detailTitle: 'BigFleetsLabelIPTDetailActivity'.tr +
                                " Februari 2020",
                            detailRowTitle1: 'Selesai',
                            detailRowValue1: "0",
                            detailRowTitleTop2: 'Aktif hari ini',
                            detailRowValueTop2: "10",
                            detailRowTitleBottom2: 'Total dibuat',
                            detailRowValueBottom2: "2",
                            colorDetailRowValueBottom2: ListColor.colorGreen,
                            detailRowTitleTop3: 'Dibuat hari ini',
                            detailRowValueTop3: "2",
                            detailRowTitleBottom3: 'Kadaluarsa',
                            detailRowValueBottom3: "0",
                            colorDetailRowValueBottom3: ListColor.colorRed,
                            iconBackgroundColor: ListColor
                                .colorIconHeaderInfoPermintaanMuatDashboard,
                            urlIcon: "info_permintaan_muat_icon.png"),
                        _getMenuDetail(
                            title: 'Mitra'.tr,
                            detailTitle: 'BigFleetsLabelIPTDetailActivity'.tr +
                                " 12 Desember 2020",
                            detailRowTitle1: 'Total Mitra',
                            detailRowValue1: "12",
                            detailRowTitleTop2: 'Transporter Big Fleet',
                            detailRowValueTop2: "100",
                            detailRowTitleBottom2:
                                'Permintaan dari Transporter',
                            detailRowValueBottom2: "7",
                            detailRowTitleTop3: '',
                            detailRowValueTop3: "",
                            detailRowTitleBottom3: 'Permintaan ke Transporter',
                            detailRowValueBottom3: "10",
                            iconBackgroundColor:
                                ListColor.colorIconHeaderMitraDashboard,
                            urlIcon: "mitra_icon.png",
                            widthHeightIconInsideCircle: 24.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBarMuat(
            centerItemText: '',
            color: Colors.grey,
            backgroundColor: Colors.white,
            selectedColor: Color(ListColor.colorSelectedBottomMenu),
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: (index) async {
              switch (index) {
                case 0:
                  {
                    // GetToPage.toNamed(Routes.INBOX);
                    await Chat.init(GlobalVariable.docID, GlobalVariable.fcmToken);
                    Chat.toInbox();
                    break;
                  }
                case 1:
                  {
                    // Get.toNamed(Routes.SETTING);
                    // GetToPage.toNamed(Routes.PROFILE_SHIPPER);
                    Get.toNamed(Routes.PROFIL);
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
          // body: _list[_page],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(),
            child: FloatingActionButton(
              backgroundColor: Color(ListColor.colorYellow),
              onPressed: () {
                //Get.toNamed(Routes.FIND_TRUCK);
              },
              child: Image(
                image: AssetImage("assets/smile_muat_muat_icon.png"),
                width: 60,
                height: 60,
              ),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  side: BorderSide(color: Colors.white, width: 4.0)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: isCurrentPage
              ? Color(ListColor.colorIndicatorSelectedBigFleet2)
              : Color(ListColor.colorIndicatorSelectedBigFleet2)
                  .withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.white)),
    );
  }

  void _generateLisMenuIcon(BuildContext context) {
    _listWidgetMenuIcon.clear();
    final int maxItem = 4;
    int pos = 0;
    //List<Widget> listDetailMenu = [];
    for (int i = 0; i < _listMenuIcon.length; i++) {
      _listWidgetMenuIcon.add(_menuIcon(context, _listMenuIcon[i]));
      // pos++;
      // if (pos == maxItem || i + 1 == _listMenuIcon.length) {
      //   if (pos < maxItem) {
      //     while (pos < maxItem) {
      //       listDetailMenu.add(_menuIcon(context, null));
      //       pos++;
      //     }
      //   }
      //   pos = 0;
      //   _listWidgetMenuIcon.add(Container(
      //     margin: EdgeInsets.only(bottom: 20.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: listDetailMenu,
      //     ),
      //   ));
      //   if (i + 1 < _listMenuIcon.length) listDetailMenu = [];
      // }
    }
  }

  Widget _menuIcon(BuildContext context, BigfleetMenuIcon bigfleetMenuIcon) {
    double sizeSmallestWidthHeight = _getSizeSmallestWidthHeight(context);
    double multiplePadding = _spaceMenu(Get.context) * 2;
    double widthHeightMenu = ((sizeSmallestWidthHeight - multiplePadding) / 3) -
        _spaceMenu(Get.context); //72.0;
    double widthHeightCircleIcon = widthHeightMenu / 3; //24.0;
    double fontSize = widthHeightCircleIcon * 0.35;
    return bigfleetMenuIcon == null
        ? Container(
            width: widthHeightMenu,
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(bigfleetMenuIcon.colorCircle),
            ),
            width: widthHeightMenu,
            height: widthHeightMenu,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: bigfleetMenuIcon.functionOnPress,
                child: Container(
                  width: widthHeightMenu,
                  padding: EdgeInsets.all(
                      GlobalVariable.ratioWidth(Get.context) * 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image(
                        image: AssetImage(
                            "assets/" + bigfleetMenuIcon.imageIconURL),
                        // width: widthHeightCircleIcon,
                        height: widthHeightCircleIcon,
                        fit: BoxFit.fitHeight,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: CustomText(bigfleetMenuIcon.title,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  double getFontSize(double originalSize) {
    return originalSize;
  }

  Widget _getMenuDetail(
      {String title,
      String detailTitle,
      String detailRowTitle1,
      String detailRowValue1,
      int detailRowValue1Color = 0xFF000000,
      String detailRowTitleTop2,
      String detailRowValueTop2,
      int colorDetailRowValueTop2 = 0xFF000000,
      String detailRowTitleBottom2,
      String detailRowValueBottom2,
      int colorDetailRowValueBottom2 = 0xFF000000,
      String detailRowTitleTop3,
      String detailRowValueTop3,
      int colorDetailRowValueTop3 = 0xFF000000,
      String detailRowTitleBottom3,
      String detailRowValueBottom3,
      int colorDetailRowValueBottom3 = 0xFF000000,
      int iconBackgroundColor,
      String urlIcon,
      double widthHeightIconInsideCircle = 0.0}) {
    double _heightDivider = 50.75;
    double _widthHeightIcon = 40.0;
    widthHeightIconInsideCircle = widthHeightIconInsideCircle == 0.0
        ? _widthHeightIcon * 0.6
        : widthHeightIconInsideCircle;
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 0),
      width: _getSizeSmallestWidthHeight(Get.context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        elevation: 5,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        topRight: Radius.circular(6.0)),
                    color: Colors.transparent),
                child: Stack(
                  children: [
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: Image(
                    //     image: AssetImage("assets/mask_header_menu.png"),
                    //     height: 50.0,
                    //     fit: BoxFit.fitWidth,
                    //   ),
                    // ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomText(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                              fontSize: getFontSize(20) - 2,
                            ),
                          ),
                          Container(
                              width: _widthHeightIcon,
                              height: _widthHeightIcon,
                              decoration: BoxDecoration(
                                color: Color(iconBackgroundColor),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image(
                                  image: AssetImage("assets/" + urlIcon),
                                  width: widthHeightIconInsideCircle,
                                  height: widthHeightIconInsideCircle,
                                  fit: BoxFit.fitWidth,
                                ),
                              )),
                          // Icon(Icons.keyboard_arrow_down, color: Colors.white)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                width: MediaQuery.of(Get.context).size.width,
                height: 1,
                color: Color(ListColor.colorStroke),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CustomText(detailTitle,
                    fontSize: getFontSize(16) - 2,
                    fontWeight: FontWeight.w700,
                    color: Color(ListColor.colorDarkGrey2)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 7, bottom: 7),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _perDetailTextTitleDashboard(detailRowTitle1),
                              SizedBox(height: 20),
                              CustomText(
                                detailRowValue1,
                                fontSize: getFontSize(50) - 2,
                                fontWeight: FontWeight.w800,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       _perRowDetail(
                      //           detailRowTitleTop2,
                      //           detailRowValueTop2,
                      //           colorDetailRowValueTop2,
                      //           detailRowTitleTop3,
                      //           detailRowValueTop3,
                      //           colorDetailRowValueTop3),
                      //       _perRowDetail(
                      //           detailRowTitleBottom2,
                      //           detailRowValueBottom2,
                      //           colorDetailRowValueBottom2,
                      //           detailRowTitleBottom3,
                      //           detailRowValueBottom3,
                      //           colorDetailRowValueBottom3)
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        width: _spaceBetweenDetailDashboard,
                      ),
                      Expanded(
                        child: _perColumnDetail(
                            detailRowTitleTop2,
                            detailRowValueTop2,
                            colorDetailRowValueTop2,
                            detailRowTitleBottom2,
                            detailRowValueBottom2,
                            colorDetailRowValueBottom2),
                      ),
                      SizedBox(
                        width: _spaceBetweenDetailDashboard,
                      ),
                      Expanded(
                        child: _perColumnDetail(
                            detailRowTitleTop3,
                            detailRowValueTop3,
                            colorDetailRowValueTop3,
                            detailRowTitleBottom3,
                            detailRowValueBottom3,
                            colorDetailRowValueBottom3),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _perColumnDetail(
      String detailRowTitleTop,
      String detailRowValueTop,
      int colorDetailRowValueTop,
      String detailRowTitleBottom,
      String detailRowValueBottom,
      int colorDetailRowValueBottom) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _perColumnDetail2(
              detailRowTitleTop, detailRowValueTop, colorDetailRowValueTop),
          SizedBox(
            height: 5,
          ),
          _perColumnDetail2(detailRowTitleBottom, detailRowValueBottom,
              colorDetailRowValueBottom),
        ],
      ),
    );
  }

  Widget _perColumnDetail2(
      String detailRowTitle, String detailRowValue, int colorDetailRowValue) {
    return Stack(
      children: [
        _perColumnDetailWidget("", "0", Colors.transparent),
        _perColumnDetailWidget(
            detailRowTitle, detailRowValue, Color(colorDetailRowValue)),
      ],
    );
  }

  Widget _perColumnDetailWidget(
      String detailRowTitle, String detailRowValue, Color colorDetailRowValue) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _perDetailTextTitleDashboard(detailRowTitle),
        SizedBox(height: 5),
        CustomText(detailRowValue,
            fontSize: getFontSize(30) - 2,
            fontWeight: FontWeight.w800,
            color: colorDetailRowValue),
      ],
    );
  }

  Widget _perDetailTextTitleDashboard(String title) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        _perDetailTextTitleDashboardWidget("\n"),
        _perDetailTextTitleDashboardWidget(title)
      ],
    );
  }

  Widget _perDetailTextTitleDashboardWidget(String title) {
    return CustomText(
      title,
      textAlign: TextAlign.left,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      fontSize: getFontSize(_fontSizeDetailTitleMenuDashboard) - 2,
      color: Color(ListColor.colorDarkGrey2),
      fontWeight: FontWeight.w600,
    );
  }

  Widget _perRowDetail(
      String detailRowTitleLeft,
      String detailRowValueLeft,
      int colorDetailRowValueLeft,
      String detailRowTitleRight,
      String detailRowValueRight,
      int colorDetailRowValueRight) {
    return Container(
      height: 131,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _perColumnDetail2(
              detailRowTitleLeft, detailRowValueLeft, colorDetailRowValueLeft),
          _perColumnDetail2(detailRowTitleRight, detailRowValueRight,
              colorDetailRowValueRight),
        ],
      ),
    );
  }
}
