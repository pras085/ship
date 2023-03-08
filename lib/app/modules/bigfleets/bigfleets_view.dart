import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/modules/bigfleets/big_fleets_menu_icon.dart';
import 'package:muatmuat/app/modules/bigfleets/bigfleets_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/global_variable.dart';

class BigfleetsView extends GetView<BigfleetsController> {
  double _heightAppBar = AppBar().preferredSize.height;
  List<BigfleetMenuIcon> _listMenuIcon = [
    BigfleetMenuIcon('BigFleetsLabelMenuTransporter'.tr, "truck_icon.png",
        ListColor.colorBackgroundCircleBigFleetTransporter, () {
      Get.toNamed(Routes.LIST_TRANSPORTER);
    }),
    BigfleetMenuIcon(
        'BigFleetsLabelMenuManagementPartners'.tr,
        "manajemen_mitra_icon.png",
        ListColor.colorBackgroundCircleBigFleetManajemenMitra, () {
      Get.toNamed(Routes.MANAJEMEN_MITRA);
    }),
    BigfleetMenuIcon(
        'BigFleetsLabelMenuInfoPraTender'.tr,
        "info_pra_tender_icon.png",
        ListColor.colorBackgroundCircleBigFleetInfoPraTender, () {
      Get.toNamed(Routes.PRATENDER);
    }),
    BigfleetMenuIcon(
        'BigFleetsLabelMenuOrderEntryManagement'.tr,
        "manajemen_order_entry_icon.png",
        ListColor.colorBackgroundCircleBigFleetManajemenOrderEntry, () {
      Get.toNamed(Routes.MANAJEMEN_ORDER_ENTRY);
    }),
    BigfleetMenuIcon(
        'BigFleetsLabelMenuTruckLocationsReadytoLoad'.tr,
        "lokasi_truk_siap_muat_icon.png",
        ListColor.colorBackgroundCircleBigFleetLokasiTrukSiapMuat, () {
      // Get.toNamed(Routes.DETAIL_LTSM);
      Get.toNamed(Routes.LOCATION_TRUCK_READY_SEARCH);
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
    _generateLisMenuIcon(context);
    return Scaffold(
      backgroundColor: Color(ListColor.colorBlue),
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          child: Container(
            color: Color(ListColor.color4),
            height: 2,
          ),
          preferredSize: Size.fromHeight(2),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage("assets/big_fleet_icon.png"),
              width: 40,
              height: 40,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'HomeLabelLogisticBigFleets'.tr,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: getFontSize(21.0)),
            )
          ],
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
                padding: EdgeInsets.only(top: 20.0, bottom: 100.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _listWidgetMenuIcon,
                      ),
                    ),
                    CarouselSlider(
                      items: controller.imageSliders.value,
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: false,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            controller.indexImageSlider.value = index;
                          }),
                    ),
                    Obx(
                      () => Row(
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
                    _getMenuDetail(
                        title: 'BigFleetsLabelTitleInfoPraTender'.tr,
                        detailColumnTitle1:
                            'BigFleetsLabelIPTDetailTotalActivePerDay'.tr,
                        detailColumnValue1: "10",
                        detailColumnTitle2:
                            'BigFleetsLabelIPTDetailMadeAsOfToday'.tr,
                        detailColumnValue2: "2",
                        detailCenterTitle1:
                            'BigFleetsLabelIPTDetailActivity'.tr +
                                " Februari 2020",
                        detailRowTitle1: 'BigFleetsLabelIPTDetailMade'.tr,
                        detailRowValue1: "210",
                        detailRowValue1Color: ListColor.colorGreen,
                        detailRowTitle2: 'BigFleetsLabelIPTDetailExpired'.tr,
                        detailRowValue2: "345",
                        detailRowValue2Color: ListColor.colorRed,
                        detailRowTitle3: 'BigFleetsLabelIPTDetailFinished'.tr,
                        detailRowValue3: "125",
                        detailRowValue3Color: ListColor.colorBlue,
                        headerColor:
                            ListColor.colorHeaderMenuInfoPraTenderBigFleet),
                    _getMenuDetail(
                        title: 'BigFleetsLabelTitleOrderEntry'.tr,
                        detailColumnTitle1:
                            'BigFleetsLabelOEDetailTotalInProgress'.tr,
                        detailColumnValue1: "12",
                        detailColumnTitle2:
                            'BigFleetsLabelOEDetailMadeAsOfToday'.tr,
                        detailColumnValue2: "2",
                        detailCenterTitle1:
                            'BigFleetsLabelOEDetailActivityPer'.tr +
                                " 12 Desember 2020",
                        detailRowTitle1:
                            'BigFleetsLabelOEDetailWaitingForConfirmation'.tr,
                        detailRowValue1: "3",
                        detailRowValue1Color: ListColor.colorYellow,
                        detailRowTitle2: 'BigFleetsLabelOEDetailDone'.tr,
                        detailRowValue2: "11",
                        detailRowValue2Color: ListColor.colorBlue,
                        detailRowTitle3: 'BigFleetsLabelOEDetailRejected'.tr,
                        detailRowValue3: "7",
                        detailRowValue3Color: ListColor.colorRed,
                        headerColor:
                            ListColor.colorHeaderMenuOrderEntryBigFleet),
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
                // Get.toNamed(Routes.INBOX);
                await Chat.init(GlobalVariable.docID, GlobalVariable.fcmToken);
                Chat.toInbox();
                break;
              }
            case 1:
              {
                // Get.toNamed(Routes.PROFILE_SHIPPER);
                Get.toNamed(Routes.PROFIL);
                break;
              }
          }
        },
        items: [
          BottomAppBarItemModel(iconName: 'message_menu_icon.svg', text: ''),
          BottomAppBarItemModel(iconName: 'user_menu_icon.svg', text: ''),
        ],
        iconSize: 40,
      ),
      // body: _list[_page],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isCurrentPage
              ? Color(ListColor.colorIndicatorSelectedBigFleet)
              : Color(ListColor.colorIndicatorNotSelectedBigFleet),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: Colors.white)),
    );
  }

  void _generateLisMenuIcon(BuildContext context) {
    _listWidgetMenuIcon.clear();
    final int maxItem = 4;
    int pos = 0;
    List<Widget> listDetailMenu = [];
    for (int i = 0; i < _listMenuIcon.length; i++) {
      listDetailMenu.add(_menuIcon(context, _listMenuIcon[i]));
      pos++;
      if (pos == maxItem || i + 1 == _listMenuIcon.length) {
        if (pos < maxItem) {
          while (pos < maxItem) {
            listDetailMenu.add(_menuIcon(context, null));
            pos++;
          }
        }
        pos = 0;
        _listWidgetMenuIcon.add(Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listDetailMenu,
          ),
        ));
        if (i + 1 < _listMenuIcon.length) listDetailMenu = [];
      }
    }
  }

  Widget _menuIcon(BuildContext context, BigfleetMenuIcon bigfleetMenuIcon) {
    double widthHeightCircleIcon = 42.0;
    double widthHeightMenu = 75.0;
    return bigfleetMenuIcon == null
        ? Container(
            width: widthHeightMenu,
          )
        : Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: bigfleetMenuIcon.functionOnPress,
              child: Container(
                width: widthHeightMenu,
                padding: EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: widthHeightCircleIcon,
                        height: widthHeightCircleIcon,
                        margin: EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: Color(bigfleetMenuIcon.colorCircle),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image(
                            image: AssetImage(
                                "assets/" + bigfleetMenuIcon.imageIconURL),
                            width: widthHeightCircleIcon * 0.6,
                            height: widthHeightCircleIcon * 0.6,
                            fit: BoxFit.fitWidth,
                          ),
                        )),
                    Text(bigfleetMenuIcon.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: getFontSize(10),
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
            ),
          );
  }

  double getFontSize(double originalSize) {
    return originalSize + 1;
  }

  Widget _getMenuDetail({
    String title,
    String detailColumnTitle1,
    String detailColumnValue1,
    String detailColumnTitle2,
    String detailColumnValue2,
    String detailCenterTitle1,
    String detailRowTitle1,
    String detailRowValue1,
    int detailRowValue1Color,
    String detailRowTitle2,
    String detailRowValue2,
    int detailRowValue2Color,
    String detailRowTitle3,
    String detailRowValue3,
    int detailRowValue3Color,
    int headerColor,
  }) {
    double _heightDivider = 50.75;
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 5,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: Color(headerColor)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image(
                        image: AssetImage("assets/mask_header_menu.png"),
                        height: 50.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: getFontSize(21),
                                color: Colors.white),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Colors.white)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 11.0),
                            child: Row(
                              children: [
                                Text(detailColumnTitle1 + ": ",
                                    style: TextStyle(
                                        fontSize: getFontSize(14.0),
                                        fontWeight: FontWeight.w600)),
                                Text(detailColumnValue1,
                                    style: TextStyle(
                                        fontSize: getFontSize(14.0),
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 11.0),
                            child: Row(
                              children: [
                                Text(detailColumnTitle2 + ": ",
                                    style: TextStyle(
                                        fontSize: getFontSize(14.0),
                                        fontWeight: FontWeight.w600)),
                                Text(detailColumnValue2,
                                    style: TextStyle(
                                        fontSize: getFontSize(14.0),
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 11.0),
                      child: Text(detailCenterTitle1,
                          style: TextStyle(
                              fontSize: getFontSize(16.0),
                              fontWeight: FontWeight.w700)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Row(children: [
                              Expanded(
                                child: Container(
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 7.0),
                                          child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                Text(detailRowTitle1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize:
                                                            getFontSize(10.0),
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text("\n",
                                                    style: TextStyle(
                                                        fontSize:
                                                            getFontSize(10.0),
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ]),
                                        ),
                                        Text(detailRowValue1,
                                            style: TextStyle(
                                                fontSize: getFontSize(15.0),
                                                fontWeight: FontWeight.w600,
                                                color: Color(
                                                    detailRowValue1Color))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: _heightDivider,
                                color: Color(ListColor.colorGrey),
                              ),
                            ]),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 7.0),
                                    child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Text(detailRowTitle2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: getFontSize(10.0),
                                                  fontWeight: FontWeight.w600)),
                                          Text("\n",
                                              style: TextStyle(
                                                  fontSize: getFontSize(10.0),
                                                  fontWeight: FontWeight.w600)),
                                        ]),
                                  ),
                                  Text(detailRowValue2,
                                      style: TextStyle(
                                          fontSize: getFontSize(15.0),
                                          fontWeight: FontWeight.w600,
                                          color: Color(detailRowValue2Color))),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(children: [
                              Container(
                                width: 1,
                                height: _heightDivider,
                                color: Color(ListColor.colorGrey),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 7.0),
                                        child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Text(detailRowTitle3,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize:
                                                          getFontSize(10.0),
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              Text("\n",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getFontSize(10.0),
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ]),
                                      ),
                                      Text(detailRowValue3,
                                          style: TextStyle(
                                              fontSize: getFontSize(15.0),
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color(detailRowValue3Color))),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
