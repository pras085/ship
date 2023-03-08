import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SelectHeadCarrierController extends GetxController {
  var searchBar = TextEditingController();
  var type = "".obs;
  var listData = [].obs;
  var listDataLength = 0.obs;
  var filteredData = [].obs;
  var limit = 6;
  var showButtonSave = false;
  var title = "";

  Timer _timerGetMitraText;
  var filterSearch = "".obs;
  var loading = true.obs;
  var selectedData = 0.obs;
  var selectHead = 0;

  final refreshTransporterController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    selectedData.value = null;
    type.value = Get.arguments[0].toString();
    selectedData.value = Get.arguments[1];
    if (type.value == "1") selectHead = Get.arguments[2];
    // showButtonSave = (Get.arguments[4] ?? 1).toString() == "1";
    if (type.value == "1")
      title =
          "InfoPraTenderCreateLabelCariJenisCarrier".tr; // Cari Jenis Carrier
    else
      title = "InfoPratenderCreateLabelCariJenisTruk".tr; //Cari Jenis Truk
    refreshData(true);
  }

  @override
  void onReady() {
    // refreshTransporterController.requestRefresh();
  }

  @override
  void onClose() {}

  void startTimerGetMitra() {
    stopTimerGetMitra();
    _timerGetMitraText = Timer(Duration(seconds: 2), () async {
      refreshData(false);
    });
  }

  void stopTimerGetMitra() {
    if (_timerGetMitraText != null) _timerGetMitraText.cancel();
  }

  void refreshData(bool refresh) async {
    stopTimerGetMitra();
    loading.value = true;
    if (refresh) await doFilter(0);
    filteredData.value = List.from(listData.value)
        .where((element) => element["Description"]
            .toString()
            .toLowerCase()
            .contains(filterSearch.value.toLowerCase()))
        .toList();
    loading.value = false;
  }

  void loadData() {
    doFilter(listData.length);
  }

  doFilter(int offset) async {
    var resultFilter = (type.value == "0")
        ? await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .listHeadTruck()
        : await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .listCarrierTruckByTruck(
                headID: selectHead == 0 ? null : selectHead.toString());
    // .listCarrierTruck();
    // var newListData = resultFilter["Data"];
    // if (offset == 0) {
    //   listDataLength.value = 0;
    //   refreshTransporterController.resetNoData();
    refreshTransporterController.refreshCompleted();
    //   listData.clear();
    // } else {
    //   refreshTransporterController.loadComplete();
    // }
    // if (newListData.length < limit) {
    refreshTransporterController.loadNoData();
    // }
    listData.value = resultFilter["Data"];
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 1,
        color: Color(ListColor.colorLightGrey5).withOpacity(0.29),
        height: 0,
      ),
    );
  }

  void onClearSearch() {
    searchBar.text = "";
    filterSearch.value = "";
    filteredData.value = List.from(listData).toList();
  }
}
