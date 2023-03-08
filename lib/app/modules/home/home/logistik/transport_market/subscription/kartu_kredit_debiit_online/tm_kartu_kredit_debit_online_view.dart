import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/kartu_kredit_debiit_online/tm_kartu_kredit_debit_online_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class TMKartuKreditDebitOnlineView
    extends GetView<TMKartuKreditDebitOnlineController> {
  final numberFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => controller.afterBuild());
    return WillPopScope(
      onWillPop: () {
        return controller.onWillPop();
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBarDetail(
          title: "SubscriptionOnlineCreditAppBar".tr,
          prefixIcon: null,
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus.unfocus();
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Color(ListColor.colorWhite),
            child: Obx(() => controller.onLoading.value
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: Get.height,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        panelTotalPesanan(),
                        panelRincianKartu(),
                      ],
                    )))),
          ),
        ),
        bottomNavigationBar: Container(
            height: GlobalVariable.ratioWidth(Get.context) * 55,
            decoration: BoxDecoration(
                color: Color(ListColor.color2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10),
                    topRight: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.16),
                  )
                ]),
            child: Center(
                child: Obx(
              () => TextButton(
                  onPressed: () {
                    if (controller.valid.value) controller.onClickOk();
                  },
                  style: TextButton.styleFrom(
                      minimumSize: Size(
                          GlobalVariable.ratioWidth(Get.context) * 160,
                          GlobalVariable.ratioWidth(Get.context) * 36),
                      backgroundColor: Color(controller.valid.value
                          ? ListColor.color4
                          : ListColor.colorLightGrey2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18))),
                  child: CustomText(
                    'SubscriptionPayNow'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(ListColor.color2),
                  )),
            ))),
      ),
    );
  }

  panelTotalPesanan() {
    return Container(
        margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 20,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 14),
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 14,
            GlobalVariable.ratioWidth(Get.context) * 14,
            GlobalVariable.ratioWidth(Get.context) * 14,
            GlobalVariable.ratioWidth(Get.context) * 14),
        decoration: BoxDecoration(
          // color: Color(ListColor.color2),
          border: Border.all(
              color: Color(ListColor.colorLightGrey10),
              width: GlobalVariable.ratioWidth(Get.context) * 1),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 10),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                      child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText('SubscriptionCreateLabelTotalPesanan'.tr,
                      fontSize: 14,
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(Get.context) * 4,
                  ),
                  CustomText(
                      "${Utils.formatUang(controller.totalPesanan ?? 0)}",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(ListColor.colorGreen3))
                ],
              ))),
              GestureDetector(
                  onTap: () {
                    showDetail();
                  },
                  child: CustomText("SubscriptionDetail".tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)))
            ]));
  }

  panelRincianKartu() {
    return Container(
        margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 16),
        decoration: BoxDecoration(
          // color: Color(ListColor.color2),
          border: Border.all(
              color: Color(ListColor.colorLightGrey10),
              width: GlobalVariable.ratioWidth(Get.context) * 1),
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * 10),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 13,
                      GlobalVariable.ratioWidth(Get.context) * 14,
                      GlobalVariable.ratioWidth(Get.context) * 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: CustomText("SubscriptionCardDetails".tr,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(ListColor.colorBlack))),
                      controller.metodePembayaran.paymentID == '8'
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  "assets/visa_icon.svg",
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          13,
                                ),
                                SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                ),
                                SvgPicture.asset(
                                  "assets/mastercard_icon.svg",
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          22,
                                ),
                              ],
                            )
                          : CachedNetworkImage(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 15,
                              fit: BoxFit.fitHeight,
                              imageUrl:
                                  controller.metodePembayaran?.thumbnail ?? "")
                    ],
                  )),
              Container(
                width: double.infinity,
                height: GlobalVariable.ratioWidth(Get.context) * 1,
                color: Color(ListColor.colorLightGrey10),
              ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //   child: Divider(
              //       height: GlobalVariable.ratioWidth(Get.context) * 1,
              //       color: Color(ListColor.colorLightGrey10)),
              // ),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 16,
                      GlobalVariable.ratioWidth(Get.context) * 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText("SubscriptionCardNumber".tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4)),
                      SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 12),
                      CustomTextField(
                        context: Get.context,
                        textAlign: TextAlign.left,
                        newContentPadding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(Get.context) * 12,
                            GlobalVariable.ratioWidth(Get.context) * 10,
                            GlobalVariable.ratioWidth(Get.context) * 12,
                            GlobalVariable.ratioWidth(Get.context) * 10),
                        newInputDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(ListColor.colorLightGrey19),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          1.0),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(ListColor.colorLightGrey19),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          1.0),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
                          isDense: true,
                          isCollapsed: true,
                          hintText: "1234 4567 7890 0909",
                          hintStyle: TextStyle(
                              color: Color(ListColor.colorLightGrey2)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(ListColor.colorLightGrey19),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          1.0),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 8)),
                        ),
                        textSize: 14,
                        controller: controller.textNoKartu,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorLightGrey4)),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                          CardNumberInputFormatter()
                        ],
                        onChanged: (value) {
                          controller.checkValid();
                        },
                        // onChanged: (value) {}
                      ),
                      SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 6,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          "SubscriptionValidityPeriod".tr,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color(ListColor.colorLightGrey4)),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      CustomTextField(
                                        context: Get.context,
                                        textAlign: TextAlign.left,
                                        newContentPadding: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                12,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        newInputDecoration: InputDecoration(
                                          isDense: true,
                                          isCollapsed: true,
                                          hintText: "SubscriptionLabelDMY".tr.substring(3,8),
                                          hintStyle: TextStyle(
                                              color: Color(
                                                  ListColor.colorLightGrey2)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(ListColor
                                                      .colorLightGrey19),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1.0),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(ListColor
                                                      .colorLightGrey19),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1.0),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(ListColor
                                                      .colorLightGrey19),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1.0),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8)),
                                        ),
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                          CardMonthInputFormatter()
                                        ],
                                        textSize: 14,
                                        controller: controller.textMasaBerlaku,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(
                                                ListColor.colorLightGrey4)),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          controller.checkValid();
                                        },
                                      ),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16),
                                    ])),
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    19),
                            Expanded(
                                flex: 5,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText("SubscriptionCardCVV".tr,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color(ListColor.colorLightGrey4)),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      Stack(
                                        children: [
                                          CustomTextField(
                                              context: Get.context,
                                              textAlign: TextAlign.left,
                                              newContentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10,
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10),
                                              newInputDecoration:
                                                  InputDecoration(
                                                isDense: true,
                                                isCollapsed: true,
                                                hintText:
                                                    "SubscriptionCardCVV".tr,
                                                hintStyle: TextStyle(
                                                    color: Color(ListColor
                                                        .colorLightGrey2)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(ListColor
                                                            .colorLightGrey19),
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            1.0),
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(ListColor
                                                            .colorLightGrey19),
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            1.0),
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8)),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color(ListColor
                                                            .colorLightGrey19),
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            1.0),
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8)),
                                              ),
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    3)
                                              ],
                                              textSize: 14,
                                              obscureText:
                                                  !controller.showCVV.value,
                                              controller: controller.textCVV,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(ListColor
                                                      .colorLightGrey4)),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                controller.checkValid();
                                              }),
                                          Positioned.fill(
                                              child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          14),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.showCVV.value =
                                                      !controller.showCVV.value;
                                                },
                                                child: controller.showCVV.value
                                                    ? Icon(
                                                        Icons
                                                            .remove_red_eye_outlined,
                                                        color: Color(ListColor
                                                            .colorBlue))
                                                    : Icon(
                                                        Icons
                                                            .remove_red_eye_outlined,
                                                        color: Color(ListColor
                                                            .colorLightGrey2)),
                                              ),
                                            ),
                                          ))
                                        ],
                                      ),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              16),
                                    ]))
                          ]),
                      SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 4),
                      CustomText("SubscriptionSelectPayment".tr,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4)),
                      SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 6),
                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //       // color: Color(ListColor.colorLightGrey19),
                        //       color: Colors.grey[300],
                        //       width: 1.0),
                        //   borderRadius: BorderRadius.circular(8),
                        // ),

                        ///toppp
                        child: Obx(() => DropdownBelow(
                              itemWidth: MediaQuery.of(Get.context).size.width -
                                  GlobalVariable.ratioWidth(Get.context) * 64,
                              itemTextstyle: TextStyle(
                                  color: Color(ListColor.colorBlack),
                                  fontWeight: FontWeight.w500,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14),
                              boxTextstyle: TextStyle(
                                  color: Color(ListColor.colorLightGrey4),
                                  fontWeight: FontWeight.w600,
                                  fontSize: GlobalVariable.ratioFontSize(
                                          Get.context) *
                                      14),
                              boxPadding: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      12,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12),
                              boxWidth: MediaQuery.of(Get.context).size.width -
                                  GlobalVariable.ratioWidth(Get.context) * 64,
                              boxHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 40,
                              boxDecoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 8),
                                  border: Border.all(
                                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                                    // color: Colors.grey[300],
                                    color: Color(ListColor.colorLightGrey19),
                                  )),
                              icon: Icon(Icons.keyboard_arrow_down,
                                  size: GlobalVariable.ratioWidth(Get.context) * 30, color: Color(ListColor.colorGrey3)),
                              hint: CustomText("SubscriptionSelectPayment".tr,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(ListColor.colorLightGrey4)),
                              value: controller.pilihPembayaran.value == '0'
                                  ? null
                                  : controller.pilihPembayaran.value,
                              items: [
                                DropdownMenuItem(
                                  child: CustomText(
                                      controller.listPilihPembayaran[0],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(ListColor.colorBlack)),
                                  value: "1",
                                ),
                                DropdownMenuItem(
                                  child: CustomText(
                                      controller.listPilihPembayaran[1],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(ListColor.colorBlack)),
                                  value: "2",
                                ),
                              ],
                              onChanged: (value) {
                                controller.pilihPembayaran.value = value;
                                controller.checkValid();
                                FocusManager.instance.primaryFocus.unfocus();
                              },
                            )),

                        ///beloww
                        // child: Obx(() => DropdownButton(
                        //       hint: Container(
                        //         padding: EdgeInsets.all(12),
                        //         alignment: Alignment.centerLeft,
                        //         child: CustomText(
                        //             "SubscriptionSelectPayment".tr,
                        //             fontSize: 14,
                        //             overflow: TextOverflow.ellipsis,
                        //             fontWeight: FontWeight.w600,
                        //             color: Color(ListColor.colorLightGrey4)),
                        //       ),
                        //       underline: Container(),
                        //       isExpanded: true,
                        //       elevation: 4,
                        //       icon: Padding(
                        //           padding: EdgeInsets.all(12),
                        //           child: Icon(Icons.keyboard_arrow_down,
                        //               color:
                        //                   Color(ListColor.colorLightGrey4))),
                        //       value: controller.pilihPembayaran.value,
                        //       selectedItemBuilder: (BuildContext context) {
                        //         return controller.listPilihPembayaran
                        //             .map<Widget>((data) {
                        //           return Container(
                        //               padding: EdgeInsets.all(12),
                        //               alignment: Alignment.centerLeft,
                        //               child: CustomText(data,
                        //                   fontSize: 14,
                        //                   maxLines: 1,
                        //                   overflow: TextOverflow.ellipsis,
                        //                   fontWeight: FontWeight.w600,
                        //                   color: Color(
                        //                       ListColor.colorLightGrey4)));
                        //         }).toList();
                        //       },
                        //       onTap: () {
                        //         FocusManager.instance.primaryFocus.unfocus();
                        //       },
                        //       items:
                        //           controller.listPilihPembayaran.map((data) {
                        //         return DropdownMenuItem(
                        //           child: Container(
                        //               padding: EdgeInsets.all(12),
                        //               alignment: Alignment.centerLeft,
                        //               child: CustomText(
                        //                 data,
                        //                 fontSize: 14,
                        //                 maxLines: 2,
                        //                 overflow: TextOverflow.ellipsis,
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.black,
                        //               )),
                        //           value: controller.listPilihPembayaran
                        //               .indexOf(data)
                        //               .toString(),
                        //         );
                        //       }).toList(),
                        //       onChanged: (value) {
                        //         controller.pilihPembayaran.value = value;
                        //         controller.checkValid();
                        //       },
                        //     ))),

                        // SizedBox(height: 16),
                        // Container(
                        //     decoration: BoxDecoration(
                        //       border: Border.all(
                        //           color: Color(ListColor.colorLightGrey10),
                        //           width: 1),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: Obx(() => ExpansionTile(
                        //             initiallyExpanded:
                        //                 controller.isExpanded.value,
                        //             title: CustomText(
                        //                 controller.pilihPembayaran.value == ""
                        //                     ? "Pilih Pembayaran"
                        //                     : controller.pilihPembayaran.value),
                        //             trailing: Obx(() => Icon(
                        //                 controller.isExpanded.value
                        //                     ? Icons.keyboard_arrow_up
                        //                     : Icons.keyboard_arrow_down,
                        //                 color: Color(ListColor.colorLightGrey4))),
                        //             onExpansionChanged: (value) {
                        //               controller.isExpanded.value = value;
                        //             },
                        //             children: [
                        //               Padding(
                        //                   padding:
                        //                       EdgeInsets.fromLTRB(16, 0, 16, 4),
                        //                   child: Divider(
                        //                       height: 1,
                        //                       color: Color(
                        //                           ListColor.colorLightGrey10))),
                        //               for (int i = 0;
                        //                   i <
                        //                       controller
                        //                           .listPilihPembayaran.length;
                        //                   i++)
                        //                 ListTile(
                        //                     onTap: () {
                        //                       print('Debug: before ' +
                        //                           controller.isExpanded.value
                        //                               .toString());
                        //                       controller.isExpanded.value = false;
                        //                       print('Debug: after ' +
                        //                           controller.isExpanded.value
                        //                               .toString());
                        //                       controller.pilihPembayaran.value =
                        //                           controller
                        //                               .listPilihPembayaran[i];
                        //                     },
                        //                     title: CustomText(
                        // controller
                        //         .listPilihPembayaran[i] ??
                        //                             "",
                        //                         color:
                        //                             Color(ListColor.colorBlack))),
                        //               SizedBox(height: 16),
                        //             ]))),
                      )
                    ],
                  )),
            ]));
  }

  Future showDetail() async {
    FocusManager.instance.primaryFocus.unfocus();
    await showModalBottomSheet(
        context: Get.context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10), 
                topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
        backgroundColor: Colors.white,
        builder: (context) {
          return Column(children: [
            _grabbingBar(),
            _title(),
            Expanded(
                child: SingleChildScrollView(
                    child: Container(
                        // padding: EdgeInsets.only(
                        //     bottom:
                        //         MediaQuery.of(Get.context).viewInsets.bottom),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                  _textLine('SubscriptionPaymentMethod'.tr,
                      'SubscriptionCreditDebit'.tr,
                      colorValue: Colors.black, fontWeight: FontWeight.w600),
                  _textLine('SubscriptionSubTotal'.tr,
                      "${Utils.formatUang(controller.subtotal ?? 0)}",
                      subCaption: (controller.subuser ?? 0) == 0
                          ? ""
                          : ("(${controller.subuser ?? 0} ${'SubscriptionPaidUser'.tr}" +
                              ((controller.freeSubuser ?? 0) == 0 ? ")" : "")),
                      subCaption2: (controller.freeSubuser ?? 0) == 0
                          ? ""
                          : "+ ${'SubscriptionFree'.tr} ${(controller.freeSubuser ?? 0)} ${'SubscriptionSubUser'.tr})",
                      colorValue: Colors.black,
                      fontWeight: FontWeight.w600),
                  _textLine(
                      'SubscriptionVoucherCode'.tr,
                      controller.kodeVoucher.isEmpty
                          ? "-"
                          : "${controller.kodeVoucher}", // 'PENGGUNABARU',
                      colorValue: controller.kodeVoucher.isEmpty
                          ? Colors.black
                          : Color(ListColor.colorBlue),
                      fontWeight: FontWeight.w700),
                  _textLine(
                      'SubscriptionDiscountVoucher'.tr,
                      controller.kodeVoucher.isEmpty
                          ? "${Utils.formatUang(0)}"
                          : "${controller.discVoucher == null || controller.discVoucher == 0 ? "" : "- "}${Utils.formatUang(controller.discVoucher ?? 0)}", // '- Rp 500.000',
                      colorValue: Color(ListColor.colorRed),
                      fontWeight: FontWeight.w600),
                  _textLine('SubscriptionServiceFee'.tr,
                      "${Utils.formatUang(controller.biayaLayanan ?? 0)}", // 'Rp 1.000',
                      colorValue: Colors.black,
                      fontWeight: FontWeight.w600),
                  _textLine('SubscriptionTax'.tr,
                      "${Utils.formatUang(controller.pajak ?? 0)}", // 'Rp 0'
                      colorValue: Colors.black,
                      fontWeight: FontWeight.w600),
                  _textLine('SubscriptionTotalOrders'.tr,
                      "${Utils.formatUang(controller.totalPesanan ?? 0)}", // 'Rp. 4.000.000',
                      showBottomLine: false,
                      colorValue: Colors.black,
                      fontWeight: FontWeight.w700),
                  SizedBox(
                    height: GlobalVariable.ratioWidth(context) * 8,
                  ),
                ]))))
          ]);
        });
  }

  Widget _grabbingBar() {
    return Container(
      margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 3),
      width: GlobalVariable.ratioWidth(Get.context) * 38, // Get.width / 10,
      height: GlobalVariable.ratioWidth(Get.context) * 3,
      decoration: BoxDecoration(
        color: Color(ListColor.colorLightGrey16),
        borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 4),
      ),
    );
  }

  Widget _title() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 16,
        GlobalVariable.ratioWidth(Get.context) * 12,
        GlobalVariable.ratioWidth(Get.context) * 16,
        GlobalVariable.ratioWidth(Get.context) * 20,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              "assets/ic_close1,5.svg",
              width: GlobalVariable.ratioWidth(Get.context) * 24,
              height: GlobalVariable.ratioWidth(Get.context) * 24,
              color: Colors.black,
            ),
          ),
          Expanded(
              child: Center(
                  child: CustomText('SubscriptionPaymentDetail'.tr,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(ListColor.color4)))),
          SizedBox(
            width: GlobalVariable.ratioWidth(Get.context) * 24,
            height: GlobalVariable.ratioWidth(Get.context) * 24,
          ),
        ],
      ),
    );
  }

  Widget _textLine(String caption, String value,
      {String subCaption = "",
      String subCaption2 = "",
      Color colorValue,
      FontWeight fontWeight,
      bool showBottomLine = true}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            0, 
            GlobalVariable.ratioWidth(Get.context) * 16, 
            0,
          ),
          constraints: BoxConstraints(
            minHeight: GlobalVariable.ratioWidth(Get.context) * 38,
          ),
          alignment: Alignment.center,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      caption,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ((subCaption == "") && (subCaption == ""))
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              subCaption == ""
                                  ? SizedBox()
                                  : CustomText(
                                      subCaption,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor.colorBlack),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              subCaption2 == ""
                                  ? SizedBox()
                                  : CustomText(
                                      ' ' + subCaption2,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor.colorOrange),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ],
                          )
                  ],
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          value,
                          fontSize: 14,
                          fontWeight: fontWeight ?? FontWeight.w600,
                          textAlign: TextAlign.end,
                          color: colorValue ?? Color(ListColor.colorBlack),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if ((subCaption != "") || (subCaption != ""))
                          CustomText(
                            '',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorBlack),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
              ])),
        if (showBottomLine)
          Container(
            width: double.infinity, 
            height: GlobalVariable.ratioWidth(Get.context) * 0.5,
            color: Color(ListColor.colorLightGrey2),
            margin: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 8, 
              GlobalVariable.ratioWidth(Get.context) * 16, 
              GlobalVariable.ratioWidth(Get.context) * 8,
            ),
          ),
      ],
    );
  }
}
