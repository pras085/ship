import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListPilihPemenangTelahDipilihController extends GetxController
    with SingleGetTickerProviderMixin {
  var isLoadingData = true.obs;
  var listPemenang = [].obs;

  var alokasiController = TextEditingController();

  var idTender = '';
  var satuanTender = 0;
  var totalAlokasi = ''.obs;
  var sisaAlokasi = ''.obs;
  var satuanVolume = '';
  var nilaiMuatan = '';
  var namaTruk = '';
  var lokasi = '';
  var statusErrorAlokasi = "".obs;
  var totalPesertaDipilih = 0.obs;
  var idrute = '';

  @override
  void onInit() async {
    idTender = Get.arguments[0];
    satuanTender = Get.arguments[1];
    satuanVolume = Get.arguments[2];
    nilaiMuatan = Get.arguments[3].toString();
    lokasi = Get.arguments[4];
    namaTruk = Get.arguments[5];
    listPemenang.value = Get.arguments[6];
    totalAlokasi.value = Get.arguments[7];
    idrute = Get.arguments[8];

    print(idTender);
    print(satuanTender);
    print(satuanVolume);
    print(nilaiMuatan);
    print(lokasi);
    print(namaTruk);
    print(listPemenang);

    isLoadingData.value = true;

    await getListPeserta(1);

    hitungPemenang();

    listPemenang.refresh();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void save() {
    Get.back();
  }

  Future getListPeserta(int page) async {
    String ID = "";
    ID = await SharedPreferencesHelper.getUserShipperID();
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchPilihPemenang(idrute, ID, '1000', page.toString(), "", "", "");

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      for (var x = 0; x < listPemenang.length; x++) {
        (data as List).forEach((element) {
          if (listPemenang[x]['id'] == element['TransporterID']) {
            listPemenang[x]['hargaPenawaran'] =
                ((element['HargaPenawaranRaw'] ?? "") == ""
                    ? '0'
                    : element['HargaPenawaranRaw']);
          }
        });
      }

      isLoadingData.value = false;
    }
  }

  void pilih(index) async {
    //KETIKA UBAH ALOKASI
    alokasiController.text = GlobalVariable.formatCurrencyDecimal(
        listPemenang[index]['alokasi'].toString());
    statusErrorAlokasi.value = "";

    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "ProsesTenderLihatPesertaLabelUbahJumlahAlokasi"
            .tr, //Ubah Jumlah Alokasi
        customMessage: Column(children: [
          Container(
              margin: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 13,
                  right: GlobalVariable.ratioWidth(Get.context) * 13),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 13,
                    ),
                    CustomText(
                        "ProsesTenderLihatPesertaLabelJumlahAlokasi"
                            .tr, //Jumlah Alokasi
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(ListColor.colorLightGrey4)),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 8,
                    ),
                    CustomTextFormField(
                      context: Get.context,
                      newContentPadding: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                        //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                      ),
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
                        DecimalInputFormatter(
                            digit: 13,
                            digitAfterComma: 3,
                            controller: alokasiController)
                      ],
                      textSize: 12,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorLightGrey4),
                      ),
                      newInputDecoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefix: SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 12),
                        suffix: SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 12),
                        suffixIconConstraints: BoxConstraints(minHeight: 0.0),
                        suffixIcon: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 12),
                          width: GlobalVariable.ratioWidth(Get.context) * 40,
                          child: CustomText(
                              (satuanTender == 2
                                  ? "Unit"
                                  : (satuanTender == 1
                                      ? "Ton"
                                      : satuanVolume.tr)),
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.right,
                              fontSize: 12),
                        ),
                        isDense: true,
                        isCollapsed: true,
                        hintText: "ProsesTenderLihatPesertaPlaceholderContoh99"
                            .tr, //Ex : 99
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey2),
                        ),
                      ),
                      controller: alokasiController,
                    ),
                    Obx(() => statusErrorAlokasi.value == "1"
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4),
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomText(
                                    "ProsesTenderLihatPesertaAlertBelumMenentukanAlokasi"
                                        .tr,
                                    overflow: TextOverflow.ellipsis,
                                    wrapSpace: true,
                                    maxLines: 2,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    height: 1.2,
                                    color: Color(ListColor.colorRed),
                                  )),
                                ],
                              ),
                            ],
                          )
                        : statusErrorAlokasi.value == "2"
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                              text: "ProsesTenderLihatPesertaAlertAlokasiMelebihiBatasMaksimal"
                                                      .tr +
                                                  " ", //Alokasi melebihi batas maksimal
                                              style: TextStyle(
                                                fontFamily: "AvenirNext",
                                                color:
                                                    Color(ListColor.colorRed),
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    12,
                                                height: 1.2,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              children: [
                                                TextSpan(
                                                    text: GlobalVariable
                                                        .formatCurrencyDecimal(
                                                            nilaiMuatan),
                                                    style: TextStyle(
                                                      fontFamily: "AvenirNext",
                                                      color: Color(
                                                          ListColor.colorRed),
                                                      fontSize: GlobalVariable
                                                              .ratioFontSize(
                                                                  Get.context) *
                                                          12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text: (satuanTender ==
                                                                  2
                                                              ? " Unit"
                                                              : satuanTender ==
                                                                      1
                                                                  ? " Ton"
                                                                  : satuanVolume
                                                                      .tr),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "AvenirNext",
                                                            color: Color(
                                                                ListColor
                                                                    .colorRed),
                                                            fontSize: GlobalVariable
                                                                    .ratioFontSize(
                                                                        Get.context) *
                                                                12,
                                                            height: 1.2,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          children: [])
                                                    ])
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox()),
                  ]))
        ]),
        labelButtonPriority1: "ProsesTenderEditStatusProsesTenderSimpan".tr,
        isDirectBack: false,
        onTapPriority1: () async {
          print(index);
          cekAlokasi(indexPemenang: index);
          if (statusErrorAlokasi.value == "") {
            //KETIKA BARU TAMBAH ALOKASI
            if (listPemenang
                    .where(
                        (element) => element['id'] == listPemenang[index]['id'])
                    .toList()
                    .length >
                0) {
              //KETIKA UBAH ALOKASI

              var alokasi;
              if (satuanTender == 2) {
                alokasi = int.parse(alokasiController.text == ""
                    ? "0"
                    : GlobalVariable.formatDoubleDecimal(
                        alokasiController.text));
              } else if (satuanTender == 1) {
                alokasi = double.parse(alokasiController.text == ""
                    ? "0.0"
                    : GlobalVariable.formatDoubleDecimal(
                        alokasiController.text));
              } else if (satuanTender == 3) {
                alokasi = double.parse(alokasiController.text == ""
                    ? "0.0"
                    : GlobalVariable.formatDoubleDecimal(
                        alokasiController.text));
              }

              listPemenang[index]['alokasi'] = alokasi.toString();
              print('aman');
            }
            hitungPemenang();
            Get.back();
            CustomToast.show(
                marginBottom: (GlobalVariable.ratioWidth(Get.context) * 26),
                context: Get.context,
                message:
                    "ProsesTenderLihatPesertaLabelBerhasilMengubahDataAlokasi"
                        .tr); //Berhasil mengubah data alokasi
          }
        });
  }

  void hapus(index) async {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "ProsesTenderLihatPesertaLabelKonfirmasiPenghapusan"
            .tr, //Konfirmasi Penghapusan
        message: "ProsesTenderLihatPesertaLabelApakahAndaYakinUntukMenghapusPilihanAnda"
                .tr +
            "\n" +
            "ProsesTenderLihatPesertaLabelDataYangTelahDihapusDapatDipilihKembali"
                .tr, //Apakah anda yakin ingin kembali? Data yang telah diisi tidak akan disimpan
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          listPemenang.removeAt(index);
          hitungPemenang();
          CustomToast.show(
              marginBottom: (GlobalVariable.ratioWidth(Get.context) * 26),
              context: Get.context,
              message:
                  "ProsesTenderLihatPesertaLabelBerhasilMenghapusPilihanPemenang"
                      .tr); //Berhasil menghapus pilihan pemenang
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }

  void hitungPemenang() {
    totalPesertaDipilih.value = listPemenang.length;
    sisaAlokasi.value = "0";
    var alokasi;

    if (satuanTender == 2) {
      alokasi = 0;
      for (var x = 0; x < listPemenang.length; x++) {
        alokasi += int.parse(listPemenang[x]['alokasi'].toString());
      }
      sisaAlokasi.value = (int.parse(totalAlokasi.value) - alokasi).toString();
    } else if (satuanTender == 1) {
      alokasi = 0.0;
      for (var x = 0; x < listPemenang.length; x++) {
        alokasi += double.parse(listPemenang[x]['alokasi'].toString());
      }
      sisaAlokasi.value =
          (double.parse(totalAlokasi.value) - alokasi).toString();
    } else if (satuanTender == 3) {
      alokasi = 0.0;
      for (var x = 0; x < listPemenang.length; x++) {
        alokasi += double.parse(listPemenang[x]['alokasi'].toString());
      }
      sisaAlokasi.value =
          (double.parse(totalAlokasi.value) - alokasi).toString();
    }

    if (listPemenang.length == 0) {
      Get.back();
    }
  }

  //indexPemenang = index yang dipilih, supaya nilainya tidak hitung sebagai kekurangan
  void cekAlokasi({int indexPemenang = -1}) {
    var sisa;
    if (alokasiController.text == "") {
      statusErrorAlokasi.value = "1"; //Belum menentukan alokasi
    } else if (satuanTender == 2) {
      var alokasi = int.parse(alokasiController.text == ""
          ? "0"
          : GlobalVariable.formatDoubleDecimal(alokasiController.text));
      sisa = int.parse(nilaiMuatan);
      print(indexPemenang);
      for (var x = 0; x < listPemenang.length; x++) {
        if (x != indexPemenang) {
          sisa -= int.parse(listPemenang[x]['alokasi'].toString());
        }
      }

      sisa -= alokasi;
    } else if (satuanTender == 1) {
      var alokasi = double.parse(alokasiController.text == ""
          ? "0.0"
          : GlobalVariable.formatDoubleDecimal(alokasiController.text));
      sisa = double.parse(nilaiMuatan);
      for (var x = 0; x < listPemenang.length; x++) {
        if (x != indexPemenang) {
          sisa -= double.parse(listPemenang[x]['alokasi'].toString());
        }
      }
      sisa -= alokasi;
    } else if (satuanTender == 3) {
      var alokasi = double.parse(alokasiController.text == ""
          ? "0.0"
          : GlobalVariable.formatDoubleDecimal(alokasiController.text));
      sisa = double.parse(nilaiMuatan);
      for (var x = 0; x < listPemenang.length; x++) {
        if (x != indexPemenang) {
          sisa -= double.parse(listPemenang[x]['alokasi'].toString());
        }
      }
      sisa -= alokasi;
    }

    if (alokasiController.text != "" && sisa < 0) {
      statusErrorAlokasi.value = "2"; //Alokasi melebihi batas maksimal
    } else if (alokasiController.text != "") {
      statusErrorAlokasi.value = "";
    }
  }
}
