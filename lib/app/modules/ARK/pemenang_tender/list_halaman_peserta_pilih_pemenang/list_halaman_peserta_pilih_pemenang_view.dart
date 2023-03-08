import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'list_halaman_peserta_pilih_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';

class ListHalamanPesertaPilihPemenangView
    extends GetView<ListHalamanPesertaPilihPemenangController> {
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
                                        "ProsesTenderLihatPesertaLabelPilihPemenang"
                                            .tr, //Pilih Pemenang Tender
                                        height: 1.2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.00,
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10),
                            topRight: Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: Offset(0, -5),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 6,
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 96),
                      child: MaterialButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 20))),
                        color: Color(ListColor.color4),
                        onPressed: () {
                          controller.onSave();
                        },
                        child: CustomText(
                          controller.tipeListPeserta == "SEKARANG"
                              ? "ProsesTenderLihatPesertaButtonSimpanDanUmumkan"
                                  .tr
                              : // Simpan dan Umumkan
                              "ProsesTenderLihatPesertaButtonSimpan"
                                  .tr, // Simpan
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    body: Obx(() => !controller.onLoading.value
                        ? Container(
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20),
                                _showListHeaderPeserta(),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      bottom: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          23), // KARENA ADA HEIGHTNYA
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0.5,
                                  color: Color(ListColor.colorLightGrey10),
                                ),
                                for (var index = 0;
                                    index < controller.dataRuteTender.length;
                                    index++)
                                  controller.satuanTender == 2
                                      ? controller
                                          .unitTrukRuteDitenderkanWidget(index)
                                      : controller.satuanTender == 1
                                          ? controller
                                              .beratRuteDitenderkanWidget(index)
                                          : controller.satuanTender == 3
                                              ? controller
                                                  .volumeRuteDitenderkanWidget(
                                                      index)
                                              : SizedBox(),
                                controller.errorPemenangTerisiSemua.value != ""
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                            SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                    right:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            16),
                                                decoration: BoxDecoration(
                                                    color: Color(ListColor
                                                        .colorBackgroundRed),
                                                    borderRadius: BorderRadius.circular(
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            5)),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8,
                                                  vertical:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          9,
                                                ),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: CustomText(
                                                              controller
                                                                  .errorPemenangTerisiSemua
                                                                  .value
                                                                  .tr,
                                                              color: Color(
                                                                  ListColor
                                                                      .colorRed),
                                                              fontSize: 10,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ))),
                                                    GestureDetector(
                                                      child: SvgPicture.asset(
                                                          GlobalVariable
                                                                  .imagePath +
                                                              'ic_close.svg',
                                                          width: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              8,
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              8,
                                                          color: Colors.black),
                                                      onTap: () async {
                                                        controller
                                                            .errorPemenangTerisiSemua
                                                            .value = "";
                                                      },
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16),
                                          ])
                                    : SizedBox()
                              ])))
                        : Center(child: CircularProgressIndicator()))))));
  }

  Widget _showListHeaderPeserta() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {},
            child: Container(
                margin: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          GlobalVariable.ratioWidth(Get.context) * 16),
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorHeaderListTender),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 10),
                              topRight: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) *
                                      10))),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(controller.judulTender,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      color: Color(ListColor.colorBlack1B),
                                      height: 1.2),
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4),
                                  CustomText(
                                    controller.noTender,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                    color: Color(ListColor.colorGrey3),
                                  ),
                                ]),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 10),
                              bottomRight: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) *
                                      10))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Container(
                                              child: CustomText(
                                        "ProsesTenderLihatPesertaLabelNamaMuatan" // Nama Muatan
                                            .tr,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color(ListColor.colorLightGrey14),
                                      )))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                          child: Container(
                                              child: CustomText(
                                        controller.muatan,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        height: 1.2,
                                        color: Color(ListColor.colorBlack1B),
                                        fontWeight: FontWeight.w600,
                                      )))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          14,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        "ProsesTenderLihatPesertaLabelKebutuhan" // Kebutuhan
                                            .tr,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color(ListColor.colorLightGrey14),
                                      ),
                                      CustomText(
                                        "ProsesTenderLihatPesertaLabelSisa" // Sisa
                                            .tr,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        textAlign: TextAlign.right,
                                        fontWeight: FontWeight.w700,
                                        color: Color(ListColor.colorRed),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        GlobalVariable.formatCurrencyDecimal(
                                                controller.totalKebutuhan.value
                                                    .toString()) +
                                            (controller.satuanTender == 2
                                                ? " Unit"
                                                : controller.satuanTender == 1
                                                    ? " Ton"
                                                    : " " +
                                                        controller
                                                            .satuanVolume),
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        //
                                        color: Color(ListColor.colorBlack1B),
                                      ),
                                      CustomText(
                                        GlobalVariable.formatCurrencyDecimal(
                                                controller.sisaKebutuhan.value
                                                    .toString()) +
                                            (controller.satuanTender == 2
                                                ? " Unit"
                                                : controller.satuanTender == 1
                                                    ? " Ton"
                                                    : " " +
                                                        controller
                                                            .satuanVolume),
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        textAlign: TextAlign.right,
                                        fontWeight: FontWeight.w600,
                                        //
                                        color: Color(ListColor.colorRed),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ]);
  }

  Future<bool> onWillPop() async {
    if (controller.dataRuteTenderSebelumnya !=
        controller.dataRuteTender.value) {
      GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          title: "ProsesTenderLihatPesertaLabelKonfirmasiSimpan"
              .tr, //Konfirmasi Simpan
          message:
              "ProsesTenderLihatPesertaLabelDataPilihPemenangAkanTersimpanSebagaiDraft"
                  .tr, //Data Pilih Peenang akan tersimpan sebagai draft?
          labelButtonPriority1: GlobalAlertDialog.yesLabelButton,
          onTapPriority1: () async {
            await controller.setDataLocalRute();
            if (controller.mode == 'UBAH') {
              Get.back();
            } else {
              Get.back(result: true);
            }
          },
          onTapPriority2: () async {
            controller.removeDataLocalRute();
            if (controller.mode == 'UBAH') {
              Get.back();
            } else {
              Get.back(result: true);
            }
          },
          labelButtonPriority2: GlobalAlertDialog.noLabelButton);
    }
  }
}
