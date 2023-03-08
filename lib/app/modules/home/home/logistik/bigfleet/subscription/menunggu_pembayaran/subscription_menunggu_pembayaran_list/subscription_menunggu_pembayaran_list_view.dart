import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list/subscription_menunggu_pembayaran_list_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/menunggu_pembayaran/subscription_menunggu_pembayaran_list_search/subscription_menunggu_pembayaran_list_search_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/tipe_paket.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_detail/subscription_detail_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/back_button.dart';

import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SubscriptionMenungguPembayaranListView
    extends GetView<SubscriptionMenungguPembayaranListController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      extendBody: true,
      appBar: _AppBar(
          controller: controller,
          showClear: false,
          isEnableSearchTextField: false,
          hintText: "SubscriptionWaitingPaymentAppBar".tr,
          preferredSize:
              Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          searchInput: controller.searchBar,
          onSelect: () {
            if (controller.listLength > 0) {
              GetToPage.toNamed<
                      SubscriptionMenungguPembayaranListSearchController>(
                  Routes.SUBSCRIPTION_MENUNGGU_PEMBAYARAN_LIST_SEARCH,
                  arguments: [""]);
            }
          }),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Obx(() => controller.loading.value
            ? Container(
                color: Color(ListColor.colorWhite),
                padding: EdgeInsets.symmetric(vertical: 40),
                width: Get.context.mediaQuery.size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator()),
                    ),
                    CustomText("ListTransporterLabelLoading".tr),
                  ],
                ))
            : Container(
                color: Color(ListColor.colorWhite),
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            SmartRefresher(
                              enablePullUp: true,
                              controller: controller.refreshController,
                              onLoading: () {
                                controller.loadData();
                              },
                              onRefresh: () {
                                controller.refreshData();
                              },
                              child: ListView.builder(
                                itemCount: controller.listLength.value,
                                itemBuilder: (content, index) {
                                  return _cardMenungguPembayaran(index);
                                },
                              ),
                            ),
                            controller.listLength.value != 0
                                ? SizedBox.shrink()
                                : Positioned.fill(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                child: SvgPicture.asset(
                                              "assets/ic_management_lokasi_no_data.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  82.3,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  75,
                                            )),
                                            Container(
                                              height: 12,
                                            ),
                                            Container(
                                                child: CustomText(
                                              "SubscriptionWaitingPaymentNoData"
                                                  .tr
                                                  .replaceAll("\\n", "\n"),
                                              textAlign: TextAlign.center,
                                              color: Color(
                                                  ListColor.colorLightGrey14),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              height: 1.2,
                                            ))
                                          ],
                                        ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
      ),
    );
  }

  Future<bool> onWillPop() {
    if (!controller.loading.value) Get.back(result: controller.refreshPanel);
    return Future.value(false);
  }

  Widget _cardMenungguPembayaran(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          index == 0 ? GlobalVariable.ratioWidth(Get.context) * 16 : 0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 14),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(ListColor.colorWhite),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(ListColor.colorLightGrey).withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 2),
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
                      top: GlobalVariable.ratioWidth(Get.context) * 10,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 10),
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    controller.listData[index].packetName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 7,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 7),
                  child: CustomText(
                    "${controller.listData[index].orderDate}\n${controller.listData[index].orderTime}",
                    textAlign: TextAlign.right,
                    color: Color(ListColor.colorBlue),
                    fontWeight: FontWeight.w600,
                    height: 13.85 / 10,
                    fontSize: 10,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 14,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14),
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              children: [
                Expanded(
                    child: Container(
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
                  child: CustomText(
                    controller.listData[index].packetType == 0
                        ? "SubscriptionService".tr
                        : "SubscriptionSubUser".tr,
                    textAlign: TextAlign.right,
                    color: Color(ListColor.colorBlack),
                    fontWeight: FontWeight.w600,
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
            margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 14,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14),
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
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
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        controller.listData[index].paymentName,
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
            margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 14,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14),
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
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
                    child: CustomText(
                      Utils.formatUang(
                          controller.listData[index].grandTotal.toDouble()),
                      textAlign: TextAlign.right,
                      color: Color(ListColor.colorBlack),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ))
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
            margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 14,
                bottom: GlobalVariable.ratioWidth(Get.context) * 14),
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "SubscriptionPaymentLimit".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )),
                Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      controller.listData[index].paymentExpired,
                      textAlign: TextAlign.right,
                      color: Color(ListColor.colorBlack),
                      fontWeight: FontWeight.w600,
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
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 16,
                right: GlobalVariable.ratioWidth(Get.context) * 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10),
                    bottomRight: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10))),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                )),
                Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 28,
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 7,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 7),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 18),
                    border: Border.all(
                        width: GlobalVariable.ratioWidth(Get.context) * 1.5,
                        color: Color(ListColor.colorBlue)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 18),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 18),
                      onTap: () async {
                        var result = await GetToPage.toNamed<
                            SubscriptionDetailController>(
                          Routes.SUBSCRIPTION_DETAIL,
                          arguments: [
                            controller.listData[index].orderID,
                            controller.listData[index].packetType == 0
                                ? TipeLayananSubscription.BF
                                : TipeLayananSubscription.SU,
                            TipeDetailSubscription.PEMBAYARAN
                          ],
                        );
                        if (result != null &&
                            result[0] == true &&
                            result[1] == false &&
                            result[2] == null) {
                          // this will process when only change payment method
                          controller.refreshList = true;
                          controller.refreshPanel = result[1];
                          controller.refreshData();
                        } else if (result != null && result[0] == true) {
                          controller.refreshList = true;
                          controller.refreshPanel = result[1];
                          // controller.refreshData();
                          if (result[2] != null) {
                            Get.back(result: result[2]);
                          } else {
                            Get.back(result: controller.refreshPanel);
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(Get.context) * 24,
                            0,
                            GlobalVariable.ratioWidth(Get.context) * 24,
                            0),
                        child: CustomText(
                          "SubscriptionDetail".tr,
                          color: Color(ListColor.colorBlue),
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
  final SubscriptionMenungguPembayaranListController controller;

  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(ListColor.color4),
      child: SafeArea(
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
                            Get.back(result: controller.refreshPanel);
                          }),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 8,
                      ),
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8)),
                              child:
                                  onSelect != null && !isEnableSearchTextField
                                      ? GestureDetector(
                                          onTap: onSelect,
                                          child: _searchTextField)
                                      : _searchTextField)),
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: listOption,
                      // )
                    ],
                  ),
                )
              ]))),
    );
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
                        GlobalVariable.ratioWidth(Get.context) * 0,
                        GlobalVariable.ratioWidth(Get.context) * 0)),
                onSubmitted: (String str) async {
                  await onSearch(str);
                },
                onChanged: (String str) async {
                  await onChange(str);
                },
                onTap: () async {
                  if (!onSelect.isNull) await onSelect();
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

  _AppBar(
      {this.hintText = "Search",
      this.preferredSize,
      this.searchInput,
      this.listOption,
      this.onSearch,
      this.onChange,
      this.onClear,
      this.onSelect,
      this.isEnableSearchTextField = true,
      this.showClear = false,
      this.controller});
}
