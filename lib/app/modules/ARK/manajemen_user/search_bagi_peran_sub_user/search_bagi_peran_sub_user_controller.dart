import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SearchBagiPeranSubUserController extends GetxController {
  var jenisTab = "".obs;
  final searchController = TextEditingController().obs;
  var isLoadingData = true.obs;
  var listUser = [].obs;
  var listUserUtama = [].obs;
  var listUserSelected = [].obs;
  var searchOn = false.obs;
  final isShowClearSearch = false.obs;
  Timer time;
  var isChanged = true.obs;
  var listRole = [].obs;

  var kondisiAwal = true;

  var countData = 1.obs;
  var countSearch = 1.obs;

  bool isBF = false;
  bool isTM = false;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN

  var sortBy = ''.obs; //UNTUK SORT BERDASARKAN APA
  var sortType = ''.obs; //UNTUK URUTAN SORTNYA
  Map<String, dynamic> mapSort = {}; //UNTUK URUTAN SORTNYA
  var pencarian = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD

  String sortTag = 'sort';

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  SortingController _sortingController;

  List<DataListSortingModel> sort = [];
  var jumlahDataUser = 0.obs;
  var lastShow = true.obs;

  var listHistorySearch = [].obs;
  var isLoadingLast = false.obs;
  String searchType = "2";
  int quotaUser = 0;
  var usedUser = 0.obs;
  var listSubUserSelected = [].obs;
  var isNext = 0.obs;
  var selectedPeriode = {};

  @override
  void onInit() async {
    super.onInit();
    quotaUser = Get.arguments[0];
    usedUser.value = Get.arguments[1];
    isBF = Get.arguments[2];
    isTM = Get.arguments[3];
    selectedPeriode['StartDate'] = Get.arguments[4];
    selectedPeriode['EndDate'] = Get.arguments[5];
    isNext.value = Get.arguments[6];
    listUserSelected.value = json.decode(json.encode(Get.arguments[7]));
    listUserUtama.value = json.decode(json.encode(Get.arguments[8]));
    print('DIPILIH');
    print(listUserSelected);

    isLoadingLast.value = true;
    await getAllRoleSubUser();
    await getHistorySearch();
    isLoadingData.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onSearch() async {
    kondisiAwal = true;
    lastShow.value = false;
    FocusManager.instance.primaryFocus.unfocus();
    countData.value = 1;
    isLoadingData.value = true;
    listUser.clear();
    if (searchController.value.text != "") {
      searchOn.value = true;
    } else {
      searchOn.value = false;
    }
    await getListUser();
    await saveHistorySearch();
  }

  void onChangeText(String textSearch) {
    isShowClearSearch.value = textSearch != "";
  }

  void onClearSearch() async {
    searchController.value.text = '';
    onChangeText(searchController.value.text);
  }

  void showSortingDialog() {
    FocusManager.instance.primaryFocus.unfocus();
    _sortingController.showSort();
  }

  void _clearSorting() {
    FocusManager.instance.primaryFocus.unfocus();
    _sortingController.clearSorting();
  }

  void reset() async {
    FocusManager.instance.primaryFocus.unfocus();
    _resetSearchSortingFilter();
  }

  void _resetSearchSortingFilter() async {
    //SET ULANG
    pencarian.value = '';
    listUser.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
  }

  Future getHistorySearch() async {
    var isShipper = "1";
    var ID = await SharedPreferencesHelper.getUserShipperID();

    listHistorySearch.clear();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchLatestSearchSubUser(searchType);
    print("ini result");
    print(result);
    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (var x = 0; x < data.length; x++) {
        var json = {
          'idsearch': data[x]['ID'].toString(),
          'search': data[x]['history'].toString(),
        };
        listHistorySearch.add(json);
      }
      listHistorySearch.refresh();
    }

    print('GET HISTORY SEARCH');

    print(listHistorySearch);
    isLoadingLast.value = false;
  }

  void chooseHistorySearch(index) async {
    searchController.value.text = listHistorySearch[index]['search'].toString();
    onSearch();
  }

  Future saveHistorySearch() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .saveLatestSearchSubUser(searchController.value.text ?? "", searchType);
    await getHistorySearch();
    print('HAPUS HISTORY SEARCH');
  }

  void hapusHistorySearch(index) async {
    var idsearch = listHistorySearch[index]['idsearch'];

    listHistorySearch.removeAt(index);

    listHistorySearch.refresh();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .deleteLatestSearchSubUser(idsearch);

    print('HAPUS HISTORY SEARCH');
  }

  void clearHistorySearch() async {
    listHistorySearch.clear();
    listHistorySearch.refresh();

    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .deleteAllLatestSearchSubUser(searchType);

    print('CLEAR HISTORY SEARCH');
  }

  Future getListUser() async {
    String url = "";
    if (isBF) {
      url = "list_assign_sub_user_BF";
    }
    if (isTM) {
      url = "list_assign_sub_user_TM";
    }
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getListAssignSubUser(
            url,
            selectedPeriode['StartDate'],
            selectedPeriode['EndDate'],
            searchController.value.text ?? "",
            isNext.value.toString());

    print(result);
    if (result != null && result['Message']['Code'].toString() == '200') {
      listUser.clear();
      var data = result['Data'][0]['SubUsers_Assign'];
      if (data != null) {
        for (int i = 0; i < data.length; i++) {
          var cek = false;

          for (var z = 0; z < listUserUtama.length; z++) {
            if (data[i]['ID'].toString() == listUserUtama[z]['id'].toString()) {
              cek = true;
              listUser.add({
                "id": listUserUtama[z]['id'],
                "idassign": (listUserUtama[z]['IDAssign'] ?? 0),
                "name": listUserUtama[z]['name'],
                "email": listUserUtama[z]['email'],
                "phone": listUserUtama[z]['phone'],
                "roleid": listUserUtama[z]['roleid'] ?? 0,
                "role": (listUserUtama[z]['roleid'] == 0
                    ? ""
                    : getRoleName(listUserUtama[z]['roleid'])),
                "aktif": listUserUtama[z]['aktif'],
                "ddError": listUserUtama[z]['ddError'],
              });
            }
          }

          if (!cek) {
            listUser.add({
              "id": data[i]['ID'],
              "idassign": (data[i]['IDAssign'] ?? 0),
              "name": data[i]['name'],
              "email": data[i]['email'],
              "phone": data[i]['phone'],
              "roleid": data[i]['Role'] ?? 0,
              "role": (data[i]['Role'] ?? 0) == 0
                  ? ""
                  : getRoleName(data[i]['Role'] ?? 0),
              "aktif": data[i]['IDAssign'] == null ? false : true,
              "ddError": false,
            });
          }
        }
      }
      usedUser.value = listUserSelected.length;

      data = result['Data'][0]['SubUsers_nonAssign'];
      if (data != null) {
        for (int i = 0; i < data.length; i++) {
          var cek = false;

          for (var z = 0; z < listUserUtama.length; z++) {
            if (data[i]['ID'].toString() == listUserUtama[z]['id'].toString()) {
              cek = true;
              listUser.add({
                "id": listUserUtama[z]['id'],
                "idassign": (listUserUtama[z]['IDAssign'] ?? 0),
                "name": listUserUtama[z]['name'],
                "email": listUserUtama[z]['email'],
                "phone": listUserUtama[z]['phone'],
                "roleid": listUserUtama[z]['roleid'] ?? 0,
                "role": (listUserUtama[z]['roleid'] == 0
                    ? ""
                    : getRoleName(listUserUtama[z]['roleid'])),
                "aktif": listUserUtama[z]['aktif'],
                "ddError": listUserUtama[z]['ddError'],
              });
            }
          }

          if (!cek) {
            listUser.add({
              "id": data[i]['ID'],
              "idassign": (data[i]['IDAssign'] ?? 0),
              "name": data[i]['name'],
              "email": data[i]['email'],
              "phone": data[i]['phone'],
              "roleid": data[i]['Role'] ?? 0,
              "role": (data[i]['Role'] ?? 0) == 0
                  ? ""
                  : getRoleName(data[i]['Role'] ?? 0),
              "aktif": data[i]['IDAssign'] == null ? false : true,
              "ddError": false,
            });
          }
        }
      }
      jumlahDataUser.value = listUser.length;
      listUser.refresh();
    } else {
      print("list_assign_sub_user_BF/TM error");
    }

    refreshController.loadComplete();

    getHistorySearch();

    onSetData();

    isLoadingData.value = false;
  }

  Future getAllRoleSubUser() async {
    listRole.clear();
    String url = "";
    if (isBF) {
      url = "1";
    }
    if (isTM) {
      url = "2";
    }
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getAllRoleSubUser(url);

    // print(result);
    if (result != null && result['Message']['Code'].toString() == '200') {
      listRole.value.addAll(result['Data']);
      listRole.refresh();
    } else {
      print("dropdown periode sub user error");
    }
  }

  String getRoleName(int id) {
    String nama = "";
    for (int i = 0; i < listRole.length; i++) {
      if (id.toString() == listRole[i]['ID'].toString()) {
        nama = listRole[i]['name'];
      }
    }
    return nama;
  }

  void onSetData() {
    for (var x = 0; x < listUser.length; x++) {
      if (listUser[x]['aktif']) {
        bool cek = false;
        for (var y = 0; y < listUserSelected.length; y++) {
          if (listUser[x]['id'] == listUserSelected[y]['id']) {
            cek = true;
            listUserSelected[y] = listUser[x];
          }
        }

        if (!cek) {
          listUserSelected.add(listUser[x]);
        }
      } else //Tidak Aktif
      {
        for (var y = 0; y < listUserSelected.length; y++) {
          if (listUser[x]['id'] == listUserSelected[y]['id']) {
            listUserSelected.removeAt(y);
          }
        }
      }
    }

    //SET DI LIST UTAMA
    for (var i = 0; i < listUserSelected.length; i++) {
      for (var j = 0; j < listUserUtama.length; j++) {
        if (listUserSelected[i]['id'] == listUserUtama[j]['id']) {
          listUserUtama[j] = listUserSelected[i];
        }
      }
    }

    listUserSelected.refresh();
    print('TERPILIH');
    print(listUserSelected);
  }

  void removeData(id) {
    print('ID DIHAPUS : ' + id.toString());
    for (var x = 0; x < listUserSelected.length; x++) {
      if (id == listUserSelected[x]['id']) {
        listUserSelected.removeAt(x);
      }
    }
    listUserSelected.refresh();
    print(listUserSelected);
  }
}
