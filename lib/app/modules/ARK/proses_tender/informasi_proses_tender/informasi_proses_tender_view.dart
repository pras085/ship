import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'informasi_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';

class InformasiProsesTenderView
    extends GetView<InformasiProsesTenderController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
            child: SafeArea(
                child: Scaffold(
                    backgroundColor: Color(ListColor.colorLightGrey6),
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
                                        onWillPop();
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
                                          "ProsesTenderDetailLabelJenisProsesTenderTertutup"
                                              .tr, //Jenis Proses Tender Tertutup
                                          height: 1.2,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.00,
                                          color:
                                              Color(ListColor.colorDarkGrey3)),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    body: Obx(() => Container(
                        margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16,
                            right: GlobalVariable.ratioWidth(Get.context) * 16),
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 20,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "ProsesTenderDetailLabelInformasiYang"
                                            .tr +
                                        " ", //Informasi yang
                                    style: TextStyle(
                                      fontFamily: "AvenirNext",
                                      color: Color(ListColor.colorBlack1B),
                                      fontSize: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          14,
                                      height: 1.4,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: "\"" +
                                              "ProsesTenderDetailLabelTidakDapatDilihatPeserta"
                                                  .tr +
                                              "\"",
                                          style: TextStyle(
                                            fontFamily: "AvenirNext",
                                            color: Color(ListColor.colorRed),
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    14,
                                            height: 1.4,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: " :",
                                                style: TextStyle(
                                                  fontFamily: "AvenirNext",
                                                  color: Color(
                                                      ListColor.colorBlack1B),
                                                  fontSize: GlobalVariable
                                                          .ratioFontSize(
                                                              Get.context) *
                                                      14,
                                                  height: 1.4,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                children: [])
                                          ])
                                    ]),
                              ),
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              !controller.cekdaftarpeserta.value &&
                                      controller
                                          .cekdatarutedanhargapenawaran.value &&
                                      controller.jenisInfo == 'PESERTA TENDER'
                                  ? controller
                                      .keterangan1HargaPenawaranPesertaWidget()
                                  : controller.cekdaftarpeserta.value &&
                                          controller
                                              .cekdatarutedanhargapenawaran
                                              .value &&
                                          controller.jenisInfo ==
                                              'PESERTA TENDER'
                                      ? controller
                                          .keterangan1DaftarPesertadanHargaPenawaranPesertaWidget()
                                      : !controller.cekdaftarpemenang.value &&
                                              controller.cekdataalokasipemenang
                                                  .value &&
                                              controller.jenisInfo ==
                                                  'PEMENANG TENDER'
                                          ? controller
                                              .keterangan1DataAlokasiPemenangWidget()
                                          : controller.cekdaftarpemenang
                                                      .value &&
                                                  controller
                                                      .cekdataalokasipemenang
                                                      .value &&
                                                  controller.jenisInfo ==
                                                      'PEMENANG TENDER'
                                              ? controller
                                                  .keterangan1DaftarPemenangdanDataAlokasiPemenangWidget()
                                              : SizedBox(),
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              Container(
                                // padding: EdgeInsets.symmetric(
                                //     vertical: GlobalVariable.ratioWidth(
                                //             Get.context) *
                                //         12,
                                //     horizontal:
                                //         GlobalVariable.ratioWidth(Get.context) *
                                //             12),
                                alignment: Alignment.center,
                                // decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.all(
                                //         Radius.circular(
                                //             GlobalVariable.ratioWidth(
                                //                     Get.context) *
                                //                 50)),
                                //     border: Border.all(
                                //         color:
                                //             Color(ListColor.colorLightGrey10),
                                //         width: 1)),
                                child: Image.asset(
                                  controller.gambarAtas,
                                ),
                              ),
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              !controller.cekdaftarpeserta.value &&
                                      controller
                                          .cekdatarutedanhargapenawaran.value &&
                                      controller.jenisInfo == 'PESERTA TENDER'
                                  ? controller
                                      .keterangan2HargaPenawaranPesertaWidget()
                                  : controller.cekdaftarpeserta.value &&
                                          controller
                                              .cekdatarutedanhargapenawaran
                                              .value &&
                                          controller.jenisInfo ==
                                              'PESERTA TENDER'
                                      ? controller
                                          .keterangan2DaftarPesertadanHargaPenawaranPesertaWidget()
                                      : !controller.cekdaftarpemenang.value &&
                                              controller.cekdataalokasipemenang
                                                  .value &&
                                              controller.jenisInfo ==
                                                  'PEMENANG TENDER'
                                          ? controller
                                              .keterangan2DataAlokasiPemenangWidget()
                                          : controller.cekdaftarpemenang
                                                      .value &&
                                                  controller
                                                      .cekdataalokasipemenang
                                                      .value &&
                                                  controller.jenisInfo ==
                                                      'PEMENANG TENDER'
                                              ? controller
                                                  .keterangan2DaftarPemenangdanDataAlokasiPemenangWidget()
                                              : SizedBox(),
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              12,
                                      horizontal:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12)),
                                      border: Border.all(
                                          color:
                                              Color(ListColor.colorLightGrey10),
                                          width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      controller.jenisInfo == "PESERTA TENDER"
                                          ? CustomText(
                                              "ProsesTenderCreateLabelPreviewPesertaTender"
                                                  .tr,
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            )
                                          : controller.jenisInfo ==
                                                  "PEMENANG TENDER"
                                              ? CustomText(
                                                  "ProsesTenderCreateLabelPreviewPemenangTender"
                                                      .tr,
                                                  color: Color(
                                                      ListColor.colorBlack1B),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                )
                                              : SizedBox(),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      Image.asset(controller.gambarBawah),
                                    ],
                                  )),
                            ]))))))));
  }

  Future<bool> onWillPop() async {
    Get.back();
  }
}
