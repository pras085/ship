import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/controllers/contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/core/controllers/filter_controller.dart';
import 'package:muatmuat/app/core/controllers/filter_controller_custom.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/enum/list_data_design_type_button_corner_right_enum.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/core/function/cek_sub_user_dan_hak_akses.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/models/group_mitra_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/mitra_model.dart';
import 'package:muatmuat/app/core/models/transporter_list_design_model.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_approve_reject_response_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_get_count_response_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_request_cancel_response_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_response_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_type_enum.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_manajemen_mitra/search_manajemen_mitra_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/search_result_manajemen_mitra/search_result_manajemen_mitra_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:muatmuat/app/core/function/custom_toast.dart';

class ManajemenMitraController extends GetxController
    with SingleGetTickerProviderMixin {
  final posTab = 0.obs;
  final isMitraTab = true.obs;
  final isRequestApproveTab = false.obs;
  final isGroupMitraTab = false.obs;
  final isGettingDataMitra = false
      .obs; //untuk menampilkan loading sendiri, tidak menggunakan loading dari smartrefresher
  final isLoadingSearchDataMitra = false.obs;
  final isLoadingDataMitra = false.obs;
  final isLoadingDataApproveMitra = false.obs;
  final isLoadingDataRequestMitra = false.obs;
  final isLoadingDataGroupMitra = false.obs;
  final isSearchMitraMode = false.obs;
  final isShowClearSearch = false.obs;
  final isRequestApproveTabApproveView = false.obs;
  final isRequestApproveTabRequestView = false.obs;
  final isUsingFilter = false.obs;
  final isUsingFilterApproveMitra = false.obs;
  final isUsingFilterRequestMitra = false.obs;
  final isUsingFilterSearchMitra = false.obs;
  final isUsingSorting = false.obs;
  final isUsingSortingApproveMitra = false.obs;
  final isUsingSortingRequestMitra = false.obs;
  final isUsingSortingSearchMitra = false.obs;
  final isThereReqFromTransporter = false.obs;

  var sortColor = Color(ListColor.colorGrey).obs;
  var sortBgColor = Colors.transparent.obs;

  final tabMitraValue = "".obs;
  final tabValueMitraValue = "".obs;

  final numberRequest = "0".obs;
  final numberApprove = "0".obs;
  var listGroup = 0.obs;
  var namaListGroup = "PartnerManagementSemuaGrup".tr.obs;
  var invite =  true.obs;
  var adding =  true.obs;
  var seeprofile =  true.obs;
  var acceptance = true.obs;
  var disabled = true.obs;

  var loading = true.obs;

  final searchMitraTextEditingController = TextEditingController().obs;

  var listGroupMitra = List<GroupMitraModel>().obs;

  final listTabMitra = [
    "PartnerManagementTabList".tr,
    "PartnerManagementTabApproveRejectMitra".tr,
    "PartnerManagementTabRequest".tr,
  ].obs;
  final listSubTitleMitra = [
    "",
    "PartnerManagementSubTitleApproveRejectMitra".tr,
    "", //"PartnerManagementSubTitleRequest".tr,
  ].obs;
  final listMitra = [].obs;
  final listMitraSearch = [].obs;
  final listRequestApproveMitraSearch = [].obs;
  final listApproveRejectMitra = [].obs;
  final listRequestCancelMitra = [].obs;

  List<InlineSpan> listUndangRekanBisnisDesc2 = [];

  RefreshController refreshMitraController =
      RefreshController(initialRefresh: false);
  RefreshController refreshApproveRejectMitraController =
      RefreshController(initialRefresh: false);
  RefreshController refreshRequestCancelController =
      RefreshController(initialRefresh: false);
  RefreshController refreshSearchController =
      RefreshController(initialRefresh: false);

  ListDataDesignFunction listDataDesignFunctionMitra;
  ListDataDesignFunction listDataDesignFunctionMitraTemp;
  ListDataDesignFunction listDataDesignFunctionApproveReject;
  ListDataDesignFunction listDataDesignFunctionApproveRejectTemp;
  ListDataDesignFunction listDataDesignFunctionRequestCancel;
  ListDataDesignFunction listDataDesignFunctionRequestCancelTemp;
  ListDataDesignFunction listDataDesignFunctionSearch;

  List<WidgetFilterModel> listWidgetFilter = [
    WidgetFilterModel(
      label: ["GlobalFIlterNumberOfTruck".tr],
      typeInFilter: TypeInFilter.UNIT,
      keyParam: "Qty",
      //customValue: [true],
    ),
    WidgetFilterModel(
        label: ["GlobalFilterYearFounded".tr],
        typeInFilter: TypeInFilter.YEAR,
        keyParam: "Tahun"),
    WidgetFilterModel(
        label: ["PartnerManagementLabelFilterBecomeMitraSince".tr],
        typeInFilter: TypeInFilter.DATE,
        keyParam: "Join"),
    WidgetFilterModel(
        label: [
          "GlobalFilterTransporterLocation".tr,
          "GlobalLabelSearchCityHint".tr,
          "GlobalFilterTransporterLocation".tr
        ],
        typeInFilter: TypeInFilter.CITY,
        keyParam: "TransporterKota"),
    WidgetFilterModel(
        label: [
          "GlobalFilterServiceArea".tr,
          "GlobalFilterSearchServiceArea".tr,
          "GlobalFilterServiceArea".tr
        ],
        typeInFilter: TypeInFilter.CITY,
        keyParam: "AreaLayanan"),
    WidgetFilterModel(label: [
      "GlobalFilterTypeOfTransporter".tr,
      "GlobalFilterGoldenTransporter".tr
    ], typeInFilter: TypeInFilter.SWITCH, keyParam: "Gold")
  ];

  final maxLimitData = 10;

  TabController tabController;

  var listToogle = ["Mitra", "Group"];

  int _posInsideRequstApproveTab = 0;

  Timer _timerGetMitraText;

  bool _isCompleteBuildWidget = false;
  bool _isFirstLoadMitra = false;
  bool _isFirstLoadGroupMitra = false;
  bool _isFirstLoadApproveMitra = false;
  bool _isFirstLoadRequestMitra = false;
  bool _isLoadingMitra = false;
  bool _isLoadingApproveMitra = false;
  bool _isLoadingRequestMitra = false;

  var _shipperID;

  SortingController _sortingControllerMitra;
  SortingController _sortingControllerApproveMitra;
  SortingController _sortingControllerRequestMitra;
  SortingController _sortingControllerGroup;
  SortingController _sortingControllerSearch;
  // SortingController _controllerListRequestMitra;
  // SortingController _controllerList;
  // SortingController _controllerListRequestApproveMitraSearch;
  FilterCustomController _filterControllerMitra;
  FilterCustomController _filtercontrollerApproveMitra;
  FilterCustomController _filtercontrollerRequestMitra;
  FilterCustomController _filtercontrollerSearchMitra;
  // FilterController _controllerFilterRequestMitra;
  // FilterController _controllerFilterApproveMitra;
  // FilterController _controllerFilterRequestApproveMitraSearch;

  ContactPartnerModalSheetBottomController _contactModalBottomSheetController;

  Map<String, dynamic> _mapSort = Map();
  Map<String, dynamic> _mapSortApproveMitra = Map();
  Map<String, dynamic> _mapSortRequestMitra = Map();
  Map<String, dynamic> _mapSortSearchMitra = Map();
  Map<String, dynamic> _mapSortGroup = Map();
  Map<String, dynamic> _mapFilterData = {};
  Map<String, dynamic> _mapFilterDataApproveMitra = {};
  Map<String, dynamic> _mapFilterDataRequestMitra = {};
  Map<String, dynamic> _mapFilterSearchDataMitra = {};

  List<void Function()> _listProcessGetAllMitra = [];
  List<void Function()> _listProcessGetAllApproveMitra = [];
  List<void Function()> _listProcessGetAllRequestMitra = [];

  final Duration _durationTimerProcess = Duration(milliseconds: 10);
  List<DataListSortingModel> mitraSort = [
    DataListSortingModel(
        "GlobalSortingLabelName".tr, "Transporter", "A-Z", "Z-A", "".obs),
    DataListSortingModel("GlobalSortingLabelLocation".tr, "TransporterKota",
        "A-Z", "Z-A", "".obs),
    DataListSortingModel("GlobalSortingLabelYearFounded".tr, "Founded",
        "GlobalSortingLabelOldest".tr, "GlobalSortingLabelLatest".tr, "".obs),
    DataListSortingModel("GlobalSortingLabelQuantityTruck".tr, "QtyTruck",
        "GlobalSortingLabelMost".tr, "GlobalSortingLabelLeast".tr, "".obs),
    // DataListSortingModel(
    //     "GlobalSortingLabelOther".tr, "Lainnya", "A-Z", "Z-A", "".obs),
  ];
  List<DataListSortingModel> groupSort = [
    DataListSortingModel("Nama", "Name", "A-Z", "Z-A", "".obs),
    DataListSortingModel("Anggota", "QtyMitra", "ASC", "DESC", "".obs),
  ];

  final refreshGroupController = RefreshController(initialRefresh: false);
  final limitGroup = 8;
  var groupSearch = "";

  final _keyDialog = new GlobalKey<State>();

  int _idSearchResult = 0;

  TypeMitra _typeMitraSearchMode;

  @override
  void onInit() async {
    await cekInvite();
    await cekAdd();
    await cekSeeProfile();
    await cekAcceptance();
    loading.value = false;
    _setListUndangRekanBisnisDesc2();
    _initListDesign();
    _contactModalBottomSheetController =
        Get.put(ContactPartnerModalSheetBottomController());
    _filterControllerMitra = Get.put(
        FilterCustomController(
            returnData: (map) {
              var getMap = Map<String,dynamic>.from(map);
              if((getMap["Join"] as String).isNotEmpty) {
                var joinDate = (getMap["Join"] as String).split(",");
                var joinString = "";
                joinDate.forEach((element) {
                  joinString += "${joinString.isEmpty ? "" : ","}${DateFormat("yyyy-MM-dd").format(DateFormat('dd-MM-yyyy').parse(element))}";
                });
                getMap[listWidgetFilter[2].keyParam] = joinString;
              }
              Map<String,dynamic> updateMap = getMap.map((key, value) => MapEntry(key.toString(), value));
              _mapFilterData.clear();
              _mapFilterData.addAll(updateMap);
              isUsingFilter.value = _mapFilterData.length > 0;
              _onRefreshFilter();
            },
            listWidgetInFilter: listWidgetFilter),
        tag: "ListMitra");
    _filtercontrollerApproveMitra = Get.put(
        FilterCustomController(
            returnData: (map) {
              _mapFilterDataApproveMitra.clear();
              _mapFilterDataApproveMitra.addAll(map);
              isUsingFilterApproveMitra.value =
                  _mapFilterDataApproveMitra.length > 0;
              _onRefreshFilter();
            },
            listWidgetInFilter: listWidgetFilter),
        tag: "ListMitraApproveMitra");
    _filtercontrollerRequestMitra = Get.put(
        FilterCustomController(
            returnData: (map) {
              _mapFilterDataRequestMitra.clear();
              _mapFilterDataRequestMitra.addAll(map);
              isUsingFilterRequestMitra.value =
                  _mapFilterDataRequestMitra.length > 0;
              _onRefreshFilter();
            },
            listWidgetInFilter: listWidgetFilter),
        tag: "ListMitraRequestMitra");
    _filtercontrollerSearchMitra = Get.put(
        FilterCustomController(
            returnData: (map) {
              _mapFilterSearchDataMitra.clear();
              _mapFilterSearchDataMitra.addAll(map);
              isUsingFilterSearchMitra.value =
                  _mapFilterSearchDataMitra.length > 0;
              _onRefreshFilter();
            },
            listWidgetInFilter: listWidgetFilter),
        tag: "ListMitraRequestMitra");
    _sortingControllerMitra = Get.put(
        SortingController(
            listSort: mitraSort,
            onRefreshData: (map) {
              _mapSort.clear();
              _mapSort.addAll(map);
              isUsingSorting.value = _mapSort.length > 0;
              _onRefreshSorting();
            }),
        tag: "ListMitra");

    _sortingControllerApproveMitra = Get.put(
        SortingController(
            listSort: mitraSort,
            onRefreshData: (map) {
              _mapSortApproveMitra.clear();
              _mapSortApproveMitra.addAll(map);
              isUsingSortingApproveMitra.value =
                  _mapSortApproveMitra.length > 0;
              _onRefreshSorting();
            }),
        tag: "ListApproveMitra");

    _sortingControllerRequestMitra = Get.put(
        SortingController(
            listSort: mitraSort,
            onRefreshData: (map) {
              _mapSortRequestMitra.clear();
              _mapSortRequestMitra.addAll(map);
              isUsingSortingRequestMitra.value =
                  _mapSortRequestMitra.length > 0;
              _onRefreshSorting();
            }),
        tag: "ListRequestMitra");
    _sortingControllerGroup = Get.put(
        SortingController(
            listSort: groupSort,
            onRefreshData: (map) {
              _mapSortGroup.clear();
              _mapSortGroup.addAll(map);
              _onRefreshSorting();
            }),
        tag: "ListGroupMitra");
    tabController = TabController(vsync: this, length: 3);
    tabController.addListener(() {
      if (posTab.value != tabController.index) {
        posTab.value = tabController.index;
        print("tabControlleraddListener");
        _checkChangePageTab();
        checkSort();
      }
    });
    tabMitraValue.value = listTabMitra[0];
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void showFilter() {
    if (isGroupMitraTab.value) {
    } else if (isRequestApproveTab.value) {
      if (isRequestApproveTabApproveView.value) {
        _filtercontrollerApproveMitra.showFilter();
      } else {
        _filtercontrollerRequestMitra.showFilter();
      }
    } else {
      _filterControllerMitra.showFilter();
    }
  }

  // Future<void> getListMitra(int offset) async {
  //   var shipperID = await SharedPreferencesHelper.getUserShipperID();
  //   var response =
  //       await ApiHelper(context: Get.context, isShowDialogLoading: false)
  //           .fetchFilteredMitra(shipperID.toString(), "", Map(), 10, 0);
  // }

   Future<void> cekInvite() async {
          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "607", showDialog: false);
          if (!hasAccess) {
            invite.value = false;
          }
    }

    Future<void> cekAdd() async {
          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "410", showDialog: false);
          if (!hasAccess) {
            adding.value = false;
          }
    }

    Future<void> cekSeeProfile() async {
          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "132", showDialog: false);
          if (!hasAccess) {
            seeprofile.value = false;
          }
    }

    Future<void> cekAcceptance() async {
          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "411", showDialog: false);
          if (!hasAccess) {
            acceptance.value = false;
          }
    }

    Future<void> cekReject() async {
          var hasAccess = await CekSubUserDanHakAkses().cekSubUserDanHakAksesWithShowDialog(context: Get.context, menuId: "413", showDialog: false);
          if (!hasAccess) {
            disabled.value = false;
          }
    }

  void refreshGroupMitra({bool isShowLoadingCircular = false}) {
    getListGroupMitra(0, isShowLoadingCircular: isShowLoadingCircular);
  }

  void loadGroupMitra() {
    getListGroupMitra(listGroupMitra.length);
  }

  Future<void> getListGroupMitra(int offset,
      {bool isShowLoadingCircular = false}) async {
    _getAllMitra(
        offset: offset,
        list: listGroupMitra,
        listDataDesignFunction: () => null,
        refreshControllerFunction: () => refreshGroupController,
        clearRefreshController: () {},
        mapSorting: _mapSortGroup,
        mapFilter: null,
        typeMitra: TypeMitra.GROUP_MITRA,
        isUsingLoadingManual: isShowLoadingCircular);
  }

  void onChangeTab(int pos) {
    tabController.animateTo(pos);
  }

  void _checkChangePageTab() {
    isMitraTab.value = posTab.value == 0;
    isRequestApproveTab.value = posTab.value == 1;
    isGroupMitraTab.value = posTab.value == 2;
    _posInsideRequstApproveTab = -1;
    //_resetAllIncSearchSortingFilter();
    if (isRequestApproveTab.value) {
      if (!isRequestApproveTabApproveView.value &&
          !isRequestApproveTabRequestView.value)
        clickButtonInsideRequestApproveTab(0);
    } else if (isMitraTab.value) {
      if (!_isFirstLoadMitra) {
        _isFirstLoadMitra = true;
        getAllMitraByShipperFirst();
      } else {
        listMitra.refresh();
      }
    } else {
      if (!_isFirstLoadGroupMitra) {
        _isFirstLoadGroupMitra = true;
        getListGroupMitra(0, isShowLoadingCircular: true);
      }
    }
  }

  void _resetAllIncSearchSortingFilter() {
    FocusScope.of(Get.context).unfocus();
    _clearAllSortingFilter();
  }

  void clickButtonInsideRequestApproveTab(int index) {
    if (_posInsideRequstApproveTab != index) {
      _posInsideRequstApproveTab = index;
      if (index == 0) {
        _setViewInsideRequestApproveTab(index);
        if (!_isFirstLoadApproveMitra) {
          _isFirstLoadApproveMitra = true;
          getAllMitraApproveRejectByShipperFirst();
        }
      } else {
        _setViewInsideRequestApproveTab(index);
        if (!_isFirstLoadRequestMitra) {
          _isFirstLoadRequestMitra = true;
          getAllMitraRequestCancelByShipperFirst();
        }
      }
    }
  }

  void _setViewInsideRequestApproveTab(int index) {
    isRequestApproveTabApproveView.value = index == 0;
    isRequestApproveTabRequestView.value = index == 1;
  }

  Future getAllMitraByShipper() async {
    _processGetAllMitraByShipper(onRefresh: false);
  }

  Future getAllMitraByShipperFirst() async {
    await _processGetAllMitraByShipper(
        onRefresh: true, isUsingLoadingManual: true);
  }

  Future getAllMitraByShipperAfterSortFilter(
      {bool isUsingLoadingManual = true}) async {
    _processGetAllMitraByShipper(
        onRefresh: true, isUsingLoadingManual: isUsingLoadingManual);
  }

  Future getAllMitraByShipperOnRefresh() async {
    _processGetAllMitraByShipper(onRefresh: true);
  }

  Future _processGetAllMitraByShipper(
      {@required bool onRefresh, bool isUsingLoadingManual = false}) async {
    _isLoadingMitra = true;
    await _getAllMitra(
        offset: onRefresh ? 0 : listMitra.length,
        list: listMitra,
        listDataDesignFunction: () => listDataDesignFunctionMitra,
        refreshControllerFunction: () => refreshMitraController,
        isUsingLoadingManual: isUsingLoadingManual,
        mapFilter: _mapFilterData,
        mapSorting: _mapSort,
        clearRefreshController: () {
          refreshMitraController = null;
          refreshMitraController = RefreshController(initialRefresh: false);
        },
        typeMitra: TypeMitra.MITRA);
    _isLoadingMitra = false;
  }

  Future getAllMitraApproveRejectByShipperFirst() async {
    _processGetAllApproveRejectMitra(
        onRefresh: true, isUsingLoadingManual: true);
  }

  Future getAllMitraApproveRejectByShipperOnRefresh() async {
    _processGetAllApproveRejectMitra(onRefresh: true);
  }

  Future getAllMitraApproveRejectByShipperAfterSortFilter(
      {bool isUsingLoadingManual = true}) async {
    _processGetAllApproveRejectMitra(
        onRefresh: true, isUsingLoadingManual: isUsingLoadingManual);
  }

  Future getAllMitraApproveRejectByShipper() async {
    _processGetAllApproveRejectMitra(onRefresh: false);
  }

  Future _processGetAllApproveRejectMitra(
      {@required bool onRefresh, bool isUsingLoadingManual = false}) async {
    _isLoadingApproveMitra = true;
    await _getAllMitra(
        offset: onRefresh ? 0 : listApproveRejectMitra.length,
        list: listApproveRejectMitra,
        listDataDesignFunction: () => listDataDesignFunctionApproveReject,
        refreshControllerFunction: () => refreshApproveRejectMitraController,
        isUsingLoadingManual: isUsingLoadingManual,
        mapFilter: _mapFilterDataApproveMitra,
        mapSorting: _mapSortApproveMitra,
        clearRefreshController: () {
          refreshApproveRejectMitraController = null;
          refreshApproveRejectMitraController =
              RefreshController(initialRefresh: false);
        },
        typeMitra: TypeMitra.APPROVE_MITRA);
    _isLoadingApproveMitra = false;
  }

  Future getAllMitraRequestCancelByShipperFirst() async {
    _processGetAllRequestCancelMitra(
        onRefresh: true, isUsingLoadingManual: true);
  }

  Future getAllMitraRequestCancelByShipperOnRefresh() async {
    _processGetAllRequestCancelMitra(onRefresh: true);
  }

  Future getAllMitraRequestCancelByShipperAfterSortFilter(
      {bool isUsingLoadingManual = true}) async {
    _processGetAllRequestCancelMitra(
        onRefresh: true, isUsingLoadingManual: isUsingLoadingManual);
  }

  Future getAllMitraRequestCancelByShipper() async {
    _processGetAllRequestCancelMitra(onRefresh: false);
  }

  Future _processGetAllRequestCancelMitra({
    @required bool onRefresh,
    bool isUsingLoadingManual = false,
  }) async {
    _isLoadingRequestMitra = true;
    await _getAllMitra(
        offset: onRefresh ? 0 : listRequestCancelMitra.length,
        list: listRequestCancelMitra,
        listDataDesignFunction: () => listDataDesignFunctionRequestCancel,
        refreshControllerFunction: () => refreshRequestCancelController,
        isUsingLoadingManual: isUsingLoadingManual,
        mapFilter: _mapFilterDataRequestMitra,
        mapSorting: _mapSortRequestMitra,
        clearRefreshController: () {
          refreshRequestCancelController = null;
          refreshRequestCancelController =
              RefreshController(initialRefresh: false);
        },
        typeMitra: TypeMitra.REQUEST_MITRA);
    _isLoadingRequestMitra = true;
  }

  Future processGetAllSearchMitra({
    @required bool onRefresh,
    bool isUsingLoadingManual = false,
    @required RxList<dynamic> list,
    @required ListDataDesignFunction Function() listDataDesignFunction,
    @required RefreshController Function() refreshControllerFunction,
    @required void Function() clearRefreshController,
    @required String textSearch,
    @required Map<String, dynamic> mapSortSearchMitra,
  }) async {
    await _getAllMitra(
        offset: onRefresh ? 0 : list.length,
        list: list,
        listDataDesignFunction: listDataDesignFunction,
        refreshControllerFunction: refreshControllerFunction,
        isUsingLoadingManual: isUsingLoadingManual,
        mapFilter: _mapFilterSearchDataMitra,
        mapSorting: mapSortSearchMitra,
        clearRefreshController: clearRefreshController,
        typeMitra: _typeMitraSearchMode,
        searchValue: textSearch);
  }

  // listnya
  Future _getAllMitra(
      {@required int offset,
      @required RxList<dynamic> list,
      @required ListDataDesignFunction Function() listDataDesignFunction,
      @required RefreshController Function() refreshControllerFunction,
      @required void Function() clearRefreshController,
      @required Map<String, dynamic> mapSorting,
      @required Map<String, dynamic> mapFilter,
      @required TypeMitra typeMitra,
      bool isUsingLoadingManual = false,
      String searchValue = "",
      int typeGroupMitra}) async {
    if (!isSearchMitraMode.value) {
      if (typeMitra == TypeMitra.GROUP_MITRA) {
        if (isUsingLoadingManual) isLoadingDataGroupMitra.value = true;
      } else if (typeMitra == TypeMitra.APPROVE_MITRA)
        isLoadingDataApproveMitra.value = true;
      else if (typeMitra == TypeMitra.REQUEST_MITRA)
        isLoadingDataRequestMitra.value = true;
      else
        isLoadingDataMitra.value = true;
    }
    try {
      if (offset == 0) {
        list.clear();
        if (isUsingLoadingManual) {
          isGettingDataMitra.value = true;
          clearRefreshController();
        }
        if (listDataDesignFunction() != null)
          listDataDesignFunction().clearList();
      }
      var response;
      if (typeMitra == TypeMitra.GROUP_MITRA) {
        typeGroupMitra =
            typeGroupMitra == null ? listGroup.value : typeGroupMitra;
        response =
            await ApiHelper(context: Get.context, isShowDialogLoading: false)
                .fetchFilteredGroupMitra(
                    _shipperID,
                    searchValue,
                    mapSorting,
                    typeGroupMitra == 0
                        ? null
                        : {"Status": listGroup.value == 1 ? "1" : "0"},
                    limitGroup,
                    offset);
      } else if (typeMitra == TypeMitra.APPROVE_MITRA) {
        response =
            await ApiHelper(context: Get.context, isShowDialogLoading: false)
                .fetchGetDataApproveMitraByShipper(
                    _shipperID, maxLimitData, offset,
                    name: searchValue,
                    order: mapSorting.isEmpty ? null : mapSorting,
                    filter: mapFilter.isEmpty ? null : mapFilter);
      } else if (typeMitra == TypeMitra.REQUEST_MITRA) {
        response =
            await ApiHelper(context: Get.context, isShowDialogLoading: false)
                .fetchGetDataRequestMitraByShipper(
                    _shipperID, maxLimitData, offset,
                    name: searchValue,
                    order: mapSorting.isEmpty ? null : mapSorting,
                    filter: mapFilter.isEmpty ? null : mapFilter);
      } else {
        response =
            await ApiHelper(context: Get.context, isShowDialogLoading: false)
                .fetchGetDataMitraByShipper(_shipperID, maxLimitData, offset,
                    name: searchValue,
                    order: mapSorting.isEmpty ? null : mapSorting,
                    filter: mapFilter.isEmpty ? null : mapFilter);
      }

      if (response != null) {
        if (typeMitra == TypeMitra.GROUP_MITRA) {
          List<dynamic> getListGroup = response["Data"];
          if (offset == 0) list.clear();
          getListGroup.forEach((element) {
            list.add(GroupMitraModel.fromJson(element));
          });
          if (isLoadingDataGroupMitra.value)
            isLoadingDataGroupMitra.value = false;
          if (offset == 0) {
            refreshControllerFunction().resetNoData();
            refreshControllerFunction().refreshCompleted();
          } else {
            refreshControllerFunction().loadComplete();
          }
          if (getListGroup.length < limitGroup) {
            refreshControllerFunction().loadNoData();
          }
        } else {
          ManajemenMitraResponseModel manajemenMitraResponseModel =
              ManajemenMitraResponseModel.fromJson(response);
          List<TransporterListDesignModel> listTransporter =
              manajemenMitraResponseModel.listMitra
                  .map((e) => TransporterListDesignModel(
                      userID: e.docID,
                      transporterID: e.id,
                      transporterName: e.name,
                      avatar: e.avatar,
                      address: e.address,
                      city: e.city,
                      serviceArea: e.areaLayanan,
                      yearFounded: e.yearFounded,
                      numberTruck: e.qtyTruck,
                      isGoldTransporter: e.isGold,
                      joinDate: e.joinDate))
                  .toList();
          if (typeMitra == TypeMitra.APPROVE_MITRA) {
            numberApprove.value = manajemenMitraResponseModel.realCountData;
            _checkThereReqFromTransporter();
          } else if (typeMitra == TypeMitra.REQUEST_MITRA)
            numberRequest.value = manajemenMitraResponseModel.realCountData;
          listDataDesignFunction().addDataList(listTransporter);
          list.addAll(manajemenMitraResponseModel.listMitra);
          list.refresh();
          _setIsLoading(typeMitra, false);
          if (refreshControllerFunction != null) {
            if (offset == 0) {
              refreshControllerFunction().resetNoData();
              refreshControllerFunction().refreshCompleted();
            } else
              refreshControllerFunction().loadComplete();

            if (manajemenMitraResponseModel.listMitra.length < maxLimitData)
              refreshControllerFunction().loadNoData();
          }
        }
      } else {
        _setIsLoading(typeMitra, false);
        if (refreshControllerFunction != null) {
          if (offset == 0) {
            refreshControllerFunction().resetNoData();
            refreshControllerFunction().refreshCompleted();
          } else
            refreshControllerFunction().loadComplete();
        }
      }
    } catch (err) {
      print(err);
    }
    checkSort();
    isGettingDataMitra.value = false;
  }

  void _setIsLoading(TypeMitra typeMitra, bool value) {
    if (typeMitra == TypeMitra.GROUP_MITRA)
      isLoadingDataGroupMitra.value = false;
    if (typeMitra == TypeMitra.APPROVE_MITRA)
      isLoadingDataApproveMitra.value = value;
    else if (typeMitra == TypeMitra.REQUEST_MITRA)
      isLoadingDataRequestMitra.value = value;
    else
      isLoadingDataMitra.value = value;
  }

  Future _getCountApproveRequest() async {
    try {
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: false)
              .fetchGetCountReqMitra(_shipperID);
      if (response != null) {
        ManajemenMitraGetCountResponseModel
            manajemenMitraGetCountResponseModel =
            ManajemenMitraGetCountResponseModel.fromJson(response);
        numberApprove.value = manajemenMitraGetCountResponseModel.numberApprove;
        _checkThereReqFromTransporter();
        numberRequest.value = manajemenMitraGetCountResponseModel.numberRequest;
      }
    } catch (err) {}
    checkSort();
    isGettingDataMitra.value = false;
  }

  void dialogSetApproveRejectMitra(MitraModel mitraModel, bool isApprove,
      {void Function() onSuccessApproveReject}) async {
    GlobalAlertDialog.showAlertDialogCustom(
        title: isApprove
            ? "PartnerManagementDialogAcceptReqTitle".tr
            : "PartnerManagementDialogRejectReqTitle".tr,
        customMessage: Container(
          margin: EdgeInsets.only(
              bottom: GlobalVariable.ratioWidth(Get.context) * 20),
          child: GlobalAlertDialog.getTextRichtWidget(
              isApprove
                  ? "PartnerManagementDialogApproveReqDesc".tr
                  : "PartnerManagementDialogRejectReqDesc".tr,
              ":NAMA_TRANSPORTER",
              mitraModel.name),
        ),
        context: Get.context,
        onTapPriority1: () {},
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority2: () {
          _setApproveRejectMitra(mitraModel, isApprove,
              onSuccessApproveReject: onSuccessApproveReject);
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        positionColorPrimaryButton: isApprove
            ? PositionColorPrimaryButton.PRIORITY2
            : PositionColorPrimaryButton.PRIORITY1);
  }

  Future _setApproveRejectMitra(MitraModel mitraModel, bool isApprove,
      {void Function() onSuccessApproveReject}) async {
    try {
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .fetchSetDataApproveRejectMitraByShipper(
                  mitraModel.docID, isApprove ? "1" : "-1");
      if (response != null) {
        ManajemenMitraApproveRejectResponseModel
            manajemenMitraApproveRejectResponseModel =
            ManajemenMitraApproveRejectResponseModel.fromJson(response);
        if (onSuccessApproveReject != null) {
          _checkAfterUpdateDataIfSearchMitraMode();
          onSuccessApproveReject();
        } else
          getAllMitraApproveRejectByShipperFirst();
        if (isApprove) _isFirstLoadMitra = false;
        CustomToast.show(
            context: Get.context,
            message: mitraModel.name +
                " " +
                (isApprove
                    ? "PartnerManagementSuccessApproveMitra".tr
                    : "PartnerManagementSuccessRejectMitra".tr));
      }
    } catch (err) {}
    checkSort();
  }

  void _checkAfterUpdateDataIfSearchMitraMode() {
    if (isSearchMitraMode.value) {
      if (isRequestApproveTab.value) {
        if (isRequestApproveTabApproveView.value) {
          _isFirstLoadApproveMitra = false;
        } else {
          _isFirstLoadRequestMitra = false;
        }
      } else if (isGroupMitraTab.value)
        _isFirstLoadGroupMitra = false;
      else {
        _isFirstLoadMitra = false;
      }
    }
  }

  void dialogSetCancelMitra(MitraModel mitraModel,
      {void Function() onSuccessCancelMitra}) async {
    GlobalAlertDialog.showAlertDialogCustom(
        title: "GlobalDialogCancelReqPartnerTitle".tr,
        customMessage: Container(
          width: GlobalVariable.ratioWidth(Get.context) * 221,
          margin: EdgeInsets.only(
              bottom: GlobalVariable.ratioWidth(Get.context) * 20),
          child: GlobalAlertDialog.getTextRichtWidget(
              "GlobalDialogCancelReqPartnerDesc".tr,
              ":NAMA_TRANSPORTER",
              mitraModel.name),
        ),
        context: Get.context,
        onTapPriority1: () {},
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority2: () {
          _setCancelMitra(mitraModel,
              onSuccessCancelMitra: onSuccessCancelMitra);
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }

  Future _setCancelMitra(MitraModel mitraModel,
      {void Function() onSuccessCancelMitra}) async {
    try {
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: true)
              .fetchSetDataRequestCancelMitraByShipper(mitraModel.docID);
      if (response != null) {
        ManajemenMitraRequestCancelResponseModel
            manajemenMitraRequestCancelResponseModel =
            ManajemenMitraRequestCancelResponseModel.fromJson(response);
        CustomToast.show(
            context: Get.context,
            message: mitraModel.name +
                " " +
                "PartnerManagementSuccessCancelRequestMitra".tr);
        getAllMitraRequestCancelByShipperFirst();
      }
    } catch (err) {}
    checkSort();
  }

  void updateStatusGroup(String groupID, String status,
      {void Function(bool) onSuccessUpdateStatusGroup}) async {
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: true)
            .fetchSetGroupMitraStatus(groupID, status);
    var message = MessageFromUrlModel.fromJson(response['Message']);
    if (message.code == 200) {
      if (status == "0")
        CustomToast.show(
            context: Get.context,
            message: "PartnerManagementHasBeenDeactivate".tr);
      else
        CustomToast.show(
            context: Get.context,
            message: "PartnerManagemenHasBeenActivate".tr);
      if (onSuccessUpdateStatusGroup != null) {
        _isFirstLoadGroupMitra = false;
        onSuccessUpdateStatusGroup(true);
      } else
        refreshGroupController.requestRefresh();
    } else {
      GlobalAlertDialog.showDialogError(
          message: response["Data"]["Message"], context: Get.context);
    }
    checkSort();
  }

  void removeGroup(String groupID,
      {void Function(bool) onSuccessRemoveGroup}) async {
    GlobalAlertDialog.showAlertDialogCustom(
        title: "PartnerManagementLabelTitleRemoveGroup".tr,
        message: "PartnerManagementRemoveGroupQuestion".tr,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton,
        onTapPriority2: () async {
          var response =
              await ApiHelper(context: Get.context, isShowDialogLoading: true)
                  .fetchDeleteGroupMitra(groupID);
          var message = MessageFromUrlModel.fromJson(response['Message']);
          if (message.code == 200) {
            CustomToast.show(
                context: Get.context,
                message: "PartnerManagementGroupHasBeenRemoved".tr);
            if (onSuccessRemoveGroup != null) {
              _isFirstLoadGroupMitra = false;
              onSuccessRemoveGroup(true);
            } else
              refreshGroupController.requestRefresh();
          } else {
            GlobalAlertDialog.showDialogError(
                message: response["Data"]["Message"], context: Get.context);
          }
        });
        checkSort();
  }

  Future<List<MitraModel>> getListMitraOnGroup(String groupID) async {
    var response =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .fetchListPartnerInGroup(groupID);
    List<dynamic> getListMitra = response["Data"];
    var listMitra = List<MitraModel>();
    getListMitra.forEach((element) {
      listMitra.add(MitraModel.fromJson(element));
    });
    checkSort();
    return listMitra;
  }

  void optionGroupMitra(GroupMitraModel group,
      {void Function(bool) onSuccessUpdateData}) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 4,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 17),
                    child: Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: GlobalVariable.ratioWidth(Get.context) * 3,
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey16),
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 4))),
                    )),
                Container(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 12,
                        right: GlobalVariable.ratioWidth(Get.context) * 12,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: CustomText("PartnerManagementOpsi".tr,
                                  fontWeight: FontWeight.w700,
                                  color: Color(ListColor.color4),
                                  fontSize: 14),
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: GlobalVariable.ratioWidth(Get.context) * 8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  child: SvgPicture.asset(
                                "assets/ic_close1,5.svg",
                                color: Color(ListColor.colorBlack),
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 15,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 15,
                              )),
                            ),
                          ),
                        ),
                      ],
                    )),
                _button(
                    height: 41,
                    paddingLeft: 16,
                    text: "PartnerManagementLabelEditGroup".tr,
                    color: Color(ListColor.colorBlack),
                    onTap: () async {
                      Get.back();
                      var listMitra = await getListMitraOnGroup(group.id);
                      var result = await Get.toNamed(Routes.EDIT_GROUP_MITRA,
                          arguments: [listMitra, group]);
                      if (result != null && result is GroupMitraModel) {
                        if (onSuccessUpdateData != null) {
                          _isFirstLoadGroupMitra = false;
                          onSuccessUpdateData(true);
                        } else {
                          refreshGroupController.requestRefresh();
                          _onRefreshSorting();
                        }
                        CustomToast.show(
                            context: Get.context,
                            message: "PartnerManagementGroupHasBeenUpdated".tr);
                      } else if (onSuccessUpdateData != null) {
                        onSuccessUpdateData(false);
                      }
                    }),
                _lineSaparator(),
                _button(
                    height: 41,
                    paddingLeft: 16,
                    text: group.status
                        ? "PartnerManagementDeactivateGroup".tr
                        : "PartnerManagementActivateGroup".tr,
                    color: Color(ListColor.colorBlack),
                    onTap: () {
                      Get.back();
                      if (group.status) {
                        updateStatusGroup(group.id, "0",
                            onSuccessUpdateStatusGroup: onSuccessUpdateData);
                      } else {
                        updateStatusGroup(group.id, "1",
                            onSuccessUpdateStatusGroup: onSuccessUpdateData);
                      }
                    }),
                _lineSaparator(),
                _button(
                  height: 41,
                  paddingLeft: 16,
                  text: "PartnerManagementDeleteGroup".tr,
                  color: Color(ListColor.colorBlack),
                  onTap: !group.isDelete
                      ? null
                      : () {
                          Get.back();
                          removeGroup(group.id,
                              onSuccessRemoveGroup: onSuccessUpdateData);
                        },
                ),
              ],
            ),
          );
        });
  }

  void optionActiveGroupMitra() {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 4,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 17),
                    child: Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: GlobalVariable.ratioWidth(Get.context) * 3,
                      decoration: BoxDecoration(
                          color: Color(ListColor.colorLightGrey16),
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 4))),
                    )),
                Container(
                  padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 12,
                      right: GlobalVariable.ratioWidth(Get.context) * 12,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: CustomText("Status",
                              fontWeight: FontWeight.w700,
                              color: Color(ListColor.color4),
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                child: SvgPicture.asset(
                              "assets/ic_close1,5.svg",
                              color: Color(ListColor.colorBlack),
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 15,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 15,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _button(
                  height: 41,
                  paddingLeft: 16,
                  text: "PartnerManagementSemuaGrup".tr,
                  color: Color(ListColor.colorBlack),
                  onTap: () {
                    Get.back();
                    listGroup.value = 0;
                    namaListGroup.value = "PartnerManagementSemuaGrup".tr;
                    refreshGroupController.requestRefresh();
                  },
                ),
                _lineSaparator(),
                _button(
                  height: 41,
                  paddingLeft: 16,
                  text: "PartnerManagementAktifGrup".tr,
                  color: Color(ListColor.colorBlack),
                  onTap: () {
                    Get.back();
                    listGroup.value = 1;
                    namaListGroup.value = "PartnerManagementAktifGrup".tr;
                    refreshGroupController.requestRefresh();
                  },
                ),
                _lineSaparator(),
                _button(
                  height: 41,
                  paddingLeft: 16,
                  text: "PartnerManagementTidakAktifGrup".tr,
                  color: Color(ListColor.colorBlack),
                  onTap: () {
                    Get.back();
                    listGroup.value = 2;
                    namaListGroup.value = "PartnerManagementTidakAktifGrup".tr;
                    refreshGroupController.requestRefresh();
                  },
                ),
              ],
            ),
          );
        });
  }

  onCompleteBuildWidget() async {
    if (!_isCompleteBuildWidget) {
      _shipperID = await SharedPreferencesHelper.getUserShipperID();
      // _shipperID = "72";
      _isCompleteBuildWidget = true;
      _getCountApproveRequest();

      if (!_isFirstLoadMitra) {
        _isFirstLoadMitra = true;
        getAllMitraByShipperFirst();
      }
      //getAllMitra(0);
    }
  }

  void checkSort() {
    if (isGroupMitraTab.value) {
        sortColor.value = listGroupMitra.isEmpty ? Color(ListColor.colorGrey) : _mapSortGroup.isEmpty ? Colors.white : Color(ListColor.color4);
        sortBgColor.value = listGroupMitra.isNotEmpty && _mapSortGroup.isNotEmpty ? Colors.white : Colors.transparent;
    } else if (isRequestApproveTab.value) {
      if (isRequestApproveTabApproveView.value) {
        sortColor.value = listApproveRejectMitra.isEmpty ? Color(ListColor.colorGrey) : _mapSortApproveMitra.isEmpty ? Colors.white : Color(ListColor.color4);
        sortBgColor.value = listApproveRejectMitra.isNotEmpty && _mapSortApproveMitra.isNotEmpty ? Colors.white : Colors.transparent;
      } else {
        sortColor.value = listRequestCancelMitra.isEmpty ? Color(ListColor.colorGrey) : _mapSortRequestMitra.isEmpty ? Colors.white : Color(ListColor.color4);
        sortBgColor.value = listRequestCancelMitra.isNotEmpty && _mapSortRequestMitra.isNotEmpty ? Colors.white : Colors.transparent;
      }
    } else {
        sortColor.value = listMitra.isEmpty ? Color(ListColor.colorGrey) : _mapSort.isEmpty ? Colors.white : Color(ListColor.color4);
        sortBgColor.value = listMitra.isNotEmpty && _mapSort.isNotEmpty ? Colors.white : Colors.transparent;
    }
  }

  void showSortingDialog() async {
    if (isGroupMitraTab.value) {
      if(listGroupMitra.isNotEmpty || (listGroupMitra.isEmpty && _mapSortGroup.isNotEmpty))
        _sortingControllerGroup.showSort();
    } else if (isRequestApproveTab.value) {
      if (isRequestApproveTabApproveView.value) {
        if(listApproveRejectMitra.isNotEmpty || (listApproveRejectMitra.isEmpty && _mapSortApproveMitra.isNotEmpty))
        _sortingControllerApproveMitra.showSort();  
      } else {
        if(listRequestCancelMitra.isNotEmpty || (listRequestCancelMitra.isEmpty && _mapSortRequestMitra.isNotEmpty))
          _sortingControllerRequestMitra.showSort();
      }
    } else {
      if(listMitra.isNotEmpty || (listMitra.isEmpty && _mapSort.isNotEmpty))
        _sortingControllerMitra.showSort();
    }
  }

  void _onRefreshSorting() {
    if (isGroupMitraTab.value) {
      refreshGroupController.requestRefresh();
    } else if (isRequestApproveTab.value) {
      if (isRequestApproveTabApproveView.value) {
        getAllMitraApproveRejectByShipperAfterSortFilter(
            isUsingLoadingManual: true);
      } else {
        getAllMitraRequestCancelByShipperAfterSortFilter(
            isUsingLoadingManual: true);
      }
    } else {
      getAllMitraByShipperAfterSortFilter(isUsingLoadingManual: true);
    }
  }

  void _onRefreshFilter() {
    if (isGroupMitraTab.value) {
    } else if (isRequestApproveTab.value) {
      if (isRequestApproveTabApproveView.value) {
        getAllMitraApproveRejectByShipperAfterSortFilter(
            isUsingLoadingManual: true);
      } else {
        getAllMitraRequestCancelByShipperAfterSortFilter(
            isUsingLoadingManual: true);
      }
    } else {
      getAllMitraByShipperAfterSortFilter(isUsingLoadingManual: true);
    }
  }

  void _clearAllSortingFilter() {
    _sortingControllerApproveMitra.clearSorting();
    _sortingControllerRequestMitra.clearSorting();
    _sortingControllerMitra.clearSorting();
    _mapSort.clear();
    _mapSortApproveMitra.clear();
    _mapSortRequestMitra.clear();
    _filterControllerMitra.clearFilter();
    _filtercontrollerApproveMitra.clearFilter();
    _filtercontrollerRequestMitra.clearFilter();
    _mapFilterData.clear();
    _mapFilterDataApproveMitra.clear();
    _mapFilterDataRequestMitra.clear();
    isUsingFilter.value = false;
    isUsingFilterApproveMitra.value = false;
    isUsingFilterRequestMitra.value = false;
    isUsingSorting.value = false;
    isUsingSortingApproveMitra.value = false;
    isUsingSortingRequestMitra.value = false;
  }

  _addListProcessMitra(void Function() function) {
    _listProcessGetAllMitra.add(function);
  }

  _addListProcessApproveMitra(void Function() function) {
    _listProcessGetAllApproveMitra.add(function);
  }

  _addListProcessRequestMitra(void Function() function) {
    _listProcessGetAllRequestMitra.add(function);
  }

  void _initListDesign() {
    void Function(dynamic result, int index) _resultMitra = (result, index) {
      checkReturnFromTransporter(result);
    };
    void Function(dynamic result, int index) _resultApproveMitra =
        (result, index) {
      checkReturnFromTransporter(result);
    };
    void Function(dynamic result, int index) _resultRequestMitra =
        (result, index) {
      checkReturnFromTransporter(result);
    };
    listDataDesignFunctionMitra =
        getListDataDesignFunctionMitra(resultMitra: _resultMitra);
    listDataDesignFunctionApproveReject =
        getListDataDesignFunctionApproveRejectMitra(
            resultMitra: _resultApproveMitra,
            listApproveRejectMitra: listApproveRejectMitra);
    listDataDesignFunctionRequestCancel =
        getListDataDesignFunctionRequestCancelMitra(
            resultMitra: _resultRequestMitra);
  }

  void _checkThereReqFromTransporter() {
    isThereReqFromTransporter.value = numberApprove.value != "0";
  }

  void addMitra() async {
    var mapResult = await Get.toNamed(Routes.LIST_TRANSPORTER2);
    checkReturnFromTransporter(mapResult);
  }

  void checkReturnFromTransporter(dynamic mapResult) {
    if (mapResult != null) {
      //Map<String, dynamic> mapResult = result;
      if (mapResult.length > 0) {
        if (mapResult["0"] != null && mapResult["0"] == true) {
          if (isMitraTab.value && !isSearchMitraMode.value) {
            getAllMitraByShipperFirst();
          } else {
            _isFirstLoadMitra = false;
          }
        }
        if (mapResult["1"] != null && mapResult["1"] == true) {
          if (isRequestApproveTab.value && !isSearchMitraMode.value) {
            getAllMitraApproveRejectByShipperFirst();
          } else {
            _isFirstLoadApproveMitra = false;
          }
        }
        if (mapResult["2"] != null && mapResult["2"] == true) {
          if (isRequestApproveTabRequestView.value &&
              !isSearchMitraMode.value) {
            getAllMitraRequestCancelByShipperFirst();
          } else {
            _isFirstLoadRequestMitra = false;
          }
        }
      }
    }
  }

  void _setListUndangRekanBisnisDesc2() {
    String isiDesc2 = "PartnerManagementInviteBusinessPartnersDesc2".tr;
    List<String> listString = isiDesc2.split(" ");
    String text = "";
    for (int i = 0; i < listString.length; i++) {
      String isi = listString[i];
      if (isi == ":KODE") {
        if (text != "") {
          listUndangRekanBisnisDesc2.add(_setTextSpan(text + " ", false));
        }
        listUndangRekanBisnisDesc2.add(_setTextSpan(
            GlobalVariable.userModelGlobal.code +
                (i + 1 == listString.length ? "" : " "),
            true));
        text = "";
      } else {
        text += (text != "" ? " " : "") + isi;
      }
      if (i + 1 == listString.length && text != "")
        listUndangRekanBisnisDesc2.add(_setTextSpan(text, false));
    }
  }

  List<InlineSpan> _getListWidgetTextSpan(
      String message, String splitterCode, String spillterReplace) {
    List<InlineSpan> listInline = [];
    List<String> listString = message.split(" ");
    String text = "";
    for (int i = 0; i < listString.length; i++) {
      String isi = listString[i];
      if (isi == splitterCode) {
        if (text != "") {
          listInline.add(_setTextSpan(text + " ", false));
        }
        listInline.add(_setTextSpan(
            spillterReplace + (i + 1 == listString.length ? "" : " "), true));
        text = "";
      } else {
        text += (text != "" ? " " : "") + isi;
      }
      if (i + 1 == listString.length && text != "")
        listInline.add(_setTextSpan(text, false));
    }
    return listInline;
  }

  TextSpan _setTextSpan(String title, bool isBold) {
    return TextSpan(
        text: title,
        style: TextStyle(
            color: Colors.black,
            fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500));
  }

  showCallPartner(int index) {
    _contactModalBottomSheetController.showContact(
      "",
      transporterID: listRequestCancelMitra[index].id,
    );
  }

  goToSearchPage() async {
    if (isMitraTab.value) {
      _typeMitraSearchMode = TypeMitra.MITRA;
    } else if (isRequestApproveTab.value) {
      if (isRequestApproveTabApproveView.value) {
        _typeMitraSearchMode = TypeMitra.APPROVE_MITRA;
      } else {
        _typeMitraSearchMode = TypeMitra.REQUEST_MITRA;
      }
    } else if (isGroupMitraTab.value) {
      _typeMitraSearchMode = TypeMitra.GROUP_MITRA;
    }
    isSearchMitraMode.value = true;
    Get.toNamed(Routes.SEARCH_MANAJEMEN_MITRA, arguments: {
      SearchManajemenMitraController.typeMitraArgsKey: _typeMitraSearchMode,
      SearchManajemenMitraController.listDataListSortingModelArgsKey:
          _typeMitraSearchMode == TypeMitra.GROUP_MITRA ? groupSort : mitraSort,
    });
  }

  void _showMenuApproveRejectMitra(MitraModel mitraModel,
      {void Function(bool) onResultFromDetailTransporter}) {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 4,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 17),
                      child: Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 38,
                        height: GlobalVariable.ratioWidth(Get.context) * 3,
                        decoration: BoxDecoration(
                            color: Color(ListColor.colorLightGrey16),
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 4))),
                      )),
                  Container(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 12,
                          right: GlobalVariable.ratioWidth(Get.context) * 12,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: CustomText(
                                    "PartnerManagementLabelOption".tr,
                                    fontWeight: FontWeight.w700,
                                    color: Color(ListColor.color4),
                                    fontSize: 14),
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: SvgPicture.asset(
                                  "assets/ic_close1,5.svg",
                                  color: Color(ListColor.colorBlack),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                )),
                              ),
                            ),
                          ),
                        ],
                      )),
                  _itemApproveRejectMitra(
                      title: "PartnerManagementLabelViewProfile".tr,
                      onTap: () async {
                        var result =
                            await Get.toNamed(Routes.TRANSPORTER, arguments: [
                          mitraModel.id,
                          mitraModel.name,
                          mitraModel.avatar,
                          mitraModel.isGold,
                        ]);
                        checkReturnFromTransporter(result);
                        if (onResultFromDetailTransporter != null)
                          onResultFromDetailTransporter(result != null);
                      }),
                ]),
          );
        });
  }

  void _showMenuMitra(MitraModel mitraModel, int index) {
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 4,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 17),
                      child: Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 38,
                        height: GlobalVariable.ratioWidth(Get.context) * 3,
                        decoration: BoxDecoration(
                            color: Color(ListColor.colorLightGrey16),
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 4))),
                      )),
                  Container(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 12,
                          right: GlobalVariable.ratioWidth(Get.context) * 12,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: CustomText(
                                    "PartnerManagementLabelOption".tr,
                                    fontWeight: FontWeight.w700,
                                    color: Color(ListColor.color4),
                                    fontSize: 14),
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: SvgPicture.asset(
                                  "assets/ic_close1,5.svg",
                                  color: Color(ListColor.colorBlack),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                )),
                              ),
                            ),
                          ),
                        ],
                      )),
                  _itemApproveRejectMitra(
                      title: "DetailTransporterLabelRemovePartner".tr,
                      onTap: () async {
                        removeMitra(mitraModel);
                      },
                      textColor: Color(ListColor.colorRed)),
                  _lineSaparator(),
                  _itemApproveRejectMitra(
                    title: "PartnerManagementLabelCallMitra".tr,
                    onTap: () {
                      showCallPartner(index);
                    },
                  ),
                ]),
          );
        });
  }

  void _showMenuRequestCancelMitra(int index, RxList<dynamic> listRequestCancel,
      {void Function() onSuccessCancelMitra}) {
    MitraModel mitraModel = listRequestCancel[index];
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 4,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 17),
                      child: Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 38,
                        height: GlobalVariable.ratioWidth(Get.context) * 3,
                        decoration: BoxDecoration(
                            color: Color(ListColor.colorLightGrey16),
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 4))),
                      )),
                  Container(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 12,
                          right: GlobalVariable.ratioWidth(Get.context) * 12,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: CustomText(
                                  "PartnerManagementLabelOption".tr,
                                  fontWeight: FontWeight.w700,
                                  color: Color(ListColor.color4),
                                  fontSize: 14)),
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: SvgPicture.asset(
                                  "assets/ic_close1,5.svg",
                                  color: Color(ListColor.colorBlack),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          15,
                                )),
                              ),
                            ),
                          ),
                        ],
                      )),
                  _itemApproveRejectMitra(
                      title: "PartnerManagementLabelCancelMitra".tr,
                      onTap: () {
                        dialogSetCancelMitra(mitraModel,
                            onSuccessCancelMitra: onSuccessCancelMitra);
                      },
                      textColor: Color(ListColor.colorRed)),

                  _lineSaparator(),
                  _itemApproveRejectMitra(
                      title: "PartnerManagementLabelCallMitra".tr,
                      onTap: () {
                        showCallPartner(index);
                      }),
                  // _lineSaparator(),
                  // _itemApproveRejectMitra(
                  //     title: "PartnerManagementLabelCallMitra".tr,
                  //     onTap: () {
                  //       controller.showCallPartner(index);
                  //     }),
                ]),
          );
        });
  }

  Widget _itemApproveRejectMitra(
      {String title,
      String urlIcon = "",
      void Function() onTap,
      Color textColor = Colors.black}) {
    return InkWell(
        onTap: () {
          Get.back();
          onTap();
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: GlobalVariable.ratioWidth(Get.context) * 41,
          padding: EdgeInsets.symmetric(
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(title,
                  color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
              urlIcon != ""
                  ? SvgPicture.asset(
                      urlIcon,
                      width: 30,
                      height: 30,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ));
  }

  Widget _lineSaparator() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
      height: GlobalVariable.ratioWidth(Get.context) * 0.5,
      color: Color(ListColor.colorStroke),
    );
  }

  Widget listPerItemMitra(
      {BuildContext context,
      int index,
      ListDataDesignFunction listDataDesignFunction}) {
    return listDataDesignFunction.getTransporterTileWidget(index,
        typeButton: ListDataDesignTypeButtonCornerRight.THREE_DOT_VERT,
        dari: ListDataMitraFrom.MITRA, onTapBottonCornerRight: () {
      _showMenuMitra(listMitra[index], index);
    });
  }

  Widget listPerItemApproveRejectMitra(
      {BuildContext context,
      int index,
      ListDataDesignFunction listDataDesignFunction,
      RxList<dynamic> listApproveRejectMitra,
      void Function(bool) onResultFromDetailTransporter}) {
    return listDataDesignFunction.getTransporterTileWidget(index,
        typeButton: ListDataDesignTypeButtonCornerRight.THREE_DOT_VERT,
        disableaccept: acceptance.value,
        disablereject: disabled.value,
        dari: ListDataMitraFrom.MITRA, onTapBottonCornerRight: () {
      _showMenuApproveRejectMitra(listApproveRejectMitra[index],
          onResultFromDetailTransporter: onResultFromDetailTransporter);
    });
  }

  Widget listPerItemRequestCancelMitra(
      {BuildContext context,
      int index,
      ListDataDesignFunction listDataDesignFunction,
      RxList<dynamic> listRequestCancel,
      void Function() onSuccessCancelMitra}) {
    return listDataDesignFunction.getTransporterTileWidget(index,
        typeButton: ListDataDesignTypeButtonCornerRight.THREE_DOT_VERT,
        dari: ListDataMitraFrom.MITRA, onTapBottonCornerRight: () {
      _showMenuRequestCancelMitra(index, listRequestCancel,
          onSuccessCancelMitra: onSuccessCancelMitra);
    });
  }

  ListDataDesignFunction getListDataDesignFunctionMitra(
      {void Function(dynamic result, int index) resultMitra}) {
    return ListDataDesignFunction(true,
        resultValueFunction: resultMitra,
        labelJoin: "PartnerManagementLabelBecomePartnerSince".tr);
  }

  ListDataDesignFunction getListDataDesignFunctionApproveRejectMitra(
      {void Function(dynamic result, int index) resultMitra,
      @required RxList<dynamic> listApproveRejectMitra,
      void Function() onSuccessApproveReject}) {
    return ListDataDesignFunction(true,
        resultValueFunction: resultMitra,
        labelJoin: "PartnerManagementLabelRequestDate".tr,
        isUsingTwoButtonRightOfDesc: true,
        labelButton1RightOfDesc: "PartnerManagementLabelApproveMitra".tr,
        labelButton2RightOfDesc: "PartnerManagementLabelRejectMitra".tr,
        onTapButton1RightOfDesc: (index) {
      dialogSetApproveRejectMitra(listApproveRejectMitra[index], true,
          onSuccessApproveReject: onSuccessApproveReject);
    }, onTapButton2RightOfDesc: (index) {
      dialogSetApproveRejectMitra(listApproveRejectMitra[index], false,
          onSuccessApproveReject: onSuccessApproveReject);
    });
  }

  ListDataDesignFunction getListDataDesignFunctionRequestCancelMitra(
      {void Function(dynamic result, int index) resultMitra}) {
    return ListDataDesignFunction(true,
        resultValueFunction: resultMitra,
        labelJoin: "PartnerManagementLabelRequestDate".tr);
  }

  Widget listPerItemGroupMitra(
      {@required int index,
      @required int totalIndex,
      @required GroupMitraModel group,
      @required RefreshController Function() refreshControllerFunction,
      void Function(bool) onSuccessUpdateData}) {
    var borderRadius = GlobalVariable.ratioWidth(Get.context) * 10;
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * 16,
          0,
          GlobalVariable.ratioWidth(Get.context) * 16,
          GlobalVariable.ratioWidth(Get.context) * 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(ListColor.colorBlack).withOpacity(0.1),
            blurRadius: GlobalVariable.ratioWidth(Get.context) * 20,
            spreadRadius: 0,
            offset: Offset(0, GlobalVariable.ratioWidth(Get.context) * 13),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Column(children: [
        Container(
          height: GlobalVariable.ratioWidth(Get.context) * 47,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
              color: Color(ListColor.colorLightBlue)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16),
                width: GlobalVariable.ratioWidth(Get.context) *
                    GlobalVariable.ratioWidth(Get.context) *
                    32,
                height: GlobalVariable.ratioWidth(Get.context) * 32,
                child: CircleAvatar(
                  radius: GlobalVariable.ratioWidth(Get.context) * 32.0,
                  backgroundImage:
                      NetworkImage(group.avatar),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(group.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      CustomText(
                        "${group.totalPartner} " +
                            "PartnerManagementLabelPartner".tr,
                        color: Color(ListColor.colorGrey3),
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        fontSize: 12,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  optionGroupMitra(group,
                      onSuccessUpdateData: onSuccessUpdateData);
                },
                child: Container(
                    margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(Get.context) * 12,
                        left: GlobalVariable.ratioWidth(Get.context) * 12),
                    child: SvgPicture.asset(
                      "assets/ic_more_vert.svg",
                      color: Color(ListColor.colorBlack),
                      width: GlobalVariable.ratioWidth(Get.context) * 24,
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    )),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 14,
              GlobalVariable.ratioWidth(Get.context) * 12,
              GlobalVariable.ratioWidth(Get.context) * 14,
              GlobalVariable.ratioWidth(Get.context) * 14),
          child: CustomText(
            (group.description) ?? "",
            maxLines: 3,
            height: 1.2,
            overflow: TextOverflow.ellipsis,
            color: Color(ListColor.colorGrey4),
          ),
        ),
        Container(
          width: MediaQuery.of(Get.context).size.width,
          height: GlobalVariable.ratioWidth(Get.context) * 0.5,
          color: Color(ListColor.colorStroke),
        ),
        Container(
          height: GlobalVariable.ratioWidth(Get.context) * 42,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16),
                alignment: Alignment.center,
                height: GlobalVariable.ratioWidth(Get.context) * 20,
                padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                decoration: BoxDecoration(
                    color: group.status
                        ? Color(ListColor.colorLightGreen3)
                        : Color(ListColor.colorLightRed3),
                    borderRadius: BorderRadius.all(Radius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 6))),
                child: CustomText(
                    group.status
                        ? "PartnerManagementAktifGrup".tr
                        : "PartnerManagementTidakAktifGrup".tr,
                    color: group.status
                        ? Color(ListColor.colorGreen6)
                        : Color(ListColor.colorRed)),
              ),
              Expanded(child: Container()),
              _button(
                  text: "PartnerManagementLabelDetail".tr,
                  marginRight: 16,
                  height: 28,
                  marginTop: 7,
                  marginBottom: 7,
                  paddingLeft: 24,
                  paddingRight: 24,
                  borderRadius: 18,
                  useBorder: false,
                  useShadow: false,
                  backgroundColor: Color(ListColor.colorBlue),
                  onTap: () async {
                    var result = await Get.toNamed(
                        Routes.DETAIL_MANAJEMEN_GROUP_MITRA,
                        arguments: [group.id, group]);
                    if (result != null && result == true) {
                      if (onSuccessUpdateData != null) {
                        _isFirstLoadGroupMitra = false;
                        onSuccessUpdateData(true);
                      } else
                        refreshControllerFunction().requestRefresh();
                    } else if (onSuccessUpdateData != null) {
                      onSuccessUpdateData(false);
                    }
                  }),
            ],
          ),
        ),
      ]),
    );
  }

  int generateID() {
    return _idSearchResult++;
  }

  void afterFromSearch() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    isSearchMitraMode.value = false;
    if (isRequestApproveTab.value) {
      if (isRequestApproveTabApproveView.value && !_isFirstLoadApproveMitra) {
        getAllMitraApproveRejectByShipperFirst();
      } else if (isRequestApproveTabRequestView.value &&
          !_isFirstLoadRequestMitra) {
        getAllMitraRequestCancelByShipperFirst();
      }
    } else if (isMitraTab.value && !_isFirstLoadMitra) {
      getAllMitraByShipperFirst();
    } else if (isGroupMitraTab.value && !_isFirstLoadGroupMitra) {
      refreshGroupMitra(isShowLoadingCircular: true);
    }
  }

  bool isCheckRefreshFromDetailTransporter(var result) {
    return result == null ? false : (result.length == 0 ? false : true);
  }

  Future removeMitra(MitraModel mitraModel) async {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "GlobalDialogTransporterRemovePartnerTitle".tr,
      customMessage: Container(
        margin: EdgeInsets.only(
            bottom: GlobalVariable.ratioWidth(Get.context) * 20),
        child: GlobalAlertDialog.getTextRichtWidget(
            "DetailTransporterLabelRemoveQuestion".tr,
            ":NAMA_TRANSPORTER",
            mitraModel.name),
      ),
      context: Get.context,
      labelButtonPriority1: "Ya",
      labelButtonPriority2: "Tidak",
      onTapPriority1: () async {
        var response =
            await ApiHelper(context: Get.context, isShowDialogLoading: false)
                .removePartner(mitraModel.docID);
        var message = MessageFromUrlModel.fromJson(response['Message']);
        if (message.code == 200) {
          CustomToast.show(
              context: Get.context,
              message: "DetailTransporterLabelRemoveSuccess".tr);
          refreshMitraController.requestRefresh();
        } else {
          GlobalAlertDialog.showAlertDialogCustom(
              title: "Error".tr,
              customMessage: Container(
                margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(Get.context) * 20),
                child: GlobalAlertDialog.convertHTMLToText(message.code == 500
                    ? response['Data']['Message']
                    : message.text),
              ),
              context: Get.context,
              labelButtonPriority1: "OK",
              onTapPriority1: () {});
        }
        checkSort();
      },
    );
  }

  Widget _button({
    double height,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 0,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: maxWidth ? MediaQuery.of(Get.context).size.width : null,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * 1,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: onTap == null
                ? null
                : () {
                    onTap();
                  },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }
}
