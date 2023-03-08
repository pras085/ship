import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/bigfleet/bigfleets2_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/home/home/home/home_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/menu_horizontal_scroll1_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subscription/create_subscription_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/transport_market/transport_market_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeView extends GetView<HomeController> {
  final double _sizeIconHeader = 30;
  final double _sizeIconBalance = 30;
  final double _heightBalance = 150;
  final double _sizeIconBelowBalance = 30;
  final double _spaceMenu = 18;
  DateTime currentBackPressTime;
  double _getWidthOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) =>
      _getWidthOfScreen(context) < _getHeightOfScreen(context)
          ? _getWidthOfScreen(context)
          : _getHeightOfScreen(context);
  double _marginHorizontal() => _spaceMenu * 2;
  double _widthContainer(BuildContext context) =>
      _getSizeSmallestWidthHeight(context) - 32;
  double _widthPerMenu(BuildContext context) =>
      (_widthContainer(context) - _marginHorizontal()) / 3;
  double _heightPerMenu(BuildContext context) =>
      (_widthPerMenu(context) * 1.17).roundToDouble();
  double _sizeTextMenu(BuildContext context) => _heightPerMenu(context) / 11.2;
  double _sizeIconMenu(BuildContext context) => _widthPerMenu(context) / 1.5;

  List<MenuHorizontalScroll> listLogisticMenu = [
    // MenuHorizontalScroll(
    //     title: 'Test List',
    //     urlIcon: "big_fleet_icon.png",
    //     onPress: () {
    //       Get.toNamed(Routes.TEST_LIST);
    //       //Get.toNamed(Routes.SHIPPER_BUYER_REGISTER);
    //     }),
    MenuHorizontalScroll(
        title: 'HomeLabelLogisticBigFleets'.tr,
        urlIcon: "big_fleet_icon.png",
        onPress: () {
          GetToPage.toNamed<Bigfleets2Controller>(Routes.BIGFLEETS2);
          //Get.toNamed(Routes.BIGFLEETS2);
          //Get.toNamed(Routes.SHIPPER_BUYER_REGISTER);
        }),
    MenuHorizontalScroll(
        title: 'HomeLabelLogisticTransportMarket'.tr,
        urlIcon: "transport_market_icon.png",
        onPress: () {
          GetToPage.toNamed<TransportMarketController>(Routes.TRANSPORT_MARKET);
        }),
    MenuHorizontalScroll(
      title: 'HomeLabelLogisticMuatTrans'.tr,
      urlIcon: "muatrans_icon.png",
      onPress: () {
        //Get.toNamed(Routes.SHIPPER_BUYER_REGISTER);
      },
    ),
    MenuHorizontalScroll(
        title: 'HomeLabelLogisticTMS'.tr, urlIcon: "tms_icon.png"),
    MenuHorizontalScroll(
        title: 'HomeLabelLogisticWarehouse'.tr, urlIcon: "warehouse_icon.png"),
  ];

  List<MenuHorizontalScroll> listSupportMenu = [
    MenuHorizontalScroll(
        title: 'HomeLabelSupportMerchants'.tr, urlIcon: "merchant_icon.png"),
    MenuHorizontalScroll(
        title: 'HomeLabelSupportMarket'.tr, urlIcon: "market_icon.png"),
    MenuHorizontalScroll(
        title: 'HomeLabelSupportFinanceInsurance'.tr,
        urlIcon: "finance_icon.png"),
    MenuHorizontalScroll(
        title: 'HomeLabelSupportDealershipWorkshop'.tr,
        urlIcon: "dealership_icon.png"),
    MenuHorizontalScroll(
        title: 'HomeLabelSupportHumanCapital'.tr,
        urlIcon: "human_capital_icon.png"),
  ];

  double widthArticle(BuildContext context) =>
      MediaQuery.of(context).size.width - 40;

  List<Widget> _listWidgetLogistic = [];
  List<Widget> _listWidgetSupport = [];

  @override
  Widget build(BuildContext context) {
    _listWidgetLogistic.clear();
    _listWidgetLogistic.addAll(_createListMenu(listLogisticMenu, context));
    _listWidgetSupport.clear();
    _listWidgetSupport.addAll(_createListMenu(listSupportMenu, context));
    return Scaffold(
      backgroundColor: Color(ListColor.color4),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.white,
          child: WillPopScope(
            onWillPop: onWillPop,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                          child: Container(
                              color: Color(ListColor.colorBackHome1))),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 80,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage("assets/smile_icon.png"),
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Wrap(
                                    children: [
                                      Container(
                                        width: _sizeIconHeader + 4,
                                        child: Stack(children: [
                                          IconButton(
                                            icon: Icon(Icons
                                                .notifications_none_outlined),
                                            color: Colors.white,
                                            iconSize: _sizeIconHeader,
                                            onPressed: () {},
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                                width: _sizeIconHeader * 2 / 5,
                                                height: _sizeIconHeader * 2 / 5,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                      ListColor.colorYellow),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                )),
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          CarouselSlider(
                            items: controller.imageSliders.value,
                            options: CarouselOptions(
                                autoPlay: false,
                                enlargeCenterPage: false,
                                aspectRatio: 2.0,
                                enableInfiniteScroll: false,
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
                          Container(
                            height: _heightBalance,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: _heightBalance * 3 / 4,
                                    decoration: BoxDecoration(
                                        color: Color(
                                            ListColor.colorBackgroundHome2),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)),
                                        border: Border.all(
                                            width: 1,
                                            color: Color(ListColor
                                                .colorBackgroundHome2))),
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    elevation: 5,
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FlatButton(
                                              onPressed: () {
                                                Get.toNamed(Routes.BALANCE);
                                              },
                                              minWidth: 0,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 9),
                                                child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      CustomText(
                                                          'HomeLabelBalance'.tr,
                                                          color: Color(ListColor
                                                              .colorTextBalance),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 18),
                                                      Expanded(
                                                          child: RichText(
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.end,
                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text: "Rp ",
                                                                  style: TextStyle(
                                                                      color: Color(ListColor
                                                                              .colorTextBalance)
                                                                          .withAlpha(
                                                                              229),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          GlobalVariable.ratioHeight(Get.context) *
                                                                              14)),
                                                              TextSpan(
                                                                  text:
                                                                      "20.000,-",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorTextBalance),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          GlobalVariable.ratioHeight(Get.context) *
                                                                              18))
                                                            ]),
                                                      )),
                                                      Icon(Icons.navigate_next,
                                                          color: Color(ListColor
                                                              .colorNextBalance))
                                                    ]),
                                              ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                height: 1,
                                                color: Color(ListColor
                                                    .colorLineSeperate)),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _buildMenuBelowBalanceCustomWidget(
                                                      SvgPicture.asset(
                                                          "assets/pay_icon.svg"),
                                                      'HomeLabelButtonPay'.tr,
                                                      () async {
                                                    var status =
                                                        await Permission
                                                            .contacts.status;
                                                    if (!status.isGranted) {
                                                      if (await Permission
                                                          .contacts
                                                          .request()
                                                          .isGranted) {
                                                        Get.toNamed(Routes.PAY);
                                                      }
                                                    } else {
                                                      Get.toNamed(Routes.PAY);
                                                    }
                                                  }),
                                                  _buildMenuBelowBalanceCustomWidget(
                                                      SvgPicture.asset(
                                                          "assets/request_icon.svg"),
                                                      'HomeLabelButtonRequest'
                                                          .tr,
                                                      () => {}),
                                                  _buildMenuBelowBalanceCustomWidget(
                                                      SvgPicture.asset(
                                                          "assets/topup_icon.svg"),
                                                      'HomeLabelButtonTopUp'.tr,
                                                      () => {}),
                                                  _buildMenuBelowBalanceCustomWidget(
                                                      SvgPicture.asset(
                                                          "assets/reward_icon.svg"),
                                                      'HomeLabelButtonReward'
                                                          .tr,
                                                      () => {}),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _buildMenu(_listWidgetLogistic, "HomeLabelMenuLogistic".tr,
                      "HomeLabelMenuLogisticDesc".tr, context),
                  SizedBox(height: 13),
                  _buildMenu(_listWidgetSupport, 'HomeLabelMenuSupport'.tr,
                      'HomeLabelMenuSupportDesc'.tr, context),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "HomeHumanCapital".tr,
                          textAlign: TextAlign.left,
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        Container(height: 14),
                        Container(
                          child: Wrap(
                            spacing: 10,
                            children: [
                              sortLowonganWidget(0, () {}),
                              sortLowonganWidget(1, () {}),
                              sortLowonganWidget(2, () {})
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: CustomText(
                            "5 Jobs Available",
                            textAlign: TextAlign.left,
                            fontSize: 10.0,
                            color: Color(ListColor.colorTextDescriptionMenu1),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: SizedBox(
                      height: 160,
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10,
                            );
                          },
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) =>
                              lowonganWidget(index)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 23, left: 16, right: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CustomText('HomeLabelMenuArticles'.tr,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.ARTICLE),
                          child: CustomText('HomeLabelMenuArticlesSeeMore'.tr,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorTextSeeMoreHome)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 17, bottom: 120),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width - 150,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 16,
                          );
                        },
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          margin: EdgeInsets.only(
                              left: index == 0 ? 16 : 0,
                              right: index == 5 - 1 ? 16 : 0),
                          width: 350,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            elevation: 5,
                            child: FlatButton(
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                onPressed: () {
                                  Get.toNamed(Routes.WEBVIEW);
                                },
                                child: Center(
                                  child: IntrinsicWidth(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6.0)),
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/gambar_example.jpeg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 9),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                CustomText(
                                                    "Penyebrangan Wajib Menggunakan Rapid, Pelabuhan Macet Tertunda",
                                                    maxLines: 2,
                                                    color: Color(ListColor
                                                        .colorTextTitleArticle),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18),
                                                CustomText("\n\n",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: CustomText(
                                                  "6 April 2021",
                                                  color: Color(0xFF717171),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Icon(
                                                Icons.bookmark_border,
                                                color: Colors.black,
                                                size: 16,
                                              )
                                            ],
                                          )
                                        ]),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(),
        child: FloatingActionButton(
          onPressed: () async {
            // var location = Location();
            // if (!await location.serviceEnabled()) {
            //   if (await location.requestService()) {
            //     Get.toNamed(Routes.FIND_TRUCK);
            //   }
            // } else {
            //   Get.toNamed(Routes.FIND_TRUCK);
            // }
            var permissionLocation = await Permission.location.status;
            if (!permissionLocation.isGranted) {
              permissionLocation = await Permission.location.request();
            }
            if (permissionLocation.isGranted) {
              Get.toNamed(Routes.FIND_TRUCK);
            }
          },
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          // SvgPicture.asset("assets/truck_menu_icon.svg",
          //     color: Colors.white),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0)),
              side: BorderSide(color: Colors.white, width: 4.0)),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      CustomToast.show(
          context: Get.context, message: 'GlobalLabelBackAgainExit'.tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _buildMenu(
      List<Widget> listData, String title, String desc, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: _widthContainer(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  textAlign: TextAlign.left,
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 3,
                ),
                CustomText(
                  desc,
                  textAlign: TextAlign.left,
                  fontSize: 10.0,
                  color: Color(ListColor.colorTextDescriptionMenu1),
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              spacing: _spaceMenu,
              runSpacing: _spaceMenu,
              children: listData,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _createListMenu(
      List<MenuHorizontalScroll> listMenu, BuildContext context) {
    List<Widget> listWidget = [];
    for (MenuHorizontalScroll data in listMenu) {
      listWidget.add(Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.5),
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(0, 7),
            ),
          ],
        ),
        height: _heightPerMenu(context),
        width: _widthPerMenu(context),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: data.onPress != null ? data.onPress : () => print("null"),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(9),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Image(
                          image: AssetImage("assets/" + data.urlIcon),
                          width: _sizeIconMenu(context),
                          height: _sizeIconMenu(context),
                          fit: BoxFit.fitWidth,
                        ),
                      ]),
                    ),
                    Stack(alignment: Alignment.center, children: [
                      CustomText(
                        "\n",
                        textAlign: TextAlign.center,
                        color: Colors.transparent,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        data.title,
                        textAlign: TextAlign.center,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ])
                  ]),
            ),
          ),
        ),
      ));
    }
    return listWidget;
  }

  // Widget _menuIcon(BuildContext context) {
  //   double sizeSmallestWidthHeight = _getSizeSmallestWidthHeight(context);
  //   double multiplePadding = _spaceMenu * 2;
  //   double widthHeightMenu =
  //       ((sizeSmallestWidthHeight - multiplePadding) / 3) - _spaceMenu; //72.0;
  //   double widthHeightCircleIcon = widthHeightMenu / 3; //24.0;
  //   double fontSize = widthHeightCircleIcon * 0.35;
  //   return Container(
  //                 margin: EdgeInsets.only(
  //                     left: index == 0 ? 14 : 0,
  //                     right: index == listData.length - 1 ? 14 : 0),
  //                 padding: EdgeInsets.only(bottom: 10),
  //                 child: Card(
  //                   elevation: 2,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   child: Material(
  //                     color: Colors.transparent,
  //                     child: InkWell(
  //                       customBorder: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       onTap: listData[index].onPress != null
  //                           ? listData[index].onPress
  //                           : () => print("null"),
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         width: 110,
  //                         child: Column(children: [
  //                           Image(
  //                             image: AssetImage(
  //                                 "assets/" + listData[index].urlIcon),
  //                             width: 80,
  //                             height: 80,
  //                             fit: BoxFit.fitWidth,
  //                           ),
  //                           Text(
  //                             listData[index].title,
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                                 fontSize: 14, fontWeight: FontWeight.w600),
  //                           )
  //                         ]),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),

  //   Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //             color: Color(bigfleetMenuIcon.colorCircle),
  //           ),
  //           width: widthHeightMenu,
  //           height: widthHeightMenu,
  //           child: Material(
  //             color: Colors.transparent,
  //             child: InkWell(
  //               customBorder: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               onTap: bigfleetMenuIcon.functionOnPress,
  //               child: Container(
  //                 width: widthHeightMenu,
  //                 padding: EdgeInsets.all(6),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   mainAxisSize: MainAxisSize.max,
  //                   children: [
  //                     Container(
  //                         width: widthHeightCircleIcon,
  //                         height: widthHeightCircleIcon,
  //                         child: Center(
  //                           child: Image(
  //                             image: AssetImage(
  //                                 "assets/" + bigfleetMenuIcon.imageIconURL),
  //                             width: widthHeightCircleIcon,
  //                             height: widthHeightCircleIcon,
  //                             fit: BoxFit.fitWidth,
  //                           ),
  //                         )),
  //                     Expanded(
  //                       child: Container(
  //                         alignment: Alignment.bottomLeft,
  //                         child: Text(bigfleetMenuIcon.title,
  //                             textAlign: TextAlign.start,
  //                             maxLines: 3,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(
  //                                 fontSize: fontSize,
  //                                 fontWeight: FontWeight.w600,
  //                                 color: Colors.white)),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  // }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 16),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: isCurrentPage
              ? Color(ListColor.colorIndicatorSelectedHome)
              : Color(ListColor.colorIndicatorNotSelectedHome),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              width: 1,
              color: isCurrentPage ? Colors.white : Color(0x80FFFFFF))),
    );
  }

  Widget _buildMenuBelowBalanceCustomWidget(
      Widget widget, String title, Function() onTapFunction) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTapFunction();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              child: Center(
                child: widget,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 5),
                child: CustomText(title,
                    color: Color(ListColor.colorDarkGrey),
                    fontWeight: FontWeight.w700,
                    fontSize: 10))
          ]),
        ),
      ),
    );
  }

  Widget sortLowonganWidget(int index, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Color(controller.currentLowongan.value == index
                    ? ListColor.colorYellow
                    : 0xFFFFC217),
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: controller.currentLowongan.value == index
                ? Colors.yellow
                : Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: CustomText(
            controller.listSortLowongan[index],
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget lowonganWidget(int index) {
    return Container(
      margin: EdgeInsets.only(
          left: index == 0 ? 14 : 0, right: index == 3 - 1 ? 14 : 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: GlobalVariable.ratioWidth(Get.context) * 260,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Color(0xFFDAE8FF),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.security,
                            color: Color(ListColor.color4),
                            size: 14,
                          ),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: CustomText("Verified User",
                                fontSize: 10,
                                color: Color(ListColor.colorDarkGrey3),
                                fontWeight: FontWeight.w600),
                          )),
                          Icon(
                            Icons.timelapse,
                            color: Color(ListColor.color4),
                            size: 14,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: CustomText("1 minute ago",
                                fontSize: 10,
                                color: Color(ListColor.colorDarkGrey3),
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomText(
                                "Lowongan Supir Ekspedisi Sidoarjo",
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CustomText("PT Maju Jaya",
                                color:
                                    Color(ListColor.colorTextDescriptionMenu1),
                                fontWeight: FontWeight.w400,
                                fontSize: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
