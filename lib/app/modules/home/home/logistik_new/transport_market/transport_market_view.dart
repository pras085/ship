import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/cari_harga_transport/cari_harga_transport_controller.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/hasil_cari_harga_transport/hasil_cari_harga_transport_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/subscription_home/tm_subscription_home_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/transport_market/transport_market_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik_new/transport_market/menu_horizontal_scroll_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_muatan/ZO_list_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_list_harga_promo/ZO_list_harga_promo_controller.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_item_model.dart';
import 'package:muatmuat/app/modules/home/home/home/bottom_app_bar_widget.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_home/subscription_home_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/scaffold_with_bottom_navbar.dart';

class TransportMarketView extends GetView<TransportMarketController> {
  final form = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  var emptyMessage = false.obs;
  final double _spaceMenu = GlobalVariable.ratioWidth(Get.context) * 11.11;

  List<MenuHorizontalScrollTransportMarket> listLogisticMenu = [
    MenuHorizontalScrollTransportMarket(
        title: "TransportMarketIndexLabelSubscription".tr, //Subscription
        icon: GlobalVariable.imagePath + "ic_subscription.svg",
        color: ListColor.colorWhite,
        onPress: () async {
          // var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "612");
          // if (!hasAccess) {
          //   return;
          // }
          GetToPage.toNamed<TMSubscriptionHomeController>(Routes.TM_SUBSCRIPTION_HOME);
        }),
    MenuHorizontalScrollTransportMarket(
        title: "Lelang Muatan".tr, // Lelang Muatan
        icon: GlobalVariable.imagePath + "ic_lelang_muatan.svg",
        color: ListColor.colorWhite,
        onPress: () {
          GetToPage.toNamed<ZoListMuatanController>(Routes.ZO_LELANG_MUATAN,
              preventDuplicates: false, arguments: [""]);
          // GetToPage.toNamed<LelangMuatanController>(Routes.LELANG_MUATAN,
          //     preventDuplicates: false, arguments: [""]);
        }),
    MenuHorizontalScrollTransportMarket(
      // title: "TransportMarketIndexLabelManajemenHargaTransport"
      //     .tr, // Manajemen Harga Transport
      // title: "Cari Harga Transport",
      title: "CariHargaTransportIndexLabelCariHargaTransport".tr,
      icon: GlobalVariable.imagePath + "ic_cari_harga.svg",
      color: ListColor.colorWhite,
      onPress: () {
        // GetToPage.toNamed<CariHargaTransportController>(
        //     Routes.CARI_HARGA_TRANSPORT,
        //     preventDuplicates: false,
        //     arguments: [""]);
        GetToPage.toNamed<HasilCariHargaTransportController>(
            Routes.CARI_HARGA_TRANSPORT,
            preventDuplicates: false,
            arguments: [""]);
      },
    ),
    MenuHorizontalScrollTransportMarket(
      title: "Promo Transporter".tr, // Promo Transporter
      icon: GlobalVariable.imagePath + "ic_promo.svg",
      color: ListColor.colorWhite,
      onPress: (){
        GetToPage.toNamed<ZoPromoTransporterController>(
            Routes.ZO_PROMO_TRANSPORTER,
            preventDuplicates: false,
            arguments: [""],
          );
        // GetToPage.toNamed<ZoListHargaPromoController>(
        //       Routes.ZO_LIST_HARGA_PROMO,
        //       preventDuplicates: false,
        //       arguments: [""]);
      }
    )
  ];
//
  List<Widget> _listWidgetLogistic = [];

  double _getWidthOfScreen(BuildContext context) => MediaQuery.of(context).size.width;
  double _getHeightOfScreen(BuildContext context) => MediaQuery.of(context).size.height;
  double _getSizeSmallestWidthHeight(BuildContext context) => _getWidthOfScreen(context) < _getHeightOfScreen(context) ? _getWidthOfScreen(context) : _getHeightOfScreen(context);
  double _marginHorizontal() => _spaceMenu * 2;
  double _widthContainer(BuildContext context) => _getSizeSmallestWidthHeight(context) - 32;
  double _widthPerMenu(BuildContext context) => (_widthContainer(context) - _marginHorizontal()) / 3;
  double _heightPerMenu(BuildContext context) => (_widthPerMenu(context) * 1.17).roundToDouble();
  double _sizeTextMenu(BuildContext context) => _heightPerMenu(context) / 11.2;
  double _sizeIconMenu(BuildContext context) => _widthPerMenu(context) / 1.5;

