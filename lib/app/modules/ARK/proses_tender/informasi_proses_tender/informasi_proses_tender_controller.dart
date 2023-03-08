import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:email_validator/email_validator.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class InformasiProsesTenderController extends GetxController {
  var validasiSimpan = false;
  var jenisInfo = "";
  var cekdaftarpeserta = false.obs;
  var cekdatarutedanhargapenawaran = false.obs;
  var cekdaftarpemenang = false.obs;
  var cekdataalokasipemenang = false.obs;
  var gambarAtas = "";
  var gambarBawah = "";
  var gambarPopup = "";

  @override
  void onInit() {
    super.onInit();
    cekdaftarpeserta = Get.arguments[0];
    cekdatarutedanhargapenawaran = Get.arguments[1];
    cekdaftarpemenang = Get.arguments[2];
    cekdataalokasipemenang = Get.arguments[3];
    jenisInfo = Get.arguments[4];
    print(cekdaftarpeserta.value);
    print(cekdatarutedanhargapenawaran.value);
    print(cekdaftarpemenang.value);
    print(cekdataalokasipemenang.value);
    print(jenisInfo);

    if (!cekdaftarpeserta.value &&
        cekdatarutedanhargapenawaran.value &&
        jenisInfo == 'PESERTA TENDER') {
      gambarAtas =
          GlobalVariable.imagePath + "harga penawaran peserta lainnya.png";
      gambarBawah = GlobalVariable.imagePath +
          "preview tertutup penawaran harga lainnya.jpg";
    } else if (cekdaftarpeserta.value &&
        cekdatarutedanhargapenawaran.value &&
        jenisInfo == 'PESERTA TENDER') {
      gambarAtas =
          GlobalVariable.imagePath + "daftar peserta tender tertutup.png";
      gambarBawah = GlobalVariable.imagePath +
          "preview daftar peserta tender tertutup.jpg";
    } else if (!cekdaftarpemenang.value &&
        cekdataalokasipemenang.value &&
        jenisInfo == 'PEMENANG TENDER') {
      gambarAtas =
          GlobalVariable.imagePath + "data alokasi pemenang tertutup.png";
      gambarBawah = GlobalVariable.imagePath +
          "preview data alokasi pemenang tertutup.jpg";
    } else if (cekdaftarpemenang.value &&
        cekdataalokasipemenang.value &&
        jenisInfo == 'PEMENANG TENDER') {
      gambarAtas = GlobalVariable.imagePath + "daftar pemenang tertutup.png";
      gambarBawah =
          GlobalVariable.imagePath + "preview data pemenang tertutup.jpg";
    }

    if (jenisInfo == 'PESERTA TENDER') {
      gambarPopup = GlobalVariable.imagePath + "detail lihat peserta.jpg";
    } else if (jenisInfo == 'PEMENANG TENDER') {
      gambarPopup = GlobalVariable.imagePath + "detail lihat pemenang.jpg";
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onSave() {}

  void lihat() {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
              child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 30),
                  child: Image.asset(gambarPopup)));
        });
  }

  Widget keterangan1HargaPenawaranPesertaWidget() {
    return RichText(
        text: TextSpan(
            text: "ProsesTenderCreateLabelOpsi".tr, //Opsi
            style: TextStyle(
              fontFamily: "AvenirNext",
              color: Color(ListColor.colorBlack1B),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            children: [
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDaftarPesertaTender".tr +
                  "\"", // Daftar Peserta
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelTidakDicentang".tr, // Tidak dicentang
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " " + "ProsesTenderCreateLabelDan".tr, //dan
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelHargaPenawaranPesertaLainnya" // Harga Penawaran Peserta Lainnya
                      .tr +
                  "\"",
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangAtauDipilih" // Dicentang/Dipilih
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: [])
        ]));
  }

  Widget keterangan1DaftarPesertadanHargaPenawaranPesertaWidget() {
    return RichText(
        text: TextSpan(
            text: "ProsesTenderCreateLabelOpsi".tr, //Opsi
            style: TextStyle(
              fontFamily: "AvenirNext",
              color: Color(ListColor.colorBlack1B),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            children: [
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDaftarPesertaTender".tr +
                  "\"", //Daftar Peserta Tender
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " + "ProsesTenderCreateLabelDan".tr, //dan
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelHargaPenawaranPesertaLainnya".tr +
                  "\"", //Harga Penawaran Peserta Lainnya
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangAtauDipilih"
                      .tr, //dicentang/dipilih
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
        ]));
  }

  Widget keterangan1DaftarPemenangdanDataAlokasiPemenangWidget() {
    return RichText(
        text: TextSpan(
            text: "ProsesTenderCreateLabelOpsi".tr, //Opsi
            style: TextStyle(
              fontFamily: "AvenirNext",
              color: Color(ListColor.colorBlack1B),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            children: [
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDaftarPemenang".tr +
                  "\"", //Daftar Pemenang
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " + "ProsesTenderCreateLabelDan".tr, //dan
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDataAlokasiPemenang".tr +
                  "\"", //Data Alokasi Pemenang
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangAtauDipilih"
                      .tr, //dicentang/dipilih
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
        ]));
  }

  Widget keterangan1DataAlokasiPemenangWidget() {
    return RichText(
        text: TextSpan(
            text: "ProsesTenderCreateLabelOpsi".tr, //Opsi
            style: TextStyle(
              fontFamily: "AvenirNext",
              color: Color(ListColor.colorBlack1B),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            children: [
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDaftarPemenang".tr +
                  "\"", //Daftar Pemenang
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelTidakDicentang".tr, //tidak dicentang
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " " + "ProsesTenderCreateLabelDan".tr, //dan
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDataAlokasiPemenang".tr +
                  "\"", //Data Alokasi Pemenang
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangAtauDipilih"
                      .tr, //dicentang/dipilih
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
        ]));
  }

  Widget keterangan2HargaPenawaranPesertaWidget() {
    return RichText(
        text: TextSpan(
            text: "ProsesTenderCreateLabelApabila".tr, //Apabila
            style: TextStyle(
              fontFamily: "AvenirNext",
              color: Color(ListColor.colorBlack1B),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            children: [
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelHargaPenawaranPesertaLainnya".tr +
                  "\"", // Harga Penawaran Peserta Lainnya
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangHargaPenawaran1"
                      .tr, // dicentang seperti pada gambar. Maka Transporter
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangHargaPenawaran2" // namun tidak dapat
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w700,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangHargaPenawaran3" // , melihat harga penawaran
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          WidgetSpan(
              child: GestureDetector(
                  onTap: () {
                    lihat();
                  },
                  child: CustomText(
                      "ProsesTenderDetailLabelLihatPeserta" // Lihat Peserta
                          .tr,
                      color: Color(ListColor.colorBlue),
                      fontSize: 14,
                      height: 1.4,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600)))
        ]));
  }

  Widget keterangan2DaftarPesertadanHargaPenawaranPesertaWidget() {
    return RichText(
        text: TextSpan(
            text: "ProsesTenderCreateLabelApabila".tr, //Apabila
            style: TextStyle(
              fontFamily: "AvenirNext",
              color: Color(ListColor.colorBlack1B),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            children: [
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDaftarPesertaTender".tr +
                  "\"", // Daftar Peserta Tender
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDaftarPesertaDanHargaPenawaran1"
                      .tr, // dicentang mak
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelHargaPenawaranPesertaLainnya".tr +
                  "\"", // Harga Penawaran Peserta Lainnya
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDaftarPesertaDanHargaPenawaran2" //akan otomatis tercentang seperti pada gambar.
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          WidgetSpan(
              child: GestureDetector(
                  onTap: () {
                    lihat();
                  },
                  child: CustomText(
                      "ProsesTenderDetailLabelLihatPeserta" // Lihat Peserta
                          .tr,
                      color: Color(ListColor.colorBlue),
                      fontSize: 14,
                      height: 1.4,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600))),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDaftarPesertaDanHargaPenawaran3" //maka informasi Daftar PEserta
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDaftarPesertaDanHargaPenawaran4" //tidak
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w700,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDaftarPesertaDanHargaPenawaran5" // dapat dilihat oleh Transporter tersebut
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
        ]));
  }

  Widget keterangan2DaftarPemenangdanDataAlokasiPemenangWidget() {
    return RichText(
        text: TextSpan(
            text: "ProsesTenderCreateLabelApabila".tr, //Apabila
            style: TextStyle(
              fontFamily: "AvenirNext",
              color: Color(ListColor.colorBlack1B),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            children: [
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDaftarPemenang".tr +
                  "\"", // Daftar Pemenang
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDaftarPemenangDanDataAlokasiPemenang1"
                      .tr, // dicentang maka
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDataAlokasiPemenang".tr +
                  "\"", // Data Alokasi Pemenang
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDaftarPemenangDanDataAlokasiPemenang2" //akan otomatis tercentang seperti pada gambar.
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          WidgetSpan(
              child: GestureDetector(
                  onTap: () {
                    lihat();
                  },
                  child: CustomText(
                      "ProsesTenderLihatPesertaButtonLihatPemenang" // Lihat Pemenang
                          .tr,
                      color: Color(ListColor.colorBlue),
                      fontSize: 14,
                      height: 1.4,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600))),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDaftarPemenangDanDataAlokasiPemenang3" //maka informasi daftar pemenang
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
        ]));
  }

  Widget keterangan2DataAlokasiPemenangWidget() {
    return RichText(
        text: TextSpan(
            text: "ProsesTenderCreateLabelApabila".tr, //Apabila
            style: TextStyle(
              fontFamily: "AvenirNext",
              color: Color(ListColor.colorBlack1B),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            children: [
          TextSpan(
              text: " \"" +
                  "ProsesTenderCreateLabelDataAlokasiPemenang".tr +
                  "\"", // Data Alokasi Pemenang
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlue),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDataAlokasiPemenang1"
                      .tr, // dicentang seperti pada gambar
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDataAlokasiPemenang2" //namun tidak dapat
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w700,
              ),
              children: []),
          TextSpan(
              text: " " +
                  "ProsesTenderCreateLabelDicentangDataAlokasiPemenang3" //melihat data alokasi pemenang
                      .tr,
              style: TextStyle(
                fontFamily: "AvenirNext",
                color: Color(ListColor.colorBlack1B),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
              children: []),
          WidgetSpan(
              child: GestureDetector(
                  onTap: () {
                    lihat();
                  },
                  child: CustomText(
                      "ProsesTenderLihatPesertaButtonLihatPemenang" // Lihat Pemenang
                          .tr,
                      color: Color(ListColor.colorBlue),
                      fontSize: 14,
                      height: 1.4,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w600))),
        ]));
  }
}
