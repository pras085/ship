import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/type_list_info_permintaan_muat_enum.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/create_info_pra_tender/create_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/edit_info_pra_tender/edit_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';

class BrowseInfoPraTenderController extends GetxController {
  var jenisTab = "".obs;
  final searchController = TextEditingController().obs;
  var isLoadingData = true.obs;
  var listInfoPraTender = [].obs;
  var searchOn = false.obs;
  var listHistorySearch = [].obs;
  var lastShow = true.obs;
  final isShowClearSearch = false.obs;

  var countData = 1.obs;
  var countSearch = 1.obs;

  var filter = {}.obs; //UNTUK FILTER PENCARIAN

  var sortBy = ''.obs; //UNTUK SORT BERDASARKAN APA
  var sortType = ''.obs; //UNTUK URUTAN SORTNYA
  Map<String, dynamic> mapSort = {}; //UNTUK URUTAN SORTNYA
  var pencarian = ''.obs; //UNTUK MENCARI BERDASARKAN KEYWORD

  String sortTag = 'browse_sort';

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  SortingController _sortingController;

  List<DataListSortingModel> sort = [];

  var jenisBrowse = "";

  @override
  void onInit() async {
    super.onInit();
    jenisTab.value = Get.arguments[0];
    jenisBrowse = Get.arguments[1];

    await getListPratender(1, jenisTab.value);

    sort = [
      DataListSortingModel(
          'InfoPraTenderIndexLabelNomor'.tr,
          'kode_td',
          'LoadRequestInfoSortingLabelAscending'.tr,
          'LoadRequestInfoSortingLabelDescending'.tr,
          ''.obs),
      DataListSortingModel(
          'InfoPraTenderIndexLabelTanggalDibuat'.tr,
          'Created',
          'LoadRequestInfoSortingLabelOldest'.tr,
          'LoadRequestInfoSortingLabelNewest'.tr,
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

    _sortingController = Get.put(
        SortingController(
            listSort: sort,
            onRefreshData: (map) {
              listInfoPraTender.clear();
              countData.value = 1;
              //SET ULANG
              sortBy.value =
                  map.keys.toString().replaceAll('(', '').replaceAll(')', '');
              sortType.value =
                  map.values.toString().replaceAll('(', '').replaceAll(')', '');

              mapSort = map;
              print('NEW MAPS');
              print(map);
              isLoadingData.value = true;
              getListPratender(1, jenisTab.value);
            }),
        tag: sortTag);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onSearch() async {
    lastShow.value = false;
    FocusManager.instance.primaryFocus.unfocus();
    countData.value = 1;
    isLoadingData.value = true;
    listInfoPraTender.clear();
    if (searchController.value.text != "") {
      searchOn.value = true;
      //setHistorySearch();
    } else {
      searchOn.value = false;
    }
    await getListPratender(1, jenisTab.value);
  }

  // void setHistorySearch() async {
  //   var stringHistorySearch =
  //       await SharedPreferencesHelper.getHistoryBrowseInfoPraTender(
  //               jenisTab.value) ??
  //           "";

  //   var data =
  //       !stringHistorySearch.isEmpty ? jsonDecode(stringHistorySearch) : [];

  //   bool cekSudahAda = false;
  //   int indexSudahAda = 0;
  //   for (var x = 0; x < data.length; x++) {
  //     if (data[x] == searchController.value.text) {
  //       cekSudahAda = true;
  //       indexSudahAda = x;
  //     }
  //   }

  //   //JIKA SUDAH ADA DIHAPUS DULU DARI DATA LAMA, LALU DITARUH DIBAGIAN BELAKANG
  //   if (cekSudahAda) {
  //     data.removeAt(indexSudahAda);
  //     data.add(searchController.value.text);
  //   } else {
  //     // KALAU BELUM ADA TAMBAHKAN BARU
  //     data.add(searchController.value.text);
  //   }

  //   //SET PREFERENCES
  //   SharedPreferencesHelper.setHistoryBrowseInfoPraTender(
  //       jsonEncode(data), jenisTab.value);

  //   print('SET HISTORY SEARCH');
  //   listHistorySearch.value rowse_= data;
  //   listHistorySearch.refresh();
  //   print(listHistorySearch);
  // }

  // void getHistorySearch() async {
  //   var stringHistorySearch =
  //       await SharedPreferencesHelper.getHistoryBrowseInfoPraTender(
  //               jenisTab.value) ??
  //           "";
  //   var data =
  //       !stringHistorySearch.isEmpty ? jsonDecode(stringHistorySearch) : [];

  //   print('GET HISTORY SEARCH');
  //   listHistorySearch.value = data;
  //   listHistorySearch.refresh();
  //   print(listHistorySearch);
  // }

  // void chooseHistorySearch(index) async {
  //   searchController.value.text = listHistorySearch[index].toString();
  //   onSearch();
  // }

  // void hapusHistorySearch(index) async {
  //   listHistorySearch.removeAt(index);
  //   //SET PREFERENCES
  //   SharedPreferencesHelper.setHistoryBrowseInfoPraTender(
  //       jsonEncode(listHistorySearch), jenisTab.value);

  //   print('CLEAR HISTORY SEARCH');
  //   listHistorySearch.refresh();
  // }

  // void clearHistorySearch() async {
  //   listHistorySearch.clear();
  //   //SET PREFERENCES
  //   SharedPreferencesHelper.setHistoryBrowseInfoPraTender(
  //       jsonEncode(listHistorySearch), jenisTab.value);

  //   print('CLEAR HISTORY SEARCH');
  //   listHistorySearch.refresh();
  // }

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
    listInfoPraTender.clear();
    countData.value = 1;
    sortBy.value = '';
    sortType.value = 'DESC';

    isLoadingData.value = true;
    await getListPratender(1, jenisTab.value);
  }

  Future getListPratender(int page, String pageName) async {
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
    } else {
      LangLink = 'InfoPraTenderHistoryGrid';
      RealLink = 'infoPraTenderHistoryGrid';
      history = '1';
    }
    print('SAMPAI SINI');
    print(jenisBrowse);
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListInfoPratender(
            ID,
            '10',
            page.toString(),
            sortBy.value,
            searchController.value.text,
            sortType.value,
            filter,
            pageName,
            LangLink,
            RealLink,
            isShipper,
            history,
            browseUntuk: jenisBrowse);

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      if (data.length == 0 && page > 1) {
        countData.value -= 1;
      }

      (data as List).forEach((element) {
        listInfoPraTender.add({
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

      countSearch.value = result['SupportingData']['RealCountData'];
    }
    refreshController.loadComplete();

    isLoadingData.value = false;
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        color: Color(ListColor.colorLightGrey10),
        thickness: GlobalVariable.ratioWidth(Get.context) * 1,
        height: 0,
      ),
    );
  }
}