  AppBar _appBar = AppBar(
    title: CustomText('Transport Market'.tr), // Transport Market
  );

  @override
  Widget build(BuildContext context) {
    _listWidgetLogistic.clear();
    _listWidgetLogistic.addAll(_createListMenu(listLogisticMenu, context));
    return Obx(() => ScaffoldWithBottomNavbar(
      newNotif: controller.newNotif.value,
      body:!controller.loading.value ? SafeArea(
        bottom: false,
        child: Container(
          color: Color(ListColor.colorBackHome1),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * (143 - kToolbarHeight)
                ),
                child: Image(
                  image: AssetImage(GlobalVariable.imagePath + "hero.png"),
                  width: MediaQuery.of(Get.context).size.width,
                ), 
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(context) * 16),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomBackButton(
                                context: context, 
                                iconColor: Color(ListColor.colorBlue),
                                backgroundColor: Colors.white,
                                onTap: () {
                                  Get.back();
                                }
                              ),
                              Container(
                                width: GlobalVariable.ratioWidth(context) * 141,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomText(
                                      'Transport Market',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      textAlign: TextAlign.end,
                                      height: 1.5,
                                      color: Colors.white,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: GlobalVariable.ratioWidth(Get.context) * 1,
                                          left: GlobalVariable.ratioWidth(Get.context) * 3,
                                          right: GlobalVariable.ratioWidth(Get.context) * 2
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 3))
                                        ),
                                        child: CustomText(
                                          'Shipper',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                          color: Color(ListColor.colorBlue),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: GlobalVariable.ratioWidth(context) * 24)
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: GlobalVariable.ratioWidth(context) * 21),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(context) * 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/transport_market.png',
                            width: GlobalVariable.ratioWidth(context) * 130,
                            height: GlobalVariable.ratioWidth(context) * 88,
                          ),
                          SizedBox(width: GlobalVariable.ratioWidth(context) * 38),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'TransportMarketIndexAyo'.tr,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
                                CustomText(
                                  'TransportMarketShipperDesc'.tr,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.2,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: GlobalVariable.ratioWidth(context) * 26),
                    Container(
                      padding: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 24,
                        left: GlobalVariable.ratioWidth(Get.context) * 16,
                        right: GlobalVariable.ratioWidth(Get.context) * 16,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
                          topRight: Radius.circular(GlobalVariable.ratioWidth(context) * 10),
                        )
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _buildMenu(_listWidgetLogistic, "TransportMarketIndexLayananTransportMarket".tr, "${_listWidgetLogistic.length} " + "TransportMarketIndexLayananTersedia".tr, context),
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 15),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              "TransportMarketIndexPromoHariIni".tr,
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 14),
                          CarouselSlider(
                            items: controller.imageSliders.value,
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: false,
                              viewportFraction: 1,
                              height: GlobalVariable.ratioWidth(context) * 82,
                              onPageChanged: (index, reason) {
                                controller.indexImageSlider.value = index;
                              },
                            ),
                          ),
                          Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < controller.imageSliders.value.length; i++)
                                _buildPageIndicator(i == controller.indexImageSlider.value),
                            ],
                          )),
                          SizedBox(height: GlobalVariable.ratioWidth(context) * 102),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        )
      ) : Center(child: CircularProgressIndicator())
    ));
  }

  Widget _buildMenu(List<Widget> listData, String title, String desc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title,
          textAlign: TextAlign.left,
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
        CustomText(
          desc,
          textAlign: TextAlign.left,
          fontSize: 12,
          color: Color(ListColor.colorGrey4),
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 9),
        Center(
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: listData,
          ),
        )
      ],
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 2,
          right: GlobalVariable.ratioWidth(Get.context) * 2,
          top: GlobalVariable.ratioWidth(Get.context) * 16),
      height: GlobalVariable.ratioWidth(Get.context) * 8,
      width: GlobalVariable.ratioWidth(Get.context) * 8,
      decoration: BoxDecoration(
          color: isCurrentPage
              ? Color(ListColor.colorBlue)
              : Color(ListColor.colorLightGrey2),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 12),
          border: Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * 1,
              color: isCurrentPage ? Colors.white : Color(0x80FFFFFF))),
    );
  }

  List<Widget> _createListMenu(List<MenuHorizontalScrollTransportMarket> listMenu, BuildContext context) {
    List<Widget> listWidget = [];
    for (MenuHorizontalScrollTransportMarket data in listMenu) {
      listWidget.add(Container(
        decoration: BoxDecoration(
          color: Color(data.color),
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorBlack).withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 6),
            ),
          ],
        ),
        height: GlobalVariable.ratioWidth(Get.context) * 112,
        width: GlobalVariable.ratioWidth(Get.context) * 112,
        margin: EdgeInsets.symmetric(
          vertical: GlobalVariable.ratioWidth(Get.context) * 9,
          horizontal: GlobalVariable.ratioWidth(Get.context) * 12
        ),
        child: Material(
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
          color: Colors.transparent,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
            ),
            onTap: data.onPress != null ? data.onPress : () => print("null"),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
              ),
              padding: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 20,
                left: GlobalVariable.ratioWidth(Get.context) * 20,
                right: GlobalVariable.ratioWidth(Get.context) * 19.5,
                bottom: GlobalVariable.ratioWidth(Get.context) * 12
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      data.icon,
                      width: GlobalVariable.ratioWidth(context) * 48,
                      height: GlobalVariable.ratioWidth(context) * 48,
                    ),
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
                  Container(
                    alignment: Alignment.topCenter,
                    height: GlobalVariable.ratioWidth(Get.context) * 26.1,
                    child: CustomText(
                      data.title,
                      fontSize: 10,
                      color: Colors.black,
                      height: 1.1,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    )
                  ),
                ]
              ),
            ),
          ),
        ),
      ));
    }
    return listWidget;
  }
}

