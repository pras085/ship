import 'dart:async';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'create_notification_harga_controller.dart';

class CreateNotificationHargaView
    extends GetView<CreateNotificationHargaController> {
  String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(statusBarColor: Color(ListColor.colorBlue)));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Color(ListColor.colorBlue),
            statusBarIconBrightness: Brightness.light),
        child: Container(
          color: Color(ListColor.colorBackgroundTender),
          child: WillPopScope(
              onWillPop: onWillPop,
              child: SafeArea(
                child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(
                          GlobalVariable.ratioWidth(Get.context) * 56),
                      child: Container(
                        alignment: Alignment.center,
                        height: GlobalVariable.ratioWidth(Get.context) * 56,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 16,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 12),
                        decoration: BoxDecoration(boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(ListColor.colorLightGrey)
                                .withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ], color: Colors.white),
                        child: Stack(
                          children: [
                            Positioned(
                                child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              "ic_back_blue_button.svg",
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24))),
                            )),
                            Positioned(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      child: CustomText(
                                        "CariHargaTransportIndexPengaturanNotifikasiHarga"
                                            .tr, //Pengaturan Notifikasi Harga
                                        height: 1.2,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    body: Obx(() => !controller.isLoading.value
                        ? SingleChildScrollView(
                            child: Container(
                                margin: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    controller.blueBox(),
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      10),
                                              topRight: Radius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      10),
                                              bottomLeft: Radius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      10),
                                              bottomRight: Radius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      10),
                                            ),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                                offset: Offset(0, 5),
                                              ),
                                            ],
                                            color: Colors.white),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    controller.tutupBuat.value =
                                                        !controller
                                                            .tutupBuat.value;
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft: Radius.circular(
                                                                GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    10),
                                                            topRight: Radius.circular(
                                                                GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    10),
                                                            bottomLeft: Radius.circular(
                                                                GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    10),
                                                            bottomRight: Radius
                                                                .circular(GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    10),
                                                          ),
                                                          color: Colors
                                                              .transparent),
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              16,
                                                          vertical: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              16),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              child: Container(
                                                                  child:
                                                                      CustomText(
                                                            'CariHargaTransportIndexBuatNotifikasiHarga'
                                                                .tr, // Buat Notifikasi Harga
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 14,
                                                          ))),
                                                          SvgPicture.asset(
                                                            (!controller
                                                                    .tutupBuat
                                                                    .value
                                                                ? GlobalVariable
                                                                        .imagePath +
                                                                    'expand.svg'
                                                                : GlobalVariable
                                                                        .imagePath +
                                                                    'unexpand.svg'),
                                                            width: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                18,
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                18,
                                                          ),
                                                        ],
                                                      ))),
                                              Obx(() => !controller
                                                      .tutupBuat.value
                                                  ? Container(
                                                      margin: EdgeInsets.symmetric(
                                                          horizontal: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              16),
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            controller
                                                                .lineDividerWidget(),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    12),
                                                            CustomText(
                                                                "CariHargaTransportIndexPickup"
                                                                    .tr, //"Pickup".tr,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey3)),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    8),
                                                            GestureDetector(
                                                                child:
                                                                    AbsorbPointer(
                                                                        child:
                                                                            Obx(
                                                                  () =>
                                                                      CustomTextFormField(
                                                                    context: Get
                                                                        .context,
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    controller:
                                                                        controller
                                                                            .lokasiPickupController
                                                                            .value,
                                                                    newContentPadding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              12,
                                                                    ),
                                                                    textSize:
                                                                        14,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorLightGrey4),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                    newInputDecoration:
                                                                        InputDecoration(
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                      prefix:
                                                                          SizedBox(
                                                                        width: GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                      ),
                                                                      suffixIcon: Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              left: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              right: GlobalVariable.ratioWidth(Get.context) *
                                                                                  12,
                                                                              bottom: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8),
                                                                          child: SvgPicture.asset(
                                                                              GlobalVariable.imagePath + "Chevron Down Blue.svg",
                                                                              width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              height: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              color: Color(ListColor.colorLightGrey14))),
                                                                      isDense:
                                                                          true,
                                                                      isCollapsed:
                                                                          true,
                                                                      hintText:
                                                                          "CariHargaTransportIndexPilih"
                                                                              .tr, //Pilih
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Color(
                                                                            ListColor.colorLightGrey4),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                                onTap:
                                                                    () async {
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      .unfocus();
                                                                  controller
                                                                      .pilihLokasi(
                                                                          'PICKUP');
                                                                }),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    24),
                                                            CustomText(
                                                                "CariHargaTransportIndexDestinasi"
                                                                    .tr, //"Pickup".tr,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey3)),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    8),
                                                            GestureDetector(
                                                                child:
                                                                    AbsorbPointer(
                                                                        child:
                                                                            Obx(
                                                                  () =>
                                                                      CustomTextFormField(
                                                                    context: Get
                                                                        .context,
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    controller:
                                                                        controller
                                                                            .lokasiDestinasiController
                                                                            .value,
                                                                    newContentPadding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              12,
                                                                    ),
                                                                    textSize:
                                                                        14,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorLightGrey4),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                    newInputDecoration:
                                                                        InputDecoration(
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                      prefix:
                                                                          SizedBox(
                                                                        width: GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                      ),
                                                                      suffixIcon: Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              left: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              right: GlobalVariable.ratioWidth(Get.context) *
                                                                                  12,
                                                                              bottom: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8),
                                                                          child: SvgPicture.asset(
                                                                              GlobalVariable.imagePath + "Chevron Down Blue.svg",
                                                                              width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              height: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              color: Color(ListColor.colorLightGrey14))),
                                                                      isDense:
                                                                          true,
                                                                      isCollapsed:
                                                                          true,
                                                                      hintText:
                                                                          "CariHargaTransportIndexPilih"
                                                                              .tr, //Pilih
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Color(
                                                                            ListColor.colorLightGrey4),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                                onTap:
                                                                    () async {
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      .unfocus();
                                                                  controller
                                                                      .pilihLokasi(
                                                                          'DESTINASI');
                                                                }),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    24),
                                                            CustomText(
                                                                "CariHargaTransportIndexJenisTruk"
                                                                    .tr, //"Jenis Truk".tr,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey3)),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    8),
                                                            GestureDetector(
                                                                child:
                                                                    AbsorbPointer(
                                                                        child:
                                                                            Obx(
                                                                  () =>
                                                                      CustomTextFormField(
                                                                    context: Get
                                                                        .context,
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    controller:
                                                                        controller
                                                                            .dataTrukController
                                                                            .value,
                                                                    newContentPadding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              12,
                                                                    ),
                                                                    textSize:
                                                                        14,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorLightGrey4),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                    newInputDecoration:
                                                                        InputDecoration(
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                      prefix:
                                                                          SizedBox(
                                                                        width: GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                      ),
                                                                      suffixIcon: Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              left: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              right: GlobalVariable.ratioWidth(Get.context) *
                                                                                  12,
                                                                              bottom: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8),
                                                                          child: SvgPicture.asset(
                                                                              GlobalVariable.imagePath + "Chevron Down Blue.svg",
                                                                              width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              height: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              color: Color(ListColor.colorLightGrey14))),
                                                                      isDense:
                                                                          true,
                                                                      isCollapsed:
                                                                          true,
                                                                      hintText:
                                                                          "CariHargaTransportIndexPilih"
                                                                              .tr, //Pilih
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Color(
                                                                            ListColor.colorLightGrey4),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                                onTap:
                                                                    () async {
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      .unfocus();
                                                                  controller
                                                                      .getTruk();
                                                                }),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    24),
                                                            CustomText(
                                                                "CariHargaTransportIndexJenisCarrier"
                                                                    .tr, //"Jenis Carrier".tr,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey3)),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    8),
                                                            GestureDetector(
                                                                child:
                                                                    AbsorbPointer(
                                                                        child:
                                                                            Obx(
                                                                  () =>
                                                                      CustomTextFormField(
                                                                    context: Get
                                                                        .context,
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    controller:
                                                                        controller
                                                                            .dataCarrierController
                                                                            .value,
                                                                    newContentPadding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              12,
                                                                    ),
                                                                    textSize:
                                                                        14,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorLightGrey4),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                    newInputDecoration:
                                                                        InputDecoration(
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                      prefix:
                                                                          SizedBox(
                                                                        width: GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                      ),
                                                                      suffixIcon: Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              left: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              right: GlobalVariable.ratioWidth(Get.context) *
                                                                                  12,
                                                                              bottom: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8),
                                                                          child: SvgPicture.asset(
                                                                              GlobalVariable.imagePath + "Chevron Down Blue.svg",
                                                                              width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              height: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              color: Color(ListColor.colorLightGrey14))),
                                                                      isDense:
                                                                          true,
                                                                      isCollapsed:
                                                                          true,
                                                                      hintText:
                                                                          "CariHargaTransportIndexPilih"
                                                                              .tr, //Pilih
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Color(
                                                                            ListColor.colorLightGrey4),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                                onTap:
                                                                    () async {
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      .unfocus();
                                                                  controller
                                                                      .getCarrier();
                                                                }),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    24),
                                                            CustomText(
                                                                "CariHargaTransportIndexTransporter"
                                                                    .tr, //"Transporter".tr,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey3)),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    8),
                                                            GestureDetector(
                                                                child:
                                                                    AbsorbPointer(
                                                                        child:
                                                                            Obx(
                                                                  () =>
                                                                      CustomTextFormField(
                                                                    context: Get
                                                                        .context,
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    controller:
                                                                        controller
                                                                            .transporterController
                                                                            .value,
                                                                    newContentPadding:
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              12,
                                                                    ),
                                                                    textSize:
                                                                        14,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorLightGrey4),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                    newInputDecoration:
                                                                        InputDecoration(
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                      prefix:
                                                                          SizedBox(
                                                                        width: GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                      ),
                                                                      suffixIcon: Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              left: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8,
                                                                              right: GlobalVariable.ratioWidth(Get.context) *
                                                                                  12,
                                                                              bottom: GlobalVariable.ratioWidth(Get.context) *
                                                                                  8),
                                                                          child: SvgPicture.asset(
                                                                              GlobalVariable.imagePath + "Chevron Down Blue.svg",
                                                                              width: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              height: GlobalVariable.ratioWidth(Get.context) * 24,
                                                                              color: Color(ListColor.colorLightGrey14))),
                                                                      isDense:
                                                                          true,
                                                                      isCollapsed:
                                                                          true,
                                                                      hintText:
                                                                          "CariHargaTransportIndexPilih"
                                                                              .tr, //Pilih
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        color: Color(
                                                                            ListColor.colorLightGrey4),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                                onTap:
                                                                    () async {
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      .unfocus();
                                                                  controller
                                                                      .selectTransporter();
                                                                }),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    24),
                                                            CustomText(
                                                                "CariHargaTransportIndexJenisNotifikasi"
                                                                    .tr, //"Jenis Notifikasi".tr,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorGrey3)),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    8),
                                                            Obx(() =>
                                                                DropdownBelow(
                                                                  itemWidth: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          32,
                                                                  itemTextstyle: TextStyle(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorGrey3),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              14),
                                                                  boxTextstyle: TextStyle(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorLightGrey4),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              14),
                                                                  boxPadding: EdgeInsets.only(
                                                                      left: GlobalVariable.ratioWidth(Get
                                                                              .context) *
                                                                          11,
                                                                      right:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              8),
                                                                  boxWidth: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          32,
                                                                  boxHeight:
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          44,
                                                                  boxDecoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                              6),
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color: controller.errorNotifikasi.value != ""
                                                                              ? Color(ListColor.colorRed)
                                                                              : Color(ListColor.colorGrey2))),
                                                                  icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_sharp,
                                                                      size: 27,
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorLightGrey14)),
                                                                  hint: CustomText(
                                                                      controller.notifikasi.value == 0
                                                                          ? "CariHargaTransportIndexPilih".tr //Pilih
                                                                          : controller.arrNotifikasi[controller.notifikasi.value].tr,
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 14,
                                                                      color: Color(ListColor.colorLightGrey4)),
                                                                  value: controller
                                                                              .notifikasi
                                                                              .value ==
                                                                          0
                                                                      ? null
                                                                      : controller
                                                                          .notifikasi
                                                                          .value,
                                                                  items: [
                                                                    DropdownMenuItem(
                                                                      child: CustomText(
                                                                          controller
                                                                              .arrNotifikasi[
                                                                                  1]
                                                                              .tr,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Color(ListColor.colorLightGrey4)),
                                                                      value: 1,
                                                                    ),
                                                                    DropdownMenuItem(
                                                                      child: CustomText(
                                                                          controller
                                                                              .arrNotifikasi[
                                                                                  2]
                                                                              .tr,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Color(ListColor.colorLightGrey4)),
                                                                      value: 2,
                                                                    ),
                                                                    DropdownMenuItem(
                                                                      child: CustomText(
                                                                          controller
                                                                              .arrNotifikasi[
                                                                                  3]
                                                                              .tr,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Color(ListColor.colorLightGrey4)),
                                                                      value: 3,
                                                                    ),
                                                                    DropdownMenuItem(
                                                                      child: CustomText(
                                                                          controller
                                                                              .arrNotifikasi[
                                                                                  4]
                                                                              .tr,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Color(ListColor.colorLightGrey4)),
                                                                      value: 4,
                                                                    ),
                                                                  ],
                                                                  onChanged:
                                                                      (value) {
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        .unfocus();
                                                                    print(
                                                                        value);
                                                                    //FocusManager.instance.primaryFocus.unfocus();
                                                                    controller
                                                                        .notifikasi
                                                                        .value = value;
                                                                    controller
                                                                        .cekData();
                                                                  },
                                                                )),
                                                            controller.errorNotifikasi
                                                                        .value !=
                                                                    ""
                                                                ? Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      SizedBox(
                                                                          height:
                                                                              GlobalVariable.ratioWidth(Get.context) * 4),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child: Obx(() => CustomText(
                                                                                    controller.errorNotifikasi.value.tr,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 12,
                                                                                    height: 1.2,
                                                                                    color: Color(ListColor.colorRed),
                                                                                  ))),
                                                                          SizedBox(
                                                                              width: GlobalVariable.ratioWidth(Get.context) * 74)
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )
                                                                : SizedBox(),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    24),
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                      child: CustomText(
                                                                          '')),
                                                                  Obx(() =>
                                                                      MaterialButton(
                                                                        elevation:
                                                                            0,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20))),
                                                                        color: controller.validasiSimpan.value
                                                                            ? Color(ListColor.colorBlue)
                                                                            : Color(ListColor.colorLightGrey2),
                                                                        onPressed: controller.validasiSimpan.value
                                                                            ? () {
                                                                                FocusManager.instance.primaryFocus.unfocus();
                                                                                controller.simpan();
                                                                              }
                                                                            : () {},
                                                                        child: Container(
                                                                            margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                                                                            child: CustomText(
                                                                              "ManajemenHargaTransportTambahHargaTransportMarketSimpan".tr, // Simpan
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12,
                                                                            )),
                                                                      )),
                                                                ]),
                                                            SizedBox(
                                                                height: GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    12)
                                                          ]))
                                                  : SizedBox()),
                                            ])),
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24),
                                    controller.expandedWidget()
                                  ],
                                )))
                        : Center(child: CircularProgressIndicator()))),
              )),
        ));
  }

  Future<bool> onWillPop() {
    return Future.value(true);
  }
}
