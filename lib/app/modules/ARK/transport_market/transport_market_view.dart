import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/transport_market/transport_market_controller.dart';
import 'package:muatmuat/app/modules/ARK/transport_market/menu_horizontal_scroll_model.dart';
import 'package:muatmuat/app/modules/contact_support/support_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/test_form_field_widget2.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:validators/validators.dart' as validator;

class TransportMarketView extends GetView<TransportMarketController> {
  final form = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  var emptyMessage = false.obs;
  final double _spaceMenu = GlobalVariable.ratioWidth(Get.context) * 11.11;

//

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
    title: CustomText('Transport Market'.tr), // Transport Market
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Color(ListColor.colorBlue),
            statusBarIconBrightness: Brightness.light),
        child: Scaffold(
            appBar: _AppBarCustom(
                showClear: false,
                isEnableSearchTextField: false,
                hintText: "LocationManagementLabelHintAppBar".tr,
                preferredSize: Size.fromHeight(
                    GlobalVariable.ratioWidth(Get.context) * 56),
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
                            child: SvgPicture.asset(
                                GlobalVariable.imagePath + "sorting_icon.svg",
                                color: Colors.white))),
                  )
                ],
                onSelect: () {}),
            body: Obx(() => !controller.onLoading.value
                ? SafeArea(
                    child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 30),
                          child: CarouselSlider(
                            items: controller.imageSliders.value,
                            options: CarouselOptions(
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    136,
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
                        Container(
                          margin: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() => Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.start,
                                    runAlignment: WrapAlignment.center,
                                    spacing: _spaceMenu,
                                    runSpacing: _spaceMenu,
                                    children: [
                                      for (var x = 0;
                                          x <
                                              controller
                                                  .listWidgetLogistic.length;
                                          x++)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(controller
                                                .listWidgetLogistic[x].color),
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    8),
                                            // boxShadow: <BoxShadow>[
                                            //   BoxShadow(
                                            //     color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                                            //     blurRadius: 4,
                                            //     spreadRadius: 2,
                                            //     offset: Offset(0, 7),
                                            //   ),
                                            // ],
                                          ),
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              101.85,
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              101.54,
                                          child: Material(
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    8),
                                            color: Colors.transparent,
                                            child: InkWell(
                                              customBorder:
                                                  RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        8),
                                              ),
                                              onTap: controller
                                                          .listWidgetLogistic[x]
                                                          .onPress !=
                                                      null
                                                  ? controller
                                                      .listWidgetLogistic[x]
                                                      .onPress
                                                  : () => print("null"),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          8),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12,
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10,
                                                    bottom:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            6),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Image(
                                                                image: AssetImage(
                                                                    controller
                                                                        .listWidgetLogistic[
                                                                            x]
                                                                        .image),
                                                                width: controller
                                                                    .listWidgetLogistic[
                                                                        x]
                                                                    .width,
                                                                height: controller
                                                                    .listWidgetLogistic[
                                                                        x]
                                                                    .height,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                                color: controller
                                                                        .listWidgetLogistic[
                                                                            x]
                                                                        .akses
                                                                    ? null
                                                                    : Color(ListColor
                                                                        .colorAksesDisable),
                                                              )
                                                            ]),
                                                      ),
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              40,
                                                          child: CustomText(
                                                            controller
                                                                .listWidgetLogistic[
                                                                    x]
                                                                .title,
                                                            fontSize: 12,
                                                            color: controller
                                                                    .listWidgetLogistic[
                                                                        x]
                                                                    .akses
                                                                ? Colors.white
                                                                : Color(ListColor
                                                                    .colorAksesDisable),
                                                            wrapSpace: true,
                                                            height: 1.1,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          )),
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                : Center(child: CircularProgressIndicator()))));
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
              ? Color(ListColor.colorYellow)
              : Color(ListColor.colorYellow).withOpacity(0.57),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 12),
          border: Border.all(
              width: GlobalVariable.ratioWidth(Get.context) * 1,
              color: isCurrentPage ? Colors.white : Color(0x80FFFFFF))),
    );
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
                            bottom: GlobalVariable.ratioWidth(Get.context) * 2),
                        child: CustomText(
                          'Shipper'.tr, // Shipper
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
