import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/shared_preferences_helper_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoPilihPemenangSearchController extends GetxController {
  //kosong
  var idlelang = "".obs;
  var loginas = "".obs;
  // var type = "".obs;
  var searchValue = "".obs;
  var cariList = [].obs;
  final isShowClearSearch = false.obs;
  var istidakadadata = false.obs;
  var onTapTextField = true.obs;
  var listChoosen = [];
  var listChoosenReturn = [].obs;
  var lengthLastSearch = 3.obs;
  var lengthSearch = 0.obs;
  var isLoading = false.obs;
  var idBid = "".obs;
  var sisa = "".obs;

  final refreshPesertaLelang = RefreshController(initialRefresh: false);

  var listPick = [].obs;
  var listDest = [].obs;
  var listDataBid = [].obs;
  var listParticipant = [].obs;

  var lengthPickup = [].obs;
  var lengthDestinasi = [].obs;

  var limitInisial = 0.obs;
  var limitnya = 10.obs;

  var erorKelebihanInputJumlahTruk = false.obs;

  //textediting
  final cari = TextEditingController().obs;
  var jumlahtruck = TextEditingController().obs;

  var sort = Map().obs;
  var issort = false.obs;

  SortingController _sortingController;
  var transporterSort = [
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleNamaTransporter".tr,
        "transporter_name",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleHargaDitawarkan".tr,
        "offer_price",
        "Terendah",
        "Tertinggi",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleJumlahTrukTersedia".tr,
        "truck_offer",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleJumlahTrukDipilih".tr,
        "qty_accepted",
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
        tag: "SortPilihPemenangLelangCari");
    idlelang.value = Get.arguments[0];
    loginas.value = Get.arguments[1];
    // type.value = Get.arguments[2];

    // cari.value.addListener(() {
    //   isLoading.value = true;
    //   if (searchValue.value != cari.value.text) {
    //     searchValue.value = cari.value.text;
    //   }

    //   debounce<String>(searchValue, (value) async {
    //     if (value.isNotEmpty) {
    //       getDataPesertaLelang("", "", "10", "false", searchValue.value);
    //       onTapTextField.value = true;
    //       istidakadadata.value = false;
    //     } else {
    //       onTapTextField.value = false;
    //       istidakadadata.value = false;

    //       cari.value.text = "";
    //       searchValue.value = "";
    //       listParticipant.value = [];
    //       issort.value = false;
    //     }
    //   }, time: 1000.milliseconds);
    // });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  @override
  void dispose() {
    cari.value.dispose();
    super.dispose();
  }

  String converttoIDR(int number) {
    NumberFormat currFormater =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return currFormater.format(number);
  }

  void refreshData() async {
    try {
      isLoading.value = true;
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

  void sortAction() {
    var multiOrder = "false";
    var order = "";
    var modeorder = "";
    var limit;

    // isLoading.value = true;
    if (sort.isNotEmpty) {
      issort.value = true;
      limit = limitnya.value;
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
    getDataPesertaLelang(order, modeorder, limit.toString(), multiOrder, "");
  }

  getDataPesertaLelang(String orderby, String ordermode, String limit,
      String multiorder, String q) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListPesertaLelang(idlelang.value, loginas.value, orderby, ordermode,
            limit, multiorder, q);
    listPick.clear();
    listDest.clear();
    listDataBid.clear();
    listParticipant.value = [];

    if (res["Message"]["Code"] == 200) {
      (res["Data"]["BidLocation"] as List).forEach((valloc) {
        if (valloc["Type"] == "0") {
          listPick.add(valloc);
        }
        if (valloc["Type"] == "1") {
          listDest.add(valloc);
        }
      });
      idBid.value = res["Data"]["DataInformationBid"]["ID"].toString();
      sisa.value =
          res["Data"]["DataInformationBid"]["RemainingNeeds"].toString();
      // noBid.value = res["Data"]["DataInformationBid"]["BidNo"];
      listDataBid.add(res["Data"]["DataInformationBid"]);

      (res["Data"]["DataParticipant"] as List).forEach((valparticipant) {
        listParticipant.add(valparticipant);
      });
      isLoading.value = false;
      refreshPesertaLelang.resetNoData();
      refreshPesertaLelang.refreshCompleted();
      refreshPesertaLelang.loadComplete();
    }
  }

  void loadData() {
    isLoading.value = false;
    if (limitInisial.value <= limitnya.value) {
      limitnya.value = limitnya.value;
    } else {
      limitnya.value += 10;
    }
    if (issort.value) {
      refreshData();
    } else {
      getDataPesertaLelang("", "", limitnya.value.toString(), "false", "");
    }

    isLoading.value = false;
  }

  void refreshDataSmart() {
    // limitAktif.value = 10;
    isLoading.value = false;
    getDataPesertaLelang("", "", limitnya.value.toString(), "false", "");
    isLoading.value = false;
  }

  void onClearSearch() {
    cari.value.text = "";
    searchValue.value = "";
    listParticipant.value = [];
    issort.value = false;
  }

  void addTextSearch(String value) {
    searchValue.value = value;
    isLoading.value = true;
    debounce<String>(searchValue, (value) async {
      if (value.isNotEmpty) {
        getDataPesertaLelang("", "", "10", "false", searchValue.value);
        onTapTextField.value = true;
        istidakadadata.value = false;
      } else {
        onTapTextField.value = false;
        istidakadadata.value = false;

        cari.value.text = "";
        searchValue.value = "";
        listParticipant.value = [];
        issort.value = false;
        isLoading.value = false;
      }
    }, time: 1000.milliseconds);
  }

  void onSubmitSearch() {
    if (searchValue.isNotEmpty) {
      isShowClearSearch.value = searchValue.isNotEmpty;
      listParticipant.value = [];
    } else {
      listParticipant.value = [];
    }
  }

  simpanJmlTruck(String id, List pemenang) async {
    isLoading.value = true;
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .postChoseWiner(loginas.value, id, pemenang);

    if (res["Message"]["Code"] == 200) {
      getDataPesertaLelang("", "", "10", "false", "");
    }
  }
}