class _AppBarCustom extends PreferredSize {
  TextEditingController searchInput;
  String hintText;
  List<Widget> listOption;
  Function(String) onSearch;
  Function(String) onChange;
  Function() onSelect;
  Function() onClear;
  bool isEnableSearchTextField;
  bool showClear;

  Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: preferredSize.height,
      child: Container(
          height: preferredSize.height,
          color: Color(ListColor.color4),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: 5,
              right: 0,
              child: Image(
                image: AssetImage(
                    GlobalVariable.imagePath + "fallin_star_3_icon.png"),
                height: preferredSize.height,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 18,
                right: GlobalVariable.ratioWidth(Get.context) * 16,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          width: GlobalVariable.ratioWidth(Get.context) * 27,
                          height: GlobalVariable.ratioWidth(Get.context) * 18,
                          child: SvgPicture.asset(
                            GlobalVariable.imagePath +
                                "ic_back_transport_market.svg",
                            color: Colors.white,
                            width: GlobalVariable.ratioWidth(Get.context) * 12,
                            height: GlobalVariable.ratioWidth(Get.context) * 12,
                          ))),
                  Padding(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 7),
                    child: CustomText(
                      'TransportMarketIndexLabelTransportMarket'
                          .tr, //Transport Market
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 8),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 8,
                            right: GlobalVariable.ratioWidth(Get.context) * 8,
                            top: GlobalVariable.ratioWidth(Get.context) * 2,
                            bottom:
                                GlobalVariable.ratioWidth(Get.context) * 2),
                        child: CustomText(
                          // 'TransportMarketIndexLabelShipper'.tr, // Transporter
                          GlobalVariable.roleName,
                          fontSize: 12,
                          color: Color(ListColor.colorBlue),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 6),
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            GlobalVariable.imagePath + "verified_blue.svg",
                            color: Colors.white,
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                          )))
                ],
              ),
            )
          ])),
    ));
  }

  _AppBarCustom({
    this.hintText = "Search",
    this.preferredSize,
    this.searchInput,
    this.listOption,
    this.onSearch,
    this.onChange,
    this.onClear,
    this.onSelect,
    this.isEnableSearchTextField = true,
    this.showClear = false,
  });
}
