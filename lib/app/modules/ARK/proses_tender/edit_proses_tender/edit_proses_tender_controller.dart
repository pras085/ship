import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:muatmuat/app/modules/ARK/proses_tender/informasi_proses_tender/informasi_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_diumumkan_kepada_tender/list_diumumkan_kepada_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_head_carrier/select_head_carrier_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_rute_tender/select_rute_tender_controller.dart';
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

import 'edit_proses_tender_view.dart';

class EditProsesTenderController extends GetxController {
  var slideIndex = 0.obs;
  var pageController = PageController();
  var title = ''.obs;
  var cekPengisian = false.obs;
  var validasiSimpan = true;
  var aktifPengecekan = true;
  var isLoading = false.obs;
  var save = true;
  var tipeEdit = "";
  var status = "1".obs;

  var dataSebelumnya = "";

  var dateFormat = DateFormat('yyyy-MM-dd kk:mm:ss');

  //First page
  String bullet = '\u2022 ';
  var formOne = GlobalKey<FormState>();
  var idPraTender = "";
  var idTender = "";
  var kodePraTender = "".obs;
  var kodeTender = 'ProsesTenderCreateLabelAutoGenerate'.obs; // autogenerate
  var judulController = TextEditingController();
  var lihattertutup = false.obs;
  var dataTahapTender = [].obs;
  var namaTahapTender = [
    "",
    "ProsesTenderCreateLabelProsesTender", //Info Pra Tender
    "ProsesTenderCreateLabelProsesTender", //Proses Tender
    "ProsesTenderCreateLabelSeleksiPemenang", //Seleksi Pemenang
    "ProsesTenderCreateLabelPengumumanPemenang", //Pengumuman Pemenang
    "ProsesTenderCreateLabelEksekusiTender" //Eksekusi Tender
  ];

  var arrJenisTender = [
    "",
    "ProsesTenderCreateLabelJenisTenderTerbuka",
    "ProsesTenderCreateLabelJenisTenderTertutup",
  ];

  //SEBELUM
  var tanggalDibuat = ''.obs;
  var satuanTender = 2.obs;
  var errorFirstPage = "".obs;
  var errorPesertaTender = "".obs;
  var errorPemenangTender = "".obs;
  var dataSelectedTampil = [].obs;

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

  //SESUDAH
  var judulPraTender = "".obs;
  var namaSatuanTender = ''.obs;
  //SATUAN TENDER
  var arrSatuanTender = [
    "",
    "ProsesTenderDetailLabelBerat".tr, // Berat
    "ProsesTenderDetailLabelUnitTruk".tr, // Unit Truk
    "ProsesTenderDetailVolume".tr, // Volume
  ];
  var jenisTender = 1.obs;
  var tertutupPesertaTender = 0.obs;
  // 0 = jika tidak dipilih
  // 2 = tertutup rute dan harga
  // 3 = tertutup all peserta
  var tertutupPemenangTender = 0.obs;
  // 0 = jika tidak dipilih
  // 2 = tertutup alokasi
  // 3 = tertutup all pemenang

  var cekdaftarpeserta = false.obs;
  var cekdatarutedanhargapenawaran = false.obs;
  var cekdaftarpemenang = false.obs;
  var cekdataalokasipemenang = false.obs;
  //SATUAN TENDER

  //Second page

  //SEBELUM
  var formTwo = GlobalKey<FormState>();
  var muatanController = TextEditingController();
  var jenisMuatan = 0.obs;
  var satuanVolume = 1.obs;
  var satuanMuatan = 1.obs;
  var beratController = TextEditingController();
  var volumeController = TextEditingController();
  var panjangController = TextEditingController();
  var lebarController = TextEditingController();
  var tinggiController = TextEditingController();
  var jumlahKoliController = TextEditingController();
  var errorSecondPage = "".obs;

  //SESUDAH
  var namaMuatan = "".obs;
  var keteranganMuatan = "".obs;
  var keteranganSatuanVolume = "".obs;
  var berat = "".obs;
  var volume = "".obs;
  var dimensiMuatanKoli = "".obs;
  var jumlahKoli = "".obs;

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

  var key1 = GlobalKey();
  var key2 = GlobalKey();
  var key3 = GlobalKey();

  //Third page
  var formThree = GlobalKey<FormState>();
  var dataTrukTender = [].obs; // Map<String,String>
  var dataTrukTenderSebelumnya = [].obs; // Map<String,String>
  var jmlTrukController = [].obs;
  var dataTrukController = [].obs;
  var dataCarrierController = [].obs;
  var errorThirdPage = "".obs;

  //Fourth page
  var formFour = GlobalKey<FormState>();
  var dataRuteTender = [].obs;
  var beratPerRuteController = [].obs;
  var volumePerRuteController = [].obs;
  var jumlahRute = 1.obs;
  var jumlahYangDigunakan = 0.00.obs;
  var errorFourthPage = "".obs;

  //Five page
  var arrJenisFile = [
    "",
    "PDF",
    "DOC/DOCX",
    "ZIP",
  ];
  var formFive = GlobalKey<FormState>();
  var persyaratanController = TextEditingController();
  var catatanTambahanController = TextEditingController();
  var keteranganFormatDokumenController = TextEditingController();
  var catatanPerubahanController = TextEditingController();
  var dataNote = [].obs;
  var dataKualifikasiProsesTender = [].obs;
  var nama_file_sebelumnya = "".obs;
  var nama_file = "".obs;
  var link = "".obs;
  String filePath = "";
  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var errorFormat = "".obs;
  var jenisFile = 0.obs;
  var jumlahPeserta = 0.obs;

  var selectedFile = File("").obs;
  var errorFifthPage = "".obs;
  var persyaratanBaru = false.obs;
  var catatanBaru = false.obs;
  var catatanterisi = false.obs;
  DateTime dateNow;

  var cekLampiran = false;
   var cekEdit = false;

