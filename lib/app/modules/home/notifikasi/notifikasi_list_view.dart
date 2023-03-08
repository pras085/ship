import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/tipe_paket.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list/subscription_riwayat_pesanan_list_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_detail/subscription_detail_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SubscriptionRiwayatPesananListView
    extends GetView<SubscriptionRiwayatPesananListController> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Container(
      color: Color(ListColor.color4),
      child: SafeArea(
        child: Scaffold(
          appBar: _AppBar(
              showClear: false,
              isEnableSearchTextField: false,
              hintText: "SubscriptionOrderHistoryAppBar".tr,
              preferredSize:
                  Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
              searchInput: TextEditingController(),
              onSelect: () {
                controller.onClickSearch();
              }),
          body: Container(
              color: Color(ListColor.colorWhite),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Obx(
                  () {
                    return TabbarCustom(
                      listMenu: [
                        'SubscriptionPaymentAccepted'.tr,
                        'SubscriptionPaymentCanceled'.tr,
                        'SubscriptionExpiredPayment'.tr
                      ],
                      onClickTab: (pos) {
                        controller.onChangeTab(pos);
                        pageController.animateToPage(pos,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      pos: controller.posTab.value,
                      heightMenu: 50,
                    );
                  },
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: (index) {
                      controller.posTab.value = index;
                    },
                    controller: pageController,
                    children: [
                      for (int i = 0; i < 3; i++)
                        Obx(
                          () => i == 0
                              ? controller.loadingAP.value
                                  ? _loadingPlaceholder()
                                  : Stack(
                                      children: [
                                        _content(
                                            controller.refreshControllerAP, 0,
                                            onClickDateFilter:
                                                controller.onClickDateFilterAP,
                                            onClickTypeOfPackageFilter: controller
                                                .onClickTypeOfPackageFilterAP,
                                            isActiveDateFilter: controller
                                                .tempRadioDateAP.isNotEmpty,
                                            isActiveTypeOfPackage: controller
                                                .tempRadioTypeAP
                                                .isNotEmpty, onRefresh: () {
                                          controller.refreshData(0);
                                        }, onLoading: () {
                                          controller.loadData(0);
                                        },
                                            listItem: controller.listAP,
                                            filterDate:
                                                controller.tempRadioDateAP,
                                            filterType:
                                                controller.tempRadioTypeAP,
                                            tempRadioDate:
                                                controller.tempRadioDateAP,
                                            tempStartDate:
                                                controller.tempStartDateAP,
                                            tempEndDate:
                                                controller.tempEndDateAP,
                                            tempRadioType:
                                                controller.tempEndDateAP),
                                        controller.listAP.length != 0
                                            ? SizedBox.shrink()
                                            : controller.tempRadioDateAP
                                                        .isNotEmpty ||
                                                    controller.tempRadioTypeAP
                                                        .isNotEmpty
                                                ? _noSearchPlaceholder()
                                                : _noDataPlaceholder(
                                                    'SubscriptionPaymentReceivedNoData'
                                                        .tr)
                                      ],
                                    )
                              : i == 1
                                  ? controller.loadingCO.value
                                      ? _loadingPlaceholder()
                                      : Stack(
                                          children: [
                                            _content(controller.refreshControllerCO, 1,
                                                onClickDateFilter: controller
                                                    .onClickDateFilterCO,
                                                onClickTypeOfPackageFilter:
                                                    controller.onClickTypeOfPackageFilterCO,
                                                onRefresh: () {
                                              controller.refreshData(1);
                                            }, onLoading: () {
                                              controller.loadData(1);
                                            },
                                                listItem: controller.listCO,
                                                isActiveDateFilter: controller
                                                    .tempRadioDateCO.isNotEmpty,
                                                isActiveTypeOfPackage: controller
                                                    .tempRadioTypeCO.isNotEmpty,
                                                filterDate:
                                                    controller.tempRadioDateCO,
                                                filterType:
                                                    controller.tempRadioTypeCO,
                                                tempRadioDate:
                                                    controller.tempRadioDateCO,
                                                tempStartDate:
                                                    controller.tempStartDateCO,
                                                tempEndDate:
                                                    controller.tempEndDateCO,
                                                tempRadioType:
                                                    controller.tempEndDateCO),
                                            controller.listCO.length != 0
                                                ? SizedBox.shrink()
                                                : controller.tempRadioDateCO
                                                            .isNotEmpty ||
                                                        controller
                                                            .tempRadioTypeCO
                                                            .isNotEmpty
                                                    ? _noSearchPlaceholder()
                                                    : _noDataPlaceholder(
                                                        'SubscriptionOrderCanceledNoData'
                                                            .tr)
                                          ],
                                        )
                                  : controller.loadingEP.value
                                      ? _loadingPlaceholder()
                                      : Stack(
                                          children: [
                                            _content(controller.refreshControllerEP, 2,
                                                onClickDateFilter: controller
                                                    .onClickDateFilterEP,
                                                onClickTypeOfPackageFilter:
                                                    controller.onClickTypeOfPackageFilterEP,
                                                onRefresh: () {
                                              controller.refreshData(2);
                                            }, onLoading: () {
                                              controller.loadData(2);
                                            },
                                                listItem: controller.listEP,
                                                isActiveDateFilter: controller
                                                    .tempRadioDateEP.isNotEmpty,
                                                isActiveTypeOfPackage: controller
                                                    .tempRadioTypeEP.isNotEmpty,
                                                filterDate:
                                                    controller.tempRadioDateEP,
                                                filterType:
                                                    controller.tempRadioTypeEP,
                                                tempRadioDate:
                                                    controller.tempRadioDateEP,
                                                tempStartDate:
                                                    controller.tempStartDateEP,
                                                tempEndDate:
                                                    controller.tempEndDateEP,
                                                tempRadioType:
                                                    controller.tempEndDateEP),
                                            controller.listEP.length != 0
                                                ? SizedBox.shrink()
                                                : controller.tempRadioDateEP
                                                            .isNotEmpty ||
                                                        controller
                                                            .tempRadioTypeEP
                                                            .isNotEmpty
                                                    ? _noSearchPlaceholder()
                                                    : _noDataPlaceholder(
                                                        'SubscriptionExpiredPaymentNoData'
                                                            .tr)
                                          ],
                                        ),
                        ),
                    ],
                  ),
                )
              ])),
        ),
      ),
    );
  }

  Widget _content(RefreshController refreshController, int posTab,
      {void Function() onClickDateFilter,
      void Function() onClickTypeOfPackageFilter,
      void Function() onRefresh,
      void Function() onLoading,
      bool isActiveDateFilter = false,
      bool isActiveTypeOfPackage = false,
      RxList<dynamic> listItem,
      String filterDate,
      String filterType,
      @required String tempRadioDate,
      @required String tempStartDate,
      @required String tempEndDate,
      @required String tempRadioType}) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 14,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14,
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16),
            height: 40,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _perFilterButton(
                      filterDate.isEmpty
                          ? 'SubscriptionDate'.tr
                          : filterDate == '1'
                              ? 'SubscriptionDateFilter1'.tr
                              : filterDate == '2'
                                  ? 'SubscriptionDateFilter2'.tr
                                  : filterDate == '3'
                                      ? 'SubscriptionDateFilter3'.tr
                                      : 'SubscriptionDateFilter4'.tr, () {
                    onClickDateFilter();
                  },
                      isActive: isActiveDateFilter,
                      isDisable: listItem.length == 0 &&
                          filterDate.isEmpty &&
                          filterType.isEmpty),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 12,
                  ),
                  _perFilterButton(
                      filterType.isEmpty
                          ? 'SubscriptionPackageType'.tr
                          : filterType == '-1'
                              ? 'SubscriptionAllPackageTypes'.tr
                              : filterType == '0'
                                  ? 'SubscriptionService'.tr
                                  : 'SubscriptionSubUser'.tr, () {
                    if (listItem.length == 0 &&
                        filterDate.isEmpty &&
                        filterType.isEmpty) {
                    } else {
                      onClickTypeOfPackageFilter();
                    }
                  },
                      isActive: isActiveTypeOfPackage,
                      isDisable: listItem.length == 0 &&
                          filterDate.isEmpty &&
                          filterType.isEmpty)
                ],
              ),
            ),
          ),
          Expanded(
            child: SmartRefresher(
              enablePullUp: true,
              controller: refreshController,
              onRefresh: () {
                onRefresh();
              },
              onLoading: () {
                onLoading();
              },
              child: ListView.builder(
                  key: PageStorageKey(posTab.toString()),
                  itemCount: listItem.length,
                  itemBuilder: (context, index) {
                    return _cardRiwayatPesanan(index, posTab);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _perFilterButton(String title, void Function() onClick,
      {bool isActive = false, bool isDisable}) {
    return ButtonBelowAppHeaderTheme1Widget(
      context: Get.context,
      onTap: isDisable ? null : onClick,
      title: title,
      borderRadius: 7,
      minWidth: GlobalVariable.ratioWidth(Get.context) * 120,
      isActive: isActive,
      titleColor: Color(isActive
          ? ListColor.colorBlue
          : isDisable
              ? ListColor.colorLightGrey2
              : ListColor.colorDarkBlue2),
      borderColor:
          Color(isActive ? ListColor.colorBlue : ListColor.colorLightGrey7),
      backgroundColor:
          isActive ? Color(ListColor.colorLightBlue1) : Colors.white,
      suffixIcon: SvgPicture.asset(
        "assets/ic_arrow_down_subscription.svg",
        width: GlobalVariable.ratioWidth(Get.context) * 24,
        height: GlobalVariable.ratioWidth(Get.context) * 24,
        color:
            Color(isDisable ? ListColor.colorLightGrey2 : ListColor.colorBlue),
      ),
    );
  }

  Widget _loadingPlaceholder() {
    return Container(
        color: Color(ListColor.colorWhite1),
        padding: EdgeInsets.symmetric(vertical: 40),
        width: Get.context.mediaQuery.size.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            ),
            CustomText("ListTransporterLabelLoading".tr),
          ],
        ));
  }

  Widget _noDataPlaceholder(String text) {
    return Positioned.fill(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: SvgPicture.asset(
                  "assets/ic_management_lokasi_no_data.svg",
                  width: GlobalVariable.ratioWidth(Get.context) * 82.3,
                  height: GlobalVariable.ratioWidth(Get.context) * 75,
                )),
                Container(
                  height: 12,
                ),
                Container(
                    child: CustomText(
                  text.replaceAll("\\n", "\n"),
                  textAlign: TextAlign.center,
                  color: Color(ListColor.colorLightGrey14),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.2,
                ))
              ],
            )));
  }

  Widget _noSearchPlaceholder() {
    return Positioned.fill(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: SvgPicture.asset(
                  "assets/ic_management_lokasi_no_search.svg",
                  height: GlobalVariable.ratioWidth(Get.context) * 95,
                )),
                Container(
                  height: 12,
                ),
                Container(
                    child: CustomText(
                  "SubscriptionFilterNoData".tr.replaceAll("\\n", "\n"),
                  textAlign: TextAlign.center,
                  color: Color(ListColor.colorLightGrey14),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.2,
                )),
              ],
            )));
  }

  Widget _cardRiwayatPesanan(int index, int posTab) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 14),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(ListColor.colorWhite),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorBlack).withOpacity(0.1),
              blurRadius: GlobalVariable.ratioWidth(Get.context) * 20,
              spreadRadius: 0,
              offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
            ),
          ],
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 10)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16),
            decoration: BoxDecoration(
                color: Color(ListColor.colorLightBlue),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10),
                    topRight: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10))),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 8.11,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 8.49,
                  ),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    posTab == 0
                        ? controller.listAP[index].packetName
                        : posTab == 1
                            ? controller.listCO[index].packetName
                            : controller.listEP[index].packetName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                )),
                SizedBox(
                  width: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 28.39,
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 8.11,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 8.49,
                  ),
                  child: CustomText(
                    posTab == 0
                        ? "${controller.listAP[index].orderDate}\n${controller.listAP[index].orderTime}"
                        : posTab == 1
                            ? "${controller.listCO[index].orderDate}\n${controller.listCO[index].orderTime}"
                            : "${controller.listEP[index].orderDate}\n${controller.listEP[index].orderTime}",
                    textAlign: TextAlign.right,
                    color: Color(ListColor.colorBlue),
                    fontWeight: FontWeight.w600,
                    height: 13.85 / 10,
                    fontSize: 10,
                    withoutExtraPadding: true,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 10,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 10),
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "SubscriptionPaymentMethod".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 10,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 10),
                      constraints: BoxConstraints(
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 41),
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        posTab == 0
                            ? controller.listAP[index].paymentName
                            : posTab == 1
                                ? controller.listCO[index].paymentName
                                : controller.listEP[index].paymentName,
                        textAlign: TextAlign.right,
                        color: Color(ListColor.colorBlack),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      )),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            //garis
            width: MediaQuery.of(Get.context).size.width,
            height: 0.5,
            color: Color(ListColor.colorLightGrey10),
          ),
          Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "SubscriptionPackageType".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )),
                Container(
                  alignment: Alignment.centerRight,
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  child: CustomText(
                    posTab == 0
                        ? controller.listAP[index].packetType == 0
                            ? "SubscriptionService".tr
                            : "SubscriptionSubUser".tr
                        : posTab == 1
                            ? controller.listCO[index].packetType == 0
                                ? "SubscriptionService".tr
                                : "SubscriptionSubUser".tr
                            : controller.listEP[index].packetType == 0
                                ? "SubscriptionService".tr
                                : "SubscriptionSubUser".tr,
                    textAlign: TextAlign.right,
                    color: Color(ListColor.colorBlack),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            //garis
            width: MediaQuery.of(Get.context).size.width,
            height: 0.5,
            color: Color(ListColor.colorLightGrey10),
          ),
          Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "SubscriptionTotalOrders".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )),
                Container(
                    alignment: Alignment.centerRight,
                    constraints: BoxConstraints(
                        minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                    child: CustomText(
                      Utils.formatUang(posTab == 0
                          ? controller.listAP[index].grandTotal.toDouble()
                          : posTab == 1
                              ? controller.listCO[index].grandTotal.toDouble()
                              : controller.listEP[index].grandTotal.toDouble()),
                      textAlign: TextAlign.right,
                      color: Color(ListColor.colorBlack),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ))
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
            constraints: BoxConstraints(
                minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  child: posTab == 0
                      ? _textCard(
                          marginLeft: 0,
                          text: "SubscriptionPaymentAccepted".tr,
                          textColor: Color(ListColor.colorGreen6),
                          backgroundColor: Color(ListColor.colorLightGreen3))
                      : posTab == 1
                          ? _textCard(
                              marginLeft: 0,
                              text: "SubscriptionPaymentCanceled".tr,
                              textColor: Color(ListColor.colorRed),
                              backgroundColor: Color(ListColor.colorLightRed3))
                          : _textCard(
                              marginLeft: 0,
                              text: "SubscriptionExpiredPayment".tr,
                              textColor: Color(ListColor.colorGrey3),
                              backgroundColor:
                                  Color(ListColor.colorLightGrey12)),
                )),
                Container(
                  margin: EdgeInsets.only(top: 7, bottom: 7),
                  width: GlobalVariable.ratioWidth(Get.context) * 82,
                  height: GlobalVariable.ratioWidth(Get.context) * 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorBlue),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: GlobalVariable.ratioWidth(Get.context) * 1.5,
                      color: Color(ListColor.colorBlue),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        GetToPage.toNamed<SubscriptionDetailController>(
                            Routes.SUBSCRIPTION_DETAIL,
                            arguments: [
                              posTab == 0
                                  ? controller.listAP[index].orderID
                                  : posTab == 1
                                      ? controller.listCO[index].orderID
                                      : controller.listEP[index].orderID,
                              posTab == 0
                                  ? controller.listAP[index].packetType == 0
                                      ? TipeLayananSubscription.BF
                                      : TipeLayananSubscription.SU
                                  : posTab == 1
                                      ? controller.listCO[index].packetType == 0
                                          ? TipeLayananSubscription.BF
                                          : TipeLayananSubscription.SU
                                      : controller.listEP[index].packetType == 0
                                          ? TipeLayananSubscription.BF
                                          : TipeLayananSubscription.SU,
                              TipeDetailSubscription.PESANAN
                            ]);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.fromLTRB(
                        //     GlobalVariable.ratioWidth(Get.context) * 24,
                        //     8,
                        //     GlobalVariable.ratioWidth(Get.context) * 24,
                        //     8),
                        child: CustomText(
                          "SubscriptionDetail".tr,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _textCard({
    @required String text,
    double marginLeft = 16,
    @required Color textColor,
    @required Color backgroundColor,
  }) {
    return Container(
        margin: EdgeInsets.only(
            left: GlobalVariable.ratioWidth(Get.context) * marginLeft),
        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: CustomText(
          text,
          maxLines: 1,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ));
  }
}

class _AppBar extends PreferredSize {
  final TextEditingController searchInput;
  final String hintText;
  final List<Widget> listOption;
  final Function(String) onSearch;
  final Function(String) onChange;
  final Function() onSelect;
  final Function() onClear;
  final bool isEnableSearchTextField;
  final bool showClear;

  final Size preferredSize;

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
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 12,
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBackButton(
                      context: Get.context,
                      onTap: () {
                        Get.back();
                      }),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 8,
                  ),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
                          child: onSelect != null && !isEnableSearchTextField
                              ? GestureDetector(
                                  onTap: onSelect, child: _searchTextField)
                              : _searchTextField)),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: listOption,
                  // )
                ],
              ),
            )
          ])),
    ));
  }

  Widget get _searchTextField => Stack(
        alignment: Alignment.centerLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextField(
                context: Get.context,
                enabled: isEnableSearchTextField,
                controller: searchInput,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                textInputAction: TextInputAction.go,
                style: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "AvenirNext",
                    color: Colors.black),
                newInputDecoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorLightGrey2)),
                    filled: true,
                    isDense: true,
                    isCollapsed: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioWidth(Get.context) * 36,
                        GlobalVariable.ratioWidth(Get.context) * 9,
                        GlobalVariable.ratioWidth(Get.context) * 32,
                        GlobalVariable.ratioWidth(Get.context) * 0)),
                onSubmitted: (String str) async {
                  await onSearch(str);
                },
                onChanged: (String str) async {
                  await onChange(str);
                },
                onTap: () async {
                  if (onSelect != null) await onSelect();
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 6),
            child: SvgPicture.asset(
              "assets/ic_search.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 20,
              height: GlobalVariable.ratioWidth(Get.context) * 20,
            ),
          ),
          showClear
              ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () async {
                      searchInput.clear();
                      await onClear();
                    },
                  ))
              : SizedBox.shrink()
        ],
      );

  _AppBar({
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

class ButtonBelowAppHeaderTheme1Widget extends StatelessWidget {
  final BuildContext context;
  final void Function() onTap;
  final String title;
  final bool isActive;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final double borderRadius;
  final Color titleColor;
  final Color borderColor;
  final Color backgroundColor;
  final double minWidth;
  ButtonBelowAppHeaderTheme1Widget(
      {@required this.context,
      @required this.onTap,
      @required this.title,
      this.isActive = false,
      this.suffixIcon,
      this.prefixIcon,
      this.borderRadius,
      this.titleColor,
      this.borderColor,
      this.backgroundColor = Colors.white,
      this.minWidth = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: GlobalVariable.ratioWidth(context) * 24,
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.shadowColor).withOpacity(0.08),
              blurRadius: GlobalVariable.ratioWidth(context) * 4,
              spreadRadius: 0,
              offset: Offset(0, GlobalVariable.ratioWidth(context) * 2),
            ),
          ],
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
              width: 1, color: borderColor ?? Color(ListColor.colorLightGrey))),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            onTap: onTap,
            child: Container(
              constraints: BoxConstraints(minWidth: minWidth),
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(context) * 7,
                  right: GlobalVariable.ratioWidth(context) * 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    constraints: BoxConstraints(
                        maxHeight: GlobalVariable.ratioWidth(context) * 24,
                        minWidth: GlobalVariable.ratioWidth(context) * 84),
                    child: CustomText(title,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: titleColor ?? Color(ListColor.colorBlue)),
                  ),
                  suffixIcon != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [suffixIcon])
                      : SizedBox.shrink()
                ],
              ),
            )),
      ),
    );
  }
}

