import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';

import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/tipe_paket.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search_result/subscription_riwayat_pesanan_list_search_result_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_detail/subscription_detail_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SubscriptionRiwayatPesananListSearchResultView
    extends GetView<SubscriptionRiwayatPesananListSearchResultController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.onWillPop();
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
            child: Container(
              height: GlobalVariable.ratioWidth(Get.context) * 56,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(ListColor.colorBlack).withOpacity(0.15),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 15,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 4)),
              ], color: Colors.white),
              child:
                  // Stack(alignment: Alignment.bottomCenter, children: [
                  //   Column(mainAxisSize: MainAxisSize.max, children: [
                  Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 12,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomBackButton(
                        context: Get.context,
                        backgroundColor: Color(ListColor.colorBlue),
                        iconColor: Color(ListColor.colorWhite),
                        onTap: () {
                          controller.onWillPop();
                        }),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.goToSearchPage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          1,
                                  color: Color(ListColor.colorStroke)),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CustomTextField(
                                      context: Get.context,
                                      enabled: false,
                                      controller: controller.searchBar,
                                      textInputAction: TextInputAction.search,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      textSize: 14,
                                      newInputDecoration: InputDecoration(
                                          hintText:
                                              "SubscriptionOrderHistoryAppBar"
                                                  .tr,
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(
                                                  ListColor.colorLightGrey2)),
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          isDense: true,
                                          isCollapsed: true,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  36,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  32,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  0))),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6),
                                child: SvgPicture.asset(
                                  "assets/ic_search.svg",
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //   ]),
              // ]),
            ),
          ),
          body: SafeArea(
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(
                          () => Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20),
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontSize: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                            fontFamily: 'AvenirNext',
                                            fontWeight: FontWeight.w500,
                                            color: Color(
                                                ListColor.colorDarkBlue2)),
                                        children: [
                                          controller.filterSearch.value
                                                      .isEmpty ||
                                                  controller
                                                          .listLength.value ==
                                                      0
                                              ? TextSpan(
                                                  text:
                                                      ("LocationManagementLabelShowNoLocation"
                                                              .tr)
                                                          .replaceAll("\"", ""))
                                              : TextSpan(
                                                  text:
                                                      ("LocationManagementLabelShowLocation"
                                                              .tr)
                                                          .replaceAll(
                                                              "#number",
                                                              controller
                                                                  .totalAll
                                                                  .value
                                                                  .toString())
                                                          .replaceAll(
                                                              "\"", "")),
                                          TextSpan(
                                              text:
                                                  "\"${controller.filterSearch.value}\"",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)),
                                          // TextSpan(text: "\"")
                                        ]),
                                  )),
                              Expanded(
                                child: Obx(() => Stack(
                                      children: [
                                        SmartRefresher(
                                          enablePullUp: true,
                                          controller:
                                              controller.refreshController,
                                          onLoading: () {
                                            controller.loadData();
                                          },
                                          onRefresh: () {
                                            controller.refreshData();
                                          },
                                          child: ListView.builder(
                                            itemCount:
                                                controller.listLength.value,
                                            itemBuilder: (content, index) {
                                              return _cardRiwayatPesanan(index);
                                            },
                                          ),
                                        ),
                                        controller.listLength.value != 0
                                            ? SizedBox.shrink()
                                            : Positioned.fill(
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                            child: SvgPicture
                                                                .asset(
                                                          "assets/ic_management_lokasi_no_search.svg",
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              95,
                                                        )),
                                                        Container(
                                                          height: 12,
                                                        ),
                                                        Container(
                                                            child: CustomText(
                                                          "LocationManagementLabelNoKeywordFound"
                                                              .tr
                                                              .replaceAll(
                                                                  "\\n", "\n"),
                                                          textAlign:
                                                              TextAlign.center,
                                                          color: Color(ListColor
                                                              .colorLightGrey14),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          height: 1.2,
                                                        ))
                                                      ],
                                                    ))),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
          ),
        ),
      ),
    );
  }

  Widget _cardRiwayatPesanan(int index) {
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
                    controller.listData[index].packetName,
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
                    "${controller.listData[index].orderDate}\n${controller.listData[index].orderTime}",
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
                      alignment: Alignment.centerRight,
                      constraints: BoxConstraints(
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 41),
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
                  constraints: BoxConstraints(
                      minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    controller.listData[index].packetType == 0
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
                    constraints: BoxConstraints(
                        minHeight: GlobalVariable.ratioWidth(Get.context) * 41),
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
                  child: _textCard(
                      marginLeft: 0,
                      text: controller.listData[index].status == 1
                          ? 'SubscriptionPaymentAccepted'.tr
                          : controller.listData[index].status == 2
                              ? 'SubscriptionPaymentCanceled'.tr
                              : 'SubscriptionExpiredPayment'.tr,
                      textColor: Color(controller.listData[index].status == 1
                          ? ListColor.colorGreen6
                          : controller.listData[index].status == 2
                              ? ListColor.colorRed
                              : ListColor.colorGrey3),
                      backgroundColor:
                          Color(controller.listData[index].status == 1
                              ? ListColor.colorLightGreen3
                              : controller.listData[index].status == 2
                                  ? ListColor.colorLightRed3
                                  : ListColor.colorLightGrey12)),
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
                              controller.listData[index].orderID,
                              controller.listData[index].packetType == 0
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
