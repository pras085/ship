import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pilih_pemenang_search/ZO_pilih_pemenang_search_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoPilihPemenangLelangController extends GetxController {
  var loginas = "".obs;
  var idlelang = "".obs;
  // var type = "".obs;
  var listPick = [].obs;
  var listDest = [].obs;
  var listDataBid = [].obs;
  var noBid = "".obs;
  var listParticipant = [].obs;
  var isLoading = false.obs;
  var issort = false.obs;
  var idBid = "".obs;
  var truckQty = "".obs;
  var terpilih = "".obs;
  var sisa = "".obs;
  var erorKelebihanInputJumlahTruk = false.obs;

  var pilihPemenangLelangList = [].obs;

  var limitInisial = 0.obs;
  var limitnya = 10.obs;

  var jumlahtruck = TextEditingController().obs;
  final refreshPesertaLelang = RefreshController(initialRefresh: false);

  var sort = Map().obs;

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
  Future<void> onInit() async {
    _sortingController = Get.put(
        SortingController(
            listSort: transporterSort,
            onRefreshData: (map) {
              sort.clear();
              sort.addAll(map);
              refreshData();
            }),
        tag: "SortPilihPemenang");
    idlelang.value = Get.arguments[0];

    isLoading.value = true;
    loginas.value = Get.arguments[1];
    getDataPesertaLelang("", "", "10", "false", "");
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void showSort() {
    _sortingController.showSort();
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

  void sortAction() {
    var multiOrder = "false";
    var order = "";
    var modeorder = "";
    var limit;

    isLoading.value = true;
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

  String converttoIDR(int number) {
    NumberFormat currFormater =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return currFormater.format(number);
  }

  getDataPesertaLelang(String orderby, String ordermode, String limit,
      String multiorder, String q) async {
    isLoading.value = true;

    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListPesertaLelang(idlelang.value, loginas.value, orderby, ordermode,
            limit, multiorder, q);
    listPick.clear();
    listDest.clear();
    listDataBid.clear();
    listParticipant.clear();
    pilihPemenangLelangList.clear();

    if (res["Message"]["Code"] == 200) {
      (res["Data"]["BidLocation"] as List).forEach((valloc) {
        if (valloc["Type"] == "0") {
          listPick.add(valloc);
        }
        if (valloc["Type"] == "1") {
          listDest.add(valloc);
        }
      });
      truckQty.value = res["Data"]["DataInformationBid"]["TruckQty"].toString();
      var terpilihya = (res["Data"]["DataInformationBid"]["TruckQty"] -
          res["Data"]["DataInformationBid"]["RemainingNeeds"]);
      terpilih.value = terpilihya.toString();
      sisa.value =
          res["Data"]["DataInformationBid"]["RemainingNeeds"].toString();
      idBid.value = res["Data"]["DataInformationBid"]["ID"].toString();
      noBid.value = res["Data"]["DataInformationBid"]["BidNo"];
      listDataBid.add(res["Data"]["DataInformationBid"]);

      (res["Data"]["DataParticipant"] as List).forEach((valparticipant) {
        listParticipant.add(valparticipant);
        if (valparticipant["qtyAccepted"] > 0) {
          pilihPemenangLelangList.add({
            "id": valparticipant["ID"].toString(),
            "total": valparticipant["qtyAccepted"].toString()
          });
        }
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

  pilihPemenangLelang(String id, List pemenang) async {
    // isLoading.value = true;
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .postChoseWiner(loginas.value, id, pemenang);

    if (res["Message"]["Code"] == 200) {
      CustomToast.show(
          context: Get.context,
          sizeRounded: 6,
          message:
              "LelangMuatPesertaLelangPesertaLelangLabelTitlePopTelahPilihPemenang"
                  .tr);
    }
  }

  Future<void> searchPesertaLelang() async {
    var result = await GetToPage.toNamed<ZoPilihPemenangSearchController>(
        Routes.ZO_PILIH_PEMENANG_SEARCH,
        arguments: [idlelang.value, loginas.value],
        preventDuplicates: false);
    if (result != null) {
      // getListLelangMuatan(type);
      // tempFilterLokasiDestinasi.value = result;
    }
  }
}
