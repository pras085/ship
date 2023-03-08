import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/list_data_design_type_button_corner_right_enum.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/core/models/checkbox_filter_model.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/core/controllers/filter_controller_custom.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/satuan_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta/list_halaman_peserta_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/search_pemenang_tender/search_pemenang_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListTentukanPemenangTenderController extends GetxController
    with SingleGetTickerProviderMixin {
  var isLoadingData = true.obs;
  var listProsesTenderBelumDiumumkan = [].obs;
  var jumlahDataBelumDiumumkan = 0.obs;
  double maxKoli = 0;
  double maxJumlah = 0;
  double maxJumlahUnitTruk = 0;
  double maxJumlahBerat = 0;
  double maxJumlahVolume = 0;
  double maxPeserta = 0;
  var countDataBelumDiumumkan = 1.obs;
  var firstTimeBelumDiumumkan = true;

  String tagBelumDiumumkan = "1001";

  var showFirstTime = true.obs;
  String filePath = "";

  var filterBelumDiumumkan = {}.obs; //UNTUK FILTER PENCARIAN BELUMDIUMUMKAN
  bool isFilterBelumDiumumkan =
      false; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK

  var sortByBelumDiumumkan = ''.obs; //UNTUK SORT BERDASARKAN APA
  Map<String, dynamic> mapSortByBelumDiumumkan =
      {}; //UNTUK DAPATKAN DATA MAP SORT BELUMDIUMUMKAN
  var sortTypeBelumDiumumkan = ''.obs; //UNTUK URUTAN SORTNYA
  var search = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD
  var listMuatanBelumDiumumkan = [].obs;
  var listDiumumkanBelumDiumumkan = [].obs;
  RefreshController refreshBelumDiumumkanController =
      RefreshController(initialRefresh: false);

  SortingController _sortingBelumDiumumkanController;

  FilterCustomControllerArk _filterBelumDiumumkanCustomController;

  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var status = 0.obs;
  List<DataListSortingModel> belumdiumumkanSort = [];
  var dataMaxJumlahUnitTruckBelumDiumumkan = 0.0.obs;
  var dataMaxJumlahBeratBelumDiumumkan = 0.0.obs;
  var dataMaxJumlahVolumeBelumDiumumkan = 0.0.obs;
  var dataMaxJumlahBelumDiumumkan = 0.0.obs;
  var dataMaxKoliBelumDiumumkan = 0.0.obs;
  var dataMaxPesertaBelumDiumumkan = 0.0.obs;

  var jenisTender = ''; //BERAKHIR , 3HARI

  var cekPilihPemenang = false;
  var cekUmumkan = false;
  var cekDetail = false;

  @override
  void onInit() async {
    cekPilihPemenang =
        await SharedPreferencesHelper.getHakAkses("Pilih Pemenang");
    cekUmumkan =
        await SharedPreferencesHelper.getHakAkses("Umumkan Lebih Awal");
    cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Tender");

    jenisTender = Get.arguments[5];

    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);

    //await SharedPreferencesHelper.setPemenangTenderPertamaKali(true);
    showFirstTime.value =
        await SharedPreferencesHelper.getPemenangTenderPertamaKali();

    belumdiumumkanSort = [
      DataListSortingModel(
          'PemenangTenderIndexLabelNomor'.tr,
          'kode_td',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'PemenangTenderIndexLabelJudul'.tr,
          'judul',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'PemenangTenderIndexLabelTanggalAwalSeleksi'.tr,
          'Created',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'PemenangTenderIndexLabelTanggalAkhirSeleksi'.tr,
          'Created',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'PemenangTenderIndexLabelTanggalAwalPengumuman'.tr,
          'Created',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'PemenangTenderIndexLabelTanggalAkhirPengumuman'.tr,
          'Created',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'PemenangTenderIndexLabelLokasiPickUp'.tr,
          'pickup',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'PemenangTenderIndexLabelLokasiDestinasi'.tr,
          'destinasi',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'PemenangTenderIndexLabelMuatan'.tr,
          'muatan',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'PemenangTenderIndexLabelPemenang'.tr,
          'jumlah_peserta',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
    ];

    _sortingBelumDiumumkanController = Get.put(
        SortingController(
            listSort: belumdiumumkanSort,
            initMap: mapSortByBelumDiumumkan,
            onRefreshData: (map) async {
              countDataBelumDiumumkan.value = 1;
              print('BELUMDIUMUMKAN');
              listProsesTenderBelumDiumumkan.clear();
              sortByBelumDiumumkan.value = "";
              sortTypeBelumDiumumkan.value = "";

              var index = 0;
              map.keys.forEach((element) {
                index++;
                sortByBelumDiumumkan.value += element;
                if (index < map.keys.length) {
                  sortByBelumDiumumkan.value += ", ";
                }
              });

              index = 0;
              map.values.forEach((element) {
                index++;
                sortTypeBelumDiumumkan.value += element;
                if (index < map.values.length) {
                  sortTypeBelumDiumumkan.value += ", ";
                }
              });

              mapSortByBelumDiumumkan = map;

              print('NEW MAPS');
              print(map);

              isLoadingData.value = true;

              print(isLoadingData);
              print(firstTimeBelumDiumumkan);
              await getListTender(1, "BelumDiumumkan", filterBelumDiumumkan);
            }),
        tag: tagBelumDiumumkan);

    await getListTender(1, "BelumDiumumkan", filterBelumDiumumkan);

    isLoadingData.value = false;

    print(firstTimeBelumDiumumkan);
    print(isLoadingData);
    print('TES');
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void showSortingDialog() async {
    print("MAP SORT BELUMDIUMUMKAN");
    print(mapSortByBelumDiumumkan);

    _sortingBelumDiumumkanController.showSort();
    print('BELUMDIUMUMKAN');
  }

  void _clearSorting() {
    _sortingBelumDiumumkanController.clearSorting();
    print('BELUMDIUMUMKAN');
  }

  void reset() async {
    _resetSearchSortingFilter();
  }

  void refreshAll() async {
    listProsesTenderBelumDiumumkan.clear();
    isLoadingData.value = true;
    countDataBelumDiumumkan.value = 1;
    await getListTender(1, 'BelumDiumumkan', filterBelumDiumumkan);
  }

  void goToSearchPage() async {
    var sortBy = "";
    var sortType = "";
    var mapSort = {};
    var sortList = [];

    sortList = belumdiumumkanSort;

    // if ("BelumDiumumkan" == "BelumDiumumkan") {
    //   sortBy = sortByBelumDiumumkan.value;
    //   sortType = sortTypeBelumDiumumkan.value;
    //   mapSort = mapSortByBelumDiumumkan;
    //   sortList = belumdiumumkanSort;
    // } else {
    //   sortBy = sortByDiumumkan.value;
    //   sortType = sortTypeDiumumkan.value;
    //   mapSort = mapSortByDiumumkan;
    //   sortList = diumumkanSort;
    // }

    var data = await GetToPage.toNamed<SearchPemenangTenderController>(
        Routes.SEARCH_PEMENANG_TENDER,
        arguments: [
          "BelumDiumumkan",
          sortBy,
          sortType,
          mapSort,
          sortList,
          jenisTender
        ]);

    if (data != null) {
      isLoadingData.value = true;
      listProsesTenderBelumDiumumkan.clear();
      listProsesTenderBelumDiumumkan.refresh();
      await getListTender(1, "BelumDiumumkan", filterBelumDiumumkan);
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

  void shareListProsesTender() async {
    var diumumkan = "0";
    var tglawal = "2500-12-31";
    var tglakhir = "1900-01-01";
    if ("BelumDiumumkan" == 'BelumDiumumkan') {
      diumumkan = "0";
      print(listProsesTenderBelumDiumumkan.length);
      //TANGGAL AWAL
      for (var x = 0; x < listProsesTenderBelumDiumumkan.length; x++) {
        if (tglawal.compareTo(
                listProsesTenderBelumDiumumkan[x]['tanggalDibuatRaw']) >
            0) {
          tglawal = listProsesTenderBelumDiumumkan[x]['tanggalDibuatRaw'];
        }
      }

      //TANGGAL AKHIR
      for (var x = 0; x < listProsesTenderBelumDiumumkan.length; x++) {
        if (tglakhir.compareTo(
                listProsesTenderBelumDiumumkan[x]['tanggalDibuatRaw']) <
            0) {
          tglakhir = listProsesTenderBelumDiumumkan[x]['tanggalDibuatRaw'];
        }
      }
    }

    String id = await SharedPreferencesHelper.getUserShipperID();

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

    onDownloading.value = true;

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .sharePDFListPemenangTender(id, tglawal, tglakhir, diumumkan);

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

  void _resetSearchSortingFilter() async {
    //SET ULANG
    search.value = '';
    listProsesTenderBelumDiumumkan.clear();
    countDataBelumDiumumkan.value = 1;
    filterBelumDiumumkan.clear();
    sortByBelumDiumumkan.value = '';
    sortTypeBelumDiumumkan.value = 'DESC';

    isLoadingData.value = true;
    await getListTender(1, "BelumDiumumkan", filterBelumDiumumkan);
  }

  Future getListTender(int page, String pageName, datafilter) async {
    String ID = "";
    String isShipper = "";
    isShipper = "1";
    ID = await SharedPreferencesHelper.getUserShipperID();

    String LangLink = '';
    String RealLink = '';
    String diumumkan = '0';

    LangLink = 'ProsesTenderBelumDiumumkanGrid';
    RealLink = 'ProsesTenderBelumDiumumkanGrid';
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListPemenangTender(
            ID,
            '10',
            page.toString(),
            sortByBelumDiumumkan.value,
            search.value,
            sortTypeBelumDiumumkan.value,
            filterBelumDiumumkan,
            pageName,
            LangLink,
            RealLink,
            isShipper,
            diumumkan,
            jenisBelumDiumumkan: jenisTender == "BERAKHIR"
                ? "0"
                : jenisTender == "3HARI"
                    ? "1"
                    : null);

    print(filterBelumDiumumkan);
    if (result['Message']['Code'].toString() == '200') {
      firstTimeBelumDiumumkan = false;
      var data = result['Data'];

      if (data.length == 0 && page > 1) {
        countDataBelumDiumumkan.value -= 1;
      }

      (data as List).forEach((element) {
        listProsesTenderBelumDiumumkan.add({
          'id': element['ID'].toString(),
          'kode': element['Kode'],
          'tanggalDibuatRaw': element['TanggalDibuatRaw'],
          'tanggalDibuat': element['TanggalDibuat'].split(" ")[0] +
              " " +
              element['TanggalDibuat'].split(" ")[1] +
              " " +
              element['TanggalDibuat'].split(" ")[2],
          'jamDibuat': element['TanggalDibuat'].split(" ")[3],
          'tanggalDiputuskanRaw': element['TanggalDiputuskanRaw'] ?? '',
          'tanggalDiputuskan': element['TanggalDiputuskan'] != null
              ? (element['TanggalDiputuskan'].split(" ")[0] +
                  " " +
                  element['TanggalDiputuskan'].split(" ")[1] +
                  " " +
                  element['TanggalDiputuskan'].split(" ")[2])
              : '',
          'jamDiputuskan': element['TanggalDiputuskan'] != null
              ? element['TanggalDiputuskan'].split(" ")[3]
              : '',
          'zonaWaktu': element['ZonaWaktu'],
          'judul': element['Judul'],
          'rute': element['ImplodedRute'],
          'muatan': element['Muatan'],
          'status': element['StatusKey'].toString(),
          'labelPeriode': false,
          'pemenang': element['Pemenang'],
          'periodeSeleksi': element['TahapSeleksi'] ?? "",
          'periodePengumuman': element['TahapPengumuman'] ?? "",
          'sudahAdaPemenang': element['hasWinner'],
          'sisaHari': element['CounterSeleksi'],
        });
      });
      jumlahDataBelumDiumumkan.value =
          result['SupportingData']['RealCountData'];
      refreshBelumDiumumkanController.loadComplete();
    }

    listProsesTenderBelumDiumumkan.refresh();
    isLoadingData.value = false;
  }

  void opsi(idTender, sudahAdaPemenang) {
    showModalBottomSheet(
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 17.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 4,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 11),
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: 3.0,
                      color: Color(ListColor.colorLightGrey16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_simple.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                        onTap: () async {
                          Get.back();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 3),
                        child: CustomText(
                            'PemenangTenderIndexLabelJudulPopUpOpsi'
                                .tr, //'Opsi'.tr,
                            color: Color(ListColor.colorBlue),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 18)
                    ],
                  ),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  listTitleWidget(
                      'PemenangTenderIndexLabelButtonDetail'.tr, //'Detail',
                      'DETAIL',
                      idTender,
                      cekDetail),
                  "BelumDiumumkan" == "BelumDiumumkan" && sudahAdaPemenang
                      ? lineDividerWidget()
                      : SizedBox(),
                  "BelumDiumumkan" == "BelumDiumumkan" && sudahAdaPemenang
                      ? listTitleWidget(
                          'PemenangTenderIndexLabelOpsiUmumkanLebihAwal'
                              .tr, //'Umumkan Lebih Awal',
                          'UMUMKAN LEBIH AWAL',
                          idTender,
                          cekUmumkan)
                      : SizedBox(),
                ],
              ),
            ));
  }

  /*
    String text = nama tile
    String fungsi = nama fungsi
  */
  Widget listTitleWidget(
      String text, String fungsi, String idTender, bool akses) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(Get.context).size.width -
            GlobalVariable.ratioWidth(Get.context) * 32,
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 12),
        alignment: Alignment.topLeft,
        child: CustomText(text.tr,
            color: akses ? Colors.black : Color(ListColor.colorAksesDisable),
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Get.back();
        if (fungsi == 'DETAIL') detail(idTender);
        if (fungsi == 'UMUMKAN LEBIH AWAL') umumkan(idTender);
      },
    );
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 0.5,
        color: Color(ListColor.colorLightGrey10),
        height: 0,
      ),
    );
  }

  void peserta(String idTender) async {
    getDetail(idTender);
  }

  void detail(String idTender) async {
     cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Tender",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekDetail)) {
      var data = await GetToPage.toNamed<DetailProsesTenderController>(
          Routes.DETAIL_PROSES_TENDER,
          arguments: [idTender, "BelumDiumumkan"]);

      if (data == null) {
        refreshAll();
      }
    }
  }

  void umumkan(String idTender) async {
    cekUmumkan =
        await SharedPreferencesHelper.getHakAkses("Umumkan Lebih Awal",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekUmumkan)) {
      GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          title:
              "PemenangTenderIndexLabelUmumkanPemenang".tr, //Umumkan Pemenang
          message: "PemenangTenderIndexLabelApakahAndaYakinInginMengumumkan"
              .tr, //Apakah anda yakin ingin mengumumkan
          labelButtonPriority1: GlobalAlertDialog.noLabelButton,
          onTapPriority1: () {},
          onTapPriority2: () async {
            showDialog(
                context: Get.context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return WillPopScope(
                      onWillPop: () {},
                      child: Center(child: CircularProgressIndicator()));
                });

            var result = await ApiHelper(
                    context: Get.context,
                    isShowDialogLoading: false,
                    isShowDialogError: false)
                .setUmumkanLebihAwal(idTender);

            if (result['Message']['Code'].toString() == '200') {
              CustomToast.show(
                  context: Get.context,
                  message:
                      "ProsesTenderDetailLabelBerhasilMengumumkanPemenang".tr);
              Get.back();
              refreshAll();
            }
          },
          labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
    }
  }

  Future getDetail(String idTender) async {
     cekPilihPemenang =
        await SharedPreferencesHelper.getHakAkses("Pilih Pemenang",denganLoading:true);
    if (cekPilihPemenang) {
      showDialog(
          context: Get.context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () {},
                child: Center(child: CircularProgressIndicator()));
          });
      String id = await SharedPreferencesHelper.getUserShipperID();

      var result = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getDetailProsesTender(id, idTender);

      if (result['Message']['Code'].toString() == '200') {
        var data = result['Data'];

        var dataTahapTender = [];
        var dataTrukTender = [];
        var dataRuteTender = [];

        //First page
        print("FIRST PAGE");

        for (var x = 0; x < data['tahap_tender'].length; x++) {
          //0 Karena Info Pra Tender, jadi dikosongi saja
          if (x == 0) {
            //KALAU TIDAK ADA INFO PRA TENDER< TAMBAHKAN
            if (data['tahap_tender'][x]['tahap_tender'] != 1) {
              dataTahapTender.add({
                'tahap_tender': 1,
                'show_first_date': '',
                'show_last_date': '',
                'min_date': '',
                'max_date': '',
              });

              dataTahapTender.add({
                'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
                'show_first_date': DateFormat('dd MMM yyyy')
                    .format(DateTime.parse(
                        data['tahap_tender'][x]['tanggal_dimulai']))
                    .toString(),
                'show_last_date': DateFormat('dd MMM yyyy')
                    .format(DateTime.parse(
                        data['tahap_tender'][x]['tanggal_akhir']))
                    .toString(),
                'min_date':
                    DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai']),
                'max_date':
                    DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']),
              });
            } else {
              //KALAU ADA INFO PRA TENDER
              dataTahapTender.add({
                'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
                'show_first_date': '',
                'show_last_date': '',
                'min_date': '',
                'max_date': '',
              });
            }
          } else {
            dataTahapTender.add({
              'tahap_tender': data['tahap_tender'][x]['tahap_tender'],
              'show_first_date': DateFormat('dd MMM yyyy')
                  .format(DateTime.parse(
                      data['tahap_tender'][x]['tanggal_dimulai']))
                  .toString(),
              'show_last_date': DateFormat('dd MMM yyyy')
                  .format(
                      DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']))
                  .toString(),
              'min_date':
                  DateTime.parse(data['tahap_tender'][x]['tanggal_dimulai']),
              'max_date':
                  DateTime.parse(data['tahap_tender'][x]['tanggal_akhir']),
            });
          }
        }
        print(dataTahapTender);

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
          if (data['satuan_tender'] == 2) {
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
        print(dataRuteTender);
        var jumlahYangDigunakan = 0;

        if (data['satuan_tender'] == 2) {
          for (var x = 0; x < dataRuteTender.length; x++) {
            for (var y = 0; y < dataRuteTender[x]['data'].length; y++) {
              jumlahYangDigunakan += dataRuteTender[x]['data'][y]['nilai'];
            }
          }
        } else if (data['satuan_tender'] == 1) {
          for (var x = 0; x < dataRuteTender.length; x++) {
            jumlahYangDigunakan += dataRuteTender[x]['data'][0]['nilai'];
          }
        } else if (data['satuan_tender'] == 3) {
          for (var x = 0; x < dataRuteTender.length; x++) {
            jumlahYangDigunakan += dataRuteTender[x]['data'][0]['nilai'];
          }
        }

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

        var idPraTender = data['info_pratenderID'].toString();
        var kodePraTender = data['kode_pratender'];
        var idTender = data['ID'];
        var kodeTender = data['kode_td'];
        var judulPraTender = data['judul'];
        Get.back();
        await GetToPage.toNamed<ListHalamanPesertaController>(
            Routes.LIST_HALAMAN_PESERTA,
            arguments: [
              idTender,
              kodeTender,
              kodePraTender,
              judulPraTender,
              data['nama_muatan'].toString() +
                  " (" +
                  arrJenisMuatan[data['jenis_muatan']].toString() +
                  ") ",
              dataTahapTender[3]['show_first_date'],
              dataTahapTender[3]['show_last_date'],
              dataTahapTender[3]['min_date'],
              dataRuteTender,
              data['satuan_tender'],
              arrSatuanVolume[data['satuan_volume']],
              jumlahYangDigunakan,
              dataTahapTender[2]['min_date'],
            ]);
        refreshAll();
      }
    } else {
      SharedPreferencesHelper.cekAkses(cekPilihPemenang);
    }
  }
}
