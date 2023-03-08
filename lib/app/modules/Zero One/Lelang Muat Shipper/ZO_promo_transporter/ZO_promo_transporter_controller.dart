import 'dart:async';
import 'dart:math' as math;

import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart'
    as ark_global;
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_location/ZO_promo_transporter_filter_location_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_transporter/ZO_promo_transporter_filter_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_filter_views/ZO_promo_transporter_filter_truck/ZO_promo_transporter_filter_truck_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_sorting_controller/ZO_promo_transporter_sorting_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/checkbox_custom_widget_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_notifikasi_harga_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_promo_transporter_model.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_bottom_sheet_contact.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_detail_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_search_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_strings.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_widgets/ZO_promo_transporter_sheet_widgets/ZO_promo_transporter_sheet_promo_condition.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/shared_preferences_helper_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum TooltipType {
  location,
  periode,
}

enum DetailTooltipType {
  dimension,
}

class ZoPromoTransporterController extends GetxController {
  var promoConditionDetail = ''.obs;
  var isLoadingPromoConditionDetail = false.obs;
  final refreshController = RefreshController(initialRefresh: false);
  final searchRefreshController = RefreshController(initialRefresh: false);
  var response = Rx<ZoPromoTransporterResponseModel>(null);
  var maxQty = 0.obs;
  var maxPrice = 0.obs;
  var maxQtyResponseList = <int>[];
  var maxPriceResponseList = <int>[];
  var showPopUp = false.obs;
  var isLoading = false.obs;
  var isFetching = false.obs;
  var loginASval = "".obs;
  final limit = 10;
  var page = 0.obs;
  var tooltipIndex = 0.obs;
  var showTooltip = false.obs;
  var showDetailTooltip = false.obs;
  var tooltipType = TooltipType.location.obs;
  var detailTooltipType = DetailTooltipType.dimension.obs;
  final promoData = <ZoPromoTransporterDataModel>[].obs;
  var promoSupportingData = Rx<ZoPromoTransporterSupportingDataModel>(null);
  var hasMore = true.obs;
  var tooltipGlobalPosition = Rx<Offset>(null);
  var detailTooltipGlobalPosition = Rx<Offset>(null);
  // var isSearchLoading = false.obs;
  var searchQueryObs = ''.obs;
  var tempSearchQueryObs = ''.obs;
  final filterObs = <String, dynamic>{}.obs;
  Timer debounce;
  Rx<RangeValues> rangePrice = RangeValues(0.0, 1500.0).obs;
  Rx<RangeValues> rangeQty = RangeValues(0.0, 1500.0).obs;
  final rangePriceStart = TextEditingController().obs;
  final rangePriceEnd = TextEditingController().obs;
  final rangeQtyStart = TextEditingController().obs;
  final rangeQtyEnd = TextEditingController().obs;
  var showLatest = true.obs;

  final _data = <ZoPromoTransporterLatestSearchDataModel>[].obs;
  final data = <ZoPromoTransporterLatestSearchDataModel>[].obs;
  var initialLatestSearch = ''.obs;

  int compareByCreatedAtDescending(
    ZoPromoTransporterLatestSearchDataModel a,
    ZoPromoTransporterLatestSearchDataModel b,
  ) {
    return b.createdAt.compareTo(a.createdAt);
  }

  void setDataLocally(List<ZoPromoTransporterLatestSearchDataModel> list) {
    list.sort(compareByCreatedAtDescending);
    SharedPreferencesHelper.setLatestSearchPromoTransporter(
      ZoPromoTransporterLatestSearchModel(data: list).toJson(),
    );
  }

  void initData(List<ZoPromoTransporterLatestSearchDataModel> list) {
    _data.clear();
    _data.addAll(list ?? []);
    if (_data.isNotEmpty) {
      _data.sort(compareByCreatedAtDescending);
    }
    setDataVisible(_data);
  }

  void setDataVisible(List<ZoPromoTransporterLatestSearchDataModel> list) {
    data.clear();
    data.addAll(list ?? []);
    if (data.isNotEmpty) {
      data.sort(compareByCreatedAtDescending);
    }
    data.refresh();
  }

  void onSearchChanged(String text) {
    tempSearchQueryObs.value = text.trim();
    // if (searchQueryObs.value.trim().isEmpty) {
    //   showLatest.value = false;
    // }
    // if (_data.isNotEmpty) {
    //   if (text?.isEmpty ?? true) {
    //     setDataVisible([..._data]);
    //   } else {
    //     setDataVisible(
    //       _data
    //           .where((e) =>
    //               e.query.toLowerCase().contains(text.trim().toLowerCase()))
    //           .toList(),
    //     );
    //   }
    // }
  }

  void onSearchSubmit(String text) {
    if (text.trim().isEmpty) {
      // FocusManager.instance?.primaryFocus?.unfocus();
      searchQueryObs.value = '';
      tempSearchQueryObs.value = '';
      showLatest.value = false;
      return;
    }
    final newItem = ZoPromoTransporterLatestSearchDataModel(
      query: text.trim(),
      createdAt: DateTime.now(),
    );
    add(newItem);
    showLatest.value = false;
    searchQueryObs.value = newItem.query.trim();
    tempSearchQueryObs.value = newItem.query.trim();
    _setPage(0);
    doInbetweenLoading(() async => _fetchTransporterPromo());
    // initData(_data);
    // _data.add(newItem);
    // _data.refresh();
    // setDataLocally(_data);
    // Get.back(result: newItem.query);
    // Get.find<ZoPromoTransporterController>().searchQueryObs.value = text;
    // Get.find<ZoPromoTransporterController>().searchQueryObs.refresh();
    // Navigator.pushReplacement(
    //   Get.context,
    //   MaterialPageRoute(builder: (_) => ZoPromoTransporterSearchView()),
    // );
  }

  ZoPromoTransporterLatestSearchDataModel removeAt(int index) {
    final removed = data.removeAt(index);
    data.refresh();
    _data.removeWhere((element) => removed.query == element.query);
    setDataLocally(_data);

    return removed;
  }

  void add(ZoPromoTransporterLatestSearchDataModel item) {
    _data.removeWhere((element) =>
        element.query.trim().toLowerCase() == item.query.trim().toLowerCase());
    _data.add(item);
    initData([..._data]);
    setDataLocally(_data);
  }

  void onTapped(int index) {
    onTooltipClose();
    onDetailTooltipClose();
    var tapped = removeAt(index).copyWith(createdAt: DateTime.now());
    add(tapped);
    setDataLocally(_data);
    // if (isLatestSearchPage) {
    //   Get.back(result: tapped.query);
    // } else {
    showLatest.value = false;
    FocusManager.instance?.primaryFocus?.unfocus();
    loadPromo(tapped.query);
    // }
    // Get.find<ZoPromoTransporterController>().searchQueryObs.value =
    //     tapped.query;
    // Navigator.pushReplacement(
    //   Get.context,
    //   MaterialPageRoute(builder: (_) => ZoPromoTransporterSearchView()),
    // );
  }

  void onDeleteTapped(int index) {
    removeAt(index);
    initData([..._data]);
  }

  void onDeleteAllTapped() {
    initData([]);
    setDataLocally(_data);
  }

  final sorts = [
    DataListSortingModel(
      ZoPromoTransporterStrings.sortCreated.tr,
      "Created",
      ZoPromoTransporterStrings.sortCreatedAsc.tr,
      ZoPromoTransporterStrings.sortCreatedDesc.tr,
      "".obs,
      isTitleASCFirst: false,
    ),
    DataListSortingModel(
      ZoPromoTransporterStrings.sortPickup.tr,
      "pickup_city",
      ZoPromoTransporterStrings.sortPickupAsc.tr,
      ZoPromoTransporterStrings.sortPickupDesc.tr,
      "".obs,
    ),
    DataListSortingModel(
      ZoPromoTransporterStrings.sortDestination.tr,
      "destination_city",
      ZoPromoTransporterStrings.sortDestinationAsc.tr,
      ZoPromoTransporterStrings.sortDestinationDesc.tr,
      "".obs,
    ),
    DataListSortingModel(
      ZoPromoTransporterStrings.sortQuota.tr,
      "quota",
      ZoPromoTransporterStrings.sortQuotaAsc.tr,
      ZoPromoTransporterStrings.sortQuotaDesc.tr,
      "".obs,
      isTitleASCFirst: false,
    ),
    DataListSortingModel(
      ZoPromoTransporterStrings.sortTransporter.tr,
      "transporter_name",
      ZoPromoTransporterStrings.sortTransporterAsc.tr,
      ZoPromoTransporterStrings.sortTransporterDesc.tr,
      "".obs,
    ),
    DataListSortingModel(
      ZoPromoTransporterStrings.sortPromoPrice.tr,
      "promo_price",
      ZoPromoTransporterStrings.sortPromoPriceAsc.tr,
      ZoPromoTransporterStrings.sortPromoPriceDesc.tr,
      "".obs,
      isTitleASCFirst: false,
    ),
    DataListSortingModel(
      ZoPromoTransporterStrings.sortMaxCapacity.tr,
      "max_capacity",
      ZoPromoTransporterStrings.sortMaxCapacityAsc.tr,
      ZoPromoTransporterStrings.sortMaxCapacityDesc.tr,
      "".obs,
      isTitleASCFirst: false,
    ),
    DataListSortingModel(
      ZoPromoTransporterStrings.sortPeriode.tr,
      "start_date",
      ZoPromoTransporterStrings.sortPeriodeAsc.tr,
      ZoPromoTransporterStrings.sortPeriodeDesc.tr,
      "".obs,
    ),
    DataListSortingModel(
      ZoPromoTransporterStrings.sortPayment.tr,
      "payment",
      ZoPromoTransporterStrings.sortPaymentAsc.tr,
      ZoPromoTransporterStrings.sortPaymentDesc.tr,
      "".obs,
    ),
  ];
  ZoPromoTransporterSortingController _sortingController;
  var sortMapObs = <String, dynamic>{}.obs;
  var isSortEnabled = false.obs;
  var isSortActive = false.obs;
  final _originalLatestSearchList =
      <ZoPromoTransporterLatestSearchDataModel>[].obs;
  final latestSearchList = <ZoPromoTransporterLatestSearchDataModel>[].obs;

  final bannerItems = <String>[].obs;

  Future<void> initBanner() async {
    bannerItems.clear();

    final fetchResult = await ApiHelper(
      context: Get.context,
      isShowDialogLoading: false,
      isShowDialogError: false,
    ).fetchBanner();

    if (fetchResult != null &&
        fetchResult['Message'] != null &&
        fetchResult['Message']['Code'] == 200) {
      if (fetchResult['Data'] != null && fetchResult['Data']['Promo'] != null) {
        if (fetchResult['Data']['Promo'] is List) {
          final items =
              (fetchResult['Data']['Promo'] as List).map((e) => '$e').toList();

          bannerItems.addAll(items.take(10));
        }
      }
    }
    bannerItems.refresh();
  }