class TabbarCustom extends StatefulWidget {
  final List<String> listMenu;
  final int pos;
  final void Function(int) onClickTab;
  final double heightMenu;

  TabbarCustom(
      {@required this.listMenu,
      @required this.onClickTab,
      @required this.pos,
      this.heightMenu = 50});

  @override
  _TabbarCustomState createState() => _TabbarCustomState();
}

class _TabbarCustomState extends State<TabbarCustom> {
  bool isExpanded = false;
  bool isFirstTime = true;
  GlobalKey containerKey = GlobalKey();
  final AutoScrollController _autoScrollController = AutoScrollController();

  void _onCompleteBuild(BuildContext context) {
    if (isFirstTime) {
      isFirstTime = false;
      double widthScreen = MediaQuery.of(context).size.width;
      final renderObject = containerKey.currentContext?.findRenderObject() as RenderBox;
      double widthContainer = renderObject.size.width;
      if (widthScreen >= widthContainer) {
        isExpanded = true;
        setState(() {});
      }
    }
    _autoScrollController.scrollToIndex(widget.pos);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _onCompleteBuild(context));
    return Container(
     width: MediaQuery.of(context).size.width,
      height: GlobalVariable.ratioWidth(context) * widget.heightMenu,
      child: isExpanded
          ? Row(
              mainAxisSize: MainAxisSize.max,
              children: _allItemMenu(),
            )
          : ListView(
              controller: _autoScrollController,
              scrollDirection: Axis.horizontal,
              children: [
                  Container(
                    key: containerKey,
                    child: Row(children: _allItemMenu()),
                  )
                ]),
    );
  }

  Widget _perItem(String item, int index) {
    return isExpanded
        ? Expanded(child: _perItemDetail(item, index),)
        : _perItemDetail(item, index);
  }

  Widget _perItemDetail(String item, int index) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.onClickTab(index);
          },
          child: Container(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 12,
                right: GlobalVariable.ratioWidth(Get.context) * 12),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: GlobalVariable.ratioWidth(Get.context) * 2,
                        color: index == widget.pos
                            ? Color(ListColor.color4)
                            : Color(ListColor.colorLightGrey10)))),
            child: Center(
                child: CustomText(item,
                    fontSize: 14,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: Color(index == widget.pos
                        ? ListColor.color4
                        : ListColor.colorLightGrey2))),
          ),
        ),
      ),
    );
  }

  List<Widget> _allItemMenu() {
    List<Widget> listWidget = [];
    for (int i = 0; i < widget.listMenu.length; i++) {
      listWidget.add(_perItem(widget.listMenu[i], i));
    }
    return listWidget;
  }
}

