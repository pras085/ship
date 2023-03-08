import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/onchange_textfield_number.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/create_subuser/create_subuser_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class CreateSubuserView extends GetView<CreateSubuserController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return WillPopScope(
      onWillPop: controller.onWillPop,
      // onWillPop: () async => Future.value(false),
      child: Container(
        color: Colors.white,
        child: Scaffold(
          appBar: AppBarDetail(
            onClickBack: () async {
              controller.onBack();
            },
            title: "Sub User Subscription",
            prefixIcon: null,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
                child: Obx(
              () => Container(
                color: Color(ListColor.colorWhite),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Obx(
                          () => Container(
                            child:
                                controller.loadTotalSubuser.value ||
                                        controller.loadTimeline.value
                                    ? Center(child: CircularProgressIndicator())
                                    : Obx(
                                        () => ListView(
                                          children: [
                                            Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        20),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16),
                                                child: CustomText(
                                                    "SubscriptionCreateLabelPaketLangganan"
                                                        .tr,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        10),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16),
                                                child: Obx(() => CustomText(
                                                    controller
                                                        .paketSubscriptionName
                                                        .value,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(
                                                        ListColor.color4)))),
                                            Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        2),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            16),
                                                child: Obx(() => CustomText(
                                                    "SubscriptionCreateLabelBerlaku".tr +
                                                        controller
                                                            .paketSubscriptionPeriode
                                                            .value
                                                            .replaceAll(
                                                                "-",
                                                                "SubscriptionCreateLabelSampaiDengan"
                                                                    .tr),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(
                                                        ListColor.colorGrey3)))),
                                            Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        20),
                                            for (var index = 0;
                                                index <
                                                    controller
                                                        .jumlahPaketSubuser
                                                        .value;
                                                index++)
                                              Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.fromLTRB(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                      0,
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24),
                                                  padding: EdgeInsets.fromLTRB(
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        27,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            1,
                                                        color: Color(ListColor
                                                            .colorLightGrey10),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              GlobalVariable.ratioWidth(
                                                                      Get.context) *
                                                                  10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.3),
                                                          offset: Offset(
                                                              GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  0,
                                                              GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  3),
                                                          blurRadius: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              12,
                                                          spreadRadius: 0,
                                                        )
                                                      ]),
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  bottom: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      14,
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    CustomText(
                                                                        "SubscriptionCreateLabelTambahanSubuser"
                                                                            .tr,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            ListColor.colorLightGrey4)),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            top: GlobalVariable.ratioWidth(Get.context) *
                                                                                8),
                                                                        child:
                                                                            Obx(
                                                                          () => Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      controller.choosePaketSubuser(index);
                                                                                    },
                                                                                    child: Container(
                                                                                        height: GlobalVariable.ratioWidth(Get.context) * 40,
                                                                                        width: GlobalVariable.ratioWidth(Get.context) * 166,
                                                                                        padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 8), border: Border.all(color: Color(ListColor.colorLightGrey19), width: GlobalVariable.ratioWidth(Get.context) * 1)),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              child: Obx(
                                                                                                () => CustomText(controller.listPaketSubuser[index][controller.subuserID] == 0 ? "Pilih Paket" : controller.listPaketSubuser[index][controller.subuserName], fontWeight: FontWeight.w600, color: Color(ListColor.colorLightGrey4), maxLines: 1, overflow: TextOverflow.ellipsis),
                                                                                              ),
                                                                                            ),
                                                                                            Container(
                                                                                                margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 12),
                                                                                                child: SvgPicture.asset(
                                                                                                  "assets/ic_arrow_down_subscription.svg",
                                                                                                  color: Color(ListColor.colorGrey3),
                                                                                                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                                                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                                                )),
                                                                                          ],
                                                                                        )),
                                                                                  ),
                                                                                ),
                                                                                (controller.listPaketSubuser[index][controller.subuserDescription] as String).isEmpty
                                                                                    ? SizedBox.shrink()
                                                                                    : Expanded(
                                                                                        child: CustomText(
                                                                                          controller.listPaketSubuser[index][controller.subuserDescription],
                                                                                          color: Color(ListColor.colorLightGrey4),
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          textAlign: TextAlign.end,
                                                                                        ),
                                                                                      )
                                                                              ]),
                                                                        ))
                                                                  ],
                                                                )),
                                                            Container(
                                                                height: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    0.5,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorLightGrey2)),
                                                            SizedBox(
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  8,
                                                            ),
                                                            Container(
                                                                constraints: BoxConstraints(
                                                                    minHeight:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            65),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                7),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    CustomText(
                                                                        "SubscriptionCreateLabelJumlah"
                                                                            .tr,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            ListColor.colorLightGrey4)),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            top: GlobalVariable.ratioWidth(Get.context) *
                                                                                8),
                                                                        child:
                                                                            Obx(
                                                                          () => Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 8),
                                                                                  width: GlobalVariable.ratioWidth(Get.context) * 90,
                                                                                  child: jumlahPaketTextFielde(context, index),
                                                                                ),
                                                                                (controller.listPaketSubuser[index][controller.subuserDescription] as String).isEmpty
                                                                                    ? SizedBox.shrink()
                                                                                    : Expanded(
                                                                                        child: CustomText(
                                                                                          "${(controller.listPaketSubuser[index][controller.subuserTotal] * controller.listPaketSubuser[index][controller.subuserQtySubuser]).toString()} " + controller.listPaketSubuser[index][controller.subuserInfo],
                                                                                          // controller.listPaketSubuser[index][controller.subuserDescription],
                                                                                          color: Color(ListColor.colorLightGrey4),
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          textAlign: TextAlign.end,
                                                                                        ),
                                                                                      )
                                                                              ]),
                                                                        ))
                                                                  ],
                                                                )),
                                                            SizedBox(
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24,
                                                            ),
                                                            Container(
                                                                height: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    0.5,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorLightGrey2)),
                                                            Container(
                                                                constraints: BoxConstraints(
                                                                    minHeight:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            65),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                14),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    CustomText(
                                                                        "SubscriptionCreateLabelHargaPaketTambahan"
                                                                            .tr,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Color(
                                                                            ListColor.colorLightGrey4)),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            top: GlobalVariable.ratioWidth(Get.context) *
                                                                                8),
                                                                        child: Obx(() =>
                                                                            CustomText(
                                                                              Utils.formatUang(controller.listPaketSubuser[index][controller.subuserHarga].toDouble()),
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w700,
                                                                            )))
                                                                  ],
                                                                )),
                                                            Container(
                                                                height: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    0.5,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorLightGrey2)),
                                                            Container(
                                                                constraints: BoxConstraints(
                                                                    minHeight:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            40),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                14),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    CustomText(
                                                                      "SubscriptionCreateLabelPeriodeBerlaku"
                                                                          .tr,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorLightGrey14),
                                                                    ),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            top: GlobalVariable.ratioWidth(Get.context) *
                                                                                8),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Obx(
                                                                              () => Container(
                                                                                width: GlobalVariable.ratioWidth(Get.context) * 166,
                                                                                height: GlobalVariable.ratioWidth(Get.context) * 40,
                                                                                alignment: Alignment.center,
                                                                                margin: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 5),
                                                                                padding: EdgeInsets.only(right: GlobalVariable.ratioWidth(context) * 6),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 8), border: Border.all(color: Color(ListColor.colorLightGrey19), width: GlobalVariable.ratioWidth(Get.context) * 1)),
                                                                                child: controller.listPeriodeSubuser[index] == null || (controller.listPeriodeSubuser[index] as List).isEmpty
                                                                                    ? Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          Container(width: GlobalVariable.ratioWidth(Get.context) * 16),
                                                                                          Expanded(
                                                                                            child: CustomText(
                                                                                              "SubscriptionCreateLabelPilihPeriode".tr,
                                                                                              fontSize: 14,
                                                                                              fontWeight: FontWeight.w600,
                                                                                              color: Color(ListColor.colorLightGrey4),
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                            ),
                                                                                          ),
                                                                                          Container(width: GlobalVariable.ratioWidth(Get.context) * 4),
                                                                                          SvgPicture.asset(
                                                                                            "assets/ic_arrow_down_subscription.svg",
                                                                                            color: Color(ListColor.colorGrey3),
                                                                                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                                          ),
                                                                                          Container(width: GlobalVariable.ratioWidth(Get.context) * 4)
                                                                                        ],
                                                                                      )
                                                                                    : DropdownButtonHideUnderline(
                                                                                        child: ButtonTheme(
                                                                                          alignedDropdown: true,
                                                                                          child: Obx(
                                                                                            () => DropdownButton(
                                                                                              underline: SizedBox.shrink(),
                                                                                              isExpanded: true,
                                                                                              icon: SvgPicture.asset(
                                                                                                "assets/ic_arrow_down_subscription.svg",
                                                                                                color: Color(ListColor.colorGrey3),
                                                                                                width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                                                height: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                                              ),
                                                                                              value: controller.selectedPeriodeSubuser[index],
                                                                                              onChanged: (value) {
                                                                                                controller.selectedPeriodeSubuser[index] = value.toString();
                                                                                                controller.selectedPeriodeSubuser.refresh();
                                                                                              },
                                                                                              items: [
                                                                                                for (var posisi = 0; posisi < (controller.listPeriodeSubuser[index] as List).length; posisi++)
                                                                                                  DropdownMenuItem(
                                                                                                      value: controller.listPeriodeSubuser[index][posisi][controller.periodePeriodeString].toString(),
                                                                                                      child: CustomText(
                                                                                                          // controller.dateTimeFormat.format(controller.dateTimeAPIFormat.parse(controller.listPeriodeSubuser[index][posisi][controller.periodeStartDateString])),
                                                                                                          controller.listPeriodeSubuser[index][posisi][controller.periodeFullStartDateString],
                                                                                                          fontSize: 14,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          color: Color(ListColor.colorLightGrey4))),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                                child: Obx(
                                                                              () => CustomText((controller.listPeriodeSubuser[index] as List).isEmpty || controller.selectedPeriodeSubuser[index] == null || controller.selectedPeriodeSubuser[index] == "0" ? "" : "s/d ${(controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeFullEndDateString]}", fontWeight: FontWeight.w600, color: Color(ListColor.colorLightGrey4)),
                                                                            )),
                                                                          ],
                                                                        )),
                                                                    Container(
                                                                        margin: EdgeInsets.only(
                                                                            top: GlobalVariable.ratioWidth(Get.context) *
                                                                                14),
                                                                        width: double
                                                                            .infinity,
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                3.5,
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                19,
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                3.5,
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                17),
                                                                        decoration: BoxDecoration(
                                                                            color: Color(ListColor
                                                                                .colorBackTextField),
                                                                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                                6)),
                                                                        child: Column(
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 20.5),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    controller.listPeriodeSubuser[index] != null && (controller.listPeriodeSubuser[index] as List).isNotEmpty && (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeStartDateString] == controller.dateTimeAPIFormat.format(controller.paketSubscriptionPeriodeAwal.value) ? SizedBox.shrink() : Container(width: GlobalVariable.ratioWidth(Get.context) * 9, height: GlobalVariable.ratioWidth(Get.context) * 9, decoration: BoxDecoration(color: Color(ListColor.colorLightGrey2), shape: BoxShape.circle)),
                                                                                    controller.listPeriodeSubuser[index] != null && (controller.listPeriodeSubuser[index] as List).isNotEmpty && (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeStartDateString] == controller.dateTimeAPIFormat.format(controller.paketSubscriptionPeriodeAwal.value) ? SizedBox.shrink() : Expanded(child: Container(height: GlobalVariable.ratioWidth(Get.context) * 1, color: Color(ListColor.colorLightGrey2))),
                                                                                    controller.listPeriodeSubuser[index] == null || (controller.listPeriodeSubuser[index] as List).isEmpty ? SizedBox.shrink() : Container(width: GlobalVariable.ratioWidth(Get.context) * 9, height: GlobalVariable.ratioWidth(Get.context) * 9, decoration: BoxDecoration(color: Color(ListColor.color4), shape: BoxShape.circle)),
                                                                                    controller.listPeriodeSubuser[index] == null || (controller.listPeriodeSubuser[index] as List).isEmpty ? SizedBox.shrink() : Expanded(child: Container(height: GlobalVariable.ratioWidth(Get.context) * 1, color: Color(ListColor.color4))),
                                                                                    controller.listPeriodeSubuser[index] == null || (controller.listPeriodeSubuser[index] as List).isEmpty ? SizedBox.shrink() : Container(width: GlobalVariable.ratioWidth(Get.context) * 9, height: GlobalVariable.ratioWidth(Get.context) * 9, decoration: BoxDecoration(color: Color(ListColor.colorLightGrey2), shape: BoxShape.circle)),
                                                                                    controller.listPeriodeSubuser[index] != null && (controller.listPeriodeSubuser[index] as List).isNotEmpty && (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeEndDateString] == controller.dateTimeAPIFormat.format(controller.paketSubscriptionPeriodeAkhir.value) ? SizedBox.shrink() : Expanded(child: Container(height: GlobalVariable.ratioWidth(Get.context) * 1, color: Color(ListColor.colorLightGrey2))),
                                                                                    controller.listPeriodeSubuser[index] != null && (controller.listPeriodeSubuser[index] as List).isNotEmpty && (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeEndDateString] == controller.dateTimeAPIFormat.format(controller.paketSubscriptionPeriodeAkhir.value) ? SizedBox.shrink() : Container(width: GlobalVariable.ratioWidth(Get.context) * 9, height: GlobalVariable.ratioWidth(Get.context) * 9, decoration: BoxDecoration(color: Color(ListColor.colorLightGrey2), shape: BoxShape.circle))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                  margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 10, left: GlobalVariable.ratioWidth(Get.context) * 3.5, right: GlobalVariable.ratioWidth(Get.context) * 3.5),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      controller.listPeriodeSubuser[index] != null && (controller.listPeriodeSubuser[index] as List).isNotEmpty && (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeStartDateString] == controller.dateTimeAPIFormat.format(controller.paketSubscriptionPeriodeAwal.value)
                                                                                          ? SizedBox.shrink()
                                                                                          : Container(
                                                                                              width: GlobalVariable.ratioWidth(Get.context) * 50,
                                                                                              alignment: Alignment.center,
                                                                                              child: CustomText(
                                                                                                controller.paketSubscriptionPeriodeAwalFull.value,
                                                                                                textAlign: TextAlign.center,
                                                                                                color: Color(ListColor.colorLightGrey14),
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 12,
                                                                                              )),
                                                                                      controller.listPeriodeSubuser[index] != null && (controller.listPeriodeSubuser[index] as List).isNotEmpty && (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeStartDateString] == controller.dateTimeAPIFormat.format(controller.paketSubscriptionPeriodeAwal.value) ? SizedBox.shrink() : Spacer(),
                                                                                      controller.listPeriodeSubuser[index] == null || (controller.listPeriodeSubuser[index] as List).isEmpty
                                                                                          ? SizedBox.shrink()
                                                                                          : Container(
                                                                                              width: GlobalVariable.ratioWidth(Get.context) * 50,
                                                                                              alignment: Alignment.center,
                                                                                              child: CustomText(
                                                                                                (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeFullStartDateString],
                                                                                                textAlign: TextAlign.center,
                                                                                                color: Color(ListColor.colorLightGrey14),
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 12,
                                                                                              )),
                                                                                      controller.listPeriodeSubuser[index] == null || (controller.listPeriodeSubuser[index] as List).isEmpty ? SizedBox.shrink() : Spacer(),
                                                                                      controller.listPeriodeSubuser[index] == null || (controller.listPeriodeSubuser[index] as List).isEmpty
                                                                                          ? SizedBox.shrink()
                                                                                          : Container(
                                                                                              width: GlobalVariable.ratioWidth(Get.context) * 50,
                                                                                              alignment: Alignment.center,
                                                                                              child: CustomText(
                                                                                                (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeDotEndDateString],
                                                                                                textAlign: TextAlign.center,
                                                                                                color: Color(ListColor.colorLightGrey14),
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 12,
                                                                                              )),
                                                                                      controller.listPeriodeSubuser[index] != null && (controller.listPeriodeSubuser[index] as List).isNotEmpty && (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeEndDateString] == controller.dateTimeAPIFormat.format(controller.paketSubscriptionPeriodeAkhir.value) ? SizedBox.shrink() : Spacer(),
                                                                                      controller.listPeriodeSubuser[index] != null && (controller.listPeriodeSubuser[index] as List).isNotEmpty && (controller.listPeriodeSubuser[index] as List).where((element) => element[controller.periodePeriodeString].toString() == controller.selectedPeriodeSubuser[index]).toList()[0][controller.periodeEndDateString] == controller.dateTimeAPIFormat.format(controller.paketSubscriptionPeriodeAkhir.value)
                                                                                          ? SizedBox.shrink()
                                                                                          : Container(
                                                                                              width: GlobalVariable.ratioWidth(Get.context) * 50,
                                                                                              alignment: Alignment.center,
                                                                                              child: CustomText(
                                                                                                controller.paketSubscriptionDotAkhirFull.value,
                                                                                                textAlign: TextAlign.center,
                                                                                                color: Color(ListColor.colorLightGrey14),
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontSize: 12,
                                                                                              ))
                                                                                    ],
                                                                                  ))
                                                                            ])),
                                                                  ],
                                                                )),
                                                            Container(
                                                                height: GlobalVariable
                                                                        .ratioWidth(Get
                                                                            .context) *
                                                                    0.5,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorLightGrey2)),
                                                            Container(
                                                                constraints: BoxConstraints(
                                                                    minHeight:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            40),
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      14,
                                                                ),
                                                                child: Obx(
                                                                  () => Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                          child: CustomText(
                                                                              "SubscriptionCreateLabelHargaPaket".tr,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w700,
                                                                              color: Color(ListColor.colorLightGrey4))),
                                                                      Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8),
                                                                          child:
                                                                              Obx(
                                                                            () =>
                                                                                Row(
                                                                              children: [
                                                                                Obx(() => CustomText(Utils.formatUang((controller.listPaketSubuser[index][controller.subuserHarga]) * (controller.listPaketSubuser[index][controller.subuserTotal]).toDouble()), fontSize: 14, fontWeight: FontWeight.w600, color: controller.listVoucher.isNotEmpty && controller.listVoucher[0][controller.voucherPaketID] == controller.listPaketSubuser[index][controller.subuserID] && controller.listVoucher[0][controller.voucherAmount].toDouble() > 0 ? Color(ListColor.colorRed) : Colors.black, decoration: controller.listVoucher.isNotEmpty && controller.listVoucher[0][controller.voucherPaketID] == controller.listPaketSubuser[index][controller.subuserID] && controller.listVoucher[0][controller.voucherAmount].toDouble() > 0 ? TextDecoration.lineThrough : TextDecoration.none)),
                                                                                controller.listVoucher.isNotEmpty && controller.listVoucher[0][controller.voucherPaketID] == controller.listPaketSubuser[index][controller.subuserID] && controller.listVoucher[0][controller.voucherAmount].toDouble() > 0
                                                                                    ? Container(
                                                                                        margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 12),
                                                                                        child: CustomText(
                                                                                          Utils.formatUang(((controller.listPaketSubuser[index][controller.subuserHarga]) * (controller.listPaketSubuser[index][controller.subuserTotal]).toDouble()) - controller.listVoucher[0][controller.voucherAmount].toDouble()),
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight.w600,
                                                                                        ))
                                                                                    : SizedBox.shrink()
                                                                              ],
                                                                            ),
                                                                          )),
                                                                      controller.listVoucher.isNotEmpty &&
                                                                              controller.listVoucher[0][controller.voucherPaketID] == controller.listPaketSubuser[index][controller.subuserID] &&
                                                                              controller.listVoucher[0][controller.voucherFreeUser] > 0
                                                                          ? Container(margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 4), child: CustomText(("(" + ("SubscriptionCreateLabelGratisSubuser".tr) + ")").replaceAll("#", controller.listVoucher[0][controller.voucherFreeUser].toString()), fontSize: 12, fontWeight: FontWeight.w600, color: Color(ListColor.colorOrange)))
                                                                          : SizedBox.shrink()
                                                                    ],
                                                                  ),
                                                                )),
                                                            controller.jumlahPaketSubuser
                                                                        .value ==
                                                                    1
                                                                ? SizedBox
                                                                    .shrink()
                                                                : Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            GlobalVariable.ratioWidth(context) *
                                                                                8,
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          controller
                                                                              .deleteSubuser(index);
                                                                        },
                                                                        child: Container(
                                                                            width: double.infinity,
                                                                            margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 16),
                                                                            height: GlobalVariable.ratioWidth(Get.context) * 34,
                                                                            alignment: Alignment.center,
                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 32), border: Border.all(width: GlobalVariable.ratioWidth(Get.context) * 1, color: Color(ListColor.colorRed))),
                                                                            child: Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Container(
                                                                                  child: SvgPicture.asset(
                                                                                    "assets/ic_close2,5.svg",
                                                                                    width: GlobalVariable.ratioWidth(Get.context) * 10,
                                                                                    height: GlobalVariable.ratioWidth(Get.context) * 10,
                                                                                    color: Color(ListColor.colorRed),
                                                                                  ),
                                                                                ),
                                                                                Container(width: GlobalVariable.ratioWidth(Get.context) * 12),
                                                                                CustomText("SubscriptionCreateLabelHapusPaket".tr, fontWeight: FontWeight.w600, color: Color(ListColor.colorRed)),
                                                                              ],
                                                                            )),
                                                                      ),
                                                                    ],
                                                                  )
                                                          ]),
                                                      Obx(() => (controller.listPaketSubuser[
                                                                          index] !=
                                                                      null &&
                                                                  controller.listPaketSubuser[index]
                                                                          [
                                                                          controller
                                                                              .subuserID] !=
                                                                      0) &&
                                                              (controller.listPeriodeSubuser[
                                                                          index] ==
                                                                      null ||
                                                                  (controller.listPeriodeSubuser[index]
                                                                          as List)
                                                                      .isEmpty)
                                                          ? Positioned.fill(
                                                              child: Container(
                                                                color: Colors
                                                                    .white
                                                                    .withAlpha(
                                                                        190),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Obx(() => controller
                                                                        .listNeedRefreshPeriode
                                                                        .contains(
                                                                            index)
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          controller
                                                                              .listNeedRefreshPeriode
                                                                              .remove(index);
                                                                          controller
                                                                              .getSubuserPeriode(index);
                                                                        },
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
                                                                              border: Border.all(
                                                                                color: Color(ListColor.color4),
                                                                                width: GlobalVariable.ratioWidth(Get.context) * 1,
                                                                              ),
                                                                            ),
                                                                            padding: EdgeInsets.symmetric(
                                                                              horizontal: GlobalVariable.ratioWidth(Get.context) * 30,
                                                                              vertical: GlobalVariable.ratioWidth(Get.context) * 5,
                                                                            ),
                                                                            child: CustomText("SubscriptionCreateLabelCobaUlang".tr, color: Color(ListColor.color4))))
                                                                    : CircularProgressIndicator()),
                                                              ),
                                                            )
                                                          : SizedBox.shrink()),
                                                    ],
                                                  )),
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                              ),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    //Pengecekan jika list paket subuser sudah dipilih semua yang tersedia atau tidak
                                                    if (controller.listPaketSubuser[
                                                                controller
                                                                        .jumlahPaketSubuser
                                                                        .value -
                                                                    1][controller
                                                                .subuserID] !=
                                                            0 &&
                                                        controller
                                                                .jumlahPaketSubuser
                                                                .value !=
                                                            controller
                                                                .totalSemuaPaketSubuser
                                                                .value)
                                                    //Pengecekan apabila semua paket subuser yang dipilih sudah muncul periodenya atau tidak
                                                    if (controller
                                                            .listPaketSubuser
                                                            .any((element) =>
                                                                element !=
                                                                null) &&
                                                        controller
                                                            .listPeriodeSubuser
                                                            .any((element) =>
                                                                element !=
                                                                null) &&
                                                        controller
                                                            .listPeriodeSubuser
                                                            .any((element) =>
                                                                (element
                                                                        as List)
                                                                    .isNotEmpty))
                                                      controller.addSubuser();
                                                  },
                                                  child: Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric(
                                                          vertical:
                                                              GlobalVariable.ratioWidth(Get.context) *
                                                                  14),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Color(controller.listPaketSubuser[controller.jumlahPaketSubuser.value - 1][controller.subuserID] != 0 &&
                                                                  controller
                                                                          .jumlahPaketSubuser
                                                                          .value !=
                                                                      controller
                                                                          .totalSemuaPaketSubuser
                                                                          .value
                                                              ? ListColor.color4
                                                              : ListColor
                                                                  .colorLightGrey2),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  GlobalVariable.ratioWidth(Get.context) * 42)),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                              "assets/plus_white.svg",
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  16,
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  16),
                                                          // Icon(Icons.add,
                                                          //     color:
                                                          //         Colors.white,
                                                          //     size: GlobalVariable
                                                          //             .ratioWidth(
                                                          //                 Get.context) *
                                                          //         16),
                                                          Container(
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12),
                                                          CustomText(
                                                            "SubscriptionCreateLabelTambahPaket"
                                                                .tr,
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )
                                                        ],
                                                      ))),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                controller.chooseVoucher();
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      GlobalVariable.ratioWidth(Get.context) *
                                                          16,
                                                      GlobalVariable.ratioWidth(Get.context) *
                                                          24,
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                      0),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              16,
                                                      vertical: GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          14),
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withAlpha(70),
                                                            offset: Offset(
                                                                GlobalVariable.ratioWidth(Get
                                                                        .context) *
                                                                    0,
                                                                GlobalVariable.ratioWidth(Get
                                                                        .context) *
                                                                    4),
                                                            blurRadius: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                2,
                                                            spreadRadius: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                3)
                                                      ],
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(
                                                          GlobalVariable.ratioWidth(Get.context) * 10)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                          margin: EdgeInsets.only(
                                                              bottom: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  14),
                                                          child: CustomText(
                                                              "SubscriptionCreateLabelKodeVoucher"
                                                                  .tr,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                      Container(
                                                          child: Stack(
                                                              children: [
                                                            Positioned.fill(
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "assets/ic_voucher_bg.svg"),
                                                            ),
                                                            Container(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      minHeight:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              40),
                                                              child: Obx(
                                                                () => Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              20,
                                                                    ),
                                                                    SvgPicture
                                                                        .asset(
                                                                      "assets/ic_voucher.svg",
                                                                      height:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              15,
                                                                    ),
                                                                    Expanded(
                                                                        child: Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(Get.context) * 12),
                                                                            margin: EdgeInsets.only(left: GlobalVariable.ratioWidth(Get.context) * 10),
                                                                            child: Obx(() => CustomText(controller.listVoucher.isEmpty ? "SubscriptionCreateLabelPakaiKodePromo".tr : controller.listVoucher[0][controller.voucherCode], color: Color(ListColor.color4), fontSize: 12, fontWeight: controller.listVoucher.isEmpty ? FontWeight.w600 : FontWeight.w700)))),
                                                                    controller.listVoucher.length ==
                                                                            0
                                                                        ? Container(
                                                                            width:
                                                                                GlobalVariable.ratioWidth(Get.context) * 20,
                                                                          )
                                                                        : _button(
                                                                            marginRight:
                                                                                22,
                                                                            width:
                                                                                13,
                                                                            height:
                                                                                13,
                                                                            useShadow:
                                                                                true,
                                                                            borderRadius:
                                                                                50,
                                                                            customWidget:
                                                                                Container(
                                                                              child: SvgPicture.asset(
                                                                                "assets/ic_close_voucher_subscription.svg",
                                                                                width: GlobalVariable.ratioWidth(Get.context) * 5,
                                                                                height: GlobalVariable.ratioWidth(Get.context) * 5,
                                                                              ),
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              controller.listVoucher.clear();
                                                                              controller.listVoucher.refresh();
                                                                              controller.countAllSubuser();
                                                                              controller.countTotalHargaSubuser();
                                                                            })

                                                                    // GestureDetector(
                                                                    //     onTap:
                                                                    //         () {
                                                                    //       controller.listVoucher.clear();
                                                                    //       controller.listVoucher.refresh();
                                                                    //       controller.countAllSubuser();
                                                                    //       controller.countTotalHargaSubuser();
                                                                    //     },
                                                                    //     child:
                                                                    //         Container(
                                                                    //             padding: EdgeInsets
                                                                    //                 .symmetric(
                                                                    //               horizontal: GlobalVariable.ratioWidth(Get.context) * 20,
                                                                    //               vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                                                                    //             ),
                                                                    //             child: Container(
                                                                    //                 decoration: BoxDecoration(boxShadow: [
                                                                    //                   BoxShadow(color: Colors.grey.withAlpha(100), blurRadius: 0.5, spreadRadius: 1)
                                                                    //                 ], color: Colors.white, shape: BoxShape.circle),
                                                                    //                 width: GlobalVariable.ratioWidth(Get.context) * 13,
                                                                    //                 height: GlobalVariable.ratioWidth(Get.context) * 13,
                                                                    //                 child: Icon(Icons.close, size: GlobalVariable.ratioWidth(Get.context) * 9, color: Colors.black))
                                                                    //             // SvgPicture.asset(
                                                                    //             //     "assets/ic_close_round.svg")
                                                                    //             ))
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ]))
                                                    ],
                                                  )),
                                            ),
                                            Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    GlobalVariable.ratioWidth(Get.context) *
                                                        16,
                                                    GlobalVariable.ratioWidth(Get.context) *
                                                        24,
                                                    GlobalVariable.ratioWidth(Get.context) *
                                                        16,
                                                    0),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            16,
                                                    vertical:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            14),
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withAlpha(70),
                                                          offset: Offset(
                                                              GlobalVariable.ratioWidth(Get
                                                                      .context) *
                                                                  0,
                                                              GlobalVariable.ratioWidth(Get
                                                                      .context) *
                                                                  4),
                                                          blurRadius: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              2,
                                                          spreadRadius: GlobalVariable
                                                                  .ratioWidth(
                                                                      Get.context) *
                                                              3)
                                                    ],
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            GlobalVariable.ratioWidth(Get.context) * 10)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                8),
                                                        constraints: BoxConstraints(
                                                            minHeight: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                36),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                child: Obx(
                                                              () => Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text.rich(TextSpan(
                                                                        style: TextStyle(
                                                                            height:
                                                                                GlobalVariable.ratioWidth(Get.context) * 1.2),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: ("SubscriptionCreateLabelSubTotal".tr + " "),
                                                                              style: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 14, fontWeight: FontWeight.w600, color: Color(ListColor.colorLightGrey4))),
                                                                          TextSpan(
                                                                              text: "SubscriptionCreateLabelSebelumDiskon".tr,
                                                                              style: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 12, fontWeight: FontWeight.w600, color: Color(ListColor.colorLightGrey4))),
                                                                        ])),
                                                                    controller.totalSubuser.value >
                                                                                0 ||
                                                                            controller.totalFreeSubuser.value >
                                                                                0
                                                                        ? Text.rich(TextSpan(
                                                                            style:
                                                                                TextStyle(height: GlobalVariable.ratioWidth(Get.context) * 1.2),
                                                                            children: [
                                                                                TextSpan(text: (controller.totalSubuser.value == 0 ? "" : (("${controller.totalSubuser.value.toString()} ") + "SubscriptionCreateLabelSubUser".tr)), style: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 12, fontWeight: FontWeight.w600, color: Colors.black)),
                                                                                TextSpan(text: controller.totalFreeSubuser.value == 0 ? "" : (controller.totalSubuser.value != 0 && controller.totalFreeSubuser.value != 0 ? " + " : "") + ("SubscriptionCreateLabelGratisSubuser".tr).replaceAll("#", controller.totalFreeSubuser.value.toString()), style: TextStyle(fontSize: GlobalVariable.ratioFontSize(Get.context) * 12, fontWeight: FontWeight.w600, color: Color(ListColor.colorOrange))),
                                                                              ]))
                                                                        : SizedBox.shrink()
                                                                  ]),
                                                            )),
                                                            Container(
                                                                child: Obx(
                                                              () => CustomText(
                                                                  Utils.formatUang(
                                                                      controller
                                                                          .subtotal
                                                                          .value
                                                                          .toDouble()),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ))
                                                          ],
                                                        )),
                                                    Container(
                                                        width: double.infinity,
                                                        color: Color(ListColor
                                                            .colorLightGrey2),
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            0.5),
                                                    Container(
                                                        margin: EdgeInsets.symmetric(
                                                            vertical: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                8),
                                                        constraints: BoxConstraints(
                                                            minHeight: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                36),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                child: CustomText(
                                                                    "SubscriptionCreateLabelDiskonVoucher"
                                                                        .tr,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorLightGrey4))),
                                                            Container(
                                                                child: Obx(
                                                              () => CustomText(
                                                                  Utils.formatUang(controller
                                                                          .listVoucher
                                                                          .isEmpty
                                                                      ? 0.0
                                                                      : controller
                                                                          .listVoucher[
                                                                              0]
                                                                              [
                                                                              controller
                                                                                  .voucherAmount]
                                                                          .toDouble()),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorRed)),
                                                            ))
                                                          ],
                                                        )),
                                                    Container(
                                                        width: double.infinity,
                                                        color: Color(ListColor
                                                            .colorLightGrey2),
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            0.5),
                                                    Container(
                                                        margin: EdgeInsets.symmetric(
                                                            vertical: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                8),
                                                        constraints: BoxConstraints(
                                                            minHeight: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                36),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                child: CustomText(
                                                                    "SubscriptionCreateLabelBiayaLayanan"
                                                                        .tr,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorLightGrey4))),
                                                            Container(
                                                                child: Obx(
                                                              () => CustomText(
                                                                  Utils.formatUang(
                                                                      controller
                                                                          .biayaLayanan
                                                                          .value
                                                                          .toDouble()),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                            ))
                                                          ],
                                                        )),
                                                    Container(
                                                        width: double.infinity,
                                                        color: Color(ListColor
                                                            .colorLightGrey2),
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            0.5),
                                                    Container(
                                                        margin: EdgeInsets.symmetric(
                                                            vertical: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                8),
                                                        constraints: BoxConstraints(
                                                            minHeight: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                36),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                child: CustomText(
                                                                    "SubscriptionCreateLabelPajak"
                                                                        .tr,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorLightGrey4))),
                                                            Container(
                                                                child: Obx(
                                                              () => CustomText(
                                                                  Utils.formatUang(
                                                                      controller
                                                                          .totalPajak
                                                                          .value),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                            ))
                                                          ],
                                                        )),
                                                    Container(
                                                        width: double.infinity,
                                                        color: Color(ListColor
                                                            .colorLightGrey2),
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            0.5),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                8),
                                                        constraints: BoxConstraints(
                                                            minHeight: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                36),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                child: CustomText(
                                                                    "SubscriptionCreateLabelTotalPesanan"
                                                                        .tr,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorLightGrey4))),
                                                            Container(
                                                                child: Obx(
                                                              () => CustomText(
                                                                  Utils.formatUang(
                                                                      controller
                                                                          .totalPesanan
                                                                          .value),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black),
                                                            ))
                                                          ],
                                                        )),
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    GlobalVariable.ratioWidth(Get.context) *
                                                        16,
                                                    GlobalVariable.ratioWidth(Get.context) *
                                                        24,
                                                    GlobalVariable.ratioWidth(Get.context) *
                                                        16,
                                                    GlobalVariable.ratioWidth(Get.context) *
                                                        24),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            16,
                                                    vertical:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            14),
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withAlpha(70),
                                                          offset: Offset(
                                                              GlobalVariable.ratioWidth(Get
                                                                      .context) *
                                                                  0,
                                                              GlobalVariable.ratioWidth(Get
                                                                      .context) *
                                                                  4),
                                                          blurRadius: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              2,
                                                          spreadRadius: GlobalVariable
                                                                  .ratioWidth(
                                                                      Get.context) *
                                                              3)
                                                    ],
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(
                                                        GlobalVariable.ratioWidth(Get.context) * 10)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                14),
                                                        child: Obx(
                                                          () => Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child: CustomText(
                                                                    "SubscriptionCreateLabelMetodePembayaran"
                                                                        .tr,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                      fontSize: 14,
                                                                  ),
                                                                ),
                                                              controller
                                                                      .metodePembayaran
                                                                      .isEmpty
                                                                  ? SizedBox
                                                                      .shrink()
                                                                  : GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        controller
                                                                            .chooseMetodePembayaran(context);
                                                                      },
                                                                      child: CustomText(
                                                                          "SubscriptionCreateLabelGanti"
                                                                              .tr,
                                                                          fontSize:
                                                                              14,
                                                                          color: Color(ListColor
                                                                              .color4),
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                            ],
                                                          ),
                                                        )),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (controller
                                                            .metodePembayaran
                                                            .isEmpty)
                                                          controller
                                                              .chooseMetodePembayaran(
                                                                  context);
                                                      },
                                                      child: Container(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  20,
                                                              vertical: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  (controller
                                                                          .metodePembayaran
                                                                          .isNotEmpty
                                                                      ? 12
                                                                      : 8)),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    3),
                                                            color: Color(ListColor
                                                                    .colorLightGrey10)
                                                                .withAlpha(77),
                                                          ),
                                                          child: Obx(
                                                            () => Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                controller
                                                                        .metodePembayaran
                                                                        .isNotEmpty
                                                                    ? CachedNetworkImage(
                                                                        height:
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                16,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                        imageUrl:
                                                                            controller.metodePembayaran[0][controller
                                                                                .paymentThumbnail])
                                                                    : SvgPicture
                                                                        .asset(
                                                                        "assets/ic_metode_pembayaran.svg",
                                                                        height:
                                                                            GlobalVariable.ratioWidth(Get.context) *
                                                                                25,
                                                                      ),
                                                                Expanded(
                                                                    child: Container(
                                                                        margin: EdgeInsets.only(
                                                                            left: GlobalVariable.ratioWidth(Get.context) *
                                                                                10),
                                                                        child: Obx(() => CustomText(
                                                                            controller.metodePembayaran.isEmpty
                                                                                ? "SubscriptionCreateLabelPilihMetodePembayaranCap".tr
                                                                                : controller.metodePembayaran[0][controller.paymentName],
                                                                            color: controller.metodePembayaran.isEmpty ? Color(ListColor.color4) : Colors.black,
                                                                            fontSize: 12,
                                                                            fontWeight: FontWeight.w600))))
                                                              ],
                                                            ),
                                                          )),
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                          ),
                        )),
                      ],
                    ),
                    !controller.loadingCreate.value
                        ? SizedBox.shrink()
                        : Positioned.fill(
                            child: Container(
                                color: Colors.black.withAlpha(100),
                                child: Center(
                                  child: Container(
                                      padding: EdgeInsets.all(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  10)),
                                      child: CircularProgressIndicator()),
                                )))
                  ],
                ),
              ),
            )),
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            height: GlobalVariable.ratioWidth(Get.context) * 56,
            padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10),
                    topRight: Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(
                      GlobalVariable.ratioWidth(Get.context) * 0,
                      GlobalVariable.ratioWidth(Get.context) * -3,
                    ),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 55,
                    color: Colors.black.withOpacity(0.16),
                  ),
                ]),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () async {
                if (controller.selectedPeriodeSubuser.isNotEmpty &&
                    controller.selectedPeriodeSubuser[0] != "0" &&
                    controller.metodePembayaran.isNotEmpty) {
                  FocusScope.of(context).unfocus();
                  await controller.onSaving();
                }
              },
              child: Obx(
                () => Container(
                  alignment: Alignment.center,
                  height: GlobalVariable.ratioWidth(Get.context) * 32,
                  width: GlobalVariable.ratioWidth(Get.context) * 160,
                  decoration: BoxDecoration(
                      color: Color(
                          controller.selectedPeriodeSubuser.isNotEmpty &&
                                  controller.selectedPeriodeSubuser[0] != "0" &&
                                  controller.metodePembayaran.isNotEmpty
                              ? ListColor.color4
                              : ListColor.colorLightGrey2),
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 26)),
                  child: CustomText(
                    "SubscriptionCreateLabelBuatPesanan".tr,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget jumlahPaketTextFielde(BuildContext context, int index) {
    var textController =
        controller.listPaketSubuser[index][controller.subUserController];
    var textOnChange =
        controller.listPaketSubuser[index][controller.subUserController].text;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: GlobalVariable.ratioWidth(context) * 85,
          height: GlobalVariable.ratioWidth(context) * 24,
          padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
          margin: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: GlobalVariable.ratioWidth(Get.context) * 1.0,
                color: Color(ListColor.colorLightGrey10),
              ),
              bottom: BorderSide(
                width: GlobalVariable.ratioWidth(Get.context) * 1.0,
                color: Color(ListColor.colorLightGrey10),
              ),
            ),
          ),
          child: Focus(
            onFocusChange: (val) {
              if (!val) {
                controller.onChangeTotalSubuser(index,
                    textOnChange.isEmpty ? "0" : textOnChange, textController);
              }
            },
            child: CustomTextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              textSize: 14,
              context: Get.context,
              controller: textController,
              enabled:
                  controller.listPaketSubuser[index][controller.subuserID] != 0,
              newContentPadding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(context) * 5,
                GlobalVariable.ratioWidth(context) * 1,
                GlobalVariable.ratioWidth(context) * 2,
                GlobalVariable.ratioWidth(context) * 2,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                FilteringTextInputFormatter.digitsOnly,
              ],
              newInputDecoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              onChanged: (value) {
                if (controller.listPaketSubuser[index][controller.subuserID] !=
                        0 &&
                    double.tryParse(value) != null) {
                  textOnChange = value;
                  OnChangeTextFieldNumber.checkNumber(
                      () => textController, value, true);
                } else {
                  textController.text = "0";
                }
              },
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                if (controller.listPaketSubuser[index][controller.subuserID] !=
                    0) {
                  controller.onChangeTotalSubuser(
                      index,
                      (int.parse(textController.text) - 1).toString(),
                      textController);
                }
              },
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 4),
                    color: Colors.white,
                    border: Border.all(
                        width: GlobalVariable.ratioWidth(Get.context) * 1,
                        color: Color(ListColor.color4))),
                child: SvgPicture.asset("assets/ic_remove_1,5.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 14,
                    height: GlobalVariable.ratioWidth(Get.context) * 14,
                    color: Color(ListColor.color4)),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (controller.listPaketSubuser[index][controller.subuserID] !=
                    0) {
                  if (int.parse(textController.text) < 9999)
                    controller.onChangeTotalSubuser(
                        index,
                        (int.parse(textController.text) + 1).toString(),
                        textController);
                  else
                    controller.onChangeTotalSubuser(
                        index, "9999", textController);
                }
              },
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 4),
                    color: Colors.white,
                    border: Border.all(
                        width: GlobalVariable.ratioWidth(Get.context) * 1,
                        color: Color(ListColor.color4))),
                child: SvgPicture.asset("assets/ic_add_1,5.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 14,
                    height: GlobalVariable.ratioWidth(Get.context) * 14,
                    color: Color(ListColor.color4)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.colorBlack).withOpacity(0.2),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 1),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}
