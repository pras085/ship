import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'list_halaman_peserta_detail_penawaran_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';

class ListHalamanPesertaDetailPenawaranView
    extends GetView<ListHalamanPesertaDetailPenawaranController> {
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
                                        "ProsesTenderLihatPesertaLabelDetailPenawaran"
                                            .tr, //Detail Penawaran Peserta
                                        height: 1.2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.00,
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    body: Obx(() => !controller.onLoading.value
                        ? Container(
                            child: Form(
                                key: controller.form,
                                child: SingleChildScrollView(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      20),
                                              CustomText(
                                                  "ProsesTenderLihatPesertaLabelTransporter"
                                                      .tr, // Transporter
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(
                                                      ListColor.colorGrey3)),
                                              SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      8),
                                              CustomText(
                                                controller.namaTransporter,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      24),
                                              CustomText(
                                                  "ProsesTenderLihatPesertaLabelTanggalKirimPenawaran"
                                                      .tr, // Tanggal Kirim Penawaran
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(
                                                      ListColor.colorGrey3)),
                                              SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      8),
                                              CustomText(
                                                controller.tanggalPenawaran,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      24),
                                              //UPLOAD
                                              CustomText(
                                                  "ProsesTenderLihatPesertaLabelDokumenPenawaran"
                                                      .tr, // Dokumen Penawaran
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(
                                                      ListColor.colorGrey3)),
                                              SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      12),
                                              //UPLOAD
                                              controller.nama_file1.value != ""
                                                  ? Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      3,
                                                                  right: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      8),
                                                              child: SvgPicture.asset(
                                                                  GlobalVariable
                                                                          .imagePath +
                                                                      'dokumen_penawaran.svg',
                                                                  width: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      16,
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      16),
                                                            ),
                                                            Expanded(
                                                                child: CustomText(
                                                                    controller
                                                                        .nama_file1
                                                                        .value,
                                                                    fontSize:
                                                                        14,
                                                                    height: 1.2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
                                                                    wrapSpace:
                                                                        true,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue))),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                8),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                controller
                                                                    .fileke = 1;
                                                                controller.lihat(
                                                                    controller
                                                                        .link1
                                                                        .value,
                                                                    controller
                                                                        .nama_file1
                                                                        .value);
                                                              },
                                                              child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              18,
                                                                      vertical: GlobalVariable.ratioWidth(Get.context) *
                                                                          4),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color: Color(ListColor
                                                                              .colorBlue)),
                                                                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                          50)),
                                                                  child: CustomText(
                                                                      'ProsesTenderLihatPesertaButtonLihat'.tr, // Lihat
                                                                      fontSize: 12,
                                                                      color: Color(ListColor.colorBlue),
                                                                      fontWeight: FontWeight.w600)),
                                                            ),
                                                            SizedBox(
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                controller
                                                                    .fileke = 1;
                                                                controller.shareData(
                                                                    controller
                                                                        .link1
                                                                        .value,
                                                                    false);
                                                              },
                                                              child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              11,
                                                                      vertical:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              4),
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlue),
                                                                      border: Border.all(
                                                                          color: Color(ListColor
                                                                              .colorBlue)),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              GlobalVariable.ratioWidth(Get.context) * 50)),
                                                                  child: CustomText('ProsesTenderLihatPesertaButtonBagikan'.tr, // Bagikan
                                                                      fontSize: 12,
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.w600)),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              controller.nama_file2.value != ""
                                                  ? SizedBox(
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          12)
                                                  : SizedBox(),
                                              //UPLOAD
                                              controller.nama_file2.value != ""
                                                  ? Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      3,
                                                                  right: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      8),
                                                              child: SvgPicture.asset(
                                                                  GlobalVariable
                                                                          .imagePath +
                                                                      'dokumen_penawaran.svg',
                                                                  width: GlobalVariable
                                                                          .ratioWidth(Get
                                                                              .context) *
                                                                      16,
                                                                  height: GlobalVariable
                                                                          .ratioWidth(
                                                                              Get.context) *
                                                                      16),
                                                            ),
                                                            Expanded(
                                                                child: CustomText(
                                                                    controller
                                                                        .nama_file2
                                                                        .value,
                                                                    fontSize:
                                                                        14,
                                                                    height: 1.2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
                                                                    wrapSpace:
                                                                        true,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue))),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                8),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  24,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                controller
                                                                    .fileke = 2;
                                                                controller.lihat(
                                                                    controller
                                                                        .link2
                                                                        .value,
                                                                    controller
                                                                        .nama_file2
                                                                        .value);
                                                              },
                                                              child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              18,
                                                                      vertical: GlobalVariable.ratioWidth(Get.context) *
                                                                          4),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color: Color(ListColor
                                                                              .colorBlue)),
                                                                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                          50)),
                                                                  child: CustomText(
                                                                      'ProsesTenderLihatPesertaButtonLihat'.tr, // Lihat
                                                                      fontSize: 12,
                                                                      color: Color(ListColor.colorBlue),
                                                                      fontWeight: FontWeight.w600)),
                                                            ),
                                                            SizedBox(
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                controller
                                                                    .fileke = 2;
                                                                controller.shareData(
                                                                    controller
                                                                        .link2
                                                                        .value,
                                                                    false);
                                                              },
                                                              child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              11,
                                                                      vertical:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              4),
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlue),
                                                                      border: Border.all(
                                                                          color: Color(ListColor
                                                                              .colorBlue)),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              GlobalVariable.ratioWidth(Get.context) * 50)),
                                                                  child: CustomText('ProsesTenderLihatPesertaButtonBagikan'.tr, // Bagikan
                                                                      fontSize: 12,
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.w600)),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              //UPLOAD
                                              SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      24),
                                            ],
                                          )),
                                      for (var index = 0;
                                          index <
                                              controller.dataRuteTender.length;
                                          index++)
                                        controller.satuanTender == 2
                                            ? controller
                                                .unitTrukRuteDitenderkanWidget(
                                                    index)
                                            : controller.satuanTender == 1
                                                ? controller
                                                    .beratRuteDitenderkanWidget(
                                                        index)
                                                : controller.satuanTender == 3
                                                    ? controller
                                                        .volumeRuteDitenderkanWidget(
                                                            index)
                                                    : SizedBox()
                                    ]))))
                        : Center(child: CircularProgressIndicator()))))));
  }

  Future<bool> onWillPop() async {
    Get.back();
  }
}
