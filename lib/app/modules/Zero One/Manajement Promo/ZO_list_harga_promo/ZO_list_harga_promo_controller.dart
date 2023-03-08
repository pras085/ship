import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_filter_jenis_truk_lelang_muatan/ZO_filter_jenis_truk_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_lelang_muatan_filter/ZO_filter_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_list_harga_promo/ZO_helper/ZO_helper_widget.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/shared_preferences_helper_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

//
class ZoListHargaPromoController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController;
  final refreshManajementPromoTabAktifController =
      RefreshController(initialRefresh: false);
  final refreshManajementPromoTabHistoryController =
      RefreshController(initialRefresh: false);
  var showInfoTooltip = true.obs;
  var firstTime = true;
  var failedGetListFilter = false.obs;
  var langTemp = "";

  var listFilterLokasiPickup = [].obs;
  var filterLokasiPickup = [].obs;
  var tempFilterLokasiPickup = [].obs;
  var getListFilterLokasiPickup = false.obs;

  var listFilterLokasiDestinasi = [].obs;
  var filterLokasiDestinasi = [].obs;
  var tempFilterLokasiDestinasi = [].obs;
  var getListFilterLokasiDestinasi = false.obs;

  var listFilterJenisTruck = [].obs;
  var filterJenisTruck = [].obs;
  var tempFilterJenisTruck = [].obs;
  var getListFilterJenisTruck = false.obs;

  var listFilterJenisTruckimg = [].obs;
  var tempFilterJenisTruckimg = [].obs;

  var listFilterJenisCarrier = [].obs;
  var filterJenisCarrier = [].obs;
  var tempFilterJenisCarrier = [].obs;
  var getListFilterJenisCarrier = false.obs;

  var listFilterJenisCarrierimg = [].obs;
  var tempFilterJenisCarrierimg = [].obs;

  var limitWrap = 5;
  var loginas = "".obs;
  var listManajementPromoData = [].obs;
  var listManajementPromoDataCount = [].obs;
  var listManajementPromoDataSearch = [].obs;
  var lihatLebihBanyak = [].obs;
  var status = [].obs;
  var lihatLebihBanyakSearch = [].obs;
  var statusSearch = [].obs;
  var munculIconDataKosong = false.obs;

  var listManajementPromoDataHistory = [].obs;
  var listManajementPromoDataSearchHistory = [].obs;
  var lihatLebihBanyakHistory = [].obs;
  var statusHistory = [].obs;
  var lihatLebihBanyakSearchHistory = [].obs;
  var statusSearchHistory = [].obs;
  var munculIconDataKosongHistory = false.obs;

  var strSwitchButon = [].obs;
  var strSwitchButonHistory = [].obs;

  var listChoosen = [];
  var listChoosenReturn = [].obs;
  var listChoosenHistory = [];
  var listChoosenReturnHistory = [].obs;
  final cari = TextEditingController().obs;
  var typingSearch = false.obs;
  var isLoading = false.obs;

  var isLoadingTabAktif = false.obs;
  var isLoadingTabHistory = false.obs;
  var limitTabAktif = 0.obs;
  var limitTabHistory = 0.obs;
  var limitAktif = 10.obs;
  var limitHistory = 10.obs;

  final periodePromoAwal = TextEditingController().obs;
  final periodePromoAkhir = TextEditingController().obs;
  final startHargaPromo = TextEditingController().obs;
  final endHargaPromo = TextEditingController().obs;
  final startKapasitas = TextEditingController().obs;
  final endKapasitas = TextEditingController().obs;
  final startJumlahTruk = TextEditingController().obs;
  final endJumlahTruk = TextEditingController().obs;
  Rx<RangeValues> _rangeValuesHargaPromo = RangeValues(0.0, 1500.0).obs;
  var _selectedsatuankapasitas = "Ton".obs;

  var type = "data-promo-aktif".obs;

  var sort = Map().obs;
  var issort = false.obs;
  var sortHistory = Map().obs;
  var issortHistory = false.obs;

  SortingController _sortingController;
  var manajemenPromoShort = [
    DataListSortingModel(
        "Tanggal Dibuat".tr, "created_at", "Terbaru", "Terlama", "".obs),
    DataListSortingModel(
        "Lokasi Destinasi".tr, "destination_city", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "Lokasi Pickup".tr, "pickup_city", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Jenis Truk".tr, "head_id", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "Jenis Carrier".tr, "carrier_id", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "Harga Promo".tr, "promo_price", "Terendah", "Tertinggi", "".obs),
    DataListSortingModel("Kapasitas".tr, "min_capacity", "Paling Sedikit",
        "Paling Banyak", "".obs),
    DataListSortingModel("Jumlah Kuota yang Promo".tr, "quota",
        "Paling Sedikit", "Paling Banyak", "".obs),
    DataListSortingModel("Periode".tr, "start_date", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Pembayaran".tr, "payment", "A-Z", "Z-A", "".obs),
  ];

  SortingController _sortingControllerHistory;
  var manajemenPromoShortHistory = [
    DataListSortingModel(
        "Tanggal Dibuat".tr, "created_at", "Terbaru", "Terlama", "".obs),
    DataListSortingModel(
        "Lokasi Destinasi".tr, "destination_city", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "Lokasi Pickup".tr, "pickup_city", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Jenis Truk".tr, "head_id", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "Jenis Carrier".tr, "carrier_id", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "Harga Promo".tr, "promo_price", "Terendah", "Tertinggi", "".obs),
    DataListSortingModel("Kapasitas".tr, "min_capacity", "Paling Sedikit",
        "Paling Banyak", "".obs),
    DataListSortingModel("Jumlah Kuota yang Promo".tr, "quota",
        "Paling Sedikit", "Paling Banyak", "".obs),
    DataListSortingModel("Periode".tr, "start_date", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Pembayaran".tr, "payment", "A-Z", "Z-A", "".obs),
  ];

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      if (tabController.index == 0) {
        listManajementPromoData.clear();
        listManajementPromoDataCount.clear();
        cari.value.text = "";
        isLoading.value = true;
        getLastSearch();
        type.value = "data-promo-aktif";
        getListManajementPromo("data-promo-aktif", "false", "false", "10");
      }
      if (tabController.index == 1) {
        listManajementPromoDataHistory.clear();
        cari.value.text = "";
        isLoading.value = true;
        getLastSearchHistory();
        type.value = "data-promo-history";
        getListManajementPromo("data-promo-history", "false", "false", "10");
      }
    });

    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper("4");

    if (resLoginAs["Message"]["Code"] == 200) {
      loginas.value = resLoginAs["LoginAs"].toString();
      getListManajementPromo("data-promo-aktif", "false", "false", "10");
    }

    getLastSearch();

    _sortingController = Get.put(
        SortingController(
            listSort: manajemenPromoShort,
            onRefreshData: (map) {
              sort.clear();
              sort.addAll(map);
              refreshData(type.value);
            }),
        tag: "SortManajementPromo");

    _sortingControllerHistory = Get.put(
        SortingController(
            listSort: manajemenPromoShortHistory,
            onRefreshData: (map) {
              sortHistory.clear();
              sortHistory.addAll(map);
              refreshData(type.value);
            }),
        tag: "SortManajementPromoHistory");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void loadData() {
    isLoadingTabAktif.value = false;
    if (limitTabAktif.value <= limitAktif.value) {
      limitAktif.value = limitAktif.value;
    } else {
      limitAktif.value += 10;
    }
    // if (isFilter.value) {
    //   filterAction("aktif");
    // } else if (issort.value) {
    //   refreshData("aktif");
    // } else {
    getListManajementPromo(
        "data-promo-aktif", "false", "false", limitAktif.value.toString());
    // }

    isLoadingTabAktif.value = false;
  }

  void refreshDataSmart() {
    // limitAktif.value = 10;
    isLoadingTabAktif.value = false;
    getListManajementPromo(
        "data-promo-aktif", "false", "false", limitAktif.value.toString());
    isLoadingTabAktif.value = false;
  }

  void loadDataHistory() {
    isLoadingTabHistory.value = false;
    if (limitTabHistory.value <= limitHistory.value) {
      limitHistory.value = limitHistory.value;
    } else {
      limitHistory.value += 10;
    }
    // if (isFilter.value) {
    //   filterAction("aktif");
    // } else if (issort.value) {
    //   refreshData("aktif");
    // } else {
    getListManajementPromo(
        "data-promo-history", "false", "false", limitHistory.value.toString());
    // }

    isLoadingTabAktif.value = false;
  }

  void refreshDataSmartHistory() {
    // limitAktif.value = 10;
    isLoadingTabHistory.value = false;
    getListManajementPromo(
        "data-promo-history", "false", "false", limitHistory.value.toString());
    isLoadingTabHistory.value = false;
  }

  void refreshData(String type) async {
    try {
      sortAction(type);
    } catch (e) {
      GlobalAlertDialog.showDialogError(
          message: e.toString(),
          context: Get.context,
          onTapPriority1: () {},
          labelButtonPriority1: "LoginLabelButtonCancel".tr);
    }
  }

  void showSort(String type) {
    if (type == "data-promo-aktif") {
      _sortingController.showSort();
    } else {
      _sortingControllerHistory.showSort();
    }
  }

  void sortAction(String type) {
    // var multiOrder = "false";
    var order = "";
    var modeorder = "";
    if (type == "data-promo-aktif") {
      listManajementPromoData.clear();
      listManajementPromoDataCount.clear();
      isLoading.value = true;
      if (sort.isNotEmpty) {
        issort.value = true;

        if (sort.keys.toList().length > 1) {
          // multiOrder = "true";
          order = sort.keys.toList().join(",");
          modeorder = sort.values.toList().join(",");
        } else {
          // multiOrder = "false";
          order = sort.keys.first;
          modeorder = sort.values.first;
        }
      } else {
        issort.value = false;

        // multiOrder = "false";
        order = null;
        modeorder = null;
      }
    } else {
      listManajementPromoDataHistory.clear();
      isLoading.value = true;
      if (sortHistory.isNotEmpty) {
        issortHistory.value = true;

        if (sortHistory.keys.toList().length > 1) {
          // multiOrder = "true";
          order = sortHistory.keys.toList().join(",");
          modeorder = sortHistory.values.toList().join(",");
        } else {
          // multiOrder = "false";
          order = sortHistory.keys.first;
          modeorder = sortHistory.values.first;
        }
      } else {
        issortHistory.value = false;

        // multiOrder = "false";
        order = null;
        modeorder = null;
      }
    }

    getListManajementPromo(type, "false", "false", "10",
        order: order, ordermode: modeorder);
  }

  getListManajementPromo(
      String type, String isFilter, String isSearch, String limit,
      {String order,
      String ordermode,
      String search = "",
      String periodStart = "",
      String periodEnd = "",
      String minCapacity = "",
      String maxCapacity = "",
      String minHarga = "",
      String maxHarga = "",
      String kuotaMax = "",
      String kuotaMin = "",
      String capacityUnit = "",
      List headId,
      List carrierId,
      List pickupLocationId,
      List destinationLocationId,
      List payment}) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListManajementPromo(loginas.value, type, isFilter, isSearch, limit,
            order: order,
            ordermode: ordermode,
            search: search,
            periodStart: periodStart,
            periodEnd: periodEnd,
            minCapacity: minCapacity,
            maxCapacity: maxCapacity,
            minHarga: minHarga,
            maxHarga: maxHarga,
            kuotaMax: kuotaMax,
            kuotaMin: kuotaMin,
            capacityUnit: capacityUnit,
            headId: headId,
            carrierId: carrierId,
            pickupLocationId: pickupLocationId,
            destinationLocationId: destinationLocationId,
            payment: payment);

    if (type == "data-promo-aktif") {
      status.clear();
      statusSearch.clear();
      lihatLebihBanyak.clear();
      lihatLebihBanyakSearch.clear();
      strSwitchButon.clear();
      listManajementPromoDataSearch.clear();
      listManajementPromoDataCount.clear();
      listManajementPromoData.clear();
      listManajementPromoData.add({"tooltip": 0});
      lihatLebihBanyak.add(false);
      status.add(false);
      strSwitchButon.add("Tidak Aktif");
    } else {
      statusHistory.clear();
      statusSearchHistory.clear();
      lihatLebihBanyakHistory.clear();
      strSwitchButonHistory.clear();
      lihatLebihBanyakSearchHistory.clear();
      listManajementPromoDataSearchHistory.clear();
      listManajementPromoDataHistory.clear();
    }

    if (res["Message"]["Code"] == 200) {
      isLoading.value = false;

      if (type == "data-promo-aktif") {
        isLoadingTabAktif.value = false;
        refreshManajementPromoTabAktifController.resetNoData();
        refreshManajementPromoTabAktifController.refreshCompleted();
        refreshManajementPromoTabAktifController.loadComplete();
        limitTabAktif.value = res["SupportingData"]["NoLimitCount"];
      } else {
        isLoadingTabHistory.value = false;
        refreshManajementPromoTabHistoryController.resetNoData();
        refreshManajementPromoTabHistoryController.refreshCompleted();
        refreshManajementPromoTabHistoryController.loadComplete();
        limitHistory.value = res["SupportingData"]["NoLimitCount"];
      }

      (res["Data"] as List).forEach((element) {
        if (isSearch == "true") {
          if (type == "data-promo-aktif") {
            listManajementPromoDataSearch.add(element);
            lihatLebihBanyakSearch.add(false);
            if (element["key"]["status"] == 1) {
              statusSearch.add(true);
              strSwitchButon.add("Aktif");
            } else {
              statusSearch.add(false);
              strSwitchButon.add("Tidak Aktif");
            }
          } else {
            listManajementPromoDataSearchHistory.add(element);
            lihatLebihBanyakSearchHistory.add(false);
            if (element["key"]["status"] == 1) {
              statusSearchHistory.add(true);
              strSwitchButonHistory.add("Aktif");
            } else {
              statusSearchHistory.add(false);
              strSwitchButonHistory.add("Tidak Aktif");
            }
          }
        } else {
          if (type == "data-promo-aktif") {
            listManajementPromoData.add(element);
            listManajementPromoDataCount.add(element);
            lihatLebihBanyak.add(false);
            if (element["key"]["status"] == 1) {
              status.add(true);
              strSwitchButon.add("Aktif");
            } else {
              status.add(false);
              strSwitchButon.add("Tidak Aktif");
            }
          } else {
            listManajementPromoDataHistory.add(element);
            lihatLebihBanyakHistory.add(false);
            if (element["key"]["status"] == 1) {
              statusHistory.add(true);
              strSwitchButonHistory.add("Aktif");
            } else {
              statusHistory.add(false);
              strSwitchButonHistory.add("Tidak Aktif");
            }
          }
        }
      });
    }
  }

  postStatusCard(String idCard, String status, String type) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .postPromoStatus(idCard, status, loginas.value);

    if (res["Message"]["Code"] == 200) {
      if (type == "data-promo-aktif") {
        getListManajementPromo(
            "data-promo-aktif", "false", "false", limitAktif.value.toString());
        CustomToast.show(
          context: Get.context,
          sizeRounded: 6,
          message:
              "Anda berhasil menonaktifkan promo \ndan otomatis masuk pada tab history"
                  .tr,
        );
      } else {
        getListManajementPromo("data-promo-history", "false", "false",
            limitHistory.value.toString());
      }
    }
  }

  toSearchPage(String type) async {
    var res = await Get.toNamed(Routes.ZO_LIST_HARGA_PROMO + "/search",
        arguments: [type]);
    // var res = await GetToPage.toNamed<ZoListHargaPromoController>(
    //     Routes.ZO_LIST_HARGA_PROMO + "/search",
    //     arguments: [type],
    //     preventDuplicates: false);
    if (res != null) {
      if (res) {
        if (type == "data-promo-aktif") {
          getListManajementPromo("data-promo-aktif", "false", "false",
              limitAktif.value.toString());
        } else {
          getListManajementPromo("data-promo-history", "false", "false",
              limitHistory.value.toString());
        }
      }
    }
  }

  clearSearch(value, String type) {
    if (value.length == 0) {
      if (type == "data-promo-aktif") {
        listManajementPromoDataSearch.clear();
      } else {
        listManajementPromoDataSearchHistory.clear();
      }
    }
  }

  setLastSearch(String valSearch) async {
    listChoosen.insert(0, valSearch);
    await SharedPreferencesHelper.setLastSearchManajementPromo(listChoosen);
    getLastSearch();
  }

  getLastSearch() async {
    var strinLelangMuatan =
        await SharedPreferencesHelper.getLastSearchManajementPromo() ?? [];
    listChoosen = strinLelangMuatan;
    listChoosenReturn.value = strinLelangMuatan;
  }

  deletLastSearch(int idx) async {
    listChoosen.removeAt(idx);
    await SharedPreferencesHelper.setLastSearchManajementPromo(listChoosen);
    getLastSearch();
  }

  deleteAllLastSearch() async {
    listChoosen.clear();
    await SharedPreferencesHelper.setLastSearchManajementPromo(listChoosen);
    getLastSearch();
  }

  setLastSearchHistory(String valSearch) async {
    listChoosenHistory.insert(0, valSearch);
    await SharedPreferencesHelper.setLastSearchManajementPromoHistory(
        listChoosenHistory);
    getLastSearchHistory();
  }

  getLastSearchHistory() async {
    var strinLelangMuatan =
        await SharedPreferencesHelper.getLastSearchManajementPromoHistory() ??
            [];
    listChoosenHistory = strinLelangMuatan;
    listChoosenReturnHistory.value = strinLelangMuatan;
  }

  deletLastSearchHistory(int idx) async {
    listChoosenHistory.removeAt(idx);
    await SharedPreferencesHelper.setLastSearchManajementPromoHistory(
        listChoosenHistory);
    getLastSearchHistory();
  }

  deleteAllLastSearchHistory() async {
    listChoosenHistory.clear();
    await SharedPreferencesHelper.setLastSearchManajementPromoHistory(
        listChoosenHistory);
    getLastSearchHistory();
  }

  submitSearch(String value, String type) {
    isLoading.value = true;
    if (type == "data-promo-aktif") {
      getListManajementPromo("data-promo-aktif", "false", "true", "10",
          search: value);
    } else {
      print("LDFSLGSDKB");
      getListManajementPromo("data-promo-history", "false", "true", "10",
          search: value);
    }
  }

  void getListLokasiPickup() async {
    getListFilterLokasiPickup.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchSearchCity("");
    if (resultCity["Message"]["Code"] == 200) {
      listFilterLokasiPickup.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterLokasiPickup.add(element["City"]);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterLokasiPickup.value = false;
    // if (!getListFilterProvince.value) GlobalVariable.languageType = langTemp;
  }

  void getListJenisTruck() async {
    getListFilterJenisTruck.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .listHeadTruck();
    if (resultCity["Message"]["Code"] == 200) {
      listFilterJenisTruck.clear();
      listFilterJenisTruckimg.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterJenisTruck.add(element["Description"]);
        listFilterJenisTruckimg.add(element);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterJenisTruck.value = false;
    // if (!getListFilterProvince.value) GlobalVariable.languageType = langTemp;
  }

  void getListJenisCarrierTruck() async {
    getListFilterJenisCarrier.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .listCarrierTruck();
    if (resultCity["Message"]["Code"] == 200) {
      listFilterJenisCarrier.clear();
      listFilterJenisCarrierimg.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterJenisCarrier.add(element["Description"]);
        listFilterJenisCarrierimg.add(element);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterJenisCarrier.value = false;
    // if (!getListFilterProvince.value) GlobalVariable.languageType = langTemp;
  }

  void getListLokasiDestinasi() async {
    getListFilterLokasiDestinasi.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchSearchCity("");
    if (resultCity["Message"]["Code"] == 200) {
      listFilterLokasiDestinasi.clear();
      (resultCity["Data"] as List).forEach((element) {
        listFilterLokasiDestinasi.add(element["City"]);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterLokasiDestinasi.value = false;
    // if (!getListFilterProvince.value) GlobalVariable.languageType = langTemp;
  }

  void getListFilter(String type) {
    langTemp = GlobalVariable.languageType;
    GlobalVariable.languageType = "id_ID";
    getListLokasiPickup();
    getListLokasiDestinasi();
    // getListProvince();
    getListJenisTruck();
    getListJenisCarrierTruck();
    // getListMuatan(type);
  }

  void resetFilter() {
    tempFilterLokasiPickup.clear();
    tempFilterLokasiDestinasi.clear();
    tempFilterJenisTruck.clear();
    tempFilterJenisTruckimg.clear();
    tempFilterJenisCarrier.clear();
    tempFilterJenisCarrierimg.clear();
  }

  void showFilter(String type) async {
    // tempFilterLokasiPickup.value = List.from(filterLokasiPickup.value);
    // tempFilterLokasiDestinasi.value = List.from(filterLokasiDestinasi.value);
    // tempFilterProvince.value = List.from(filterProvince.value);
    if (firstTime || failedGetListFilter.value) getListFilter(type);
    firstTime = false;
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(Get.context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 4,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 16),
                  height: GlobalVariable.ratioWidth(Get.context) * 3,
                  width: GlobalVariable.ratioWidth(Get.context) * 38,
                  color: Color(ListColor.colorLightGrey16),
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 12,
                        right: GlobalVariable.ratioWidth(Get.context) * 18,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 20),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: CustomText("GlobalFilterTitle".tr,
                                fontWeight: FontWeight.w700,
                                color: Color(ListColor.color4),
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14)),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                child: Icon(
                              Icons.close_rounded,
                              size: GlobalVariable.ratioFontSize(Get.context) *
                                  24,
                            )),
                          ),
                        ),
                        Obx(
                          () => !failedGetListFilter.value &&
                                  !getListFilterLokasiPickup.value &&
                                  !getListFilterLokasiDestinasi.value &&
                                  !getListFilterJenisTruck.value &&
                                  !getListFilterJenisCarrier.value
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        child: CustomText(
                                          "GlobalFilterButtonReset".tr,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(ListColor.color4),
                                        ),
                                        onTap: () {
                                          resetFilter();
                                        }),
                                  ),
                                )
                              : SizedBox.shrink(),
                        )
                      ],
                    )),
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(Get.context).size.height - 200,
                        minHeight: 0,
                        minWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 18),
                      child: Obx(
                        () => (getListFilterLokasiPickup.value ||
                                getListFilterLokasiDestinasi.value)
                            ? Container(
                                width: MediaQuery.of(Get.context).size.width,
                                height: 200,
                                child: Center(
                                    child: Container(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator())))
                            : !failedGetListFilter.value
                                ? (listFilterLokasiPickup.isNotEmpty ||
                                        listFilterLokasiDestinasi.isNotEmpty)
                                    ? ListView(
                                        shrinkWrap: true,
                                        children: [
                                          _formFilterLokasiPickUp(),
                                          ZoWidgetHelper().listseparator(),
                                          _formFilterLokasiDestinasi(),
                                          ZoWidgetHelper().listseparator(),
                                          _formFilterJenisTruck(),
                                          ZoWidgetHelper().listseparator(),
                                          _formFilterJenisCarrier(),
                                          ZoWidgetHelper().listseparator(),
                                          _formPeriodePromo(),
                                          ZoWidgetHelper().listseparator(),
                                          _formHargaPromo(),
                                          ZoWidgetHelper().listseparator(),
                                          _formKapasitas(),
                                          ZoWidgetHelper().listseparator(),
                                          _formJumlahTruk(),
                                          ZoWidgetHelper().listseparator(),
                                          _formPembayaran(),
                                          ZoWidgetHelper().listseparator(),
                                        ],
                                      )
                                    : SizedBox.shrink()
                                : Container(
                                    width:
                                        MediaQuery.of(Get.context).size.width,
                                    height: 200,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 10),
                                          CustomText(
                                            'GlobalLabelErrorNoCTypection'.tr,
                                            textAlign: TextAlign.center,
                                            fontSize:
                                                GlobalVariable.ratioFontSize(
                                                        Get.context) *
                                                    14,
                                          ),
                                          SizedBox(height: 10),
                                          GestureDetector(
                                              onTap: () {
                                                getListFilter(type);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: CustomText(
                                                  'GlobalButtonTryAgain'.tr,
                                                  fontSize: GlobalVariable
                                                          .ratioFontSize(
                                                              Get.context) *
                                                      14,
                                                  color:
                                                      Color(ListColor.color4),
                                                ),
                                              ))
                                        ])),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 10,
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 10),
                  height: GlobalVariable.ratioWidth(context) * 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x54000000),
                          spreadRadius: 2,
                          blurRadius: 80,
                        ),
                      ]),
                  child: Row(
                    children: [
                      Expanded(child: _buttonPrioritySecondary()),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 8,
                      ),
                      Expanded(child: _buttonPriorityPrimary(type)),
                    ],
                  ),
                )
              ],
            ),
          ));
        });
  }

  _formFilterLokasiPickUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                "LelangMuatBuatLelangBuatLelangLabelTitleLokasiPickup".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterLokasiPickup.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterLokasiPickup.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showAllPickup();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilter(
                listFilterLokasiPickup.value, tempFilterLokasiPickup.value,
                (bool onSelect, String value) {
              if (onSelect)
                tempFilterLokasiPickup.add(value);
              else
                tempFilterLokasiPickup.remove(value);
            }))
      ],
    );
  }

  _formFilterLokasiDestinasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                "LelangMuatTabAktifTabAktifLabelTitleDestinationLocation".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterLokasiDestinasi.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterLokasiDestinasi.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showAllDestinasi();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilter(listFilterLokasiDestinasi.value,
                tempFilterLokasiDestinasi.value, (bool onSelect, String value) {
              if (onSelect)
                tempFilterLokasiDestinasi.add(value);
              else
                tempFilterLokasiDestinasi.remove(value);
            }))
      ],
    );
  }

  _formFilterJenisTruck() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("LelangMuatTabAktifTabAktifLabelTitleTruckType".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterJenisTruck.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterJenisTruck.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // showAll(0);
                    showAllJenisTruck();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilterJenisTrukCarrier(
                listFilterJenisTruckimg.value, tempFilterJenisTruck.value,
                (bool onSelect, Map value) {
              if (onSelect) {
                print("SDLAKDAK $value");
                tempFilterJenisTruck.add(value);
              } else {
                tempFilterJenisTruck.remove(value);
              }
            }))
      ],
    );
  }

  _formFilterJenisCarrier() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText("LelangMuatTabAktifTabAktifLabelTitleCarrierType".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterJenisCarrier.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterJenisCarrier.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // showAll(0);
                    showAllJenisCarrierTruck();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilterJenisTrukCarrier(
                listFilterJenisCarrierimg.value, tempFilterJenisCarrier.value,
                (bool onSelect, Map value) {
              if (onSelect)
                tempFilterJenisCarrier.add(value);
              else
                tempFilterJenisCarrier.remove(value);
            }))
      ],
    );
  }

  _formPeriodePromo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ZoWidgetHelper()
            .labelText("Periode Promo", Colors.black, 14, FontWeight.w600),
        ZoWidgetHelper().sizeBoxHeight(12),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  CustomTextField(
                      key: ValueKey("startPeriodePromo"),
                      context: Get.context,
                      readOnly: true,
                      onTap: () {
                        // _datetimeRangePicker(isController);
                        // _datestartPicker(isController);
                      },
                      controller: periodePromoAwal.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 9),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "hh/bb/tttt", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // _datestartPicker(isController);
                          // controller.onClearSearch();
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: SvgPicture.asset("assets/ic_calendar.svg",
                                color: Colors.black,
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    24)),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(Get.context) * 19,
            ),
            Container(
              child: CustomText(
                "LelangMuatTabAktifTabAktifLabelTitleToDate".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(Get.context) * 19,
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  CustomTextField(
                      key: ValueKey("endPeriodePromo"),
                      context: Get.context,
                      readOnly: true,
                      onTap: () {
                        // // _datetimeRangePicker(isController);
                        // if (isSelectStartDateTglBuat.value) {
                        //   _dateendPicker(isController);
                        // } else if (isSelectStartDatePeriodeLelang.value) {
                        //   _dateendPicker(isController);
                        // } else if (isSelectStartDateWaktuPickup.value) {
                        //   _dateendPicker(isController);
                        // } else if (isSelectStartDateEstimasiKedatangan.value) {
                        //   _dateendPicker(isController);
                        // }
                        // // if (isSelectStartDatePeriodeLelang.value) {
                        // //   _dateendPicker(isController);
                        // // }
                        // // if (isSelectStartDateWaktuPickup.value) {
                        // //   _dateendPicker(isController);
                        // // }
                        // // if (isSelectStartDateEstimasiKedatangan.value) {
                        // //   _dateendPicker(isController);
                        // // }
                      },
                      controller: periodePromoAkhir.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 9),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "hh/bb/tttt", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // // _datetimeRangePicker(isController);
                          // if (isSelectStartDateTglBuat.value) {
                          //   _dateendPicker(isController);
                          // } else if (isSelectStartDatePeriodeLelang.value) {
                          //   _dateendPicker(isController);
                          // } else if (isSelectStartDateWaktuPickup.value) {
                          //   _dateendPicker(isController);
                          // } else if (isSelectStartDateEstimasiKedatangan.value) {
                          //   _dateendPicker(isController);
                          // }
                          // // controller.onClearSearch();
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: SvgPicture.asset("assets/ic_calendar.svg",
                                color: Colors.black,
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    24)),
                      )),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  _formHargaPromo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ZoWidgetHelper()
            .labelText("Harga Promo", Colors.black, 14, FontWeight.w600),
        ZoWidgetHelper().sizeBoxHeight(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CustomTextField(
                      key: ValueKey("startHargaPromo"),
                      context: Get.context,
                      controller: startHargaPromo.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        // getVlidatoreror(value, "startkebutuhan");

                        // if (int.parse(value) >
                        //     int.parse(endJumlahKebutuhan.value.text == ""
                        //         ? "0"
                        //         : endJumlahKebutuhan.value.text)) {
                        //   getValidateerorkelebihan("startkebutuhan");
                        // } else {
                        //   iserorstartkebutuhankelebihan.value = "";
                        // }

                        // if (int.parse(value) > 1500) {
                        // } else {
                        //   if (int.parse(_rangeValuesJmlKebutuhan.value.start
                        //           .toString()) <
                        //       int.parse(value)) {
                        //   } else {
                        //     _rangeValuesJmlKebutuhan.value = RangeValues(
                        //         double.parse(value),
                        //         _rangeValuesJmlKebutuhan.value.end);
                        //   }
                        // }
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 9),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "0", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                ),
                Container(
                    height: 1,
                    width: GlobalVariable.ratioWidth(Get.context) * 92,
                    color: Color(ListColor.colorLightGrey10)),
                Expanded(
                  child: CustomTextField(
                      key: ValueKey("endHargaPromo"),
                      context: Get.context,
                      controller: endHargaPromo.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        // getVlidatoreror(value, "endkebutuhan");

                        // if (int.parse(startJumlahKebutuhan.value.text == ""
                        //         ? "0"
                        //         : startJumlahKebutuhan.value.text) >
                        //     int.parse(value)) {
                        //   getValidateerorkelebihan("endkebutuhan");
                        // } else {
                        //   iserorstartkebutuhankelebihan.value = "";
                        // }

                        // if (int.parse(value) > 1500) {
                        // } else {
                        //   if (int.parse(_rangeValuesJmlKebutuhan.value.start
                        //           .toString()) <
                        //       int.parse(value)) {
                        //   } else {
                        //     _rangeValuesJmlKebutuhan.value = RangeValues(
                        //         _rangeValuesJmlKebutuhan.value.start,
                        //         double.parse(value));
                        //   }
                        // }
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 9),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "1500", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                ),
              ],
            ),
            CustomText(
              "tes",
              color: Color(ListColor.colorRed),
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 12,
            ),
            Obx(
              () => Container(
                child: SliderTheme(
                  data: SliderThemeData(
                      trackHeight: 1,
                      activeTrackColor: Color(ListColor.colorBlue),
                      inactiveTrackColor: Color(ListColor.colorGrey),
                      thumbColor: Color(ListColor.colorWhite),
                      overlayShape: RoundSliderOverlayShape(
                          overlayRadius:
                              GlobalVariable.ratioWidth(Get.context) * 10),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0)),
                  child: RangeSlider(
                    min: 0,
                    max: 1500,
                    values: _rangeValuesHargaPromo.value,
                    onChanged: (values) {
                      // _rangeValuesJmlKebutuhan.value = values;

                      // startJumlahKebutuhan.value.text =
                      //     values.start.toInt().toString();
                      // endJumlahKebutuhan.value.text = values.end.toInt().toString();
                    },
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  _formKapasitas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ZoWidgetHelper()
            .labelText("Kapasitas", Colors.black, 14, FontWeight.w600),
        ZoWidgetHelper().sizeBoxHeight(12),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CustomTextField(
                  key: ValueKey("startKapasitas"),
                  context: Get.context,
                  readOnly: true,
                  onTap: () {
                    // _datetimeRangePicker(isController);
                    // _datestartPicker(isController);
                  },
                  controller: periodePromoAwal.value,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  newContentPadding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                  textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  newInputDecoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: "0", // "Cari Area Pick Up",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  )),
            ),
            ZoWidgetHelper().sizeBoxWidth(8),
            Container(
              child: CustomText(
                "LelangMuatTabAktifTabAktifLabelTitleToDate".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
            ZoWidgetHelper().sizeBoxWidth(8),
            Expanded(
              child: CustomTextField(
                  key: ValueKey("endKapasitas"),
                  context: Get.context,
                  readOnly: true,
                  onTap: () {
                    // // _datetimeRangePicker(isController);
                    // if (isSelectStartDateTglBuat.value) {
                    //   _dateendPicker(isController);
                    // } else if (isSelectStartDatePeriodeLelang.value) {
                    //   _dateendPicker(isController);
                    // } else if (isSelectStartDateWaktuPickup.value) {
                    //   _dateendPicker(isController);
                    // } else if (isSelectStartDateEstimasiKedatangan.value) {
                    //   _dateendPicker(isController);
                    // }
                    // // if (isSelectStartDatePeriodeLelang.value) {
                    // //   _dateendPicker(isController);
                    // // }
                    // // if (isSelectStartDateWaktuPickup.value) {
                    // //   _dateendPicker(isController);
                    // // }
                    // // if (isSelectStartDateEstimasiKedatangan.value) {
                    // //   _dateendPicker(isController);
                    // // }
                  },
                  controller: periodePromoAkhir.value,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  newContentPadding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                  textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  newInputDecoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: "0", // "Cari Area Pick Up",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(ListColor.colorLightGrey19), width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  )),
            ),
            ZoWidgetHelper().sizeBoxWidth(12),
            Container(
                child: DropdownBelow(
                    key: ValueKey("selectedsatuankapasitas"),
                    items: [
                      DropdownMenuItem(
                        child: CustomText("Ton",
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            color: Color(ListColor.colorLightGrey4)),
                        value: "Ton",
                      ),
                      DropdownMenuItem(
                        child: Html(
                            style: {
                              "body": Style(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero)
                            },
                            data:
                                '<span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 14}; color: #676767;">m<sup>3<sup></span'),
                        value: "m3",
                      ),
                      DropdownMenuItem(
                        child: CustomText("Liter",
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            color: Color(ListColor.colorLightGrey4)),
                        value: "Lt",
                      )
                    ],
                    onChanged: (value) {
                      _selectedsatuankapasitas.value = value;
                    },
                    itemWidth: 65,
                    itemTextstyle: TextStyle(
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        fontWeight: FontWeight.w400,
                        color: Color(ListColor.colorLightGrey4)),
                    boxTextstyle: TextStyle(
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        fontWeight: FontWeight.w400,
                        color: Color(ListColor.colorLightGrey4)),
                    boxPadding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 8,
                        right: GlobalVariable.ratioWidth(Get.context) * 8),
                    // boxPadding: EdgeInsets.symmetric(
                    //     horizontal:
                    //         GlobalVariable.ratioWidth(Get.context) * 8,
                    //     vertical:
                    //         GlobalVariable.ratioWidth(Get.context) * 9),
                    boxWidth: 100,
                    // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 44,
                    boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
                        GlobalVariable.ratioWidth(Get.context) * 12 +
                        GlobalVariable.ratioWidth(Get.context) * 12,
                    boxDecoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1, color: Color(ListColor.colorLightGrey19)),
                        borderRadius: BorderRadius.circular(6)),
                    icon: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Color(ListColor.colorLightGrey19)),
                    hint: _selectedsatuankapasitas == "m3"
                        ? Html(
                            style: {
                                "body": Style(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero)
                              },
                            data:
                                '<span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 14}; color: #676767;">m<sup>3<sup></span')
                        : CustomText(_selectedsatuankapasitas.value,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            color: Color(ListColor.colorLightGrey4)),
                    value: _selectedsatuankapasitas.value))
          ],
        )
      ],
    );
  }

  _formJumlahTruk() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ZoWidgetHelper()
            .labelText("Jumlah Truk", Colors.black, 14, FontWeight.w600),
        ZoWidgetHelper().sizeBoxHeight(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CustomTextField(
                      key: ValueKey("startJumlahTruk"),
                      context: Get.context,
                      controller: startHargaPromo.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        // getVlidatoreror(value, "startkebutuhan");

                        // if (int.parse(value) >
                        //     int.parse(endJumlahKebutuhan.value.text == ""
                        //         ? "0"
                        //         : endJumlahKebutuhan.value.text)) {
                        //   getValidateerorkelebihan("startkebutuhan");
                        // } else {
                        //   iserorstartkebutuhankelebihan.value = "";
                        // }

                        // if (int.parse(value) > 1500) {
                        // } else {
                        //   if (int.parse(_rangeValuesJmlKebutuhan.value.start
                        //           .toString()) <
                        //       int.parse(value)) {
                        //   } else {
                        //     _rangeValuesJmlKebutuhan.value = RangeValues(
                        //         double.parse(value),
                        //         _rangeValuesJmlKebutuhan.value.end);
                        //   }
                        // }
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 9),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "0", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                ),
                Container(
                    height: 1,
                    width: GlobalVariable.ratioWidth(Get.context) * 92,
                    color: Color(ListColor.colorLightGrey10)),
                Expanded(
                  child: CustomTextField(
                      key: ValueKey("endJumlahTruk"),
                      context: Get.context,
                      controller: endHargaPromo.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        // getVlidatoreror(value, "endkebutuhan");

                        // if (int.parse(startJumlahKebutuhan.value.text == ""
                        //         ? "0"
                        //         : startJumlahKebutuhan.value.text) >
                        //     int.parse(value)) {
                        //   getValidateerorkelebihan("endkebutuhan");
                        // } else {
                        //   iserorstartkebutuhankelebihan.value = "";
                        // }

                        // if (int.parse(value) > 1500) {
                        // } else {
                        //   if (int.parse(_rangeValuesJmlKebutuhan.value.start
                        //           .toString()) <
                        //       int.parse(value)) {
                        //   } else {
                        //     _rangeValuesJmlKebutuhan.value = RangeValues(
                        //         _rangeValuesJmlKebutuhan.value.start,
                        //         double.parse(value));
                        //   }
                        // }
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 9),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "1500", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                ),
              ],
            ),
            CustomText(
              "tes",
              color: Color(ListColor.colorRed),
            ),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 12,
            ),
            Obx(
              () => Container(
                child: SliderTheme(
                  data: SliderThemeData(
                      trackHeight: 1,
                      activeTrackColor: Color(ListColor.colorBlue),
                      inactiveTrackColor: Color(ListColor.colorGrey),
                      thumbColor: Color(ListColor.colorWhite),
                      overlayShape: RoundSliderOverlayShape(
                          overlayRadius:
                              GlobalVariable.ratioWidth(Get.context) * 10),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0)),
                  child: RangeSlider(
                    min: 0,
                    max: 1500,
                    values: _rangeValuesHargaPromo.value,
                    onChanged: (values) {
                      // _rangeValuesJmlKebutuhan.value = values;

                      // startJumlahKebutuhan.value.text =
                      //     values.start.toInt().toString();
                      // endJumlahKebutuhan.value.text = values.end.toInt().toString();
                    },
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  _formPembayaran() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ZoWidgetHelper()
            .labelText("Pembayaran", Colors.black, 14, FontWeight.w600),
        ZoWidgetHelper().sizeBoxHeight(12),
      ],
    );
  }

  Widget _buttonPriorityPrimary(String type) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Color(ListColor.color4),
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        Get.back();
        // filterAction(type);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Stack(alignment: Alignment.center, children: [
          CustomText(
            "LelangMuatBuatLelangBuatLelangLabelTitleSave".tr,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
          ),
        ]),
      ),
    );
  }

  Widget _buttonPrioritySecondary() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        Get.back();
        resetFilter();
        // if (!disableGetBack) Get.back();
        // if (onTapPriority != null) onTapPriority();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Stack(alignment: Alignment.center, children: [
          CustomText("LelangMuatTabAktifTabAktifLabelTitleCancelFilter".tr,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.color4),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 12),
        ]),
      ),
    );
  }

  Widget wrapFilter(List listShow, List listSelected,
      void Function(bool isChoosen, String value) onTapItem) {
    var listNotSelected = List.from(listShow);
    listNotSelected.removeWhere((element) => listSelected.contains(element));
    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 8,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
      children: [
        for (var index = 0;
            index <
                (listSelected.length > limitWrap
                    ? limitWrap
                    : listSelected.length);
            index++)
          itemWrap(listSelected[index], true, onTapItem),
        for (var index = 0;
            index <
                (listNotSelected.length + listSelected.length <= limitWrap
                    ? listNotSelected.length
                    : limitWrap - listSelected.length);
            index++)
          itemWrap(listNotSelected[index], false, onTapItem),
      ],
    );
  }

  Widget itemWrap(String name, bool isChoosen,
      void Function(bool isChoosen, String value) onTapItem) {
    double borderRadius = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: 1,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorLightGrey7)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            onTapItem(!isChoosen, name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: CustomText(
              name,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  Widget wrapFilterJenisTrukCarrier(List listShow, List listSelected,
      void Function(bool isChoosen, Map value) onTapItem) {
    var listNotSelected = List.from(listShow);
    listNotSelected.removeWhere((element) => listSelected.contains(element));

    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 8,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
      children: [
        for (var index = 0;
            index <
                (listSelected.length > limitWrap
                    ? limitWrap
                    : listSelected.length);
            index++)
          itemWrapJenistruckCarrier(listSelected[index], true, onTapItem),
        for (var index = 0;
            index <
                (listNotSelected.length + listSelected.length <= limitWrap
                    ? listNotSelected.length
                    : limitWrap - listSelected.length);
            index++)
          itemWrapJenistruckCarrier(listNotSelected[index], false, onTapItem),
      ],
    );
  }

  Widget itemWrapJenistruckCarrier(Map name, bool isChoosen,
      void Function(bool isChoosen, Map value) onTapItem) {
    double borderRadius = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: 1,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorLightGrey7)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            onTapItem(!isChoosen, name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: CustomText(
              name["Description"],
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  void showAllDestinasi() async {
    var result = await GetToPage.toNamed<ZoFilterLelangMuatanController>(
        Routes.ZO_FILTER_LELANG_MUATAN,
        arguments: [
          List.from(listFilterLokasiDestinasi.value),
          List.from(tempFilterLokasiDestinasi.value),
          "LelangMuatTabAktifTabAktifLabelTitleDestinationLocation".tr
        ],
        preventDuplicates: false);
    if (result != null) {
      tempFilterLokasiDestinasi.value = result;
    }
  }

  void showAllPickup() async {
    var result = await GetToPage.toNamed<ZoFilterLelangMuatanController>(
        Routes.ZO_FILTER_LELANG_MUATAN,
        arguments: [
          List.from(listFilterLokasiPickup.value),
          List.from(tempFilterLokasiPickup.value),
          "LelangMuatBuatLelangBuatLelangLabelTitleLokasiPickup".tr
        ],
        preventDuplicates: false);
    if (result != null) {
      tempFilterLokasiPickup.value = result;
    }
  }

  void showAllJenisTruck() async {
    var result =
        await GetToPage.toNamed<ZoFilterJenisTrukLelangMuatanController>(
            Routes.ZO_FILTER_JENIS_TRUK_LELANG_MUATAN,
            arguments: [
              List.from(listFilterJenisTruckimg.value),
              List.from(tempFilterJenisTruck.value),
              "LelangMuatTabAktifTabAktifLabelTitleTruckType".tr
            ],
            preventDuplicates: false);
    if (result != null) {
      tempFilterJenisTruck.value = result;
    }
  }

  void showAllJenisCarrierTruck() async {
    var result =
        await GetToPage.toNamed<ZoFilterJenisTrukLelangMuatanController>(
            Routes.ZO_FILTER_JENIS_TRUK_LELANG_MUATAN,
            arguments: [
              List.from(listFilterJenisCarrierimg.value),
              List.from(tempFilterJenisCarrier.value),
              "LelangMuatTabAktifTabAktifLabelTitleCarrierType".tr
            ],
            preventDuplicates: false);
    if (result != null) {
      tempFilterJenisCarrier.value = result;
    }
  }
}