  @override
  Future<void> onInit() async {
    cekLampiran = await SharedPreferencesHelper.getHakAkses(
        "Lihat dan Download File Persyaratan/Lampiran Proses Tender");
    isLoading.value = true;
    dateNow = await GlobalVariable.getDateTimeFromServer(Get.context);
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);
    //SALIN
    if (Get.arguments != null) {
      idPraTender = Get.arguments[0].toString();
      print(idPraTender);
      await getDetail(idPraTender, Get.arguments[1]);
    }
    onSetData("SET");
  }

  void firstPageinit() {
    dataTahapTender.clear();

    dataTahapTender.addAll([
      {
        'tahap_tender': 1,
        'show_first_date': '',
        'show_last_date': '',
        'min_date': '',
        'max_date': '',
        'error_tahap_tender': '',
        'error_min_date':
            '', // untuk error pengecekan tanggal belum diisi / tgl awal lebih kecil dari tgl akhir
        'error_max_date':
            '', // untuk error pengecekan tanggal belum diisi / tgl akhir lebih kecil dari tgl awal periode
      },
      {
        'tahap_tender': 2,
        'show_first_date': '',
        'show_last_date': '',
        'min_date': '',
        'max_date': '',
        'error_tahap_tender': '',
        'error_min_date':
            '', // untuk error pengecekan tanggal belum diisi / tgl awal lebih kecil dari tgl akhir
        'error_max_date':
            '', // untuk error pengecekan tanggal belum diisi / tgl akhir lebih kecil dari tgl awal periode
      },
      {
        'tahap_tender': 3,
        'show_first_date': '',
        'show_last_date': '',
        'min_date': '',
        'max_date': '',
        'error_tahap_tender': '',
        'error_min_date':
            '', // untuk error pengecekan tanggal belum diisi / tgl awal lebih kecil dari tgl akhir
        'error_max_date':
            '', // untuk error pengecekan tanggal belum diisi / tgl akhir lebih kecil dari tgl awal periode
      },
      {
        'tahap_tender': 4,
        'show_first_date': '',
        'show_last_date': '',
        'min_date': '',
        'max_date': '',
        'error_tahap_tender': '',
        'error_min_date':
            '', // untuk error pengecekan tanggal belum diisi / tgl awal lebih kecil dari tgl akhir
        'error_max_date':
            '', // untuk error pengecekan tanggal belum diisi / tgl akhir lebih kecil dari tgl awal periode
      }
    ]);
  }

  void secondPageinit() {}

  void thirdPageinit() {
    dataTrukTender.clear();
    dataTrukController.clear();
    dataCarrierController.clear();
    jmlTrukController.clear();

    dataTrukTender.addAll([
      {
        'truck_id': 0,
        'jenis_truk': 0,
        'jenis_carrier': 0,
        'nama_truk': '',
        'nama_carrier': '',
        'deskripsi': '-',
        'gambar_truk': '',
        'jumlah_truck': 0,
        'error': '', // Untuk error jika ada truk dan carrier yang kembar
        'jmlerror': '', // untuk error jika jumlah tidak diisi atau bernilai 0
      }
    ]);

    dataTrukController.addAll([TextEditingController(text: '')]);
    dataCarrierController.addAll([TextEditingController(text: '')]);
    jmlTrukController.addAll([TextEditingController(text: '0')]);
  }

  void fourthPageinit() {
    jumlahRute.value = 1;
    dataRuteTender.clear();
    beratPerRuteController.clear();
    volumePerRuteController.clear();

    dataRuteTender.addAll([
      {
        'pickup': '',
        'destinasi': '',
        'data': [
          {
            'jenis_truk': 0,
            'nama_truk': '',
            'jenis_carrier': 0,
            'nama_carrier': '',
            'nilai': (satuanTender.value != 2 ? 0.0 : 0),
            'error': ''
          }
        ],
        'error_pickup': '',
        'error_destinasi': '',
        'error_lokasi_kembar': '',
      },
      {
        'pickup': '',
        'destinasi': '',
        'data': [
          {
            'jenis_truk': 0,
            'nama_truk': '',
            'jenis_carrier': 0,
            'nama_carrier': '',
            'nilai': (satuanTender.value != 2 ? 0.0 : 0),
            'error': ''
          }
        ],
        'error_pickup': '',
        'error_destinasi': '',
        'error_lokasi_kembar': '',
      },
      {
        'pickup': '',
        'destinasi': '',
        'data': [
          {
            'jenis_truk': 0,
            'nama_truk': '',
            'jenis_carrier': 0,
            'nama_carrier': '',
            'nilai': (satuanTender.value != 2 ? 0.0 : 0),
            'error': ''
          }
        ],
        'error_pickup': '',
        'error_destinasi': '',
        'error_lokasi_kembar': '',
      }
    ]);

    beratPerRuteController.addAll([
      TextEditingController(text: ''),
      TextEditingController(text: ''),
      TextEditingController(text: '')
    ]);
    volumePerRuteController.addAll([
      TextEditingController(text: ''),
      TextEditingController(text: ''),
      TextEditingController(text: '')
    ]);

    hitungTotalYangDigunakan(false);
  }

  void fifthPageinit() {}

  void ubahSatuanTender() {
    thirdPageinit();

    beratPerRuteController.clear();
    volumePerRuteController.clear();

    for (var x = 0; x < dataRuteTender.length; x++) {
      var listJson = [
        {
          'jenis_truk': 0,
          'nama_truk': '',
          'jenis_carrier': 0,
          'nama_carrier': '',
          'nilai': (satuanTender.value != 2 ? 0.0 : 0),
          'error': ''
        }
      ];

      dataRuteTender[x]['data'] = listJson;
    }

    beratPerRuteController.addAll([
      TextEditingController(text: ''),
      TextEditingController(text: ''),
      TextEditingController(text: '')
    ]);

    volumePerRuteController.addAll([
      TextEditingController(text: ''),
      TextEditingController(text: ''),
      TextEditingController(text: '')
    ]);

    hitungTotalYangDigunakan(false);
  }

  Future getDetail(String idtrans, int halaman,
      {String jenisTransaksi = "TD"}) async {
    isLoading.value = true;
    String id = await SharedPreferencesHelper.getUserShipperID();

    var result;
    print('ID TENDER');
    print(idtrans);
    result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDetailProsesTender(id, idtrans);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      print("TANGGAL TAHAP TENDER");
      print(data['tahap_tender'][1]['tanggal_dimulai']);
      print(DateTime.parse(data['tahap_tender'][1]['tanggal_dimulai']));

      idTender = data['ID'].toString();
      kodeTender.value = data['kode_td'];
      idPraTender = data['info_pratenderID'].toString();
      kodePraTender.value = data['kode_pratender'];
      tanggalDibuat.value = data['TanggalDibuat'];
      selectedFile.value = null;
      updateTitle();

      jenisTender.value = data['jenis_tender'];
      tertutupPesertaTender.value = data['detail_jenis_tender_peserta'];
      tertutupPemenangTender.value = data['detail_jenis_tender_pemenang'];
      cekCheckboxButtonPeserta();
      cekCheckboxButtonPemenang();

      for (var x = 0; x < data['tahap_tender'].length; x++) {
        if (data['tahap_tender'][x]['tahap_tender'] == 2) {
          if (DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai'])
                  .compareTo(await GlobalVariable.getDateTimeFromServer(
                      Get.context)) <=
              0) {
            tipeEdit = "SEKARANG";
          } else if (DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai'])
                  .compareTo(
                      await GlobalVariable.getDateTimeFromServer(Get.context)) >
              0) {
            tipeEdit = "SEBELUM";
          }
        }
      }

      await firstPageinit();

      print("Tipe : " + tipeEdit);

      var countTahapTender = 0;
      for (var x = 0; x < data['tahap_tender'].length; x++) {
        if (data['tahap_tender'][x]['tahap_tender'] == 5) {
          print(5);
          dataTahapTender.add({
            'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
            'show_first_date': data['tahap_tender'][x]
                ['tanggal_dimulai_format_new'],
            'show_last_date': data['tahap_tender'][x]
                ['tanggal_akhir_format_new'],
            'min_date':
                DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai']),
            'max_date':
                DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']),
            'error_tahap_tender': '',
            'error_min_date':
                '', // untuk error pengecekan tanggal belum diisi / tgl awal lebih kecil dari tgl akhir
            'error_max_date':
                '', // untuk error pengecekan tanggal belum diisi / tgl akhir lebih kecil dari tgl awal periode
          });
        } else {
          //JIKA TIDAK ADA INFO PRA TENDER, TAMBAHKAN SAJA
          if (data['tahap_tender'][x]['tahap_tender'] != 1 && x == 0) {
            print(2);
            dataTahapTender[countTahapTender] = {
              'tahap_tender': 1,
              'show_first_date': '',
              'show_last_date': '',
              'min_date': '',
              'max_date': '',
              'error_tahap_tender': '',
              'error_min_date':
                  '', // untuk error pengecekan tanggal belum diisi / tgl awal lebih kecil dari tgl akhir
              'error_max_date':
                  '', // untuk error pengecekan tanggal belum diisi / tgl akhir lebih kecil dari tgl awal periode
            };
            countTahapTender++;
            dataTahapTender[countTahapTender] = {
              'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
              'show_first_date': data['tahap_tender'][x]
                  ['tanggal_dimulai_format_new'],
              'show_last_date': data['tahap_tender'][x]
                  ['tanggal_akhir_format_new'],
              'min_date':
                  DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai']),
              'max_date':
                  DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']),
              'error_tahap_tender': '',
              'error_min_date':
                  '', // untuk error pengecekan tanggal belum diisi / tgl awal lebih kecil dari tgl akhir
              'error_max_date':
                  '', // untuk error pengecekan tanggal belum diisi / tgl akhir lebih kecil dari tgl awal periode
            };
          } else {
            // JIKA DIA INFO PRA TENDER KOSONGI SAJA TANGGALNYA
            if (data['tahap_tender'][x]['tahap_tender'] != 1) {
              print(3);
              dataTahapTender[countTahapTender] = {
                'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
                'show_first_date': data['tahap_tender'][x]
                    ['tanggal_dimulai_format_new'],
                'show_last_date': data['tahap_tender'][x]
                    ['tanggal_akhir_format_new'],
                'min_date':
                    DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai']),
                'max_date':
                    DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']),
                'error_tahap_tender': '',
                'error_min_date':
                    '', // untuk error pengecekan tanggal belum diisi / tgl awal lebih kecil dari tgl akhir
                'error_max_date':
                    '', // untuk error pengecekan tanggal belum diisi / tgl akhir lebih kecil dari tgl awal periode
              };
            } else {
              print(1);
              dataTahapTender[countTahapTender] = {
                'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
                'show_first_date': '',
                'show_last_date': '',
                'min_date': '',
                'max_date': '',
                'error_tahap_tender': '',
                'error_min_date':
                    '', // untuk error pengecekan tanggal belum diisi / tgl awal lebih kecil dari tgl akhir
                'error_max_date':
                    '', // untuk error pengecekan tanggal belum diisi / tgl akhir lebih kecil dari tgl awal periode
              };
            }
          }
          countTahapTender++;
        }
      }

      print("TAHAP");
      print(dataTahapTender);

      dataTahapTender.refresh();
      dataGroup.clear();
      dataMitraTransporter.clear();
      dataEmail.clear();

      var dataGroupTemp = [];
      var dataMitraTransporterTemp = [];
      var dataEmailTemp = [];

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
            dataGroupTemp.add({
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
            dataMitraTransporterTemp.add({
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
            dataMitraTransporterTemp.add({
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
            dataEmailTemp.add({
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

      print('ALL');
      print(dataAll);
      print('GROUP');
      print(dataGroupTemp);
      print('MITRA TRANSPORTER');
      print(dataMitraTransporterTemp);
      print('EMAIL');
      print(dataEmailTemp);

      await getDataTransporter(
          dataGroupTemp, dataMitraTransporterTemp, dataEmailTemp);

      if (tipeEdit == "SEBELUM" && dataEmail.length == 0) {
        dataEmail.addAll([
          {
            'ismitra': 0,
            'isgroup': 0,
            'invited_email': 1,
            'id': "0",
            'name': "",
            'image': "",
            'select': false,
            'urutan': 0,
          }
        ]);
      }

      judulController.text = data['judul'];

      satuanTender.value = data['satuan_tender'];

      namaSatuanTender.value = arrSatuanTender[satuanTender.value];

      //SESUDAH
      judulPraTender.value = data['judul'];

      //SECOND PAGE
      print("SECOND PAGE");

      //SEBELUM
      muatanController.text = data['nama_muatan'];

      jenisMuatan.value = data['jenis_muatan'];

      beratController.text =
          GlobalVariable.formatCurrencyDecimal(data['berat'].toString()) == "0"
              ? ""
              : GlobalVariable.formatCurrencyDecimal(data['berat'].toString());

      satuanVolume.value = data['satuan_volume'];

      volumeController.text =
          GlobalVariable.formatCurrencyDecimal(data['volume'].toString()) == "0"
              ? ""
              : GlobalVariable.formatCurrencyDecimal(data['volume'].toString());

      panjangController.text = GlobalVariable.formatCurrencyDecimal(
                  data['dimensi_p'].toString()) ==
              "0"
          ? ""
          : GlobalVariable.formatCurrencyDecimal(data['dimensi_p'].toString());

      lebarController.text = GlobalVariable.formatCurrencyDecimal(
                  data['dimensi_l'].toString()) ==
              "0"
          ? ""
          : GlobalVariable.formatCurrencyDecimal(data['dimensi_l'].toString());

      tinggiController.text = GlobalVariable.formatCurrencyDecimal(
                  data['dimensi_t'].toString()) ==
              "0"
          ? ""
          : GlobalVariable.formatCurrencyDecimal(data['dimensi_t'].toString());

      satuanMuatan.value = data['satuan_dimensi'];

      jumlahKoliController.text = GlobalVariable.formatCurrencyDecimal(
                  data['jumlah_koli'].toString()) ==
              "0"
          ? ""
          : GlobalVariable.formatCurrencyDecimal(
              data['jumlah_koli'].toString());

      //SESUDAH
      namaMuatan.value = data['nama_muatan'];
      keteranganMuatan.value = arrJenisMuatan[data['jenis_muatan']];
      berat.value =
          GlobalVariable.formatCurrencyDecimal(data['berat'].toString()) +
              " Ton";
      if (GlobalVariable.formatCurrencyDecimal(data['berat'].toString()) ==
          "0") {
        berat.value = "-";
      }
      keteranganSatuanVolume.value = arrSatuanVolume[data['satuan_volume']];
      volume.value =
          GlobalVariable.formatCurrencyDecimal(data['volume'].toString()) +
              " " +
              keteranganSatuanVolume.value;

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
          (GlobalVariable.formatCurrencyDecimal(data['dimensi_l'].toString()) ==
                  "0"
              ? "-"
              : GlobalVariable.formatCurrencyDecimal(
                  data['dimensi_l'].toString())) +
          ' ' +
          arrSatuanDimensi[data['satuan_dimensi']] +
          " x " +
          (GlobalVariable.formatCurrencyDecimal(data['dimensi_t'].toString()) ==
                  "0"
              ? "-"
              : GlobalVariable.formatCurrencyDecimal(
                  data['dimensi_t'].toString())) +
          ' ' +
          arrSatuanDimensi[data['satuan_dimensi']];

      if (GlobalVariable.formatCurrencyDecimal(
                  data['dimensi_p'].toString()) ==
              "0" &&
          GlobalVariable.formatCurrencyDecimal(data['dimensi_l'].toString()) ==
              "0" &&
          GlobalVariable.formatCurrencyDecimal(data['dimensi_t'].toString()) ==
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
      dataTrukTender.clear();
      dataTrukController.clear();
      dataCarrierController.clear();
      jmlTrukController.clear();

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
          'error': '',
          'jmlerror': ''
        });

        dataTrukController.add(TextEditingController(
            text: data['unit_truk'][x]['jenis_truk_raw']));
        dataCarrierController.add(TextEditingController(
            text: data['unit_truk'][x]['jenis_carrier_raw']));
        jmlTrukController.add(TextEditingController(
            text: GlobalVariable.formatCurrencyDecimal(
                data['unit_truk'][x]['jumlah'].toString())));
      }

      dataTrukTender.refresh();
      dataTrukController.refresh();
      dataCarrierController.refresh();
      jmlTrukController.refresh();

      dataTrukTenderSebelumnya.value =
          json.decode(json.encode(dataTrukTender.value));

      //Fourth page

      print("FOURTH PAGE");

      fourthPageinit();

      jumlahRute.value = data['rute'].length;
      print(data['rute']);
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
              'nama_truk': data['rute'][x]['child'][y]['nama_truk'],
              'jenis_carrier': data['rute'][x]['child'][y]['jenis_carrier'],
              'nama_carrier': data['rute'][x]['child'][y]['nama_carrier'],
              'nilai': data['rute'][x]['child'][y]['nilai'],
              'error': ''
            });

            if (satuanTender.value == 1) {
              beratPerRuteController[x].text =
                  GlobalVariable.formatCurrencyDecimal(
                      ListTruk[ListTruk.length - 1]['nilai'].toString());
            }

            if (satuanTender.value == 3) {
              volumePerRuteController[x].text =
                  GlobalVariable.formatCurrencyDecimal(
                      ListTruk[ListTruk.length - 1]['nilai'].toString());
            }
          }
        }

        dataRuteTender[x]['pickup'] = data['rute'][x]['pickup'];

        dataRuteTender[x]['destinasi'] = data['rute'][x]['destinasi'];

        dataRuteTender[x]['data'] = ListTruk;
      }
      print("RUTE");
      print(dataRuteTender);

      hitungTotalYangDigunakan(false);

      dataRuteTender.refresh();
      beratPerRuteController.refresh();
      volumePerRuteController.refresh();

      print("FIFTH PAGE");

      dataNote.clear();
      dataKualifikasiProsesTender.clear();

      for (var x = 0; x < data['notes'].length; x++) {
        if (tipeEdit == "SEBELUM") {
          catatanTambahanController.text +=
              data['notes'][x]['Content'].replaceAll("<br>", "\n") ?? "";
        } else {
          dataNote.add({
            'tglDibuat': data['notes'][x]['TanggalDibuat'] ?? "",
            'isi': data['notes'][x]['Content'].replaceAll("<br>", "\n") ?? "",
            'no': data['notes'][x]['Urut'] ?? "",
          });
        }
      }

      for (var x = 0; x < data['kualifikasi_proses_tender'].length; x++) {
        if (tipeEdit == "SEBELUM") {
          persyaratanController.text += data['kualifikasi_proses_tender'][x]
                      ['detail']
                  .replaceAll("<br>", "\n") ??
              "";
        } else {
          dataKualifikasiProsesTender.add({
            'tglDibuat':
                data['kualifikasi_proses_tender'][x]['TanggalDibuat'] ?? "",
            'isi': data['kualifikasi_proses_tender'][x]['detail']
                    .replaceAll("<br>", "\n") ??
                "",
          });
        }
      }

      if (data['lampiran']['FileName'] != null) {
        nama_file.value = data['lampiran']['FileName'].split("/").last ?? "";
        nama_file_sebelumnya.value =
            data['lampiran']['FileName'].split("/").last ?? "";
        link.value = data['lampiran']['Link'] ?? "";
      }

      jenisFile.value = data['format_dokumen'];
      keteranganFormatDokumenController.text = data['format_dokumen_desc'];
      jumlahPeserta.value = data['jumlah_peserta'];

      status.value = data['status'].toString();
      isLoading.value = false;

      setHalaman(halaman);
    }
  }

  void setHalaman(halaman) async {
    pageController = new PageController(initialPage: halaman);
    slideIndex.value = halaman;
    updateTitle();
  }

  void getDataTransporter(
      dataGroupTemp, dataMitraTransporterTemp, dataEmailTemp) async {
    String shipperID = await SharedPreferencesHelper.getUserShipperID();
    var result =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .listTransporterMitraGroup(shipperID);
    if (result['Message']['Code'].toString() == '200') {
      var dataTransporterMitraGroup = result['Data'];

      //MASUKAN API KE ARRAY
      for (var x = 0; x < dataTransporterMitraGroup.length; x++) {
        dataGroup.add({
          'ismitra': 0,
          'isgroup': 1,
          'invited_email': 0,
          'id': dataTransporterMitraGroup[x]['GroupID'].toString(),
          'name': dataTransporterMitraGroup[x]['Name'],
          'image': dataTransporterMitraGroup[x]['Avatar'],
          'select': false,
          'data': dataTransporterMitraGroup[x]['Mitra'],
          'urutan': 0,
        });
      }

      result = await ApiHelper(context: Get.context, isShowDialogLoading: false)
          .listTransporterSaja(shipperID);

      if (result['Message']['Code'].toString() == '200') {
        var dataTransporterSaja = result['Data'];

        //MASUKAN API KE ARRAY
        for (var x = 0; x < dataTransporterSaja.length; x++) {
          var id = dataTransporterSaja[x]['TransporterID'];

          if (dataTransporterSaja[x]['MitraID'] != 0) {
            id = dataTransporterSaja[x]['MitraID'];
          }

          dataMitraTransporter.add({
            'ismitra': dataTransporterSaja[x]['IsMitra'],
            'isgroup': 0,
            'invited_email': 0,
            'id': id.toString(),
            'name': dataTransporterSaja[x]['Name'],
            'image': dataTransporterSaja[x]['Avatar'],
            'select': false,
            'urutan': 0,
          });
        }

        //GROUP
        for (var x = 0; x < dataGroup.length; x++) {
          for (var y = 0; y < dataGroupTemp.length; y++) {
            if (dataGroup[x]['id'] == dataGroupTemp[y]['id']) {
              dataGroup[x]['select'] = dataGroupTemp[y]['select'];
              dataGroup[x]['urutan'] = dataGroupTemp[y]['urutan'];
            }
          }
        }

        //MITRA TRANSPORTER
        for (var x = 0; x < dataMitraTransporter.length; x++) {
          for (var y = 0; y < dataMitraTransporterTemp.length; y++) {
            if (dataMitraTransporter[x]['id'] ==
                dataMitraTransporterTemp[y]['id']) {
              dataMitraTransporter[x]['select'] =
                  dataMitraTransporterTemp[y]['select'];

              dataMitraTransporter[x]['urutan'] =
                  dataMitraTransporterTemp[y]['urutan'];
            }
          }
        }

        //JIKA ALL MITRA
        if (dataAll[1]['select']) {
          print('ALL TRANSPORTER');
          for (var y = 0; y < dataGroup.length; y++) {
            dataGroup[y]['select'] = true;
            dataGroup[y]['urutan'] = dataAll[1]['urutan'];
          }

          for (var y = 0; y < dataMitraTransporter.length; y++) {
            dataMitraTransporter[y]['select'] = true;
            dataMitraTransporter[y]['urutan'] = dataAll[1]['urutan'];
          }
        } else if (dataAll[0]['select']) {
          print('ALL MITRA');
          for (var y = 0; y < dataGroup.length; y++) {
            dataGroup[y]['select'] = true;
            dataGroup[y]['urutan'] = dataAll[0]['urutan'];
          }

          for (var y = 0; y < dataMitraTransporter.length; y++) {
            if (dataMitraTransporter[y]['ismitra'] == 1) {
              dataMitraTransporter[y]['select'] = true;
              dataMitraTransporter[y]['urutan'] = dataAll[0]['urutan'];
            }
          }
        }

        dataEmail.clear();

        //EMAIL
        for (var x = 0; x < dataEmailTemp.length; x++) {
          dataEmail.add({
            'ismitra': 0,
            'isgroup': 0,
            'invited_email': 1,
            'id': "0",
            'name': dataEmailTemp[x]['name'],
            'image': "",
            'select': false,
            'urutan': dataEmailTemp[x]['urutan'],
          });
        }

        print('ALL API');
        print(dataAll);
        print('GROUP API');
        print(dataGroup);
        print('MITRA TRANSPORTER API');
        print(dataMitraTransporter);
        print('EMAIL API');
        print(dataEmail);

        collectData();
      }
    }
  }

  void updateTitle() {
    if (satuanTender == 2) {
      switch (slideIndex.value) {
        case 0:
          {
            title.value =
                'ProsesTenderCreateLabelDataProsesTender'; //'Data Proses Tender'
            break;
          }
        case 1:
          {
            title.value = 'ProsesTenderCreateLabelDataMuatan'; //Data Muatan
            break;
          }
        case 2:
          {
            title.value = 'ProsesTenderCreateLabelDataTender'; //'Data Tender'
            break;
          }
        case 3:
          {
            title.value =
                'ProsesTenderCreateLabelRuteYangDitenderkan'; // Rute Yang Ditenderkan
            break;
          }
        case 4:
          {
            title.value = 'ProsesTenderCreateLabelPersyaratanKualifikasi'
                .tr; // Syarat dan Ketentuan
            break;
          }
      }
    } else {
      switch (slideIndex.value) {
        case 0:
          {
            title.value =
                'ProsesTenderCreateLabelDataProsesTender'; //'Data Proses Tender'
            break;
          }
        case 1:
          {
            title.value = 'ProsesTenderCreateLabelDataMuatan'; //Data Muatan
            break;
          }
        case 2:
          {
            title.value =
                'ProsesTenderCreateLabelRuteYangDitenderkan'; // Rute Yang Ditenderkan
            break;
          }
        case 3:
          {
            title.value = 'ProsesTenderCreateLabelPersyaratanKualifikasi'
                .tr; // Syarat dan Ketentuan
            break;
          }
      }
    }
  }

  void checkImage(index) async {
    if (dataTrukTender[index]['jenis_truk'] != 0 &&
        dataTrukTender[index]['jenis_carrier'] != 0) {
      var result =
          await ApiHelper(context: Get.context, isShowDialogLoading: false)
              .getSpecificTruck(dataTrukTender[index]['jenis_truk'].toString(),
                  dataTrukTender[index]['jenis_carrier'].toString());
      if (result["Data"].isNotEmpty) print(result["Data"]);
      dataTrukTender[index]['gambar_truk'] = result["Data"]["TruckURL"];
      dataTrukTender[index]['truck_id'] = result["Data"]["TruckID"];
      dataTrukTender[index]['deskripsi'] =
          (result["Data"]["tonase"] ?? "-").toString() +
              " / " +
              (result["Data"]["Length"] ?? "-").toString() +
              " x " +
              (result["Data"]["Width"] ?? "-").toString() +
              " x " +
              (result["Data"]["Height"] ?? "-").toString() +
              " / " +
              (result["Data"]["Volume"] ?? "-").toString();
    } else {
      dataTrukTender[index]['gambar_truk'] = "";
      dataTrukTender[index]['truck_id'] = 0;
      dataTrukTender[index]['deskripsi'] = "-";
    }

    dataTrukTender.refresh();
  }

  @override
  void onReady() {}

  void onSetData(String tipe) async {
    //DIUMUMKAN KEPADA
    var dataTransporterTenderSave = {
      "all": [],
      "group": [],
      "mitra": [],
      "transporter": [],
    };
    //CEK DATA ALL
    for (var x = 0; x < dataAll.length; x++) {
      if (dataAll[x]['select']) {
        dataTransporterTenderSave["all"].add(dataAll[x]['id']);
      }
    }
    //CEK DATA GROUP, DAN JIKA SEMUA TRANSPORTER DAN MITRA TIDAK DICENTANG
    for (var x = 0; x < dataGroup.length; x++) {
      if (dataGroup[x]['select'] &&
          dataAll[0]['select'] == false &&
          dataAll[1]['select'] == false) {
        dataTransporterTenderSave["group"].add(dataGroup[x]['id']);
      }
    }
    //CEK DATA MITRA dan TRANSPORTER,
    //JIKA MITRA, SEMUA TRANSPORTER DAN SEMUA MITRA TIDAK DICENTANG
    //JIKA TRANSPORTER, dan SEMUA TRANSPORTER TIDAK DICENTANG
    for (var x = 0; x < dataMitraTransporter.length; x++) {
      if (dataMitraTransporter[x]['select'] &&
          dataMitraTransporter[x]['ismitra'] == 1 &&
          dataAll[0]['select'] == false &&
          dataAll[1]['select'] == false) {
        bool cekAdaMitra = false;
        //CEK LAGI JIKA DIA MITRA YANG SUDAH TERGABUNG DI GROUP YANG TERCENTANG JANGAN DIMASUKAN

        for (var x1 = 0; x1 < dataGroup.length; x1++) {
          if (dataGroup[x1]['select']) {
            for (var y1 = 0; y1 < dataGroup[x1]['data'].length; y1++) {
              if (dataGroup[x1]['data'][y1]['MitraID'].toString() ==
                  dataMitraTransporter[x]['id']) {
                cekAdaMitra = true;
              }
            }
          }
        }

        if (!cekAdaMitra) {
          dataTransporterTenderSave["mitra"].add(dataMitraTransporter[x]['id']);
        }
      } else if (dataMitraTransporter[x]['select'] &&
          dataMitraTransporter[x]['ismitra'] == 0 &&
          dataAll[1]['select'] == false) {
        dataTransporterTenderSave["transporter"]
            .add(dataMitraTransporter[x]['id']);
      }
    }
    var dataInvitedEmailSave = [];
    //CEK DATA EMAIL INVITATION
    for (var x = 0; x < dataEmail.length; x++) {
      dataInvitedEmailSave.add(dataEmail[x]['name']);
    }
    //DIUMUMKAN KEPADA
    var dataTahapTenderSave = [];
    for (var x = 1; x < dataTahapTender.length; x++) {
      var data = {
        'tahap_tender': dataTahapTender[x]['tahap_tender'].toString(),
        'min_date': dataTahapTender[x]['min_date'].toString().split(" ")[0],
        'max_date': dataTahapTender[x]['max_date'].toString().split(" ")[0],
      };
      dataTahapTenderSave.add(data);
    }
    var dataTrukTenderSave = [];
    for (var x = 0; x < dataTrukTender.length; x++) {
      var data = {
        'jumlah_truck': dataTrukTender[x]['jumlah_truck'].toString(),
        'jenis_truk': dataTrukTender[x]['jenis_truk'].toString(),
        'jenis_carrier': dataTrukTender[x]['jenis_carrier'].toString(),
        'truck_id': dataTrukTender[x]['truck_id'].toString(),
      };

      dataTrukTenderSave.add(data);
    }

    var dataRuteTenderSave = [];
    //DIAMBIL DARI JUMLAH RUTE SAJA
    for (var x = 0; x < jumlahRute.value; x++) {
      var rute = [];
      for (var y = 0; y < dataRuteTender[x]['data'].length; y++) {
        var dataDetail;
        //KARENA UNIT TRUK ITU INTEGER, JADI DIBEDAKAN NILAINYA
        if (satuanTender.value == 2) {
          if (dataRuteTender[x]['data'][y]['nilai'].toString() != "") {
            if (dataRuteTender[x]['data'][y]['nilai'] > 0) {
              dataDetail = {
                'jenis_truck':
                    dataRuteTender[x]['data'][y]['jenis_truk'].toString(),
                'jenis_carrier':
                    dataRuteTender[x]['data'][y]['jenis_carrier'].toString(),
                'nilai': dataRuteTender[x]['data'][y]['nilai'],
              };
            }
          }
        } else {
          dataDetail = {
            'jenis_truck':
                dataRuteTender[x]['data'][y]['jenis_truk'].toString(),
            'jenis_carrier':
                dataRuteTender[x]['data'][y]['jenis_carrier'].toString(),
            'nilai': GlobalVariable.formatCurrency(
                dataRuteTender[x]['data'][y]['nilai'].toString(), 3),
          };
        }

        if (dataDetail != null) {
          rute.add(dataDetail);
        }
      }

      var data = {
        'pickup': dataRuteTender[x]['pickup'].toString(),
        'destinasi': dataRuteTender[x]['destinasi'].toString(),
        'data': rute,
      };

      dataRuteTenderSave.add(data);
    }

    if (tipe == "SAVE" && save) {
      save = false;

      showDialog(
          context: Get.context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          });
      // showDialog(
      //     context: Get.context,
      //     barrierDismissible: true,
      //     builder: (BuildContext context) {
      //       return WillPopScope(
      //           onWillPop: () {},
      //           child: Center(child: CircularProgressIndicator()));
      //     });

      String shipperID = await SharedPreferencesHelper.getUserShipperID();

      var result = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .editProsestender(
              tipeEdit,
              idTender,
              status.value,
              shipperID,
              judulController.text,
              satuanTender.toString(),
              muatanController.text,
              jenisMuatan.toString(),
              beratController.text,
              volumeController.text,
              satuanVolume.toString(),
              panjangController.text,
              lebarController.text,
              tinggiController.text,
              satuanMuatan.toString(),
              jumlahKoliController.text,
              jumlahRute.toString(),
              persyaratanController.text,
              nama_file == nama_file_sebelumnya ? "" : nama_file.value,
              catatanTambahanController.text,
              catatanPerubahanController.value.text,
              dataTransporterTenderSave,
              dataInvitedEmailSave,
              dataTahapTenderSave,
              dataTrukTenderSave,
              dataRuteTenderSave,
              selectedFile.value,
              idPraTender,
              jenisTender.value.toString(),
              tertutupPesertaTender.value.toString(),
              tertutupPemenangTender.value.toString(),
              jenisFile.value.toString(),
              keteranganFormatDokumenController.text);

      if (result['Message']['Code'].toString() == '200') {
        print("BERHASIL SIMPAN");

        if (nama_file.value == "") {
          hapusFileTender();
        } else {
          Get.back();
          Get.back(result: true);

          CustomToast.show(
              context: Get.context,
              message: "ProsesTenderEditNotifikasiBerhasilMenyimpan".tr);
        }
      } else {
        save = true;
        Get.back();
      }
    } else if (tipe == "SET") {
      dataSebelumnya = (judulController.text +
          satuanTender.toString() +
          muatanController.text +
          jenisMuatan.toString() +
          beratController.text +
          volumeController.text +
          satuanVolume.toString() +
          panjangController.text +
          lebarController.text +
          tinggiController.text +
          satuanMuatan.toString() +
          jumlahKoliController.text +
          jumlahRute.toString() +
          persyaratanController.text +
          nama_file.value +
          catatanTambahanController.text +
          catatanPerubahanController.text +
          jsonEncode(dataTransporterTenderSave) +
          jsonEncode(dataInvitedEmailSave) +
          jsonEncode(dataTahapTenderSave) +
          jsonEncode(dataTrukTenderSave) +
          jsonEncode(dataRuteTenderSave) +
          idPraTender +
          jenisTender.value.toString() +
          tertutupPesertaTender.value.toString() +
          tertutupPemenangTender.value.toString() +
          jenisFile.value.toString() +
          keteranganFormatDokumenController.text);

      print("SET");
      print(dataSebelumnya);
    } else if (tipe == "COMPARE") {
      var dataSekarang = (judulController.text +
          satuanTender.toString() +
          muatanController.text +
          jenisMuatan.toString() +
          beratController.text +
          volumeController.text +
          satuanVolume.toString() +
          panjangController.text +
          lebarController.text +
          tinggiController.text +
          satuanMuatan.toString() +
          jumlahKoliController.text +
          jumlahRute.toString() +
          persyaratanController.text +
          nama_file.value +
          catatanTambahanController.text +
          catatanPerubahanController.text +
          jsonEncode(dataTransporterTenderSave) +
          jsonEncode(dataInvitedEmailSave) +
          jsonEncode(dataTahapTenderSave) +
          jsonEncode(dataTrukTenderSave) +
          jsonEncode(dataRuteTenderSave) +
          idPraTender +
          jenisTender.value.toString() +
          tertutupPesertaTender.value.toString() +
          tertutupPemenangTender.value.toString() +
          jenisFile.value.toString() +
          keteranganFormatDokumenController.text);

      print("COMPARE");
      print("SEBELUMNYA");
      print(dataSebelumnya.length);
      print(dataSebelumnya);
      print("SEKARANGNYA");
      print(dataSekarang.length);
      print(dataSekarang);

      if (dataSekarang.toString() != dataSebelumnya.toString()) {
        print('POPUP KELUAR');
        GlobalAlertDialog.showAlertDialogCustom(
            context: Get.context,
            title: "ProsesTenderCreateLabelInfoKonfirmasiPembatalan"
                .tr, //Konfirmasi Pembatalan
            message: "ProsesTenderCreateLabelInfoApakahAndaYakinInginKembali"
                    .tr +
                "\n" +
                "ProsesTenderCreateLabelInfoDataTidakDisimpan"
                    .tr, //Apakah anda yakin ingin kembali? Data yang telah diisi tidak akan disimpan
            labelButtonPriority1: GlobalAlertDialog.noLabelButton,
            onTapPriority1: () {},
            onTapPriority2: () async {
              Get.back();
            },
            labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
      } else {
        print('LANGSUNG KELUAR');
        Get.back();
      }
    } else if (tipe == "COMPAREMASATENDER") {
      var dataSekarang = (judulController.text +
          satuanTender.toString() +
          muatanController.text +
          jenisMuatan.toString() +
          beratController.text +
          volumeController.text +
          satuanVolume.toString() +
          panjangController.text +
          lebarController.text +
          tinggiController.text +
          satuanMuatan.toString() +
          jumlahKoliController.text +
          jumlahRute.toString() +
          persyaratanController.text +
          nama_file.value +
          catatanTambahanController.text +
          catatanPerubahanController.text +
          jsonEncode(dataTransporterTenderSave) +
          jsonEncode(dataInvitedEmailSave) +
          jsonEncode(dataTahapTenderSave) +
          jsonEncode(dataTrukTenderSave) +
          jsonEncode(dataRuteTenderSave) +
          idPraTender +
          jenisTender.value.toString() +
          tertutupPesertaTender.value.toString() +
          tertutupPemenangTender.value.toString() +
          jenisFile.value.toString() +
          keteranganFormatDokumenController.text);

      print("COMPAREMASATENDER");
      print("SEBELUMNYA");
      print(dataSebelumnya.length);
      print(dataSebelumnya);
      print("SEKARANGNYA");
      print(dataSekarang.length);
      print(dataSekarang);

      if (dataSekarang.toString() != dataSebelumnya.toString()) {
        catatanPerubahanController.clear();
        catatanterisi.value = false;
        GlobalAlertDialog.showAlertDialogCustom(
            context: Get.context,
            title: "ProsesTenderCreateLabelInfoKonfirmasiPerubahan"
                .tr, //Konfirmasi Perubahan
            customMessage: Column(children: [
              CustomText(
                  "ProsesTenderEditLabelInputPesanPerubahanData"
                      .tr, //Mohon inputkan pesan perubahan data kepada peserta tender
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  color: Colors.black,
                  height: 1.2,
                  fontWeight: FontWeight.w500),
              SizedBox(
                height: GlobalVariable.ratioWidth(Get.context) * 12,
              ),
              CustomTextFormField(
                context: Get.context,
                newContentPadding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                  //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                ),
                textSize: 14,
                maxLines: 5,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorLightGrey4),
                ),
                onChanged: (value) {
                  if (value == "") {
                    catatanterisi.value = false;
                  } else {
                    catatanterisi.value = true;
                  }
                },
                newInputDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 12),
                  suffix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 12),
                  isDense: true,
                  isCollapsed: true,
                  hintText:
                      "ProsesTenderEditLabelPlaceholderContohTerjadiPerubahanTender"
                          .tr,
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey2),
                  ),
                ),
                controller: catatanPerubahanController,
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              Obx(() => FlatButton(
                    color: catatanterisi.value
                        ? Color(ListColor.color4)
                        : Color(ListColor.colorLightGrey2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 20)),
                    ),
                    child: Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 100,
                      padding: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: Stack(alignment: Alignment.center, children: [
                        CustomText("",
                            fontWeight: FontWeight.w600,
                            color: Colors.transparent),
                        CustomText(
                            "ProsesTenderEditStatusProsesTenderSimpan".tr,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ]),
                    ),
                    onPressed: () {
                      if (catatanterisi.value) {
                        Get.back();
                        onSetData("SAVE");
                      }
                    },
                  ))
            ]),
            isShowButton: false);
      } else {
        onSetData("SAVE");
      }
    }
  }

  void hapusFileTender() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .hapusFileProsesTender(idTender);

    if (result['Message']['Code'].toString() == '200') {
      Get.back();
      Get.back(result: true);

      CustomToast.show(
          context: Get.context,
          message: "ProsesTenderEditNotifikasiBerhasilMenyimpan"
              .tr); //Berhasil menyimpan data yang telah diedit

    }
  }

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
              height: 1.6)
          : Row(children: [
              CustomText(".... ",
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.6),
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
                        tipeEdit == 'SEBELUM'
                            ? 'EDIT_PROSES_TENDER_SEBELUM'
                            : 'EDIT_PROSES_TENDER_SEKARANG'
                      ]);
                  print(data);
                  if (data.length > 0) {
                    dataAll.value = data[0];
                    dataGroup.value = data[1];
                    dataMitraTransporter.value = data[2];
                    dataEmail.value = data[3];

                    dataAll.refresh();
                    dataGroup.refresh();
                    dataMitraTransporter.refresh();
                    dataEmail.refresh();

                    collectData();
                  }
                },
              )
            ])
    ]);
  }

  Widget listTahapTenderWidget(int index) {
    //LIST DROP DOWN MENU
    return Obx(() => Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  width: GlobalVariable.ratioWidth(Get.context) * 17,
                  child: CustomText((index).toString() + '.  ',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(ListColor.colorDarkGrey3))),
              Expanded(
                  child: Container(
                      child: CustomText(namaTahapTender[index + 1].tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(ListColor.colorDarkGrey3))))
            ],
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),
          Row(
            children: [
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 17,
                  child: CustomText('  '.tr,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(ListColor.colorDarkGrey3))),
              Expanded(
                child:
                    CustomText('ProsesTenderCreateLabelPeriode'.tr, // Periode
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(ListColor.colorGrey3)),
              )
            ],
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 6),
          Row(
            children: [
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 17,
                  child: CustomText('  '.tr,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(ListColor.colorDarkGrey3))),
              Expanded(
                child: periodeTenderWidget(index),
              )
            ],
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 14),
        ]));
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
    var idMitraTermasukGroup = [];

    if (!semuaMitra && !semuaTransporter) {
      //GROUP
      for (var x = 0; x < dataGroup.length; x++) {
        if (dataGroup[x]['select']) {
          dataSelectedUrut.add(dataGroup[x]);
          for (var y = 0; y < dataGroup[x]['data'].length; y++) {
            //CEK APAKAH ADA DATA KEBAR TERHADAP LIST INI
            if (idMitraTermasukGroup
                    .where((element) =>
                        element ==
                        dataGroup[x]['data'][y]['MitraID'].toString())
                    .toList()
                    .length ==
                0) {
              idMitraTermasukGroup
                  .add(dataGroup[x]['data'][y]['MitraID'].toString());
            }
          }
        }
      }

      //MITRA
      for (var x = 0; x < dataMitraTransporter.length; x++) {
        //CEK JIKA DIA DICENTANG, MITRA, DAN TIDAK MASUK GRUP
        if (dataMitraTransporter[x]['select'] &&
            dataMitraTransporter[x]['ismitra'] == 1 &&
            idMitraTermasukGroup
                    .where((element) =>
                        element == dataMitraTransporter[x]['id'].toString())
                    .toList()
                    .length ==
                0) {
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

    //CEK DATA EMAIL INVITATION
    for (var x = 0; x < dataEmail.length; x++) {
      if (dataEmail[x]['name'] != "") {
        dataSelectedUrut.add({
          'id': '0',
          'name': dataEmail[x]['name'],
          'ismitra': 0,
          'isgroup': 0,
          'invited_email': 1,
          'image': '',
          'urutan': dataEmail[x]['urutan'],
        });
      }
    }

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

  Widget periodeTenderWidget(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: index == 1 && tipeEdit == "SEKARANG"
                    ? Container(
                        // padding: EdgeInsets.only(
                        //   left: GlobalVariable.ratioWidth(Get.context) * 10,
                        // ),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                                dataTahapTender[index]['show_first_date'],
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                textAlign: TextAlign.left,
                                color: Color(ListColor.colorLightGrey4))))
                    : GestureDetector(
                        onTap: () async {
                          FocusManager.instance.primaryFocus.unfocus();

                          print(dataTahapTender[index]['min_date']);

                          var result = await showDatePicker(
                              context: Get.context,
                              initialDate: initDate(index, 'awal'),
                              firstDate: firstDate(index, 'awal'),
                              lastDate: DateTime(2100));
                          dataTahapTender[index]['show_first_date'] =
                              DateFormat('dd MMM yy').format(result).toString();
                          dataTahapTender[index]['min_date'] = result;
                          dataTahapTender.refresh();
                          cekPengisian.value = true;
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 10,
                            right: GlobalVariable.ratioWidth(Get.context) * 8,
                            top: GlobalVariable.ratioWidth(Get.context) * 7,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 7,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: dataTahapTender[index]
                                              ['error_min_date'] !=
                                          ""
                                      ? Color(ListColor.colorRed)
                                      : Color(ListColor.colorGrey2),
                                  width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 6)),
                              color: Color(ListColor.colorWhite)),
                          child: Material(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => CustomText(
                                      (dataTahapTender[index]['min_date'] == ''
                                          ? 'ProsesTenderCreateLabelFirstDate'
                                              .tr //Tanggal Awal
                                          : dataTahapTender[index]
                                              ['show_first_date']),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: dataTahapTender[index]
                                                  ['min_date'] !=
                                              ''
                                          ? Color(ListColor.colorLightGrey4)
                                          : Color(ListColor.colorStroke),
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        'calendar_icon.svg',
                                    color: Color(ListColor.colorGrey3),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16),
                              ],
                            ),
                          ),
                        ),
                      )),
            Container(
              child: CustomText(
                  ' ' + 'ProsesTenderCreateLabelSampaiDengan'.tr + ' ', // s/d
                  fontSize: 14,
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  FocusManager.instance.primaryFocus.unfocus();
                  var result = await showDatePicker(
                      context: Get.context,
                      initialDate: initDate(index, 'akhir'),
                      firstDate: firstDate(index, 'akhir'),
                      lastDate: DateTime(2100));
                  dataTahapTender[index]['show_last_date'] =
                      DateFormat('dd MMM yy').format(result).toString();
                  dataTahapTender[index]['max_date'] = result;
                  dataTahapTender.refresh();
                  cekPengisian.value = true;
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 10,
                    right: GlobalVariable.ratioWidth(Get.context) * 8,
                    top: GlobalVariable.ratioWidth(Get.context) * 7,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 7,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: dataTahapTender[index]['error_max_date'] != ""
                              ? Color(ListColor.colorRed)
                              : Color(ListColor.colorGrey2),
                          width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6)),
                      color: Color(ListColor.colorWhite)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: CustomText(
                          (dataTahapTender[index]['max_date'] == ''
                              ? 'ProsesTenderCreateLabelLastDate'
                                  .tr // Tanggal Akhir
                              : dataTahapTender[index]['show_last_date']),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: dataTahapTender[index]['max_date'] != ''
                              ? Color(ListColor.colorLightGrey4)
                              : Color(ListColor.colorStroke),
                        ),
                      ),
                      SvgPicture.asset(
                          GlobalVariable.imagePath + 'calendar_icon.svg',
                          color: Color(ListColor.colorGrey3),
                          width: GlobalVariable.ratioWidth(Get.context) * 16,
                          height: GlobalVariable.ratioWidth(Get.context) * 16)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: dataTahapTender.length == 4 && index == 3
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 40),
                          GestureDetector(
                            onTap: () {
                              tambahTahapTender();
                            },
                            child: SvgPicture.asset(
                                GlobalVariable.imagePath + 'plus_square.svg',
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 20,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    20),
                          ),
                        ])
                  : dataTahapTender.length - 1 == index
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    10),
                            GestureDetector(
                                onTap: () {
                                  hapusTahapTender(index);
                                },
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        'minus_square.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20)),
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    30),
                          ],
                        )
                      : SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 61),
            )
          ],
        ),
        dataTahapTender[index]['error_min_date'] != "" ||
                dataTahapTender[index]['error_max_date'] != ""
            ? Container(
                margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: dataTahapTender[index]['error_min_date'] != ""
                          ? CustomText(dataTahapTender[index]['error_min_date'],
                              color: Color(ListColor.colorRed),
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                              fontSize: 12)
                          : SizedBox(),
                    ),
                    Container(
                      child: CustomText(
                          ' ' +
                              'ProsesTenderCreateLabelSampaiDengan'.tr +
                              ' ', // s/d
                          fontSize: 12,
                          color: Colors.transparent),
                    ),
                    Expanded(
                      child: dataTahapTender[index]['error_max_date'] != ""
                          ? CustomText(dataTahapTender[index]['error_max_date'],
                              color: Color(ListColor.colorRed),
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                              fontSize: 12)
                          : SizedBox(),
                    ),
                    dataTahapTender.length > 1
                        ? SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 61)
                        : SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 33)
                  ],
                ))
            : SizedBox.shrink(),
      ],
    );
  }
  //FIRST PAGE

  //THIRD PAGE WIDGET & FUNCTION
  Widget kebutuhanTrukSebelumTenderWidget(index) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            dataTrukTender.length > 1
                ? ('ProsesTenderCreateLabelKebutuhan'.tr +
                    ' #' +
                    (index + 1).toString().tr) // Kebutuhan
                : ('ProsesTenderCreateLabelKebutuhan'.tr), // Kebutuhan
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(ListColor.colorGrey3)),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
        GestureDetector(
            child: AbsorbPointer(
                child: Obx(
              () => CustomTextFormField(
                context: Get.context,
                textAlignVertical: TextAlignVertical.center,
                controller: dataTrukController[index],
                newContentPadding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                textSize: 14,
                style: TextStyle(
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w600,
                ),
                newInputDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffixIcon: Icon(Icons.keyboard_arrow_down_sharp,
                      size: 30, color: Color(ListColor.colorGrey4)),
                  isDense: true,
                  isCollapsed: true,
                  hintText: "ProsesTenderCreateLabelJenisTruk".tr, //Jenis Truk
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6))),
                ),
                validator: (value) {
                  if (value == "" || !validasiSimpan) {
                    return "ProsesTenderCreateLabelAlertJenisTruk"
                        .tr; // Jenis Truk Harus Diisi
                  }
                  return null;
                },
              ),
            )),
            onTap: () async {
              FocusManager.instance.primaryFocus.unfocus();
              if (!cekRuteDitenderkanSudahAda() ||
                  dataTrukTender[index]['jenis_truk'] == 0) {
                await getTruk(index);
              } else {
                GlobalAlertDialog.showAlertDialogCustom(
                    context: Get.context,
                    title: "ProsesTenderCreateLabelInfoKonfirmasiPerubahan"
                        .tr, //Konfirmasi Perubahan
                    message:
                        "ProsesTenderCreateLabelPerubahanTrukCarrier" //Apakah anda yakin ingin melakukan perubahan data jenis truk/carrier ? Data yang telah diisi pada rute yang ditenderkan akan hilang
                            .tr,
                    labelButtonPriority1: GlobalAlertDialog.noLabelButton,
                    onTapPriority1: () async {},
                    onTapPriority2: () async {
                      fourthPageinit();
                      setUlangDataRute();
                      await getTruk(index);
                    },
                    labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
              }
            }),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 18),
        GestureDetector(
            child: AbsorbPointer(
                child: Obx(
              () => CustomTextFormField(
                context: Get.context,
                textAlignVertical: TextAlignVertical.center,
                controller: dataCarrierController[index],
                newContentPadding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                ),
                textSize: 14,
                style: TextStyle(
                  color: Color(ListColor.colorLightGrey4),
                  fontWeight: FontWeight.w600,
                ),
                newInputDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffixIcon: Icon(Icons.keyboard_arrow_down_sharp,
                      size: 30, color: Color(ListColor.colorGrey4)),
                  isDense: true,
                  isCollapsed: true,
                  hintText:
                      "ProsesTenderCreateLabelJenisCarrier".tr, //Jenis Carrier
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                  ),
                  errorText: dataTrukTender[index]['error'] != ""
                      ? dataTrukTender[index]['error']
                      : null,
                ),
                validator: (value) {
                  if (value == "" || !validasiSimpan) {
                    return "ProsesTenderCreateLabelAlertJenisCarrier"
                        .tr; // Jenis Carrier Harus Diisi
                  }
                  return null;
                },
              ),
            )),
            onTap: () async {
              FocusManager.instance.primaryFocus.unfocus();

              //PENGECEKAN JIKA RUTE DITENDERKAN SUDAH DIBUAT

              if (dataTrukTender[index]['jenis_carrier'] == 0 ||
                  dataTrukTender[index]['jenis_truk'] != 0) {
                if (!cekRuteDitenderkanSudahAda() ||
                    dataTrukTender[index]['jenis_carrier'] == 0) {
                  await getCarrier(index);
                } else {
                  GlobalAlertDialog.showAlertDialogCustom(
                      context: Get.context,
                      title: "ProsesTenderCreateLabelInfoKonfirmasiPerubahan"
                          .tr, //Konfirmasi Perubahan
                      message:
                          "ProsesTenderCreateLabelPerubahanTrukCarrier" //Apakah anda yakin ingin melakukan perubahan data jenis truk/carrier ?  Data yang telah diisi pada rute yang ditenderkan akan hilang
                              .tr,
                      labelButtonPriority1: GlobalAlertDialog.noLabelButton,
                      onTapPriority1: () async {},
                      onTapPriority2: () async {
                        fourthPageinit();

                        setUlangDataRute();

                        await getCarrier(index);
                      },
                      labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
                }
              }
            }),
        // dataTrukTender[index]['error'] != ""
        //     ? Container(
        //         margin: EdgeInsets.only(
        //           top: GlobalVariable.ratioWidth(Get.context) * 4,
        //         ),
        //         child: CustomText(
        //           dataTrukTender[index]['error'],
        //           color: Color(ListColor.colorRed),
        //           fontSize: 12,
        //           height: 1.2,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       )
        //     : SizedBox.shrink(),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
        Obx(
          () => Container(
              alignment: Alignment.center,
              height: GlobalVariable.ratioWidth(Get.context) * 167,
              decoration: BoxDecoration(
                  color: dataTrukTender[index]['gambar_truk'].isEmpty
                      ? Color(ListColor.colorBackgroundGambar)
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 6)),
                  border: Border.all(
                      color: Color(ListColor.colorLightGrey10), width: 1)),
              child: Obx(
                () => dataTrukTender[index]['gambar_truk'].isEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              GlobalVariable.imagePath + 'ic_image.svg',
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 39,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 28),
                          Container(height: 4),
                          CustomText(
                              'ProsesTenderCreateLabelPilihJenisTrukdanCarrier'
                                  .tr, // Pilih Jenis Truk dan Carrier

                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(ListColor.colorLightGrey4))
                        ],
                      )
                    : CachedNetworkImage(
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
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                      ),
              )),
        ),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
        CustomText(
            'ProsesTenderCreateLabelEstimasiKapasitasDimensiVolume'
                .tr, //Estimasi kapasitas / dimensi / volume
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(ListColor.colorGrey3)),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
        Obx(
          () => CustomText(dataTrukTender[index]['deskripsi'].toString().tr,
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
        ),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
        CustomText('ProsesTenderCreateLabelJumlahTruk'.tr, //Jumlah Truk
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(ListColor.colorGrey3)),
        SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 6),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 90,
                  child: Stack(alignment: Alignment.centerLeft, children: [
                    Obx(
                      () => Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(ListColor.colorLightGrey10)),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 4))),
                          height: GlobalVariable.ratioWidth(Get.context) * 22,
                          child: CustomTextField(
                            context: Get.context,
                            controller: jmlTrukController[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              DecimalInputFormatter(
                                  digit: 4,
                                  digitAfterComma: 0,
                                  controller: jmlTrukController[index])
                            ],
                            newContentPadding: EdgeInsets.only(top: 1.0),
                            newInputDecoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                isDense: true,
                                isCollapsed: true,
                                hintText: '',
                                errorMaxLines: 2,
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                ))),
                            onChanged: (value) {
                              if (value == "") {
                                value = "0";
                              }
                              dataTrukTender[index]['jumlah_truck'] =
                                  value == ""
                                      ? ""
                                      : int.parse(
                                          GlobalVariable.formatDoubleDecimal(
                                              value));

                              print(dataTrukTender[index]['jumlah_truck']);
                            },
                          )),
                    ),
                    Positioned(
                        child: GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus.unfocus();
                              if (jmlTrukController[index].text == "") {
                                jmlTrukController[index].text = "0";
                              }

                              if (int.parse(GlobalVariable.formatDoubleDecimal(
                                      jmlTrukController[index].text)) >
                                  0) {
                                jmlTrukController[index].text =
                                    GlobalVariable.formatCurrencyDecimal(
                                        (int.parse(GlobalVariable
                                                    .formatDoubleDecimal(
                                                        jmlTrukController[index]
                                                            .text)) -
                                                1)
                                            .toString());

                                dataTrukTender[index]['jumlah_truck'] =
                                    int.parse(
                                        GlobalVariable.formatDoubleDecimal(
                                            jmlTrukController[index].text));
                              }
                            },
                            child: Container(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 22,
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 22,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(ListColor.colorBlue),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                4))),
                                child: Icon(Icons.remove,
                                    size:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20, // 24
                                    color: Color(ListColor.colorBlue))))),
                    Positioned(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  FocusManager.instance.primaryFocus.unfocus();
                                  if (jmlTrukController[index].text == "") {
                                    jmlTrukController[index].text = "0";
                                  }
                                  if (int.parse(
                                          GlobalVariable.formatDoubleDecimal(
                                              jmlTrukController[index].text)) <
                                      10000) {
                                    jmlTrukController[index].text =
                                        GlobalVariable.formatCurrencyDecimal(
                                            (int.parse(GlobalVariable
                                                        .formatDoubleDecimal(
                                                            jmlTrukController[
                                                                    index]
                                                                .text)) +
                                                    1)
                                                .toString());

                                    dataTrukTender[index]['jumlah_truck'] =
                                        int.parse(
                                            GlobalVariable.formatDoubleDecimal(
                                                jmlTrukController[index].text));
                                  }
                                },
                                child: Container(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            22,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            22,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Color(ListColor.colorBlue),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    4))),
                                    child: Icon(Icons.add,
                                        size: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            20,
                                        color: Color(ListColor.colorBlue)))))),
                  ])),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Expanded(
                child: CustomText('Unit'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black),
              ),
            ]),
        dataTrukTender[index]['jmlerror'] != ""
            ? Obx(() => Container(
                  margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 4,
                  ),
                  child: CustomText(
                    dataTrukTender[index]['jmlerror'],
                    color: Color(ListColor.colorRed),
                    fontSize: 12,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ))
            : SizedBox.shrink(),
        dataTrukTender.length - 1 == index
            ? Column(children: [
                SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    dataTrukTender.length > 1
                        ? GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus.unfocus();
                              if (!cekRuteDitenderkanSudahAda()) {
                                hapusTruk(index);
                              } else {
                                GlobalAlertDialog.showAlertDialogCustom(
                                    context: Get.context,
                                    title:
                                        "ProsesTenderCreateLabelInfoKonfirmasiPerubahan"
                                            .tr, //Konfirmasi Perubahan
                                    message:
                                        "ProsesTenderCreateLabelPerubahanTrukCarrier" //Apakah anda yakin ingin melakukan perubahan data jenis truk/carrier ?  Data yang telah diisi pada rute yang ditenderkan akan hilang
                                            .tr,
                                    labelButtonPriority1:
                                        GlobalAlertDialog.noLabelButton,
                                    onTapPriority1: () async {},
                                    onTapPriority2: () async {
                                      fourthPageinit();

                                      setUlangDataRute();

                                      hapusTruk(index);
                                    },
                                    labelButtonPriority2:
                                        GlobalAlertDialog.yesLabelButton);
                              }
                            },
                            child: SvgPicture.asset(
                                GlobalVariable.imagePath + 'minus_square.svg',
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 32,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    32))
                        : SizedBox(),
                    SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 20),
                    GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus.unfocus();
                          if (!cekRuteDitenderkanSudahAda()) {
                            tambahTruk();
                          } else {
                            GlobalAlertDialog.showAlertDialogCustom(
                                context: Get.context,
                                title:
                                    "ProsesTenderCreateLabelInfoKonfirmasiPerubahan"
                                        .tr, //Konfirmasi Perubahan
                                message:
                                    "ProsesTenderCreateLabelPerubahanTrukCarrier" //Apakah anda yakin ingin melakukan perubahan data jenis truk/carrier ?  Data yang telah diisi pada rute yang ditenderkan akan hilang
                                        .tr,
                                labelButtonPriority1:
                                    GlobalAlertDialog.noLabelButton,
                                onTapPriority1: () async {},
                                onTapPriority2: () async {
                                  //RESET, LALU BUAT ULANG
                                  fourthPageinit();

                                  setUlangDataRute();

                                  tambahTruk();
                                },
                                labelButtonPriority2:
                                    GlobalAlertDialog.yesLabelButton);
                          }
                        },
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'plus_square.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 32,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 32)),
                  ],
                )
              ])
            : SizedBox(),
        dataTrukTender.length > 1 && index != dataTrukTender.length - 1
            ? Column(children: [
                SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 29),
                lineDividerWidget(),
                SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
              ])
            : SizedBox()
      ],
    ));
  }

  void tambahTruk() {
    dataTrukTender.add({
      'truck_id': 0,
      'jenis_truk': 0,
      'jenis_carrier': 0,
      'nama_truk': '',
      'nama_carrier': '',
      'deskripsi': '-',
      'gambar_truk': '',
      'jumlah_truck': 0,
      'error': '',
      'jmlerror': '',
    });

    dataTrukTender.refresh();

    dataTrukController.add(TextEditingController(text: ""));
    dataCarrierController.add(TextEditingController(text: ""));
    jmlTrukController.add(TextEditingController(text: "0"));
    dataTrukController.refresh();
    dataCarrierController.refresh();
    jmlTrukController.refresh();

    //DATA RUTE TENDER DITAMBAHKAN
    for (var x = 0; x < 3; x++) {
      var jsonData = {
        'jenis_truk': 0,
        'nama_truk': '',
        'jenis_carrier': 0,
        'nama_carrier': '',
        'nilai': 0,
        'error': ''
      };

      dataRuteTender[x]['data'].add(jsonData);
    }

    dataRuteTender.refresh();
  }

  void hapusTruk(int index) {
    dataTrukTender.refresh();
    dataTrukTender.removeAt(index);
    dataTrukTender.refresh();
    jmlTrukController.removeAt(index);
    jmlTrukController.refresh();
    dataTrukController.removeAt(index);
    dataTrukController.refresh();
    dataCarrierController.removeAt(index);
    dataCarrierController.refresh();

    //HAPUS TRUk
    for (var x = 0; x < 3; x++) {
      dataRuteTender[x]['data'].removeAt(index);
    }

    dataRuteTender.refresh();
  }

  Widget kebutuhanTrukTenderWidget(index) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            dataTrukTender.length > 1
                ? ('ProsesTenderDetailLabelKebutuhan'.tr +
                    ' #' +
                    (index + 1).toString().tr) //Kebutuhan
                : ('ProsesTenderDetailLabelKebutuhan'.tr), //Kebutuhan
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
                  "ProsesTenderDetailLabelJenisTruk".tr, // Jenis Truk
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
                  "ProsesTenderDetailLabelJenisCarrier".tr, // Jenis Carrier
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
              child: CustomText("ProsesTenderDetailLabelJumlah".tr, // Jumlah
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
            'ProsesTenderDetailLabelEstimasi'
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
        color: Color(ListColor.colorLightGrey2),
        height: 0,
      ),
    );
  }

  void tambahTahapTender() {
    //DAPATKAN TAHAP TENDER TERAKHIR
    var lastTahap = 0;
    for (var index = 0; index < dataTahapTender.length; index++) {
      if (lastTahap < dataTahapTender[index]['tahap_tender']) {
        lastTahap = dataTahapTender[index]['tahap_tender'];
      }
    }

    //SETTING COMBOGRID
    dataTahapTender.add({
      'tahap_tender': (lastTahap + 1),
      'show_first_date': 'ProsesTenderCreateLabelFirstDate'.tr, //Tanggal Awal
      'show_last_date': 'ProsesTenderCreateLabelLastDate'.tr, // Tanggal AKhir
      'min_date': '',
      'max_date': '',
      'error_tahap_tender': '',
      'error_min_date': '',
      'error_max_date': '',
    });
    dataTahapTender.refresh();
  }

  void hapusTahapTender(int index) {
    dataTahapTender.removeAt(index);
    dataTahapTender.refresh();
  }

  void hitungTotalYangDigunakan(bool editNilai) {
    jumlahYangDigunakan.value = 0;

    //HAPUS RUTE YANG TIDAK TERPAKAI
    for (var x = 0; x < dataRuteTender.length; x++) {
      print('x = ' + x.toString());
      if ((x + 1) > jumlahRute.value) {
        var listData = [];
        if (satuanTender.value == 2) {
          for (var y = 0; y < dataTrukTender.length; y++) {
            listData.add({
              'jenis_truk': dataTrukTender[y]['jenis_truk'],
              'nama_truk': dataTrukTender[y]['nama_truk'],
              'jenis_carrier': dataTrukTender[y]['jenis_carrier'],
              'nama_carrier': dataTrukTender[y]['nama_carrier'],
              'nilai': 0,
              'error': ''
            });
          }
        } else {
          listData.add({
            'jenis_truk': 0,
            'nama_truk': '',
            'jenis_carrier': 0,
            'nama_carrier': '',
            'nilai': 0.0,
            'error': ''
          });
        }

        dataRuteTender[x] = {
          'pickup': '',
          'destinasi': '',
          'data': listData,
          'error_pickup': '',
          'error_destinasi': '',
          'error_lokasi_kembar': '',
        };
      }
    }

    if (satuanTender == 2) {
      for (var x = 0; x < dataRuteTender.length; x++) {
        for (var y = 0; y < dataRuteTender[x]['data'].length; y++) {
          jumlahYangDigunakan.value += dataRuteTender[x]['data'][y]['nilai'];
        }
      }
    } else if (satuanTender == 1) {
      for (var x = 0; x < dataRuteTender.length; x++) {
        jumlahYangDigunakan.value += dataRuteTender[x]['data'][0]['nilai'];
        if (!editNilai) {
          if (dataRuteTender[x]['data'][0]['nilai'] > 0) {
            beratPerRuteController[x].text =
                GlobalVariable.formatCurrencyDecimal(
                    dataRuteTender[x]['data'][0]['nilai'].toString());
          } else {
            beratPerRuteController[x].clear();
          }
        }
      }
    } else if (satuanTender == 3) {
      for (var x = 0; x < dataRuteTender.length; x++) {
        jumlahYangDigunakan.value += dataRuteTender[x]['data'][0]['nilai'];
        if (!editNilai) {
          if (dataRuteTender[x]['data'][0]['nilai'] > 0) {
            volumePerRuteController[x].text =
                GlobalVariable.formatCurrencyDecimal(
                    dataRuteTender[x]['data'][0]['nilai'].toString());
          } else {
            volumePerRuteController[x].clear();
          }
        }
      }
    }
    print(dataRuteTender.length);
  }

  void cekBelumTerpakai() async {
    errorFourthPage.value = "";
    if (satuanTender.value == 2) {
      //DAPATKAN JUMLAH UNIT TRUK YANG DISEDIAKAN
      var jmltruktersedia = 0;
      for (var x = 0; x < dataTrukTender.length; x++) {
        jmltruktersedia += dataTrukTender[x]['jumlah_truck'];
      }

      //PENGECEKAN JUMLAH YANG DIGUNAKAN LEBIH SEDIKIT DIBANDINGKAN DENGAN JUMLAH YANG TERSEDIA
      if (jumlahYangDigunakan.value.toInt() < jmltruktersedia) {
        validasiSimpan = false;
        errorFourthPage.value = "ProsesTenderCreateLabelAlertSisaUnitTruk"
            .tr; //Masih ada sisa truk yang belum dialokasikan pada rute. Habiskan semua unit truk Anda
      }

      dataTrukTender.refresh();
      dataRuteTender.refresh();
    } else if (satuanTender.value == 1) {
      if (jumlahYangDigunakan.value.toDouble() <
          double.parse(
              GlobalVariable.formatDoubleDecimal(beratController.text))) {
        validasiSimpan = false;
        errorFourthPage.value = "ProsesTenderCreateLabelAlertSisaBerat"
            .tr; //Masih ada sisa berat yang belum dialokasikan pada rute. Habiskan semua alokasi berat Anda
      }
      if (jumlahYangDigunakan.value.toDouble() >
          double.parse(
              GlobalVariable.formatDoubleDecimal(beratController.text))) {
        validasiSimpan = false;
        errorFourthPage.value = "ProsesTenderCreateLabelAlertBeratHeavier"
            .tr; //Berat yang digunakan lebih besar
      }
    } else if (satuanTender.value == 3) {
      if (jumlahYangDigunakan.value.toDouble() <
          double.parse(
              GlobalVariable.formatDoubleDecimal(volumeController.text))) {
        validasiSimpan = false;
        errorFourthPage.value = "ProsesTenderCreateLabelAlertSisaVolume"
            .tr; //Masih ada sisa volume yang belum dialokasikan pada rute. Habiskan semua alokasi volume Anda
      }

      if (jumlahYangDigunakan.value.toDouble() >
          double.parse(
              GlobalVariable.formatDoubleDecimal(volumeController.text))) {
        validasiSimpan = false;
        errorFourthPage.value = "ProsesTenderCreateLabelAlertVolumeHeavier"
            .tr; // Volume yang digunakan lebih besar
      }
    }
  }

  void chooseFile() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', "doc", "docx"]);

    if (pickedFile != null) {
      selectedFile.value = File(pickedFile.files.first.path);
      int sizeInBytes = selectedFile.value.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      nama_file.value = pickedFile.files.first.name;
      errorFifthPage.value = "";

      if (nama_file.value
                  .split(".")[nama_file.value.split(".").length - 1]
                  .toUpperCase() !=
              'DOC' &&
          nama_file.value
                  .split(".")[nama_file.value.split(".").length - 1]
                  .toUpperCase() !=
              'DOCX' &&
          nama_file.value
                  .split(".")[nama_file.value.split(".").length - 1]
                  .toUpperCase() !=
              'PDF') {
        selectedFile.value = null;
        nama_file.value = "";
        errorFifthPage.value = "ProsesTenderCreateAlertFileFormatSalah"
            .tr; // File yang Anda pilih lebih dari 8 MB
      }
      if (sizeInMb > 8) {
        selectedFile.value = null;
        nama_file.value = "";
        errorFifthPage.value = "ProsesTenderCreateAlertFileBesar"
            .tr; // File yang Anda pilih lebih dari 8 MB
      }
    }
  }

  //FOURTH PAGE
  Widget unitTrukRuteDitenderkanSebelumTenderWidget(int index) {
    return Obx(
      () => Column(
        children: [
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                  "ProsesTenderDetailLabelRute".tr +
                      " " +
                      (index + 1).toString(), //Rute
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              Expanded(child: SizedBox()),
              GestureDetector(
                  onTap: () async {
                    var dataTrukTenderSelisih =
                        json.decode(json.encode(dataTrukTender));
                    //DAPATKAN TRUK TENDER
                    for (var x = 0; x < dataTrukTenderSelisih.length; x++) {
                      //DAPATKAN DATA SEMUA RUTE
                      for (var y = 0; y < dataRuteTender.length; y++) {
                        //DAPATKAN DATA TRUK PER RUTE
                        for (var z = 0;
                            z < dataRuteTender[y]['data'].length;
                            z++) {
                          if (dataTrukTenderSelisih[x]['jenis_truk'] ==
                                  dataRuteTender[y]['data'][z]['jenis_truk'] &&
                              dataTrukTenderSelisih[x]['jenis_carrier'] ==
                                  dataRuteTender[y]['data'][z]
                                      ['jenis_carrier']) {
                            dataTrukTenderSelisih[x]['jumlah_truck'] =
                                dataTrukTenderSelisih[x]['jumlah_truck'] -
                                    dataRuteTender[y]['data'][z]['nilai'];
                          }
                        }
                      }
                    }

                    var result =
                        await GetToPage.toNamed<SelectRuteTenderController>(
                            Routes.SELECT_RUTE_TENDER,
                            arguments: [
                          dataRuteTender[index],
                          dataTrukTenderSelisih,
                          dataRuteTender,
                          (index + 1),
                          "TD"
                        ]);

                    if (result != null) {
                      dataRuteTender[index] = result;
                      hitungTotalYangDigunakan(false);
                      // if (errorFourthPage.value != "") {
                      //   cekBelumTerpakai();
                      // }
                    }
                  },
                  child: CustomText(
                      "ProsesTenderCreateLabelIsiDataRute".tr, // Isi Data Rute
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.right,
                      fontSize: 12,
                      color: Color(ListColor.colorBlue))),
              dataRuteTender[index]['pickup'] != "" &&
                      dataRuteTender[index]['destinasi'] != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 28),
                          GestureDetector(
                              onTap: () async {
                                GlobalAlertDialog.showAlertDialogCustom(
                                    context: Get.context,
                                    title: "".tr,
                                    message:
                                        "ProsesTenderCreateAlertButtonResetDataRute" //Apakah anda yakin ingin mereset rute ini? Data rute yang telah diisi akan hilang
                                            .tr,
                                    labelButtonPriority1:
                                        GlobalAlertDialog.noLabelButton,
                                    onTapPriority1: () async {},
                                    onTapPriority2: () async {
                                      dataRuteTender[index]['pickup'] = "";
                                      dataRuteTender[index]['destinasi'] = "";
                                      for (var x = 0;
                                          x <
                                              dataRuteTender[index]['data']
                                                  .length;
                                          x++) {
                                        dataRuteTender[index]['data'][x]
                                            ['nilai'] = 0;
                                      }
                                      dataRuteTender.refresh();
                                      hitungTotalYangDigunakan(false);

                                      errorFourthPage.value = "";
                                    },
                                    labelButtonPriority2:
                                        GlobalAlertDialog.yesLabelButton);
                              },
                              child: CustomText(
                                  "ProsesTenderCreateLabelReset".tr, // Reset
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.right,
                                  fontSize: 12,
                                  color: Color(ListColor.colorRed)))
                        ])
                  : SizedBox(),
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
                  border:
                      Border.all(color: Color(ListColor.colorBorderTextbox)),
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 6))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => CustomText(
                        dataRuteTender[index]['pickup'] == "" &&
                                dataRuteTender[index]['destinasi'] == ""
                            ? "ProsesTenderCreateLabelRuteBelumDitentukan"
                                .tr //Rute Belum Ditentukan
                            : dataRuteTender[index]['pickup'] +
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
                            'ProsesTenderCreateLabelJenisTruk'.tr, // Jenis Truk
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      //RIGHT
                      Container(
                          alignment: Alignment.centerRight,
                          constraints: BoxConstraints(
                              minWidth:
                                  GlobalVariable.ratioWidth(Get.context) * 52),
                          child: CustomText(
                              'ProsesTenderDetailLabelJumlah'.tr, // Jumlah
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
                                    dataRuteTender[index]['data'].indexWhere(
                                        (element) => element['nilai'] != 0)
                                ? null //EYA
                                : EdgeInsets.only(
                                    top: GlobalVariable.ratioWidth(
                                            Get.context) *
                                        22), //// JIKA INDEX TERAKHIR, TIDAK PERLU
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //LEFT
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            2,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "ic_truck_grey.svg",
                                              color: Color(ListColor.colorBlue),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  9),
                                          Obx(
                                            () => CustomText(
                                                dataRuteTender[index]['data']
                                                        [indexDetail]
                                                    ['nama_carrier'],
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(
                                                    ListColor.colorDarkGrey3)),
                                          ),
                                        ],
                                      )
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
                                        GlobalVariable.formatCurrencyDecimal(
                                                dataRuteTender[index]['data']
                                                        [indexDetail]['nilai']
                                                    .toString()) +
                                            ' Unit'.tr,
                                        fontSize: 14,
                                        textAlign: TextAlign.right,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black))),
                              ],
                            ),
                          )
                        : indexDetail == 0 &&
                                dataRuteTender[index]['data'].length ==
                                    (dataRuteTender[index]['data']
                                        .where(
                                            (element) => element['nilai'] == 0)
                                        .toList()
                                        .length)
                            ? Container(
                                margin: dataRuteTender[index]['data']
                                            [indexDetail]['nilai'] !=
                                        0
                                    ? EdgeInsets.only(
                                        bottom: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            22)
                                    : null, // JIKA INDEX TERAKHIR, TIDAK PERLU
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //LEFT
                                    Expanded(
                                        child: CustomText(
                                            "ProsesTenderCreateLabelBelumDitentukan"
                                                .tr, // Belum Ditentukan
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(
                                                ListColor.colorDarkGrey3))),
                                    //RIGHT
                                    Container(
                                        alignment: Alignment.centerRight,
                                        constraints: BoxConstraints(
                                            minWidth: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                52),
                                        child: CustomText('0 Unit'.tr,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            textAlign: TextAlign.right,
                                            color: Colors.black)),
                                  ],
                                ),
                              )
                            : SizedBox()
                ],
              )),
          dataRuteTender[index]['error_lokasi_kembar'] != ""
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 8),
                    Row(
                      children: [
                        Expanded(
                            child: Obx(() => CustomText(
                                  dataRuteTender[index]['error_lokasi_kembar'],
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
        ],
      ),
    );
  }

  Widget beratRuteDitenderkanSebelumTenderWidget(int index) {
    return Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                      "ProsesTenderDetailLabelRute".tr +
                          " " +
                          (index + 1).toString(), //Rute
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                  Expanded(child: SizedBox()),
                  dataRuteTender[index]['pickup'] != "" ||
                          dataRuteTender[index]['destinasi'] != "" ||
                          beratPerRuteController[index].text != ""
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          28),
                              GestureDetector(
                                  onTap: () async {
                                    GlobalAlertDialog.showAlertDialogCustom(
                                        context: Get.context,
                                        title: "".tr,
                                        message:
                                            "ProsesTenderCreateAlertButtonResetDataRute" //Apakah anda yakin ingin mereset rute ini? Data rute yang telah diisi akan hilang
                                                .tr,
                                        labelButtonPriority1:
                                            GlobalAlertDialog.noLabelButton,
                                        onTapPriority1: () async {},
                                        onTapPriority2: () async {
                                          dataRuteTender[index]['pickup'] = "";
                                          dataRuteTender[index]['destinasi'] =
                                              "";
                                          beratPerRuteController[index].clear();
                                          dataRuteTender[index]['data'][0]
                                              ['nilai'] = 0.0;

                                          dataRuteTender.refresh();
                                          hitungTotalYangDigunakan(false);

                                          errorFourthPage.value = "";
                                        },
                                        labelButtonPriority2:
                                            GlobalAlertDialog.yesLabelButton);
                                  },
                                  child: CustomText(
                                      "ProsesTenderCreateLabelReset"
                                          .tr, // Reset
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.right,
                                      fontSize: 12,
                                      color: Color(ListColor.colorRed)))
                            ])
                      : SizedBox()
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),
              Container(
                  //KALAU INDEX TERAKHIR< TIDAK PERLU
                  padding: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 8,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                    left: GlobalVariable.ratioWidth(Get.context) * 10,
                    right: GlobalVariable.ratioWidth(Get.context) * 10,
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
                        Container(
                          padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 8,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          child: CustomText(
                              "ProsesTenderDetailLabelPickUp".tr, // Pick Up
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(ListColor.colorGrey3)),
                        ),
                        GestureDetector(
                            child: Container(
                                width: MediaQuery.of(Get.context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            17),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: dataRuteTender[index]
                                                    ['error_pickup'] !=
                                                ""
                                            ? Color(ListColor.colorRed)
                                            : Color(
                                                ListColor.colorLightGrey10)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6)),
                                child: CustomText(
                                    dataRuteTender[index]['pickup'] == ""
                                        ? "ProsesTenderCreateLabelLokasiPickup".tr //Lokasi Pickup
                                        : dataRuteTender[index]['pickup'],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: dataRuteTender[index]['pickup'] == "" ? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey4))),
                            onTap: () async {
                              FocusManager.instance.primaryFocus.unfocus();
                              var result = await Get.toNamed(
                                  Routes.CHOOSE_AREA_PICKUP,
                                  arguments: [
                                    0,
                                    {},
                                    "ProsesTenderCreateLabelPlaceholderCariLokasiPickup"
                                        .tr
                                  ]); // Cari Lokasi Pickup
                              if (result != null) {
                                (result as Map).keys.forEach((key) {
                                  //Lokasi
                                  print(result[key]);
                                  dataRuteTender[index]['pickup'] = result[key];

                                  //PENGECEKAN LOKASI KEMBAR
                                  cekLokasiKembar(index);

                                  dataRuteTender.refresh();
                                });
                              }
                            }),
                        dataRuteTender[index]['error_pickup'] != ""
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                                dataRuteTender[index]
                                                    ['error_pickup'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                height: 1.2,
                                                color:
                                                    Color(ListColor.colorRed),
                                              ))),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              74)
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Container(
                          padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 8,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          child: CustomText(
                              "ProsesTenderDetailLabelDestinasi"
                                  .tr, // Destinasi
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(ListColor.colorGrey3)),
                        ),
                        GestureDetector(
                            child: Container(
                                width: MediaQuery.of(Get.context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            17),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: dataRuteTender[index]
                                                    ['error_destinasi'] !=
                                                ""
                                            ? Color(ListColor.colorRed)
                                            : Color(
                                                ListColor.colorLightGrey10)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6)),
                                child: CustomText(
                                    dataRuteTender[index]['destinasi'] == ""
                                        ? "ProsesTenderCreateLabelDestinasi".tr // Lokasi Destinasi
                                        : dataRuteTender[index]['destinasi'],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: dataRuteTender[index]['destinasi'] == "" ? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey4))),
                            onTap: () async {
                              var result = await Get.toNamed(
                                  Routes.CHOOSE_AREA_PICKUP,
                                  arguments: [
                                    0,
                                    {},
                                    "ProsesTenderCreateLabelPlaceholderCariLokasiDestinasi"
                                        .tr
                                  ]); // Cari Lokasi Destinasi
                              if (result != null) {
                                FocusManager.instance.primaryFocus.unfocus();
                                (result as Map).keys.forEach((key) {
                                  //Lokasi
                                  print(result[key]);
                                  dataRuteTender[index]['destinasi'] =
                                      result[key];

                                  //PENGECEKAN LOKASI KEMBAR
                                  cekLokasiKembar(index);

                                  dataRuteTender.refresh();
                                });
                              }
                            }),
                        dataRuteTender[index]['error_destinasi'] != ""
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                                dataRuteTender[index]
                                                    ['error_destinasi'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                height: 1.2,
                                                color:
                                                    Color(ListColor.colorRed),
                                              ))),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              74)
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        dataRuteTender[index]['error_lokasi_kembar'] != ""
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                                dataRuteTender[index]
                                                    ['error_lokasi_kembar'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                height: 1.2,
                                                color:
                                                    Color(ListColor.colorRed),
                                              ))),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              74)
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Container(
                          padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 8,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          child: CustomText(
                              "ProsesTenderDetailLabelBerat".tr, //Berat
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(ListColor.colorGrey3)),
                        ),
                        CustomTextFormField(
                            context: Get.context,
                            newContentPadding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 12,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 17,
                            ),
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9\,]")),
                              DecimalInputFormatter(
                                  digit: 13,
                                  digitAfterComma: 3,
                                  controller: beratPerRuteController[index])
                            ],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey4),
                            ),
                            textSize: 14,
                            newInputDecoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                              filled: true,
                              prefix: SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17),
                              suffix: SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          17),
                              suffixIconConstraints:
                                  BoxConstraints(minHeight: 0.0),
                              suffixIcon: Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 40,
                                child: CustomText("Ton",
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorLightGrey4),
                                    fontSize: 14),
                              ),
                              isDense: true,
                              isCollapsed: true,
                              hintText: "ProsesTenderCreateLabelContoh"
                                  .tr, //Contoh : 50
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(ListColor.colorLightGrey2),
                              ),
                            ),
                            controller: beratPerRuteController[index],
                            // validator: (value) {
                            //   if ((value.isEmpty || value == "" || !validasiSimpan)) {
                            //     return "Berat Harus Diisi";
                            //   }

                            //   if (value == "0" ||
                            //       value == "0,00" ||
                            //       value == "0,000" ||
                            //       !validasiSimpan) {
                            //     return "Berat Tidak Boleh 0";
                            //   }

                            //   return null;
                            // },
                            onChanged: (value) {
                              if (value == "") {
                                value = "0.0";
                              }
                              dataRuteTender[index]['data'][0]['nilai'] =
                                  double.parse(
                                      GlobalVariable.formatDoubleDecimal(
                                          value));

                              hitungTotalYangDigunakan(true);
                              // if (errorFourthPage.value != "") {
                              //   cekBelumTerpakai();
                              // }
                            },
                            onEditingComplete: () {
                              print(errorFourthPage.value);
                            }),
                      ]))
            ]));
  }

  Widget volumeRuteDitenderkanSebelumTenderWidget(int index) {
    return Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: GlobalVariable.ratioWidth(Get.context) * 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                      "ProsesTenderDetailLabelRute".tr +
                          " " +
                          (index + 1).toString(), //Rute
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(ListColor.colorGrey3)),
                  Expanded(child: SizedBox()),
                  dataRuteTender[index]['pickup'] != "" ||
                          dataRuteTender[index]['destinasi'] != "" ||
                          volumePerRuteController[index].text != ""
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          28),
                              GestureDetector(
                                  onTap: () async {
                                    GlobalAlertDialog.showAlertDialogCustom(
                                        context: Get.context,
                                        title: "".tr,
                                        message:
                                            "ProsesTenderCreateAlertButtonResetDataRute" //Apakah anda yakin ingin mereset rute ini? Data rute yang telah diisi akan hilang
                                                .tr,
                                        labelButtonPriority1:
                                            GlobalAlertDialog.noLabelButton,
                                        onTapPriority1: () async {},
                                        onTapPriority2: () async {
                                          dataRuteTender[index]['pickup'] = "";
                                          dataRuteTender[index]['destinasi'] =
                                              "";

                                          volumePerRuteController[index]
                                              .clear();
                                          dataRuteTender[index]['data'][0]
                                              ['nilai'] = 0.0;
                                          dataRuteTender.refresh();
                                          hitungTotalYangDigunakan(false);

                                          errorFourthPage.value = "";
                                        },
                                        labelButtonPriority2:
                                            GlobalAlertDialog.yesLabelButton);
                                  },
                                  child: CustomText(
                                      "ProsesTenderCreateLabelReset"
                                          .tr, // Reset
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.right,
                                      fontSize: 12,
                                      color: Color(ListColor.colorRed)))
                            ])
                      : SizedBox()
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10),
              Container(
                  //KALAU INDEX TERAKHIR< TIDAK PERLU
                  padding: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 8,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                    left: GlobalVariable.ratioWidth(Get.context) * 10,
                    right: GlobalVariable.ratioWidth(Get.context) * 10,
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
                        Container(
                          padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 8,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          child: CustomText(
                              "ProsesTenderDetailLabelPickUp".tr, // Pick Up
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(ListColor.colorGrey3)),
                        ),
                        GestureDetector(
                            child: Container(
                                width: MediaQuery.of(Get.context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            17),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: dataRuteTender[index]
                                                    ['error_pickup'] !=
                                                ""
                                            ? Color(ListColor.colorRed)
                                            : Color(
                                                ListColor.colorLightGrey10)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6)),
                                child: CustomText(
                                    dataRuteTender[index]['pickup'] == ""
                                        ? "ProsesTenderCreateLabelLokasiPickup".tr //Lokasi Pickup
                                        : dataRuteTender[index]['pickup'],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: dataRuteTender[index]['pickup'] == "" ? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey4))),
                            onTap: () async {
                              FocusManager.instance.primaryFocus.unfocus();
                              var result = await Get.toNamed(
                                  Routes.CHOOSE_AREA_PICKUP,
                                  arguments: [
                                    0,
                                    {},
                                    "ProsesTenderCreateLabelPlaceholderCariLokasiPickup"
                                        .tr
                                  ]); // Cari Lokasi Pickup
                              if (result != null) {
                                (result as Map).keys.forEach((key) {
                                  //Lokasi
                                  print(result[key]);
                                  dataRuteTender[index]['pickup'] = result[key];

                                  //PENGECEKAN LOKASI KEMBAR
                                  cekLokasiKembar(index);

                                  dataRuteTender.refresh();
                                });
                              }
                            }),
                        dataRuteTender[index]['error_pickup'] != ""
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                                dataRuteTender[index]
                                                    ['error_pickup'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                height: 1.2,
                                                color:
                                                    Color(ListColor.colorRed),
                                              ))),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              74)
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Container(
                          padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 8,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          child: CustomText(
                              "ProsesTenderDetailLabelDestinasi"
                                  .tr, // Destinasi
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(ListColor.colorGrey3)),
                        ),
                        GestureDetector(
                            child: Container(
                                width: MediaQuery.of(Get.context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            17),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: dataRuteTender[index]
                                                    ['error_destinasi'] !=
                                                ""
                                            ? Color(ListColor.colorRed)
                                            : Color(
                                                ListColor.colorLightGrey10)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            6)),
                                child: CustomText(
                                    dataRuteTender[index]['destinasi'] == ""
                                        ? "ProsesTenderCreateLabelDestinasi".tr // Lokasi Destinasi
                                        : dataRuteTender[index]['destinasi'],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: dataRuteTender[index]['destinasi'] == "" ? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey4))),
                            onTap: () async {
                              var result = await Get.toNamed(
                                  Routes.CHOOSE_AREA_PICKUP,
                                  arguments: [
                                    0,
                                    {},
                                    "ProsesTenderCreateLabelPlaceholderCariLokasiDestinasi"
                                        .tr
                                  ]); // Cari Lokasi Destinasi
                              if (result != null) {
                                FocusManager.instance.primaryFocus.unfocus();
                                (result as Map).keys.forEach((key) {
                                  //Lokasi
                                  print(result[key]);
                                  dataRuteTender[index]['destinasi'] =
                                      result[key];

                                  //PENGECEKAN LOKASI KEMBAR
                                  cekLokasiKembar(index);

                                  dataRuteTender.refresh();
                                });
                              }
                            }),
                        dataRuteTender[index]['error_destinasi'] != ""
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                                dataRuteTender[index]
                                                    ['error_destinasi'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                height: 1.2,
                                                color:
                                                    Color(ListColor.colorRed),
                                              ))),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              74)
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        dataRuteTender[index]['error_lokasi_kembar'] != ""
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                                dataRuteTender[index]
                                                    ['error_lokasi_kembar'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                height: 1.2,
                                                color:
                                                    Color(ListColor.colorRed),
                                              ))),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              74)
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Container(
                          padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 8,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          child: CustomText(
                              "ProsesTenderDetailLabelVolume".tr, // Volume
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(ListColor.colorGrey3)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: CustomTextFormField(
                                    context: Get.context,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[0-9\,]")),
                                      DecimalInputFormatter(
                                          digit: 13,
                                          digitAfterComma: 3,
                                          controller:
                                              volumePerRuteController[index])
                                    ],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor.colorLightGrey4),
                                    ),
                                    newContentPadding: EdgeInsets.symmetric(
                                      vertical: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                      //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                                    ),
                                    textSize: 14,
                                    newInputDecoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        prefix: SizedBox(
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                17),
                                        suffix: SizedBox(
                                            width: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                17),
                                        isDense: true,
                                        isCollapsed: true,
                                        hintText:
                                            "ProsesTenderCreateLabelContoh"
                                                .tr, // Contoh : 50
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                        )),
                                    controller: volumePerRuteController[index],
                                    // validator: (value) {
                                    //   if ((value.isEmpty ||
                                    //       value == "" ||
                                    //       !validasiSimpan)) {
                                    //     return "Volume Harus Diisi";
                                    //   }

                                    //   if (value == "0" ||
                                    //       value == "0,00" ||
                                    //       value == "0,000" ||
                                    //       !validasiSimpan) {
                                    //     return "Volume Tidak Boleh 0";
                                    //   }

                                    //   return null;
                                    // },
                                    onChanged: (value) {
                                      print(value);
                                      if (value == "") {
                                        value = "0.0";
                                      }
                                      dataRuteTender[index]['data'][0]
                                              ['nilai'] =
                                          double.parse(GlobalVariable
                                              .formatDoubleDecimal(value));

                                      hitungTotalYangDigunakan(true);
                                      // if (errorFourthPage.value != "") {
                                      //   cekBelumTerpakai();
                                      // }
                                    },
                                    onEditingComplete: () {
                                      print(errorFourthPage.value);
                                    })),
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    12),
                            Container(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 76,
                              child: Obx(() => CustomTextFormField(
                                    context: Get.context,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorLightGrey4),
                                        fontSize: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    newContentPadding: EdgeInsets.symmetric(
                                      vertical: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                      //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                                    ),
                                    readOnly: true,
                                    newInputDecoration: InputDecoration(
                                      hintText:
                                          arrSatuanVolume[satuanVolume.value],
                                      fillColor: Colors.white,
                                      filled: true,
                                      prefix: SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              17),
                                      suffix: SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              17),
                                      isDense: true,
                                      isCollapsed: true,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ]))
            ]));
  }

  void cekLokasiKembar(int index) {
    if (dataRuteTender[index]['pickup'] != "" &&
        dataRuteTender[index]['destinasi'] != "" &&
        dataRuteTender
                .where((element) =>
                    element['pickup'] == dataRuteTender[index]['pickup'] &&
                    element['destinasi'] == dataRuteTender[index]['destinasi'])
                .toList()
                .length >
            1) {
      validasiSimpan = false;
      dataRuteTender[index]['error_lokasi_kembar'] =
          "ProsesTenderCreateLabelAlertDataRuteSama"
              .tr; //Data rute tidak boleh sama
    } else {
      validasiSimpan = true;
      dataRuteTender[index]['error_lokasi_kembar'] = "";
    }
  }

  Widget unitTrukRuteDitenderkanTenderWidget(int index) {
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
                      "ProsesTenderDetailLabelRute".tr +
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
                                'ProsesTenderDetailLabelJenisTruk'
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
                                  'ProsesTenderDetailLabelJumlah'.tr, // Jumlah
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
                            : SizedBox(),
                    ],
                  ))
            ],
          )
        : SizedBox());
  }

  Widget beratRuteDitenderkanTenderWidget(int index) {
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
                      "ProsesTenderDetailLabelRute".tr +
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
                                    "ProsesTenderDetailLabelPickUp".tr, //Pickup
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
                                      "ProsesTenderDetailLabelDestinasi"
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
                                      "ProsesTenderDetailLabelBerat"
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

  Widget volumeRuteDitenderkanTenderWidget(int index) {
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
                      "ProsesTenderDetailLabelRute".tr +
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
                                    "ProsesTenderDetailLabelPickUp".tr, //Pickup
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
                                      "ProsesTenderDetailLabelDestinasi"
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
                                      "ProsesTenderDetailLabelVolume"
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
                                          keteranganSatuanVolume.value,
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

  //FOURTH PAGE

  DateTime firstDate(int index, String jenis) {
    DateTime date = dateNow;

    if (jenis == 'awal') {
      if (index != 1) {
        //CEK TANGGAL AKIR KOSONG ATAU TIDAk, KALAU KOSONG ISI TANGGAL SEKARANG
        if (dataTahapTender[index - 1]['max_date'] != "") {
          date = dataTahapTender[index - 1]['max_date'];
        }
      }

      // index==0
      //  ? await GlobalVariable.getDateTimeFromServer(Get.context)
      //  : dataTahapTender[index]['min_date'] == ""
      //      ? dataTahapTender[index - 1]['max_date'] == ""?
      //        await GlobalVariable.getDateTimeFromServer(Get.context)
      //        :dataTahapTender[index - 1]['max_date']
      //      : dataTahapTender[index - 1]['max_date']
      //                  .compareTo(dataTahapTender[index]
      //                      ['min_date']) >
      //              0
      //          ? dataTahapTender[index - 1]['max_date']
      //          : dataTahapTender[index]['min_date']
    } else if (jenis == 'akhir') {
      if (index == 1) {
        if (dataTahapTender[index]['min_date'] != "") {
          date = dataTahapTender[index]['min_date'];
        }
      } else {
        if (dataTahapTender[index]['min_date'] != "" &&
            dataTahapTender[index - 1]['max_date'] != "" &&
            dataTahapTender[index - 1]['max_date']
                    .compareTo(dataTahapTender[index]['min_date']) >=
                0) {
          date = dataTahapTender[index - 1]['max_date'];
        } else if (dataTahapTender[index]['min_date'] != "" &&
            dataTahapTender[index - 1]['max_date'] != "" &&
            dataTahapTender[index]['min_date']
                    .compareTo(dataTahapTender[index - 1]['max_date']) >
                0) {
          date = dataTahapTender[index]['min_date'];
        } else {
          if (dataTahapTender[index]['min_date'] != '') {
            date = dataTahapTender[index]['min_date'];
          } else if (dataTahapTender[index - 1]['max_date'] != '') {
            date = dataTahapTender[index - 1]['max_date'];
          }
        }
      }
      // index == 0
      //                     ? dataTahapTender[index]['min_date'] !=
      //                             "" // JIKA TANGGAL AWAL SUDAH DIISI, MAKA TANGGAL SEBELUM TANGGAL ARAL INI DISABLE
      //                         ? dataTahapTender[index]['min_date']
      //                                     .compareTo(await GlobalVariable.getDateTimeFromServer(Get.context)) >
      //                                 0
      //                             // JIKA TANGGAL AWAL TAHAP INI LEBIH BESAR DARI TANGGAL HARI INI, MAKA TANGGAL HARI INI DISABLE
      //                             ? dataTahapTender[index]['min_date']
      //                             : await GlobalVariable.getDateTimeFromServer(Get.context)
      //                         : await GlobalVariable.getDateTimeFromServer(Get.context)
      //                     : dataTahapTender[index]['min_date'] !=
      //                             "" // JIKA TANGGAL AWAL SUDAH DIISI, MAKA TANGGAL SEBELUM TANGGAL AWAL DISABLE
      //                         ? dataTahapTender[index]['min_date'].compareTo(
      //                                     dataTahapTender[index - 1]
      //                                         ['max_date']) >
      //                                 0
      //                             // JIKA TANGGAL AWAL TAHAP INI LEBIH BESAR DARI TANGGAL AKHIR TAHAP TENDER SEBELUMNYA, MAKA TANGGAL SEBELUM TANGGAL AWAL TAHAP INI DISABLE
      //                             ? dataTahapTender[index]['min_date']
      //                             : dataTahapTender[index - 1]
      //                                 ['max_date'] // JIKA KEBALIKAN NYA, TANGGAL AKHIR SEBELUM TAHAP INI DISABLE
      //                         : dataTahapTender[index - 1]['max_date']
    }

    return date;
  }

  DateTime initDate(int index, String jenis) {
    DateTime date = dateNow;
    if (jenis == 'awal') {
      if (index == 1) {
        if (dataTahapTender[index]['min_date'] != '') {
          date = dataTahapTender[index]['min_date'];
        }
      } else {
        if ((dataTahapTender[index]['min_date'] != '' &&
                dataTahapTender[index - 1]['max_date'] != '') &&
            dataTahapTender[index - 1]['max_date']
                    .compareTo(dataTahapTender[index]['min_date']) >=
                0) {
          date = dataTahapTender[index - 1]['max_date'];
        } else if ((dataTahapTender[index]['min_date'] != '' &&
                dataTahapTender[index - 1]['max_date'] != '') &&
            dataTahapTender[index - 1]['max_date']
                    .compareTo(dataTahapTender[index]['min_date']) <
                0) {
          date = dataTahapTender[index]['min_date'];
        } else {
          if (dataTahapTender[index]['min_date'] != '') {
            date = dataTahapTender[index]['min_date'];
          } else if (dataTahapTender[index - 1]['max_date'] != '') {
            date = dataTahapTender[index - 1]['max_date'];
          }
        }
      }

      // dataTahapTender[index]['min_date'] == ''
      //                     ? index ==
      //                             0 // JIKA TAHAP TENDER "INFO PRA TENDER", ISI DENGAN TANGGAL SEKARANG
      //                         ? await GlobalVariable.getDateTimeFromServer(Get.context)
      //                         : dataTahapTender[index - 1]['max_date'] == ''
      //                             ? await GlobalVariable.getDateTimeFromServer(Get.context)
      //                             : dataTahapTender[index - 1]['max_date']
      //                     : index ==
      //                             0 // JIKA TAHAP TENDER "INFO PRA TENDER", ISI DENGAN TANGGAL SEKARANG
      //                         ? dataTahapTender[index]['min_date']
      //                         : dataTahapTender[index - 1]['max_date']
      //                                     .compareTo(dataTahapTender[index]
      //                                         ['min_date']) >
      //                                 0
      //                             ? dataTahapTender[index - 1]['max_date']
      //                             : dataTahapTender[index]['min_date']
    } else if (jenis == 'akhir') {
      if (index == 1) {
        if (dataTahapTender[index]['min_date'] != "") {
          date = dataTahapTender[index]['min_date'];
        }
      } else {
        if (dataTahapTender[index]['min_date'] != "" &&
            dataTahapTender[index - 1]['max_date'] != "" &&
            dataTahapTender[index - 1]['max_date']
                    .compareTo(dataTahapTender[index]['min_date']) >=
                0) {
          date = dataTahapTender[index - 1]['max_date'];
        } else if (dataTahapTender[index]['min_date'] != "" &&
            dataTahapTender[index - 1]['max_date'] != "" &&
            dataTahapTender[index]['min_date']
                    .compareTo(dataTahapTender[index - 1]['max_date']) >
                0) {
          date = dataTahapTender[index]['min_date'];
        } else {
          if (dataTahapTender[index]['min_date'] != '') {
            date = dataTahapTender[index]['min_date'];
          } else if (dataTahapTender[index - 1]['max_date'] != '') {
            date = dataTahapTender[index - 1]['max_date'];
          }
        }
      }

      if (dataTahapTender[index]['max_date'] != '' &&
          dataTahapTender[index]['max_date'].compareTo(date) > 0) {
        date = dataTahapTender[index]['max_date'];
      }

      // index ==
      //                       0 // JIKA TAHAP TENDER "INFO PRA TENDER", ISI DENGAN TANGGAL SEKARANG
      //                   ? dataTahapTender[index]['max_date'] == ''
      //                       ? dataTahapTender[index]['min_date']
      //                                   .compareTo(await GlobalVariable.getDateTimeFromServer(Get.context)) >
      //                               0
      //                           ? // JIKA TAHAP TENDER "INFO PRA TENDER", PILIH TANGGAL TAHAP INI LEBIH BESAR DARI TANGGAL SEKARANG, MAKA PILIH TANGGAL PERIODE INI
      //                           dataTahapTender[index]['min_date']
      //                           : await GlobalVariable.getDateTimeFromServer(Get.context)
      //                       : dataTahapTender[index]['min_date'].compareTo(
      //                                   dataTahapTender[index]['max_date']) >
      //                               0
      //                           ? dataTahapTender[index]['min_date']
      //                           : dataTahapTender[index]['max_date']
      //                   : dataTahapTender[index]['min_date']
    }

    return date;
  }

  void getTruk(index) async {
    print(dataTrukTender[index]['jenis_carrier']);
    print(dataTrukTender[index]['jenis_truk']);
    var result = await GetToPage.toNamed<SelectHeadCarrierController>(
        Routes.SELECT_HEAD_CARRIER_TRUCK,
        arguments: ['0', dataTrukTender[index]['jenis_truk']]);
    if (result != null) {
      dataTrukTender[index]['nama_truk'] = result['Description'];
      dataTrukTender[index]['jenis_truk'] = result['ID'];
      dataTrukController[index].text = dataTrukTender[index]['nama_truk'];

      dataTrukTender[index]['nama_carrier'] =
          'ProsesTenderCreateLabelJenisCarrier'.tr; // Jenis Carrier
      dataTrukTender[index]['jenis_carrier'] = 0;
      dataTrukTender[index]['gambar_truk'] = '';
      dataCarrierController[index].text = '';

      dataTrukTender.refresh();
      dataTrukController.refresh();
      dataCarrierController.refresh();
    }
  }

  void getCarrier(index) async {
    print(dataTrukTender[index]);
    print(dataTrukTender[index]['jenis_carrier']);
    print(dataTrukTender[index]['jenis_truk']);
    var result = await GetToPage.toNamed<SelectHeadCarrierController>(
        Routes.SELECT_HEAD_CARRIER_TRUCK,
        arguments: [
          '1',
          dataTrukTender[index]['jenis_carrier'],
          dataTrukTender[index]['jenis_truk']
        ]);
    if (result != null) {
      print(result);
      dataTrukTender[index]['nama_carrier'] = result['Description'];
      dataTrukTender[index]['jenis_carrier'] = result['ID'];
      dataCarrierController[index].text = dataTrukTender[index]['nama_carrier'];
      dataCarrierController.refresh();
      dataTrukTender.refresh();

      for (var x = 0; x < 3; x++) {
        dataRuteTender[x]['data'][index]['jenis_truk'] =
            dataTrukTender[index]['jenis_truk'];
        dataRuteTender[x]['data'][index]['jenis_carrier'] =
            dataTrukTender[index]['jenis_carrier'];
        dataRuteTender[x]['data'][index]['nama_truk'] =
            dataTrukTender[index]['nama_truk'];
        dataRuteTender[x]['data'][index]['nama_carrier'] =
            dataTrukTender[index]['nama_carrier'];
      }

      dataRuteTender.refresh();
      checkImage(index);
    }
  }

  bool cekRuteDitenderkanSudahAda() {
    print(dataRuteTender);
    print(dataTrukTender);
    var sudahAda = false;

    for (var x = 0; x < dataRuteTender.length; x++) {
      for (var y = 0; y < dataRuteTender[x]['data'].length; y++) {
        if (dataRuteTender[x]['data'][y]['nilai'] != 0 ||
            dataRuteTender[x]['pickup'] != "" ||
            dataRuteTender[x]['destinasi'] != "") {
          sudahAda = true;
        }
      }
    }

    return sudahAda;
  }

  bool cekJumlahTrukSebelumnyaBeda() {
    print('CEK JUMLAH TRUK SEBELUMNYA');
    print(dataTrukTender);
    print(dataTrukTenderSebelumnya);
    var beda = false;
    for (var x = 0; x < dataTrukTender.length; x++) {
      for (var y = 0; y < dataTrukTenderSebelumnya.length; y++) {
        if (dataTrukTender[x]['jenis_truk'] ==
                dataTrukTenderSebelumnya[y]['jenis_truk'] &&
            dataTrukTender[x]['jenis_carrier'] ==
                dataTrukTenderSebelumnya[y]['jenis_carrier'] &&
            dataTrukTender[x]['jumlah_truck'] !=
                dataTrukTenderSebelumnya[y]['jumlah_truck']) {
          beda = true;
        }
      }
    }

    return beda;
  }

  void setUlangDataRute() {
    //DATA RUTE TENDER DITAMBAHKAN
    for (var x = 0; x < 3; x++) {
      dataRuteTender[x]['data'].clear();
      for (var y = 0; y < dataTrukTender.length; y++) {
        var jsonData = {
          'jenis_truk': dataTrukTender[y]['jenis_truk'],
          'nama_truk': dataTrukTender[y]['nama_truk'],
          'jenis_carrier': dataTrukTender[y]['jenis_carrier'],
          'nama_carrier': dataTrukTender[y]['nama_carrier'],
          'nilai': 0,
          'error': ''
        };
        dataRuteTender[x]['data'].add(jsonData);
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
        onDownloading.value = false;
        Get.back();

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

  void shareData(String link, bool usingBaseFileLink) async {
    var namaFile = GlobalVariable.formatNamaFile(link.split("/").last);

    var savedLocation = await _getLocalPath() + "/" + namaFile;
    print(savedLocation);
    var existed = await File(savedLocation).exists();
    print(existed);
    //JIKA SUDAH PERNAH DIDOWNLOAD ARAHKAN KE LOCAL
    if (existed) {
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

  void resetJenisTender() {
    cekdaftarpeserta.value = false;
    cekdatarutedanhargapenawaran.value = false;
    cekdaftarpemenang.value = false;
    cekdataalokasipemenang.value = false;
    cekPeserta();
    cekPemenang();
  }

  void cekPeserta() {
    tertutupPesertaTender.value = 0;
    if (cekdaftarpeserta.value) {
      tertutupPesertaTender.value = 3;
    } else if (cekdatarutedanhargapenawaran.value) {
      tertutupPesertaTender.value = 2;
    }
    print(tertutupPesertaTender.value);
  }

  void cekPemenang() {
    tertutupPemenangTender.value = 0;
    if (cekdaftarpemenang.value) {
      tertutupPemenangTender.value = 3;
    } else if (cekdataalokasipemenang.value) {
      tertutupPemenangTender.value = 2;
    }
    print(tertutupPemenangTender.value);
  }

  void hapusInfoPraTender() async {
    kodePraTender.value = "";
    idPraTender = "";
  }

  void cekCheckboxButtonPeserta() {
    cekdaftarpeserta.value = false;
    cekdatarutedanhargapenawaran.value = false;
    if (tertutupPesertaTender.value == 2) {
      cekdatarutedanhargapenawaran.value = true;
    } else if (tertutupPesertaTender.value == 3) {
      cekdaftarpeserta.value = true;
      cekdatarutedanhargapenawaran.value = true;
    }
  }

  void cekCheckboxButtonPemenang() {
    cekdaftarpemenang.value = false;
    cekdataalokasipemenang.value = false;
    if (tertutupPemenangTender.value == 2) {
      cekdataalokasipemenang.value = true;
    } else if (tertutupPemenangTender.value == 3) {
      cekdaftarpemenang.value = true;
      cekdataalokasipemenang.value = true;
    }
  }

  void lihatInformasiTenderTertutup(jenisTertutup) async {
    FocusManager.instance.primaryFocus.unfocus();
    var data = await GetToPage.toNamed<InformasiProsesTenderController>(
        Routes.INFORMASI_PROSES_TENDER,
        arguments: [
          cekdaftarpeserta,
          cekdatarutedanhargapenawaran,
          cekdaftarpemenang,
          cekdataalokasipemenang,
          jenisTertutup
        ]);
  }
}
