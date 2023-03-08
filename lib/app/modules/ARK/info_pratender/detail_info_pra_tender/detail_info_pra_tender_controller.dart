import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/dialog_search_city_by_google.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_diumumkan_kepada_tender/list_diumumkan_kepada_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

class DetailInfoPraTenderController extends GetxController {
  var slideIndex = 0.obs;
  var pageController = PageController();
  var title = ''.obs;
  var cekPengisian = false.obs;
  var validasiSimpan = true;
  var aktifPengecekan = true;
  var isLoading = false.obs;
  var jenisTab = "";
  Timer time;

  var dateFormat = DateFormat('yyyy-MM-dd kk:mm:ss');

  //First page
  var formOne = GlobalKey<FormState>();
  var idPraTender = "";
  var kodePraTender = '<autogenerate>'.obs;
  var judulPraTender = "".obs;

  var shipperNama = "".obs;
  var shipperAvatar = "".obs;

  var dataEmailTransporter = [].obs;

  var dataAll = [
    {
      'name': 'Semua Mitra',
      'id': 'allMitra',
      'ismitra': 0,
      'isgroup': 0,
      'invited_email': 0,
      'select': false,
      'urutan': 0,
    },
    {
      'name': 'Semua Transporter',
      'id': 'allTransporter',
      'ismitra': 0,
      'isgroup': 0,
      'invited_email': 0,
      'select': false,
      'urutan': 0,
    }
  ].obs;

  var dataGroup = [].obs;
  var dataMitraTransporter = [].obs;
  var dataEmail = [].obs;
  var dataSelectedTampil = [].obs;
  var dataTahapTender = [].obs;
  var namaTahapTender = [
    "",
    "InfoPraTenderDetailLabelInfoPraTender".tr, // Info Pra Tender
    "InfoPraTenderDetailLabelProsesTender".tr, // Proses Tender
    "InfoPraTenderDetailLabelSeleksiPemenang".tr, // Seleksi Pemenang
    "InfoPraTenderDetailLabelPengumumanPemenang".tr, // Pengumuman Pemenang
    "InfoPraTenderDetailLabelEksekusiTender".tr //Eksekusi Tender
  ];

  var tanggalDibuat = ''.obs;
  var satuanTender = 2.obs;
  var namaSatuanTender = ''.obs;

  //SATUAN TENDER
  var arrSatuanTender = [
    "",
    "InfoPraTenderDetailLabelBerat".tr, // Berat
    "InfoPraTenderDetailLabelUnitTruk".tr, // Unit Truk
    "InfoPraTenderDetailVolume".tr, // Volume
  ];
  //SATUAN TENDER

  //Second page
  var formTwo = GlobalKey<FormState>();
  var namaMuatan = "".obs;
  var jenisMuatan = "".obs;
  var berat = "".obs;
  var volume = "".obs;
  var dimensiMuatanKoli = "".obs;
  var jumlahKoli = "".obs;
  var satuanVolume = "".obs;

  //SATUAN TENDER
  var arrJenisMuatan = [
    "",
    "Padat",
    "Cair",
    "Curah",
  ];
  var arrSatuanVolume = [
    "",
    "m\u00B3",
    "L",
  ];
  var arrSatuanDimensi = [
    "",
    "m",
    "cm",
  ];
  //SATUAN TENDER

  //Third page
  var formThree = GlobalKey<FormState>();
  var dataTrukTender = [].obs; // Map<String,String>

  //Fourth page
  var formFour = GlobalKey<FormState>();
  var dataRuteTender = [].obs;
  var jumlahYangDigunakan = 0.0.obs;

  //Five page
  var formFive = GlobalKey<FormState>();
  var persyaratanController = TextEditingController();
  var catatanTambahanController = TextEditingController();
  var dataNote = [].obs;
  var dataKualifikasiPraTender = [].obs;
  var link = "".obs;
  var nama_file = "".obs;
  String filePath = "";
  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var status = 0.obs;

  var cekEdit = false;
  var cekLampiran = false;
  var cekShare = false;
  var cekKirim = false;

