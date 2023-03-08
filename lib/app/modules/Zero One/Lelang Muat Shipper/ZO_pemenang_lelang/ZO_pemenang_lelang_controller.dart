import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/zo_bid_information_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/zo_bid_participant_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_pemenang_lelang/ZO_pemenang_lelang_widgets/ZO_pemenang_lelang_bottom_sheet_contact.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ZoPemenangLelangController extends GetxController {
  var loginASval = "".obs;
  final int roleProfile = int.tryParse(GlobalVariable.role);
  RxString searchQueryObs = "".obs;
  RxMap<String, dynamic> sortMapObs = <String, dynamic>{}.obs;
  RxInt bidID = RxInt(0);
  RxBool isLoading = false.obs;
  RxBool isSortEnabled = false.obs;
  RxBool isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();
  Worker searchWorker;
  final mainRefreshController = RefreshController(initialRefresh: false);
  final searchRefreshController = RefreshController(initialRefresh: false);
  SortingController _sortingController;
  RxBool isSearchActive = false.obs;

  final RxList<ZoBidParticipant> bidWinnerList = <ZoBidParticipant>[].obs;
  final List<ZoBidParticipant> _originalBidWinnerList = <ZoBidParticipant>[];

  Rx<ZoBidInformation> bidInformation = ZoBidInformation().obs;
  var bidWinnerSort = [
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleNamaTransporter".tr,
        "transporter_name",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleHargaLelang".tr,
        "initial_price",
        "Terendah",
        "Tertinggi",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleJumlahDitawarkan".tr,
        "truck_offer",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleNilaiTransporter".tr,
        "transporter_score",
        "A-Z",
        "Z-A",
        "".obs),
    DataListSortingModel(
        "LelangMuatPesertaLelangPesertaLelangLabelTitleTanggalPilihPemenang".tr,
        "picked_date",
        "Terlama",
        "Terbaru",
        "".obs,
        isTitleASCFirst: false),
  ];

  Future<void> reset({bool maintainQuery = false}) async {
    if (!maintainQuery) {
      _resetSearch();
    }
    _resetSort();
    await _refreshData();
  }

  void _resetSort() {
    if (sortMapObs.isNotEmpty) {
      sortMapObs.clear();
    }
  }

  void _resetSearch() {
    searchController.text = "";
    searchQueryObs.value = "";
    isSearchActive.value = false;
    // isSortEnabled.value = _originalBidWinnerList.isNotEmpty;
    // bidWinnerList.clear();
    // bidWinnerList.addAll(_originalBidWinnerList);
  }

  void doSearch(String query) {
    isSearching.value = true;
    bidWinnerList.clear();

    if (searchQueryObs.isEmpty) {
      bidWinnerList.addAll(_originalBidWinnerList);
    } else {
      var nameContainsQuery = (ZoBidParticipant bidWinner) =>
          bidWinner.transporterName.toLowerCase().contains(query.toLowerCase());
      bidWinnerList
          .addAll(_originalBidWinnerList.where(nameContainsQuery) ?? []);
    }

    isSortEnabled.value = bidWinnerList.isNotEmpty;
    isSearching.value = false;
  }

  void _setSearchController() {
    searchController.addListener(() {
      if (searchQueryObs.value != searchController.text) {
        isSearching.value = true;
        searchQueryObs.value = searchController.text;
        if (sortMapObs.isNotEmpty) {
          sortMapObs.clear();
        }
      }
    });

    // searchWorker = debounce(searchQuery, doSearch, time: 1.seconds);
    searchWorker = debounce<String>(searchQueryObs, (value) async {
      if (value.isNotEmpty) {
        isSearching.value = true;
        isSortEnabled.value = false;
        await fetchBidWinnerList(query: value, sortMap: sortMapObs);
      }
      isSearching.value = false;
      isSortEnabled.value = bidWinnerList.isNotEmpty &&
          (isSearchActive.isFalse ||
              (isSearchActive.isTrue && searchQueryObs.isNotEmpty));
    }, time: 300.milliseconds);
  }

  int Function(ZoBidParticipant, ZoBidParticipant) _getComparator(
      String groupValue) {
    var compareWithNullCheck = (Comparable a, Comparable b) {
      if (a == null) {
        return -1;
      } else if (b == null) {
        return 1;
      } else {
        return a.compareTo(b);
      }
    };
    var comparator;
    switch (groupValue) {
      case "transporter_name_ASC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(a.transporterName, b.transporterName);
        break;
      case "transporter_name_DESC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(b.transporterName, a.transporterName);
        break;
      case "initial_price_ASC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(a.initialPrice, b.initialPrice);
        break;
      case "initial_price_DESC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(b.initialPrice, a.initialPrice);
        break;
      case "truck_offer_ASC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(a.truckOffer, b.truckOffer);
        break;
      case "truck_offer_DESC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(b.truckOffer, a.truckOffer);
        break;
      case "transporter_score_ASC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(a.star, b.star);
        break;
      case "transporter_score_DESC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(b.star, a.star);
        break;
      case "picked_date_ASC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(a.pickedDate, b.pickedDate);
        break;
      case "picked_date_DESC":
        comparator = (ZoBidParticipant a, ZoBidParticipant b) =>
            compareWithNullCheck(b.pickedDate, a.pickedDate);
        break;
      default:
    }
    return comparator;
  }

  _doSort(Map<String, dynamic> sortMap) {
    sortMap.entries.forEach((sort) {
      String groupValue = "${sort.key}_${sort.value}";
      var comparator = _getComparator(groupValue);

      bidWinnerList.sort(comparator);
      _originalBidWinnerList.sort(comparator);
    });
  }

  showSort() {
    _sortingController.showSort();
  }

  clearSort() {
    sortMapObs.clear();
  }

  _refreshData() async {
    print("debug refreshData");
    await fetchBidWinnerList(sortMap: sortMapObs, query: searchQueryObs.value);
  }

  _setSortController() {
    _sortingController = Get.put(SortingController(
      listSort: bidWinnerSort,
      initMap: sortMapObs,
      enableCustomSort: true,
      onRefreshData: (newSortMap) async {
        print(sortMapObs.toString());
        sortMapObs.clear();
        sortMapObs.addAll(newSortMap);
        isSearching.value = isSearchActive.value;
        await _refreshData();
        isSearching.value = false;
      },
    ));
  }

  @override
  Future<void> onInit() async {
    print("onInit");
    bidID.value = int.tryParse(Get.parameters['bidId']);
    isLoading.value = true;
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      loginASval.value = resLoginAs["LoginAs"].toString();
      print("DALSDKSAFLAK ${loginASval.value}");
      fetchBidWinnerList().whenComplete(() {
        _setSearchController();
        _setSortController();
        print(_originalBidWinnerList);
        print(bidWinnerList);
      });
    }

    super.onInit();
  }

  @override
  void onClose() {
    searchWorker.dispose();
    searchController.dispose();
    _sortingController.dispose();
    searchRefreshController.dispose();
    mainRefreshController.dispose();

    super.onClose();
  }

  Future fetchBidWinnerList(
      {String query, Map<String, dynamic> sortMap}) async {
    print("sortMapObs $sortMapObs");
    isLoading.value = true;
    isSortEnabled.value = false;
    var response = await ApiHelper(
      context: Get.context,
      isShowDialogLoading: false,
      // isShowDialogError: false,
    ).fetchBidWinnerData(
        bidID.value.toString(), loginASval.value, GlobalVariable.role,
        query: query, sortMap: sortMap);

    print('fetchbidwinnerlist: $response');
    // ZoBidWinnerData winnerData = ZoBidWinnerData.fromJson(data);
    if (response.message.code == 200) {
      var winnerData = response.data;
      if (winnerData != null && winnerData.bidParticipantList != null) {
        if (winnerData.bidParticipantList != null) {
          _originalBidWinnerList.clear();
          _originalBidWinnerList.addAll(winnerData.bidParticipantList);
          bidWinnerList.clear();
          bidWinnerList.addAll(_originalBidWinnerList);
        }
        if (winnerData.bidInformation != null) {
          bidInformation.value = winnerData.bidInformation;
        }
        isSortEnabled.value = bidWinnerList.isNotEmpty &&
            (isSearchActive.isFalse ||
                (isSearchActive.isTrue && searchQueryObs.isNotEmpty));
      }

      for (int i = 0; i < bidWinnerList.length; i++) {
        print("bidWinnerList[$i]: " + bidWinnerList[i].toJson().toString());
      }

      print("Debug: " + bidInformation.value.toJson().toString());
    } else if (response.message.code == 403) {
      GlobalAlertDialog.showDialogError(
        message: 'GlobalLabelErrorFalseTokenApp'.tr,
        context: Get.context,
        onTapPriority1: () {
          LoginFunction().signOut();
        },
      );
    } else {
      GlobalAlertDialog.showDialogError(
        context: Get.context,
        message: "GlobalLabelErrorNullResponse".tr,
      );
    }
    isLoading.value = false;
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
      if (response.message.code == 200) {
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
      } else {
        GlobalAlertDialog.showDialogError(
          context: Get.context,
          message: "GlobalLabelErrorNullResponse".tr,
        );
      }
    }
  }
}
