import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/tipe_paket.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_langganan_bf_dan_su/subscription_riwayat_langganan_su_list_search_result/subscription_riwayat_langganan_su_list_search_result_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/subscription_detail/subscription_detail_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SubscriptionRiwayatLanggananSUListSearchResultView
    extends GetView<SubscriptionRiwayatLanggananSUListSearchResultController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () {
        controller.onWillPop();
        return Future.value(false);
      },
      child: Container(
        color: Color(ListColor.colorWhite),
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
                      offset: Offset(
                          0, GlobalVariable.ratioWidth(Get.context) * 4)),
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
                                    GlobalVariable.ratioWidth(Get.context) *
                                        8)),
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
                                            color: Color(ListColor.colorBlack)),
                                        textSize: 14,
                                        newInputDecoration: InputDecoration(
                                            hintText:
                                                "SubscriptionSubUserHistoryAppBar"
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
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
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
                                              fontSize:
                                                  GlobalVariable.ratioWidth(
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
                                                    text: ("LocationManagementLabelShowNoLocation"
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
                                                    fontWeight:
                                                        FontWeight.w600)),
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
                                                return _cardRiwayatLangganan(
                                                    index);
                                              },
                                            ),
                                          ),
                                          controller.listLength.value != 0
                                              ? SizedBox.shrink()
                                              : Positioned.fill(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
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
                                                                    .ratioWidth(
                                                                        Get.context) *
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
                                                                    "\\n",
                                                                    "\n"),
                                                            textAlign: TextAlign
                                                                .center,
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
      ),
    );
  }

  Widget _cardRiwayatLangganan(int index) {
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
                top: GlobalVariable.ratioWidth(Get.context) * 12,
                bottom: GlobalVariable.ratioWidth(Get.context) * 13),
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
                    "SubscriptionPeriod".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.2,
                  ),
                )),
                Container(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    controller.listData[index].periodeLangganan,
                    textAlign: TextAlign.right,
                    color: Color(ListColor.colorBlack),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.2,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(Get.context) * 13),
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "SubscriptionSubUser".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: (controller.listData[index].qtyPaidSubuser > 0 ||
                              controller.listData[index].qtyFreeSubuser > 0)
                          ? Container(
                              padding: EdgeInsets.only(
                                  top: FontTopPadding.getSize(14)),
                              child: RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontFamily: "AvenirNext",
                                          height: 1.2,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  14),
                                      children: [
                                        TextSpan(
                                            text: controller.listData[index]
                                                        .qtyPaidSubuser >
                                                    0
                                                ? '${controller.listData[index].qtyPaidSubuser.toString()} ${'SubscriptionSubUser'.tr}'
                                                : '',
                                            style: TextStyle(
                                                color: Color(
                                                    ListColor.colorBlack))),
                                        TextSpan(
                                            text: controller.listData[index]
                                                        .qtyFreeSubuser >
                                                    0
                                                ? '${controller.listData[index].qtyPaidSubuser > 0 ? " + " : ""}${controller.listData[index].qtyFreeSubuser} ${'SubscriptionSubUser'.tr} ${'SubscriptionFree'.tr}'
                                                : '',
                                            style: TextStyle(
                                                color: Color(
                                                    ListColor.colorOrange))),
                                      ])),
                            )
                          : CustomText(
                              "-",
                              textAlign: TextAlign.right,
                              color: Color(ListColor.colorBlack),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1.2,
                            )),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(Get.context) * 13),
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
                    "SubscriptionPaymentMethod".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.2,
                  ),
                )),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      controller.listData[index].paymentName,
                      textAlign: TextAlign.right,
                      color: Color(ListColor.colorBlack),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.2,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: GlobalVariable.ratioWidth(Get.context) * 16),
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 14,
                right: GlobalVariable.ratioWidth(Get.context) * 14),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    "SubscriptionTotal".tr,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.2,
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
                    height: 1.2,
                  ),
                )
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
                  child: CustomText(
                    controller.listData[index].docNumber,
                    color: Color(ListColor.colorLightGrey4),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                )),
                Container(
                  alignment: Alignment.center,
                  height: GlobalVariable.ratioWidth(Get.context) * 28,
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 7,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 18),
                    border: Border.all(
                        width: GlobalVariable.ratioWidth(Get.context) * 1,
                        color: Color(ListColor.colorBlue)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 18),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 18),
                      onTap: () {
                        GetToPage.toNamed<SubscriptionDetailController>(
                            Routes.SUBSCRIPTION_DETAIL,
                            arguments: [
                              controller.listData[index].orderID,
                              TipeLayananSubscription.SU,
                              TipeDetailSubscription.LANGGANAN
                            ]);
                      },
                      child: Container(
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
