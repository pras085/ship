import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/modules/ARK/proses_tender/detail_proses_tender/detail_proses_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_pemenang/list_halaman_peserta_detail_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_pilih_pemenang/list_halaman_peserta_pilih_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_tentukan_pemenang_tender/list_tentukan_pemenang_tender_controller.dart';
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

class PemenangTenderController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;
  var posTab = 0.obs;
  var isLoadingData = true.obs;
  var listProsesTenderBelumDiumumkan = [].obs;
  var listProsesTenderDiumumkan = [].obs;
  var jumlahDataBelumDiumumkan = 0.obs;
  var jumlahDataDiumumkan = 0.obs;
  double maxKoli = 0;
  double maxJumlah = 0;
  double maxJumlahUnitTruk = 0;
  double maxJumlahBerat = 0;
  double maxJumlahVolume = 0;
  double maxPeserta = 0;
  var countDataBelumDiumumkan = 1.obs;
  var countDataDiumumkan = 1.obs;
  var firstTimeBelumDiumumkan = true;
  var firstTimeDiumumkan = true;
  var jumlahDanger = 0.obs;
  var jumlahWarning = 0.obs;

  String tagBelumDiumumkan = "1001";
  String tagDiumumkan = "1002";

  var showFirstTime = true.obs;
  String filePath = "";
  var popUpYellow = true.obs;
  var jenisTab = 'BelumDiumumkan'.obs; // Diumumkan

  var filterBelumDiumumkan = {}.obs; //UNTUK FILTER PENCARIAN BELUMDIUMUMKAN
  bool isFilterBelumDiumumkan =
      false; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK
  var filterDiumumkan = {}.obs; //UNTUK FILTER PENCARIAN DIUMUMKAN
  bool isFilterDiumumkan =
      false; //UNTUK CEK ADA FILTER YANG DIGUNAKAN ATAU TIDAK

  var sortByBelumDiumumkan = ''.obs; //UNTUK SORT BERDASARKAN APA
  Map<String, dynamic> mapSortByBelumDiumumkan =
      {}; //UNTUK DAPATKAN DATA MAP SORT BELUMDIUMUMKAN
  var sortTypeBelumDiumumkan = ''.obs; //UNTUK URUTAN SORTNYA
  var sortByDiumumkan = ''.obs; //UNTUK SORT BERDASARKAN APA
  Map<String, dynamic> mapSortByDiumumkan =
      {}; //UNTUK DAPATKAN DATA MAP SORT DIUMUMKAN
  var sortTypeDiumumkan = ''.obs; //UNTUK URUTAN SORTNYA
  var search = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD
  var listMuatanBelumDiumumkan = [].obs;
  var listDiumumkanBelumDiumumkan = [].obs;
  var listMuatanDiumumkan = [].obs;
  var listDiumumkanDiumumkan = [].obs;
  RefreshController refreshBelumDiumumkanController =
      RefreshController(initialRefresh: false);

  RefreshController refreshDiumumkanController =
      RefreshController(initialRefresh: false);

  SortingController _sortingBelumDiumumkanController;
  SortingController _sortingDiumumkanController;

  FilterCustomControllerArk _filterBelumDiumumkanCustomController;
  FilterCustomControllerArk _filterDiumumkanCustomController;

  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var tapDownload = false;
  var status = 0.obs;
  List<DataListSortingModel> belumdiumumkanSort = [];
  List<DataListSortingModel> diumumkanSort = [];
  var dataMaxJumlahUnitTruckBelumDiumumkan = 0.0.obs;
  var dataMaxJumlahBeratBelumDiumumkan = 0.0.obs;
  var dataMaxJumlahVolumeBelumDiumumkan = 0.0.obs;
  var dataMaxJumlahBelumDiumumkan = 0.0.obs;
  var dataMaxKoliBelumDiumumkan = 0.0.obs;
  var dataMaxPesertaBelumDiumumkan = 0.0.obs;
  var dataMaxJumlahUnitTruckDiumumkan = 0.0.obs;
  var dataMaxJumlahBeratDiumumkan = 0.0.obs;
  var dataMaxJumlahVolumeDiumumkan = 0.0.obs;
  var dataMaxJumlahDiumumkan = 0.0.obs;
  var dataMaxKoliDiumumkan = 0.0.obs;
  var dataMaxPesertaDiumumkan = 0.0.obs;
  var cekPilihPemenang = false;
  var cekLihatPemenang = false;
  var cekUmumkan = false;
  var cekDetail = false;
  var cekShareBelumDiumumkan = false;
  var cekShareDiumumkan = false;

  @override
  void onInit() async {
    cekPilihPemenang =
        await SharedPreferencesHelper.getHakAkses("Pilih Pemenang");
    cekUmumkan =
        await SharedPreferencesHelper.getHakAkses("Umumkan Lebih Awal");
    cekLihatPemenang =
        await SharedPreferencesHelper.getHakAkses("Lihat Pemenang");
    cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Tender");
    cekShareBelumDiumumkan = await SharedPreferencesHelper.getHakAkses(
        "Export List Pemenang Tender Belum Diumukan");
    cekShareDiumumkan = await SharedPreferencesHelper.getHakAkses(
        "Export List Pemenang Tender Diumumkan");

    print("reset filter");
    try {
      Get.delete<FilterCustomControllerArk>(tag: "BelumDiumumkan");
      Get.delete<FilterCustomControllerArk>(tag: "Diumumkan");
    } catch (e) {
      print(e);
    }
    unbindBackgroundIsolate();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallBack);

    popUpYellow.value =
        await SharedPreferencesHelper.getPemenangTenderYellowPopUp();

    //await SharedPreferencesHelper.setPemenangTenderPertamaKali(true);
    showFirstTime.value =
        await SharedPreferencesHelper.getPemenangTenderPertamaKali();

    tabController = TabController(vsync: this, length: 2);

    tabController.addListener(() {
      if (posTab.value != tabController.index) {
        posTab.value = tabController.index;
        print('tabControlleraddListener');
        _checkChangePageTab();
      }
    });

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
          'seleksiAwal',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'PemenangTenderIndexLabelTanggalAkhirSeleksi'.tr,
          'seleksiAkhir',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          'InfoPraTenderIndexLabelPalingLama'.tr.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'PemenangTenderIndexLabelTanggalAwalPengumuman'.tr,
          'pengumumanAwal',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'PemenangTenderIndexLabelTanggalAkhirPengumuman'.tr,
          'pengumumanAkhir',
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
          'pemenang',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
    ];

    diumumkanSort = [
      DataListSortingModel(
          'PemenangTenderIndexLabelTanggalDiumumkan'.tr,
          'tanggalDiumumkan',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
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
          'PemenangTenderIndexLabelTanggalAwalPengumuman'.tr,
          'pengumumanAwal',
          'InfoPraTenderIndexLabelPalingLama'.tr,
          'InfoPraTenderIndexLabelPalingBaru'.tr,
          ''.obs,
          isTitleASCFirst: false),
      DataListSortingModel(
          'PemenangTenderIndexLabelTanggalAkhirPengumuman'.tr,
          'pengumumanAkhir',
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
          'pemenang',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
    ];

    sortByBelumDiumumkan.value = "seleksiAkhir";
    sortTypeBelumDiumumkan.value = "ASC";

    _sortingBelumDiumumkanController = Get.put(
        SortingController(
            listSort: belumdiumumkanSort,
            initMap: mapSortByBelumDiumumkan,
            onRefreshData: (map) async {
              countDataBelumDiumumkan.value = 1;
              print('BELUMDIUMUMKAN');
              listProsesTenderBelumDiumumkan.clear();

              //SET ULANG
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

              print('HASIL');

              isLoadingData.value = true;

              print(isLoadingData);
              print(firstTimeBelumDiumumkan);
              await getListTender(1, jenisTab.value, filterBelumDiumumkan);
            }),
        tag: tagBelumDiumumkan);

    _sortingDiumumkanController = Get.put(
        SortingController(
            listSort: diumumkanSort,
            initMap: mapSortByDiumumkan,
            onRefreshData: (map) async {
              countDataDiumumkan.value = 1;
              print('DIUMUMKAN');
              listProsesTenderDiumumkan.clear(); //SET ULANG
              //SET ULANG
              sortByDiumumkan.value = "";
              sortTypeDiumumkan.value = "";

              var index = 0;
              map.keys.forEach((element) {
                index++;
                sortByDiumumkan.value += element;
                if (index < map.keys.length) {
                  sortByDiumumkan.value += ", ";
                }
              });

              index = 0;
              map.values.forEach((element) {
                index++;
                sortTypeDiumumkan.value += element;
                if (index < map.values.length) {
                  sortTypeDiumumkan.value += ", ";
                }
              });

              mapSortByDiumumkan = map;
              print('NEW MAPS');
              print(map);
              isLoadingData.value = true;
              await getListTender(1, jenisTab.value, filterDiumumkan);
            }),
        tag: tagDiumumkan);

    //DIUMUMKAN DI LOAD JUGA KARENA, UNTUK CEK ADA DATA ATAU TIDAK, SUPAYA JIKA DIA BELUMDIUMUMKAN KOSONG, TAPI ADA DIUMUMKAN BISA BUKA
    await getListTender(1, 'Diumumkan', filterDiumumkan);

    await getListTender(1, jenisTab.value, filterBelumDiumumkan);

    isLoadingData.value = false;

    print(firstTimeBelumDiumumkan);
    print(isLoadingData);
    print('TES');
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void _checkChangePageTab() async {
    if (posTab.value == 0) {
      jenisTab.value = 'BelumDiumumkan';
      if (firstTimeBelumDiumumkan) {
        isLoadingData.value = true;
        await getListTender(1, jenisTab.value, filterBelumDiumumkan);
      }
    } else {
      jenisTab.value = 'Diumumkan';
      if (firstTimeDiumumkan) {
        isLoadingData.value = true;
        await getListTender(1, jenisTab.value, filterDiumumkan);
      }
    }
  }

  void onChangeTab(int pos) {
    tabController.animateTo(pos);
  }

  void showSortingDialog() async {
    print("MAP SORT BELUMDIUMUMKAN");
    print(mapSortByBelumDiumumkan);
    print("MAP SORT DIUMUMKAN");
    print(mapSortByDiumumkan);

    if (jenisTab.value == "BelumDiumumkan") {
      _sortingBelumDiumumkanController.showSort();
      print('BELUMDIUMUMKAN');
    }
    if (jenisTab.value == "Diumumkan") {
      _sortingDiumumkanController.showSort();
      print('DIUMUMKAN');
    }
  }

  void _clearSorting() {
    if (jenisTab.value == "BelumDiumumkan") {
      _sortingBelumDiumumkanController.clearSorting();
      print('BELUMDIUMUMKAN');
    }
    if (jenisTab.value == "Diumumkan") {
      _sortingDiumumkanController.clearSorting();
      print('DIUMUMKAN');
    }
  }

  void showFilter() async {
    if (jenisTab.value == "BelumDiumumkan") {
      _filterBelumDiumumkanCustomController.updateListFilterModel(
          2,
          WidgetFilterModel(
              label: ['InfoPraTenderTransporterIndexLabelSatuanTender'.tr],
              typeInFilter: TypeInFilter.SATUAN,
              customValue: [
                SatuanFilterModel(
                    id: "total_truk",
                    value: "PemenangTenderIndexLabelUnitTruk".tr,
                    min: 0,
                    max: dataMaxJumlahUnitTruckBelumDiumumkan.value),
                SatuanFilterModel(
                    id: "Berat",
                    value: "PemenangTenderIndexLabelBerat".tr,
                    min: 0,
                    max: dataMaxJumlahBeratBelumDiumumkan.value),
                SatuanFilterModel(
                    id: "Volume",
                    value: "PemenangTenderIndexLabelVolume".tr,
                    min: 0,
                    max: dataMaxJumlahVolumeBelumDiumumkan.value)
              ],
              keyParam: 'satuanTender'));
      _filterBelumDiumumkanCustomController.updateListFilterModel(
        3,
        WidgetFilterModel(
            label: ['InfoPraTenderTransporterIndexLabelJumlah'.tr],
            typeInFilter: TypeInFilter.UNIT_SATUAN,
            customValue: [0.0, dataMaxJumlahBelumDiumumkan.value],
            // initValue: [1], // Isi nomor widget typeinfilter.satuan
            keyParam: 'jumlahMin_jumlahMax'),
      );
      _filterBelumDiumumkanCustomController.updateListFilterModel(
          4,
          WidgetFilterModel(
              label: ['InfoPraTenderTransporterIndexLabelJumlahKoli'.tr],
              typeInFilter: TypeInFilter.UNIT,
              customValue: [0.0, dataMaxKoliBelumDiumumkan.value],
              keyParam: 'jumlah_koli'));
      _filterBelumDiumumkanCustomController.updateListFilterModel(
          7,
          WidgetFilterModel(
              label: [
                'PemenangTenderIndexLabelMuatan'.tr,
                "PemenangTenderIndexLabelSearchPlaceholderCariMuatan".tr,
                "PemenangTenderIndexLabelexKardus".tr,
              ],
              typeInFilter: TypeInFilter.MUATAN,
              customValue: listMuatanBelumDiumumkan,
              keyParam: 'muatan'));
      _filterBelumDiumumkanCustomController.updateListFilterModel(
        9,
        WidgetFilterModel(
          label: [
            'PemenangTenderIndexLabelPemenang'.tr,
            'PemenangTenderIndexLabelCariPemenang'.tr,
            "PemenangTenderIndexLabelexPTAbadijaya".tr,
          ],
          canBeHide: true,
          numberHideFilter: 8,
          hideTitle: true,
          hideLine: true,
          paddingLeft: GlobalVariable.ratioWidth(Get.context) * 33,
          typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
          customValue: listDiumumkanBelumDiumumkan,
          keyParam: 'pemenang ',
        ),
      );

      _filterBelumDiumumkanCustomController.showFilter();
      print('BELUMDIUMUMKAN');
    }
    if (jenisTab.value == "Diumumkan") {
      _filterDiumumkanCustomController.updateListFilterModel(
          2,
          WidgetFilterModel(
              label: ['InfoPraTenderTransporterIndexLabelSatuanTender'.tr],
              typeInFilter: TypeInFilter.SATUAN,
              customValue: [
                SatuanFilterModel(
                    id: "total_truk",
                    value: "PemenangTenderIndexLabelUnitTruk".tr,
                    min: 0,
                    max: dataMaxJumlahUnitTruckDiumumkan.value),
                SatuanFilterModel(
                    id: "Berat",
                    value: "PemenangTenderIndexLabelBerat".tr,
                    min: 0,
                    max: dataMaxJumlahBeratDiumumkan.value),
                SatuanFilterModel(
                    id: "Volume",
                    value: "PemenangTenderIndexLabelVolume".tr,
                    min: 0,
                    max: dataMaxJumlahVolumeDiumumkan.value)
              ],
              keyParam: 'satuanTender'));
      _filterDiumumkanCustomController.updateListFilterModel(
        3,
        WidgetFilterModel(
            label: ['InfoPraTenderTransporterIndexLabelJumlah'.tr],
            typeInFilter: TypeInFilter.UNIT_SATUAN,
            customValue: [0.0, dataMaxJumlahDiumumkan.value],
            // initValue: [1], // Isi nomor widget typeinfilter.satuan
            keyParam: 'jumlahMin_jumlahMax'),
      );
      _filterDiumumkanCustomController.updateListFilterModel(
          4,
          WidgetFilterModel(
              label: ['InfoPraTenderTransporterIndexLabelJumlahKoli'.tr],
              typeInFilter: TypeInFilter.UNIT,
              customValue: [0.0, dataMaxKoliDiumumkan.value],
              keyParam: 'jumlah_koli'));
      _filterDiumumkanCustomController.updateListFilterModel(
          7,
          WidgetFilterModel(
              label: [
                'PemenangTenderIndexLabelMuatan'.tr,
                "PemenangTenderIndexLabelSearchPlaceholderCariMuatan".tr,
                "PemenangTenderIndexLabelexKardus".tr,
              ],
              typeInFilter: TypeInFilter.MUATAN,
              customValue: listMuatanDiumumkan,
              keyParam: 'muatan'));
      _filterDiumumkanCustomController.updateListFilterModel(
        9,
        WidgetFilterModel(
          label: [
            'PemenangTenderIndexLabelPemenang'.tr,
            'PemenangTenderIndexLabelCariPemenang'.tr,
            "PemenangTenderIndexLabelexPTAbadijaya".tr,
          ],
          canBeHide: true,
          numberHideFilter: 8,
          hideTitle: true,
          hideLine: true,
          paddingLeft: GlobalVariable.ratioWidth(Get.context) * 33,
          typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
          customValue: listDiumumkanDiumumkan,
          keyParam: 'pemenang ',
        ),
      );
      _filterDiumumkanCustomController.showFilter();
      print('DIUMUMKAN');
    }
  }

  void reset() async {
    _resetSearchSortingFilter();
  }

  void refreshAll() async {
    listProsesTenderBelumDiumumkan.clear();
    isLoadingData.value = true;
    countDataBelumDiumumkan.value = 1;
    await getListTender(1, 'BelumDiumumkan', filterBelumDiumumkan);
    listProsesTenderDiumumkan.clear();
    isLoadingData.value = true;
    countDataDiumumkan.value = 1;
    await getListTender(1, 'Diumumkan', filterDiumumkan);
  }

  void goToSearchPage() async {
    var sortBy = "";
    var sortType = "";
    var mapSort = {};
    var sortList = [];

    if (jenisTab.value == "BelumDiumumkan") {
      sortList = belumdiumumkanSort;
    } else {
      sortList = diumumkanSort;
    }

    // if (jenisTab.value == "BelumDiumumkan") {
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
        arguments: [jenisTab.value, sortBy, sortType, mapSort, sortList, null]);

    if (data != null) {
      isLoadingData.value = true;
      if (jenisTab.value == "BelumDiumumkan") {
        listProsesTenderBelumDiumumkan.clear();
        listProsesTenderBelumDiumumkan.refresh();
        await getListTender(1, jenisTab.value, filterBelumDiumumkan);
      } else {
        listProsesTenderDiumumkan.clear();
        listProsesTenderDiumumkan.refresh();
        await getListTender(1, jenisTab.value, filterDiumumkan);
      }
      // if (jenisTab.value == "BelumDiumumkan") {
      //   sortByBelumDiumumkan.value = data[0];
      //   sortTypeBelumDiumumkan.value = data[1];
      //   mapSortByBelumDiumumkan = data[2];
      //   belumdiumumkanSort = data[3];

      //   tagBelumDiumumkan += (int.parse(tagBelumDiumumkan) + 1).toString();
      //   _sortingBelumDiumumkanController = Get.put(
      //       SortingController(
      //           listSort: belumdiumumkanSort,
      //           initMap: mapSortByBelumDiumumkan,
      //           onRefreshData: (map) async {
      //             countDataBelumDiumumkan.value = 1;
      //             print('BELUMDIUMUMKAN');
      //             listProsesTenderBelumDiumumkan.clear();
      //             //SET ULANG
      //             sortByBelumDiumumkan.value = map.keys
      //                 .toString()
      //                 .replaceAll('(', '')
      //                 .replaceAll(')', '');
      //             sortTypeBelumDiumumkan.value = map.values
      //                 .toString()
      //                 .replaceAll('(', '')
      //                 .replaceAll(')', '');

      //             mapSortByBelumDiumumkan = map;

      //             print('NEW MAPS');
      //             print(map);

      //             isLoadingData.value = true;
      //             await getListTender(1, jenisTab.value, filterBelumDiumumkan);
      //           }),
      //       permanent: false,
      //       tag: tagBelumDiumumkan);

      //   if (mapSortByDiumumkan = null) {
      //     await getListTender(1, jenisTab.value, filterBelumDiumumkan);
      //   } else {
      //     _sortingBelumDiumumkanController.onRefreshData(mapSortByBelumDiumumkan);
      //   }

      //   await getListTender(1, jenisTab.value, filterBelumDiumumkan);

      //   print('SORT BELUMDIUMUMKAN');
      // } else {
      //   sortByDiumumkan = data[0];
      //   sortTypeDiumumkan = data[1];
      //   mapSortByDiumumkan = data[2];
      //   diumumkanSort = data[3];

      //   tagDiumumkan += (int.parse(tagDiumumkan) + 1).toString();
      //   _sortingDiumumkanController = Get.put(
      //       SortingController(
      //           listSort: diumumkanSort,
      //           initMap: mapSortByDiumumkan,
      //           onRefreshData: (map) async {
      //             countDataDiumumkan.value = 1;
      //             print('DIUMUMKAN');
      //             listProsesTenderDiumumkan.clear(); //SET ULANG
      //             sortByDiumumkan.value = map.keys
      //                 .toString()
      //                 .replaceAll('(', '')
      //                 .replaceAll(')', '');
      //             sortTypeDiumumkan.value = map.values
      //                 .toString()
      //                 .replaceAll('(', '')
      //                 .replaceAll(')', '');
      //             mapSortByDiumumkan = map;
      //             print('NEW MAPS');
      //             print(map);
      //             isLoadingData.value = true;
      //             await getListTender(1, jenisTab.value, filterDiumumkan);
      //           }),
      //       permanent: false,
      //       tag: tagDiumumkan);
      //   if (mapSortByDiumumkan = null) {
      //     await getListTender(1, jenisTab.value, filterDiumumkan);
      //   } else {
      //     _sortingDiumumkanController.onRefreshData(mapSortByDiumumkan);
      //   }
      //   await getListTender(1, jenisTab.value, filterDiumumkan);
      //   print('SORT DIUMUMKAN');
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

  void shareListProsesTender() async {
    var diumumkan = "0";
    var tglawal = "2500-12-31";
    var tglakhir = "1900-01-01";

    if (jenisTab.value == 'BelumDiumumkan') {
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
    } else {
      diumumkan = "1";

      //TANGGAL AWAL
      for (var x = 0; x < listProsesTenderDiumumkan.length; x++) {
        if (tglawal
                .compareTo(listProsesTenderDiumumkan[x]['tanggalDibuatRaw']) >
            0) {
          tglawal = listProsesTenderDiumumkan[x]['tanggalDibuatRaw'];
        }
      }

      //TANGGAL AKHIR
      for (var x = 0; x < listProsesTenderDiumumkan.length; x++) {
        if (tglakhir
                .compareTo(listProsesTenderDiumumkan[x]['tanggalDibuatRaw']) <
            0) {
          tglakhir = listProsesTenderDiumumkan[x]['tanggalDibuatRaw'];
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
    if (jenisTab.value == "BelumDiumumkan") {
      listProsesTenderBelumDiumumkan.clear();
      countDataBelumDiumumkan.value = 1;
      filterBelumDiumumkan.clear();
      sortByBelumDiumumkan.value = '';
      sortTypeBelumDiumumkan.value = 'DESC';
    } else if (jenisTab.value == "Diumumkan") {
      listProsesTenderDiumumkan.clear();
      countDataDiumumkan.value = 1;
      filterDiumumkan.clear();
      sortByDiumumkan.value = '';
      sortTypeDiumumkan.value = 'DESC';
    }

    isLoadingData.value = true;
    await getListTender(
        1,
        jenisTab.value,
        jenisTab.value == 'BelumDiumumkan'
            ? filterBelumDiumumkan
            : filterDiumumkan);
  }

  Future getListTender(int page, String pageName, datafilter) async {
    String ID = "";
    String isShipper = "";
    isShipper = "1";
    ID = await SharedPreferencesHelper.getUserShipperID();

    String LangLink = '';
    String RealLink = '';
    String diumumkan = '0';
    if (pageName == 'BelumDiumumkan') {
      jumlahDanger.value = 0;
      jumlahWarning.value = 0;

      LangLink = 'ProsesTenderBelumDiumumkanGrid';
      RealLink = 'ProsesTenderBelumDiumumkanGrid';

      print(sortByBelumDiumumkan.value);
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
              diumumkan);

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

        jumlahDanger.value = result['SupportingData']['JmlSeleksiBerakhir'];

        jumlahWarning.value =
            result['SupportingData']['JmlSeleksiHampirBerakhir'];

        print("DANGER" + jumlahDanger.value.toString());
        print("WARNING" + jumlahWarning.value.toString());
        jumlahDataBelumDiumumkan.value =
            result['SupportingData']['RealCountData'];
        maxKoli = result['SupportingData']['MaxKoli'].toDouble();
        maxJumlahBerat = result['SupportingData']['MaxBerat'].toDouble();
        maxJumlahVolume = result['SupportingData']['MaxVolume'].toDouble();
        maxJumlahUnitTruk = result['SupportingData']['MaxUnitTruk'].toDouble();
        // maxPeserta = result['SupportingData']['MaxPeserta'].toDouble();
        // refreshBelumDiumumkanController.loadComplete();

        print(maxPeserta);

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

        Map<String, dynamic> _mapFilterBelumDiumumkan = {};

        listMuatanBelumDiumumkan.value = result['SupportingData']['DataMuatan'];
        listDiumumkanBelumDiumumkan.value =
            result['SupportingData']['DataPemenang'];
        if (jumlahDataBelumDiumumkan.value != 0) {
          dataMaxJumlahUnitTruckBelumDiumumkan.value = maxJumlahUnitTruk;
          dataMaxJumlahBeratBelumDiumumkan.value = maxJumlahBerat;
          dataMaxJumlahVolumeBelumDiumumkan.value = maxJumlahVolume;
          dataMaxJumlahBelumDiumumkan.value = maxJumlah;
          dataMaxKoliBelumDiumumkan.value = maxKoli;
        } else {
          maxJumlahUnitTruk = dataMaxJumlahUnitTruckBelumDiumumkan.value;
          maxJumlahBerat = dataMaxJumlahBeratBelumDiumumkan.value;
          maxJumlahVolume = dataMaxJumlahVolumeBelumDiumumkan.value;
          maxJumlah = dataMaxJumlahBelumDiumumkan.value;
          maxKoli = dataMaxKoliBelumDiumumkan.value;
        }
        // dataMaxPesertaBelumDiumumkan.value = maxPeserta;

        List<WidgetFilterModel> listWidgetFilterBelumDiumumkan = [
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelPeriodePengumuman'.tr],
              typeInFilter: TypeInFilter.DATE,
              keyParam: 'tanggal_pengumuman'),
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelPeriodeSeleksi'.tr],
              typeInFilter: TypeInFilter.DATE,
              keyParam: 'tanggal_seleksi'),
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelSatuanTender'.tr],
              typeInFilter: TypeInFilter.SATUAN,
              customValue: [
                SatuanFilterModel(
                    id: "total_truk",
                    value: "PemenangTenderIndexLabelUnitTruk".tr,
                    min: 0,
                    max: maxJumlahUnitTruk),
                SatuanFilterModel(
                    id: "Berat",
                    value: "PemenangTenderIndexLabelBerat".tr,
                    min: 0,
                    max: maxJumlahBerat),
                SatuanFilterModel(
                    id: "Volume",
                    value: "PemenangTenderIndexLabelVolume".tr,
                    min: 0,
                    max: maxJumlahVolume)
              ],
              keyParam: 'satuanTender'),
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelJumlah'.tr],
              typeInFilter: TypeInFilter.UNIT_SATUAN,
              customValue: [0.0, maxJumlah],
              // initValue: [1], // Isi nomor widget typeinfilter.satuan
              keyParam: 'jumlahMin_jumlahMax'),
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelJumlahKoli'.tr],
              typeInFilter: TypeInFilter.UNIT,
              customValue: [0.0, maxKoli],
              keyParam: 'jumlah_koli'),
          WidgetFilterModel(
            label: [
              'PemenangTenderIndexLabelLokasiPickUp'.tr,
              "PemenangTenderIndexLabelSearchPlaceholderCariLokasiPickUp".tr,
              "PemenangTenderIndexLabelLokasiPickUp".tr
            ],
            typeInFilter: TypeInFilter.CITY,
            isIdAsParameter: true,
            keyParam: 'pick_up',
          ),
          WidgetFilterModel(
            label: [
              'PemenangTenderIndexLabelLokasiDestinasi'.tr,
              "PemenangTenderIndexLabelSearchPlaceholderCariLokasiDestinasi".tr,
              "PemenangTenderIndexLabelLokasiDestinasi".tr,
            ],
            typeInFilter: TypeInFilter.DESTINASI,
            isIdAsParameter: true,
            keyParam: 'destination',
          ),
          WidgetFilterModel(
              label: [
                'PemenangTenderIndexLabelMuatan'.tr,
                "PemenangTenderIndexLabelSearchPlaceholderCariMuatan".tr,
                "PemenangTenderIndexLabelexKardus".tr,
              ],
              typeInFilter: TypeInFilter.MUATAN,
              customValue: result['SupportingData']['DataMuatan'],
              keyParam: 'muatan'),
          WidgetFilterModel(
            label: ['PemenangTenderIndexLabelStatusPemenang'.tr],
            typeInFilter: TypeInFilter.CHECKBOX_WITH_HIDE,
            customValue: [
              CheckboxFilterModel(
                id: "BelumDiumumkan",
                value: "PemenangTenderIndexLabelBelumDitentukan".tr,
              ),
              CheckboxFilterModel(
                id: "DiputuskanTanpaPemenang",
                value: "PemenangTenderIndexLabelDiputuskanTanpaPemenang".tr,
              ),
              CheckboxFilterModel(
                id: "AdaPemenang",
                value: "PemenangTenderIndexLabelAdaPemenang".tr,
                canHide: true,
                hideIndex: 9,
              ),
            ],
            keyParam: 'filterPemenang',
          ),
          WidgetFilterModel(
            label: [
              'PemenangTenderIndexLabelPemenang'.tr,
              'PemenangTenderIndexLabelCariPemenang'.tr,
              "PemenangTenderIndexLabelexPTAbadijaya".tr,
            ],
            canBeHide: true,
            numberHideFilter: 8,
            hideTitle: true,
            hideLine: true,
            paddingLeft: GlobalVariable.ratioWidth(Get.context) * 24,
            typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
            customValue: result['SupportingData']['DataPemenang'],
            keyParam: 'pemenang ',
          ),
        ];

        _filterBelumDiumumkanCustomController = Get.put(
            FilterCustomControllerArk(
              returnData: (data) async {
                _mapFilterBelumDiumumkan.clear();
                _mapFilterBelumDiumumkan.addAll(data);

                isLoadingData.value = true;
                // print(dataval);
                isFilterBelumDiumumkan = false;
                // print(data);
                for (int i = 0; i < data.values.length; i++) {
                  if (i == 3 || i == 4) {
                    if (data.values.elementAt(i) > 0) {
                      isFilterBelumDiumumkan = true;
                    }
                  } else {
                    if (data.values.elementAt(i).length > 0) {
                      isFilterBelumDiumumkan = true;
                    }
                  }
                }

                var urutan = 0;
                filterBelumDiumumkan.value = data;
                filterBelumDiumumkan.refresh();

                listProsesTenderBelumDiumumkan.clear();
                listProsesTenderBelumDiumumkan.refresh();
                countDataBelumDiumumkan.value = 1;
                await getListTender(1, jenisTab.value, data);
              },
              listWidgetInFilter: listWidgetFilterBelumDiumumkan,
            ),
            tag: "BelumDiumumkan");
      }
    } else if (pageName == 'Diumumkan') {
      LangLink = 'ProsesTenderDiumumkanGrid';
      RealLink = 'ProsesTenderDiumumkanGrid';
      diumumkan = '1';

      var result = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchListPemenangTender(
              ID,
              '10',
              page.toString(),
              sortByDiumumkan.value,
              search.value,
              sortTypeDiumumkan.value,
              filterDiumumkan,
              pageName,
              LangLink,
              RealLink,
              isShipper,
              diumumkan);

      if (result['Message']['Code'].toString() == '200') {
        firstTimeDiumumkan = false;
        var data = result['Data'];

        if (data.length == 0 && page > 1) {
          countDataDiumumkan.value -= 1;
        }

        (data as List).forEach((element) {
          listProsesTenderDiumumkan.add({
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

        jumlahDataDiumumkan.value = result['SupportingData']['RealCountData'];

        maxKoli = result['SupportingData']['MaxKoli'].toDouble();
        maxJumlahBerat = result['SupportingData']['MaxBerat'].toDouble();
        maxJumlahVolume = result['SupportingData']['MaxVolume'].toDouble();
        maxJumlahUnitTruk = result['SupportingData']['MaxUnitTruk'].toDouble();
        // maxPeserta = result['SupportingData']['MaxPeserta'].toDouble();

        print(maxPeserta);

        refreshDiumumkanController.loadComplete();

        // if (maxJumlahUnitTruk > maxJumlahBerat &&
        //     maxJumlahUnitTruk > maxJumlahVolume) {
        //   maxJumlah = maxJumlahUnitTruk;
        // } else if (maxJumlahBerat > maxJumlahUnitTruk &&
        //     maxJumlahBerat > maxJumlahVolume) {
        //   maxJumlah = maxJumlahBerat;
        // } else if (maxJumlahVolume > maxJumlahUnitTruk &&
        //     maxJumlahVolume > maxJumlahBerat) {
        //   maxJumlah = maxJumlahVolume;
        // }
        maxJumlah = maxJumlahBerat;
        if (maxJumlah < maxJumlahVolume) {
          maxJumlah = maxJumlahVolume;
        }
        if (maxJumlah < maxJumlahUnitTruk) {
          maxJumlah = maxJumlahUnitTruk;
        }

        print(maxJumlah);
        print(maxKoli);

        Map<String, dynamic> _mapFilterDiumumkan = {};
        print("datamuatan");
        print(result['SupportingData']['DataMuatan']);
        listMuatanDiumumkan.value = result['SupportingData']['DataMuatan'];
        listDiumumkanDiumumkan.value = result['SupportingData']['DataPemenang'];
        if (jumlahDataDiumumkan.value != 0) {
          dataMaxJumlahUnitTruckDiumumkan.value = maxJumlahUnitTruk;
          dataMaxJumlahBeratDiumumkan.value = maxJumlahBerat;
          dataMaxJumlahVolumeDiumumkan.value = maxJumlahVolume;
          dataMaxJumlahDiumumkan.value = maxJumlah;
          dataMaxKoliDiumumkan.value = maxKoli;
        } else {
          maxJumlahUnitTruk = dataMaxJumlahUnitTruckDiumumkan.value;
          maxJumlahBerat = dataMaxJumlahBeratDiumumkan.value;
          maxJumlahVolume = dataMaxJumlahVolumeDiumumkan.value;
          maxJumlah = dataMaxJumlahDiumumkan.value;
          maxKoli = dataMaxKoliDiumumkan.value;
        }
        // dataMaxPesertaDiumumkan.value = maxPeserta;

        List<WidgetFilterModel> listWidgetFilterDiumumkan = [
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelTanggalDiumumkan'.tr],
              typeInFilter: TypeInFilter.DATE,
              keyParam: 'tanggal_diputuskan'),
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelPeriodeSeleksi'.tr],
              typeInFilter: TypeInFilter.DATE,
              keyParam: 'tanggal_seleksi'),
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelSatuanTender'.tr],
              typeInFilter: TypeInFilter.SATUAN,
              customValue: [
                SatuanFilterModel(
                    id: "total_truk",
                    value: "PemenangTenderIndexLabelUnitTruk".tr,
                    min: 0,
                    max: maxJumlahUnitTruk),
                SatuanFilterModel(
                    id: "Berat",
                    value: "PemenangTenderIndexLabelBerat".tr,
                    min: 0,
                    max: maxJumlahBerat),
                SatuanFilterModel(
                    id: "Volume",
                    value: "PemenangTenderIndexLabelVolume".tr,
                    min: 0,
                    max: maxJumlahVolume)
              ],
              keyParam: 'satuanTender'),
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelJumlah'.tr],
              typeInFilter: TypeInFilter.UNIT_SATUAN,
              customValue: [0.0, maxJumlah],
              // initValue: [1], // Isi nomor widget typeinfilter.satuan
              keyParam: 'jumlahMin_jumlahMax'),
          WidgetFilterModel(
              label: ['PemenangTenderIndexLabelJumlahKoli'.tr],
              typeInFilter: TypeInFilter.UNIT,
              customValue: [0.0, maxKoli],
              keyParam: 'jumlah_koli'),
          WidgetFilterModel(
            label: [
              'PemenangTenderIndexLabelLokasiPickUp'.tr,
              "PemenangTenderIndexLabelSearchPlaceholderCariLokasiPickUp".tr,
              "PemenangTenderIndexLabelLokasiPickUp".tr
            ],
            typeInFilter: TypeInFilter.CITY,
            isIdAsParameter: true,
            keyParam: 'pick_up',
          ),
          WidgetFilterModel(
            label: [
              'PemenangTenderIndexLabelLokasiDestinasi'.tr,
              "PemenangTenderIndexLabelSearchPlaceholderCariLokasiDestinasi".tr,
              "PemenangTenderIndexLabelLokasiDestinasi".tr,
            ],
            typeInFilter: TypeInFilter.DESTINASI,
            isIdAsParameter: true,
            keyParam: 'destination',
          ),
          WidgetFilterModel(
              label: [
                'PemenangTenderIndexLabelMuatan'.tr,
                "PemenangTenderIndexLabelSearchPlaceholderCariMuatan".tr,
                "PemenangTenderIndexLabelexKardus".tr,
              ],
              typeInFilter: TypeInFilter.MUATAN,
              customValue: result['SupportingData']['DataMuatan'],
              keyParam: 'muatan'),
          WidgetFilterModel(
            label: ['PemenangTenderIndexLabelStatusPemenang'.tr],
            typeInFilter: TypeInFilter.CHECKBOX_WITH_HIDE,
            customValue: [
              CheckboxFilterModel(
                id: "BelumDiumumkan",
                value: "PemenangTenderIndexLabelBelumDitentukan".tr,
              ),
              CheckboxFilterModel(
                id: "DiputuskanTanpaPemenang",
                value: "PemenangTenderIndexLabelDiputuskanTanpaPemenang".tr,
              ),
              CheckboxFilterModel(
                id: "AdaPemenang",
                value: "PemenangTenderIndexLabelAdaPemenang".tr,
                canHide: true,
                hideIndex: 9,
              ),
            ],
            keyParam: 'filterPemenang',
          ),
          WidgetFilterModel(
            label: [
              'PemenangTenderIndexLabelPemenang'.tr,
              'PemenangTenderIndexLabelCariPemenang'.tr,
              "PemenangTenderIndexLabelexPTAbadijaya".tr,
            ],
            typeInFilter: TypeInFilter.DIUMUMKANKEPADA,
            customValue: result['SupportingData']['DataPemenang'],
            canBeHide: true,
            hideLine: true,
            numberHideFilter: 8,
            hideTitle: true,
            paddingLeft: GlobalVariable.ratioWidth(Get.context) * 24,
            keyParam: 'pemenang ',
          ),
        ];

        _filterDiumumkanCustomController = Get.put(
            FilterCustomControllerArk(
                returnData: (data) async {
                  _mapFilterDiumumkan.clear();
                  _mapFilterDiumumkan.addAll(data);

                  isLoadingData.value = true;

                  isFilterDiumumkan = false;
                  for (int i = 0; i < data.values.length; i++) {
                    if (i == 3 || i == 4) {
                      if (data.values.elementAt(i) > 0) {
                        isFilterDiumumkan = true;
                      }
                    } else {
                      if (data.values.elementAt(i).length > 0) {
                        isFilterDiumumkan = true;
                      }
                    }
                  }
                  //SET ULANG

                  var urutan = 0;
                  filterDiumumkan.value = data;
                  filterDiumumkan.refresh();

                  listProsesTenderDiumumkan.clear();
                  listProsesTenderDiumumkan.refresh();
                  countDataDiumumkan.value = 1;

                  await getListTender(1, jenisTab.value, filterDiumumkan);
                },
                listWidgetInFilter: listWidgetFilterDiumumkan),
            tag: "Diumumkan");
      }
    }

    //listProsesTenderBelumDiumumkan.clear();

    listProsesTenderBelumDiumumkan.refresh();
    listProsesTenderDiumumkan.refresh();
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
          GlobalVariable.ratioWidth(Get.context) * 12, //22
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
                        text: 'PemenangTenderIndexLabelPemenangTender'.tr +
                            ' ', //'Pemenang Tender'.tr,
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
                            text: 'PemenangTenderIndexLabelPopUpParagraf1'
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
                  await SharedPreferencesHelper.setPemenangTenderYellowPopUp(
                      false);
                  popUpYellow.value = false;
                },
              ),
            ))
          ],
        ));
  }

  Widget warningBox() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        GlobalVariable.ratioWidth(Get.context) * 16,
        0,
        GlobalVariable.ratioWidth(Get.context) * 16,
        GlobalVariable.ratioWidth(Get.context) * 14,
      ),
      decoration: BoxDecoration(
        color: Color(ListColor.colorWarningTile),
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
          GlobalVariable.ratioWidth(Get.context) * 6,
          GlobalVariable.ratioWidth(Get.context) * 18,
          GlobalVariable.ratioWidth(Get.context) * 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => CustomText(
              "PemenangTenderIndexLabelAda".tr + // Ada
                  " " +
                  jumlahWarning.value.toString() +
                  " " +
                  "PemenangTenderIndexLabelTenderYangPeriodeSeleksinyaAkanBerakhirDalam3" // tender yang periode seleksinya akan berakhir dalam
                      .tr,
              color: Color(ListColor.colorBackgroundLabelTidakAdaPeserta),
              fontWeight: FontWeight.w500,
              height: 1.2,
              fontSize: 12,
              textAlign: TextAlign.justify)),
          GestureDetector(
            child: CustomText(
              "PemenangTenderIndexLabelPilihPemenang".tr,
              color: Color(ListColor.colorBlue),
              fontWeight: FontWeight.w500,
              fontSize: 12,
              textAlign: TextAlign.justify,
              decoration: TextDecoration.underline,
            ),
            onTap: () async {
              var sortBy = "";
              var sortType = "";
              var mapSort = {};
              var sortList = [];

              if (jenisTab.value == "BelumDiumumkan") {
                sortList = belumdiumumkanSort;
              } else {
                sortList = diumumkanSort;
              }

              var data =
                  await GetToPage.toNamed<ListTentukanPemenangTenderController>(
                      Routes.LIST_TENTUKAN_PEMENANG_TENDER,
                      arguments: [
                    jenisTab.value,
                    sortBy,
                    sortType,
                    mapSort,
                    sortList,
                    '3HARI'
                  ]);
              if (data != null) {
                isLoadingData.value = true;
                if (jenisTab.value == "BelumDiumumkan") {
                  listProsesTenderBelumDiumumkan.clear();
                  listProsesTenderBelumDiumumkan.refresh();
                  await getListTender(1, jenisTab.value, filterBelumDiumumkan);
                } else {
                  listProsesTenderDiumumkan.clear();
                  listProsesTenderDiumumkan.refresh();
                  await getListTender(1, jenisTab.value, filterDiumumkan);
                }
                // if (jenisTab.value == "BelumDiumumkan") {
                //   sortByBelumDiumumkan.value = data[0];
                //   sortTypeBelumDiumumkan.value = data[1];
                //   mapSortByBelumDiumumkan = data[2];
                //   belumdiumumkanSort = data[3];

                //   tagBelumDiumumkan += (int.parse(tagBelumDiumumkan) + 1).toString();
                //   _sortingBelumDiumumkanController = Get.put(
                //       SortingController(
                //           listSort: belumdiumumkanSort,
                //           initMap: mapSortByBelumDiumumkan,
                //           onRefreshData: (map) async {
                //             countDataBelumDiumumkan.value = 1;
                //             print('BELUMDIUMUMKAN');
                //             listProsesTenderBelumDiumumkan.clear();
                //             //SET ULANG
                //             sortByBelumDiumumkan.value = map.keys
                //                 .toString()
                //                 .replaceAll('(', '')
                //                 .replaceAll(')', '');
                //             sortTypeBelumDiumumkan.value = map.values
                //                 .toString()
                //                 .replaceAll('(', '')
                //                 .replaceAll(')', '');

                //             mapSortByBelumDiumumkan = map;

                //             print('NEW MAPS');
                //             print(map);

                //             isLoadingData.value = true;
                //             await getListTender(1, jenisTab.value, filterBelumDiumumkan);
                //           }),
                //       permanent: false,
                //       tag: tagBelumDiumumkan);

                //   if (mapSortByDiumumkan = null) {
                //     await getListTender(1, jenisTab.value, filterBelumDiumumkan);
                //   } else {
                //     _sortingBelumDiumumkanController.onRefreshData(mapSortByBelumDiumumkan);
                //   }

                //   await getListTender(1, jenisTab.value, filterBelumDiumumkan);

                //   print('SORT BELUMDIUMUMKAN');
                // } else {
                //   sortByDiumumkan = data[0];
                //   sortTypeDiumumkan = data[1];
                //   mapSortByDiumumkan = data[2];
                //   diumumkanSort = data[3];

                //   tagDiumumkan += (int.parse(tagDiumumkan) + 1).toString();
                //   _sortingDiumumkanController = Get.put(
                //       SortingController(
                //           listSort: diumumkanSort,
                //           initMap: mapSortByDiumumkan,
                //           onRefreshData: (map) async {
                //             countDataDiumumkan.value = 1;
                //             print('DIUMUMKAN');
                //             listProsesTenderDiumumkan.clear(); //SET ULANG
                //             sortByDiumumkan.value = map.keys
                //                 .toString()
                //                 .replaceAll('(', '')
                //                 .replaceAll(')', '');
                //             sortTypeDiumumkan.value = map.values
                //                 .toString()
                //                 .replaceAll('(', '')
                //                 .replaceAll(')', '');
                //             mapSortByDiumumkan = map;
                //             print('NEW MAPS');
                //             print(map);
                //             isLoadingData.value = true;
                //             await getListTender(1, jenisTab.value, filterDiumumkan);
                //           }),
                //       permanent: false,
                //       tag: tagDiumumkan);
                //   if (mapSortByDiumumkan = null) {
                //     await getListTender(1, jenisTab.value, filterDiumumkan);
                //   } else {
                //     _sortingDiumumkanController.onRefreshData(mapSortByDiumumkan);
                //   }
                //   await getListTender(1, jenisTab.value, filterDiumumkan);
                //   print('SORT DIUMUMKAN');
                // }
              }
            },
          ) // Pilih Pemenang
        ],
      ),
    );
  }

  Widget dangerBox() {
    return Container(
        margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 12,
        ),
        decoration: BoxDecoration(
          color: Color(ListColor.colorDangerTile),
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
            GlobalVariable.ratioWidth(Get.context) * 6,
            GlobalVariable.ratioWidth(Get.context) * 18,
            GlobalVariable.ratioWidth(Get.context) * 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => CustomText(
                  "PemenangTenderIndexLabelAda".tr + //Ada
                      " " +
                      jumlahDanger.value.toString() +
                      " " +
                      "PemenangTenderIndexLabelTenderYangPeriodeSeleksinya" // tender yang periode seleksinya telah atau akan
                          .tr,
                  color: Color(ListColor.colorLabelBatal),
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  fontSize: 12,
                  textAlign: TextAlign.justify,
                )),
            GestureDetector(
                child: CustomText(
                  "PemenangTenderIndexLabelTentukanPemenangSekarang"
                      .tr, // Tentukan Pemenang Sekarang
                  color: Color(ListColor.colorBlue),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  textAlign: TextAlign.justify,
                  decoration: TextDecoration.underline,
                ),
                onTap: () async {
                  var sortBy = "";
                  var sortType = "";
                  var mapSort = {};
                  var sortList = [];

                  if (jenisTab.value == "BelumDiumumkan") {
                    sortList = belumdiumumkanSort;
                  } else {
                    sortList = diumumkanSort;
                  }

                  var data = await GetToPage.toNamed<
                          ListTentukanPemenangTenderController>(
                      Routes.LIST_TENTUKAN_PEMENANG_TENDER,
                      arguments: [
                        jenisTab.value,
                        sortBy,
                        sortType,
                        mapSort,
                        sortList,
                        'BERAKHIR'
                      ]);
                  if (data != null) {
                    isLoadingData.value = true;
                    if (jenisTab.value == "BelumDiumumkan") {
                      listProsesTenderBelumDiumumkan.clear();
                      listProsesTenderBelumDiumumkan.refresh();
                      await getListTender(
                          1, jenisTab.value, filterBelumDiumumkan);
                    } else {
                      listProsesTenderDiumumkan.clear();
                      listProsesTenderDiumumkan.refresh();
                      await getListTender(1, jenisTab.value, filterDiumumkan);
                    }
                    // if (jenisTab.value == "BelumDiumumkan") {
                    //   sortByBelumDiumumkan.value = data[0];
                    //   sortTypeBelumDiumumkan.value = data[1];
                    //   mapSortByBelumDiumumkan = data[2];
                    //   belumdiumumkanSort = data[3];

                    //   tagBelumDiumumkan += (int.parse(tagBelumDiumumkan) + 1).toString();
                    //   _sortingBelumDiumumkanController = Get.put(
                    //       SortingController(
                    //           listSort: belumdiumumkanSort,
                    //           initMap: mapSortByBelumDiumumkan,
                    //           onRefreshData: (map) async {
                    //             countDataBelumDiumumkan.value = 1;
                    //             print('BELUMDIUMUMKAN');
                    //             listProsesTenderBelumDiumumkan.clear();
                    //             //SET ULANG
                    //             sortByBelumDiumumkan.value = map.keys
                    //                 .toString()
                    //                 .replaceAll('(', '')
                    //                 .replaceAll(')', '');
                    //             sortTypeBelumDiumumkan.value = map.values
                    //                 .toString()
                    //                 .replaceAll('(', '')
                    //                 .replaceAll(')', '');

                    //             mapSortByBelumDiumumkan = map;

                    //             print('NEW MAPS');
                    //             print(map);

                    //             isLoadingData.value = true;
                    //             await getListTender(1, jenisTab.value, filterBelumDiumumkan);
                    //           }),
                    //       permanent: false,
                    //       tag: tagBelumDiumumkan);

                    //   if (mapSortByDiumumkan = null) {
                    //     await getListTender(1, jenisTab.value, filterBelumDiumumkan);
                    //   } else {
                    //     _sortingBelumDiumumkanController.onRefreshData(mapSortByBelumDiumumkan);
                    //   }

                    //   await getListTender(1, jenisTab.value, filterBelumDiumumkan);

                    //   print('SORT BELUMDIUMUMKAN');
                    // } else {
                    //   sortByDiumumkan = data[0];
                    //   sortTypeDiumumkan = data[1];
                    //   mapSortByDiumumkan = data[2];
                    //   diumumkanSort = data[3];

                    //   tagDiumumkan += (int.parse(tagDiumumkan) + 1).toString();
                    //   _sortingDiumumkanController = Get.put(
                    //       SortingController(
                    //           listSort: diumumkanSort,
                    //           initMap: mapSortByDiumumkan,
                    //           onRefreshData: (map) async {
                    //             countDataDiumumkan.value = 1;
                    //             print('DIUMUMKAN');
                    //             listProsesTenderDiumumkan.clear(); //SET ULANG
                    //             sortByDiumumkan.value = map.keys
                    //                 .toString()
                    //                 .replaceAll('(', '')
                    //                 .replaceAll(')', '');
                    //             sortTypeDiumumkan.value = map.values
                    //                 .toString()
                    //                 .replaceAll('(', '')
                    //                 .replaceAll(')', '');
                    //             mapSortByDiumumkan = map;
                    //             print('NEW MAPS');
                    //             print(map);
                    //             isLoadingData.value = true;
                    //             await getListTender(1, jenisTab.value, filterDiumumkan);
                    //           }),
                    //       permanent: false,
                    //       tag: tagDiumumkan);
                    //   if (mapSortByDiumumkan = null) {
                    //     await getListTender(1, jenisTab.value, filterDiumumkan);
                    //   } else {
                    //     _sortingDiumumkanController.onRefreshData(mapSortByDiumumkan);
                    //   }
                    //   await getListTender(1, jenisTab.value, filterDiumumkan);
                    //   print('SORT DIUMUMKAN');
                    // }
                  }
                }) // Tentukan pemenang sekarang
          ],
        ));
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
                  jenisTab.value == "BelumDiumumkan" && sudahAdaPemenang
                      ? lineDividerWidget()
                      : SizedBox(),
                  jenisTab.value == "BelumDiumumkan" && sudahAdaPemenang
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

  void detail(String idTender) async {
    cekDetail =
        await SharedPreferencesHelper.getHakAkses("Lihat Detail Tender",denganLoading:true);
    if (SharedPreferencesHelper.cekAkses(cekDetail)) {
      var data = await GetToPage.toNamed<DetailProsesTenderController>(
          Routes.DETAIL_PROSES_TENDER,
          arguments: [idTender, jenisTab.value]);

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

  Future getDetail(String idTender, String jenis) async {
    if (jenis == 'PILIH') {
      cekPilihPemenang =
          await SharedPreferencesHelper.getHakAkses("Pilih Pemenang",denganLoading:true);
    } else {
      cekLihatPemenang =
          await SharedPreferencesHelper.getHakAkses("Lihat Pemenang",denganLoading:true);
    }

    if ((cekPilihPemenang && jenis == 'PILIH') ||
        (cekLihatPemenang && jenis == 'LIHAT')) {
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
        var jumlahYangDigunakan = 0.0;

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
        var judulTender = data['judul'];

        var tipeListPeserta;
        if (dataTahapTender[3]['min_date'].compareTo(
                await GlobalVariable.getDateTimeFromServer(Get.context)) <=
            0) {
          tipeListPeserta = "SEKARANG";
        } else if (dataTahapTender[3]['min_date'].compareTo(
                await GlobalVariable.getDateTimeFromServer(Get.context)) >
            0) {
          tipeListPeserta = "SEBELUM";
        }
        print(jenis);
        Get.back();
        if (jenis == 'PILIH') {
          await GetToPage.toNamed<ListHalamanPesertaPilihPemenangController>(
              Routes.LIST_HALAMAN_PESERTA_PILIH_PEMENANG,
              arguments: [
                dataRuteTender,
                data['satuan_tender'],
                arrSatuanVolume[data['satuan_volume']],
                idTender,
                kodeTender,
                judulTender,
                data['nama_muatan'].toString() +
                    " (" +
                    arrJenisMuatan[data['jenis_muatan']].toString() +
                    ") ",
                jumlahYangDigunakan.toString(),
                tipeListPeserta,
                'TAMBAH'
              ]);
        } else if (jenis == 'LIHAT') {
          await GetToPage.toNamed<ListHalamanPesertaDetailPemenangController>(
              Routes.LIST_HALAMAN_PESERTA_DETAIL_PEMENANG,
              arguments: [
                dataRuteTender,
                data['satuan_tender'],
                arrSatuanVolume[data['satuan_volume']],
                idTender,
                kodeTender,
                judulTender,
                data['nama_muatan'].toString() +
                    " (" +
                    arrJenisMuatan[data['jenis_muatan']].toString() +
                    ") ",
                jumlahYangDigunakan.toString(),
                tipeListPeserta,
              ]);
        }

        refreshAll();
      } else if (jenis == 'PILIH') {
        SharedPreferencesHelper.cekAkses(cekPilihPemenang);
      } else if (jenis == 'LIHAT') {
        SharedPreferencesHelper.cekAkses(cekLihatPemenang);
      }
    }
  }
}
