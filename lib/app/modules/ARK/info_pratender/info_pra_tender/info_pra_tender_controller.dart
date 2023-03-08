import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/satuan_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/create_info_pra_tender/create_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/edit_info_pra_tender/edit_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/search_info_pra_tender/search_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/create_proses_tender/create_proses_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class InfoPraTenderController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;
  var posTab = 0.obs;
  var isLoadingData = true.obs;
  var listInfoPraTenderAktif = [].obs;
  var listInfoPraTenderHistory = [].obs;
  var jumlahDataAktif = 0.obs;
  var jumlahDataHistory = 0.obs;
  double maxKoli = 0;
  double maxJumlah = 0;
  double maxJumlahUnitTruk = 0;
  double maxJumlahBerat = 0;
  double maxJumlahVolume = 0;
  var countDataAktif = 1.obs;
  var countDataHistory = 1.obs;
  var firstTimeAktif = true;
  var firstTimeHistory = true;

  String tagAktif = "0";
  String tagHistory = "1000";

  var showFirstTime = true.obs;
  String filePath = "";
  var popUpYellow = true.obs;
  var jenisTab = 'Aktif'.obs; // History

  var filterAktif = {}.obs; //UNTUK FILTER PENCARIAN AKTIF
  bool isFilterAktif = false; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK
  var filterHistory = {}.obs; //UNTUK FILTER PENCARIAN HISTORY
  bool isFilterHistory = false; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK

  var sortByAktif = ''.obs; //UNTUK SORT BERDASARKAN APA
  Map<String, dynamic> mapSortByAktif = {}; //UNTUK DAPATKAN DATA MAP SORT AKTIF
  var sortTypeAktif = ''.obs; //UNTUK URUTAN SORTNYA
  var sortByHistory = ''.obs; //UNTUK SORT BERDASARKAN APA
  Map<String, dynamic> mapSortByHistory =
      {}; //UNTUK DAPATKAN DATA MAP SORT HISTORY
  var sortTypeHistory = ''.obs; //UNTUK URUTAN SORTNYA
  var search = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD
  var listMuatanAktif = [].obs;
  var listDiumumkanAktif = [].obs;
  var listMuatanHistory = [].obs;
  var listDiumumkanHistory = [].obs;
  RefreshController refreshAktifController =
      RefreshController(initialRefresh: false);

  RefreshController refreshHistoryController =
      RefreshController(initialRefresh: false);

  SortingController _sortingAktifController;
  SortingController _sortingHistoryController;

  FilterCustomControllerArk _filterAktifCustomController;
  FilterCustomControllerArk _filterHistoryCustomController;

  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var status = 0.obs;
  List<DataListSortingModel> aktifSort = [];
  List<DataListSortingModel> historySort = [];

  var dataMaxJumlahUnitTruckAktif = 0.0.obs;
  var dataMaxJumlahBeratAktif = 0.0.obs;
  var dataMaxJumlahVolumeAktif = 0.0.obs;
  var dataMaxJumlahAktif = 0.0.obs;
  var dataMaxKoliAktif = 0.0.obs;
  var dataMaxJumlahUnitTruckHistory = 0.0.obs;
  var dataMaxJumlahBeratHistory = 0.0.obs;
  var dataMaxJumlahVolumeHistory = 0.0.obs;
  var dataMaxJumlahHistory = 0.0.obs;
  var dataMaxKoliHistory = 0.0.obs;

  var cekTambahTender = false;
  var cekTambah = false;
  var cekEdit = false;
  var cekDetail = false;
  var cekShareAktif = false;
  var cekShareHistory = false;

  @override
  void onInit() async {
    cekTambahTender =
        await SharedPreferencesHelper.getHakAkses("Buat Proses Tender");
    cekTambah =
        await SharedPreferencesHelper.getHakAkses("Buat Info Pra Tender");
    cekEdit = await SharedPreferencesHelper.getHakAkses("Edit Info Pra Tender");
    cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Pra Tender");
    cekShareAktif = await SharedPreferencesHelper.getHakAkses(
        "Export List Info Pra Tender Aktif");
    cekShareHistory = await SharedPreferencesHelper.getHakAkses(
        "Export List Info Pra Tender History");

    print("reset filter");
    try {
      Get.delete<FilterCustomControllerArk>(tag: "Aktif");
      Get.delete<FilterCustomControllerArk>(tag: "History");
    } catch (e) {
      print(e);
    }
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);

    popUpYellow.value =
        await SharedPreferencesHelper.getInfoPraTenderYellowPopUp();

    //await SharedPreferencesHelper.setInfoPraTenderPertamaKali(true);
    showFirstTime.value =
        await SharedPreferencesHelper.getInfoPraTenderPertamaKali();

    tabController = TabController(vsync: this, length: 2);

    tabController.addListener(() {
      if (posTab.value != tabController.index) {
        posTab.value = tabController.index;
        print('tabControlleraddListener');
        _checkChangePageTab();
      }
    });

    aktifSort = [
      DataListSortingModel(
          'InfoPraTenderIndexLabelNomor'.tr,
          'kode_td',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelTanggalDibuat'.tr,
          'Created',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'InfoPraTenderIndexLabelJudul'.tr,
          'judul',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelLokasiPickUp'.tr,
          'pickup',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelLokasiDestinasi'.tr,
          'destinasi',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelMuatan'.tr,
          'muatan',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
    ];

    historySort = [
      DataListSortingModel(
          'InfoPraTenderIndexLabelNomor'.tr,
          'kode_td',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelTanggalDibuat'.tr,
          'Created',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'InfoPraTenderIndexLabelJudul'.tr,
          'judul',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelLokasiPickUp'.tr,
          'pickup',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelLokasiDestinasi'.tr,
          'destinasi',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelMuatan'.tr,
          'muatan',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
    ];

    _sortingAktifController = Get.put(
        SortingController(
            listSort: aktifSort,
            initMap: mapSortByAktif,
            onRefreshData: (map) async {
              countDataAktif.value = 1;
              print('AKTIF');
              listInfoPraTenderAktif.clear();
              //SET ULANG
              //SET ULANG
              sortByAktif.value = "";
              sortTypeAktif.value = "";

              var index = 0;
              map.keys.forEach((element) {
                index++;
                sortByAktif.value += element;
                if (index < map.keys.length) {
                  sortByAktif.value += ", ";
                }
              });

              index = 0;
              map.values.forEach((element) {
                index++;
                sortTypeAktif.value += element;
                if (index < map.values.length) {
                  sortTypeAktif.value += ", ";
                }
              });

              mapSortByAktif = map;

              print('NEW MAPS');
              print(map);

              isLoadingData.value = true;

              print(isLoadingData);
              print(firstTimeAktif);
              await getListTender(1, jenisTab.value, filterAktif);
            }),
        tag: tagAktif);

    _sortingHistoryController = Get.put(
        SortingController(
            listSort: historySort,
            initMap: mapSortByHistory,
            onRefreshData: (map) async {
              countDataHistory.value = 1;
              print('HISTORY');
              listInfoPraTenderHistory.clear(); //SET ULANG
              //SET ULANG
              sortByHistory.value = "";
              sortTypeHistory.value = "";

              var index = 0;
              map.keys.forEach((element) {
                index++;
                sortByHistory.value += element;
                if (index < map.keys.length) {
                  sortByHistory.value += ", ";
                }
              });

              index = 0;
              map.values.forEach((element) {
                index++;
                sortTypeHistory.value += element;
                if (index < map.values.length) {
                  sortTypeHistory.value += ", ";
                }
              });

              mapSortByHistory = map;
              print('NEW MAPS');
              print(map);
              isLoadingData.value = true;
              await getListTender(1, jenisTab.value, filterHistory);
            }),
        tag: tagHistory);

    // try {
    //   // print('delete');
    //   // Get.delete<FilterCustomControllerArk>();
    //   _filterAktifCustomController.resetFromPage();
    //   _filterHistoryCustomController.resetFromPage();
    //   filterHistory.clear();
    //   filterHistory.refresh();
    // } catch (e) {
    //   print(e);
    // }

    //HISTORY DI LOAD JUGA KARENA, UNTUK CEK ADA DATA ATAU TIDAK, SUPAYA JIKA DIA AKTIF KOSONG, TAPI ADA HISTORY BISA BUKA
    await getListTender(1, 'History', filterHistory);

    await getListTender(1, jenisTab.value, filterAktif);

    isLoadingData.value = false;

    print(firstTimeAktif);
    print(isLoadingData);
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void _checkChangePageTab() async {
    if (posTab.value == 0) {
      jenisTab.value = 'Aktif';
      if (firstTimeAktif) {
        isLoadingData.value = true;
        await getListTender(1, jenisTab.value, filterAktif);
      }
    } else {
      jenisTab.value = 'History';
      if (firstTimeHistory) {
        isLoadingData.value = true;
        await getListTender(1, jenisTab.value, filterHistory);
      }
    }
  }

  void onChangeTab(int pos) {
    tabController.animateTo(pos);
  }

  void showSortingDialog() async {
    print("MAP SORT AKTIF");
    print(mapSortByAktif);
    print("MAP SORT HISTORY");
    print(mapSortByHistory);

    if (jenisTab.value == "Aktif") {
      _sortingAktifController.showSort();
      print('AKTIF');
    }
    if (jenisTab.value == "History") {
      _sortingHistoryController.showSort();
      print('HISTORY');
    }
  }

  void _clearSorting() {
    if (jenisTab.value == "Aktif") {
      _sortingAktifController.clearSorting();
      print('AKTIF');
    }
    if (jenisTab.value == "History") {
      _sortingHistoryController.clearSorting();
      print('HISTORY');
    }
  }

  void showFilter() async {
    if (jenisTab.value == "Aktif") {
      _filterAktifCustomController.updateListFilterModel(
          1,
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelSatuanTender'.tr],
              typeInFilter: TypeInFilter.SATUAN,
              customValue: [
                SatuanFilterModel(
                    id: "total_truk",
                    value: "InfoPraTenderIndexLabelUnitTruk".tr,
                    min: 0,
                    max: dataMaxJumlahUnitTruckAktif.value),
                SatuanFilterModel(
                    id: "Berat",
                    value: "InfoPraTenderIndexLabelBerat".tr,
                    min: 0,
                    max: dataMaxJumlahBeratAktif.value),
                SatuanFilterModel(
                    id: "Volume",
                    value: "InfoPraTenderIndexLabelVolume".tr,
                    min: 0,
                    max: dataMaxJumlahVolumeAktif.value)
              ],
              keyParam: 'satuanTender'));
      _filterAktifCustomController.updateListFilterModel(
        2,
        WidgetFilterModel(
            label: ['InfoPraTenderIndexLabelJumlah'.tr],
            typeInFilter: TypeInFilter.UNIT_SATUAN,
            customValue: [0.0, dataMaxJumlahAktif.value],
            // initValue: [1], // Isi nomor widget typeinfilter.satuan
            keyParam: 'jumlahMin_jumlahMax'),
      );
      _filterAktifCustomController.updateListFilterModel(
          3,
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelJumlahKoli'.tr],
              typeInFilter: TypeInFilter.UNIT,
              customValue: [0.0, dataMaxKoliAktif.value],
              keyParam: 'jumlah_koli'));
      _filterAktifCustomController.updateListFilterModel(
        6,
        WidgetFilterModel(
            label: [
              'InfoPraTenderIndexLabelMuatan'.tr,
              "InfoPraTenderIndexLabelSearchPlaceholderCariMuatan".tr,
              "InfoPraTenderIndexLabelexKardus".tr,
            ],
            typeInFilter: TypeInFilter.MUATAN,
            customValue: listMuatanAktif,
            keyParam: 'muatan'),
      );
      _filterAktifCustomController.updateListFilterModel(
        7,
        WidgetFilterModel(
            label: [
              'InfoPraTenderIndexLabelDiumumkanKepada'.tr,
              "InfoPraTenderIndexLabelSearchPlaceholderCariDiumumkanKepada".tr,
              "InfoPraTenderIndexLabelexPTAjinomoto".tr,
            ],
            typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
            customValue: listDiumumkanAktif,
            keyParam: 'diumumkankepada'),
      );

      _filterAktifCustomController.showFilter();
      print('AKTIF');
    }
    if (jenisTab.value == "History") {
      _filterHistoryCustomController.updateListFilterModel(
          1,
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelSatuanTender'.tr],
              typeInFilter: TypeInFilter.SATUAN,
              customValue: [
                SatuanFilterModel(
                    id: "total_truk",
                    value: "InfoPraTenderIndexLabelUnitTruk".tr,
                    min: 0,
                    max: dataMaxJumlahUnitTruckHistory.value),
                SatuanFilterModel(
                    id: "Berat",
                    value: "InfoPraTenderIndexLabelBerat".tr,
                    min: 0,
                    max: dataMaxJumlahBeratHistory.value),
                SatuanFilterModel(
                    id: "Volume",
                    value: "InfoPraTenderIndexLabelVolume".tr,
                    min: 0,
                    max: dataMaxJumlahVolumeHistory.value)
              ],
              keyParam: 'satuanTender'));
      _filterHistoryCustomController.updateListFilterModel(
        2,
        WidgetFilterModel(
            label: ['InfoPraTenderIndexLabelJumlah'.tr],
            typeInFilter: TypeInFilter.UNIT_SATUAN,
            customValue: [0.0, dataMaxJumlahHistory.value],
            // initValue: [1], // Isi nomor widget typeinfilter.satuan
            keyParam: 'jumlahMin_jumlahMax'),
      );
      _filterHistoryCustomController.updateListFilterModel(
          3,
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelJumlahKoli'.tr],
              typeInFilter: TypeInFilter.UNIT,
              customValue: [0.0, dataMaxKoliHistory.value],
              keyParam: 'jumlah_koli'));
      _filterHistoryCustomController.updateListFilterModel(
        6,
        WidgetFilterModel(
            label: [
              'InfoPraTenderIndexLabelMuatan'.tr,
              "InfoPraTenderIndexLabelSearchPlaceholderCariMuatan".tr,
              "InfoPraTenderIndexLabelexKardus".tr,
            ],
            typeInFilter: TypeInFilter.MUATAN,
            customValue: listMuatanHistory,
            keyParam: 'muatan'),
      );
      _filterHistoryCustomController.updateListFilterModel(
        7,
        WidgetFilterModel(
            label: [
              'InfoPraTenderIndexLabelDiumumkanKepada'.tr,
              "InfoPraTenderIndexLabelSearchPlaceholderCariDiumumkanKepada".tr,
              "InfoPraTenderIndexLabelexPTAjinomoto".tr,
            ],
            typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
            customValue: listDiumumkanHistory,
            keyParam: 'diumumkankepada'),
      );

      _filterHistoryCustomController.showFilter();
      print('HISTORY');
    }
  }

  void reset() async {
    _resetSearchSortingFilter();
  }

  void refreshAll() async {
    listInfoPraTenderAktif.clear();
    isLoadingData.value = true;
    countDataAktif.value = 1;
    await getListTender(1, 'Aktif', filterAktif);
    listInfoPraTenderHistory.clear();
    isLoadingData.value = true;
    countDataHistory.value = 1;
    await getListTender(1, 'History', filterHistory);
  }

  void goToSearchPage() async {
    var sortBy = "";
    var sortType = "";
    var mapSort = {};
    var sortList = [];

    if (jenisTab.value == "Aktif") {
      sortList = aktifSort;
    } else {
      sortList = historySort;
    }

    // if (jenisTab.value == "Aktif") {
    //   sortBy = sortByAktif.value;
    //   sortType = sortTypeAktif.value;
    //   mapSort = mapSortByAktif;
    //   sortList = aktifSort;
    // } else {
    //   sortBy = sortByHistory.value;
    //   sortType = sortTypeHistory.value;
    //   mapSort = mapSortByHistory;
    //   sortList = historySort;
    // }

    var data = await GetToPage.toNamed<SearchInfoPraTenderController>(
        Routes.SEARCH_INFO_PRA_TENDER,
        arguments: [jenisTab.value, sortBy, sortType, mapSort, sortList]);

    if (data != null) {
      isLoadingData.value = true;
      if (jenisTab.value == "Aktif") {
        listInfoPraTenderAktif.clear();
        listInfoPraTenderAktif.refresh();
        await getListTender(1, jenisTab.value, filterAktif);
      } else {
        listInfoPraTenderHistory.clear();
        listInfoPraTenderHistory.refresh();
        await getListTender(1, jenisTab.value, filterHistory);
      }
      // if (jenisTab.value == "Aktif") {
      //   sortByAktif.value = data[0];
      //   sortTypeAktif.value = data[1];
      //   mapSortByAktif = data[2];
      //   aktifSort = data[3];

      //   tagAktif += (int.parse(tagAktif) + 1).toString();
      //   _sortingAktifController = Get.put(
      //       SortingController(
      //           listSort: aktifSort,
      //           initMap: mapSortByAktif,
      //           onRefreshData: (map) async {
      //             countDataAktif.value = 1;
      //             print('AKTIF');
      //             listInfoPraTenderAktif.clear();
      //             //SET ULANG
      //             sortByAktif.value = map.keys
      //                 .toString()
      //                 .replaceAll('(', '')
      //                 .replaceAll(')', '');
      //             sortTypeAktif.value = map.values
      //                 .toString()
      //                 .replaceAll('(', '')
      //                 .replaceAll(')', '');

      //             mapSortByAktif = map;

      //             print('NEW MAPS');
      //             print(map);

      //             isLoadingData.value = true;
      //             await getListTender(1, jenisTab.value, filterAktif);
      //           }),
      //       permanent: false,
      //       tag: tagAktif);

      //   if (mapSortByHistory = null) {
      //     await getListTender(1, jenisTab.value, filterAktif);
      //   } else {
      //     _sortingAktifController.onRefreshData(mapSortByAktif);
      //   }

      //   await getListTender(1, jenisTab.value, filterAktif);

      //   print('SORT AKTIF');
      // } else {
      //   sortByHistory = data[0];
      //   sortTypeHistory = data[1];
      //   mapSortByHistory = data[2];
      //   historySort = data[3];

      //   tagHistory += (int.parse(tagHistory) + 1).toString();
      //   _sortingHistoryController = Get.put(
      //       SortingController(
      //           listSort: historySort,
      //           initMap: mapSortByHistory,
      //           onRefreshData: (map) async {
      //             countDataHistory.value = 1;
      //             print('HISTORY');
      //             listInfoPraTenderHistory.clear(); //SET ULANG
      //             sortByHistory.value = map.keys
      //                 .toString()
      //                 .replaceAll('(', '')
      //                 .replaceAll(')', '');
      //             sortTypeHistory.value = map.values
      //                 .toString()
      //                 .replaceAll('(', '')
      //                 .replaceAll(')', '');
      //             mapSortByHistory = map;
      //             print('NEW MAPS');
      //             print(map);
      //             isLoadingData.value = true;
      //             await getListTender(1, jenisTab.value, filterHistory);
      //           }),
      //       permanent: false,
      //       tag: tagHistory);
      //   if (mapSortByHistory = null) {
      //     await getListTender(1, jenisTab.value, filterHistory);
      //   } else {
      //     _sortingHistoryController.onRefreshData(mapSortByHistory);
      //   }
      //   await getListTender(1, jenisTab.value, filterHistory);
      //   print('SORT HISTORY');
      // }
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

  void shareListInfoPraTender() async {
    var history = "0";
    var tglawal = "2500-12-31";
    var tglakhir = "1900-01-01";

    print(cekShareAktif);

    if (jenisTab.value == 'Aktif') {
      history = "0";
      print(listInfoPraTenderAktif.length);
      //TANGGAL AWAL
      for (var x = 0; x < listInfoPraTenderAktif.length; x++) {
        if (tglawal.compareTo(listInfoPraTenderAktif[x]['tanggalDibuatRaw']) >
            0) {
          tglawal = listInfoPraTenderAktif[x]['tanggalDibuatRaw'];
        }
      }

      //TANGGAL AKHIR
      for (var x = 0; x < listInfoPraTenderAktif.length; x++) {
        if (tglakhir.compareTo(listInfoPraTenderAktif[x]['tanggalDibuatRaw']) <
            0) {
          tglakhir = listInfoPraTenderAktif[x]['tanggalDibuatRaw'];
        }
      }
    } else {
      history = "1";

      //TANGGAL AWAL
      for (var x = 0; x < listInfoPraTenderHistory.length; x++) {
        if (tglawal.compareTo(listInfoPraTenderHistory[x]['tanggalDibuatRaw']) >
            0) {
          tglawal = listInfoPraTenderHistory[x]['tanggalDibuatRaw'];
        }
      }

      //TANGGAL AKHIR
      for (var x = 0; x < listInfoPraTenderHistory.length; x++) {
        if (tglakhir
                .compareTo(listInfoPraTenderHistory[x]['tanggalDibuatRaw']) <
            0) {
          tglakhir = listInfoPraTenderHistory[x]['tanggalDibuatRaw'];
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

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .sharePDFListInfoPraTender(id, tglawal, tglakhir, history);

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
    if (jenisTab.value == "Aktif") {
      listInfoPraTenderAktif.clear();
      countDataAktif.value = 1;
      filterAktif.clear();
      sortByAktif.value = '';
      sortTypeAktif.value = 'DESC';
    } else if (jenisTab.value == "History") {
      listInfoPraTenderHistory.clear();
      countDataHistory.value = 1;
      filterHistory.clear();
      sortByHistory.value = '';
      sortTypeHistory.value = 'DESC';
    }

    isLoadingData.value = true;
    await getListTender(1, jenisTab.value,
        jenisTab.value == 'Aktif' ? filterAktif : filterHistory);
  }

  Future getListTender(int page, String pageName, datafilter) async {
    String ID = "";
    String isShipper = "";
    isShipper = "1";
    ID = await SharedPreferencesHelper.getUserShipperID();

    String LangLink = '';
    String RealLink = '';
    String history = '0';
    if (pageName == 'Aktif') {
      LangLink = 'InfoPraTenderAktifGrid';
      RealLink = 'infoPraTenderAktifGrid';
      var result = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchListInfoPratender(
              ID,
              '10',
              page.toString(),
              sortByAktif.value,
              search.value,
              sortTypeAktif.value,
              filterAktif,
              pageName,
              LangLink,
              RealLink,
              isShipper,
              history);

      print(filterAktif);
      if (result['Message']['Code'].toString() == '200') {
        firstTimeAktif = false;
        var data = result['Data'];

        if (data.length == 0 && page > 1) {
          countDataAktif.value -= 1;
        }

        (data as List).forEach((element) {
          listInfoPraTenderAktif.add({
            'id': element['ID'].toString(),
            'kode': element['Kode'],
            'tanggalDibuatRaw': element['TanggalDibuatRaw'],
            'tanggalDibuat': element['TanggalDibuat'].split(" ")[0] +
                " " +
                element['TanggalDibuat'].split(" ")[1] +
                " " +
                element['TanggalDibuat'].split(" ")[2],
            'jamDibuat': element['TanggalDibuat'].split(" ")[3],
            'zonaWaktu': element['ZonaWaktu'],
            'judul': element['Judul'],
            'rute': element['ImplodedRute'],
            'muatan': element['Muatan'],
            'transporter': element['AllInvites'],
            'status': element['StatusKey'].toString(),
          });
        });
        jumlahDataAktif.value = result['SupportingData']['RealCountData'];
        maxKoli = result['SupportingData']['MaxKoli'].toDouble();
        maxJumlahBerat = result['SupportingData']['MaxBerat'].toDouble();
        maxJumlahVolume = result['SupportingData']['MaxVolume'].toDouble();
        maxJumlahUnitTruk = result['SupportingData']['MaxUnitTruk'].toDouble();
        refreshAktifController.loadComplete();

        if (maxJumlahUnitTruk > maxJumlahBerat &&
            maxJumlahUnitTruk > maxJumlahVolume) {
          maxJumlah = maxJumlahUnitTruk;
        } else if (maxJumlahBerat > maxJumlahUnitTruk &&
            maxJumlahBerat > maxJumlahVolume) {
          maxJumlah = maxJumlahBerat;
        } else if (maxJumlahVolume > maxJumlahUnitTruk &&
            maxJumlahVolume > maxJumlahBerat) {
          maxJumlah = maxJumlahVolume;
        }

        print(maxJumlah);
        print(maxKoli);

        Map<String, dynamic> _mapFilterAktif = {};

        listMuatanAktif.value = result['SupportingData']['DataMuatan'];
        listDiumumkanAktif.value = result['SupportingData']['DataDiumumkan'];
        dataMaxJumlahUnitTruckAktif.value = maxJumlahUnitTruk;
        dataMaxJumlahBeratAktif.value = maxJumlahBerat;
        dataMaxJumlahVolumeAktif.value = maxJumlahVolume;
        dataMaxJumlahAktif.value = maxJumlah;
        dataMaxKoliAktif.value = maxKoli;

        List<WidgetFilterModel> listWidgetFilterAktif = [
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelTanggalDibuat'.tr],
              typeInFilter: TypeInFilter.DATE,
              keyParam: 'doc_date'),
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelSatuanTender'.tr],
              typeInFilter: TypeInFilter.SATUAN,
              customValue: [
                SatuanFilterModel(
                    id: "total_truk",
                    value: "InfoPraTenderIndexLabelUnitTruk".tr,
                    min: 0,
                    max: maxJumlahUnitTruk),
                SatuanFilterModel(
                    id: "Berat",
                    value: "InfoPraTenderIndexLabelBerat".tr,
                    min: 0,
                    max: maxJumlahBerat),
                SatuanFilterModel(
                    id: "Volume",
                    value: "InfoPraTenderIndexLabelVolume".tr,
                    min: 0,
                    max: maxJumlahVolume)
              ],
              keyParam: 'satuanTender'),
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelJumlah'.tr],
              typeInFilter: TypeInFilter.UNIT_SATUAN,
              customValue: [0.0, maxJumlah],
              // initValue: [1], // Isi nomor widget typeinfilter.satuan
              keyParam: 'jumlahMin_jumlahMax'),
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelJumlahKoli'.tr],
              typeInFilter: TypeInFilter.UNIT,
              customValue: [0.0, maxKoli],
              keyParam: 'jumlah_koli'),
          WidgetFilterModel(
            label: [
              'InfoPraTenderIndexLabelLokasiPickUp'.tr,
              "InfoPraTenderIndexLabelSearchPlaceholderCariLokasiPickUp".tr,
              "InfoPraTenderIndexLabelLokasiPickUp".tr
            ],
            typeInFilter: TypeInFilter.CITY,
            isIdAsParameter: true,
            keyParam: 'pick_up',
          ),
          WidgetFilterModel(
            label: [
              'InfoPraTenderIndexLabelLokasiDestinasi'.tr,
              "InfoPraTenderIndexLabelSearchPlaceholderCariLokasiDestinasi".tr,
              "InfoPraTenderIndexLabelLokasiDestinasi".tr,
            ],
            typeInFilter: TypeInFilter.DESTINASI,
            isIdAsParameter: true,
            keyParam: 'destination',
          ),
          WidgetFilterModel(
              label: [
                'InfoPraTenderIndexLabelMuatan'.tr,
                "InfoPraTenderIndexLabelSearchPlaceholderCariMuatan".tr,
                "InfoPraTenderIndexLabelexKardus".tr,
              ],
              typeInFilter: TypeInFilter.MUATAN,
              customValue: result['SupportingData']['DataMuatan'],
              keyParam: 'muatan'),
          WidgetFilterModel(
              label: [
                'InfoPraTenderIndexLabelDiumumkanKepada'.tr,
                "InfoPraTenderIndexLabelSearchPlaceholderCariDiumumkanKepada"
                    .tr,
                "InfoPraTenderIndexLabelexPTAjinomoto".tr,
              ],
              typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
              customValue: result['SupportingData']['DataDiumumkan'],
              keyParam: 'diumumkankepada'),
        ];

        _filterAktifCustomController = Get.put(
            FilterCustomControllerArk(
              returnData: (data) async {
                _mapFilterAktif.clear();
                _mapFilterAktif.addAll(data);

                isLoadingData.value = true;
                // print(dataval);
                isFilterAktif = false;
                // print(data);
                for (int i = 0; i < data.values.length; i++) {
                  if (i == 2 || i == 3) {
                    if (data.values.elementAt(i) > 0) {
                      isFilterAktif = true;
                    }
                  } else {
                    if (data.values.elementAt(i).length > 0) {
                      isFilterAktif = true;
                    }
                  }
                }

                var urutan = 0;
                filterAktif.value = data;
                filterAktif.refresh();

                listInfoPraTenderAktif.clear();
                listInfoPraTenderAktif.refresh();
                countDataAktif.value = 1;

                await getListTender(1, jenisTab.value, data);
              },
              listWidgetInFilter: listWidgetFilterAktif,
            ),
            tag: "Aktif");
      }
    } else if (pageName == 'History') {
      LangLink = 'InfoPraTenderHistoryGrid';
      RealLink = 'infoPraTenderHistoryGrid';
      history = '1';

      var result = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchListInfoPratender(
              ID,
              '10',
              page.toString(),
              sortByHistory.value,
              search.value,
              sortTypeHistory.value,
              filterHistory,
              pageName,
              LangLink,
              RealLink,
              isShipper,
              history);

      if (result['Message']['Code'].toString() == '200') {
        firstTimeHistory = false;
        var data = result['Data'];

        if (data.length == 0 && page > 1) {
          countDataHistory.value -= 1;
        }

        (data as List).forEach((element) {
          listInfoPraTenderHistory.add({
            'id': element['ID'].toString(),
            'kode': element['Kode'],
            'tanggalDibuatRaw': element['TanggalDibuatRaw'],
            'tanggalDibuat': element['TanggalDibuat'].split(" ")[0] +
                " " +
                element['TanggalDibuat'].split(" ")[1] +
                " " +
                element['TanggalDibuat'].split(" ")[2],
            'jamDibuat': element['TanggalDibuat'].split(" ")[3],
            'zonaWaktu': element['ZonaWaktu'],
            'judul': element['Judul'],
            'rute': element['ImplodedRute'],
            'muatan': element['Muatan'],
            'transporter': element['AllInvites'],
            'status': element['StatusKey'].toString(),
          });
        });

        jumlahDataHistory.value = result['SupportingData']['RealCountData'];
        maxKoli = result['SupportingData']['MaxKoli'].toDouble();
        maxJumlahBerat = result['SupportingData']['MaxBerat'].toDouble();
        maxJumlahVolume = result['SupportingData']['MaxVolume'].toDouble();
        maxJumlahUnitTruk = result['SupportingData']['MaxUnitTruk'].toDouble();

        refreshHistoryController.loadComplete();

        if (maxJumlahUnitTruk > maxJumlahBerat &&
            maxJumlahUnitTruk > maxJumlahVolume) {
          maxJumlah = maxJumlahUnitTruk;
        } else if (maxJumlahBerat > maxJumlahUnitTruk &&
            maxJumlahBerat > maxJumlahVolume) {
          maxJumlah = maxJumlahBerat;
        } else if (maxJumlahVolume > maxJumlahUnitTruk &&
            maxJumlahVolume > maxJumlahBerat) {
          maxJumlah = maxJumlahVolume;
        }

        print('maxjumlah ' + maxJumlah.toString());
        print('maxKoli ' + maxKoli.toString());

        Map<String, dynamic> _mapFilterHistory = {};

        listMuatanHistory.value = result['SupportingData']['DataMuatan'];
        listDiumumkanHistory.value = result['SupportingData']['DataDiumumkan'];
        dataMaxJumlahUnitTruckHistory.value = maxJumlahUnitTruk;
        dataMaxJumlahBeratHistory.value = maxJumlahBerat;
        dataMaxJumlahVolumeHistory.value = maxJumlahVolume;
        dataMaxJumlahHistory.value = maxJumlah;
        dataMaxKoliHistory.value = maxKoli;

        List<WidgetFilterModel> listWidgetFilterHistory = [
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelTanggalDibuat'.tr],
              typeInFilter: TypeInFilter.DATE,
              keyParam: 'doc_date'),
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelSatuanTender'.tr],
              typeInFilter: TypeInFilter.SATUAN,
              customValue: [
                SatuanFilterModel(
                    id: "total_truk",
                    value: "InfoPraTenderIndexLabelUnitTruk".tr,
                    min: 0,
                    max: maxJumlahUnitTruk),
                SatuanFilterModel(
                    id: "Berat",
                    value: "InfoPraTenderIndexLabelBerat".tr,
                    min: 0,
                    max: maxJumlahBerat),
                SatuanFilterModel(
                    id: "Volume",
                    value: "InfoPraTenderIndexLabelVolume".tr,
                    min: 0,
                    max: maxJumlahVolume)
              ],
              keyParam: 'satuanTender'),
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelJumlah'.tr],
              typeInFilter: TypeInFilter.UNIT_SATUAN,
              customValue: [0.0, maxJumlah],
              // initValue: [1], // Isi nomor widget typeinfilter.satuan
              keyParam: 'jumlahMin_jumlahMax'),
          WidgetFilterModel(
              label: ['InfoPraTenderIndexLabelJumlahKoli'.tr],
              typeInFilter: TypeInFilter.UNIT,
              customValue: [0.0, maxKoli],
              keyParam: 'jumlah_koli'),
          WidgetFilterModel(
            label: [
              'InfoPraTenderIndexLabelLokasiPickUp'.tr,
              "InfoPraTenderIndexLabelSearchPlaceholderCariLokasiPickUp".tr,
              "InfoPraTenderIndexLabelLokasiPickUp".tr
            ],
            typeInFilter: TypeInFilter.CITY,
            isIdAsParameter: true,
            keyParam: 'pick_up',
          ),
          WidgetFilterModel(
            label: [
              'InfoPraTenderIndexLabelLokasiDestinasi'.tr,
              "InfoPraTenderIndexLabelSearchPlaceholderCariLokasiDestinasi".tr,
              "InfoPraTenderIndexLabelLokasiDestinasi".tr,
            ],
            typeInFilter: TypeInFilter.DESTINASI,
            isIdAsParameter: true,
            keyParam: 'destination',
          ),
          WidgetFilterModel(
              label: [
                'InfoPraTenderIndexLabelMuatan'.tr,
                "InfoPraTenderIndexLabelSearchPlaceholderCariMuatan".tr,
                "InfoPraTenderIndexLabelexKardus".tr,
              ],
              typeInFilter: TypeInFilter.MUATAN,
              customValue: result['SupportingData']['DataMuatan'],
              keyParam: 'muatan'),
          WidgetFilterModel(
              label: [
                'InfoPraTenderIndexLabelDiumumkanKepada'.tr,
                "InfoPraTenderIndexLabelSearchPlaceholderCariDiumumkanKepada"
                    .tr,
                "InfoPraTenderIndexLabelexPTAjinomoto".tr,
              ],
              typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
              customValue: result['SupportingData']['DataDiumumkan'],
              keyParam: 'diumumkankepada'),
        ];

        _filterHistoryCustomController = Get.put(
            FilterCustomControllerArk(
                returnData: (data) async {
                  _mapFilterHistory.clear();
                  _mapFilterHistory.addAll(data);

                  isLoadingData.value = true;

                  isFilterHistory = false;
                  for (int i = 0; i < data.values.length; i++) {
                    if (i == 2 || i == 3) {
                      if (data.values.elementAt(i) > 0) {
                        isFilterHistory = true;
                      }
                    } else {
                      if (data.values.elementAt(i).length > 0) {
                        isFilterHistory = true;
                      }
                    }
                  }
                  //SET ULANG

                  var urutan = 0;
                  filterHistory.value = data;
                  filterHistory.refresh();

                  listInfoPraTenderHistory.clear();
                  listInfoPraTenderHistory.refresh();
                  countDataHistory.value = 1;

                  await getListTender(1, jenisTab.value, filterHistory);
                },
                listWidgetInFilter: listWidgetFilterHistory),
            tag: "History");
      }
    }
    listInfoPraTenderAktif.refresh();
    listInfoPraTenderHistory.refresh();
    isLoadingData.value = false;
  }

  //Menampilkan Box Kuning, ketika pertama kali menggunakan aplikasi
  Widget firstTimeYellowBox() {
    String bullet = '\u2022 ';
    return Container(
        margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 22,
        ),
        decoration: BoxDecoration(
          color: Color(ListColor.colorYellowTile),
          borderRadius:
              BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 18,
            GlobalVariable.ratioWidth(Get.context) * 8,
            GlobalVariable.ratioWidth(Get.context) * 5,
            GlobalVariable.ratioWidth(Get.context) * 14),
        child: Stack(
          children: [
            Column(children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 0,
                    GlobalVariable.ratioWidth(Get.context) * 18,
                    GlobalVariable.ratioWidth(Get.context) * 13,
                    GlobalVariable.ratioWidth(Get.context) * 0),
                child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'InfoPraTenderIndexLabelPopUpTeksInfoPraTender'
                            .tr, //'Info Pra Tender'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "AvenirNext",
                          height: 1.8,
                        ),
                        children: [
                          TextSpan(
                            text: 'InfoPraTenderIndexLabelPopUpParagraf1'
                                .tr, //' adalah fitur untuk menginfokan tender yang akan berlangsung di perusahaan Anda kepada Transporter yang ingin anda undang. Bila Anda mengundang Transporter baru.\n\nAnda dapat mengumumkan persyaratan administrasi tender yang diperlukan. Gunakan fitur ini ketika ada jeda waktu yang panjang antara info pra tender sampai degan eksekusi tender.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "AvenirNext",
                              height: 1.8,
                            ),
                          )
                        ])),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 0,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 13,
                    GlobalVariable.ratioWidth(Get.context) * 0),
                child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'InfoPraTenderIndexLabelPopUpParagraf2'
                            .tr, //'Info Pra Tender'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "AvenirNext",
                          height: 1.8,
                        ),
                        children: [])),
              ),
            ]),
            Positioned(
                child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: SvgPicture.asset(
                    GlobalVariable.imagePath + 'ic_close.svg',
                    width: GlobalVariable.ratioWidth(Get.context) * 14,
                    height: GlobalVariable.ratioWidth(Get.context) * 14,
                    color: Colors.black),
                onTap: () async {
                  await SharedPreferencesHelper.setInfoPraTenderYellowPopUp(
                      false);
                  popUpYellow.value = false;
                },
              ),
            ))
          ],
        ));
  }

  void opsi(idPraTender) {
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
                            'InfoPraTenderIndexLabelJudulPopUpOpsi'
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
                      'InfoPraTenderIndexLabelOpsiBuatTender'
                          .tr, //'Buat Tender',
                      'BUAT',
                      '0',
                      cekTambahTender),
                  lineDividerWidget(),
                  listTitleWidget(
                      'InfoPraTenderIndexLabelOpsiSalinTender'.tr, //'Salin',
                      'SALIN',
                      idPraTender,
                      cekTambah),
                  jenisTab.value != "History"
                      ? Column(
                          children: [
                            lineDividerWidget(),
                            listTitleWidget(
                                'InfoPraTenderIndexLabelOpsiEditTender', // 'Edit',
                                'EDIT',
                                idPraTender,
                                cekEdit),
                          ],
                        )
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
      String text, String fungsi, String idPraTender, bool akses) {
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
        if (fungsi == 'BUAT') buat(idPraTender);
        if (fungsi == 'SALIN') salin(idPraTender);
        if (fungsi == 'EDIT') edit(idPraTender);
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

  void buat(String idPraTender) async {
    cekTambahTender =
        await SharedPreferencesHelper.getHakAkses("Buat Proses Tender",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekTambahTender)) {
      var data = await GetToPage.toNamed<CreateProsesTenderController>(
        Routes.CREATE_PROSES_TENDER,
      );
      if (data != null) {
        refreshAll();
      }
    }
  }

  void salin(String idPraTender) async {
    cekTambah =
        await SharedPreferencesHelper.getHakAkses("Buat Info Pra Tender",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekTambah)) {
      var data = await GetToPage.toNamed<CreateInfoPraTenderController>(
          Routes.CREATE_INFO_PRA_TENDER,
          arguments: [idPraTender, 0]);
      if (data != null) {
        refreshAll();
      }
    }
  }

  void edit(String idPraTender) async {
    cekEdit = await SharedPreferencesHelper.getHakAkses("Edit Info Pra Tender",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekEdit)) {
      var data = await GetToPage.toNamed<EditInfoPraTenderController>(
          Routes.EDIT_INFO_PRA_TENDER,
          arguments: [idPraTender, 0]);

      if (data != null) {
        refreshAll();
      }
    }
  }
}
