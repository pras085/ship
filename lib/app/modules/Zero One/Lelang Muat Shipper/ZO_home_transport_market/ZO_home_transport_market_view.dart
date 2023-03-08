import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/hasil_cari_harga_transport/hasil_cari_harga_transport_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_home_transport_market/ZO_home_transport_market_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_home_transport_market/menu_horizontal_scroll_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_list_muatan/ZO_list_muatan_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/widgets/test_form_field_widget2.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:validators/validators.dart' as validator;

class ZoHomeTransportMarketView
    extends GetView<ZoHomeTransportMarketController> {
  final form = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  var emptyMessage = false.obs;
  final double _spaceMenu = GlobalVariable.ratioWidth(Get.context) * 11.11;

  List<MenuHorizontalScrollTransportMarket> listLogisticMenu = [
    MenuHorizontalScrollTransportMarket(
        title: "Subscription",
        urlIcon: "ic_menu_dashboard_subcription.png",
        color: ListColor.colorBackgroundCircleBigFleetSubscription,
        onPress: () {}),
    MenuHorizontalScrollTransportMarket(
        title: "LelangMuatBuatLelangBuatLelangLabelTitleLelangMuatan".tr,
        urlIcon: "ic_menu_dashboard_lelang_muatan.png",
        color: ListColor.colorDashboardTransporterMarketMenuLelangMuatan,
        onPress: () {
          // ZoHomeTransportMarketController
          GetToPage.toNamed<ZoListMuatanController>(Routes.ZO_LELANG_MUATAN,
              preventDuplicates: false, arguments: [""]);
        }),
    MenuHorizontalScrollTransportMarket(
      title: "LelangMuatBuatLelangBuatLelangLabelTitleCariHargaTransport".tr,
      urlIcon: "ic_menu_dashboard_cari_harga_transport.png",
      color: ListColor.colorDashboardTransporterMarketMenuCariHarga,
      onPress: () {
        //Get.toNamed(Routes.SHIPPER_BUYER_REGISTER);
        GetToPage.toNamed<HasilCariHargaTransportController>(
            Routes.CARI_HARGA_TRANSPORT,
            preventDuplicates: false,
            arguments: [""]);
      },
    ),
    MenuHorizontalScrollTransportMarket(
        title: "LelangMuatBuatLelangBuatLelangLabelTitlePromoTransport".tr,
        urlIcon: "ic_menu_dashboard_promo_transport.png",
        color: ListColor.colorDashboardTransporterMarketMenuPromoTranspoter,
        onPress: () {
          GetToPage.toNamed<ZoPromoTransporterController>(
            Routes.ZO_PROMO_TRANSPORTER,
            preventDuplicates: false,
            arguments: [""],
          );
          // GetToPage.toNamed<ZoListHargaPromoController>(
          //     Routes.ZO_LIST_HARGA_PROMO,
          //     preventDuplicates: false,
          //     arguments: [""]);
        })
  ];
//
  List<Widget> _listWidgetLogistic = [];

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

  AppBar _appBar = AppBar(
    title: CustomText('Transport Market'),
  );

  @override
  Widget build(BuildContext context) {
    _listWidgetLogistic.clear();
    _listWidgetLogistic.addAll(_createListMenu(listLogisticMenu, context));
    return Scaffold(
        appBar: _AppBarCustom(
            showClear: false,
            isEnableSearchTextField: false,
            hintText: "LocationManagementLabelHintAppBar".tr,
            preferredSize: Size.fromHeight(_appBar.preferredSize.height + 10),
            // searchInput: controller.searchBar,
            listOption: [
              Container(width: GlobalVariable.ratioWidth(Get.context) * 12),
              Obx(
                () => GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/sorting_icon.svg",
                            color: Colors.white))),
              )
            ],
            onSelect: () {}),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 30),
                child: CarouselSlider(
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
              _buildMenu(_listWidgetLogistic, "HomeLabelMenuLogistic".tr,
                  "HomeLabelMenuLogisticDesc".tr, context),
            ],
          ),
        )));
  }

  Widget _buildMenu(
      List<Widget> listData, String title, String desc, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.center,
            spacing: _spaceMenu,
            runSpacing: _spaceMenu,
            children: listData,
          )
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 16),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: isCurrentPage
              ? Color(ListColor.colorYellow)
              : Color(ListColor.colorYellow).withOpacity(0.57),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              width: 1,
              color: isCurrentPage ? Colors.white : Color(0x80FFFFFF))),
    );
  }

  List<Widget> _createListMenu(
      List<MenuHorizontalScrollTransportMarket> listMenu,
      BuildContext context) {
    List<Widget> listWidget = [];
    for (MenuHorizontalScrollTransportMarket data in listMenu) {
      listWidget.add(Container(
        decoration: BoxDecoration(
          color: Color(data.color),
          borderRadius: BorderRadius.circular(8),
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Color(ListColor.colorLightGrey).withOpacity(0.5),
          //     blurRadius: 4,
          //     spreadRadius: 2,
          //     offset: Offset(0, 7),
          //   ),
          // ],
        ),
        height: GlobalVariable.ratioWidth(Get.context) * 101.85,
        width: GlobalVariable.ratioWidth(Get.context) * 101.54,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: data.onPress != null ? data.onPress : () => print("null"),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        Image(
                          image: AssetImage("assets/" + data.urlIcon),
                          width: GlobalVariable.ratioWidth(Get.context) * 24.92,
                          height: GlobalVariable.ratioWidth(Get.context) * 38,
                          fit: BoxFit.fitWidth,
                        ),
                      ]),
                    ),
                    Stack(alignment: Alignment.centerLeft, children: [
                      CustomText(
                        "\n",
                        textAlign: TextAlign.center,
                        color: Colors.transparent,
                        fontSize: GlobalVariable.ratioFontSize(context) * 10,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        data.title,
                        // textAlign: TextAlign.center,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 12,
                        color: Colors.white,
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
}

class ZoListHargaPromo {}

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
                image: AssetImage("assets/fallin_star_3_icon.png"),
                height: preferredSize.height,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 14,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 30 * 0.7,
                          ))),
                  Padding(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 6),
                    child: CustomText(
                      'Transport Market',
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 16,
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
                            top: GlobalVariable.ratioWidth(Get.context) * 4,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 4),
                        child: CustomText(
                          'Shipper'.tr,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 12,
                          color: Color(0xff176CF7),
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
                          child: Icon(
                            Icons.verified_user,
                            color: Colors.white,
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
