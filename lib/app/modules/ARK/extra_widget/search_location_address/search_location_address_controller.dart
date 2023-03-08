import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/contact_partner_info_pra_tender_transporter_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/type_list_info_permintaan_muat_enum.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/search_address_google_function.dart';
import 'package:muatmuat/app/core/models/address_google_info_permintaan_muat_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_autocomplete_model.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/history_search_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class SearchLocationAddressController extends GetxController {
  var jenisTab = "".obs;
  final searchController = TextEditingController().obs;
  var isLoadingData = true.obs;
  var listUser = [].obs;
  var searchOn = false.obs;
  final isShowClearSearch = false.obs;
  Timer time;

  var kondisiAwal = true;

  var countData = 1.obs;
  var countSearch = 1.obs;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN

  var sortBy = ''.obs; //UNTUK SORT BERDASARKAN APA
  var sortType = ''.obs; //UNTUK URUTAN SORTNYA
  Map<String, dynamic> mapSort = {}; //UNTUK URUTAN SORTNYA
  var pencarian = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD
  var selectedAddress = 6.obs;

  String sortTag = 'sort';

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  SortingController _sortingController;

  List<DataListSortingModel> sort = [];
  var jumlahDataUser = 0.obs;
  var lastShow = true.obs;

  var listHistorySearch = [].obs;
  var isLoadingLast = false.obs;
  var hintText = "".obs;
  final isSearchingData = false.obs;
  final listSearchAddress = [].obs;
  SearchAddressGoogleFunction _searchAddressGoogleFunction;
  @override
  void onInit() {
    super.onInit();
    hintText.value = Get.arguments[0];

    // _searchAddressGoogleFunction = SearchAddressGoogleFunction(
    //   context: Get.context,
    //   getResultListAddress: (list) {
    //     isSearchingData.value = false;
    //     listSearchAddress.clear();
    //     for (AddressGooglePlaceAutoCompleteModel data in list) {
    //       listSearchAddress.add(
    //           AddressGoogleInfoPermintaanMuatModel(addressAutoComplete: data));
    //     }
    //     print(listSearchAddress);
    //   },
    //   getResultDetail: (details) {
    //     Get.back(result: {
    //       "ID": listSearchAddress[selectedAddress.value]
    //           .addressAutoComplete
    //           .placeId,
    //       "Text": listSearchAddress[selectedAddress.value]
    //           .addressAutoComplete
    //           .description,
    //       "District": details.districtName,
    //       "City": details.cityName
    //     });
    //   },
    // );
    isLoadingLast.value = true;
    isLoadingData.value = false;
    getHistorySearch();
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
    // await saveHistorySearch();
    // await getListUser(1, jenisTab.value);
  }

  void onChangeText(String textSearch) {
    isShowClearSearch.value = textSearch != "";
    // _searchAddressGoogleFunction.addTextCity(textSearch);
    getListAddress(textSearch);
    lastShow.value = false;
    kondisiAwal = true;
  }

  Future getListAddress(String search) async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getAutoCompleteStreet(search);
    if (result != null && result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      print(data);
      listSearchAddress.clear();
      listSearchAddress.addAll(data);
      listSearchAddress.refresh();
    } else {
      print("List address tidak ada");
    }
  }

  Future getDetailAddress(String placeID, String text) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {
                Get.back();
              },
              child: Center(child: CircularProgressIndicator()));
        });
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDistrictByToken(placeID);
    if (result != null && result['Message']['Code'].toString() == '200') {
      var details = result['Data']['Districts'][0];
      Get.back();
      Get.back(result: {
        "ID": placeID,
        "Text": text,
        "DistrictID": details['DistrictID'],
        "District": details['District'],
        "CityID": details['CityID'],
        "City": details['CityName'],
      });
    } else {
      Get.back();
      print("detail address tidak ada");
    }
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
        .fetchLatestSearchLocation();
    print("ini result");
    print(result);
    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];
      for (var x = 0; x < data.length; x++) {
        var json = {
          'search': data[x]['pencarian'].toString(),
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
    onChangeText(listHistorySearch[index]['search'].toString());
  }

  void chooseAddress(index) async {
    // searchController.value.text = listHistorySearch[index]['search'].toString();
    // onChangeText(listHistorySearch[index]['search'].toString());
    saveHistorySearch(listSearchAddress[index]['title']);
    // _searchAddressGoogleFunction.onClickListAddress(
    //     listSearchAddress[index].addressAutoComplete.placeId);
    getDetailAddress(
        listSearchAddress[index]['id'], listSearchAddress[index]['title']);
    selectedAddress.value = index;
  }

  Future saveHistorySearch(String text) async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .saveLatestSearchLocation(text);
    await getHistorySearch();
    print('Save HISTORY SEARCH');
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
        .deleteAllLatestSearchSubUser("2");

    print('CLEAR HISTORY SEARCH');
  }
}
