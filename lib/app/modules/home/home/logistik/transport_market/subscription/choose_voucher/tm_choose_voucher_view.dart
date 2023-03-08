import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/choose_voucher/tm_choose_voucher_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/back_button.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class TMChooseVoucherView extends GetView<TMChooseVoucherController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
          child: Material(
            color: Colors.white,
            child: SafeArea(
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
                child: Container(
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
                            Get.back();
                          }),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 8,
                      ),
                      Obx(
                        () => Expanded(
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
                                        enabled: !(controller.listVoucher.length == 0 &&
                                            controller.search.value.isEmpty),
                                        autofocus: false,
                                        onChanged: (value) {
                                          controller.searchOnSubmit(value,
                                              submit: false);
                                        },
                                        controller: controller.searchBar,
                                        textInputAction: TextInputAction.search,
                                        onSubmitted: (value) {
                                          controller.searchOnSubmit(value);
                                        },
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          height: 1.2,
                                        ),
                                        textSize: 14,
                                        newInputDecoration: InputDecoration(
                                            hintText:
                                                "SubscriptionCreateLabelCariKodeVoucher"
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
                                                GlobalVariable.ratioWidth(Get.context) *
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
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: controller.isShowClearSearch.value
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.onClearSearch();
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          4),
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                "assets/ic_close1,5.svg",
                                                color:
                                                    Color(ListColor.colorGrey3),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        15,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        15,
                                              )))
                                      : SizedBox.shrink(),
                                ),
                              ],
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
        ),
        body: SafeArea(
          child: Container(
            color: Color(ListColor.colorWhite),
            child: Obx(
              () => Stack(children: [
                controller.loading.value
                    ? Container(
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
                        child: Obx(
                          () => Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              controller.search.value.isEmpty
                                  ? SizedBox.shrink()
                                  : Container(
                                      margin: EdgeInsets.fromLTRB(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20,
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16,
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14),
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
                                              controller.listVoucher.length == 0
                                                  ? TextSpan(
                                                      text:
                                                          ("LocationManagementLabelShowNoLocation"
                                                                  .tr)
                                                              .replaceAll(
                                                                  "\"", ""))
                                                  : TextSpan(
                                                      text: ("LocationManagementLabelShowLocation"
                                                              .tr)
                                                          .replaceAll(
                                                              "#number",
                                                              controller
                                                                  .listVoucher
                                                                  .length
                                                                  .toString())
                                                          .replaceAll(
                                                              "\"", "")),
                                              TextSpan(
                                                  text:
                                                      "\"${controller.search.value}\"",
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
                                        ListView.builder(
                                          itemCount:
                                              controller.listVoucher.length,
                                          itemBuilder: (content, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller
                                                    .onClickPaketSubuser(index);
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          (index != 0
                                                              ? 7
                                                              : controller
                                                                      .search
                                                                      .value
                                                                      .isEmpty
                                                                  ? 20
                                                                  : 0),
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          7),
                                                  child: Stack(
                                                    children: [
                                                      Obx(
                                                        () => Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withAlpha(
                                                                          70),
                                                                  offset:
                                                                      Offset(
                                                                          0, 2),
                                                                  blurRadius: 2,
                                                                  spreadRadius:
                                                                      3)
                                                            ],
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: controller.listVoucher[index]
                                                                            [
                                                                            controller
                                                                                .getVoucherID] ==
                                                                        controller
                                                                            .selectedVoucherID
                                                                            .value
                                                                    ? Color(ListColor
                                                                        .colorBlue)
                                                                    : Colors
                                                                        .transparent,
                                                                width: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    0.5),
                                                            borderRadius: BorderRadius
                                                                .circular(GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    6),
                                                          ),
                                                          child: Container(
                                                            padding: EdgeInsets.only(
                                                                left: GlobalVariable.ratioWidth(Get
                                                                        .context) *
                                                                    16,
                                                                right: GlobalVariable.ratioWidth(Get
                                                                        .context) *
                                                                    16,
                                                                top: GlobalVariable.ratioWidth(Get.context) *
                                                                        14 -
                                                                    (14 *
                                                                        2.3 /
                                                                        11),
                                                                bottom: GlobalVariable.ratioWidth(
                                                                        Get.context) *
                                                                    14),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: controller.listVoucher[
                                                                              index]
                                                                          [
                                                                          controller
                                                                              .getVoucherID] ==
                                                                      controller
                                                                          .selectedVoucherID
                                                                          .value
                                                                  ? Color(ListColor
                                                                          .colorBlue)
                                                                      .withOpacity(
                                                                          0.1)
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              6),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        right: GlobalVariable.ratioWidth(Get.context) *
                                                                            27),
                                                                    child:
                                                                        CustomText(
                                                                      controller
                                                                              .listVoucher[index]
                                                                          [
                                                                          controller
                                                                              .getVoucherNote],
                                                                      fontSize:
                                                                          14,
                                                                      height:
                                                                          1.2,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    )),
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: GlobalVariable.ratioWidth(Get.context) *
                                                                            10),
                                                                    child: Text.rich(
                                                                        TextSpan(
                                                                            children: [
                                                                          TextSpan(
                                                                              text: "Kode : ",
                                                                              style: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 12, fontWeight: FontWeight.w500, color: Color(ListColor.colorGrey3))),
                                                                          TextSpan(
                                                                              text: controller.listVoucher[index][controller.getVoucherKode],
                                                                              style: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 12, fontWeight: FontWeight.w500, color: Colors.black))
                                                                        ]))),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          10),
                                                                  child: CustomText(
                                                                      "${controller.listVoucher[index][controller.getVoucherStartDate]} - ${controller.listVoucher[index][controller.getVoucherEndDate]}",
                                                                      fontSize:
                                                                          12,
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorGrey3),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned.fill(
                                                          child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: Container(
                                                                  margin: EdgeInsets.only(
                                                                      right: GlobalVariable.ratioWidth(Get
                                                                              .context) *
                                                                          16),
                                                                  child: SvgPicture.asset(
                                                                      "assets/ic_list_voucher.svg",
                                                                      width: GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          23)))),
                                                    ],
                                                  )),
                                            );
                                          },
                                        ),
                                        controller.listVoucher.length != 0
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
                                                          controller.search
                                                                  .value.isEmpty
                                                              ? "assets/ic_management_lokasi_no_data.svg"
                                                              : "assets/ic_management_lokasi_no_search.svg",
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              (controller
                                                                      .search
                                                                      .value
                                                                      .isEmpty
                                                                  ? 75
                                                                  : 95),
                                                        )),
                                                        Container(
                                                          height: 12,
                                                        ),
                                                        Container(
                                                            child: CustomText(
                                                          controller.search
                                                                  .value.isEmpty
                                                              ? "SubscriptionVoucherNoData"
                                                                  .tr
                                                              : "LocationManagementLabelNoKeywordFound"
                                                                  .tr
                                                                  .replaceAll(
                                                                      "\\n",
                                                                      "\n"),
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
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        topRight: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10)),
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.onSubmit();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            32,
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            160,
                                        decoration: BoxDecoration(
                                            color: Color(ListColor.color4),
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    26)),
                                        child: CustomText(
                                          "OK",
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      )))
                            ],
                          ),
                        ),
                      ),
                controller.cekLoading.value
                    ? Positioned.fill(
                        child: Container(
                        alignment: Alignment.center,
                        color: Colors.black.withAlpha(80),
                        child: Container(
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        10)),
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
                            )),
                      ))
                    : SizedBox.shrink()
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
