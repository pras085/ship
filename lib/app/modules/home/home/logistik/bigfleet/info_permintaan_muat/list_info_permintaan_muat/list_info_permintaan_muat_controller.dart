import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/filter_controller_custom.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/core/enum/type_list_info_permintaan_muat_enum.dart';
import 'package:muatmuat/app/core/function/api/get_detail_info_permintaan_muat.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/radio_button_filter_model.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/api_permintaan_muat.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/create_permintaan_muat/create_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/detail_permintaan_muat/detail_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/info_permintaan_muat_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/info_permintaan_muat_status_enum.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/list_info_permintaan_muat/list_info_permintaan_muat_response_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/search_info_permintaan_muat/search_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListInfoPermintaanMuatController extends GetxController
    with SingleGetTickerProviderMixin {
  final posTab = 0.obs;
  final isGettingDataPermintaanMuat = false.obs;
  final isAlreadyLoadHistoryFirstTime = false.obs;
  final isAlreadyLoadActiveFirstTime = false.obs;
  final isUsingFilterActive = false.obs;
  final isUsingFilterHistory = false.obs;
  final isUsingSortingActive = false.obs;
  final isUsingSortingHistory = false.obs;
  final listInfoPermintaanMuatActive = [].obs;
  final listInfoPermintaanMuatHistory = [].obs;
  final _listInfoPermintaanMuatActiveTemp = [].obs;
  final _listInfoPermintaanMuatHistoryTemp = [].obs;
  final searchInfoPermintaanMuatValue = "".obs;

  final int tabLength = 2;
  TabController tabController;

  RefreshController activeRefreshController =
      RefreshController(initialRefresh: false);
  RefreshController historyRefreshController =
      RefreshController(initialRefresh: false);

  final TextEditingController searchTextEditingController =
      TextEditingController();

  bool isLoadingDataActive = false;
  bool isLoadingDataHistory = false;
  bool isTabActive = true;
  bool isTabHistory = false;
  bool isSearchMode = false;

  SortingController _sortingActiveController;
  SortingController _sortingHistoryController;

  FilterCustomController _filterCustomActiveController;
  FilterCustomController _filterCustomHistoryController;

  final int _maximumLimit = 10;

  var activeHistorySort = [
    DataListSortingModel(
        "LoadRequestInfoSortingLabelCode".tr,
        "kode_pm",
        "LoadRequestInfoSortingLabelAscending".tr,
        "LoadRequestInfoSortingLabelDescending".tr,
        "".obs),
    DataListSortingModel(
        "LoadRequestInfoSortingLabelCreateDate".tr,
        "tanggal_dibuat",
        "LoadRequestInfoSortingLabelOldest".tr,
        "LoadRequestInfoSortingLabelNewest".tr,
        "".obs,
        isTitleASCFirst: false),
    DataListSortingModel(
        "LoadRequestInfoSortingLabelRoute".tr,
        "rute",
        "LoadRequestInfoSortingLabelAscending".tr,
        "LoadRequestInfoSortingLabelDescending".tr,
        "".obs),
    DataListSortingModel(
        "LoadRequestInfoSortingLabelDeliveryTime".tr,
        "estimasi_muat",
        "LoadRequestInfoSortingLabelAscending".tr,
        "LoadRequestInfoSortingLabelDescending".tr,
        "".obs),
    DataListSortingModel(
        "LoadRequestInfoSortingLabelTypeOfTruckCarrier".tr,
        "nama_truck",
        "LoadRequestInfoSortingLabelAscending".tr,
        "LoadRequestInfoSortingLabelDescending".tr,
        "".obs),
  ];
  List<WidgetFilterModel> listWidgetFilterAktif = [
    WidgetFilterModel(
        label: ["LoadRequestInfoLabelCreateDateFilter".tr],
        typeInFilter: TypeInFilter.DATE,
        keyParam: "doc_date"),
    WidgetFilterModel(
        label: ["LoadRequestInfoLabelSendDateFilter".tr],
        typeInFilter: TypeInFilter.DATE,
        keyParam: "pengiriman_date"),
    WidgetFilterModel(
        label: ["LoadRequestInfoLabelPickUpLocationFilter".tr,
          "GlobalFilterSearchPickupLocation".tr,
          "GlobalFilterPickupLocation".tr,
        ],
        typeInFilter: TypeInFilter.CITY,
        keyParam: "pick_up"),
    WidgetFilterModel(
        label: ["LoadRequestInfoLabelDestinationLocationFilter".tr,
          "GlobalFilterSearchDestinationLocation".tr,
          "GlobalFilterDestinationLocation".tr,
        ],
        typeInFilter: TypeInFilter.CITY,
        keyParam: "destination"),
    WidgetFilterModel(
        label: ["LoadRequestInfoLabelTruckFilter".tr],
        typeInFilter: TypeInFilter.TRUCK,
        keyParam: "jenis_truck"),
    WidgetFilterModel(
        label: ["LoadRequestInfoLabelCarrierFilter".tr],
        typeInFilter: TypeInFilter.CARRIER,
        keyParam: "jenis_carrier"),
  ];
  List<WidgetFilterModel> listWidgetFilterHistory = [];

  Map<String, dynamic> _mapSortActive = {};
  Map<String, dynamic> _mapSortHistory = {};
  Map<String, dynamic> _mapFilterActive = {};
  Map<String, dynamic> _mapFilterHistory = {};

  Timer _timerSearchActive;
  Timer _timerSearchHistory;

  bool _isCompleteBuildWidget = false;

  var lihatRole = false.obs;
  var buatRole = false.obs;
  var exportAktifRole = false.obs;
  var exportHistoryRole = false.obs;
  var exportDetailRole = false.obs;
  var editRole = false.obs;

  @override
  void onInit() async{
    super.onInit();
  }

  Future<void> cekRoleUser() async {
    // Role Lihat Info Permintaan Muat
    lihatRole.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
      context:Get.context, 
      menuId : '611',
      showDialog: false,
    );
    buatRole.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
      context:Get.context, 
      menuId : "440",
      showDialog: false,
    );
    exportAktifRole.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
      context:Get.context, 
      menuId : "441",
      showDialog: false,
    ); 
    exportHistoryRole.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
      context:Get.context, 
      menuId : "442",
      showDialog: false,
    ); 
    editRole.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
      context:Get.context, 
      menuId : "443",
      showDialog: false,
    ); 
    exportDetailRole.value = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(
      context:Get.context, 
      menuId : "604",
      showDialog: false,
    ); 
  }

  void firstInit(){
    listWidgetFilterHistory.addAll(listWidgetFilterAktif);
    listWidgetFilterHistory.add(WidgetFilterModel(
        label: ["LoadRequestInfoLabelStatusFilter".tr],
        typeInFilter: TypeInFilter.RADIO_BUTTON,
        keyParam: "status",
        customValue: [
          RadioButtonFilterModel(id: "2", value: "Cancel"),
          RadioButtonFilterModel(id: "1", value: "Finished")
        ]));
    _filterCustomActiveController = Get.put(
        FilterCustomController(
            returnData: (data) {
              _mapFilterActive.clear();
              _mapFilterActive.addAll(data);
              isUsingFilterActive.value = _mapFilterActive.length > 0;
              getAllInfoPermintaanMuatActiveOnRefresh(
                  isUsingLoadingManual: true, isAddToTemp: false);
            },
            listWidgetInFilter: listWidgetFilterAktif),
        tag: "aktif");
    _filterCustomHistoryController = Get.put(
        FilterCustomController(
            returnData: (data) {
              _mapFilterHistory.clear();
              _mapFilterHistory.addAll(data);
              isUsingFilterHistory.value = _mapFilterHistory.length > 0;
              getAllInfoPermintaanMuatHistoryOnRefresh(
                  isUsingLoadingManual: true, isAddToTemp: false);
            },
            listWidgetInFilter: listWidgetFilterHistory),
        tag: "history");
    tabController = TabController(vsync: this, length: tabLength);
    tabController.addListener(() {
      if (posTab.value != tabController.index) {
        posTab.value = tabController.index;
        if (isSearchMode) {
          onClearSearch();
        }
        _setIsTab(posTab.value);
        if (isTabHistory && !isAlreadyLoadHistoryFirstTime.value) {
          getAllInfoPermintaanMuatHistoryOnRefresh(isUsingLoadingManual: true);
          isAlreadyLoadHistoryFirstTime.value = true;
        }
        if (isTabActive && !isAlreadyLoadActiveFirstTime.value) {
          getAllInfoPermintaanMuatActiveOnRefresh(isUsingLoadingManual: true);
          isAlreadyLoadActiveFirstTime.value = true;
        }
      }
    });

    _sortingActiveController = Get.put(
        SortingController(
            listSort: activeHistorySort,
            onRefreshData: (map) {
              _mapSortActive.clear();
              _mapSortActive.addAll(map);
              isUsingSortingActive.value = _mapSortActive.length > 0;
              getAllInfoPermintaanMuatActiveOnRefresh(
                  isUsingLoadingManual: true);
            }),
        tag: "ListInfoPermintaanMuatAktif");
    _sortingHistoryController = Get.put(
        SortingController(
            listSort: activeHistorySort,
            onRefreshData: (map) {
              _mapSortHistory.clear();
              _mapSortHistory.addAll(map);
              isUsingSortingHistory.value = _mapSortHistory.length > 0;
              getAllInfoPermintaanMuatHistoryOnRefresh(
                  isUsingLoadingManual: true);
            }),
        tag: "ListInfoPermintaanMuatHistori");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onChangeTab(int pos) {
    tabController.animateTo(pos);
  }

  void onChangeSearch(String value) {
    if (value == "") {
      isSearchMode = false;
      isGettingDataPermintaanMuat.value = false;
      _restoreDataFromTemp();
      if (isTabActive) {
        _stopTimerGetInfoPermintaanMuatActive();
      } else {
        _stopTimerGetInfoPermintaanMuatHistory();
      }
    } else {
      isSearchMode = true;
      isGettingDataPermintaanMuat.value = true;
      searchInfoPermintaanMuatValue.value = value;
      if (isTabActive) {
        _startTimerGetInfoPermintaanMuatActive();
      } else {
        _startTimerGetInfoPermintaanMuatHistory();
      }
    }
  }

  void onClearSearch() {
    isSearchMode = false;
    isGettingDataPermintaanMuat.value = false;
    searchTextEditingController.text = "";
    searchInfoPermintaanMuatValue.value = "";
    _restoreDataFromTemp();
    if (isTabActive) {
      _stopTimerGetInfoPermintaanMuatActive();
    } else {
      _stopTimerGetInfoPermintaanMuatHistory();
    }
  }

  void showSortingDialog() {
    if (isTabActive) {
      _sortingActiveController.showSort();
    } else {
      _sortingHistoryController.showSort();
    }
  }

  Future getAllInfoPermintaanMuatActiveOnRefresh(
      {bool isUsingLoadingManual = false, bool isAddToTemp = false}) async {
    if (isAddToTemp && _listInfoPermintaanMuatActiveTemp.length == 0) {
      _listInfoPermintaanMuatActiveTemp.clear();
      _listInfoPermintaanMuatActiveTemp.addAll(listInfoPermintaanMuatActive);
    }
    await _getAllInfoPermintaanMuat(
        pageNow: 1,
        list: listInfoPermintaanMuatActive,
        refreshControllerFunction: () => activeRefreshController,
        clearRefreshController: () {
          activeRefreshController = null;
          activeRefreshController = RefreshController(initialRefresh: false);
        },
        mapSorting: _mapSortActive,
        mapFilter: _mapFilterActive,
        isHistory: false,
        isUsingLoadingManual: isUsingLoadingManual);
  }

  Future getAllInfoPermintaanMuatActiveForTempOnly() async {
    await _getAllInfoPermintaanMuat(
        pageNow: 1,
        list: _listInfoPermintaanMuatActiveTemp,
        refreshControllerFunction: null,
        clearRefreshController: null,
        mapSorting: _mapSortActive,
        mapFilter: _mapFilterActive,
        isHistory: false,
        isUsingLoadingManual: false);
  }

  Future getAllInfoPermintaanMuatActiveOnLoading() async {
    await _getAllInfoPermintaanMuat(
        pageNow:
            ((listInfoPermintaanMuatActive.length / _maximumLimit) + 1).toInt(),
        list: listInfoPermintaanMuatActive,
        refreshControllerFunction: () => activeRefreshController,
        clearRefreshController: () {
          activeRefreshController = null;
          activeRefreshController = RefreshController(initialRefresh: false);
        },
        mapSorting: _mapSortActive,
        mapFilter: _mapFilterActive,
        isHistory: false);
  }

  Future getAllInfoPermintaanMuatHistoryOnRefresh(
      {bool isUsingLoadingManual = false, bool isAddToTemp = false}) async {
    if (isAddToTemp && _listInfoPermintaanMuatHistoryTemp.length == 0) {
      _listInfoPermintaanMuatHistoryTemp.clear();
      _listInfoPermintaanMuatHistoryTemp.addAll(listInfoPermintaanMuatHistory);
    }
    await _getAllInfoPermintaanMuat(
        pageNow: 1,
        list: listInfoPermintaanMuatHistory,
        refreshControllerFunction: () => historyRefreshController,
        clearRefreshController: () {
          historyRefreshController = null;
          historyRefreshController = RefreshController(initialRefresh: false);
        },
        mapSorting: _mapSortHistory,
        mapFilter: _mapFilterHistory,
        isHistory: true,
        isUsingLoadingManual: isUsingLoadingManual);
  }

  Future getAllInfoPermintaanMuatHistoryForTempOnly() async {
    await _getAllInfoPermintaanMuat(
        pageNow: 1,
        list: _listInfoPermintaanMuatHistoryTemp,
        refreshControllerFunction: null,
        clearRefreshController: null,
        mapSorting: _mapSortHistory,
        mapFilter: _mapFilterHistory,
        isHistory: true,
        isUsingLoadingManual: false);
  }

  Future getAllInfoPermintaanMuatHistoryOnLoading() async {
    await _getAllInfoPermintaanMuat(
        pageNow: ((listInfoPermintaanMuatHistory.length / _maximumLimit) + 1)
            .toInt(),
        list: listInfoPermintaanMuatHistory,
        refreshControllerFunction: () => historyRefreshController,
        clearRefreshController: () {
          historyRefreshController = null;
          historyRefreshController = RefreshController(initialRefresh: false);
        },
        mapSorting: _mapSortHistory,
        mapFilter: _mapFilterHistory,
        isHistory: true);
  }

  Future getAllInfoPermintaanMuatSearchOnLoading(
      {@required RxList<dynamic> list,
      @required RefreshController Function() refreshController,
      @required void Function() clearRefreshController,
      @required Map<String, dynamic> mapSorting,
      @required Map<String, dynamic> mapFilter,
      @required String searchValue,
      @required TypeListInfoPermintaanMuat typeListInfoPermintaanMuat}) async {
    await _getAllInfoPermintaanMuat(
      pageNow: ((list.length / _maximumLimit) + 1).toInt(),
      list: list,
      refreshControllerFunction: refreshController,
      clearRefreshController: clearRefreshController,
      mapSorting: mapSorting,
      mapFilter: mapFilter,
      isHistory:
          typeListInfoPermintaanMuat == TypeListInfoPermintaanMuat.HISTORY
              ? true
              : false,
      searchValue: searchValue,
    );
  }

  Future getAllInfoPermintaanMuatSearchOnRefresh(
      {bool isUsingLoadingManual = false,
      @required RxList<dynamic> list,
      @required RefreshController Function() refreshController,
      @required void Function() clearRefreshController,
      @required Map<String, dynamic> mapSorting,
      @required Map<String, dynamic> mapFilter,
      @required String searchValue,
      @required TypeListInfoPermintaanMuat typeListInfoPermintaanMuat}) async {
    await _getAllInfoPermintaanMuat(
        pageNow: 1,
        list: list,
        refreshControllerFunction: refreshController,
        clearRefreshController: clearRefreshController,
        mapSorting: mapSorting,
        mapFilter: mapFilter,
        isHistory:
            typeListInfoPermintaanMuat == TypeListInfoPermintaanMuat.HISTORY
                ? true
                : false,
        searchValue: searchValue,
        isUsingLoadingManual: isUsingLoadingManual);
  }

  Future _getAllInfoPermintaanMuat(
      {@required int pageNow,
      @required RxList<dynamic> list,
      @required RefreshController Function() refreshControllerFunction,
      @required void Function() clearRefreshController,
      @required Map<String, dynamic> mapSorting,
      @required Map<String, dynamic> mapFilter,
      @required bool isHistory = false,
      String searchValue = "",
      bool isUsingLoadingManual = false}) async {
    if (isHistory)
      isLoadingDataHistory = true;
    else
      isLoadingDataActive = true;
    try {
      if (pageNow == 1) {
        list.clear();
        if (isUsingLoadingManual) {
          isGettingDataPermintaanMuat.value = true;
          clearRefreshController();
        }
      }
      var response = await ApiPermintaanMuat(
              context: Get.context, isShowDialogLoading: false)
          .fetchInfoPermintaanMuat(
              isHistory: isHistory,
              limit: _maximumLimit,
              pageNow: pageNow,
              search: searchValue,
              order: mapSorting,
              filter: mapFilter);

      if (response != null) {
        ListInfoPermintaanMuatResponseModel
            listInfoPermintaanMuatResponseModel =
            ListInfoPermintaanMuatResponseModel.fromJson(response);
        list.addAll(listInfoPermintaanMuatResponseModel.listPermintaanMuat);
        if (isHistory)
          isLoadingDataHistory = true;
        else
          isLoadingDataActive = true;
        list.refresh();
        if (refreshControllerFunction != null) {
          if (pageNow == 1) {
            refreshControllerFunction().resetNoData();
            refreshControllerFunction().refreshCompleted();
          } else
            refreshControllerFunction().loadComplete();

          if (listInfoPermintaanMuatResponseModel.listPermintaanMuat.length <
              _maximumLimit) refreshControllerFunction().loadNoData();
        }
      } else {
        if (refreshControllerFunction != null) {
          if (pageNow == 1) {
            refreshControllerFunction().resetNoData();
            refreshControllerFunction().refreshCompleted();
          } else
            refreshControllerFunction().loadComplete();
        }
      }
    } catch (err) {}
    if (isHistory)
      isLoadingDataHistory = false;
    else
      isLoadingDataActive = false;
    isGettingDataPermintaanMuat.value = false;
  }

  void onCompleteBuildWidget() {
    firstInit();

    if (!_isCompleteBuildWidget) {
      _isCompleteBuildWidget = true;
      cekRoleUser();
      getAllInfoPermintaanMuatActiveOnRefresh(
          isUsingLoadingManual: true, isAddToTemp: true);
      isAlreadyLoadActiveFirstTime.value = true;
    }
  }

  void _stopTimerGetInfoPermintaanMuatActive() {
    if (_timerSearchActive != null) _timerSearchActive.cancel();
  }

  void _stopTimerGetInfoPermintaanMuatHistory() {
    if (_timerSearchHistory != null) _timerSearchHistory.cancel();
  }

  void _startTimerGetInfoPermintaanMuatActive() {
    _stopTimerGetInfoPermintaanMuatActive();
    _timerSearchActive = Timer(Duration(seconds: 2), () async {
      await getAllInfoPermintaanMuatActiveOnRefresh(
          isUsingLoadingManual: true, isAddToTemp: true);
    });
  }

  void _startTimerGetInfoPermintaanMuatHistory() {
    _stopTimerGetInfoPermintaanMuatHistory();
    _timerSearchHistory = Timer(Duration(seconds: 2), () async {
      await getAllInfoPermintaanMuatHistoryOnRefresh(
          isUsingLoadingManual: true, isAddToTemp: true);
    });
  }

  void _setIsTab(int pos) {
    isTabActive = pos == 0;
    isTabHistory = pos == 1;
  }

  void _restoreDataFromTemp() {
    if (isTabHistory) {
      listInfoPermintaanMuatHistory.clear();
      listInfoPermintaanMuatHistory.addAll(_listInfoPermintaanMuatHistoryTemp);
      _listInfoPermintaanMuatHistoryTemp.clear();
      listInfoPermintaanMuatHistory.refresh();
      historyRefreshController.resetNoData();
    } else {
      listInfoPermintaanMuatActive.clear();
      listInfoPermintaanMuatActive.addAll(_listInfoPermintaanMuatActiveTemp);
      _listInfoPermintaanMuatActiveTemp.clear();
      listInfoPermintaanMuatActive.refresh();
      activeRefreshController.resetNoData();
    }
  }

  void _clearSortingActive() {
    _sortingActiveController.clearSorting();
  }

  void _clearSortingHistory() {
    _sortingHistoryController.clearSorting();
  }

  void showFilterActive() {
    _filterCustomActiveController.showFilter();
  }

  void showFilterHistory() {
    _filterCustomHistoryController.showFilter();
  }

  void goToSearchPage() async {
    await GetToPage.toNamed<SearchInfoPermintaanMuatController>(
        Routes.SEARCH_INFO_PERMINTAAN_MUAT,
        arguments: {
          SearchInfoPermintaanMuatController.searchValueKey: "",
          SearchInfoPermintaanMuatController.typeListInfoPermintaanMuatKey:
              isTabActive
                  ? TypeListInfoPermintaanMuat.AKTIF
                  : TypeListInfoPermintaanMuat.HISTORY
        });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  Widget listPerItem(int index, InfoPermintaanMuatModel data) {
    double borderRadius = GlobalVariable.ratioWidth(Get.context) * 10;
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
            vertical: GlobalVariable.ratioWidth(Get.context) * 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: GlobalVariable.ratioWidth(Get.context) * 20,
              spreadRadius: 0,
              offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: GlobalVariable.ratioWidth(Get.context) * 66,
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorLightBlue),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius))),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  GestureDetector(
                    onTap: () {
                      goToDetailPermintaanMuat(data.id,
                          data.statusKey == InfoPermintaanMuatStatus.AKTIF);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  data.kode,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) * 2,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              10,
                                      height:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              10,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: GlobalVariable.ratioWidth(Get.context) * 2,
                                              color: Color(ListColor.color4))),
                                    ),
                                    SizedBox(
                                      width:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              8,
                                    ),
                                    Expanded(
                                      child: CustomText(data.firstLocationPickup,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Container(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) * 10,
                                  child: Container(
                                    child: Dash(
                                      direction: Axis.vertical,
                                      dashGap:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              1,
                                      length:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              10,
                                      dashLength:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              3,
                                      dashThickness: GlobalVariable.ratioWidth(Get.context) * 1,
                                      dashBorderRadius: 10,
                                      dashColor: Color(ListColor.color4),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              10,
                                      height:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              10,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(ListColor.color4),
                                          border: Border.all(
                                              width: GlobalVariable.ratioWidth(Get.context) * 2,
                                              color: Color(ListColor.color4))),
                                    ),
                                    SizedBox(
                                      width:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              8,
                                    ),
                                    Expanded(
                                      child: CustomText(data.firstLocationBongkar,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 6),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          CustomText(
                                            data.tanggalDibuat,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor.color4),
                                          ),
                                          CustomText(
                                            data.waktuDibuat,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor.color4),
                                          ),
                                        ]),
                                    SizedBox(
                                      width:
                                          GlobalVariable.ratioWidth(Get.context) *
                                              4,
                                    ),
                                    Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            _showMenuOptionListInfoPermintaanMuat(
                                                data);
                                          },
                                          child: Container(
                                              child: Icon(
                                            Icons.more_vert,
                                            size: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                24,
                                          )),
                                        ))
                                  ]),
                              SizedBox(
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 4,
                              ),
                              data.statusKey == InfoPermintaanMuatStatus.AKTIF
                                  ? SizedBox.shrink()
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              8,
                                          vertical: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              2),
                                      decoration: BoxDecoration(
                                          color: data.statusKey ==
                                                  InfoPermintaanMuatStatus.SELESAI
                                              ? Color(ListColor.colorLightYellow)
                                              : Color(ListColor.colorLightRed2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                      child: CustomText(data.status,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: data.statusKey ==
                                                  InfoPermintaanMuatStatus.SELESAI
                                              ? Color(ListColor.colorYellow2)
                                              : Color(ListColor.colorRed)),
                                    )
                            ]),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Container(
              height: GlobalVariable.ratioWidth(Get.context) * 76,
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _itemDescPermintaanMuat(
                        "assets/number_truck_icon.svg", data.truck),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 14,
                    ),
                    _itemDescPermintaanMuat(
                        "assets/announce_to_icon.svg", data.diumumkanKepada),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 7),
              width: MediaQuery.of(Get.context).size.width,
              height: 0.5,
              color: Color(ListColor.colorLightGrey2),
            ),
            Container(
                height: GlobalVariable.ratioWidth(Get.context) * 42,
                padding:
                    EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius))),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 8,
                      ),
                      Expanded(
                          child: CustomText(
                              "LoadRequestInfoButtonLabelDeliveryTime".tr +
                                  ": " +
                                  data.tanggalEstimasi,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 10,
                              color: Color(ListColor.color4),
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 13,
                      ),
                      Container(
                        height: GlobalVariable.ratioWidth(Get.context) * 28,
                        margin: EdgeInsets.only(
                            right: GlobalVariable.ratioWidth(Get.context) * 8),
                        child: Material(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                          color: Color(ListColor.color4),
                          child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) * 18),
                              ),
                              onTap: () async {
                                goToDetailPermintaanMuat(
                                    data.id,
                                    data.statusKey ==
                                        InfoPermintaanMuatStatus.AKTIF);
                              },
                              child: Container(
                                  width: GlobalVariable.ratioWidth(Get.context) * 82,
                                  height: GlobalVariable.ratioWidth(Get.context) * 28,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: CustomText(
                                        'LoadRequestInfoButtonLabelDetail'.tr,
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }

  void _showMenuOptionListInfoPermintaanMuat(
      InfoPermintaanMuatModel infoPermintaanMuatModel) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20),
                topRight: Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(Get.context).size.width,
            color: Colors.transparent,
            //height: MediaQuery.of(context).size.height - 100,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 4,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 12),
                      alignment: Alignment.center,
                      child: Container(
                          width: GlobalVariable.ratioWidth(Get.context) * 38,
                          height: GlobalVariable.ratioWidth(Get.context) * 3,
                          color: Color(ListColor.colorLightGrey16))),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: CustomText(
                                  "GlobalModalBottomSheetLabelOption".tr,
                                  fontWeight: FontWeight.w700,
                                  color: Color(ListColor.color4),
                                  fontSize: 14)),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.close_rounded,
                                size:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                          ),
                        ],
                      )),
                  isTabActive 
                      ? _itemInfoPermintaanMuatModalBottomSheet(
                          title: "LoadRequestInfoButtonLabelEdit".tr,
                          haveAccess: buatRole.value,
                          onTap: () async {
                            var response =  await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "443");
                            if (!response) return;
                            goToDetailPermintaanMuat(
                                infoPermintaanMuatModel.id, true);
                          })
                      : _itemInfoPermintaanMuatModalBottomSheet(
                        title: "LoadRequestInfoButtonLabelCopyAndCreate".tr,
                        onTap: () {
                          _getDetailPermintaanMuat(
                              infoPermintaanMuatModel.id);
                        }),
                  isTabActive ? _lineSaparator() : SizedBox.shrink(),
                  isTabActive
                      ? _itemInfoPermintaanMuatModalBottomSheet(
                          title: "LoadRequestInfoButtonLabelCopyRequestInfo".tr,
                          onTap: () {
                            _getDetailPermintaanMuat(
                                infoPermintaanMuatModel.id);
                          })
                      : SizedBox.shrink(),
                ]),
          );
        });
  }

  Widget _itemDescPermintaanMuat(String urlIcon, String title) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: GlobalVariable.ratioWidth(Get.context) * 12,
            height: GlobalVariable.ratioWidth(Get.context) * 12,
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              urlIcon,
              color: Color(ListColor.color4),
              width: GlobalVariable.ratioWidth(Get.context) * 12,
              height: GlobalVariable.ratioWidth(Get.context) * 12,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 20),
          Expanded(
              child: CustomText(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey4),
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  Widget _itemInfoPermintaanMuatModalBottomSheet(
      {String title, void Function() onTap, Color textColor = Colors.black, bool haveAccess = true}) {
    return InkWell(
        onTap: () {
          Get.back();
          onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
              vertical: GlobalVariable.ratioWidth(Get.context) * 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title, 
                color: haveAccess ? textColor : Color(ListColor.colorGrey3), 
                fontWeight: FontWeight.w600,
              )
            ],
          ),
        ));
  }

  Widget _lineSaparator() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 14),
        height: 0.5,
        width: MediaQuery.of(Get.context).size.width,
        color: Color(ListColor.colorLightGrey5WithOpacity));
  }

  void _getDetailPermintaanMuat(String permintaanMuatID) async {
    var response =
        await GetDetailInfoPermintaanMuat.getDetail(permintaanMuatID);
    if (response != null) goToCreatePermintaanMuat(arguments: [response.data]);
  }

  void goToCreatePermintaanMuat({dynamic arguments}) async {
    var result = await GetToPage.toNamed<CreatePermintaanMuatController>(
        Routes.CREATE_PERMINTAAN_MUAT,
        arguments: arguments);
    if (result != null) {
      if (result) {
        if (isTabActive)
          getAllInfoPermintaanMuatActiveOnRefresh(
              isUsingLoadingManual: true, isAddToTemp: true);
        else
          isAlreadyLoadActiveFirstTime.value = false;
      }
    }
  }

  void goToDetailPermintaanMuat(
      String permintaanMuatID, bool isEditable) async {
    var result = await GetToPage.toNamed<DetailPermintaanMuatController>(
        Routes.DETAIL_PERMINTAAN_MUAT,
        arguments: [permintaanMuatID, isEditable]);
    if (result != null) {
      if (result) {
        if (isTabActive)
          getAllInfoPermintaanMuatActiveOnRefresh(
              isUsingLoadingManual: true, isAddToTemp: true);
        else
          isAlreadyLoadActiveFirstTime.value = false;
      }
    }
  }
}
