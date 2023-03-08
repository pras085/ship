import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/filter_controller_custom.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_type_enum.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_manajemen_mitra/search_manajemen_mitra_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultManajemenMitraController extends GetxController {
  ManajemenMitraController manajemenMitraController = Get.find();

  RefreshController refreshSearchController =
      RefreshController(initialRefresh: false);

  ListDataDesignFunction listDataDesignFunctionSearch;

  final listSearchMitra = [].obs;

  final isShowClearSearch = false.obs;
  final isShowLoadingCircular = false.obs;
  final isUsingFilter = false.obs;
  final isUsingSorting = false.obs;
  final isGettingData = false.obs;

  final listHasilPencarianInlineSpan = [].obs;

  final searchTextEditingController = TextEditingController().obs;

  String textSearch = "";

  var _args;

  Timer _timerGetMitraText;

  TypeMitra typeMitraSearchMode;

  SortingController _sortingControllerSearchMitra;

  FilterCustomController _filterCustomController;

  Map<String, dynamic> _mapSortSearch = Map();
  Map<String, dynamic> _mapFilterSearch = {};

  List<DataListSortingModel> _mitraSort;
  var sortColor = Color(ListColor.colorGrey).obs;
  var sortBgColor = Colors.transparent.obs;

  bool _firstTimeBuildWidget = true;

  @override
  void onInit() {
    _args = Get.arguments;
    typeMitraSearchMode =
        _args[SearchManajemenMitraController.typeMitraArgsKey];
    _mitraSort =
        _args[SearchManajemenMitraController.listDataListSortingModelArgsKey];
    if (typeMitraSearchMode == TypeMitra.MITRA)
      listDataDesignFunctionSearch =
          manajemenMitraController.getListDataDesignFunctionMitra(
        resultMitra: (result, index) {
          _returnFromDetailTransporterBasedResult(result);
        },
      );
    else if (typeMitraSearchMode == TypeMitra.APPROVE_MITRA)
      listDataDesignFunctionSearch =
          manajemenMitraController.getListDataDesignFunctionApproveRejectMitra(
              resultMitra: (result, index) {
                _returnFromDetailTransporterBasedResult(result);
              },
              listApproveRejectMitra: listSearchMitra,
              onSuccessApproveReject: () {
                getAllSearchMitraOnRefresh(isUsingLoadingManual: true);
              });
    else if (typeMitraSearchMode == TypeMitra.REQUEST_MITRA)
      listDataDesignFunctionSearch =
          manajemenMitraController.getListDataDesignFunctionRequestCancelMitra(
        resultMitra: (result, index) {
          _returnFromDetailTransporterBasedResult(result);
        },
      );
    _sortingControllerSearchMitra = Get.put(
        SortingController(
            listSort: _mitraSort,
            onRefreshData: (map) {
              _mapSortSearch.clear();
              _mapSortSearch.addAll(map);
              //isUsingSorting.value = _mapSort.length > 0;
              getAllSearchMitraOnRefresh();
            }),
        tag: "SearchMitra");
    _filterCustomController = Get.put(
        FilterCustomController(
            returnData: (data) {
              _mapFilterSearch.clear();
              _mapFilterSearch.addAll(data);
              isUsingFilter.value = _mapFilterSearch.length > 0;
              getAllSearchMitraOnRefresh(isUsingLoadingManual: true);
            },
            listWidgetInFilter: manajemenMitraController.listWidgetFilter),
        tag: "SearchMitra");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    manajemenMitraController.afterFromSearch();
  }

  Future getAllSearchMitra() async {
    isGettingData.value = true;
    await manajemenMitraController.processGetAllSearchMitra(
        onRefresh: false,
        isUsingLoadingManual: false,
        list: listSearchMitra,
        listDataDesignFunction: () => listDataDesignFunctionSearch,
        refreshControllerFunction: () => refreshSearchController,
        clearRefreshController: () {
          refreshSearchController = null;
          refreshSearchController = RefreshController(initialRefresh: false);
        },
        textSearch: textSearch,
        mapSortSearchMitra: _mapSortSearch);
    isGettingData.value = false;
    listSearchMitra.refresh();
    checkSort();
  }
  
  void checkSort() {
    sortColor.value = listSearchMitra.isEmpty ? Color(ListColor.colorGrey) : _mapSortSearch.isEmpty ? Colors.black : Colors.white;
    sortBgColor.value = listSearchMitra.isNotEmpty && _mapSortSearch.isNotEmpty ? Colors.black : Colors.transparent;
  }

  Future getAllSearchMitraOnRefresh({bool isUsingLoadingManual = false}) async {
    isGettingData.value = true;
    isShowLoadingCircular.value = isUsingLoadingManual;
    await manajemenMitraController.processGetAllSearchMitra(
        onRefresh: true,
        isUsingLoadingManual: isUsingLoadingManual,
        list: listSearchMitra,
        listDataDesignFunction: () => listDataDesignFunctionSearch,
        refreshControllerFunction: () => refreshSearchController,
        clearRefreshController: () {
          refreshSearchController = null;
          refreshSearchController = RefreshController(initialRefresh: false);
        },
        textSearch: textSearch,
        mapSortSearchMitra: _mapSortSearch);
    isGettingData.value = false;
    isShowLoadingCircular.value = false;
    listSearchMitra.refresh();
    checkSort();
  }

  Widget listWidget(BuildContext context, int index) {
    if (typeMitraSearchMode == TypeMitra.GROUP_MITRA) {
      return manajemenMitraController.listPerItemGroupMitra(
          index: index,
          totalIndex: 0,
          group: listSearchMitra[index],
          refreshControllerFunction: () => refreshSearchController,
          onSuccessUpdateData: (isRefresh) {
            _returnFromDetailTransporter(isRefresh);
          });
    } else if (typeMitraSearchMode == TypeMitra.MITRA)
      return manajemenMitraController.listPerItemMitra(
          context: context,
          index: index,
          listDataDesignFunction: listDataDesignFunctionSearch);
    else if (typeMitraSearchMode == TypeMitra.APPROVE_MITRA)
      return manajemenMitraController.listPerItemApproveRejectMitra(
          context: context,
          index: index,
          listDataDesignFunction: listDataDesignFunctionSearch,
          listApproveRejectMitra: listSearchMitra,
          onResultFromDetailTransporter: (isRefresh) {
            _returnFromDetailTransporter(isRefresh);
          });
    else if (typeMitraSearchMode == TypeMitra.REQUEST_MITRA)
      return manajemenMitraController.listPerItemRequestCancelMitra(
          context: context,
          index: index,
          listDataDesignFunction: listDataDesignFunctionSearch,
          listRequestCancel: listSearchMitra,
          onSuccessCancelMitra: () {
            getAllSearchMitraOnRefresh(isUsingLoadingManual: true);
          });
  }

  void showSorting() {
    if(listSearchMitra.isNotEmpty || (listSearchMitra.isEmpty && _mapSortSearch.isNotEmpty))
      _sortingControllerSearchMitra.showSort();
  }

  goToSearchPage() async {
    var result =
        await Get.toNamed(Routes.SEARCH_MANAJEMEN_MITRA, arguments: _args);
    if (result != null) {
      _args[SearchManajemenMitraController.searchValueArgsKey] =
          result[SearchManajemenMitraController.searchValueArgsKey];
      _setSearchTextEditingControllerAndTextSearch();
      _setListHasilPencarian();
      getAllSearchMitraOnRefresh(isUsingLoadingManual: true);
    }
  }

  void onCompleteBuildWidget() {
    if (_firstTimeBuildWidget) {
      _setSearchTextEditingControllerAndTextSearch();
      _setListHasilPencarian();
      _firstTimeBuildWidget = false;
      getAllSearchMitraOnRefresh(isUsingLoadingManual: true);
    }
  }

  void _setSearchTextEditingControllerAndTextSearch() {
    textSearch = _args[SearchManajemenMitraController.searchValueArgsKey];
    searchTextEditingController.value.text = textSearch;
  }

  void _setListHasilPencarian() {
    String isiDesc2 = "PartnerManagementLabelResult".tr + " \"";
    listHasilPencarianInlineSpan.clear();
    listHasilPencarianInlineSpan.add(_setTextSpan(isiDesc2, false));
    listHasilPencarianInlineSpan.add(_setTextSpan(textSearch, true));
    listHasilPencarianInlineSpan.add(_setTextSpan("\"", false));
  }

  TextSpan _setTextSpan(String title, bool isBold) {
    return TextSpan(
        text: title,
        style: TextStyle(
            color: isBold ? Colors.black : Color(ListColor.colorDarkBlue2),
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500));
  }

  void showFilter() {
    _filterCustomController.showFilter();
  }

  void _returnFromDetailTransporterBasedResult(var result) {
    manajemenMitraController.checkReturnFromTransporter(result);
    _returnFromDetailTransporter(
        manajemenMitraController.isCheckRefreshFromDetailTransporter(result));
  }

  void _returnFromDetailTransporter(bool isRefresh) {
    Timer(Duration(milliseconds: 300), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    });
    if (isRefresh) getAllSearchMitraOnRefresh(isUsingLoadingManual: true);
  }
}
