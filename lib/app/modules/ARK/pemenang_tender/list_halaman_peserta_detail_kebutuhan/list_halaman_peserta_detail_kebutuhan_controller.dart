import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListHalamanPesertaDetailKebutuhanController extends GetxController {
  var validasiSimpan = false;
  var form = GlobalKey<FormState>();
  var dataRuteTender = [];
  var satuanTender = 0;
  var satuanVolume = '';

  @override
  void onInit() {
    super.onInit();
    dataRuteTender = Get.arguments[0];
    satuanTender = Get.arguments[1];
    satuanVolume = Get.arguments[2];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Widget unitTrukRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioWidth(Get.context) * 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 12)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(Get.context).size.width,
                            padding: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16),
                            decoration: BoxDecoration(
                                color: Color(ListColor.colorHeaderListTender),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                    topRight: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10))),
                            child: CustomText(
                              "ProsesTenderLihatPesertaLabelRute".tr +
                                  " " +
                                  (index + 1).toString().tr, // Rute
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      15.5,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.8,
                                    child: Dash(
                                      direction: Axis.vertical,
                                      length: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          41,
                                      dashGap: 1.8,
                                      dashThickness: 1.5,
                                      dashLength: 5,
                                      dashColor: Color(ListColor.colorDash),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                26,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        3,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        'ic_pickup.svg',
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                              ),
                                              CustomText(
                                                  dataRuteTender[index]
                                                      ['pickup'],
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(
                                                      ListColor.colorBlack1B)),
                                            ],
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          3,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'ic_destinasi.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                            ),
                                            CustomText(
                                                dataRuteTender[index]
                                                    ['destinasi'],
                                                fontSize: 14,
                                                height: 1.2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                    ListColor.colorBlack1B)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (var indexDetail = 0;
                              indexDetail <
                                  dataRuteTender[index]['data'].length;
                              indexDetail++)
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        bottomRight: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10))),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  3,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'ic_truck_grey.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        Expanded(
                                            child: CustomText(
                                                dataRuteTender[index]['data']
                                                            [indexDetail]
                                                        ['nama_truk'] +
                                                    " - " +
                                                    dataRuteTender[index]
                                                                ['data']
                                                            [indexDetail]
                                                        ['nama_carrier'],
                                                fontSize: 14,
                                                height: 1.2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                maxLines: 2,
                                                wrapSpace: true,
                                                color: Colors.black))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'muatan.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        CustomText(
                                            GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['nilai']
                                                            .toString()) +
                                                " Unit",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  indexDetail !=
                                          dataRuteTender[index]['data'].length -
                                              1
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              bottom: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  13), // KARENA ADA HEIGHTNYA
                                          width: MediaQuery.of(Get.context)
                                              .size
                                              .width,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              0.5,
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                        )
                                      : SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                ]))
                        ],
                      )),
                )
              ])
        : SizedBox());
  }

  Widget beratRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioWidth(Get.context) * 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 12)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(Get.context).size.width,
                            padding: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16),
                            decoration: BoxDecoration(
                                color: Color(ListColor.colorHeaderListTender),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                    topRight: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10))),
                            child: CustomText(
                              "ProsesTenderLihatPesertaLabelRute".tr +
                                  " " +
                                  (index + 1).toString().tr, // Rute
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      15.5,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.8,
                                    child: Dash(
                                      direction: Axis.vertical,
                                      length: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          41,
                                      dashGap: 1.8,
                                      dashThickness: 1.5,
                                      dashLength: 5,
                                      dashColor: Color(ListColor.colorDash),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                26,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        3,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        'ic_pickup.svg',
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                              ),
                                              CustomText(
                                                  dataRuteTender[index]
                                                      ['pickup'],
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(
                                                      ListColor.colorBlack1B)),
                                            ],
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          3,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'ic_destinasi.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                            ),
                                            CustomText(
                                                dataRuteTender[index]
                                                    ['destinasi'],
                                                fontSize: 14,
                                                height: 1.2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                    ListColor.colorBlack1B)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (var indexDetail = 0;
                              indexDetail <
                                  dataRuteTender[index]['data'].length;
                              indexDetail++)
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        bottomRight: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10))),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'muatan.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        CustomText(
                                            GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['nilai']
                                                            .toString()) +
                                                " Ton",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  indexDetail !=
                                          dataRuteTender[index]['data'].length -
                                              1
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              bottom: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  13), // KARENA ADA HEIGHTNYA
                                          width: MediaQuery.of(Get.context)
                                              .size
                                              .width,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              0.5,
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                        )
                                      : SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                ]))
                        ],
                      )),
                )
              ])
        : SizedBox());
  }

  Widget volumeRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioWidth(Get.context) * 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 12)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(Get.context).size.width,
                            padding: EdgeInsets.fromLTRB(
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16,
                                GlobalVariable.ratioWidth(Get.context) * 16),
                            decoration: BoxDecoration(
                                color: Color(ListColor.colorHeaderListTender),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                    topRight: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10))),
                            child: CustomText(
                              "ProsesTenderLihatPesertaLabelRute".tr +
                                  " " +
                                  (index + 1).toString().tr, // Rute
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      15.5,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.8,
                                    child: Dash(
                                      direction: Axis.vertical,
                                      length: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          41,
                                      dashGap: 1.8,
                                      dashThickness: 1.5,
                                      dashLength: 5,
                                      dashColor: Color(ListColor.colorDash),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                26,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        3,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        'ic_pickup.svg',
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                              ),
                                              CustomText(
                                                  dataRuteTender[index]
                                                      ['pickup'],
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(
                                                      ListColor.colorBlack1B)),
                                            ],
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          3,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'ic_destinasi.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                            ),
                                            CustomText(
                                                dataRuteTender[index]
                                                    ['destinasi'],
                                                fontSize: 14,
                                                height: 1.2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                    ListColor.colorBlack1B)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (var indexDetail = 0;
                              indexDetail <
                                  dataRuteTender[index]['data'].length;
                              indexDetail++)
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10),
                                        bottomRight: Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                10))),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'muatan.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              color:
                                                  Color(ListColor.colorBlue)),
                                        ),
                                        CustomText(
                                            GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['nilai']
                                                            .toString()) +
                                                " " +
                                                satuanVolume,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  indexDetail !=
                                          dataRuteTender[index]['data'].length -
                                              1
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              bottom: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  13), // KARENA ADA HEIGHTNYA
                                          width: MediaQuery.of(Get.context)
                                              .size
                                              .width,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              0.5,
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                        )
                                      : SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                ]))
                        ],
                      )),
                )
              ])
        : SizedBox());
  }
}