  @override
  void onInit() {
    initBanner();
    doInbetweenLoading(() async {
      SharedPreferencesHelper.getLatestSearchPromoTransporter()
              .then(
                  (json) => ZoPromoTransporterLatestSearchModel.fromJson(json))
              .then((model) => initData(model?.data ?? []))
          // .then((_) => onSearchChanged(initialSearch.value))
          ;
      SharedPreferencesHelper.getFirstTimePromoTransporter()
          .then((value) async => await _setIsFirstTimer(value))
          .onError((error, stackTrace) async => await _setIsFirstTimer(true));

      // SharedPreferencesHelper.getLatestSearchPromoTransporter()
      //     .then(
      //       (value) => _setLatestSearchList(
      //         ZoPromoTransporterLatestSearchModel.fromJson(value)?.data,
      //       ),
      //     )
      //     .onError((error, stackTrace) => _setLatestSearchList(null));

      var getUserShipperResponse = await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      ).getUserShiper(GlobalVariable.role);

      if (getUserShipperResponse["Message"]["Code"] == 200) {
        loginASval.value = getUserShipperResponse["LoginAs"].toString();
        await _fetchTransporterPromo();
      }
    });
    _setSortController();
    super.onInit();
  }

  @override
  void onClose() {
    // refreshController.dispose();
    // searchRefreshController.dispose();
    // _keyboardNotification.dispose();
    _sortingController.dispose();
    super.onClose();
  }

  void _setSortController() {
    _sortingController = Get.put<ZoPromoTransporterSortingController>(
      ZoPromoTransporterSortingController(
        listSort: sorts,
        initMap: sortMapObs,
        enableCustomSort: true,
        onRefreshData: (newSortMap) async {
          sortMapObs.clear();
          sortMapObs.addAll(newSortMap);
          sortMapObs.refresh();
          if (sortMapObs.isNotEmpty) {
            isSortActive.value = true;
          } else {
            isSortActive.value = false;
          }
          debugPrint(newSortMap.toString());
          debugPrint('debug-sortmapobs: ${sortMapObs.toString()}');
          _setPage(0);

          isLoading.value = true;
          isLoading.refresh();

          await _fetchTransporterPromo();

          isLoading.value = false;
          isLoading.refresh();
        },
      ),
      permanent: false,
      // tag:
      //     'ZoPromoTransporterSortController-${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  void onSortTap() async {
    onTooltipClose();
    onDetailTooltipClose();
    await _sortingController.showSort();
  }

  void onInfoTap() {
    onTooltipClose();
    onDetailTooltipClose();
    showPopUp.value = true;
    showPopUp.refresh();
  }

  // var showLatestSearch = false.obs;

  // KeyboardVisibilityNotification _keyboardNotification;

  // void _setLatestSearchList(
  //   List<ZoPromoTransporterLatestSearchDataModel> data,
  // ) {
  //   latestSearchList.value = data ?? [];
  //   latestSearchList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  //   latestSearchList.refresh();
  //   _originalLatestSearchList.clear();
  //   _originalLatestSearchList.addAll(data ?? []);

  //   SharedPreferencesHelper.setLatestSearchPromoTransporter(
  //     ZoPromoTransporterLatestSearchModel(data: latestSearchList).toJson(),
  //   );
  // }

  // void _addLatestSearch(String query) {
  //   var result = latestSearchList.asMap().entries.where((e) =>
  //       e.value.query.trim().toLowerCase() == query.trim().toLowerCase());
  //   var isFound = result.isNotEmpty;

  //   if (isFound) {
  //     var data = latestSearchList.removeAt(result.first.key);

  //     latestSearchList.add(data.copyWith(createdAt: DateTime.now()));
  //   } else {
  //     latestSearchList.add(ZoPromoTransporterLatestSearchDataModel(
  //       query: query,
  //       createdAt: DateTime.now(),
  //     ));
  //   }

  //   _setLatestSearchList(latestSearchList);
  // }

  // void _removeLatestSearch(int index) {
  //   latestSearchList.removeAt(index);
  //   _setLatestSearchList(latestSearchList);
  // }

  // void onLatestSearchItemTap(int index) {
  //   var query = latestSearchList[index].query;
  //   onSearchSubmit(query);
  // }

  // void onLatestSearchItemRemoveTap(int index) {
  //   _removeLatestSearch(index);
  // }

  // void onLatestSearchRemoveAll() {
  //   _setLatestSearchList(null);
  // }

  // void onSearchSubmit(String query) {
  //   // showLatestSearch.value = false;
  //   debugPrint('ZoPromoTransporterController-onSearchSubmit: ${jsonEncode({
  //     'data': latestSearchList
  //   })}');
  //   _addLatestSearch(query);
  //   searchQueryObs.value = query;
  //   doInbetweenLoading(() async => await _fetchTransporterPromo());
  // }

  // // void onSearchActive() {
  // //   showLatestSearch.value = true;
  // // }
  void loadPromo([String query]) {
    if (query?.trim()?.isNotEmpty ?? false) {
      searchQueryObs.value = query.trim();
      tempSearchQueryObs.value = query.trim();
    }
    doInbetweenLoading(() async => await _fetchTransporterPromo());
  }

  void onLatestSearchTap() async {
    onTooltipClose();
    onDetailTooltipClose();
    setDataVisible(_data
        // _data
        //     .where((e) => e.query
        //         .toLowerCase()
        //         .contains(tempSearchQueryObs.value.trim().toLowerCase()))
        //     .toList(),
        );
    showLatest.value = true;
  }

  void onSearchTap() async {
    onTooltipClose();
    onDetailTooltipClose();
    sortMapObs.clear();
    sortMapObs.refresh();
    var tempIsFilter = isFilter.value;
    isFilter.value = false;
    _setPage(0);
    _setSortController();
    // Get.toNamed(Routes.ZO_PROMO_TRANSPORTER_LATEST_SEARCH).then((value) {
    //   searchQueryObs.value = value;
    //   loadPromo();
    // });
    showLatest.value = true;
    await Get.to(() => ZoPromoTransporterSearchView());
    isFilter.value = tempIsFilter;
    maxPriceResponseList.clear();
    maxQtyResponseList.clear();
    sortMapObs.clear();
    sortMapObs.refresh();
    searchQueryObs.value = '';
    tempSearchQueryObs.value = '';
    // doInbetweenLoading(() async => await _fetchTransporterPromo());
  }

  // void onSearchChanged(String query) async {
  //   // if (query.trim().isEmpty) {
  //   //   latestSearchList.clear();
  //   //   latestSearchList.addAll([..._originalLatestSearchList]);
  //   // } else {
  //   //   latestSearchList.clear();
  //   //   latestSearchList.addAll(
  //   //     _originalLatestSearchList.where(
  //   //       (e) =>
  //   //           e.query.trim().toLowerCase().contains(query.trim().toLowerCase()),
  //   //     ),
  //   //   );
  //   // }
  //   if (query.trim().isEmpty) {
  //     promoData.clear();
  //     // showLatestSearch.value = true;
  //   } else {
  //     // showLatestSearch.value = false;
  //   }
  //   if (debounce?.isActive ?? false) debounce?.cancel();
  //   debounce = Timer(const Duration(milliseconds: 500), () async {
  //     // isSearchLoading.value = true;
  //     isLoading.value = true;
  //     searchQueryObs.value = query;

  //     await _fetchTransporterPromo();

  //     // isSearchLoading.value = false;
  //     isLoading.value = false;
  //   });
  // }

  Offset getTooltipLocalPosition(BuildContext context) {
    return (context.findRenderObject() as RenderBox)
        .globalToLocal(tooltipGlobalPosition.value);
  }

  Offset getDetailTooltipLocalPosition(BuildContext context) {
    if (detailTooltipGlobalPosition.value == null) return null;
    return (context.findRenderObject() as RenderBox)
        .globalToLocal(detailTooltipGlobalPosition.value);
  }

  void _showTooltip(TooltipType type, int index, Offset position) {
    showTooltip.value = true;
    tooltipType.value = type;
    tooltipIndex.value = index;
    tooltipGlobalPosition.value = position;
  }

  void _showDetailTooltip(DetailTooltipType type, Offset position) {
    showDetailTooltip.value = true;
    detailTooltipType.value = type;
    detailTooltipGlobalPosition.value = position;
  }

  void onLocationTap(int index, TapDownDetails details) {
    onTooltipClose();
    onDetailTooltipClose();
    debugPrint('Tooltip: Location, $index, ${details.globalPosition}');
    _showTooltip(TooltipType.location, index, details.globalPosition);
  }

  void onPeriodeTap(int index, TapDownDetails details) {
    onTooltipClose();
    onDetailTooltipClose();
    debugPrint('Tooltip: Periode, $index, ${details.globalPosition}');
    _showTooltip(TooltipType.periode, index, details.globalPosition);
  }

  void onDimensionTap(TapDownDetails details) {
    onTooltipClose();
    onDetailTooltipClose();
    debugPrint('Tooltip: Dimension, ${details.globalPosition}');
    _showDetailTooltip(DetailTooltipType.dimension, details.globalPosition);
  }

  void _hideTooltip() {
    showTooltip.value = false;
  }

  void _hideDetailTooltip() {
    showDetailTooltip.value = false;
    detailTooltipGlobalPosition.value = null;
  }

  void onDetailTooltipClose() {
    _hideDetailTooltip();
  }

  void onTooltipClose() {
    _hideTooltip();
  }

  bool shouldShowLocationTooltip(int index) {
    return tooltipIndex.value == index &&
        showTooltip.isTrue &&
        tooltipType.value == TooltipType.location;
  }

  bool shouldShowPeriodeTooltip(int index) {
    return tooltipIndex.value == index &&
        showTooltip.isTrue &&
        tooltipType.value == TooltipType.periode;
  }

  bool shouldShowDimensionTooltip() {
    return showDetailTooltip.isTrue &&
        detailTooltipType.value == DetailTooltipType.dimension &&
        detailTooltipGlobalPosition.value != null;
  }

  Future<bool> _setIsFirstTimer(bool value) async {
    debugPrint('ZoPromoTransporterController-isFirstTimer: $value');
    showPopUp.value = value;
    showPopUp.refresh();
    return SharedPreferencesHelper.setFirstTimePromoTransporter(value);
  }

  void _setPage(int value) {
    page.value = value;
    page.refresh();
  }

  void doInbetweenLoading(Future<void> Function() callback) async {
    isLoading.value = true;
    await callback?.call();
    isLoading.value = false;
  }

  void onSearchRefreshPullDown() async {
    if (isFetching.isFalse && isLoading.isFalse) {
      _setPage(0);
      await _fetchTransporterPromo();
      if (response.value?.maxHarga != null) {
        if (maxPriceResponseList.isNotEmpty) {
          maxPriceResponseList.clear();
        }
        maxPriceResponseList.add(response.value?.maxHarga);
      }
      if (response.value?.maxQty != null) {
        if (maxQtyResponseList.isNotEmpty) {
          maxQtyResponseList.clear();
        }
        maxQtyResponseList.add(response.value?.maxQty);
      }
    }
    searchRefreshController.refreshCompleted();
  }

  void onSearchRefreshPullUp() async {
    if (isFetching.isFalse && isLoading.isFalse) {
      _setPage(page.value + 1);
      await _fetchTransporterPromo();
      if (response.value?.maxHarga != null) {
        maxPriceResponseList.add(response.value?.maxHarga);
      }
      if (response.value?.maxQty != null) {
        maxQtyResponseList.add(response.value?.maxQty);
      }
    }
    searchRefreshController.loadComplete();
  }

  void onRefreshPullDown() async {
    if (isFetching.isFalse && isLoading.isFalse) {
      _setPage(0);
      await _fetchTransporterPromo();
      if (response.value?.maxHarga != null) {
        if (maxPriceResponseList.isNotEmpty) {
          maxPriceResponseList.clear();
        }
        maxPriceResponseList.add(response.value?.maxHarga);
      }
      if (response.value?.maxQty != null) {
        if (maxQtyResponseList.isNotEmpty) {
          maxQtyResponseList.clear();
        }
        maxQtyResponseList.add(response.value?.maxQty);
      }
    }
    refreshController.refreshCompleted();
  }

  void onRefreshPullUp() async {
    if (isLoading.isFalse && isFetching.isFalse) {
      _setPage(page.value + 1);
      await _fetchTransporterPromo();
      if (response.value?.maxHarga != null) {
        maxPriceResponseList.add(response.value?.maxHarga);
      }
      if (response.value?.maxQty != null) {
        maxQtyResponseList.add(response.value?.maxQty);
      }
    }
    refreshController.loadComplete();
  }

  int get offset => page.value * limit;

  Future<void> onTapPromoCondition({@required int idPromo}) async {
    onTooltipClose();
    onDetailTooltipClose();
    Get.bottomSheet(
      const ZoPromoTransporterSheetPromoCondition(isLoading: true),
      shape: ZoPromoTransporterSheetPromoCondition.getShape(),
      backgroundColor:
          ZoPromoTransporterSheetPromoCondition.getBackgroundColor(),
      isScrollControlled: true,
    );

    var result = '';

    try {
      result = await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      ).fetchTransporterPromoCondition(
        loginAS: loginASval.value,
        roleProfile: GlobalVariable.role,
        idPromo: idPromo,
        searchId: response.value?.searchId,
      );
    } catch (e) {
      result = "GlobalLabelErrorNullResponse".tr;
    }

    if (Get.isBottomSheetOpen) {
      Get.back();
      Get.bottomSheet(
        ZoPromoTransporterSheetPromoCondition(
          conditions: result,
        ),
        shape: ZoPromoTransporterSheetPromoCondition.getShape(),
        backgroundColor:
            ZoPromoTransporterSheetPromoCondition.getBackgroundColor(),
        isScrollControlled: true,
      );
    }
  }

  Future<void> _fetchTransporterPromo({bool reset = false}) async {
    isFetching.value = true;
    final nullResponse = "GlobalLabelErrorNullResponse".tr;

    if (isFilter.isFalse) {
      firstTime = true;
    }
    try {
      debugPrint('_fetchTransporterPromo: ${isLoading.value}');
      isSortEnabled.value = false;
      if (sortMapObs.isEmpty) {
        isSortActive.value = false;
      }
      _hideTooltip();
      response.value = await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      ).fetchTransporterPromoList(
        loginAS: loginASval.value,
        roleProfile: GlobalVariable.role,
        limit: limit,
        offset: offset,
        query: searchQueryObs.value,
        sortMap: sortMapObs,
        isFilter: isFilter.isTrue,
        filter: filterObs,
      );
      debugPrint('${response?.value?.data}');

      if ((response?.value?.message?.code ?? 0) != 200) {
        rangePrice.value = RangeValues(
          math.max(0, rangePrice.value?.start ?? 0),
          math.max(
            1500,
            math.max(
              rangePrice.value?.end ?? 0,
              response?.value?.maxHarga?.toDouble() ?? 0,
            ),
          ),
        );
        rangePrice.refresh();
        rangePriceStart.value.text =
            formatThousand(rangePrice.value.start.toInt());
        rangePriceEnd.value.text = formatThousand(rangePrice.value.end.toInt());
        rangeQty.value = RangeValues(
          math.max(0, rangeQty.value?.start ?? 0),
          math.max(
            1500,
            math.max(
              rangeQty.value?.end ?? 0,
              response?.value?.maxQty?.toDouble() ?? 0,
            ),
          ),
        );
        rangeQty.refresh();
        rangeQtyStart.value.text = formatThousand(rangeQty.value.start.toInt());
        rangeQtyEnd.value.text = formatThousand(rangeQty.value.end.toInt());

        isFetching.value = false;
        CustomToast.show(
          context: Get.context,
          sizeRounded: GlobalVariable.ratioWidth(Get.context) * 6,
          message: nullResponse + ' ${response?.value?.message?.text ?? ''}',
        );
        promoData.clear();
        return;
      }

      if (page.value == 0) {
        promoData.clear();
      }
      promoData.addAll(response?.value?.data ?? []);
      promoSupportingData.value = response?.value?.supportingData;

      if (sortMapObs.isEmpty) {
        promoData.forEach((datum) {
          datum.detail.sort((a, b) {
            return a.promoPriceInt == null
                ? 1
                : b.promoPriceInt == null
                    ? -1
                    : a.promoPriceInt.compareTo(b.promoPriceInt);
          });
        });
      }

      sortMapObs.forEach((key, value) {
        promoData.forEach((datum) {
          datum.detail.sort((a, b) {
            ZoPromoTransporterDetailModel first;
            ZoPromoTransporterDetailModel second;

            if (value == 'ASC') {
              first = a;
              second = b;
            } else {
              first = b;
              second = a;
            }

            debugPrint('debug-sort: $key $value');

            if (key == 'truck_qty') {
              debugPrint(
                  'debug-sort: ${first.truckQty}, ${second.truckQty} : ${first.truckQty.compareTo(second.truckQty)}');
              return first.truckQty == null
                  ? 1
                  : second.truckQty == null
                      ? -1
                      : first.truckQty.compareTo(second.truckQty);
            } else if (key == 'promo_price') {
              debugPrint(
                  'debug-sort: ${first.promoPriceInt}, ${second.promoPriceInt} : ${first.promoPriceInt.compareTo(second.promoPriceInt)}');
              return first.promoPriceInt == null
                  ? 1
                  : second.promoPriceInt == null
                      ? -1
                      : first.promoPriceInt.compareTo(second.promoPriceInt);
            } else if (key == 'max_capacity') {
              debugPrint(
                  'debug-sort: ${first.maxCapacity}, ${second.maxCapacity} : ${first.maxCapacity.compareTo(second.maxCapacity)}');
              var firstCapacityUnit =
                  first.capacityUnit?.trim()?.toLowerCase() ?? 'ton';
              var secondCapacityUnit =
                  second.capacityUnit?.trim()?.toLowerCase() ?? 'ton';

              double firstCapacityInLiter;
              if (first.maxCapacity != null) {
                firstCapacityInLiter = (first.maxCapacity ?? 0) *
                    (['ton', 'm3'].contains(firstCapacityUnit) ? 1000 : 1);
              }

              double secondCapacityInLiter;
              if (second.maxCapacity != null) {
                secondCapacityInLiter = (second.maxCapacity ?? 0) *
                    (['ton', 'm3'].contains(secondCapacityUnit) ? 1000 : 1);
              }

              return firstCapacityInLiter == null
                  ? 1
                  : secondCapacityInLiter == null
                      ? -1
                      : firstCapacityInLiter.compareTo(secondCapacityInLiter);
            } else {
              return -1;
            }
          });
        });
      });

      promoData.refresh();

      debugPrint(promoData.toString());

      final noLimitCount = promoSupportingData.value.noLimitCount;
      final limitCount = promoSupportingData.value.limitCount;
      final accumulated = limitCount + offset;

      // debugPrint('ZoPromoTransporterController-${hasMore.value} = $noLimitCount > $accumulated');
      // debugPrint('ZoPromoTransporterController-${hasMore.value} = $noLimitCount > $accumulated');

      hasMore.value = noLimitCount > accumulated;

      if (promoData.isNotEmpty) {
        isSortEnabled.value = true;
      }
      isFetching.value = false;
    } catch (e) {
      isFetching.value = false;
      CustomToast.show(
        context: Get.context,
        sizeRounded: GlobalVariable.ratioWidth(Get.context) * 6,
        message: nullResponse + ' $e',
      );
    }
    isFetching.value = false;
    if (maxPriceResponseList.isEmpty && response.value?.maxHarga != null) {
      maxPriceResponseList.add(response.value?.maxHarga);
    }
    if (maxQtyResponseList.isEmpty && response.value?.maxQty != null) {
      maxQtyResponseList.add(response.value?.maxQty);
    }
  }

  void onPopUpClose() async {
    await _setIsFirstTimer(false);
  }

  void onTapDetail(int index) async {
    onTooltipClose();
    onDetailTooltipClose();
    Get.to(() => ZoPromoTransporterDetailView(data: promoData[index]));
    doInbetweenPromoConditionLoading(
      () async => _fetchPromoCondition(promoData[index].key.id),
    );
  }

  void doInbetweenPromoConditionLoading(
      Future<void> Function() callback) async {
    isLoadingPromoConditionDetail.value = true;
    await callback?.call();
    isLoadingPromoConditionDetail.value = false;
  }

  Future<void> _fetchPromoCondition(int idPromo) async {
    var result = '';
    var nullResult = "GlobalLabelErrorNullResponse".tr;

    try {
      result = await ApiHelper(
        context: Get.context,
        isShowDialogLoading: false,
        isShowDialogError: false,
      ).fetchTransporterPromoCondition(
        loginAS: loginASval.value,
        roleProfile: GlobalVariable.role,
        idPromo: idPromo,
      );
    } catch (e) {
      result = '$e';
    }

    result = result.isEmpty ? nullResult : result;

    if (result == nullResult) {
      promoConditionDetail.value = null;
    } else {
      promoConditionDetail.value = result;
    }
  }

  Future<void> showContactBottomSheet(int transporterId) async {
    Get.bottomSheet(
      const ZoPemenangLelangContactBottomSheet(isLoading: true),
      shape: ZoPemenangLelangContactBottomSheet.getShape(),
      backgroundColor: ZoPemenangLelangContactBottomSheet.getBackgroundColor(),
      isScrollControlled: true,
    );

    var response = await ApiHelper(
      context: Get.context,
      isShowDialogLoading: false,
      isShowDialogError: false,
    ).fetchTransporterContact(transporterId);

    if (Get.isBottomSheetOpen) {
      Get.back();
      if (response == null) {
        GlobalAlertDialog.showDialogError(
          context: Get.context,
          message: "GlobalLabelErrorNullResponse".tr,
        );
      } else if (response.message.code == 200) {
        Get.bottomSheet(
          ZoPemenangLelangContactBottomSheet(contact: response.data),
          shape: ZoPemenangLelangContactBottomSheet.getShape(),
          backgroundColor:
              ZoPemenangLelangContactBottomSheet.getBackgroundColor(),
          isScrollControlled: true,
        );
      } else if (response.message.code == 403) {
        GlobalAlertDialog.showDialogError(
          message: 'GlobalLabelErrorFalseTokenApp'.tr,
          context: Get.context,
          onTapPriority1: () => LoginFunction().signOut(),
        );
      }
    }
  }

  final searchTextEditingController = TextEditingController().obs;
  final rangeStartDate = TextEditingController().obs;
  final rangeEndDate = TextEditingController().obs;
  final isShowClearSearch = false.obs;

  final panjang = TextEditingController().obs;
  final lebar = TextEditingController().obs;
  final tinggi = TextEditingController().obs;
  final rangeCapacityStart = TextEditingController().obs;
  final rangeCapacityEnd = TextEditingController().obs;

  var listFilterLokasiPickup = [].obs;
  var filterLokasiPickup = [].obs;
  var tempFilterLokasiPickup = [].obs;
  var getListFilterLokasiPickup = false.obs;
  var pickupFetchResult = [].obs;

  var listFilterLokasiDestinasi = [].obs;
  var filterLokasiDestinasi = [].obs;
  var tempFilterLokasiDestinasi = [].obs;
  var getListFilterLokasiDestinasi = false.obs;
  var destinationFetchResult = [].obs;

  var listFilterJenisTruck = [].obs;
  var filterJenisTruck = [].obs;
  var tempFilterJenisTruck = [].obs;
  var getListFilterJenisTruck = false.obs;

  var listFilterJenisTruckimg = [].obs;
  var tempFilterJenisTruckimg = [].obs;

  var listFilterJenisCarrier = [].obs;
  var filterJenisCarrier = [].obs;
  var tempFilterJenisCarrier = [].obs;
  var getListFilterJenisCarrier = false.obs;

  var listFilterJenisCarrierimg = [].obs;
  var tempFilterJenisCarrierimg = [].obs;

  var totalAll = 0.obs;

  var listTransporter = <ZoTransporterFreeModel>[].obs;
  var tempTransporter = <ZoTransporterFreeModel>[].obs;
  var getListFilterTransporter = false.obs;

  var listDataNotifikasi = [].obs;
  var listStatus = [
    {"id": 1, "val": ZoPromoTransporterStrings.filterPaymentOption1.tr},
    {"id": 2, "val": ZoPromoTransporterStrings.filterPaymentOption2.tr},
    {"id": 3, "val": ZoPromoTransporterStrings.filterPaymentOption3.tr},
    {"id": 4, "val": ZoPromoTransporterStrings.filterPaymentOption4.tr},
    {"id": 5, "val": ZoPromoTransporterStrings.filterPaymentOption5.tr},
  ].obs;
  var tempPayment = [].obs;

  var firstTime = true;
  var failedGetListFilter = false.obs;
  var limitWrap = 5;
  var langTemp = "";

  var isFilter = false.obs;
  var isFilterHistory = false.obs;
  var issort = false.obs;
  var issortHistory = false.obs;

  var isLoadingFilter = true.obs;
  final listChoosen = {}.obs;

  var limitTransporterView = 3;

  DateTime inisialDateEnd = DateTime.now();
  DateTime inisialDateStart = DateTime.now();

  var isSearchAktifOrHistory = "aktif".obs;
  var lengthPickup = [].obs;
  var lengthDestinasi = [].obs;
  var lengthPickupHistory = [].obs;
  var lengthDestinasiHistory = [].obs;

  void filterAction() {
    filterObs.clear();

    filterObs.value = {
      'period_start': '',
      'period_end': '',
      'min_capacity': '',
      'max_capacity': '',
      'min_harga': '',
      'max_harga': '',
      'capacity_unit': '',
      'width': '',
      'length': '',
      'height': '',
      'dimension_unit': '',
      'qty_min': '',
      'qty_max': '',
      'head_id': [],
      'carrier_id': [],
      'pickup_location_id': [],
      'destination_location_id': [],
      'payment': [],
      'transporter': [],
    };
    isFilter.value = false;

    String startcreatedatetxt = "";
    String endcreatedatetxt = "";
    final tempFilter = <String, dynamic>{};

    if (rangeStartDate.value.text != "" && rangeEndDate.value.text != "") {
      var startcreateddate = rangeStartDate.value.text.split("/");
      var endcreateddate = rangeEndDate.value.text.split("/");
      startcreatedatetxt =
          "${startcreateddate[2]}-${startcreateddate[1]}-${startcreateddate[0]}";
      endcreatedatetxt =
          "${endcreateddate[2]}-${endcreateddate[1]}-${endcreateddate[0]}";
      // if (type == "aktif") {
      tempFilter.addAll({
        'period_start': startcreatedatetxt,
        'period_end': endcreatedatetxt,
      });
      // tempFilter['period_start'] = startcreatedatetxt;
      // tempFilter['period_end'] = endcreatedatetxt;
      filterObs['period_start'] = startcreatedatetxt;
      filterObs['period_end'] = endcreatedatetxt;
      isFilter.value = true;
      // filterObs.refresh();
      // debugPrint('debug-result-startcreatedatetxt: $startcreatedatetxt');
      // debugPrint('debug-result-endcreatedatetxt: $endcreatedatetxt');
      debugPrint('debug-result-tempFilter-period_start_end: $tempFilter');
      debugPrint('debug-result-filterObs-period_start_end: $filterObs');
      // }
      // if (type == "history") {
      //   isFilterHistory.value = true;
      // }
    }

    if (rangeCapacityStart.value.text != "" &&
        rangeCapacityEnd.value.text != "") {
      // final minCapacity =
      //     double.tryParse(rangeCapacityStart.value.text.replaceAll('.', ''))
      //         ?.toInt();
      // final maxCapacity =
      //     double.tryParse(rangeCapacityEnd.value.text.replaceAll('.', ''))
      //         ?.toInt();
      final minCapacity =
          tryParseFormattedDouble(rangeCapacityStart.value.text);

      final maxCapacity = tryParseFormattedDouble(rangeCapacityEnd.value.text);

      if (minCapacity != null && maxCapacity != null) {
        filterObs['min_capacity'] = minCapacity.toString();
        filterObs['max_capacity'] = maxCapacity.toString();
        filterObs['capacity_unit'] = _selectedCapacityUnit.value;
        isFilter.value = true;
      }
      // filterObs.refresh();
      debugPrint('debug-result-filterObs-min_max_capacity: $filterObs');
      // if (type == "aktif") {
      // }
      // if (type == "history") {
      //   isFilterHistory.value = true;
      // }
    }

    var jenistruk = [];
    if (tempFilterJenisTruck.isNotEmpty) {
      tempFilterJenisTruck.forEach((element) {
        jenistruk.add(element["ID"]);
      });
      filterObs['head_id'] = jenistruk;
      // if (type == "aktif") {
      isFilter.value = true;
      // filterObs.refresh();
      debugPrint('debug-result-filterObs-head_id: $filterObs');
      // }
      // if (type == "history") {
      //   isFilterHistory.value = true;
      // }
    }

    var jeniscarriertruk = [];
    if (tempFilterJenisCarrier.isNotEmpty) {
      tempFilterJenisCarrier.forEach((element) {
        jeniscarriertruk.add(element["ID"]);
      });
      filterObs['carrier_id'] = jeniscarriertruk;
      // if (type == "aktif") {
      isFilter.value = true;
      // filterObs.refresh();
      debugPrint('debug-result-filterObs-carrier_id: $filterObs');
      // }
      // if (type == "history") {
      //   isFilterHistory.value = true;
      // }
    }

    var listProvinci = [];
    if (tempFilterLokasiPickup.isNotEmpty) {
      filterObs['pickup_location_id'] = pickupFetchResult
          .where((e) => tempFilterLokasiPickup.contains(e['City']))
          .map((e) => e['CityID'])
          .toList();
      // tempFilterLokasiPickup.map((element) => element['']);
      // if (type == "aktif") {
      isFilter.value = true;
      // filterObs.refresh();
      debugPrint('debug-result-filterObs-pickup_location_id: $filterObs');
      // }
      // if (type == "history") {
      //   isFilterHistory.value = true;
      // }
    }

    if (tempFilterLokasiDestinasi.isNotEmpty) {
      filterObs['destination_location_id'] = destinationFetchResult
          .where((e) => tempFilterLokasiDestinasi.contains(e['City']))
          .map((e) => e['CityID'])
          .toList();
      // if (type == "aktif") {
      isFilter.value = true;
      // }
      // if (type == "history") {
      //   isFilterHistory.value = true;
      // }
    }

    if (tempTransporter.isNotEmpty) {
      final list =
          tempTransporter.map((element) => element.transporterId).toList();
      filterObs['transporter'] = list;
      // if (type == "aktif") {
      isFilter.value = true;
      filterObs.refresh();
      debugPrint('debug-result-filterObs-transporter_id: $filterObs');
      // }
      // if (type == "history") {
      //   isFilterHistory.value = true;
      // }
    }

    String dimensi = "";

    if (panjang.value.text != "") {
      filterObs['length'] =
          tryParseFormattedDouble(panjang.value.text)?.toString() ?? '';
      filterObs['dimension_unit'] = _selectedDimensionUnit.value;
      isFilter.value = true;
      filterObs.refresh();
    }
    if (lebar.value.text != "") {
      filterObs['width'] =
          tryParseFormattedDouble(lebar.value.text)?.toString() ?? '';
      filterObs['dimension_unit'] = _selectedDimensionUnit.value;
      isFilter.value = true;
      filterObs.refresh();
    }
    if (tinggi.value.text != "") {
      filterObs['height'] =
          tryParseFormattedDouble(tinggi.value.text)?.toString() ?? '';
      filterObs['dimension_unit'] = _selectedDimensionUnit.value;
      isFilter.value = true;
      filterObs.refresh();
    }

    // if (panjang.value.text != "" &&
    //     lebar.value.text != "" &&
    //     tinggi.value.text != "") {
    //   dimensi = panjang.value.text +
    //       ",00*_*_*" +
    //       lebar.value.text +
    //       ",00*_*_*" +
    //       tinggi.value.text +
    //       ",00 " +
    //       _selectedDimensionUnit.value;
    //   filterObs['length'] =
    //       tryParseFormattedDouble(panjang.value.text)?.toString() ?? '';
    //   filterObs['width'] =
    //       tryParseFormattedDouble(lebar.value.text)?.toString() ?? '';
    //   filterObs['height'] =
    //       tryParseFormattedDouble(tinggi.value.text)?.toString() ?? '';
    //   filterObs['dimension_unit'] = _selectedDimensionUnit.value;
    //   // if (type == "aktif") {
    //   isFilter.value = true;
    //   filterObs.refresh();
    //   debugPrint('debug-result-filterObs-dimensision: $filterObs');
    //   // }
    //   // if (type == "history") {
    //   //   isFilterHistory.value = true;
    //   // }
    // }

    if (tempPayment.isNotEmpty) {
      filterObs['payment'] = tempPayment;
      isFilter.value = true;
    }

    if (rangePriceStart.value.text != "" && rangePriceEnd.value.text != "") {
      final minHarga =
          double.tryParse(rangePriceStart.value.text.replaceAll('.', ''))
              ?.toInt();
      final maxHarga =
          double.tryParse(rangePriceEnd.value.text.replaceAll('.', ''))
              ?.toInt();
      if (minHarga != null && maxHarga != null) {
        filterObs['min_harga'] = '$minHarga';
        filterObs['max_harga'] = '$maxHarga';
        if (isFilter.isFalse) {
          if (minHarga != 0 || maxHarga != maxPrice.value.toInt()) {
            isFilter.value = true;
          }
        }
      }
      // filterObs.refresh();
      debugPrint('debug-result-filterObs-min_max_harga: $filterObs');
      // if (type == "aktif") {
      // }
      // if (type == "history") {
      //   isFilterHistory.value = true;
      // }
    }

    if (rangeQtyStart.value.text != "" && rangeQtyEnd.value.text != "") {
      final qtyStart =
          double.tryParse(rangeQtyStart.value.text.replaceAll('.', ''))
              ?.toInt();
      final qtyEnd =
          double.tryParse(rangeQtyEnd.value.text.replaceAll('.', ''))?.toInt();
      if (qtyStart != null && qtyEnd != null) {
        filterObs['qty_min'] = '$qtyStart';
        filterObs['qty_max'] = '$qtyEnd';
        if (isFilter.isFalse) {
          if (qtyStart != 0 || qtyEnd != maxQty.value.toInt()) {
            isFilter.value = true;
          }
        }
      }
      // filterObs.refresh();
      debugPrint('debug-result-filterObs-min_max_capacity: $filterObs');
      // if (type == "aktif") {
      // }
      // if (type == "history") {
      //   isFilterHistory.value = true;
      // }
    }

    debugPrint('debug-filter-isFilter: ${isFilter.value}');

    // String vol = "";
    // if (rangeCapacityStart.value.text != "") {
    //   vol = rangeCapacityStart.value.text + " " + _selectedsatuanvolume.value;
    //   // if (type == "aktif") {
    //   isFilter.value = true;
    //   // }
    //   // if (type == "history") {
    //   //   isFilterHistory.value = true;
    //   // }
    // }

    if (
        // startdatetxt == "" &&
        //   enddatetxt == "" &&
        startcreatedatetxt == "" &&
            endcreatedatetxt == "" &&
            // startpickupdatetxt == "" &&
            // endpickupdatetxt == "" &&
            // startdestinasidatetxt == "" &&
            // enddestinasidatetxt == "" &&
            rangePriceStart.value.text == "" &&
            rangePriceEnd.value.text == "" &&
            rangeQtyStart.value.text == "" &&
            rangeQtyEnd.value.text == "" &&
            tempFilterJenisTruck.isEmpty &&
            tempFilterJenisCarrier.isEmpty &&
            tempFilterLokasiPickup.isEmpty &&
            tempFilterLokasiDestinasi.isEmpty &&
            tempPayment.isEmpty &&
            dimensi == "" &&
            // vol == "" &&
            tempTransporter.isEmpty) {
      // if (type == "aktif") {
      isFilter.value = false;
      // }
      // if (type == "history") {
      //   isFilterHistory.value = false;
      // }
    }

    // var limit;
    // if (type == "aktif") {
    //   limit = limitAktif.value;
    // }
    // if (type == "history") {
    //   limit = limitHistory.value;
    // }

    // filterObs.clear();
    // filterObs.addAll({
    //   'period_start': startcreatedatetxt,
    //   'period_end': endcreatedatetxt,
    //   'min_capacity': range
    // });

    debugPrint(
        'debug-filter-startDateFilterPeriodeLelangController.value.text: ${rangeStartDate.value.text}');
    debugPrint(
        'debug-filter-endDateFilterPeriodeLelangController.value.text: ${rangeEndDate.value.text}');
    debugPrint(
        'debug-filter-rangePriceStart.value.text: ${rangePriceStart.value.text}');
    debugPrint(
        'debug-filter-rangePriceEnd.value.text: ${rangePriceEnd.value.text}');
    debugPrint(
        'debug-filter-rangeQtyStart.value.text: ${rangeQtyStart.value.text}');
    debugPrint(
        'debug-filter-rangeQtyEnd.value.text: ${rangeQtyEnd.value.text}');
    debugPrint('debug-filter-tempFilterJenisTruck: ${tempFilterJenisTruck}');
    debugPrint(
        'debug-filter-tempFilterJenisCarrier: ${tempFilterJenisCarrier}');
    debugPrint(
        'debug-filter-tempFilterLokasiPickup: ${tempFilterLokasiPickup}');
    debugPrint(
        'debug-filter-tempFilterLokasiDestinasi: ${tempFilterLokasiDestinasi}');
    debugPrint('debug-filter-tempTransporter: ${tempFilterLokasiDestinasi}');
    debugPrint('debug-filter-dimensi: ${dimensi}');
    debugPrint('debug-filter-filterObs: $filterObs');
    debugPrint('debug-filter-isFilter: ${isFilter.value}');

    // if (isFilter.isFalse) {
    //   final minHargaTemp = double.tryParse(rangePriceStart.value.text)?.toInt();
    //   final maxHargaTemp = double.tryParse(rangePriceEnd.value.text)?.toInt();
    //   final minQtyTemp = double.tryParse(rangeQtyStart.value.text)?.toInt();
    //   final maxQtyTemp = double.tryParse(rangeQtyEnd.value.text)?.toInt();
    //   bool maxHargaChanged = false;
    //   bool minHargaChanged = false;
    //   bool maxQtyChanged = false;
    //   bool minQtyChanged = false;

    //   if ((maxHargaTemp ?? -1) != maxPrice.value) {
    //     maxHargaChanged = true;
    //   }
    //   if ((minHargaTemp ?? -1) != 0) {
    //     minHargaChanged = true;
    //   }
    //   if ((maxQtyTemp ?? -1) != maxQty.value) {
    //     maxQtyChanged = true;
    //   }
    //   if ((minQtyTemp ?? -1) != 0) {
    //     minQtyChanged = true;
    //   }

    //   if (!maxHargaChanged &&
    //       !minHargaChanged &&
    //       !maxQtyChanged &&
    //       !minQtyChanged) {
    //     _setPage(0);
    //     doInbetweenLoading(() async => await _fetchTransporterPromo());
    //     return;
    //   }
    // }

    // doInbetweenLoading(() async => await _fetchTransporterPromo());
    filterObs.refresh();
    debugPrint('debug-result-filterObs: $filterObs');

    _setPage(0);
    doInbetweenLoading(() async => await _fetchTransporterPromo());
  }

  void getListFilter() {
    langTemp = GlobalVariable.languageType;
    GlobalVariable.languageType = "id_ID";
    getListLokasiPickup();
    getListLokasiDestinasi();
    getListJenisTruck();
    getListJenisCarrierTruck();
    getListTransporter();
  }

  String getNoPrefixName(String text) {
    return text.split(" ").length > 1
        ? text.split(" ").skip(1).join(" ")
        : text;
  }

  String getInitial(String text) {
    var getText = getNoPrefixName(text);
    return getText.substring(0, 1);
    // return "";
  }

  int compareCity(dynamic a, dynamic b) {
    if (a['City'] == null) return 1;
    if (b['City'] == null) return -1;
    // return a['City'].compareTo(b['City']);
    var initialA = getInitial('${a['City']}');
    var initialB = getInitial('${b['City']}');

    var result1 = initialA.compareTo(initialB);
    if (result1 != 0) return result1;

    var nameA = getNoPrefixName('${a['City']}');
    var nameB = getNoPrefixName('${b['City']}');

    var result2 = nameA.compareTo(nameB);
    if (result2 != 0) return result2;

    return nameA.split(' ')[0].compareTo(nameB.split(' ')[0]);
  }

  void getListLokasiPickup() async {
    getListFilterLokasiPickup.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchSearchCity("");
    if (resultCity != null &&
        resultCity["Message"] != null &&
        (resultCity["Message"]["Code"] ?? -1) == 200) {
      listFilterLokasiPickup.clear();
      var list = (resultCity["Data"] as List);
      list.sort(compareCity);
      list.forEach((element) {
        listFilterLokasiPickup.add(element["City"]);
      });
      pickupFetchResult.value = [...list];
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterLokasiPickup.value = false;
    GlobalVariable.languageType = langTemp;
  }

  void getListLokasiDestinasi() async {
    getListFilterLokasiDestinasi.value = true;
    var resultCity = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchSearchCity("");
    if (resultCity != null &&
        resultCity["Message"] != null &&
        (resultCity["Message"]["Code"] ?? -1) == 200) {
      listFilterLokasiDestinasi.clear();
      var list = (resultCity["Data"] as List);
      list.sort(compareCity);
      list.forEach((element) {
        listFilterLokasiDestinasi.add(element["City"]);
      });
      destinationFetchResult.value = [...list];
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterLokasiDestinasi.value = false;
    GlobalVariable.languageType = langTemp;
  }

  void getListJenisTruck() async {
    getListFilterJenisTruck.value = true;
    var resultListHeadTruck = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .listHeadTruck();
    if (resultListHeadTruck != null &&
        resultListHeadTruck["Message"] != null &&
        (resultListHeadTruck["Message"]["Code"] ?? -1) == 200) {
      listFilterJenisTruck.clear();
      listFilterJenisTruckimg.clear();
      var list = (resultListHeadTruck["Data"] as List);
      list.sort((a, b) {
        if (a['Description'] == null) return 1;
        if (b['Description'] == null) return -1;
        return a['Description'].compareTo(b['Description']);
      });
      list.forEach((element) {
        listFilterJenisTruck.add(element["Description"]);
        listFilterJenisTruckimg.add(element);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterJenisTruck.value = false;
    GlobalVariable.languageType = langTemp;
  }

  void getListJenisCarrierTruck() async {
    getListFilterJenisCarrier.value = true;
    var resultListCarrierTruck = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .listCarrierTruck();
    if (resultListCarrierTruck != null &&
        resultListCarrierTruck["Message"] != null &&
        (resultListCarrierTruck["Message"]["Code"] ?? -1) == 200) {
      listFilterJenisCarrier.clear();
      listFilterJenisCarrierimg.clear();
      var list = (resultListCarrierTruck["Data"] as List);
      list.sort((a, b) {
        if (a['Description'] == null) return 1;
        if (b['Description'] == null) return -1;
        return a['Description'].compareTo(b['Description']);
      });
      list.forEach((element) {
        listFilterJenisCarrier.add(element["Description"]);
        listFilterJenisCarrierimg.add(element);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterJenisCarrier.value = false;
    GlobalVariable.languageType = langTemp;
  }

  void getListTransporter() async {
    getListFilterTransporter.value = true;
    var resultTransporter = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchTransporterListFree(query: "", limit: null, offset: 0);

    if (resultTransporter?.isNotEmpty ?? false) {
      listTransporter.clear();
      resultTransporter.forEach((element) {
        listTransporter.add(element);
      });
    } else {
      failedGetListFilter.value = true;
    }
    getListFilterTransporter.value = false;
    GlobalVariable.languageType = langTemp;
  }

  Widget wrapFilterProvinci(List listShow, List listSelected,
      void Function(bool isChoosen, dynamic value) onTapItem) {
    var listNotSelected = List.from(listShow);
    listNotSelected.removeWhere((element) => listSelected.contains(element));
    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 8,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
      children: [
        for (var index = 0;
            index <
                (listSelected.length > limitWrap
                    ? limitWrap
                    : listSelected.length);
            index++)
          itemWrapProvinci(listSelected[index], true, onTapItem),
        for (var index = 0;
            index <
                (listNotSelected.length + listSelected.length <= limitWrap
                    ? listNotSelected.length
                    : limitWrap - listSelected.length);
            index++)
          itemWrapProvinci(listNotSelected[index], false, onTapItem),
      ],
    );
  }

  Widget wrapFilter(List listShow, List listSelected,
      void Function(bool isChoosen, String value) onTapItem) {
    var listNotSelected = List.from(listShow);
    listNotSelected.removeWhere((element) => listSelected.contains(element));
    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 8,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
      children: [
        // for (var index = 0;
        //     index <
        //         (listNotSelected.length <= limitWrap
        //             ? listNotSelected.length
        //             : limitWrap);
        //     index++)
        //   itemWrap(listNotSelected[index],
        //       listSelected.contains(listNotSelected[index]), onTapItem),
        for (var index = 0;
            index <
                (listSelected.length > limitWrap
                    ? limitWrap
                    : listSelected.length);
            index++)
          itemWrap(listSelected[index], true, onTapItem),
        for (var index = 0;
            index <
                (listNotSelected.length + listSelected.length <= limitWrap
                    ? listNotSelected.length
                    : limitWrap - listSelected.length);
            index++)
          itemWrap(listNotSelected[index], false, onTapItem),
      ],
    );
  }

  Widget wrapFilterJenisTrukCarrier(List listShow, List listSelected,
      void Function(bool isChoosen, Map value) onTapItem) {
    var listNotSelected = List.from(listShow);
    listNotSelected.removeWhere((element) => listSelected.contains(element));
    debugPrint('debug-filter-wraptruck-listSelected: $listSelected');
    debugPrint('debug-filter-wraptruck-listNotSelected: $listNotSelected');

    return Wrap(
      spacing: GlobalVariable.ratioWidth(Get.context) * 8,
      runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
      children: [
        // for (var index = 0;
        //     index <
        //         (listNotSelected.length <= limitWrap
        //             ? listNotSelected.length
        //             : limitWrap);
        //     index++)
        // itemWrapJenistruckCarrier(
        //     listNotSelected[index],
        //     listSelected.any((element) =>
        //         element['Description'] ==
        //         listNotSelected[index]['Description']),
        //     onTapItem),
        for (var index = 0;
            index <
                (listSelected.length > limitWrap
                    ? limitWrap
                    : listSelected.length);
            index++)
          itemWrapJenistruckCarrier(listSelected[index], true, onTapItem),
        for (var index = 0;
            index <
                (listNotSelected.length + listSelected.length <= limitWrap
                    ? listNotSelected.length
                    : limitWrap - listSelected.length);
            index++)
          itemWrapJenistruckCarrier(listNotSelected[index], false, onTapItem),
      ],
    );
  }

  Widget itemWrapJenistruckCarrier(Map name, bool isChoosen,
      void Function(bool isChoosen, Map value) onTapItem) {
    debugPrint('itemWrapJenistruckCarrier($name, $isChoosen)');
    double borderRadius = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: 1,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorLightGrey7)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            onTapItem(!isChoosen, name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: CustomText(
              name["Description"],
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  Widget wrapFilterTransporter(List listShow) {
    // var listNotSelected = List.from(listShow);
    // listNotSelected.removeWhere((element) => listSelected.contains(element));

    return Padding(
      padding: EdgeInsets.only(
        top: GlobalVariable.ratioWidth(Get.context) *
            (listShow.isEmpty ? 0 : 12),
      ),
      child: Wrap(
        spacing: GlobalVariable.ratioWidth(Get.context) * 8,
        runSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
        children: [
          if (listShow.length > 5)
            for (var idx = 0; idx < 5; idx++)
              itemWrapTransporter(listShow[idx], idx)
          else
            for (var idx = 0; idx < listShow.length; idx++)
              itemWrapTransporter(listShow[idx], idx),
          if (listShow.length > 5)
            Container(
              // margin: EdgeInsets.symmetric(
              //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
              width: GlobalVariable.ratioWidth(Get.context) * 40,
              height: GlobalVariable.ratioWidth(Get.context) * 22,
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
              constraints: BoxConstraints(
                  minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 22),
                  color: Color(ListColor.color4)),
              child: CustomText("+${listShow.length - 5}",
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget itemWrapTransporter(String name, int idx) {
    double borderRadius = 20;
    return Container(
      constraints: BoxConstraints(
          maxWidth: GlobalVariable.ratioWidth(Get.context) * 190),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(width: 1, color: Color(ListColor.color4)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            tempTransporter.removeWhere((element) => element.name == name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    child: CustomText(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: Color(ListColor.color4),
                    ),
                  ),
                ),
                SizedBox(
                  width: GlobalVariable.ratioFontSize(Get.context) * 4,
                ),
                Icon(
                  Icons.close_rounded,
                  size: GlobalVariable.ratioFontSize(Get.context) * 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemWrapProvinci(dynamic name, bool isChoosen,
      void Function(bool isChoosen, dynamic value) onTapItem) {
    double borderRadius = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: 1,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorLightGrey7)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            onTapItem(!isChoosen, name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: CustomText(
              name["Description"] ?? name["Nama"],
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  Widget itemWrap(String name, bool isChoosen,
      void Function(bool isChoosen, String value) onTapItem) {
    double borderRadius = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(
              width: 1,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorLightGrey7)),
          color: Colors.white),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          onTap: () {
            onTapItem(!isChoosen, name);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                vertical: GlobalVariable.ratioWidth(Get.context) * 4),
            child: CustomText(
              name,
              color: isChoosen
                  ? Color(ListColor.color4)
                  : Color(ListColor.colorDarkBlue2),
            ),
          ),
        ),
      ),
    );
  }

  String rangeStartDateUnapplied = '';
  String rangeEndDateUnapplied = '';

  String rangePriceStartUnapplied = '';
  String rangePriceEndUnapplied = '';
  RangeValues rangePriceUnapplied;

  String rangeCapacityStartUnapplied = '';
  String rangeCapacityEndUnapplied = '';
  String _selectedCapacityUnitUnapplied = '';

  String rangeQtyStartUnapplied = '';
  String rangeQtyEndUnapplied = '';
  RangeValues rangeQtyUnapplied;

  String panjangUnapplied = '';
  String lebarUnapplied = '';
  String tinggiUnapplied = '';
  String _selectedDimensionUnitUnapplied = '';

  final List tempFilterLokasiPickupUnapplied = [];
  final List tempFilterLokasiDestinasiUnapplied = [];
  final List tempFilterJenisTruckUnapplied = [];
  final List tempFilterJenisTruckimgUnapplied = [];
  final List tempFilterJenisCarrierUnapplied = [];
  final List tempFilterJenisCarrierimgUnapplied = [];
  final List<ZoTransporterFreeModel> tempTransporterUnapplied = [];
  final List tempPaymentUnapplied = [];

  String errorTextPriceUnapplied;
  String errorTextCapacityUnapplied;
  String errorTextQtyUnapplied;

  DateTime inisialDateStartUnapplied = DateTime.now();
  DateTime inisialDateEndUnapplied = DateTime.now();

  void applyFields() {
    rangeStartDateUnapplied = rangeStartDate.value.text;
    rangeEndDateUnapplied = rangeEndDate.value.text;

    rangePriceStartUnapplied = rangePriceStart.value.text;
    rangePriceEndUnapplied = rangePriceEnd.value.text;
    rangePriceUnapplied = rangePrice.value;

    rangeCapacityStartUnapplied = rangeCapacityStart.value.text;
    rangeCapacityEndUnapplied = rangeCapacityEnd.value.text;
    _selectedCapacityUnitUnapplied = _selectedCapacityUnit.value;

    panjangUnapplied = panjang.value.text;
    lebarUnapplied = lebar.value.text;
    tinggiUnapplied = tinggi.value.text;
    _selectedDimensionUnitUnapplied = _selectedDimensionUnit.value;

    rangeQtyStartUnapplied = rangeQtyStart.value.text;
    rangeQtyEndUnapplied = rangeQtyEnd.value.text;
    rangeQtyUnapplied = rangeQty.value;

    tempFilterLokasiPickupUnapplied.clear();
    tempFilterLokasiPickupUnapplied.addAll(tempFilterLokasiPickup);

    tempFilterLokasiDestinasiUnapplied.clear();
    tempFilterLokasiDestinasiUnapplied.addAll(tempFilterLokasiDestinasi);

    tempFilterJenisTruckUnapplied.clear();
    tempFilterJenisTruckUnapplied.addAll(tempFilterJenisTruck);
    tempFilterJenisTruckimgUnapplied.clear();
    tempFilterJenisTruckimgUnapplied.addAll(tempFilterJenisTruckimg);

    tempFilterJenisCarrierUnapplied.clear();
    tempFilterJenisCarrierUnapplied.addAll(tempFilterJenisCarrier);
    tempFilterJenisCarrierimgUnapplied.clear();
    tempFilterJenisCarrierimgUnapplied.addAll(tempFilterJenisCarrierimg);

    tempTransporterUnapplied.clear();
    tempTransporterUnapplied.addAll(tempTransporter);

    tempPaymentUnapplied.clear();
    tempPaymentUnapplied.addAll(tempPayment);

    errorTextPriceUnapplied = errorTextPrice.value;
    errorTextCapacityUnapplied = errorTextCapacity.value;
    errorTextQtyUnapplied = errorTextQty.value;

    inisialDateEndUnapplied = inisialDateEnd;
    inisialDateStartUnapplied = inisialDateStart;
  }

  void cancelApplyFields() {
    rangeStartDate.value.text = rangeStartDateUnapplied;
    rangeEndDate.value.text = rangeEndDateUnapplied;

    rangePriceStart.value.text = rangePriceStartUnapplied;
    rangePriceEnd.value.text = rangePriceEndUnapplied;
    rangePrice.value = rangePriceUnapplied;

    rangeCapacityStart.value.text = rangeCapacityStartUnapplied;
    rangeCapacityEnd.value.text = rangeCapacityEndUnapplied;
    _selectedCapacityUnit.value = _selectedCapacityUnitUnapplied;

    panjang.value.text = panjangUnapplied;
    lebar.value.text = lebarUnapplied;
    tinggi.value.text = tinggiUnapplied;
    _selectedDimensionUnit.value = _selectedDimensionUnitUnapplied;

    rangeQtyStart.value.text = rangeQtyStartUnapplied;
    rangeQtyEnd.value.text = rangeQtyEndUnapplied;
    rangeQty.value = rangeQtyUnapplied;

    tempFilterLokasiPickup.clear();
    tempFilterLokasiPickup.addAll(tempFilterLokasiPickupUnapplied);

    tempFilterLokasiDestinasi.clear();
    tempFilterLokasiDestinasi.addAll(tempFilterLokasiDestinasiUnapplied);

    tempFilterJenisTruck.clear();
    tempFilterJenisTruck.addAll(tempFilterJenisTruckUnapplied);
    tempFilterJenisTruckimg.clear();
    tempFilterJenisTruckimg.addAll(tempFilterJenisTruckimgUnapplied);

    tempFilterJenisCarrier.clear();
    tempFilterJenisCarrier.addAll(tempFilterJenisCarrierUnapplied);
    tempFilterJenisCarrierimg.clear();
    tempFilterJenisCarrierimg.addAll(tempFilterJenisCarrierimgUnapplied);

    tempTransporter.clear();
    tempTransporter.addAll(tempTransporterUnapplied);

    tempPayment.clear();
    tempPayment.addAll(tempPaymentUnapplied);

    errorTextPrice.value = errorTextPriceUnapplied;
    errorTextCapacity.value = errorTextCapacityUnapplied;
    errorTextQty.value = errorTextQtyUnapplied;

    errorTextPrice.refresh();
    errorTextCapacity.refresh();
    errorTextQty.refresh();

    inisialDateEnd = inisialDateEndUnapplied;
    inisialDateStart = inisialDateStartUnapplied;
  }

  void resetFilter() {
    FocusManager.instance?.primaryFocus?.unfocus();
    rangeStartDate.value.text = "";
    rangeEndDate.value.text = "";
    rangePriceStart.value.text =
        formatThousand(initialPriceRangeValues.start.toInt());
    rangePriceEnd.value.text =
        formatThousand(initialPriceRangeValues.end.toInt());
    rangePrice.value = initialPriceRangeValues;
    rangeQtyStart.value.text =
        formatThousand(initialQtyRangeValues.start.toInt());
    rangeQtyEnd.value.text = formatThousand(initialQtyRangeValues.end.toInt());
    rangeQty.value = initialQtyRangeValues;
    tempFilterLokasiPickup.clear();
    tempFilterLokasiDestinasi.clear();
    tempFilterJenisTruck.clear();
    tempFilterJenisTruckimg.clear();
    tempFilterJenisCarrier.clear();
    tempFilterJenisCarrierimg.clear();
    tempTransporter.clear();
    tempPayment.clear();
    panjang.value.text = "";
    lebar.value.text = "";
    tinggi.value.text = "";
    _selectedDimensionUnit.value = "m";
    rangeCapacityStart.value.text = "";
    rangeCapacityEnd.value.text = "";
    _selectedCapacityUnit.value = "Ton";
    errorTextPrice.value = null;
    errorTextQty.value = null;
    errorTextCapacity.value = null;
    errorTextCapacity.refresh();
    errorTextQty.refresh();
    errorTextPrice.refresh();
    inisialDateStart = DateTime.now();
    inisialDateEnd = inisialDateStart;
    filterObs.clear();
  }

  var _selectedDimensionUnit = "m".obs;
  List _listSatuanDimensi = ["m", "cm"];

  List<DropdownMenuItem> buildDropdownSatuanDimensi(List _listSatuanDimensi) {
    List<DropdownMenuItem> items = [];
    for (var i in _listSatuanDimensi) {
      items.add(DropdownMenuItem(
        value: i,
        child: CustomText(i,
            fontWeight: FontWeight.w600,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            color: Color(ListColor.colorLightGrey4)),
      ));
    }
    return items;
  }

  List<DropdownMenuItem> _dropdownSatuanDimensi = [];

  onChangeDropdownSatuanDimensi(select) {
    _selectedDimensionUnit.value = select;
  }

  var _selectedCapacityUnit = "Ton".obs;
  var _listSatuanVolume = <String>["Ton", "Liter"];

  List<DropdownMenuItem> buildDropdownSatuanVolume(List _listSatuanVolume) {
    List<DropdownMenuItem> items = [];
    for (var i in _listSatuanVolume) {
      items.add(DropdownMenuItem(
        value: i,
        child: CustomText(i,
            fontWeight: FontWeight.w600,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            color: Color(ListColor.colorLightGrey4)),
      ));
    }
    return items;
  }

  List<DropdownMenuItem> _dropdownSatuanVolume = [];

  onChangeDropdownSatuanVolume(select) {
    _selectedCapacityUnit.value = select;
  }

  var initialPriceRangeValues = RangeValues(0, 1500);
  var initialQtyRangeValues = RangeValues(0, 1500);

  void showFilter() async {
    var maxInPriceList = maxPriceResponseList.isEmpty
        ? null
        : maxPriceResponseList.reduce(math.max);
    var maxInQtyList =
        maxQtyResponseList.isEmpty ? null : maxQtyResponseList.reduce(math.max);

    maxPrice.value = math.max(maxPrice.value, maxInPriceList ?? 1500);
    maxQty.value = math.max(maxQty.value, maxInQtyList ?? 1500);
    // maxPrice.value =
    //     math.max(maxPrice.value, response?.value?.maxHarga ?? 1500);
    // maxQty.value = math.max(maxQty.value, response?.value?.maxQty ?? 1500);
    // tempFilterLokasiPickup.value = List.from(filterLokasiPickup.value);
    // tempFilterLokasiDestinasi.value = List.from(filterLokasiDestinasi.value);
    // tempFilterProvince.value = List.from(filterProvince.value);
    if (firstTime || failedGetListFilter.value) {
      failedGetListFilter.value = false;
      getListFilter();
      rangePrice.value = RangeValues(0, maxPrice.value.toDouble());
      initialPriceRangeValues = rangePrice.value;
      rangePriceStart.value.text = '0';
      rangePriceEnd.value.text = formatThousand(rangePrice.value.end.toInt());

      rangeQty.value = RangeValues(0, maxQty.value.toDouble());
      initialQtyRangeValues = rangeQty.value;
      rangeQtyStart.value.text = '0';
      rangeQtyEnd.value.text = formatThousand(rangeQty.value.end.toInt());

      resetFilter();
      applyFields();
    } else {
      if (rangePrice.value.end > maxPrice.value) {
        rangePrice.value =
            RangeValues(rangePrice.value.start, maxPrice.value.toDouble());
        initialPriceRangeValues = rangePrice.value;
        rangePriceEnd.value.text = formatThousand(rangePrice.value.end.toInt());
      }
      if (rangeQty.value.end > maxQty.value) {
        rangeQty.value =
            RangeValues(rangeQty.value.start, maxQty.value.toDouble());
        initialQtyRangeValues = rangeQty.value;
        rangeQtyEnd.value.text = formatThousand(rangeQty.value.end.toInt());
      }
    }
    firstTime = false;

    var isApplied = await showModalBottomSheet<bool>(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(Get.context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 4,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 16),
                  height: GlobalVariable.ratioWidth(Get.context) * 3,
                  width: GlobalVariable.ratioWidth(Get.context) * 38,
                  color: Color(ListColor.colorLightGrey16),
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 16,
                        right: GlobalVariable.ratioWidth(Get.context) * 16,
                        bottom: GlobalVariable.ratioWidth(Get.context) * 20),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: CustomText("GlobalFilterTitle".tr,
                                fontWeight: FontWeight.w700,
                                color: Color(ListColor.color4),
                                fontSize:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        14)),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              cancelApplyFields();
                              Get.back();
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/ic_close_simple.svg",
                                color: Color(ListColor.colorBlack),
                                width:
                                    GlobalVariable.ratioFontSize(context) * 24,
                                height:
                                    GlobalVariable.ratioFontSize(context) * 24,
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => !failedGetListFilter.value &&
                                  !getListFilterLokasiPickup.value &&
                                  !getListFilterLokasiDestinasi.value &&
                                  !getListFilterJenisTruck.value &&
                                  !getListFilterJenisCarrier.value &&
                                  !getListFilterTransporter.value
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        child: CustomText(
                                          "GlobalFilterButtonReset".tr,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(ListColor.color4),
                                        ),
                                        onTap: () {
                                          resetFilter();
                                        }),
                                  ),
                                )
                              : SizedBox.shrink(),
                        )
                      ],
                    )),
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(Get.context).size.height - 200,
                        minHeight: 0,
                        minWidth: double.infinity),
                    child: Obx(
                      () => getListFilterLokasiPickup.value ||
                              getListFilterLokasiDestinasi.value ||
                              getListFilterJenisTruck.value ||
                              getListFilterJenisCarrier.value ||
                              getListFilterTransporter.value
                          ? Container(
                              width: MediaQuery.of(Get.context).size.width,
                              height: 200,
                              child: Center(
                                  child: Container(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator())))
                          : !failedGetListFilter.value
                              ? (listFilterLokasiPickup.isNotEmpty ||
                                      listFilterLokasiDestinasi.isNotEmpty)
                                  ? ListView(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            GlobalVariable.ratioWidth(context) *
                                                16,
                                      ),
                                      shrinkWrap: true,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    ZoPromoTransporterStrings
                                                        .filterPeriode.tr,
                                                    fontSize: GlobalVariable
                                                            .ratioFontSize(
                                                                Get.context) *
                                                        14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ],
                                            ),
                                            Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12),
                                            _formFilterDate(),
                                          ],
                                        ),
                                        _listseparator(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    ZoPromoTransporterStrings
                                                        .filterPrice.tr,
                                                    fontSize: GlobalVariable
                                                            .ratioFontSize(
                                                                Get.context) *
                                                        14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ],
                                            ),
                                            Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12),
                                            _formFilterRangePrice()
                                          ],
                                        ),
                                        _listseparator(),
                                        _formFilterCapacity(),
                                        _listseparator(),
                                        _formFilterMinDimension(),
                                        _listseparator(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    ZoPromoTransporterStrings
                                                        .filterQuota.tr,
                                                    fontSize: GlobalVariable
                                                            .ratioFontSize(
                                                                Get.context) *
                                                        14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ],
                                            ),
                                            Container(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        12),
                                            _formFilterRangeTruckQty()
                                            // _formFilterRangeHarga(
                                            //     "jumlahKoli")
                                          ],
                                        ),
                                        _listseparator(),
                                        _formFilterLokasiPickUp(),
                                        _listseparator(),
                                        _formFilterLokasiDestinasi(),
                                        _listseparator(),
                                        _formFilterJenisTruck(),
                                        _listseparator(),
                                        _formFilterJenisCarrier(),
                                        _listseparator(),
                                        _formFilterTransporter(),
                                        _listseparator(),
                                        _formFilterStatus(),
                                        SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  context) *
                                              24,
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink()
                              : Container(
                                  width: MediaQuery.of(Get.context).size.width,
                                  height: 200,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 10),
                                        CustomText(
                                          'GlobalLabelErrorNullResponse'.tr,
                                          textAlign: TextAlign.center,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  14,
                                        ),
                                        SizedBox(height: 10),
                                        GestureDetector(
                                            onTap: () {
                                              failedGetListFilter.value = false;
                                              getListFilter();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: CustomText(
                                                'GlobalButtonTryAgain'.tr,
                                                fontSize: GlobalVariable
                                                        .ratioFontSize(
                                                            Get.context) *
                                                    14,
                                                color: Color(ListColor.color4),
                                              ),
                                            ))
                                      ])),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 12,
                      GlobalVariable.ratioWidth(context) * 16,
                      GlobalVariable.ratioWidth(context) * 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -3),
                          color: Color(ListColor.colorBlack).withOpacity(0.161),
                          spreadRadius: 0,
                          blurRadius: 55,
                        ),
                      ]),
                  child: Row(
                    children: [
                      Expanded(child: _buttonPrioritySecondary()),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(context) * 8,
                      ),
                      Expanded(child: _buttonPriorityPrimary()),
                    ],
                  ),
                )
              ],
            ),
          ));
        });
    debugPrint('debug-filter-isApplied: $isApplied');
    if (isApplied == null || !isApplied) {
      cancelApplyFields();
    }
  }

  bool get isEnabled {
    // if (panjang.value.text.isNotEmpty) {
    //   if (lebar.value.text.isEmpty || tinggi.value.text.isEmpty) {
    //     return false;
    //   }
    // }
    // if (lebar.value.text.isNotEmpty) {
    //   if (panjang.value.text.isEmpty || tinggi.value.text.isEmpty) {
    //     return false;
    //   }
    // }
    // if (tinggi.value.text.isNotEmpty) {
    //   if (panjang.value.text.isEmpty || lebar.value.text.isEmpty) {
    //     return false;
    //   }
    // }

    if ((rangeStartDate.value.text.isNotEmpty &&
            rangeEndDate.value.text.isEmpty) ||
        (rangeStartDate.value.text.isEmpty &&
            rangeEndDate.value.text.isNotEmpty)) {
      return false;
    }
    if ((rangePriceStart.value.text.isNotEmpty &&
            rangePriceEnd.value.text.isEmpty) ||
        (rangePriceEnd.value.text.isNotEmpty &&
            rangePriceStart.value.text.isEmpty)) {
      return false;
    }
    if ((rangeQtyStart.value.text.isNotEmpty &&
            rangeQtyEnd.value.text.isEmpty) ||
        (rangeQtyEnd.value.text.isNotEmpty &&
            rangeQtyStart.value.text.isEmpty)) {
      return false;
    }
    if ((rangeCapacityStart.value.text.isNotEmpty &&
            rangeCapacityEnd.value.text.isEmpty) ||
        (rangeCapacityEnd.value.text.isNotEmpty &&
            rangeCapacityStart.value.text.isEmpty)) {
      return false;
    }
    debugPrint(
        'debug-filter-isEnabled: [${(errorTextCapacity.value == null && errorTextPrice.value == null && errorTextQty.value == null)}]');

    return errorTextCapacity.value == null &&
        errorTextPrice.value == null &&
        errorTextQty.value == null;
  }

  Widget _buttonPriorityPrimary() {
    return Obx(
      () => OutlinedButton(
        style: OutlinedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Color(
            !isEnabled ? ListColor.colorLightGrey2 : ListColor.color4,
          ),
          side: BorderSide(
            width: 2,
            color: Color(
              !isEnabled ? ListColor.colorLightGrey2 : ListColor.color4,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        onPressed: isEnabled
            ? () {
                Get.back(result: true);
                applyFields();
                filterAction();
              }
            : null,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Stack(alignment: Alignment.center, children: [
            CustomText(
              "LelangMuatBuatLelangBuatLelangLabelTitleSave".tr,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buttonPrioritySecondary() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Colors.white,
          side: BorderSide(width: 2, color: Color(ListColor.color4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )),
      onPressed: () {
        Get.back();
        cancelApplyFields();
        // resetFilter();
        // if (!disableGetBack) Get.back();
        // if (onTapPriority != null) onTapPriority();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Stack(alignment: Alignment.center, children: [
          CustomText("LelangMuatTabAktifTabAktifLabelTitleCancelFilter".tr,
              fontWeight: FontWeight.w600,
              color: Color(ListColor.color4),
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 12),
        ]),
      ),
    );
  }

  _listseparator() {
    return Container(
        height: 0.5,
        color: Color(ListColor.colorLightGrey10),
        margin: EdgeInsets.only(
            top: GlobalVariable.ratioWidth(Get.context) * 20,
            bottom: GlobalVariable.ratioWidth(Get.context) * 20));
  }

  _formFilterDate() {
    var isStartController;
    var isEndController;
    isStartController = rangeStartDate.value;
    isEndController = rangeEndDate.value;

    var border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Color(ListColor.colorLightGrey19), width: 1.0),
      borderRadius: BorderRadius.circular(6),
    );
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              CustomTextField(
                  context: Get.context,
                  readOnly: true,
                  onTap: () {
                    _datestartPicker();
                  },
                  controller: isStartController,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  newContentPadding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                  textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  newInputDecoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: "hh/bb/tttt", // "Cari Area Pick Up",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w600),
                    enabledBorder: border,
                    border: border,
                    focusedBorder: border,
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      _datestartPicker();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(Get.context) * 9,
                      ),
                      child: SvgPicture.asset(
                        "assets/ic_calendar.svg",
                        color: Colors.black,
                        width: GlobalVariable.ratioFontSize(Get.context) * 16,
                        height: GlobalVariable.ratioFontSize(Get.context) * 16,
                      ),
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
          width: GlobalVariable.ratioWidth(Get.context) * 19,
        ),
        Container(
          child: CustomText(
            "LelangMuatTabAktifTabAktifLabelTitleToDate".tr,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
          ),
        ),
        SizedBox(
          width: GlobalVariable.ratioWidth(Get.context) * 19,
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              CustomTextField(
                  context: Get.context,
                  readOnly: true,
                  onTap: () {
                    _dateendPicker();
                  },
                  controller: isEndController,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  newContentPadding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                  textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  newInputDecoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: "hh/bb/tttt", // "Cari Area Pick Up",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w600),
                    enabledBorder: border,
                    border: border,
                    focusedBorder: border,
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      _dateendPicker();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: GlobalVariable.ratioWidth(Get.context) * 9,
                      ),
                      child: SvgPicture.asset(
                        "assets/ic_calendar.svg",
                        color: Colors.black,
                        width: GlobalVariable.ratioFontSize(Get.context) * 16,
                        height: GlobalVariable.ratioFontSize(Get.context) * 16,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  String formatThousand(num number) {
    if (number == null) return null;
    var format = number is int ? '#,###' : '#,###.###';
    var formattedOriginal = NumberFormat(format).format(number);
    var formatted = formattedOriginal;

    formatted = formatted.replaceAll(',', '.');
    if (formattedOriginal.contains('.')) {
      formatted = formatted.replaceFirst('.', ',', formatted.lastIndexOf('.'));
    }

    debugPrint('debug-formatThousand: $formatted');

    return formatted;
  }

  var isSavedOnce = false.obs;
  var startPrice = ''.obs;
  var endPrice = ''.obs;
  var startQty = ''.obs;
  var endQty = ''.obs;
  var startCapacity = ''.obs;
  var endCapacity = ''.obs;
  var errorTextPrice = Rx<String>(null);
  var errorTextQty = Rx<String>(null);
  var errorTextCapacity = Rx<String>(null);

  void onStartPriceChanged(String value) {
    final baseOffset = rangePriceStart.value.selection.baseOffset;
    if (rangePriceStart.value.text.isEmpty) {
      startPrice.value = '';
      errorTextPrice.value = null;
    } else {
      int start =
          int.tryParse(rangePriceStart.value.text.replaceAll('.', '')) ?? -1;
      int end =
          int.tryParse(rangePriceEnd.value.text.replaceAll('.', '')) ?? -1;

      if (start <= maxPrice.value) {
        startPrice.value = formatThousand(start);
        if (start != -1 && end != -1 && start > end) {
          errorTextPrice.value =
              'Harga promo minimum tidak boleh lebih dari harga promo maksimum'
                  .tr;
        } else {
          errorTextPrice.value = null;
        }
      }
    }
    // var offset = rangePriceStart.value.selection.baseOffset;
    // var listDot = rangePriceStart.value.text.characters
    //     .map((e) => e.indexOf('.'))
    //     .toList();
    // if (listDot.contains(offset)) {
    //   offset++;
    // }
    rangePriceStart.value.text = startPrice.value;
    rangePriceStart.value.selection = TextSelection.collapsed(
      offset: math.max(0, math.min(baseOffset, startPrice?.value?.length ?? 0)),
    );
    var start = double.tryParse('${startPrice.value}'.replaceAll('.', '')) ?? 0;
    var end = double.tryParse('${endPrice.value}'.replaceAll('.', '')) ?? 0;
    rangePrice.value = RangeValues(
      math.min(start, end),
      math.min(end, maxPrice.value.toDouble()),
    );
  }

  void onEndPriceChanged(String value) {
    final baseOffset = rangePriceEnd.value.selection.baseOffset;
    if (rangePriceEnd.value.text.isEmpty) {
      endPrice.value = '';
      errorTextPrice.value = null;
    } else {
      int start =
          int.tryParse(rangePriceStart.value.text.replaceAll('.', '')) ?? -1;
      int end =
          int.tryParse(rangePriceEnd.value.text.replaceAll('.', '')) ?? -1;

      if (end <= maxPrice.value) {
        endPrice.value = formatThousand(end);
        if (start != -1 && end != -1 && start > end) {
          errorTextPrice.value =
              'Harga promo minimum tidak boleh lebih dari harga promo maksimum'
                  .tr;
        } else {
          errorTextPrice.value = null;
        }
      }
    }
    // var offset = rangePriceEnd.value.selection.baseOffset;
    // var listDot =
    //     rangePriceEnd.value.text.characters.map((e) => e.indexOf('.')).toList();
    // if (listDot.contains(offset)) {
    //   offset++;
    // }
    rangePriceEnd.value.text = endPrice.value;
    rangePriceEnd.value.selection = TextSelection.collapsed(
      offset: math.max(0, math.min(baseOffset, endPrice?.value?.length ?? 0)),
    );
    var start = double.tryParse('${startPrice.value}'.replaceAll('.', '')) ?? 0;
    var end = double.tryParse('${endPrice.value}'.replaceAll('.', '')) ?? 0;
    rangePrice.value = RangeValues(
      start,
      math.min(math.max(start, end), maxPrice.value.toDouble()),
    );
  }

  void onStartQtyChanged(String value) {
    final baseOffset = rangeQtyStart.value.selection.baseOffset;
    if (rangeQtyStart.value.text.isEmpty) {
      startQty.value = '';
      errorTextQty.value = null;
    } else {
      int start =
          int.tryParse(rangeQtyStart.value.text.replaceAll('.', '')) ?? -1;
      int end = int.tryParse(rangeQtyEnd.value.text.replaceAll('.', '')) ?? -1;

      if (start <= maxQty.value) {
        startQty.value = formatThousand(start);
        if (start != -1 && end != -1 && start > end) {
          errorTextQty.value =
              'Jumlah truk minimum tidak boleh lebih dari jumlah truk maksimum'
                  .tr;
        } else {
          errorTextQty.value = null;
        }
      }
    }
    // var offset = rangeQtyStart.value.selection.baseOffset;
    // var listDot =
    //     rangeQtyStart.value.text.characters.map((e) => e.indexOf('.')).toList();
    // if (listDot.contains(offset)) {
    //   offset++;
    // }
    rangeQtyStart.value.text = startQty.value;
    rangeQtyStart.value.selection = TextSelection.collapsed(
      offset: math.max(0, math.min(baseOffset, startQty?.value?.length ?? 0)),
    );
    var start = double.tryParse('${startQty.value}'.replaceAll('.', '')) ?? 0;
    var end = double.tryParse('${endQty.value}'.replaceAll('.', '')) ?? 0;
    rangeQty.value = RangeValues(
      math.min(start, end),
      math.min(end, maxQty.value.toDouble()),
    );
  }

  void onEndQtyChanged(String value) {
    final baseOffset = rangeQtyEnd.value.selection.baseOffset;
    if (rangeQtyEnd.value.text.isEmpty) {
      endQty.value = '';
      errorTextQty.value = null;
    } else {
      int start =
          int.tryParse(rangeQtyStart.value.text.replaceAll('.', '')) ?? -1;
      int end = int.tryParse(rangeQtyEnd.value.text.replaceAll('.', '')) ?? -1;

      if (end <= maxQty.value) {
        endQty.value = formatThousand(end);
        if (start != -1 && end != -1 && start > end) {
          errorTextQty.value =
              'Jumlah truk minimum tidak boleh lebih dari jumlah truk maksimum'
                  .tr;
        } else {
          errorTextQty.value = null;
        }
      }
    }
    // var offset = rangeQtyEnd.value.text.length;
    // var offset = rangeQtyEnd.value.selection.baseOffset;
    // var listDot =
    //     rangeQtyEnd.value.text.characters.map((e) => e.indexOf('.')).toList();
    // if (listDot.contains(offset)) {
    //   offset++;
    // }
    rangeQtyEnd.value.text = endQty.value;
    rangeQtyEnd.value.selection = TextSelection.collapsed(
      offset: math.max(0, math.min(baseOffset, endQty?.value?.length ?? 0)),
    );
    var start = double.tryParse('${startQty.value}'.replaceAll('.', '')) ?? 0;
    var end = double.tryParse('${endQty.value}'.replaceAll('.', '')) ?? 0;
    rangeQty.value = RangeValues(
      start,
      math.min(math.max(start, end), maxQty.value.toDouble()),
    );
  }

  double tryParseFormattedDouble(String text) {
    var parsed = double.tryParse(
      '$text'.trim().replaceAll('.', '').replaceAll(',', '.'),
    );
    debugPrint('debug-tryParseFormattedDouble: $text => $parsed');
    return parsed;
  }

  void onStartCapacityChanged(String value) {
    final offset = rangeCapacityStart.value.selection.baseOffset;
    if (rangeCapacityStart.value.text.isEmpty) {
      startCapacity.value = '';
      errorTextCapacity.value = null;
    } else {
      if (rangeCapacityStart.value.text.characters.last != ',') {
        double start =
            tryParseFormattedDouble(rangeCapacityStart.value.text) ?? -1;
        double end = tryParseFormattedDouble(rangeCapacityEnd.value.text) ?? -1;

        if (start <= 1000000000.0) {
          startCapacity.value = formatThousand(start);
          if (start != -1 && end != -1 && start > end) {
            errorTextCapacity.value =
                'Kapasitas minimum tidak boleh lebih dari kapasitas maksimum'
                    .tr;
          } else {
            errorTextCapacity.value = null;
          }
        }
      }
    }
    // var offset = rangeQtyStart.value.selection.baseOffset;
    // var listDot =
    //     rangeQtyStart.value.text.characters.map((e) => e.indexOf('.')).toList();
    // if (listDot.contains(offset)) {
    //   offset++;
    // }
    if (rangeCapacityStart.value.text.characters.last != ',') {
      rangeCapacityStart.value.text = startCapacity.value;
      rangeCapacityStart.value.selection = TextSelection.collapsed(
        offset:
            math.max(0, math.min(offset, startCapacity?.value?.length ?? 0)),
      );
    }
  }

  void onEndCapacityChanged(String value) {
    if (rangeCapacityEnd.value.text.isEmpty) {
      endCapacity.value = '';
      errorTextCapacity.value = null;
    } else {
      if (rangeCapacityEnd.value.text.characters.last != ',') {
        double start =
            tryParseFormattedDouble(rangeCapacityStart.value.text) ?? -1;
        double end = tryParseFormattedDouble(rangeCapacityEnd.value.text) ?? -1;

        if (end <= 1000000000.0) {
          endCapacity.value = formatThousand(end);
          if (start != -1 && end != -1 && start > end) {
            errorTextCapacity.value =
                'Kapasitas minimum tidak boleh lebih dari kapasitas maksimum'
                    .tr;
          } else {
            errorTextCapacity.value = null;
          }
        }
      }
    }
    // var offset = rangeQtyEnd.value.text.length;
    // var offset = rangeQtyEnd.value.selection.baseOffset;
    // var listDot =
    //     rangeQtyEnd.value.text.characters.map((e) => e.indexOf('.')).toList();
    // if (listDot.contains(offset)) {
    //   offset++;
    // }
    if (rangeCapacityEnd.value.text.characters.last != ',') {
      rangeCapacityEnd.value.text = endCapacity.value;
      rangeCapacityEnd.value.selection = TextSelection.collapsed(
        offset: endCapacity?.value?.length ?? 0,
      );
    }
  }

  _formFilterRangePrice() {
    var border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Color(ListColor.colorLightGrey19), width: 1.0),
      borderRadius: BorderRadius.circular(6),
    );
    return Column(
      children: [
        Obx(() {
          if (isLoading.isTrue) {
            return SizedBox.shrink();
          } else {
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      CustomTextField(
                          key: ValueKey("startJumlahKebutuhan"),
                          context: Get.context,
                          controller: rangePriceStart.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ThousanSeparatorFormater(),
                          ],
                          onChanged: onStartPriceChanged,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey4),
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14),
                          newContentPadding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 8,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 9),
                          textSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          newInputDecoration: InputDecoration(
                            isDense: true,
                            isCollapsed: true,
                            hintText: formatThousand(
                                initialPriceRangeValues.start.toInt()),
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(
                                color: Color(ListColor.colorLightGrey2),
                                fontWeight: FontWeight.w600),
                            enabledBorder: border,
                            border: border,
                            focusedBorder: border,
                          )),
                    ])),
                Container(
                    height: 1,
                    width: GlobalVariable.ratioWidth(Get.context) * 92,
                    color: Color(ListColor.colorLightGrey10)),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      CustomTextField(
                          key: ValueKey("endJumlahKebutuhan"),
                          context: Get.context,
                          controller: rangePriceEnd.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ThousanSeparatorFormater(),
                          ],
                          onChanged: onEndPriceChanged,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey4),
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14),
                          newContentPadding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 8,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 9),
                          textSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          newInputDecoration: InputDecoration(
                            isDense: true,
                            isCollapsed: true,
                            hintText: formatThousand(
                                initialPriceRangeValues.end.toInt()),
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(
                                color: Color(ListColor.colorLightGrey2),
                                fontWeight: FontWeight.w600),
                            enabledBorder: border,
                            border: border,
                            focusedBorder: border,
                          )),
                    ])),
              ],
            );
          }
        }),
        if (errorTextPrice?.value?.isNotEmpty ?? false) ...[
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 5,
          ),
          CustomText(
            errorTextPrice.value,
            color: Color(ListColor.colorRed),
            fontSize: 12,
          ),
        ],
        SizedBox(
          height: GlobalVariable.ratioWidth(Get.context) * 12,
        ),
        Obx(() {
          if (isLoading.isTrue) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              child: SliderTheme(
                data: SliderThemeData(
                    trackHeight: 1,
                    activeTrackColor: Color(ListColor.colorBlue),
                    inactiveTrackColor: Color(ListColor.colorGrey),
                    thumbColor: Color(ListColor.colorWhite),
                    overlayShape: RoundSliderOverlayShape(
                        overlayRadius:
                            GlobalVariable.ratioWidth(Get.context) * 10),
                    thumbShape:
                        RoundSliderThumbShape(enabledThumbRadius: 15.0)),
                child: RangeSlider(
                  min: 0,
                  max: maxPrice.value.toDouble(),
                  values: rangePrice.value,
                  onChanged: (values) {
                    rangePrice.value = values;

                    rangePriceStart.value.text =
                        values.start.toInt().toString();
                    rangePriceEnd.value.text = values.end.toInt().toString();
                    onStartPriceChanged(rangePriceStart.value.text);
                    onEndPriceChanged(rangePriceEnd.value.text);
                    // validateRangePriceStart(rangePriceStart.value.text);
                    // validateRangePriceEnd(rangePriceEnd.value.text);
                  },
                ),
              ),
            );
          }
        }),
      ],
    );
  }

  _formFilterRangeTruckQty() {
    var border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Color(ListColor.colorLightGrey19), width: 1.0),
      borderRadius: BorderRadius.circular(6),
    );
    return Column(
      children: [
        Obx(() {
          if (isLoading.isTrue) {
            return SizedBox.shrink();
          } else {
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      CustomTextField(
                          key: ValueKey("startJumlahKoli"),
                          context: Get.context,
                          controller: rangeQtyStart.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: onStartQtyChanged,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey4),
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14),
                          newContentPadding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 8,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 9),
                          textSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          newInputDecoration: InputDecoration(
                            isDense: true,
                            isCollapsed: true,
                            hintText: formatThousand(
                                initialQtyRangeValues.start.toInt()),
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(
                                color: Color(ListColor.colorLightGrey2),
                                fontWeight: FontWeight.w600),
                            enabledBorder: border,
                            border: border,
                            focusedBorder: border,
                          )),
                    ])),
                Container(
                    height: 1,
                    width: GlobalVariable.ratioWidth(Get.context) * 92,
                    color: Color(ListColor.colorLightGrey10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        key: ValueKey("endJumlahKoli"),
                        context: Get.context,
                        controller: rangeQtyEnd.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: onEndQtyChanged,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorLightGrey4),
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14),
                        newContentPadding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 8,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 9),
                        textSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        newInputDecoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          hintText:
                              formatThousand(initialQtyRangeValues.end.toInt()),
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: TextStyle(
                              color: Color(ListColor.colorLightGrey2),
                              fontWeight: FontWeight.w600),
                          enabledBorder: border,
                          border: border,
                          focusedBorder: border,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
        if (errorTextQty?.value?.isNotEmpty ?? false) ...[
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 5,
          ),
          CustomText(
            errorTextQty.value,
            color: Color(ListColor.colorRed),
            fontSize: 12,
          ),
        ],
        SizedBox(
          height: GlobalVariable.ratioWidth(Get.context) * 12,
        ),
        Obx(() {
          if (isLoading.isTrue) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              child: SliderTheme(
                data: SliderThemeData(
                    trackHeight: 1,
                    activeTrackColor: Color(ListColor.colorBlue),
                    inactiveTrackColor: Color(ListColor.colorGrey),
                    thumbColor: Color(ListColor.colorWhite),
                    overlayShape: RoundSliderOverlayShape(
                        overlayRadius:
                            GlobalVariable.ratioWidth(Get.context) * 10),
                    thumbShape:
                        RoundSliderThumbShape(enabledThumbRadius: 15.0)),
                child: RangeSlider(
                  min: 0,
                  max: maxQty.value.toDouble(),
                  values: rangeQty.value,
                  onChanged: (values) {
                    rangeQty.value = values;

                    rangeQtyStart.value.text = values.start.toInt().toString();
                    rangeQtyEnd.value.text = values.end.toInt().toString();
                    onStartQtyChanged(rangeQtyStart.value.text);
                    onEndQtyChanged(rangeQtyEnd.value.text);
                    // validateRangeQtyStart(rangeQtyStart.value.text);
                    // validateRangeQtyEnd(rangeQtyEnd.value.text);
                  },
                ),
              ),
            );
          }
        }),
      ],
    );
  }

  void showAllDestinasi() async {
    var result =
        await GetToPage.toNamed<ZoPromoTransporterFilterLocationController>(
      Routes.ZO_PROMO_TRANSPORTER_FILTER_LOCATION,
      arguments: [
        List.from(listFilterLokasiDestinasi.value),
        List.from(tempFilterLokasiDestinasi.value),
        "LelangMuatTabAktifTabAktifLabelTitleDestinationLocation".tr
      ],
      preventDuplicates: false,
    );

    debugPrint('debug-result-showAllDestinasi: $result');
    if (result != null) {
      tempFilterLokasiDestinasi.value = result;
    }
  }

  void showAllPickup() async {
    var result =
        await GetToPage.toNamed<ZoPromoTransporterFilterLocationController>(
      Routes.ZO_PROMO_TRANSPORTER_FILTER_LOCATION,
      arguments: [
        List.from(listFilterLokasiPickup.value),
        List.from(tempFilterLokasiPickup.value),
        "LelangMuatBuatLelangBuatLelangLabelTitleLokasiPickup".tr
      ],
      preventDuplicates: false,
    );

    debugPrint('debug-result-showAllPickup: $result');
    if (result != null) {
      tempFilterLokasiPickup.value = result;
    }
  }

  void showAllJenisTruck() async {
    var result =
        await GetToPage.toNamed<ZoPromoTransporterFilterTruckController>(
            Routes.ZO_PROMO_TRANSPORTER_FILTER_TRUCK,
            arguments: [
              List.from(listFilterJenisTruckimg.value),
              List.from(tempFilterJenisTruck.value),
              "LelangMuatTabAktifTabAktifLabelTitleTruckType".tr
            ],
            preventDuplicates: false);

    debugPrint('debug-result-showAllJenisTruck: $result');
    if (result != null) {
      tempFilterJenisTruck.value = result;
    }
    debugPrint('debug-filter-showAllJenisTruck: $tempFilterJenisTruck');
  }

  void showAllJenisCarrierTruck() async {
    var result =
        await GetToPage.toNamed<ZoPromoTransporterFilterTruckController>(
            Routes.ZO_PROMO_TRANSPORTER_FILTER_TRUCK,
            arguments: [
              List.from(listFilterJenisCarrierimg.value),
              List.from(tempFilterJenisCarrier.value),
              "LelangMuatTabAktifTabAktifLabelTitleCarrierType".tr
            ],
            preventDuplicates: false);

    debugPrint('debug-result-showAllJenisCarrier: $result');
    if (result != null) {
      tempFilterJenisCarrier.value = result;
    }
  }

  _buildWrapperdForm(String label, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(ZoPromoTransporterStrings.filterPickup.tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterLokasiPickup.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterLokasiPickup.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showAllPickup();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(
          () => wrapFilter(
            listFilterLokasiPickup.value,
            tempFilterLokasiPickup.value,
            (bool onSelect, String value) {
              if (onSelect)
                tempFilterLokasiPickup.add(value);
              else
                tempFilterLokasiPickup.remove(value);
            },
          ),
        ),
      ],
    );
  }

  _formFilterLokasiPickUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              ZoPromoTransporterStrings.filterPickup.tr,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w600,
            ),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterLokasiPickup.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterLokasiPickup.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showAllPickup();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilter(
                listFilterLokasiPickup.value, tempFilterLokasiPickup.value,
                (bool onSelect, String value) {
              if (onSelect)
                tempFilterLokasiPickup.add(value);
              else
                tempFilterLokasiPickup.remove(value);
            }))
      ],
    );
  }

  _formFilterLokasiDestinasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              ZoPromoTransporterStrings.filterDestination.tr,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w600,
            ),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterLokasiDestinasi.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterLokasiDestinasi.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showAllDestinasi();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilter(listFilterLokasiDestinasi.value,
                tempFilterLokasiDestinasi.value, (bool onSelect, String value) {
              if (onSelect)
                tempFilterLokasiDestinasi.add(value);
              else
                tempFilterLokasiDestinasi.remove(value);
            }))
      ],
    );
  }

  _formFilterJenisTruck() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              ZoPromoTransporterStrings.filterTruck.tr,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w600,
            ),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterJenisTruck.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterJenisTruck.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // showAll(0);
                    showAllJenisTruck();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilterJenisTrukCarrier(
                listFilterJenisTruckimg.value, tempFilterJenisTruck.value,
                (bool onSelect, Map value) {
              if (onSelect) {
                tempFilterJenisTruck.add(value);
              } else {
                tempFilterJenisTruck.removeWhere((e) => value['ID'] == e['ID']);
              }
            }))
      ],
    );
  }

  _formFilterJenisCarrier() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(ZoPromoTransporterStrings.filterCarrier.tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
            Obx(
              () => Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12),
                  height: GlobalVariable.ratioWidth(Get.context) * 22,
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 6),
                  constraints: BoxConstraints(
                      minWidth: GlobalVariable.ratioWidth(Get.context) * 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 22),
                      color: tempFilterJenisCarrier.isEmpty
                          ? Colors.transparent
                          : Color(ListColor.color4)),
                  child: CustomText(tempFilterJenisCarrier.length.toString(),
                      fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // showAll(0);
                    showAllJenisCarrierTruck();
                  },
                  child: CustomText("GlobalFilterButtonShowAll".tr,
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorBlue)),
                ),
              ),
            )
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Obx(() => wrapFilterJenisTrukCarrier(
                listFilterJenisCarrierimg.value, tempFilterJenisCarrier.value,
                (bool onSelect, Map value) {
              if (onSelect)
                tempFilterJenisCarrier.add(value);
              else
                tempFilterJenisCarrier
                    .removeWhere((e) => value['ID'] == e['ID']);
            }))
      ],
    );
  }

  void cariTransporter() async {
    var result =
        await GetToPage.toNamed<ZoPromoTransporterFilterTransporterController>(
            Routes.ZO_PROMO_TRANSPORTER_FILTER_TRANSPORTER,
            arguments: [
              List.from(listTransporter.map((element) => {
                    'ImageHead': '${element.avatar}',
                    'Description': '${element.name}',
                    'ID': element.transporterId,
                  })),
              List.from(tempTransporter.map((element) => {
                    'ImageHead': '${element.avatar}',
                    'Description': '${element.name}',
                    'ID': element.transporterId,
                  })),
              "Transporter".tr
            ],
            preventDuplicates: false);
    if (result != null) {
      tempTransporter.value = List.from(result)
          .map((e) => ZoTransporterFreeModel(
                name: e['Description'],
                avatar: e['ImageHead'],
                transporterId: e['ID'],
              ))
          .toList();
    }
  }

  void onCheckTransporter(int index, bool value) {
    if (value) {
      listChoosen[listTransporter[index]] = listTransporter[index];
    } else {
      listChoosen.removeWhere((key, value) => key == listTransporter[index]);
    }
    listTransporter.refresh();
  }

  void onCheckTransporterFirst(int index, bool value) {
    if (value) {
      tempTransporter.add(listTransporter[index]);
    } else {
      tempTransporter.removeWhere((element) =>
          element.transporterId == listTransporter[index].transporterId);
    }
    tempTransporter.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
    tempTransporter.refresh();
  }

  _formFilterTransporter() {
    var border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Color(ListColor.colorLightGrey10), width: 1.0),
      borderRadius: BorderRadius.circular(8),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(ZoPromoTransporterStrings.filterTransporter.tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
              context: Get.context,
              readOnly: true,
              onTap: () {
                cariTransporter();
              },
              onChanged: (value) {
                // controller.addTextSearchCity(value);
              },
              // controller: controller.searchTextEditingController.value,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                // controller.onSubmitSearch();
              },
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              newContentPadding: EdgeInsets.symmetric(
                  horizontal: 42,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 9),
              textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              newInputDecoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                hintText: listTransporter.length > 0
                    ? 'ex: ${listTransporter[0].name}'
                    : ZoPromoTransporterStrings.filterTransporterHint.tr,
                fillColor: Color(ListColor.colorStroke).withOpacity(0.1),
                filled: true,
                hintStyle: TextStyle(
                    color: Color(ListColor.colorStroke),
                    fontWeight: FontWeight.w600),
                enabledBorder: border,
                border: border,
                focusedBorder: border,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 7),
              child: SvgPicture.asset(
                "assets/search_magnifition_icon.svg",
                width: GlobalVariable.ratioFontSize(Get.context) * 28,
                height: GlobalVariable.ratioFontSize(Get.context) * 28,
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: GlobalVariable.ratioWidth(Get.context) * 12,
        // ),
        Obx(() => wrapFilterTransporter(
            tempTransporter.map((element) => '${element.name}').toList())),
        if (listTransporter.value.length > 0)
          if (listTransporter.value.length > limitTransporterView)
            for (var i = 0; i < limitTransporterView; i++) ...[
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
              GestureDetector(
                onTap: () {
                  var currentValue = tempTransporter.any((element) =>
                      element.transporterId ==
                      listTransporter[i].transporterId);
                  onCheckTransporterFirst(i, !currentValue);
                },
                child: Row(children: [
                  CheckBoxCustom(
                      paddingR: 0,
                      paddingT: 0,
                      paddingL: 0,
                      paddingB: 0,
                      borderColor: Color(ListColor.colorLightGrey14),
                      size: GlobalVariable.ratioFontSize(Get.context) * 16,
                      shadowSize:
                          GlobalVariable.ratioFontSize(Get.context) * 19,
                      isWithShadow: true,
                      colorBG: Colors.white,
                      border: 1,
                      value: tempTransporter.any((element) =>
                          element.transporterId ==
                          listTransporter[i].transporterId),
                      onChanged: (value) {
                        onCheckTransporterFirst(i, value);
                      }),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 8,
                  ),
                  CustomText(
                    '${listTransporter[i].name}',
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    fontWeight: FontWeight.w500,
                    color: Color(ListColor.colorLightGrey4),
                  )
                ]),
              ),
            ]
          else
            for (var i = 0; i < listTransporter.value.length; i++) ...[
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
              GestureDetector(
                onTap: () {
                  var currentValue = tempTransporter.any((element) =>
                      element.transporterId ==
                      listTransporter[i].transporterId);
                  onCheckTransporterFirst(i, !currentValue);
                },
                child: Row(children: [
                  CheckBoxCustom(
                      paddingR: 0,
                      paddingT: 0,
                      paddingL: 0,
                      paddingB: 0,
                      size: GlobalVariable.ratioFontSize(Get.context) * 16,
                      shadowSize:
                          GlobalVariable.ratioFontSize(Get.context) * 19,
                      borderColor: Color(ListColor.colorLightGrey14),
                      isWithShadow: true,
                      border: 1,
                      colorBG: Colors.white,
                      value: tempTransporter.any((element) =>
                          element.transporterId ==
                          listTransporter[i].transporterId),
                      onChanged: (value) {
                        onCheckTransporterFirst(i, value);
                      }),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 8,
                  ),
                  CustomText(
                    '${listTransporter[i].name}',
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                    fontWeight: FontWeight.w500,
                    color: Color(ListColor.colorLightGrey4),
                  )
                ]),
              ),
            ],
      ],
    );
  }

  _formFilterStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(ZoPromoTransporterStrings.filterPayment.tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 2),
        for (var index = 0; index < listStatus.length; index++) ...[
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 14),
          _statusForm(listStatus[index]["val"],
              listStatus[index]["id"].toString(), index),
        ],
      ],
    );
  }

  _statusForm(String name, String id, int idx) {
    return GestureDetector(
      onTap: () {
        var currentValue = tempPayment.value.contains(name);
        var value = !currentValue;
        if (value) {
          tempPayment.add(name);
        } else {
          if (tempPayment.length == 1) {
            tempPayment.clear();
          } else {
            tempPayment.removeWhere((element) => element == name);
          }
        }
      },
      child: Row(
        children: [
          CheckBoxCustom(
              paddingR: 0,
              paddingT: 0,
              paddingL: 0,
              paddingB: 0,
              size: GlobalVariable.ratioFontSize(Get.context) * 16,
              shadowSize: GlobalVariable.ratioFontSize(Get.context) * 19,
              isWithShadow: true,
              borderColor: Color(ListColor.colorGrey3),
              colorBG: Colors.white,
              border: 1,
              value: tempPayment.value.contains(name),
              onChanged: (value) {
                if (value) {
                  tempPayment.add(name);
                } else {
                  if (tempPayment.length == 1) {
                    tempPayment.clear();
                  } else {
                    tempPayment.removeWhere((element) => element == name);
                  }
                }
              }),
          SizedBox(
            width: GlobalVariable.ratioWidth(Get.context) * 8,
          ),
          CustomText(
            name,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            fontWeight: FontWeight.w500,
            color: Color(ListColor.colorLightGrey4),
          ),
        ],
      ),
    );
  }

  _formFilterMinDimension() {
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: Color(ListColor.colorWhite), width: 1.0),
      borderRadius: BorderRadius.circular(6),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(ZoPromoTransporterStrings.filterMinDimension.tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Container(
          // color: Colors.blue,
          width: MediaQuery.of(Get.context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  // width: GlobalVariable.ratioWidth(Get.context) * 228,
                  // width: MediaQuery.of(Get.context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color(ListColor.colorLightGrey19)),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextField(
                            key: ValueKey("panjang"),
                            context: Get.context,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9\,]")),
                              ark_global.DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 3,
                                controller: panjang.value,
                              ),
                              // LengthLimitingTextInputFormatter(5),
                              // ThousanSeparatorFormater(),
                              // FilteringTextInputFormatter.allow(
                              //   RegExp(r'^[0-9,]*$'),
                              // ),
                            ],
                            newContentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            controller: panjang.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            textSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            newInputDecoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey2)),
                              hintText:
                                  "LelangMuatTabAktifTabAktifLabelTitlePlaceholderLength"
                                      .tr,
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: border,
                              border: border,
                              focusedBorder: border,
                            )),
                      ),
                      Container(
                        // width: GlobalVariable.ratioWidth(Get.context) * 36,
                        child: Center(
                          child: CustomText(
                            "x",
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            color: Color(ListColor.colorLightGrey4),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                            key: ValueKey("lebar"),
                            context: Get.context,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9\,]")),
                              ark_global.DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 3,
                                controller: lebar.value,
                              ),
                              // LengthLimitingTextInputFormatter(5),
                              // FilteringTextInputFormatter.allow(
                              //     RegExp(r'^[0-9,]*$'))
                            ],
                            newContentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            controller: lebar.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            textSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            newInputDecoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey2)),
                              hintText:
                                  "LelangMuatTabAktifTabAktifLabelTitlePlaceholderWidth"
                                      .tr,
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            )),
                      ),
                      Container(
                        // width: GlobalVariable.ratioWidth(Get.context) * 36,
                        child: Center(
                          child: CustomText(
                            "x",
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            color: Color(ListColor.colorLightGrey4),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                            key: ValueKey("tinggi"),
                            context: Get.context,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9\,]")),
                              ark_global.DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 3,
                                controller: tinggi.value,
                              ),
                              // LengthLimitingTextInputFormatter(5),
                              // FilteringTextInputFormatter.allow(
                              //     RegExp(r'^[0-9,]*$'))
                            ],
                            newContentPadding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 9),
                            controller: tinggi.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            textSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            newInputDecoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey2)),
                              hintText:
                                  "LelangMuatTabAktifTabAktifLabelTitlePlaceholderHeight"
                                      .tr,
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(ListColor.colorWhite),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Container(
                  child: DropdownBelow(
                key: ValueKey("selectedsatuandimensi"),
                items: [
                  DropdownMenuItem(
                    child: CustomText("m",
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Color(ListColor.colorLightGrey4)),
                    value: "m",
                  ),
                  DropdownMenuItem(
                    child: CustomText("cm",
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Color(ListColor.colorLightGrey4)),
                    value: "cm",
                  )
                ],
                onChanged: (value) {
                  // controller.selectedDimensiKoli.value = value;
                  _selectedDimensionUnit.value = value;
                },
                itemWidth: 100,
                itemTextstyle: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w400,
                    color: Color(ListColor.colorLightGrey4)),
                boxTextstyle: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w400,
                    color: Color(ListColor.colorLightGrey4)),
                boxPadding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 8,
                    right: GlobalVariable.ratioWidth(Get.context) * 8),
                // boxPadding: EdgeInsets.symmetric(
                //     horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
                //     vertical: GlobalVariable.ratioWidth(Get.context) * 9),
                boxWidth: 100,
                // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 45,
                boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
                    GlobalVariable.ratioWidth(Get.context) * 13.5 +
                    GlobalVariable.ratioWidth(Get.context) * 13.5,
                boxDecoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1, color: Color(ListColor.colorLightGrey19)),
                    borderRadius: BorderRadius.circular(6)),
                icon: Icon(Icons.keyboard_arrow_down_outlined,
                    color: Color(ListColor.colorLightGrey19)),
                hint: CustomText(_selectedDimensionUnit.value,
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    color: Color(ListColor.colorLightGrey4)),
                value: _selectedDimensionUnit.value,
              ))
              // Container(
              //     child: DropdownBelow(
              //   items: _dropdownSatuanDimensi,
              //   onChanged: onChangeDropdownSatuanDimensi,
              //   itemWidth: 100,
              //   itemTextstyle: TextStyle(
              //       fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
              //       fontWeight: FontWeight.w400,
              //       color: Color(ListColor.colorLightGrey4)),
              //   boxTextstyle: TextStyle(
              //       fontSize: GlobalVariable.ratioWidth(Get.context) * 14,
              //       fontWeight: FontWeight.w400,
              //       color: Color(ListColor.colorLightGrey4)),
              //   boxPadding: EdgeInsets.fromLTRB(13, 12, 13, 12),
              //   boxWidth: 100,
              //   boxHeight: GlobalVariable.ratioWidth(Get.context) * 35,
              //   boxDecoration: BoxDecoration(
              //       color: Colors.transparent,
              //       border: Border.all(
              //           width: 1, color: Color(ListColor.colorLightGrey19)),
              //       borderRadius: BorderRadius.circular(6)),
              //   icon: Icon(Icons.keyboard_arrow_down_outlined,
              //       color: Color(ListColor.colorLightGrey19)),
              //   hint: Text(_selectedsatuandimensi.value),
              //   value: _selectedsatuandimensi.value,
              // ))
            ],
          ),
        )
      ],
    );
  }

  _formFilterCapacity() {
    Widget buildCapacityTextField({
      TextEditingController controller,
      void Function(String) onChanged,
    }) {
      var border = OutlineInputBorder(
        borderSide:
            BorderSide(color: Color(ListColor.colorLightGrey19), width: 1.0),
        borderRadius: BorderRadius.circular(6),
      );
      return CustomTextField(
        // key: ValueKey("volume"),
        context: Get.context,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
          ark_global.DecimalInputFormatter(
            digit: 10,
            digitAfterComma: 3,
            controller: controller,
          ),
          // FilteringTextInputFormatter.digitsOnly,
          // ThousanSeparatorFormater(),
        ],
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
            vertical: GlobalVariable.ratioWidth(Get.context) * 9),
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(ListColor.colorLightGrey2)),
          hintText: '0',
          fillColor: Colors.white,
          filled: true,
          enabledBorder: border,
          border: border,
          focusedBorder: border,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(ZoPromoTransporterStrings.filterCapacity.tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600),
          ],
        ),
        Container(height: GlobalVariable.ratioWidth(Get.context) * 18),
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Obx(
                  () => buildCapacityTextField(
                    controller: rangeCapacityStart.value,
                    onChanged: onStartCapacityChanged,
                  ),
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(
                ZoPromoTransporterStrings.filterSeparator.tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                fontWeight: FontWeight.w500,
                color: Color(ListColor.colorLightGrey4),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Expanded(
                  child: Obx(
                () => buildCapacityTextField(
                  controller: rangeCapacityEnd.value,
                  onChanged: onEndCapacityChanged,
                ),
              )),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
              Container(
                  child: DropdownBelow(
                      key: ValueKey("selectedsatuanvolume"),
                      items: _listSatuanVolume
                          .map((e) => DropdownMenuItem(
                                child: CustomText("$e",
                                    fontWeight: FontWeight.w600,
                                    fontSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                    color: Color(ListColor.colorLightGrey4)),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        _selectedCapacityUnit.value = value;
                      },
                      itemWidth: 100,
                      itemTextstyle: TextStyle(
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          fontWeight: FontWeight.w400,
                          color: Color(ListColor.colorLightGrey4)),
                      boxTextstyle: TextStyle(
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          fontWeight: FontWeight.w400,
                          color: Color(ListColor.colorLightGrey4)),
                      boxPadding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      // boxPadding: EdgeInsets.symmetric(
                      //     horizontal:
                      //         GlobalVariable.ratioWidth(Get.context) * 8,
                      //     vertical:
                      //         GlobalVariable.ratioWidth(Get.context) * 9),
                      boxWidth: 100,
                      // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 44,
                      boxHeight:
                          GlobalVariable.ratioFontSize(Get.context) * 14 +
                              GlobalVariable.ratioWidth(Get.context) * 12.5 +
                              GlobalVariable.ratioWidth(Get.context) * 12.5,
                      boxDecoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: Color(ListColor.colorLightGrey19)),
                          borderRadius: BorderRadius.circular(6)),
                      icon: Icon(Icons.keyboard_arrow_down_outlined,
                          color: Color(ListColor.colorLightGrey19)),
                      hint: _selectedCapacityUnit == "m3"
                          ? Html(
                              style: {
                                  "body": Style(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero)
                                },
                              data:
                                  '<span style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 14}; color: #676767;">m<sup>3<sup></span')
                          : CustomText(_selectedCapacityUnit.value,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) * 14,
                              color: Color(ListColor.colorLightGrey4)),
                      value: _selectedCapacityUnit.value))
            ],
          ),
        ),
        Obx(() => (errorTextCapacity?.value?.isNotEmpty ?? false)
            ? SizedBox(
                height: GlobalVariable.ratioWidth(Get.context) * 5,
              )
            : SizedBox.shrink()),
        Obx(() => (errorTextCapacity?.value?.isNotEmpty ?? false)
            ? CustomText(
                errorTextCapacity.value,
                color: Color(ListColor.colorRed),
                fontSize: 12,
              )
            : SizedBox.shrink()),
      ],
    );
  }

  _datestartPicker() async {
    FocusManager.instance?.primaryFocus?.unfocus();
    var picked = await showDatePicker(
        context: Get.context,
        initialDate: inisialDateStart,
        firstDate: DateTime(2000),
        lastDate: DateTime(DateTime.now().year + 200));

    if (picked != null) {
      inisialDateStart = picked;
      String isMonth = "";
      if (picked.month.toString().length > 1) {
        isMonth = "${picked.month}";
      } else {
        isMonth = "0${picked.month}";
      }

      String isDay = "";
      if (picked.day.toString().length > 1) {
        isDay = "${picked.day}";
      } else {
        isDay = "0${picked.day}";
      }

      rangeStartDate.value.text = "$isDay/$isMonth/${picked.year}";
      rangeStartDate.refresh();

      if (inisialDateEnd?.isBefore(picked) ?? true) {
        inisialDateEnd = picked;
        if (rangeEndDate.value.text.isNotEmpty) {
          rangeEndDate.value.text = "$isDay/$isMonth/${picked.year}";
          rangeEndDate.refresh();
        }
      }
    }
  }

  _dateendPicker() async {
    FocusManager.instance?.primaryFocus?.unfocus();
    DateTime firstdate = inisialDateStart;

    if (inisialDateEnd?.isBefore(firstdate) ?? false) {
      inisialDateEnd = firstdate;
    }

    var picked = await showDatePicker(
        context: Get.context,
        initialDate: inisialDateEnd,
        firstDate: firstdate,
        lastDate: DateTime(DateTime.now().year + 200));

    if (picked != null) {
      String isMonthend = "";
      if (picked.month.toString().length > 1) {
        isMonthend = "${picked.month}";
      } else {
        isMonthend = "0${picked.month}";
      }

      String isDayend = "";
      if (picked.day.toString().length > 1) {
        isDayend = "${picked.day}";
      } else {
        isDayend = "0${picked.day}";
      }

      inisialDateEnd = picked;
      rangeEndDate.value.text = "$isDayend/$isMonthend/${picked.year}";
      rangeEndDate.refresh();
    }
  }
}
