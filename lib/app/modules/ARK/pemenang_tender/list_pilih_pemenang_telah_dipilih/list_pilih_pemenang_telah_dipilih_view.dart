import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang_telah_dipilih/list_pilih_pemenang_telah_dipilih_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListPilihPemenangTelahDipilihView
    extends GetView<ListPilihPemenangTelahDipilihController> {
  String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(statusBarColor: Color(ListColor.colorBlue)));
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });

        return null;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarColor: Color(ListColor.colorBlue),
              statusBarIconBrightness: Brightness.light),
          child: Container(
              child: SafeArea(
            child: Scaffold(
              backgroundColor: Color(ListColor.colorLightGrey6),
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    GlobalVariable.ratioWidth(Get.context) * 56),
                child: Container(
                  alignment: Alignment.center,
                  height: GlobalVariable.ratioWidth(Get.context) * 56,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(ListColor.colorLightGrey).withOpacity(0.5),
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
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24))),
                      )),
                      Positioned(
                          child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                  child: Column(children: [
                                CustomText(
                                    "ProsesTenderLihatPesertaLabelPemenangYangTelahDipilih"
                                        .tr, //Pemenang yang Telah Dipilih
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.00,
                                    color: Color(ListColor.colorBlack1B)),
                                SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            9),
                                Obx(() => CustomText(
                                    "ProsesTenderLihatPesertaLabelJumlahPemenang"
                                            .tr + //Pemenang yang Telah Dipilih
                                        " : " +
                                        controller.totalPesertaDipilih.value
                                            .toString() +
                                        " " +
                                        "ProsesTenderLihatPesertaLabelPeserta"
                                            .tr, //Peserta
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.00,
                                    color: Color(ListColor.colorBlack1B))),
                              ])))),
                    ],
                  ),
                ),
              ),
              body: _listPemenang(),
            ),
          ))),
    );
  }

  Widget _listPemenang() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: _showListPemenang()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showListHeaderPeserta() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {},
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 20,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    0),
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 16),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: GlobalVariable.ratioWidth(Get.context) * 1,
                      color: Color(ListColor.colorLightGrey10)),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 10,
                  //     spreadRadius: 2,
                  //     offset: Offset(0, 5),
                  //   ),
                  // ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      controller.lokasi,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(ListColor.colorBlack1B),
                    ), // No. Tender
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 4),
                    CustomText(
                      GlobalVariable.formatCurrencyDecimal(
                              controller.nilaiMuatan) +
                          (controller.satuanTender == 2
                              ? " Unit"
                              : controller.satuanTender == 1
                                  ? " Ton"
                                  : " " + controller.satuanVolume),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    controller.satuanTender == 2
                        ? Column(
                            children: [
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4),
                              CustomText(controller.namaTruk,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3)),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 8),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            "ProsesTenderLihatPesertaButtonAlokasi" // Alokasi
                                .tr,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(ListColor.colorBlue),
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
                      height: GlobalVariable.ratioWidth(Get.context) * 4,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            GlobalVariable.formatCurrencyDecimal((double.parse(
                                            controller.totalAlokasi.value) -
                                        double.parse(
                                            controller.sisaAlokasi.value))
                                    .toString()) +
                                (controller.satuanTender == 2
                                    ? " Unit"
                                    : controller.satuanTender == 1
                                        ? " Ton"
                                        : " " + controller.satuanVolume),
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            //
                            color: Color(ListColor.colorBlue),
                          ),
                          CustomText(
                            GlobalVariable.formatCurrencyDecimal(
                                    controller.sisaAlokasi.value.toString()) +
                                (controller.satuanTender == 2
                                    ? " Unit"
                                    : controller.satuanTender == 1
                                        ? " Ton"
                                        : " " + controller.satuanVolume),
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
                )),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
        ]);
  }

  Widget _showListPemenang() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          : Container(
              child: SingleChildScrollView(
                  child: Column(children: [
              _showListHeaderPeserta(),
              _listPemenangTile()
            ])))
    ]);
  }

  Widget _listPemenangTile() {
    return Container(
        child: Column(children: [
      for (var index = 0; index < controller.listPemenang.length; index++)
        Container(
            child: Column(
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
                      borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
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
                              GlobalVariable.ratioWidth(Get.context) * 8,
                              GlobalVariable.ratioWidth(Get.context) * 13,
                              GlobalVariable.ratioWidth(Get.context) * 7),
                          decoration: BoxDecoration(
                              color: Color(ListColor.colorHeaderListTender),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                  topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          controller.listPemenang[index]
                                              ['transporter'],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          wrapSpace: true,
                                          height: 1.2),
                                      CustomText(
                                          controller.listPemenang[index]
                                              ['kota'],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                          color: Color(ListColor.colorGrey3),
                                          height: 1.2)
                                    ]),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(borderRadius),
                            //     bottomRight: Radius.circular(borderRadius))
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "hargapenawaran.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          Expanded(
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          2),
                                                  child: CustomText(
                                                    "ProsesTenderLihatPesertaLabelHargaPenawaran"
                                                        .tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    //
                                                    color: Colors.black,
                                                  )))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24),
                                          Expanded(
                                              child: Container(
                                                  child: CustomText(
                                            'Rp' +
                                                GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        controller.listPemenang[
                                                                index]
                                                            ['hargaPenawaran']),
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            height: 1.2,
                                            fontWeight: FontWeight.w600,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          )))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          10,
                                    ),
                                    //DOKUMEN
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "muatan.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          Expanded(
                                              child: Container(
                                                  child: CustomText(
                                            "ProsesTenderLihatPesertaLabelJumlahYangDialokasikan"
                                                .tr, //Jumlah yang dialokasikan
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            //
                                            color: Colors.black,
                                          )))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24),
                                          CustomText(
                                            GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        controller
                                                            .listPemenang[index]
                                                                ['alokasi']
                                                            .toString()) +
                                                (controller.satuanTender == 2
                                                    ? " Unit"
                                                    : controller.satuanTender ==
                                                            1
                                                        ? " Ton"
                                                        : " " +
                                                            controller
                                                                .satuanVolume),
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            height: 1.2,
                                            fontWeight: FontWeight.w600,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                bottom: GlobalVariable.ratioWidth(Get.context) *
                                    16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                    bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(""),
                                  ],
                                )),
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20),
                                  color: Colors.transparent,
                                  child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18),
                                      ),
                                      onTap: () async {
                                        controller.hapus(index);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                              vertical:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      6),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(
                                                      ListColor.colorRed)),
                                              borderRadius: BorderRadius.circular(
                                                  GlobalVariable.ratioWidth(Get.context) * 20)),
                                          child: Center(
                                            child: CustomText(
                                                'ProsesTenderLihatPesertaButtonHapusPilihan'
                                                    .tr, //'Hapus Pilihan'.tr,
                                                fontSize: 12,
                                                color:
                                                    Color(ListColor.colorRed),
                                                fontWeight: FontWeight.w600),
                                          ))),
                                ),
                                SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12),
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20),
                                  color: Colors.transparent,
                                  child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18),
                                      ),
                                      onTap: () async {
                                        controller.pilih(index);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                              vertical:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      6),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(
                                                      ListColor.colorBlue)),
                                              borderRadius: BorderRadius.circular(
                                                  GlobalVariable.ratioWidth(Get.context) * 20)),
                                          child: Center(
                                            child: CustomText(
                                                'ProsesTenderLihatPesertaLabelUbahAlokasi'
                                                    .tr, //'Ubah Alokasi'.tr,
                                                fontSize: 12,
                                                color:
                                                    Color(ListColor.colorBlue),
                                                fontWeight: FontWeight.w600),
                                          ))),
                                )
                              ],
                            )),
                      ],
                    )),
              )
            ]))
    ]));
  }
}
