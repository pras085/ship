import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/filter_controller_custom.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/enum/type_list_info_permintaan_muat_enum.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/info_permintaan_muat_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/list_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/search_info_permintaan_muat/search_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultInfoPermintaanMuatController extends GetxController {
  final listInfoPermintaanMuatSearch = [].obs;

  final isUsingFilter = false.obs;
  final isUsingSorting = false.obs;
  final isGettingData = false.obs;
  final isLoadingManual = false.obs;

  final searchTextEditingController = TextEditingController().obs;

  final listHasilPencarianInlineSpan = [].obs;

  RefreshController searchRefreshController =
      RefreshController(initialRefresh: false);

  ListInfoPermintaanMuatController _listInfoPermintaanMuatController =
      Get.find();

  String _searchValue = "";

  TypeListInfoPermintaanMuat _typeListInfoPermintaanMuat;

  Map<String, dynamic> _mapFilter = {};
  Map<String, dynamic> _mapSort = {};

  FilterCustomController _filterCustomController;
  SortingController _sortingController;

  bool _firstTimeBuildWidget = true;

  var _arguments;
  @override
  void onInit() {
    _arguments = Get.arguments;
    _searchValue =
        _arguments[SearchInfoPermintaanMuatController.searchValueKey];
    _typeListInfoPermintaanMuat = _arguments[
        SearchInfoPermintaanMuatController.typeListInfoPermintaanMuatKey];
    _filterCustomController = Get.put(
        FilterCustomController(
            returnData: (data) {
              _mapFilter.clear();
              _mapFilter.addAll(data);
              isUsingFilter.value = _mapFilter.length > 0;
              onRefreshSearchInfoPermintaanMuat(isUsingLoadingManual: true);
            },
            listWidgetInFilter: _typeListInfoPermintaanMuat ==
                    TypeListInfoPermintaanMuat.AKTIF
                ? _listInfoPermintaanMuatController.listWidgetFilterAktif
                : _listInfoPermintaanMuatController.listWidgetFilterHistory),
        tag: "searchInfoPermintaanMuat");
    _sortingController = Get.put(
        SortingController(
            listSort: _listInfoPermintaanMuatController.activeHistorySort,
            onRefreshData: (map) {
              _mapSort.clear();
              _mapSort.addAll(map);
              isUsingSorting.value = _mapSort.length > 0;
              onRefreshSearchInfoPermintaanMuat(isUsingLoadingManual: true);
            }),
        tag: "searchInfoPermintaanMuat");
    _setListHasilPencarian();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onCompleteBuildWidget() {
    if (_firstTimeBuildWidget) {
      _firstTimeBuildWidget = false;
      searchTextEditingController.value.text = _searchValue;
      onRefreshSearchInfoPermintaanMuat(isUsingLoadingManual: true);
    }
  }

  Future onRefreshSearchInfoPermintaanMuat(
      {bool isUsingLoadingManual = false}) async {
    isGettingData.value = true;
    isLoadingManual.value = isUsingLoadingManual;
    await _listInfoPermintaanMuatController
        .getAllInfoPermintaanMuatSearchOnRefresh(
            isUsingLoadingManual: isUsingLoadingManual,
            list: listInfoPermintaanMuatSearch,
            refreshController: () => searchRefreshController,
            clearRefreshController: () {
              searchRefreshController = null;
              searchRefreshController =
                  RefreshController(initialRefresh: false);
            },
            mapSorting: _mapSort,
            mapFilter: _mapFilter,
            searchValue: _searchValue,
            typeListInfoPermintaanMuat: _typeListInfoPermintaanMuat);
    isGettingData.value = false;
    isLoadingManual.value = false;
    listInfoPermintaanMuatSearch.refresh();
  }

  void onLoadingSearchInfoPermintaanMuat() async {
    isGettingData.value = true;
    await _listInfoPermintaanMuatController
        .getAllInfoPermintaanMuatSearchOnLoading(
            list: listInfoPermintaanMuatSearch,
            refreshController: () => searchRefreshController,
            clearRefreshController: () {
              searchRefreshController = null;
              searchRefreshController =
                  RefreshController(initialRefresh: false);
            },
            mapSorting: _mapSort,
            mapFilter: _mapFilter,
            searchValue: _searchValue,
            typeListInfoPermintaanMuat: _typeListInfoPermintaanMuat);
    isGettingData.value = false;
    isLoadingManual.value = false;
    listInfoPermintaanMuatSearch.refresh();
  }

  Widget perItem(int index, InfoPermintaanMuatModel data) {
    return _listInfoPermintaanMuatController.listPerItem(index, data);
  }

  void showFilter() {
    _filterCustomController.showFilter();
  }

  void showSorting() {
    _sortingController.showSort();
  }

  void goToSearchPage() async {
    var result = await GetToPage.toNamed<SearchInfoPermintaanMuatController>(
        Routes.SEARCH_INFO_PERMINTAAN_MUAT,
        arguments: _arguments);
    if (result != null) {
      _arguments = result;
      _searchValue =
          _arguments[SearchInfoPermintaanMuatController.searchValueKey];
      _setListHasilPencarian();
      searchTextEditingController.value.text = _searchValue;
      searchTextEditingController.refresh();
      onRefreshSearchInfoPermintaanMuat(isUsingLoadingManual: true);
    }
  }

  void _setListHasilPencarian() {
    String isiDesc2 = "LoadRequestInfoLabelResult".tr + " ";
    listHasilPencarianInlineSpan.clear();
    listHasilPencarianInlineSpan.add(_setTextSpan(isiDesc2, false));
    listHasilPencarianInlineSpan
        .add(_setTextSpan("\"" + _searchValue + "\"", true));
  }

  TextSpan _setTextSpan(String title, bool isBold) {
    return TextSpan(
        text: title,
        style: TextStyle(
            color: isBold ? Colors.black : Color(ListColor.colorDarkBlue2),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
            fontWeight: FontWeight.w600));
  }
}
