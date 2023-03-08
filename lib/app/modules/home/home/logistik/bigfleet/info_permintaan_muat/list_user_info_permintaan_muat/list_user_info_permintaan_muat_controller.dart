import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/api_permintaan_muat.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListUserInfoPermintaanMuatController extends GetxController {
  var loading = true.obs;
  var searchBar = TextEditingController();
  var transporterSearch = "".obs;
  var scrollbarController = ScrollController();

  var listGroup = [].obs;
  var listTransporter = [].obs;

  var listGroupSearch = [].obs;
  var listTransporterSearch = [].obs;

  Timer _timerGetMitraText;
  final refreshTransporterController = RefreshController(initialRefresh: false);

  var selectedJenisMitra = {}.obs;
  var selectedGroup = [].obs;
  var selectedTransporter = [].obs;

  var isExpandJenisMitra = true.obs;
  var isExpandGroup = true.obs;
  var isExpandTransporter = true.obs;
  var showSemua = true.obs;
  var limitTampil = 7;
  var jumlahMitra = 0.obs;

  var totalInvited = 0.obs;
  // var invitedTransporter = {}.obs;
  var errorInvited = [].obs;
  var invitedController = [].obs;

  RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  var limitTransporter = 8;

  @override
  void onInit() async {
  }
  
  void firstInit() async {
    var map = Get.arguments[0];
    selectedJenisMitra.value = map["semua"];
    selectedGroup.value = map["group"];
    selectedTransporter.value = map["transporter"];
    var getInvited = map["invited"] as Map;
    invitedController.clear();
    var index = 0;
    getInvited.forEach((key, value) {
      addInvitedController();
      invitedController[index].text = value;
      index++;
    });
    totalInvited.value = getInvited.length;
    updateJumlahMitra();
    await getList();
    refreshData();
    loading.value = false;
  }

  void onCompleteBuildWidget() {
    firstInit();
  }

  void addInvitedController() {
    invitedController.add(TextEditingController());
  }

  void removeInvitedController(int index) {
    invitedController.removeAt(index);
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    FocusScope.of(Get.context).unfocus();
    FocusManager.instance.primaryFocus.unfocus();
  }

  Future<void> getList() async {
    String shipperID = await SharedPreferencesHelper.getUserShipperID();
    var result = await ApiPermintaanMuat(
            context: Get.context, isShowDialogLoading: false)
        .getListDiumumkan(shipperID);
    listGroup.value = result["Data"]["group"];
    listTransporter.value = result["Data"]["mitra"];
  }

  void startTimerGetMitra() {
    stopTimerGetMitra();
    _timerGetMitraText = Timer(Duration(seconds: 1), () async {
      refreshData();
    });
  }

  void stopTimerGetMitra() {
    if (_timerGetMitraText != null) _timerGetMitraText.cancel();
  }

  void updateJumlahMitra() {
    jumlahMitra.value = (selectedJenisMitra.keys.length) +
        selectedGroup.length +
        selectedTransporter.length;
  }

  void refreshData() {
    listGroupSearch.value = (List.from(listGroup).where((element) =>
        element["Name"]
            .toString()
            .toLowerCase()
            .contains(transporterSearch.value.toLowerCase()))).toList();
    listTransporterSearch.value = (List.from(listTransporter).where((element) =>
        element["name"]
            .toString()
            .toLowerCase()
            .contains(transporterSearch.value.toLowerCase()))).toList();
    showSemua.value = transporterSearch.value.isEmpty;
  }

  void toListUser() async {
    var listInvited = {};
    invitedController.value.forEach((element) {
      if (element.text.isNotEmpty)
        listInvited[invitedController.indexOf(element).toString()] =
            element.text;
    });
    var result = await Get.toNamed(Routes.LIST_USER, arguments: [
      true,
      {
        "semua": Map.from(selectedJenisMitra.value),
        "group": List.from(selectedGroup),
        "transporter": List.from(selectedTransporter),
        "invited": listInvited
      }
    ]);
    if (result != null) {
      selectedJenisMitra.value = result["semua"];
      selectedGroup.value = result["group"];
      selectedTransporter.value = result["transporter"];
      var getInvited = result["invited"] as Map;
      invitedController.clear();
      var index = 0;
      getInvited.forEach((key, value) {
        addInvitedController();
        invitedController[index].text = value;
        index++;
      });
      totalInvited.value = getInvited.length;
      updateJumlahMitra();
    }
  }

  void removeAll() {
    selectedJenisMitra.clear();
    selectedGroup.clear();
    selectedTransporter.clear();
    invitedController.clear();
    totalInvited.value = 0;
    updateJumlahMitra();
  }
}
