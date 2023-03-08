import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_detail_lelang_muatan/ZO_detail_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_peserta_lelang/ZO_peserta_lelang_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/shared_preferences_helper_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoSearchLelangMuatanController extends GetxController {
  //kosong
  var argumn = "".obs;
  var searchValue = "".obs;
  var type = "".obs;
  var cariList = [].obs;
  final isShowClearSearch = false.obs;
  var listDataLelangMuatan = [].obs;
  var listDataLelangMuatanHistory = [].obs;
  var istidakadadata = false.obs;
  var istidakadadatahistory = false.obs;
  var onTapTextField = true.obs;
  var listChoosen = [];
  var listChoosenReturn = [].obs;
  var lengthLastSearch = 3.obs;
  var lengthSearch = 0.obs;

  var isLoading = false.obs;

  var lengthPickup = [].obs;
  var lengthDestinasi = [].obs;
  var lengthPickupHistory = [].obs;
  var lengthDestinasiHistory = [].obs;

  final refreshLelangMuatanTabAktifController =
      RefreshController(initialRefresh: false);
  final refreshLelangMuatanTabHistoryController =
      RefreshController(initialRefresh: false);
  var isLoadingTabAktif = false.obs;
  var isLoadingTabHistory = false.obs;
  var limitTabAktif = 0.obs;
  var limitTabHistory = 0.obs;
  var limitAktif = 10.obs;

  var limitHistory = 10.obs;

  //textediting
  final cari = TextEditingController().obs;

  var sort = Map().obs;
  var sortHistory = Map().obs;
  var issort = false.obs;
  var issortHistory = false.obs;

  SortingController _sortingController;
  SortingController _sortingControllerHistory;
  var transporterSort = [
    DataListSortingModel("LelangMuatTabAktifTabAktifLableTitleSortNumber".tr,
        "bid_no", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortCreatedDate".tr,
        "Created",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortRoute".tr,
        "rute", "A-Z", "Z-A", "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortPeriod".tr,
        "periode", "A-Z", "Z-A", "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortReqQty".tr,
        "truck_qty", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortPickupTime".tr,
        "pickup_eta",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortExpectedArrival".tr,
        "destination_eta",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortStatusTransporter".tr,
        "viewers",
        "A-Z",
        "Z-A",
        "".obs),
  ];

  var transporterSortHistory = [
    DataListSortingModel("LelangMuatTabAktifTabAktifLableTitleSortNumber".tr,
        "bid_no", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortCreatedDate".tr,
        "Created",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortRoute".tr,
        "rute", "A-Z", "Z-A", "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortPeriod".tr,
        "periode", "A-Z", "Z-A", "".obs),
    DataListSortingModel("LelangMuatTabAktifTabAktifLabelTitleSortReqQty".tr,
        "truck_qty", "A-Z", "Z-A", "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortPickupTime".tr,
        "pickup_eta",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortExpectedArrival".tr,
        "destination_eta",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatTabAktifTabAktifLabelTitleSortStatusTransporter".tr,
        "viewers",
        "A-Z",
        "Z-A",
        "".obs),
  ];

  @override
  void onInit() async {
    _sortingController = Get.put(
        SortingController(
            listSort: transporterSort,
            onRefreshData: (map) {
              sort.clear();
              sort.addAll(map);
              refreshData();
            }),
        tag: "SortLelangMuatanCari");

    _sortingControllerHistory = Get.put(
        SortingController(
            listSort: transporterSortHistory,
            onRefreshData: (map) {
              sortHistory.clear();
              sortHistory.addAll(map);
              refreshData();
            }),
        tag: "SortLelangMuatanCariHistory");
    type.value = Get.arguments[0];

    if (type.value == "aktif") {
      getLastSearch();
    }
    if (type.value == "history") {
      getLastSearchHistory();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  setLastSearch(String valSearch) async {
    listChoosen.insert(0, valSearch);

    if (listChoosen.length > 3) {
      listChoosen.removeAt(3);
    }
    await SharedPreferencesHelper.setLastSearchLelangMuatan(listChoosen);
    getLastSearch();
  }

  getLastSearch() async {
    var strinLelangMuatan =
        await SharedPreferencesHelper.getLastSearchLelangMuatan() ?? [];
    listChoosen = strinLelangMuatan;
    listChoosenReturn.value = strinLelangMuatan;
  }

  deletLastSearch(int idx) async {
    listChoosen.removeAt(idx);
    await SharedPreferencesHelper.setLastSearchLelangMuatan(listChoosen);
    getLastSearch();
  }

  deleteAllLastSearch() async {
    listChoosen.clear();
    await SharedPreferencesHelper.setLastSearchLelangMuatan(listChoosen);
    getLastSearch();
  }

  setLastSearchHistory(String valSearch) async {
    listChoosen.insert(0, valSearch);

    if (listChoosen.length > 3) {
      listChoosen.removeAt(3);
    }
    await SharedPreferencesHelper.setLastSearchLelangMuatanHistory(listChoosen);
    getLastSearchHistory();
  }

  getLastSearchHistory() async {
    var strinLelangMuatan =
        await SharedPreferencesHelper.getLastSearchLelangMuatanHistory() ?? [];
    listChoosen = strinLelangMuatan;
    listChoosenReturn.value = strinLelangMuatan;
  }

  deletLastSearchHistory(int idx) async {
    listChoosen.removeAt(idx);
    await SharedPreferencesHelper.setLastSearchLelangMuatanHistory(listChoosen);
    getLastSearchHistory();
  }

  deleteAllLastSearchHistory() async {
    listChoosen.clear();
    await SharedPreferencesHelper.setLastSearchLelangMuatanHistory(listChoosen);
    getLastSearchHistory();
  }

  void refreshData() async {
    try {
      sortAction();
    } catch (e) {
      GlobalAlertDialog.showDialogError(
          message: e.toString(),
          context: Get.context,
          onTapPriority1: () {},
          labelButtonPriority1: "LoginLabelButtonCancel".tr);
    }
  }

  void showSort() {
    _sortingController.showSort();
  }

  void showSortHistory() {
    _sortingControllerHistory.showSort();
  }

  void sortAction() {
    var multiOrder = "false";
    var order = "";
    var modeorder = "";
    if (type.value == "aktif") {
      if (sort.isNotEmpty) {
        issort.value = true;

        if (sort.keys.toList().length > 1) {
          multiOrder = "true";
          order = sort.keys.toList().join(",");
          modeorder = sort.values.toList().join(",");
        } else {
          multiOrder = "false";
          order = sort.keys.first;
          modeorder = sort.values.first;
        }
      } else {
        issort.value = false;

        multiOrder = "false";
        order = "";
        modeorder = "";
      }
    }

    if (type.value == "history") {
      if (sortHistory.isNotEmpty) {
        issortHistory.value = true;

        if (sortHistory.keys.toList().length > 1) {
          multiOrder = "true";
          order = sortHistory.keys.toList().join(",");
          modeorder = sortHistory.values.toList().join(",");
        } else {
          multiOrder = "false";
          order = sortHistory.keys.first;
          modeorder = sortHistory.values.first;
        }
      } else {
        issortHistory.value = false;

        multiOrder = "false";
        order = "";
        modeorder = "";
      }
    }

    getListLelangMuatan(type.value, "10",
        word: searchValue.toString(),
        filter: "false",
        search: "true",
        startdate: "",
        enddate: "",
        startcreateddate: "",
        endcreateddate: "",
        startpickupdate: "",
        endpickupdate: "",
        startdestinationdate: "",
        enddestinationdate: "",
        mintrukqty: "",
        maxtrukqty: "",
        minkoliqty: "",
        maxkoliqty: "",
        length: "",
        width: "",
        height: "",
        dimensionUnit: "",
        volume: "",
        idcargotype: [],
        status: [],
        cargo: [],
        pickuplocation: [],
        destinationlocation: [],
        province: [],
        headid: [],
        carrierid: [],
        orderBy: order,
        orderMode: modeorder,
        multiOrder: multiOrder);
  }

  void getListLelangMuatan(String typenya, String limit,
      {String word = "",
      String search = "false",
      String filter = "false",
      String startdate = "",
      String enddate = "",
      String startcreateddate = "",
      String endcreateddate = "",
      String startpickupdate = "",
      String endpickupdate = "",
      String startdestinationdate = "",
      String enddestinationdate = "",
      String mintrukqty = "",
      String maxtrukqty = "",
      String minkoliqty = "",
      String maxkoliqty = "",
      String length = '',
      String width = '',
      String height = '',
      String dimensionUnit = "",
      String volume = "",
      List idcargotype,
      List status,
      List cargo,
      List pickuplocation,
      List destinationlocation,
      List province,
      List headid,
      List carrierid,
      String orderBy = "",
      String orderMode = "",
      String multiOrder = "false",
      String offset = ""}) async {
    if (type.value == "aktif") {
      isLoadingTabAktif.value = true;
    }
    if (type.value == "history") {
      isLoadingTabHistory.value = true;
    }
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      var resultCity = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getListLelangMuatan(
              typenya, search, filter, resLoginAs["LoginAs"].toString(),
              word: word,
              startdate: startdate,
              enddate: enddate,
              startcreateddate: startcreateddate,
              endcreateddate: endcreateddate,
              startpickupdate: startpickupdate,
              endpickupdate: endpickupdate,
              startdestinationdate: startdestinationdate,
              enddestinationdate: enddestinationdate,
              mintrukqty: mintrukqty,
              maxtrukqty: maxtrukqty,
              minkoliqty: minkoliqty,
              maxkoliqty: maxkoliqty,
              length: length,
              width: width,
              height: height,
              dimensionUnit: dimensionUnit,
              volume: volume,
              idcargotype: idcargotype,
              status: status,
              cargo: cargo,
              pickuplocation: pickuplocation,
              destinationlocation: destinationlocation,
              province: province,
              headid: headid,
              carrierid: carrierid,
              orderBy: orderBy,
              orderMode: orderMode,
              multiOrder: multiOrder,
              limit: limit,
              offset: offset);

      if (resultCity["Message"]["Code"] == 200) {
        if (type.value == "aktif") {
          listDataLelangMuatan.clear();
          isLoadingTabAktif.value = false;
          refreshLelangMuatanTabAktifController.resetNoData();
          refreshLelangMuatanTabAktifController.refreshCompleted();
          refreshLelangMuatanTabAktifController.loadComplete();
          lengthPickup.clear();
          lengthDestinasi.clear();
        }
        if (type.value == "history") {
          listDataLelangMuatanHistory.clear();
          isLoadingTabHistory.value = false;
          refreshLelangMuatanTabHistoryController.resetNoData();
          refreshLelangMuatanTabHistoryController.refreshCompleted();
          refreshLelangMuatanTabHistoryController.loadComplete();
          lengthPickupHistory.clear();
          lengthDestinasiHistory.clear();
        }

        if (type.value == "aktif") {
          limitTabAktif.value = resultCity["SupportingData"]["NoLimitCount"];
        }
        if (type.value == "history") {
          limitTabHistory.value = resultCity["SupportingData"]["NoLimitCount"];
        }

        (resultCity["Data"] as List).forEach((element) {
          var idx = resultCity["Data"].indexOf(element);

          if (type.value == "aktif") {
            lengthPickup.add(0);
            lengthDestinasi.add(0);
            listDataLelangMuatan.add(element);
          }
          if (type.value == "history") {
            lengthPickupHistory.add(0);
            lengthDestinasiHistory.add(0);
            listDataLelangMuatanHistory.add(element);
          }

          var listpickhis = [];
          var listdeshis = [];
          var listpick = [];
          var listdes = [];
          (element["Location"] as List).forEach((el) {
            if (type.value == "aktif") {
              if (el["Type"] == "0") {
                listpick.add(el);
              }
              if (el["Type"] == "1") {
                listdes.add(el);
              }
            }

            if (type.value == "history") {
              if (el["Type"] == "0") {
                listpickhis.add(el);
              }
              if (el["Type"] == "1") {
                listdeshis.add(el);
              }
            }
          });

          if (type.value == "aktif") {
            lengthPickup[idx] = listpick.length;
            lengthDestinasi[idx] = listdes.length;
          }
          if (type.value == "history") {
            lengthPickupHistory[idx] = listpickhis.length;
            lengthDestinasiHistory[idx] = listdeshis.length;
          }
        });
        if (type.value == "aktif") {
          if (listDataLelangMuatan.isEmpty) {
            istidakadadata.value = true;
          }
        }
        if (type.value == "history") {
          if (listDataLelangMuatanHistory.isEmpty) {
            istidakadadatahistory.value = true;
          }
        }
      }
    }
  }

  void onClearSearch() {
    cari.value.text = "";
    searchValue.value = "";
    listDataLelangMuatan.clear();
    listDataLelangMuatanHistory.clear();
    issort.value = false;
    issortHistory.value = false;
  }

  // void addTextSearch(String value) {
  //   searchValue.value = value;

  //   // if (searchValue.isNotEmpty) {
  //   //   if (type.value == "aktif") {
  //   //     setLastSearch(searchValue.toString());
  //   //   }
  //   //   if (type.value == "history") {
  //   //     setLastSearchHistory(searchValue.toString());
  //   //   }
  //   //   Future.delayed(Duration(seconds: 2), () {
  //   //     getListLelangMuatan(type.value, "10",
  //   //         word: searchValue.toString(), search: 'true');
  //   //   });
  //   // }
  // }

  void addTextSearch(String value) {
    searchValue.value = value;
    listDataLelangMuatan.clear();
    listDataLelangMuatanHistory.clear();
    isLoading.value = true;
    debounce<String>(searchValue, (value) async {
      if (value.isNotEmpty) {
        if (type.value == "aktif") {
          setLastSearch(searchValue.value);
        }
        if (type.value == "history") {
          setLastSearchHistory(searchValue.value);
        }
        getListLelangMuatan(type.value, "10",
            word: searchValue.toString(), search: 'true');
        onTapTextField.value = true;
        if (type.value == "aktif") {
          istidakadadata.value = false;
        }
        if (type.value == "history") {
          istidakadadatahistory.value = false;
        }
      } else {
        onTapTextField.value = false;
        if (type.value == "aktif") {
          istidakadadata.value = false;
        }
        if (type.value == "history") {
          istidakadadatahistory.value = false;
        }

        cari.value.text = "";
        searchValue.value = "";
        listDataLelangMuatan.clear();
        listDataLelangMuatanHistory.clear();
        issort.value = false;
        issortHistory.value = false;
      }
    }, time: 1000.milliseconds);
  }

  void onSubmitSearch() {
    if (searchValue.isNotEmpty) {
      if (type.value == "aktif") {
        setLastSearch(searchValue.toString());
      }
      if (type.value == "history") {
        setLastSearchHistory(searchValue.toString());
      }
      isShowClearSearch.value = searchValue.isNotEmpty;
      listDataLelangMuatan.clear();
      listDataLelangMuatanHistory.clear();
      getListLelangMuatan(type.value, "10",
          word: searchValue.toString(), search: 'true');
    } else {
      listDataLelangMuatan.clear();
      listDataLelangMuatanHistory.clear();
    }
  }

  tutupLelang(String id) async {
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      var resTutupLelang = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .postCloseLelang(
              id, resLoginAs["LoginAs"].toString(), GlobalVariable.role);

      if (resTutupLelang["Message"]["Code"] == 200) {
        CustomToast.show(
            context: Get.context,
            sizeRounded: 6,
            message: 'LelangMuatTabAktifTabAktifLabelTitleCloseBidLelang'.tr);
        getListLelangMuatan(type.value, "10",
            word: searchValue.toString(), search: 'true');
      }
    }
  }

  batalLelang(String id) async {
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      var resTutupLelang = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .postBatalLelang(
              id, resLoginAs["LoginAs"].toString(), GlobalVariable.role);

      if (resTutupLelang["Message"]["Code"] == 200) {
        CustomToast.show(
            context: Get.context,
            sizeRounded: 6,
            message:
                'LelangMuatBuatLelangBuatLelangLabelTitleLelangBerhasilBatal'
                    .tr);
        getListLelangMuatan(type.value, "10",
            word: searchValue.toString(), search: 'true');
      }
    }
  }

  toDetailLelangMuatCari(String idLelang, int page) async {
    var res = await GetToPage.toNamed<ZoDetailLelangMuatanController>(
        Routes.ZO_DETAIL_LELANG_MUATAN,
        preventDuplicates: false,
        arguments: [idLelang, page, type.value]);

    if (res != null) {
      if (res) {
        Get.back(result: true);
        // getListLelangMuatan(word: searchValue.toString(), search: 'true');
      }
    }
  }

  salinData(String idLelang) async {
    var res = await GetToPage.toNamed<ZoBuatLelangMuatanController>(
        Routes.ZO_BUAT_LELANG_MUATAN,
        preventDuplicates: false,
        arguments: [idLelang]);

    if (res != null) {
      // if (res) {
      //   getListLelangMuatan(type);
      // }
    }
  }

  void loadDataSearch() {
    isLoadingTabAktif.value = false;
    if (limitTabAktif.value <= limitAktif.value) {
      limitAktif.value = limitAktif.value;
    } else {
      limitAktif.value += 10;
    }
    if (issort.value) {
      sortAction();
    } else {
      getListLelangMuatan(type.value, limitAktif.value.toString(),
          word: searchValue.toString(), search: 'true');
    }

    isLoadingTabAktif.value = false;
  }

  void refreshDataSmartSearch() {
    // limitAktif.value = 10;
    isLoadingTabAktif.value = false;
    getListLelangMuatan(type.value, limitAktif.value.toString(),
        word: searchValue.toString(), search: 'true');
    isLoadingTabAktif.value = false;
  }

  void loadDataHistorySearch() {
    isLoadingTabHistory.value = false;
    if (limitTabHistory.value <= limitHistory.value) {
      limitHistory.value = limitHistory.value;
    } else {
      limitHistory.value += 10;
    }
    if (issortHistory.value) {
      sortAction();
    } else {
      getListLelangMuatan(type.value, limitHistory.value.toString(),
          word: searchValue.toString(), search: 'true');
    }

    isLoadingTabHistory.value = false;
  }

  void refreshDataSmartHistorySearch() {
    // limitHistory.value = 10;
    isLoadingTabHistory.value = false;
    getListLelangMuatan(type.value, limitHistory.value.toString(),
        word: searchValue.toString(), search: 'true');
    isLoadingTabHistory.value = false;
  }

  toPesertaLelangSearch(String idLelang, String type) async {
    var res = await GetToPage.toNamed<ZoPesertaLelangController>(
        Routes.ZO_PESERTA_LELANG,
        preventDuplicates: false,
        arguments: [idLelang, type]);

    if (res != null) {
      // if (res) {
      //   getListLelangMuatan(type);
      // }
    }
  }

  toPemenangLelang(String idLelang) async {
    Get.toNamed(Routes.ZO_PEMENANG_LELANG + "/$idLelang");
  }
}