  @override
  void onInit() async {
    cekEdit = await SharedPreferencesHelper.getHakAkses("Edit Info Pra Tender");
    cekLampiran = await SharedPreferencesHelper.getHakAkses("Lihat dan Download File Persyaratan/Lampiran Pra Tender");
    cekShare = await SharedPreferencesHelper.getHakAkses("Export Detail Info Pra Tender");
    cekKirim = await SharedPreferencesHelper.getHakAkses("Undag Invited Transporter Pra Tender");
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);
    updateTitle();
    idPraTender = Get.arguments[0].toString();
    jenisTab = Get.arguments[1].toString();
    getDetail("");
  }

  void collectData() {
    var dataSelectedUrut = [];
    var semuaMitra = false;
    var semuaTransporter = false;
    dataSelectedUrut.clear();
    dataSelectedTampil.clear();

    //JIKA DICENTANG DATA SEMUA MITRA
    if (dataAll[0]['select']) {
      dataSelectedUrut.add(dataAll[0]);
      semuaMitra = true;
    }
    //JIKA DICENTANG DATA SEMUA TRANSPORTER
    if (dataAll[1]['select']) {
      dataSelectedUrut.add(dataAll[1]);
      semuaTransporter = true;
    }

    //UNTUK MITRA YANG ADA PADA DATA GROUP

    if (!semuaMitra && !semuaTransporter) {
      //GROUP
      for (var x = 0; x < dataGroup.length; x++) {
        if (dataGroup[x]['select']) {
          dataSelectedUrut.add(dataGroup[x]);
        }
      }

      //MITRA
      for (var x = 0; x < dataMitraTransporter.length; x++) {
        //CEK JIKA DIA DICENTANG, MITRA, DAN TIDAK MASUK GRUP
        if (dataMitraTransporter[x]['select'] &&
            dataMitraTransporter[x]['ismitra'] == 1) {
          dataSelectedUrut.add(dataMitraTransporter[x]);
        }
      }
    }

    if (!semuaTransporter) {
      for (var x = 0; x < dataMitraTransporter.length; x++) {
        if (dataMitraTransporter[x]['select'] &&
            dataMitraTransporter[x]['ismitra'] == 0) {
          dataSelectedUrut.add(dataMitraTransporter[x]);
        }
      }
    }

    //CEK DATA EMAIL INVITATION, TIDAK MUNCUL DI DIUMUMKAN
    // for (var x = 0; x < dataEmail.length; x++) {
    //   if (dataEmail[x]['name'] != "") {
    //     dataSelectedUrut.add({
    //       'id': '0',
    //       'name': dataEmail[x]['name'] ?? "",
    //       'ismitra': 0,
    //       'isgroup': 0,
    //       'invited_email': 1,
    //       'image': '',
    //       'urutan': dataEmail[x]['urutan'],
    //     });
    //   }
    // }

    //SORT DENGAN URUTAN, DAPATKAN YANG URUTAN TERBESAR
    var urutanTerbesar = 0;
    for (var x = 0; x < dataSelectedUrut.length; x++) {
      if (dataSelectedUrut[x]['urutan'] > 0 &&
          urutanTerbesar < dataSelectedUrut[x]['urutan']) {
        urutanTerbesar = dataSelectedUrut[x]['urutan'];
      }
    }

    //URUTKAN DIMULAI 1, KARENA NOL BERARTI TIDAK DIPILIH
    for (var x = 1; x <= urutanTerbesar; x++) {
      for (var y = 0; y < dataSelectedUrut.length; y++) {
        if (x == dataSelectedUrut[y]['urutan']) {
          dataSelectedTampil.add(dataSelectedUrut[y]);
        }
      }
    }

    dataSelectedTampil.refresh();

    print(dataSelectedUrut);
    print(dataSelectedTampil);
  }

  Future getDetail(String keterangan) async {
    // KALAU KETERANGANNYA KOSONG ALIAS TANPA GET DETAIL BUKAN DARI KIRIM ULANG
    if (keterangan == "") {
      isLoading.value = true;
    }

    String id = await SharedPreferencesHelper.getUserShipperID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDetailInfoPraTender(id, idPraTender);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      print(data['lampiran']['FileName']);
      print(nama_file.value);
      print(link.value);

      dataGroup.clear();
      dataMitraTransporter.clear();
      dataEmail.clear();
      dataEmailTransporter.clear();

      //DATA EMAIL
      for (var x = 0; x < data['invitation'].length; x++) {
        data['invitation'][x]['name'] ?? "";
        if (data['invitation'][x]['name'] != "") {
          if (data['invitation'][x]['name'] == "Semua Mitra") {
            dataAll[0]['select'] = true;
            dataAll[0]['urutan'] = (x + 1);
          }

          if (data['invitation'][x]['name'] == "Semua Transporter") {
            dataAll[1]['select'] = true;
            dataAll[1]['urutan'] = (x + 1);
          }

          if (data['invitation'][x]['group'] != "" &&
              data['invitation'][x]['group'] != null) {
            dataGroup.add({
              'ismitra': 0,
              'isgroup': 1,
              'invited_email': 0,
              'id': data['invitation'][x]['id'].toString(),
              'name': data['invitation'][x]['name'],
              'image': data['invitation'][x]['image'],
              'select': true,
              'urutan': (x + 1),
            });
          }

          if (data['invitation'][x]['kategori'] == "Mitra") {
            dataMitraTransporter.add({
              'ismitra': 1,
              'isgroup': 0,
              'invited_email': 0,
              'id': data['invitation'][x]['id'].toString(),
              'name': data['invitation'][x]['name'],
              'image': data['invitation'][x]['image'],
              'select': true,
              'urutan': (x + 1),
            });
          }

          if (data['invitation'][x]['kategori'] == "Transporter") {
            dataMitraTransporter.add({
              'ismitra': 0,
              'isgroup': 0,
              'invited_email': 0,
              'id': data['invitation'][x]['id'].toString(),
              'name': data['invitation'][x]['name'],
              'image': data['invitation'][x]['image'],
              'select': true,
              'urutan': (x + 1),
            });
          }

          if (data['invitation'][x]['kategori'] == "Email") {
            dataEmail.add({
              'ismitra': 0,
              'isgroup': 0,
              'invited_email': 1,
              'id': 0,
              'name': data['invitation'][x]['name'],
              'image': '',
              'select': true,
              'urutan': (x + 1),
            });
          }
        }
      }

      //DATA EMAIL
      for (var x = 0; x < dataEmail.length; x++) {
        for (var y = 0; y < data['email'].length; y++) {
          if (dataEmail[x]['name'] == data['email'][y]['Email']) {
            dataEmail[x]['id'] = data['email'][x]['ID'];
            dataEmail[x]['name'] = data['email'][x]['Email'] ?? "";
          }
        }
      }

      //DAPATKAN TANGGAL TERKECIL
      for (var x = 0; x < data['email'].length; x++) {
        var cekAda = false;
        for (var y = 0; y < dataEmailTransporter.length; y++) {
          if (dataEmailTransporter[y]['tanggalRaw'] ==
              data['email'][x]['TglDibuatRaw']) {
            cekAda = true;
          }
        }

        if (!cekAda) {
          var dataEmailList = {
            'data': [],
            'tanggalRaw': data['email'][x]['TglDibuatRaw'],
            'tanggal': data['email'][x]['Created'],
          };
          dataEmailTransporter.add(dataEmailList);
        }
      }

      for (var x = 0; x < dataEmailTransporter.length; x++) {
        var dataEmailList = [];
        for (var y = 0; y < data['email'].length; y++) {
          if (dataEmailTransporter[x]['tanggalRaw'] ==
              data['email'][y]['TglDibuatRaw']) {
            dataEmailList.add({
              'id': data['email'][y]['ID'],
              'name': data['email'][y]['Email'],
              'waktu': data['email'][y]['Seconds'],
            });
          }
        }

        dataEmailTransporter[x]['data'] = dataEmailList;
      }

      if (keterangan == "") {
        dataTahapTender.clear();
        dataTrukTender.clear();
        dataRuteTender.clear();
        dataNote.clear();
        dataKualifikasiPraTender.clear();

        //First page
        print("FIRST PAGE");
        kodePraTender.value = data['kode_td'];
        tanggalDibuat.value = data['TanggalDibuat'];

        judulPraTender.value = data['judul'];

        for (var x = 0; x < data['tahap_tender'].length; x++) {
          dataTahapTender.add({
            'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
            'show_first_date': data['tahap_tender'][x]
                ['tanggal_dimulai_format'],
            'show_last_date': data['tahap_tender'][x]['tanggal_akhir_format'],
            'min_date':
                DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai']),
            'max_date':
                DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']),
          });
        }

        satuanTender.value = data['satuan_tender'];
        namaSatuanTender.value = arrSatuanTender[satuanTender.value];
        shipperNama.value = data['shipper_nama'];
        shipperAvatar.value = data['shipper_avatar'];

        //Second page

        print("SECOND PAGE");
        namaMuatan.value = data['nama_muatan'];
        jenisMuatan.value = arrJenisMuatan[data['jenis_muatan']];
        berat.value =
            GlobalVariable.formatCurrencyDecimal(data['berat'].toString()) +
                " Ton";
        if (GlobalVariable.formatCurrencyDecimal(data['berat'].toString()) ==
            "0") {
          berat.value = "-";
        }
        satuanVolume.value = arrSatuanVolume[data['satuan_volume']];
        volume.value =
            GlobalVariable.formatCurrencyDecimal(data['volume'].toString()) +
                " " +
                satuanVolume.value;

        if (GlobalVariable.formatCurrencyDecimal(data['volume'].toString()) ==
            "0") {
          volume.value = "-";
        }

        dimensiMuatanKoli.value = (GlobalVariable.formatCurrencyDecimal(
                        data['dimensi_p'].toString()) ==
                    "0"
                ? "-"
                : GlobalVariable.formatCurrencyDecimal(
                    data['dimensi_p'].toString())) +
            ' ' +
            arrSatuanDimensi[data['satuan_dimensi']] +
            " x " +
            (GlobalVariable.formatCurrencyDecimal(
                        data['dimensi_l'].toString()) ==
                    "0"
                ? "-"
                : GlobalVariable.formatCurrencyDecimal(
                    data['dimensi_l'].toString())) +
            ' ' +
            arrSatuanDimensi[data['satuan_dimensi']] +
            " x " +
            (GlobalVariable.formatCurrencyDecimal(
                        data['dimensi_t'].toString()) ==
                    "0"
                ? "-"
                : GlobalVariable.formatCurrencyDecimal(
                    data['dimensi_t'].toString())) +
            ' ' +
            arrSatuanDimensi[data['satuan_dimensi']];

        if (GlobalVariable.formatCurrencyDecimal(
                    data['dimensi_p'].toString()) ==
                "0" &&
            GlobalVariable.formatCurrencyDecimal(
                    data['dimensi_l'].toString()) ==
                "0" &&
            GlobalVariable.formatCurrencyDecimal(
                    data['dimensi_t'].toString()) ==
                "0") {
          dimensiMuatanKoli.value = "-";
        }

        jumlahKoli.value = data['jumlah_koli'].toString() == "0"
            ? "-"
            : GlobalVariable.formatCurrencyDecimal(
                    data['jumlah_koli'].toString()) +
                " Koli";

        //Third page

        print("THIRD PAGE");
        for (var x = 0; x < data['unit_truk'].length; x++) {
          dataTrukTender.add({
            'truck_id': data['unit_truk'][x]['ID'],
            'jenis_truk': data['unit_truk'][x]['jenis_trukID'],
            'jenis_carrier': data['unit_truk'][x]['jenis_carrierID'],
            'nama_truk': data['unit_truk'][x]['jenis_truk_raw'],
            'nama_carrier': data['unit_truk'][x]['jenis_carrier_raw'],
            'deskripsi': (data['unit_truk'][x]['truk_tonase'] ?? "-") +
                " / " +
                (data['unit_truk'][x]['truk_dimensi'] ?? "-") +
                " / " +
                (data['unit_truk'][x]['truk_volume'] ?? "-"),
            'gambar_truk': data['unit_truk'][x]['truk_image'],
            'jumlah_truck': data['unit_truk'][x]['jumlah'],
          });
        }

        //Fourth page

        print("FOURTH PAGE");
        for (var x = 0; x < data['rute'].length; x++) {
          var ListTruk = [];
          if (satuanTender.value == 2) {
            for (var x1 = 0; x1 < dataTrukTender.length; x1++) {
              var dataAda = false;
              ListTruk.add({
                'jenis_truk': dataTrukTender[x1]['jenis_truk'],
                'nama_truk': dataTrukTender[x1]['nama_truk'],
                'jenis_carrier': dataTrukTender[x1]['jenis_carrier'],
                'nama_carrier': dataTrukTender[x1]['nama_carrier'],
                'error': ''
              });

              for (var y = 0; y < data['rute'][x]['child'].length; y++) {
                if (dataTrukTender[x1]['jenis_truk'] ==
                        data['rute'][x]['child'][y]['jenis_truk'] &&
                    dataTrukTender[x1]['jenis_carrier'] ==
                        data['rute'][x]['child'][y]['jenis_carrier']) {
                  dataAda = true;
                  ListTruk[ListTruk.length - 1]['nilai'] =
                      data['rute'][x]['child'][y]['nilai'];
                }
              }

              if (!dataAda) {
                ListTruk[ListTruk.length - 1]['nilai'] = 0;
              }
            }
          } else {
            for (var y = 0; y < data['rute'][x]['child'].length; y++) {
              ListTruk.add({
                'jenis_truk': data['rute'][x]['child'][y]['jenis_truk'],
                'nama_truk': data['rute'][x]['child'][y]['jenis_truk_name'],
                'jenis_carrier': data['rute'][x]['child'][y]['jenis_carrier'],
                'nama_carrier': data['rute'][x]['child'][y]
                    ['jenis_carrier_name'],
                'nilai': data['rute'][x]['child'][y]['nilai'],
                'error': ''
              });
            }
          }

          dataRuteTender.add({
            'pickup': data['rute'][x]['pickup'],
            'destinasi': data['rute'][x]['destinasi'],
            'data': ListTruk
          });
        }

        hitungTotalYangDigunakan();
        //Fifth page

        print("FIFTH PAGE");
        for (var x = 0; x < data['notes'].length; x++) {
          dataNote.add({
            'tglDibuat': data['notes'][x]['TanggalDibuat'] ?? "",
            'isi': data['notes'][x]['Content'].replaceAll("<br>", "\n") ?? "",
            'no': data['notes'][x]['Urut'] ?? "",
          });
        }

        for (var x = 0; x < data['kualifikasi_pratender'].length; x++) {
          dataKualifikasiPraTender.add({
            'tglDibuat':
                data['kualifikasi_pratender'][x]['TanggalDibuat'] ?? "",
            'isi': data['kualifikasi_pratender'][x]['detail']
                    .replaceAll("<br>", "\n") ??
                "",
          });
        }

        if (data['lampiran']['FileName'] != null) {
          nama_file.value = data['lampiran']['FileName'].split("/").last ?? "";
          link.value = data['lampiran']['Link'] ?? "";
        } else {
          nama_file.value = "";
          link.value = "";
        }

        status.value = data['status'] ?? "";

        //BATAL JADI HISTORY
        if (status.value.toString() == "3" ||
            DateTime.parse(
                        data['tahap_tender'][0]['tanggal_akhir'] + " 23:59:59")
                    .compareTo(await GlobalVariable.getDateTimeFromServer(
                        Get.context)) <
                0) {
          jenisTab = "History";
        }
      }

      setMailTime();
    } else {
      isLoading.value = false;
    }
  }

  void updateTitle() {
    if (satuanTender == 2) {
      switch (slideIndex.value) {
        case 0:
          {
            title.value =
                'InfoPraTenderDetailLabelDataPraTender'; // Data Pra Tender
            break;
          }
        case 1:
          {
            title.value = 'InfoPraTenderDetailLabelDataMuatan'; // Data Muatan
            break;
          }
        case 2:
          {
            title.value =
                'InfoPraTenderDetailLabelDataPraTender'; // Data Pra Tender
            break;
          }
        case 3:
          {
            title.value =
                'InfoPraTenderDetailLabelRuteYangDitenderkan'; // Rute yang Ditenderkan
            break;
          }
        case 4:
          {
            title.value =
                'InfoPraTenderDetailLabelPersyaratanKualifikasi'; // Persyaratan Kualifikasi
            break;
          }
      }
    } else {
      switch (slideIndex.value) {
        case 0:
          {
            title.value =
                'InfoPraTenderDetailLabelDataPraTender'; // Data Pra Tender
            break;
          }
        case 1:
          {
            title.value = 'InfoPraTenderDetailLabelDataMuatan'; // Data Muatan
            break;
          }
        case 2:
          {
            title.value =
                'InfoPraTenderDetailLabelRuteYangDitenderkan'; // Rute yang Ditenderkan
            break;
          }
        case 3:
          {
            title.value =
                'InfoPraTenderDetailLabelPersyaratanKualifikasi'; // Persyaratan Kualifikasi
            break;
          }
      }
    }
  }

  @override
  void onReady() {}

  void onSave() async {
    if (time.isActive) {
      time.cancel();
    }
    Get.back();
  }

  void shareDetailInfoPraTender() async {
    String id = await SharedPreferencesHelper.getUserShipperID();
    onDownloading.value = true;
    onProgress.value = 0;
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
              child: WillPopScope(
                  onWillPop: () {},
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 8))),
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 30),
                      padding: EdgeInsets.all(
                          GlobalVariable.ratioWidth(Get.context) * 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(ListColor.color4)),
                              value: onProgress.value)),
                          Container(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 10),
                          Obx(() => RichText(
                              text: TextSpan(
                                  text: "Downloading " +
                                      (onProgress.value * 100)
                                          .toInt()
                                          .toString() +
                                      " %", // Menampilkan hasil untuk
                                  style: TextStyle(
                                    fontFamily: "AvenirNext",
                                    color: Color(ListColor.colorBlack),
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                  ),
                                  children: [])))
                        ],
                      ))));
        });

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .sharePDFDetailInfoPraTender(id, idPraTender);

    if (result['Message']['Code'].toString() == '200') {
      Get.back();
      shareData(result['Data']['link'].toString(), false);
    }
  }

  void shareData(String link, bool usingBaseFileLink) async {
    var namaFile = GlobalVariable.formatNamaFile(link.split("/").last);

    var savedLocation = await _getLocalPath() + "/" + namaFile;
    print(savedLocation);
    var existed = await File(savedLocation).exists();
    print(existed);
    //JIKA SUDAH PERNAH DIDOWNLOAD ARAHKAN KE LOCAL
    if (existed) {
      onProgress.value = 1;
      var status = await Permission.storage.request();
      print(status);
      if (status.isGranted) {
        Share.shareFiles([savedLocation]);
      } else {
        print('Permission Denied!');
      }
    } else {
      //KARENA KETIKA DOWNLOAD, DAN TAP DOWNLOADNYA FALSE, DIA LANGSUNG SHARE
      filePath = savedLocation;
      await download(link, namaFile, usingBaseFileLink);
    }
  }

  @override
  void onClose() {
    //FocusScope.of(Get.context).unfocus();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void lihat(String link, String fileNameDownload) async {
    var savedLocation = await _getLocalPath() + "/" + fileNameDownload;
    var linkFile = link;
    // if (!link.contains(GlobalVariable.urlFile)) {
    //   linkFile = GlobalVariable.urlFile + link;
    // }

    //JIKA SUDAH PERNAH DIDOWNLOAD ARAHKAN KE LOCAL
    if (await File(savedLocation).exists()) {
      linkFile = savedLocation;
    }

    print(linkFile);
    if (linkFile.split(":").first == "https") {
      print('Debug: Opening File Document Via Internet');
      // Get.toNamed(Routes.LIHAT_PDF, arguments: [fileNameDownload, linkFile]);
      if (await canLaunch(linkFile)) {
        await launch(linkFile);
      } else {
        throw "Could not launch $linkFile";
      }
    } else {
      File myFile = File(linkFile);
      if (myFile.existsSync()) {
        print('Debug: Opening File Document');
        var result = await OpenFile.open(linkFile);
      } else {
        print('Debug: Failed Opening File Document');
      }
    }
  }

  Future<String> _getLocalPath() async {
    return (await _findLocalPath()) + Platform.pathSeparator + 'Download';
  }

  static void downloadCallBack(id, status, progress) {
    SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, "downloader_send_port");
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    _port.listen((message) {
      onProgress.value = message[2] / 100;
      print(message[2].toString());
      if (message[2] == 100.0 && onDownloading.value) {
        Get.back();
        onDownloading.value = false;
        print(tapDownload);
        if (tapDownload) {
          CustomToast.show(
              context: Get.context,
              message: "DetailTransporterLabelDownloadComplete".tr);
        } else {
          Share.shareFiles([filePath]);
        }
      } else if (message[2] == -1) {
        Get.back();
      }
    });
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping("downloader_send_port");
  }

  Future<void> download(
      String url, String fileNameDownload, bool usingBaseFileLink) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
              child: WillPopScope(
                  onWillPop: null,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 8))),
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 30),
                      padding: EdgeInsets.all(
                          GlobalVariable.ratioWidth(Get.context) * 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() => CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(ListColor.color4)),
                              value: onProgress.value)),
                          Container(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 10),
                          Obx(() => RichText(
                              text: TextSpan(
                                  text: "Downloading " +
                                      (onProgress.value * 100)
                                          .toInt()
                                          .toString() +
                                      " %", // Menampilkan hasil untuk
                                  style: TextStyle(
                                    fontFamily: "AvenirNext",
                                    color: Color(ListColor.colorBlack),
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                  ),
                                  children: [])))
                        ],
                      ))));
        });
    var status = await Permission.storage.request();
    String urlFile = "";
    // if (!url.contains(GlobalVariable.urlFile)) {
    //   urlFile = GlobalVariable.urlFile;
    // }
    if (status.isGranted) {
      var savedLocation = await _getLocalPath();
      onDownloading.value = true;
      String downloadId = await FlutterDownloader.enqueue(
          url: urlFile + url,
          // savedDir: externalDir.path,
          savedDir: savedLocation,
          saveInPublicStorage: true,
          showNotification: true,
          fileName: fileNameDownload,
          openFileFromNotification: true);
    } else {
      print('Permission Denied!');
    }
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0";
    // return ExtStorage.getExternalStorageDirectory();
  }

  //FIRST PAGE WIDGET & FUNCTION

  Widget selectedTransporterWidget(data, int index) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      index < 5
          ? CustomText(
              index == dataSelectedTampil.length - 1 &&
                      dataSelectedTampil.length < 6
                  ? data['name']
                  : data['name'] + ", ",
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 1.6,
            )
          : Row(children: [
              CustomText(
                ".... ",
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.6,
              ),
              GestureDetector(
                child: Material(
                    color: Colors.transparent,
                    elevation: 5,
                    child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          minWidth: GlobalVariable.ratioWidth(Get.context) * 24,
                          minHeight:
                              GlobalVariable.ratioWidth(Get.context) * 24,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Color(ListColor.colorBlue)),
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 4)),
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 4,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 2),
                        child: CustomText(
                            "+" +
                                (dataSelectedTampil.value.length - 5)
                                    .toString(),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorBlue)))),
                onTap: () async {
                  var data = await GetToPage.toNamed<
                          ListDiumumkanKepadaTenderController>(
                      Routes.LIST_DIUMUMKAN_KEPADA_TENDER,
                      arguments: [
                        dataAll,
                        dataGroup,
                        dataMitraTransporter,
                        dataEmail,
                        'DETAIL_INFO_PRA_TENDER'
                      ]);
                  print(data);
                  if (data != null) {
                    dataAll.value = data[0];
                    dataGroup.value = data[1];
                    dataMitraTransporter.value = data[2];
                    dataEmail.value = data[3];

                    dataAll.refresh();
                    dataGroup.refresh();
                    dataMitraTransporter.refresh();
                    dataEmail.refresh();
                  }
                },
              )
            ])
    ]);
  }

  Widget listTahapTenderWidget(int index) {
    //LIST DROP DOWN MENU
    return Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 20,
                      child: CustomText((index + 1).toString() + '.',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(ListColor.colorDarkGrey3))),
                  Expanded(
                      child: CustomText(
                          namaTahapTender[dataTahapTender[index]
                                  ['tahap_tender']]
                              .toString()
                              .tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(ListColor.colorDarkGrey3)))
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),
              Row(
                children: [
                  Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 20,
                      child: CustomText('  '.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(ListColor.colorDarkGrey3))),
                  Expanded(
                    child: periodeTenderWidget(index),
                  )
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
            ]));
  }

  Widget periodeTenderWidget(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: CustomText('InfoPraTenderDetailLabelPeriode'.tr, // Periode
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: 1.3,
                  color: Color(ListColor.colorGrey3)),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: CustomText(dataTahapTender[index]['show_first_date'],
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        color: Color(ListColor.colorBlack1B)))),
            Container(
              child: CustomText(
                  ' ' + 'InfoPraTenderDetailLabelSampaiDengan'.tr + ' ', //s/d
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: CustomText(dataTahapTender[index]['show_last_date'],
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        color: Color(ListColor.colorBlack1B)))),
            SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 47)
          ],
        ),
      ],
    );
  }
  //FIRST PAGE

  //THIRD PAGE WIDGET & FUNCTION
  Widget kebutuhanTrukWidget(index) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            dataTrukTender.length > 1
                ? ('InfoPraTenderDetailLabelKebutuhan'.tr +
                    ' #' +
                    (index + 1).toString().tr) //Kebutuhan
                : ('InfoPraTenderDetailLabelKebutuhan'.tr), //Kebutuhan
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(ListColor.colorLightGrey4)),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
        Obx(() => Container(
              alignment: Alignment.center,
              height: GlobalVariable.ratioWidth(Get.context) * 167,
              decoration: BoxDecoration(
                  color: dataTrukTender[index]['gambar_truk'].isEmpty
                      ? Color(ListColor.colorBackgroundGambar)
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
                  border: Border.all(
                      color: Color(ListColor.colorLightGrey10), width: 1)),
              child: Obx(
                () => CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: dataTrukTender[index]['gambar_truk'],
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 19)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain)),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                ),
              ),
            )),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
        Row(
          children: [
            Container(
              width: GlobalVariable.ratioWidth(Get.context) * 108,
              child: CustomText(
                  "InfoPraTenderDetailLabelJenisTruk".tr, // Jenis Truk
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
            ),
            Expanded(
              child: CustomText(dataTrukTender[index]['nama_truk'],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Row(
          children: [
            Container(
              width: GlobalVariable.ratioWidth(Get.context) * 108,
              child: CustomText(
                  "InfoPraTenderDetailLabelJenisCarrier".tr, // Jenis Carrier
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
            ),
            Expanded(
              child: CustomText(dataTrukTender[index]['nama_carrier'],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Row(
          children: [
            Container(
              width: GlobalVariable.ratioWidth(Get.context) * 108,
              child: CustomText("InfoPraTenderDetailLabelJumlah".tr, // Jumlah
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
            ),
            Expanded(
              child: CustomText(
                  GlobalVariable.formatCurrencyDecimal(
                          dataTrukTender[index]['jumlah_truck'].toString()) +
                      " Unit",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
        CustomText(
            'InfoPraTenderDetailLabelEstimasi'
                .tr, //Estimasi kapasitas / dimensi / volume
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(ListColor.colorGrey3)),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
        Obx(
          () => CustomText(dataTrukTender[index]['deskripsi'].toString().tr,
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
        ),
        dataTrukTender.length > 1 && index != dataTrukTender.length - 1
            ? Column(children: [
                SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
                lineDividerWidget(),
                SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
              ])
            : SizedBox()
      ],
    ));
  }

  //THIRD PAGE

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 1,
        color: Color(ListColor.colorLightGrey14).withOpacity(0.3),
        height: 0,
      ),
    );
  }

  Widget unitTrukRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            children: [
              index > 0
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 14)
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      "InfoPraTenderDetailLabelRute".tr +
                          " " +
                          (index + 1).toString(), // Rute
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),
              Container(
                  //KALAU INDEX TERAKHIR< TIDAK PERLU
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 10,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(ListColor.colorBorderTextbox)),
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => CustomText(
                            dataRuteTender[index]['pickup'] +
                                " - " +
                                dataRuteTender[index]['destinasi'],
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 14,
                      ),
                      Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //LEFT
                          Expanded(
                            child: CustomText(
                                'InfoPraTenderDetailLabelJenisTruk'
                                    .tr, // Jenis Truk
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          //RIGHT
                          Container(
                              alignment: Alignment.centerRight,
                              constraints: BoxConstraints(
                                  minWidth:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          52),
                              child: CustomText(
                                  'InfoPraTenderDetailLabelJumlah'.tr, // Jumlah
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.right,
                                  color: Colors.black))
                        ],
                      )),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 8,
                      ),
                      //DETAIL JENIS TRUK DAN JUMLAH
                      for (var indexDetail = 0;
                          indexDetail < dataRuteTender[index]['data'].length;
                          indexDetail++)
                        dataRuteTender[index]['data'][indexDetail]['nilai'] != 0
                            ? Container(
                                margin: indexDetail ==
                                        dataRuteTender[index]['data']
                                            .indexWhere((element) =>
                                                element['nilai'] != 0)
                                    ? null //EYA
                                    : EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            22), // JIKA INDEX TERAKHIR, TIDAK PERLU
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //LEFT
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Obx(
                                            () => CustomText(
                                                dataRuteTender[index]['data']
                                                    [indexDetail]['nama_truk'],
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(
                                                    ListColor.colorDarkGrey3)),
                                          ),
                                          SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                4,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "ic_truck_grey.svg",
                                                  color: Color(
                                                      ListColor.colorBlue),
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          18),
                                              SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          9),
                                              Obx(
                                                () => CustomText(
                                                    dataRuteTender[index]
                                                                ['data']
                                                            [indexDetail]
                                                        ['nama_carrier'],
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(ListColor
                                                        .colorDarkGrey3)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    //RIGHT
                                    Container(
                                        alignment: Alignment.centerRight,
                                        constraints: BoxConstraints(
                                            minWidth: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                52),
                                        child: Obx(() => CustomText(
                                            GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        dataRuteTender[index]
                                                                        ['data']
                                                                    [
                                                                    indexDetail]
                                                                ['nilai']
                                                            .toString()) +
                                                ' Unit'.tr,
                                            fontSize: 14,
                                            textAlign: TextAlign.right,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black))),
                                  ],
                                ),
                              )
                            : SizedBox()
                    ],
                  ))
            ],
          )
        : SizedBox());
  }

  Widget beratRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            children: [
              index > 0
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24)
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      "InfoPraTenderDetailLabelRute".tr +
                          " " +
                          (index + 1).toString().tr, // Rute
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
              Container(
                  constraints: BoxConstraints(
                    minHeight: GlobalVariable.ratioWidth(Get.context) * 175,
                  ),
                  //KALAU INDEX TERAKHIR< TIDAK PERLU
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 14,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(ListColor.colorBorderTextbox)),
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6))),
                  child: Stack(
                    children: [
                      Positioned(
                        top: GlobalVariable.ratioWidth(Get.context) * 15.5,
                        child: Container(
                          alignment: Alignment.center,
                          width: GlobalVariable.ratioWidth(Get.context) * 11.8,
                          child: Dash(
                            direction: Axis.vertical,
                            length: GlobalVariable.ratioWidth(Get.context) * 50,
                            dashGap: 1.8,
                            dashThickness: 1.5,
                            dashLength: 5,
                            dashColor: Color(ListColor.colorDash),
                          ),
                        ),
                      ),
                      Positioned(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: GlobalVariable.ratioWidth(Get.context) *
                                    19),
                            child: SvgPicture.asset(
                                GlobalVariable.imagePath + 'ic_pickup.svg',
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    12),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    "InfoPraTenderDetailLabelPickUp"
                                        .tr, //Pickup
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                CustomText(dataRuteTender[index]['pickup'],
                                    fontSize: 14,
                                    height: 1.2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ])
                        ],
                      )),
                      Positioned(
                        top: GlobalVariable.ratioWidth(Get.context) * 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          19),
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath + 'ic_destinasi.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      "InfoPraTenderDetailLabelDestinasi"
                                          .tr, //Destinasi
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  CustomText(dataRuteTender[index]['destinasi'],
                                      fontSize: 14,
                                      height: 1.2,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ])
                          ],
                        ),
                      ),
                      Positioned(
                        top: GlobalVariable.ratioWidth(Get.context) * 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15),
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath + 'ic_berat.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      "InfoPraTenderDetailLabelBerat"
                                          .tr, // Berat
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  CustomText(
                                      GlobalVariable.formatCurrencyDecimal(
                                              dataRuteTender[index]['data'][0]
                                                      ['nilai']
                                                  .toString()) +
                                          " Ton",
                                      fontSize: 14,
                                      height: 1.2,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ])
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          )
        : SizedBox());
  }

  Widget volumeRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            children: [
              index > 0
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24)
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      "InfoPraTenderDetailLabelRute".tr +
                          " " +
                          (index + 1).toString().tr, // Rute
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
              Container(
                  constraints: BoxConstraints(
                    minHeight: GlobalVariable.ratioWidth(Get.context) * 175,
                  ),
                  //KALAU INDEX TERAKHIR< TIDAK PERLU
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 14,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(ListColor.colorBorderTextbox)),
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6))),
                  child: Stack(
                    children: [
                      Positioned(
                        top: GlobalVariable.ratioWidth(Get.context) * 15.5,
                        child: Container(
                          alignment: Alignment.center,
                          width: GlobalVariable.ratioWidth(Get.context) * 11.8,
                          child: Dash(
                            direction: Axis.vertical,
                            length: GlobalVariable.ratioWidth(Get.context) * 50,
                            dashGap: 1.8,
                            dashThickness: 1.5,
                            dashLength: 5,
                            dashColor: Color(ListColor.colorDash),
                          ),
                        ),
                      ),
                      Positioned(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: GlobalVariable.ratioWidth(Get.context) *
                                    19),
                            child: SvgPicture.asset(
                                GlobalVariable.imagePath + 'ic_pickup.svg',
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    12),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    "InfoPraTenderDetailLabelPickUp"
                                        .tr, //Pickup
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                CustomText(dataRuteTender[index]['pickup'],
                                    fontSize: 14,
                                    height: 1.2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ])
                        ],
                      )),
                      Positioned(
                        top: GlobalVariable.ratioWidth(Get.context) * 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          19),
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath + 'ic_destinasi.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      "InfoPraTenderDetailLabelDestinasi"
                                          .tr, //Destinasi
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  CustomText(dataRuteTender[index]['destinasi'],
                                      fontSize: 14,
                                      height: 1.2,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ])
                          ],
                        ),
                      ),
                      Positioned(
                        top: GlobalVariable.ratioWidth(Get.context) * 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15),
                              child: SvgPicture.asset(
                                  GlobalVariable.imagePath + 'volume_icon.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      "InfoPraTenderDetailLabelVolume"
                                          .tr, // Volume
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  CustomText(
                                      GlobalVariable.formatCurrencyDecimal(
                                              dataRuteTender[index]['data'][0]
                                                      ['nilai']
                                                  .toString()) +
                                          " " +
                                          satuanVolume.value,
                                      fontSize: 14,
                                      height: 1.2,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ])
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          )
        : SizedBox());
  }

  void hitungTotalYangDigunakan() {
    jumlahYangDigunakan.value = 0;
    if (satuanTender == 2) {
      for (var x = 0; x < dataRuteTender.length; x++) {
        for (var y = 0; y < dataRuteTender[x]['data'].length; y++) {
          jumlahYangDigunakan.value += dataRuteTender[x]['data'][y]['nilai'];
        }
      }
    } else if (satuanTender == 1) {
      for (var x = 0; x < dataRuteTender.length; x++) {
        jumlahYangDigunakan.value += dataRuteTender[x]['data'][0]['nilai'];
      }
    } else if (satuanTender == 3) {
      for (var x = 0; x < dataRuteTender.length; x++) {
        jumlahYangDigunakan.value += dataRuteTender[x]['data'][0]['nilai'];
      }
    }
  }

  void setMailTime() async {
    time = Timer.periodic(const Duration(seconds: 1), (val) {
      for (var x = 0; x < dataEmailTransporter.length; x++) {
        for (var y = 0; y < dataEmailTransporter[x]['data'].length; y++) {
          if (dataEmailTransporter[x]['data'][y]['waktu'] > 0) {
            dataEmailTransporter[x]['data'][y]['waktu']--;
            dataEmailTransporter.refresh();
          } else {
            dataEmailTransporter[x]['data'][y]['waktu'] = 0;
            dataEmailTransporter.refresh();
          }
        }
      }
      isLoading.value = false;
    });
    collectData();
  }

  Future kirimUlang(int idEmail, int index) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {},
              child: Center(child: CircularProgressIndicator()));
        });

    String shipperID = await SharedPreferencesHelper.getUserShipperID();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .resendEmailInfoPraTender(shipperID, idEmail.toString());

    if (result['Message']['Code'].toString() == '200') {
      Get.back(result: true);
      CustomToast.show(
          context: Get.context,
          message:
              "InfoPraTenderDetailLabelTeksBerhasilMengirimUlangInvitedTransporter"
                  .tr); //Berhasil mengirim ulang invited Transporter. Anda dapat mengirim ulang kembali setelah 1 jam
      isLoading.value = true;
      time.cancel();
      getDetail("Kirim Ulang");
    } else {
      Get.back(result: true);
    }
  }
}
