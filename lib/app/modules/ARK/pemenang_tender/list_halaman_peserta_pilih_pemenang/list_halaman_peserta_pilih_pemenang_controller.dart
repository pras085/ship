import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang/list_pilih_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_pemenang/list_halaman_peserta_detail_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListHalamanPesertaPilihPemenangController extends GetxController {
  var validasiSimpan = false;
  var dataRuteTender = [].obs;
  var dataRuteTenderSebelumnya = [];
  var satuanTender = 0;
  var satuanVolume = '';
  var idTender = '';
  var noTender = '';
  var judulTender = '';
  var muatan = '';
  var totalKebutuhan = "".obs;
  var sisaKebutuhan = "".obs;
  var tipeListPeserta = "";
  var ambilLocal = false;
  var firstTime = true;
  var firstSet = true;
  var onLoading = false.obs;
  var save = true;
  var mode;
  var errorPemenangTerisiSemua = "".obs;
  var dataIDRute = [];

  @override
  void onInit() async {
    super.onInit();
    var dataRute = Get.arguments[0];
    satuanTender = Get.arguments[1];
    satuanVolume = Get.arguments[2];
    idTender = Get.arguments[3];
    noTender = Get.arguments[4];
    judulTender = Get.arguments[5];
    muatan = Get.arguments[6];
    totalKebutuhan.value = Get.arguments[7];
    tipeListPeserta = Get.arguments[8];
    mode = Get.arguments[9];
    print(mode);
    onLoading.value = true;
    await getDataPemenang(idTender);
    if (mode == 'UBAH') {
      await getDetailPemenang(dataRute);
    } else {
      var listTruk = [];
      for (var x = 0; x < dataRute.length; x++) {
        listTruk = [];
        for (var y = 0; y < dataRute[x]['data'].length; y++) {
          var idrute;
          //TAMBAHKAN RUTE ID
          for (var i = 0; i < dataIDRute.length; i++) {
            if (dataRute[x]['pickup'] == dataIDRute[i]['pickup'] &&
                dataRute[x]['destinasi'] == dataIDRute[i]['destinasi'] &&
                dataRute[x]['data'][y]['nama_truk'] == dataIDRute[i]['head'] &&
                dataRute[x]['data'][y]['nama_carrier'] ==
                    dataIDRute[i]['carrier']) {
              idrute = dataIDRute[i]['idrute'];
            }
          }

          var data_values = {
            'jenis_truk': dataRute[x]['data'][y]['jenis_truk'],
            'nama_truk': dataRute[x]['data'][y]['nama_truk'],
            'jenis_carrier': dataRute[x]['data'][y]['jenis_carrier'],
            'nama_carrier': dataRute[x]['data'][y]['nama_carrier'],
            'nilai': dataRute[x]['data'][y]['nilai'],
            'idrute': idrute.toString(),
            'error': '',
            'local': ambilLocal,
            'datapemenang': [],
            'statuspemenang':
                '0', //0 = BELUM ADA PEMENANG,  1 = ADA PEMENANG, 2 = TANPA PEMENANG
          };
          listTruk.add(data_values);
        }

        var dataHeader = {
          'pickup': dataRute[x]['pickup'],
          'destinasi': dataRute[x]['destinasi'],
          'data': listTruk,
        };

        dataRuteTender.add(dataHeader);
      }
    }

    onLoading.value = false;
    await setFirstTimeLocalRute();
    hitungTotalYangDigunakan();
  }

  Future getDataPemenang(String idTender) async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDataPemenang(idTender);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      for (var x = 0; x < data.length; x++) {
        for (var y = 0; y < data[x]['detail'].length; y++) {
          var data_values = {
            'pickup': data[x]['pickup'],
            'destinasi': data[x]['destinasi'],
            'head': data[x]['detail'][y]['head'],
            'carrier': data[x]['detail'][y]['carrier'],
            'idrute': data[x]['detail'][y]['ruteID'],
          };
          dataIDRute.add(data_values);
        }
      }
    }
  }

  Future getDetailPemenang(List dataRute) async {
    String ID = "";
    ID = await SharedPreferencesHelper.getUserShipperID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDetailPemenang(idTender, ID);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      var listTruk = [];
      for (var x = 0; x < dataRute.length; x++) {
        listTruk = [];
        for (var y = 0; y < dataRute[x]['data'].length; y++) {
          var statuspemenang = "0";
          var listPemenang = [];
          //DARI API
          for (var i = 0; i < data.length; i++) {
            for (var j = 0; j < data[i]['detail'].length; j++) {
              if (dataRute[x]['pickup'] == data[i]['pickup'] &&
                  dataRute[x]['destinasi'] == data[i]['destinasi'] &&
                  dataRute[x]['data'][y]['nama_truk'] ==
                      data[i]['detail'][j]['head'] &&
                  dataRute[x]['data'][y]['nama_carrier'] ==
                      data[i]['detail'][j]['carrier']) {
                if (data[i]['detail'][j]['tanpa_pemenang'] == 1) {
                  statuspemenang = "2";
                } else {
                  for (var k = 0;
                      k < data[i]['detail'][j]['detail'].length;
                      k++) {
                    statuspemenang = "1";
                    listPemenang.add({
                      'id': data[i]['detail'][j]['detail'][k]['TransporterID'],
                      'transporter': data[i]['detail'][j]['detail'][k]
                          ['nama_transporter'],
                      'kota': data[i]['detail'][j]['detail'][k]
                          ['kota_transporter'],
                      'hargaPenawaran': '0',
                      'alokasi': data[i]['detail'][j]['detail'][k]['alokasi'],
                    });
                  }
                }
              }
            }
          }

          var idrute;
          //TAMBAHKAN RUTE ID
          for (var i = 0; i < dataIDRute.length; i++) {
            if (dataRute[x]['pickup'] == dataIDRute[i]['pickup'] &&
                dataRute[x]['destinasi'] == dataIDRute[i]['destinasi'] &&
                dataRute[x]['data'][y]['nama_truk'] == dataIDRute[i]['head'] &&
                dataRute[x]['data'][y]['nama_carrier'] ==
                    dataIDRute[i]['carrier']) {
              idrute = dataIDRute[i]['idrute'];
            }
          }

          print('asd');
          var data_values = {
            'jenis_truk': dataRute[x]['data'][y]['jenis_truk'],
            'nama_truk': dataRute[x]['data'][y]['nama_truk'],
            'jenis_carrier': dataRute[x]['data'][y]['jenis_carrier'],
            'nama_carrier': dataRute[x]['data'][y]['nama_carrier'],
            'nilai': dataRute[x]['data'][y]['nilai'],
            'idrute': idrute.toString(),
            'error': '',
            'local': ambilLocal,
            'datapemenang': listPemenang,
            'statuspemenang':
                statuspemenang, //0 = BELUM ADA PEMENANG,  1 = ADA PEMENANG, 2 = TANPA PEMENANG
          };
          listTruk.add(data_values);
        }

        var dataHeader = {
          'pickup': dataRute[x]['pickup'],
          'destinasi': dataRute[x]['destinasi'],
          'data': listTruk,
        };

        dataRuteTender.add(dataHeader);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onSave() {
    var isValid = true;
    errorPemenangTerisiSemua.value = "";
    for (var x = 0; x < dataRuteTender.length; x++) {
      for (var y = 0; y < dataRuteTender[x]['data'].length; y++) {
        if (dataRuteTender[x]['data'][y]['datapemenang'].length == 0 &&
            dataRuteTender[x]['data'][y]['statuspemenang'] == "0") {
          isValid = false;
          errorPemenangTerisiSemua.value =
              'ProsesTenderLihatPesertaLabelAndaWajibMelengkapiSemuaPemenang'
                  .tr; // Anda wajib melengkapi semua pemenang
        }
      }
    }

    var dataRute = [];

    for (var x = 0; x < dataRuteTender.length; x++) {
      for (var y = 0; y < dataRuteTender[x]['data'].length; y++) {
        var arrayPemenang = [];
        for (var z = 0;
            z < dataRuteTender[x]['data'][y]['datapemenang'].length;
            z++) {
          var dataDetail = {
            'TransporterID': dataRuteTender[x]['data'][y]['datapemenang'][z]
                ['id'],
            'alokasi': dataRuteTender[x]['data'][y]['datapemenang'][z]
                ['alokasi'],
          };

          arrayPemenang.add(dataDetail);
        }

        var dataHeader = {
          "ruteID": dataRuteTender[x]['data'][y]['idrute'],
          "datapemenang": arrayPemenang,
          "statuspemenang": dataRuteTender[x]['data'][y]['statuspemenang'],
        };

        dataRute.add(dataHeader);
      }
    }
//SAVE nya tidak diberi karena takutnya di pop out di luar area
    if (isValid) {
      if (tipeListPeserta == "SEKARANG") {
        GlobalAlertDialog.showAlertDialogCustom(
            context: Get.context,
            title: "ProsesTenderLihatPesertaLabelKonfirmasiSimpan"
                .tr, //Konfirmasi Simpan
            message:
                "ProsesTenderLihatPesertaLabelInformasiPemenangTenderAkanDiumumkan"
                    .tr, //Apakah anda yakin untuk menyimpan data pemenang tender ?
            labelButtonPriority1: GlobalAlertDialog.yesLabelButton,
            onTapPriority1: () async {
              showDialog(
                  context: Get.context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  });
              var result = await ApiHelper(
                      context: Get.context,
                      isShowDialogLoading: false,
                      isShowDialogError: false)
                  .simpanPemenangTender(idTender, dataRute);

              if (result['Message']['Code'].toString() == '200') {
                removeDataLocalRute();

                Get.back();
                if (mode == "UBAH") {
                  Get.back(result: [dataRuteTender]);
                } else {
                  Get.back(result: true);
                  GetToPage.toNamed<ListHalamanPesertaDetailPemenangController>(
                      Routes.LIST_HALAMAN_PESERTA_DETAIL_PEMENANG,
                      arguments: [
                        dataRuteTender,
                        satuanTender,
                        satuanVolume,
                        idTender,
                        noTender,
                        judulTender,
                        muatan,
                        totalKebutuhan.value,
                        tipeListPeserta,
                      ]);
                }

                CustomToast.show(
                    marginBottom: (GlobalVariable.ratioWidth(Get.context) * 44),
                    context: Get.context,
                    message:
                        "ProsesTenderLihatPesertaLabelBerhasilMenyimpanDanMengumumkan"
                            .tr);
              } else {
                Get.back();
              }
            },
            onTapPriority2: () async {
              //Berhasil menyimpan dan mengumumkan data pemenang tender
            },
            labelButtonPriority2: GlobalAlertDialog.noLabelButton);
      } else if (tipeListPeserta == "SEBELUM") {
        GlobalAlertDialog.showAlertDialogCustom(
            context: Get.context,
            title: "ProsesTenderLihatPesertaLabelKonfirmasiSimpan"
                .tr, //Konfirmasi Simpan
            message:
                "ProsesTenderLihatPesertaLabelInformasiPemenangTenderAkanDiumumkanSecaraOtomatis"
                    .tr, //Apakah anda yakin untuk menyimpan data pemenang tender ?
            labelButtonPriority1: GlobalAlertDialog.yesLabelButton,
            onTapPriority1: () async {
              showDialog(
                  context: Get.context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  });

              var result = await ApiHelper(
                      context: Get.context,
                      isShowDialogLoading: false,
                      isShowDialogError: false)
                  .simpanPemenangTender(idTender, dataRute);

              if (result['Message']['Code'].toString() == '200') {
                removeDataLocalRute();

                Get.back();
                if (mode == "UBAH") {
                  Get.back(result: [dataRuteTender]);
                } else {
                  Get.back(result: true);
                  GetToPage.toNamed<ListHalamanPesertaDetailPemenangController>(
                      Routes.LIST_HALAMAN_PESERTA_DETAIL_PEMENANG,
                      arguments: [
                        dataRuteTender,
                        satuanTender,
                        satuanVolume,
                        idTender,
                        noTender,
                        judulTender,
                        muatan,
                        totalKebutuhan.value,
                        tipeListPeserta,
                      ]);
                }

                CustomToast.show(
                    marginBottom: (GlobalVariable.ratioWidth(Get.context) * 64),
                    context: Get.context,
                    message:
                        "ProsesTenderLihatPesertaLabelBerhasilMenyimpanDataPemenangTender"
                            .tr); //Berhasil menyimpan data pemenang tender. Data yang Anda simpan masih
              } else {
                Get.back();
              }
            },
            onTapPriority2: () async {},
            labelButtonPriority2: GlobalAlertDialog.noLabelButton);
      }
    }
  }

  void setFirstTimeLocalRute() async {
    var dataRuteLocal = await getDataLocalRute();

    if (dataRuteLocal.length > 0) {
      //JIKA DIA BARU MASUK DAN MASIH ADA DATANYA, MUNCUL DIALOG
      if (firstTime) {
        GlobalAlertDialog.showAlertDialogCustom(
            context: Get.context,
            title: "ProsesTenderLihatPesertaLabelKonfirmasiPenyimpanan"
                .tr, //Konfirmasi Penyimpanan
            customMessage: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "ProsesTenderLihatPesertaLabelDataPilihPemenangSebelumnya" //Data pilih pemenang sebelumnya
                              .tr +
                          "\n" +
                          "ProsesTenderLihatPesertaLabelJikaAndaInginMenghapusPilihanAnda".tr +
                          " ", //Jika anda ingin menghapus pilihan sebelumnya, // Menampilkan hasil untuk
                      style: TextStyle(
                        fontFamily: "AvenirNext",
                        color: Color(ListColor.colorBlack1B),
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: "ProsesTenderLihatPesertaButtonReset".tr,
                            style: TextStyle(
                              fontFamily: "AvenirNext",
                              color: Color(ListColor.colorBlack1B),
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w700,
                            ),
                            children: [])
                      ]),
                )
              ],
            ), //Jika anda ingin menghapus pilihan sebelumnya
            labelButtonPriority1: "ProsesTenderLihatPesertaButtonLanjut".tr,
            onTapPriority1: () {
              ambilLocal = true;
              dataRuteTender.value = dataRuteLocal[0]['datarutetender'];
              print('AMBIL DARI LOKAL');
              firstTime = false;
              hitungTotalYangDigunakan(gantiLocal: ambilLocal);
            },
            onTapPriority2: () async {
              firstTime = false;
              await removeDataLocalRute();
              hitungTotalYangDigunakan(gantiLocal: ambilLocal);
            },
            labelButtonPriority2: "ProsesTenderLihatPesertaButtonReset".tr);
      }
    } else {
      firstTime = false;
    }

    if (firstSet) {
      dataRuteTenderSebelumnya = json.decode(json.encode(dataRuteTender.value));
      firstSet = false;
    }
  }

  void hitungTotalYangDigunakan({bool gantiLocal = false}) async {
    sisaKebutuhan.value = totalKebutuhan.value;

    if (satuanTender == 2) {
      for (var x = 0; x < dataRuteTender.length; x++) {
        for (var y = 0; y < dataRuteTender[x]['data'].length; y++) {
          if (gantiLocal) {
            dataRuteTender[x]['data'][y]['local'] = ambilLocal;
          }

          for (var z = 0;
              z < dataRuteTender[x]['data'][y]['datapemenang'].length;
              z++) {
            sisaKebutuhan.value =
                (double.parse(sisaKebutuhan.value.toString()) -
                        double.parse(dataRuteTender[x]['data'][y]
                                ['datapemenang'][z]['alokasi']
                            .toString()))
                    .toString();
          }
        }
      }
    } else if (satuanTender == 1) {
      for (var x = 0; x < dataRuteTender.length; x++) {
        if (gantiLocal) {
          dataRuteTender[x]['data'][0]['local'] = ambilLocal;
        }

        for (var z = 0;
            z < dataRuteTender[x]['data'][0]['datapemenang'].length;
            z++) {
          sisaKebutuhan.value = (double.parse(sisaKebutuhan.value.toString()) -
                  double.parse(dataRuteTender[x]['data'][0]['datapemenang'][z]
                          ['alokasi']
                      .toString()))
              .toString();
          print('Kebutuhan : ');
          print(double.parse(dataRuteTender[x]['data'][0]['datapemenang'][z]
                  ['alokasi']
              .toString()));
        }
      }
    } else if (satuanTender == 3) {
      for (var x = 0; x < dataRuteTender.length; x++) {
        if (gantiLocal) {
          dataRuteTender[x]['data'][0]['local'] = ambilLocal;
        }

        for (var z = 0;
            z < dataRuteTender[x]['data'][0]['datapemenang'].length;
            z++) {
          sisaKebutuhan.value = (double.parse(sisaKebutuhan.value.toString()) -
                  double.parse(dataRuteTender[x]['data'][0]['datapemenang'][z]
                          ['alokasi']
                      .toString()))
              .toString();
        }
      }
    }
    dataRuteTender.refresh();
  }

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
                          index == dataRuteTender.length - 1 &&
                                  errorPemenangTerisiSemua.value != ""
                              ? 0
                              : GlobalVariable.ratioWidth(Get.context) * 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: GlobalVariable.ratioWidth(Get.context) * 1,
                            color: Color(ListColor.colorLightGrey10)),
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
                                  GlobalVariable.ratioWidth(Get.context) * 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        "ProsesTenderLihatPesertaLabelRute".tr +
                                            " " +
                                            (index + 1).toString().tr, // Rute
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(ListColor.colorBlack1B)),
                                    dataRuteTender[index]['data'].length !=
                                            dataRuteTender[index]['data']
                                                .where((element) =>
                                                    element['statuspemenang'] ==
                                                    "2")
                                                .toList()
                                                .length
                                        ? GestureDetector(
                                            onTap: () {
                                              putuskanSemuaRuteTanpaPemenang(
                                                  index);
                                            },
                                            child: CustomText(
                                                "ProsesTenderLihatPesertaLabelPutuskanRuteTanpaPemenang"
                                                    .tr, // Putuskan Rute Tanpa Pemenang
                                                //"ProsesTenderLihatPesertaLabelBatalkanRuteTanpaPemenang".tr, // Batalkan Rute Tanpa Pemenang
                                                color:
                                                    Color(ListColor.colorBlue),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600))
                                        : GestureDetector(
                                            onTap: () {
                                              batalkanSemuaKeputusan(index);
                                            },
                                            child: CustomText(
                                                "ProsesTenderLihatPesertaLabelBatalkanRuteTanpaPemenang"
                                                    .tr, // Batalkan Rute Tanpa Pemenang
                                                color:
                                                    Color(ListColor.colorRed),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600))
                                  ])),
                          Container(
                            // KARENA ADA HEIGHTNYA
                            width: MediaQuery.of(Get.context).size.width,
                            height: GlobalVariable.ratioWidth(Get.context) * 2,
                            color: Color(ListColor.colorLightGrey10),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 88,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
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
                                margin: EdgeInsets.only(
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      16,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          14,
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          14,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            Color(ListColor.colorLightGrey10)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                child: Column(children: [
                                  Container(
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
                                                  8),
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
                                                fontWeight: FontWeight.w600,
                                                maxLines: 2,
                                                wrapSpace: true,
                                                color: Color(
                                                    ListColor.colorBlack1B)))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16),
                                  Container(
                                    padding: EdgeInsets.only(
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
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                        bottom: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14), // KARENA ADA HEIGHTNYA
                                    width:
                                        MediaQuery.of(Get.context).size.width,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            0.5,
                                    color: Color(ListColor.colorLightGrey2),
                                  ),
                                  for (var indexPemenang = 0;
                                      indexPemenang <
                                          dataRuteTender[index]['data']
                                                  [indexDetail]['datapemenang']
                                              .length;
                                      indexPemenang++)
                                    Column(children: [
                                      Container(
                                        padding: EdgeInsets.only(
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
                                                  top: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      3,
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          7),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'pemenang_blue.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  color: Color(
                                                      ListColor.colorBlue)),
                                            ),
                                            Expanded(
                                                child: CustomText(
                                                    dataRuteTender[index]['data']
                                                                        [indexDetail]
                                                                    ['datapemenang']
                                                                [indexPemenang]
                                                            ['transporter'] +
                                                        ' (' +
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [indexDetail]
                                                                ['datapemenang']
                                                            [
                                                            indexPemenang]['kota'] +
                                                        ')',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    overflow: TextOverflow.ellipsis,
                                                    height: 1.2,
                                                    maxLines: 2,
                                                    wrapSpace: true,
                                                    color: Colors.black))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
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
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          1,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          7),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'muatan.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  color: Color(
                                                      ListColor.colorBlue)),
                                            ),
                                            CustomText(
                                                GlobalVariable.formatCurrencyDecimal(
                                                        dataRuteTender[index][
                                                                            'data']
                                                                        [
                                                                        indexDetail]
                                                                    [
                                                                    'datapemenang']
                                                                [
                                                                indexPemenang]['alokasi']
                                                            .toString()) +
                                                    " Unit",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)
                                          ],
                                        ),
                                      ),
                                      indexPemenang !=
                                              dataRuteTender[index]['data']
                                                              [indexDetail]
                                                          ['datapemenang']
                                                      .length -
                                                  1
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  top: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      14,
                                                  bottom: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      14), // KARENA ADA HEIGHTNYA
                                              width: MediaQuery.of(Get.context)
                                                  .size
                                                  .width,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  0.5,
                                              color: Color(
                                                  ListColor.colorLightGrey2),
                                            )
                                          : SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14),
                                    ]),
                                  Obx(
                                      () =>
                                          dataRuteTender[index]['data'][indexDetail]
                                                      ['statuspemenang'] ==
                                                  "0"
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.only(
                                                          bottomLeft: Radius.circular(
                                                              10),
                                                          bottomRight: Radius.circular(
                                                              10))),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          CustomText(""),
                                                        ],
                                                      )),
                                                      Material(
                                                        borderRadius: BorderRadius
                                                            .circular(GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20),
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          18),
                                                            ),
                                                            onTap: () async {
                                                              pilihPemenang(
                                                                  index,
                                                                  indexDetail);
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            24,
                                                                    vertical:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            6),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Color(ListColor
                                                                            .colorBlue)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                            20)),
                                                                child: Center(
                                                                  child: CustomText(
                                                                      'ProsesTenderLihatPesertaButtonPilihPemenang'
                                                                          .tr, //'Pilih Pemenang'.tr,
                                                                      fontSize:
                                                                          12,
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlue),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ))),
                                                      )
                                                    ],
                                                  ))
                                              : dataRuteTender[index]['data']
                                                              [indexDetail]
                                                          ['statuspemenang'] ==
                                                      "1"
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                                              bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          dataRuteTender[index]
                                                                          ['data']
                                                                      [indexDetail]
                                                                  ['local']
                                                              ? Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              4,
                                                                      horizontal:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              8),
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBackgroundLabelBelumDitentukanPemenang),
                                                                      borderRadius:
                                                                          BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6)),
                                                                  child: CustomText("ProsesTenderLihatPesertaLabelDraft".tr, // Draft
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.w600,
                                                                      color: Color(ListColor.colorLabelBelumDitentukanPemenang)))
                                                              : SizedBox(),
                                                          Expanded(
                                                              child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              CustomText(""),
                                                            ],
                                                          )),
                                                          Material(
                                                            borderRadius: BorderRadius
                                                                .circular(GlobalVariable
                                                                        .ratioWidth(
                                                                            Get.context) *
                                                                    20),
                                                            color: Colors
                                                                .transparent,
                                                            child: InkWell(
                                                                customBorder:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              18),
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  pilihPemenang(
                                                                      index, 0);
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: GlobalVariable.ratioWidth(Get.context) *
                                                                                24,
                                                                            vertical: GlobalVariable.ratioWidth(Get.context) *
                                                                                6),
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Color(ListColor.colorBlue)),
                                                                            borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                                                                        child: Center(
                                                                          child: CustomText(
                                                                              'ProsesTenderLihatPesertaLabelUbahPemenang'.tr, //'Ubah Pemenang'.tr,
                                                                              fontSize: 12,
                                                                              color: Color(ListColor.colorBlue),
                                                                              fontWeight: FontWeight.w600),
                                                                        ))),
                                                          )
                                                        ],
                                                      ))
                                                  : dataRuteTender[index]['data'][indexDetail]['statuspemenang'] == "2"
                                                      ? Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Column(
                                                            children: [
                                                              CustomText(
                                                                "ProsesTenderLihatPesertaLabelDiputuskanTanpaPemenang"
                                                                    .tr, // Diputuskan Tanpa Pemenang
                                                                color: Color(
                                                                    ListColor
                                                                        .colorRed),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              dataRuteTender[index]
                                                                              [
                                                                              'data']
                                                                          .length >
                                                                      1
                                                                  ? //JIKA LEBIH DARI 1 DATA MAKA BARU TEXT BATALKAN KEPUTUSAN PER RUTE
                                                                  SizedBox(
                                                                      height:
                                                                          GlobalVariable.ratioWidth(Get.context) *
                                                                              12,
                                                                    )
                                                                  : SizedBox(),
                                                              dataRuteTender[index]
                                                                              [
                                                                              'data']
                                                                          .length >
                                                                      1
                                                                  ? //JIKA LEBIH DARI 1 DATA MAKA BARU TEXT BATALKAN KEPUTUSAN PER RUTE
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        batalkanKeputusan(
                                                                            index,
                                                                            indexDetail);
                                                                      },
                                                                      child:
                                                                          CustomText(
                                                                        "ProsesTenderLihatPesertaLabelBatalkanKeputusan"
                                                                            .tr, //Batalkan Keputusan
                                                                        color: Color(
                                                                            ListColor.colorBlue),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        decoration:
                                                                            TextDecoration.underline,
                                                                      ))
                                                                  : SizedBox()
                                                            ],
                                                          ) // Diputuskan Tanpa Pemenang
                                                          ,
                                                        )
                                                      : SizedBox())
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
                          index == dataRuteTender.length - 1 &&
                                  errorPemenangTerisiSemua.value != ""
                              ? 0
                              : GlobalVariable.ratioWidth(Get.context) * 14),
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, GlobalVariable.ratioWidth(Get.context) * 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: GlobalVariable.ratioWidth(Get.context) * 1,
                            color: Color(ListColor.colorLightGrey10)),
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
                                  GlobalVariable.ratioWidth(Get.context) * 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        "ProsesTenderLihatPesertaLabelRute".tr +
                                            " " +
                                            (index + 1).toString().tr, // Rute
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(ListColor.colorBlack1B)),
                                    dataRuteTender[index]['data'].length !=
                                            dataRuteTender[index]['data']
                                                .where((element) =>
                                                    element['statuspemenang'] ==
                                                    "2")
                                                .toList()
                                                .length
                                        ? GestureDetector(
                                            onTap: () {
                                              putuskanSemuaRuteTanpaPemenang(
                                                  index);
                                            },
                                            child: CustomText(
                                                "ProsesTenderLihatPesertaLabelPutuskanRuteTanpaPemenang"
                                                    .tr, // Putuskan Rute Tanpa Pemenang
                                                //"ProsesTenderLihatPesertaLabelBatalkanRuteTanpaPemenang".tr, // Batalkan Rute Tanpa Pemenang
                                                color:
                                                    Color(ListColor.colorBlue),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600))
                                        : GestureDetector(
                                            onTap: () {
                                              batalkanSemuaKeputusan(index);
                                            },
                                            child: CustomText(
                                                "ProsesTenderLihatPesertaLabelBatalkanRuteTanpaPemenang"
                                                    .tr, // Batalkan Rute Tanpa Pemenang
                                                color:
                                                    Color(ListColor.colorRed),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600))
                                  ])),
                          Container(
                            // KARENA ADA HEIGHTNYA
                            width: MediaQuery.of(Get.context).size.width,
                            height: GlobalVariable.ratioWidth(Get.context) * 2,
                            color: Color(ListColor.colorLightGrey10),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 16,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              left: GlobalVariable.ratioWidth(Get.context) * 16,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
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
                          Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 14,
                                right: GlobalVariable.ratioWidth(Get.context) *
                                    14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          3,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath + 'muatan.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      color: Color(ListColor.colorBlue)),
                                ),
                                CustomText(
                                    GlobalVariable.formatCurrencyDecimal(
                                            dataRuteTender[index]['data'][0]
                                                    ['nilai']
                                                .toString()) +
                                        " Ton",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 14,
                                bottom: GlobalVariable.ratioWidth(Get.context) *
                                    14), // KARENA ADA HEIGHTNYA
                            width: MediaQuery.of(Get.context).size.width,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 0.5,
                            color: Color(ListColor.colorLightGrey2),
                          ),
                          for (var indexPemenang = 0;
                              indexPemenang <
                                  dataRuteTender[index]['data'][0]
                                          ['datapemenang']
                                      .length;
                              indexPemenang++)
                            Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          14,
                                ),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(
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
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  3,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'pemenang_blue.svg',
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
                                                dataRuteTender[index]['data'][0]
                                                                ['datapemenang']
                                                            [indexPemenang]
                                                        ['transporter'] +
                                                    ' (' +
                                                    dataRuteTender[index]
                                                                    ['data'][0]
                                                                ['datapemenang']
                                                            [indexPemenang]
                                                        ['kota'] +
                                                    ')',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                                height: 1.2,
                                                maxLines: 2,
                                                wrapSpace: true,
                                                color: Colors.black))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
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
                                                  3,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
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
                                            GlobalVariable.formatCurrencyDecimal(
                                                    dataRuteTender[index]['data']
                                                                        [0][
                                                                    'datapemenang']
                                                                [indexPemenang]
                                                            ['alokasi']
                                                        .toString()) +
                                                " Ton",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  indexPemenang !=
                                          dataRuteTender[index]['data'][0]
                                                      ['datapemenang']
                                                  .length -
                                              1
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              bottom: GlobalVariable
                                                      .ratioWidth(
                                                          Get.context) *
                                                  14), // KARENA ADA HEIGHTNYA
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
                                              14),
                                ])),
                          Obx(() => dataRuteTender[index]['data'][0]
                                      ['statuspemenang'] ==
                                  "0"
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14,
                                  ),
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
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20),
                                        color: Colors.transparent,
                                        child: InkWell(
                                            customBorder:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                            ),
                                            onTap: () async {
                                              pilihPemenang(index, 0);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            24,
                                                    vertical: GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        6),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(ListColor
                                                            .colorBlue)),
                                                    borderRadius: BorderRadius.circular(
                                                        GlobalVariable.ratioWidth(Get.context) * 20)),
                                                child: Center(
                                                  child: CustomText(
                                                      'ProsesTenderLihatPesertaButtonPilihPemenang'
                                                          .tr, //'Pilih Pemenang'.tr,
                                                      fontSize: 12,
                                                      color: Color(
                                                          ListColor.colorBlue),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))),
                                      )
                                    ],
                                  ))
                              : dataRuteTender[index]['data'][0]
                                          ['statuspemenang'] ==
                                      "1"
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                              bottomRight:
                                                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          dataRuteTender[index]['data'][0]
                                                  ['local']
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              4,
                                                      horizontal:
                                                          GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              8),
                                                  decoration: BoxDecoration(
                                                      color: Color(ListColor
                                                          .colorBackgroundLabelBelumDitentukanPemenang),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              GlobalVariable.ratioWidth(Get.context) * 6)),
                                                  child: CustomText("ProsesTenderLihatPesertaLabelDraft".tr, // Draft
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(ListColor.colorLabelBelumDitentukanPemenang)))
                                              : SizedBox(),
                                          Expanded(
                                              child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomText(""),
                                            ],
                                          )),
                                          Material(
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20),
                                            color: Colors.transparent,
                                            child: InkWell(
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          18),
                                                ),
                                                onTap: () async {
                                                  pilihPemenang(index, 0);
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            24,
                                                        vertical: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            6),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(ListColor
                                                                .colorBlue)),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                GlobalVariable.ratioWidth(Get.context) * 20)),
                                                    child: Center(
                                                      child: CustomText(
                                                          'ProsesTenderLihatPesertaLabelUbahPemenang'
                                                              .tr, //'Ubah Pemenang'.tr,
                                                          fontSize: 12,
                                                          color: Color(ListColor
                                                              .colorBlue),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))),
                                          )
                                        ],
                                      ))
                                  : dataRuteTender[index]['data'][0]
                                              ['statuspemenang'] ==
                                          "2"
                                      ? Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    14,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                                  bottomRight:
                                                      Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                          child: Column(
                                            children: [
                                              CustomText(
                                                "ProsesTenderLihatPesertaLabelDiputuskanTanpaPemenang"
                                                    .tr, // Diputuskan Tanpa Pemenang
                                                color:
                                                    Color(ListColor.colorRed),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ) // Diputuskan Tanpa Pemenang
                                          ,
                                        )
                                      : SizedBox()),
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
                          index == dataRuteTender.length - 1 &&
                                  errorPemenangTerisiSemua.value != ""
                              ? 0
                              : GlobalVariable.ratioWidth(Get.context) * 14),
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, GlobalVariable.ratioWidth(Get.context) * 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: GlobalVariable.ratioWidth(Get.context) * 1,
                            color: Color(ListColor.colorLightGrey10)),
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
                                  GlobalVariable.ratioWidth(Get.context) * 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        "ProsesTenderLihatPesertaLabelRute".tr +
                                            " " +
                                            (index + 1).toString().tr, // Rute
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(ListColor.colorBlack1B)),
                                    dataRuteTender[index]['data'].length !=
                                            dataRuteTender[index]['data']
                                                .where((element) =>
                                                    element['statuspemenang'] ==
                                                    "2")
                                                .toList()
                                                .length
                                        ? GestureDetector(
                                            onTap: () {
                                              putuskanSemuaRuteTanpaPemenang(
                                                  index);
                                            },
                                            child: CustomText(
                                                "ProsesTenderLihatPesertaLabelPutuskanRuteTanpaPemenang"
                                                    .tr, // Putuskan Rute Tanpa Pemenang
                                                //"ProsesTenderLihatPesertaLabelBatalkanRuteTanpaPemenang".tr, // Batalkan Rute Tanpa Pemenang
                                                color:
                                                    Color(ListColor.colorBlue),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600))
                                        : GestureDetector(
                                            onTap: () {
                                              batalkanSemuaKeputusan(index);
                                            },
                                            child: CustomText(
                                                "ProsesTenderLihatPesertaLabelBatalkanRuteTanpaPemenang"
                                                    .tr, // Batalkan Rute Tanpa Pemenang
                                                color:
                                                    Color(ListColor.colorRed),
                                                fontSize: 14,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600))
                                  ])),
                          Container(
                            // KARENA ADA HEIGHTNYA
                            width: MediaQuery.of(Get.context).size.width,
                            height: GlobalVariable.ratioWidth(Get.context) * 2,
                            color: Color(ListColor.colorLightGrey10),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 16,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              left: GlobalVariable.ratioWidth(Get.context) * 16,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
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
                          Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 14,
                                right: GlobalVariable.ratioWidth(Get.context) *
                                    14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          3,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath + 'muatan.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      color: Color(ListColor.colorBlue)),
                                ),
                                CustomText(
                                    GlobalVariable.formatCurrencyDecimal(
                                            dataRuteTender[index]['data'][0]
                                                    ['nilai']
                                                .toString()) +
                                        " " +
                                        satuanVolume,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 14,
                                bottom: GlobalVariable.ratioWidth(Get.context) *
                                    14), // KARENA ADA HEIGHTNYA
                            width: MediaQuery.of(Get.context).size.width,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 0.5,
                            color: Color(ListColor.colorLightGrey2),
                          ),
                          for (var indexPemenang = 0;
                              indexPemenang <
                                  dataRuteTender[index]['data'][0]
                                          ['datapemenang']
                                      .length;
                              indexPemenang++)
                            Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          14,
                                ),
                                child: Column(children: [
                                  Container(
                                    padding: EdgeInsets.only(
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
                                              left: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  3,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'pemenang_blue.svg',
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
                                                dataRuteTender[index]['data'][0]
                                                                ['datapemenang']
                                                            [indexPemenang]
                                                        ['transporter'] +
                                                    ' (' +
                                                    dataRuteTender[index]
                                                                    ['data'][0]
                                                                ['datapemenang']
                                                            [indexPemenang]
                                                        ['kota'] +
                                                    ')',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                                height: 1.2,
                                                maxLines: 2,
                                                wrapSpace: true,
                                                color: Colors.black))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
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
                                                  3,
                                              right: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
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
                                            GlobalVariable.formatCurrencyDecimal(
                                                    dataRuteTender[index]['data']
                                                                        [0][
                                                                    'datapemenang']
                                                                [indexPemenang]
                                                            ['alokasi']
                                                        .toString()) +
                                                " " +
                                                satuanVolume,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)
                                      ],
                                    ),
                                  ),
                                  indexPemenang !=
                                          dataRuteTender[index]['data'][0]
                                                      ['datapemenang']
                                                  .length -
                                              1
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  14,
                                              bottom: GlobalVariable
                                                      .ratioWidth(
                                                          Get.context) *
                                                  14), // KARENA ADA HEIGHTNYA
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
                                              14),
                                ])),
                          Obx(() => dataRuteTender[index]['data'][0]
                                      ['statuspemenang'] ==
                                  "0"
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14,
                                  ),
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
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20),
                                        color: Colors.transparent,
                                        child: InkWell(
                                            customBorder:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                            ),
                                            onTap: () async {
                                              pilihPemenang(index, 0);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            24,
                                                    vertical: GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        6),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(ListColor
                                                            .colorBlue)),
                                                    borderRadius: BorderRadius.circular(
                                                        GlobalVariable.ratioWidth(Get.context) * 20)),
                                                child: Center(
                                                  child: CustomText(
                                                      'ProsesTenderLihatPesertaButtonPilihPemenang'
                                                          .tr, //'Pilih Pemenang'.tr,
                                                      fontSize: 12,
                                                      color: Color(
                                                          ListColor.colorBlue),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))),
                                      )
                                    ],
                                  ))
                              : dataRuteTender[index]['data'][0]
                                          ['statuspemenang'] ==
                                      "1"
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                              bottomRight:
                                                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          dataRuteTender[index]['data'][0]
                                                  ['local']
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              4,
                                                      horizontal:
                                                          GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              8),
                                                  decoration: BoxDecoration(
                                                      color: Color(ListColor
                                                          .colorBackgroundLabelBelumDitentukanPemenang),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              GlobalVariable.ratioWidth(Get.context) * 6)),
                                                  child: CustomText("ProsesTenderLihatPesertaLabelDraft".tr, // Draft
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(ListColor.colorLabelBelumDitentukanPemenang)))
                                              : SizedBox(),
                                          Expanded(
                                              child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomText(""),
                                            ],
                                          )),
                                          Material(
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20),
                                            color: Colors.transparent,
                                            child: InkWell(
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          18),
                                                ),
                                                onTap: () async {
                                                  pilihPemenang(index, 0);
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            24,
                                                        vertical: GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            6),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(ListColor
                                                                .colorBlue)),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                GlobalVariable.ratioWidth(Get.context) * 20)),
                                                    child: Center(
                                                      child: CustomText(
                                                          'ProsesTenderLihatPesertaLabelUbahPemenang'
                                                              .tr, //'Ubah Pemenang'.tr,
                                                          fontSize: 12,
                                                          color: Color(ListColor
                                                              .colorBlue),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))),
                                          )
                                        ],
                                      ))
                                  : dataRuteTender[index]['data'][0]
                                              ['statuspemenang'] ==
                                          "2"
                                      ? Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    14,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                                  bottomRight:
                                                      Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                          child: Column(
                                            children: [
                                              CustomText(
                                                "ProsesTenderLihatPesertaLabelDiputuskanTanpaPemenang"
                                                    .tr, // Diputuskan Tanpa Pemenang
                                                color:
                                                    Color(ListColor.colorRed),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ) // Diputuskan Tanpa Pemenang
                                          ,
                                        )
                                      : SizedBox()),
                        ],
                      )),
                )
              ])
        : SizedBox());
  }

  void putuskanSemuaRuteTanpaPemenang(index) async {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "ProsesTenderLihatPesertaLabelKonfirmasiTanpaPemenang"
            .tr, //Konfirmasi Tanpa Pemenang
        message: "ProsesTenderLihatPesertaLabelMenentukanTanpaPemenang"
            .tr, //Apakah Anda yakin ingin menentukan tanpa pemenang?
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          for (var x = 0; x < dataRuteTender[index]['data'].length; x++) {
            dataRuteTender[index]['data'][x]['statuspemenang'] = '2';
            dataRuteTender[index]['data'][x]['datapemenang'] = [];
          }
          dataRuteTender.refresh();

          await setDataLocalRute();
          hitungTotalYangDigunakan();
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }

  void batalkanKeputusan(index, indexDetail) async {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "ProsesTenderLihatPesertaLabelKonfirmasiTanpaPemenang"
            .tr, //Konfirmasi Tanpa Pemenang
        message:
            "ProsesTenderLihatPesertaLabelMembatalkanKeputusanTanpaPemenang"
                .tr, //Apakah Anda yakin ingin membatalkan keputusan ?
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          dataRuteTender[index]['data'][indexDetail]['statuspemenang'] = '0';
          dataRuteTender.refresh();

          await setDataLocalRute();
          hitungTotalYangDigunakan();
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }

  void batalkanSemuaKeputusan(index) async {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "ProsesTenderLihatPesertaLabelKonfirmasiTanpaPemenang"
            .tr, //Konfirmasi Tanpa Pemenang
        message:
            "ProsesTenderLihatPesertaLabelMembatalkanKeputusanTanpaPemenang"
                .tr, //Apakah Anda yakin ingin membatalkan keputusan ?
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () {},
        onTapPriority2: () async {
          for (var x = 0; x < dataRuteTender[index]['data'].length; x++) {
            dataRuteTender[index]['data'][x]['statuspemenang'] = '0';
          }
          dataRuteTender.refresh();

          await setDataLocalRute();
          hitungTotalYangDigunakan();
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }

  void pilihPemenang(index, indexDetail) async {
    print(dataRuteTender[index]);
    var data = await GetToPage.toNamed<ListPilihPemenangController>(
        Routes.LIST_PILIH_PEMENANG,
        arguments: [
          idTender,
          satuanTender,
          satuanVolume,
          dataRuteTender[index]['data'][indexDetail]['nilai'].toString(),
          dataRuteTender[index]['pickup'] +
              " - " +
              dataRuteTender[index]['destinasi'],
          (dataRuteTender[index]['data'][indexDetail]['nama_truk'] ?? "") +
              " - " +
              (dataRuteTender[index]['data'][indexDetail]['nama_carrier'] ??
                  ""),
          dataRuteTender[index]['data'][indexDetail]['datapemenang'],
          dataRuteTender[index]['data'][indexDetail]['statuspemenang'],
          dataRuteTender[index]['data'][indexDetail]['idrute'],
        ]);
    if (data != null) {
      errorPemenangTerisiSemua.value = "";

      dataRuteTender[index]['data'][indexDetail]['datapemenang'] = [];
      dataRuteTender[index]['data'][indexDetail]['local'] = false;
      if (data[0] == "TANPA PEMENANG") {
        print('SIAP');
        dataRuteTender[index]['data'][indexDetail]['statuspemenang'] = "2";
      } else if (data[0] == "PEMENANG") {
        //MESKI PEMENANG TAPI BLM ADA DATA, DIANGGAP BLM ADA PEMENANG
        if (data[1].length > 0) {
          dataRuteTender[index]['data'][indexDetail]['statuspemenang'] = "1";
          dataRuteTender[index]['data'][indexDetail]['datapemenang'] = data[1];
        } else {
          dataRuteTender[index]['data'][indexDetail]['statuspemenang'] = "0";
        }
      }

      dataRuteTender.refresh();

      await setDataLocalRute();
      hitungTotalYangDigunakan();
    }
  }

  void setDataLocalRute() async {
    var dataSebelumnya = await SharedPreferencesHelper.getDataPemenang();
    var dataRute = dataSebelumnya == "" ? [] : jsonDecode(dataSebelumnya);

    //YANG DISIMPAN RUTE YANG ADA
    dataRute =
        dataRute.where((element) => element['idtender'] != idTender).toList();

    print('DATA RUTE SEBELUMNYA DARI SET DATA LOCAL RUTE');
    print(dataRute);

    var map = {
      "idtender": idTender,
      "datarutetender": dataRuteTender,
    };

    dataRute.add(map);

    await SharedPreferencesHelper.setDataPemenang(jsonEncode(dataRute));

    print('TERSIMPAN');
  }

  Future<List> getDataLocalRute() async {
    var dataSebelumnya = await SharedPreferencesHelper.getDataPemenang();
    var dataRute = dataSebelumnya == "" ? [] : jsonDecode(dataSebelumnya);
    print('DATA RUTE SEBELUMNYA DARI GET DATA LOCAL RUTE');
    print(
        dataRute.where((element) => element['idtender'] == idTender).toList());
    return dataRute
        .where((element) => element['idtender'] == idTender)
        .toList();
  }

  void removeDataLocalRute() async {
    var dataSebelumnya = await SharedPreferencesHelper.getDataPemenang();
    var dataRute = dataSebelumnya == "" ? [] : jsonDecode(dataSebelumnya);

    //YANG DISIMPAN RUTE YANG ADA
    dataRute =
        dataRute.where((element) => element['idtender'] != idTender).toList();

    await SharedPreferencesHelper.setDataPemenang(jsonEncode(dataRute));

    print('TERSIMPAN');
  }
}
