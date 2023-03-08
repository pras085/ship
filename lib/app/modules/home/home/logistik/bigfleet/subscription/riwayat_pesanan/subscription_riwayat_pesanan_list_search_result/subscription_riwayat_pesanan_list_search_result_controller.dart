import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/api_subscription.dart';

import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/subscription_list_riwayat_pesanan_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/riwayat_pesanan/subscription_riwayat_pesanan_list_search/subscription_riwayat_pesanan_list_search_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SubscriptionRiwayatPesananListSearchResultController
    extends GetxController {
  var listHasilPencarianInlineSpan = [].obs;
  var searchBar = TextEditingController();

  var filterSearch = "".obs;

  var loading = true.obs;
  var listLength = 0.obs;

  var limit = 4;
  final refreshController = RefreshController(initialRefresh: false);
  var change = Map();

  var listData = <SubscriptionListRiwayatPesananModel>[].obs;
  var totalAll = 0.obs;

  @override
  void onInit() async {
    filterSearch.value = Get.arguments[0] as String;
    _setListHasilPencarian();
    searchBar.text = filterSearch.value;

    refreshData();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void refreshData() async {
    try {
      loading.value = true;
      await doFilter(0);
      loading.value = false;
    } catch (e) {
      GlobalAlertDialog.showDialogError(
          message: e.toString(),
          context: Get.context,
          onTapPriority1: () {},
          labelButtonPriority1: "LoginLabelButtonCancel".tr);
    }
  }

  void loadData() {
    doFilter(listLength.value);
  }

  doFilter(int offset) async {
    var body = {
      "Limit": limit.toString(),
      "Offset": offset.toString(),
      "q": filterSearch.value
    };

    var resultFilter =
        await ApiSubscription(context: Get.context, isShowDialogLoading: false)
            .getPacketSubscriptionHistoryByShipper(body);

    if (offset == 0) {
      listLength.value = 0;
      refreshController.resetNoData();
      refreshController.refreshCompleted();
      listData.clear();
    } else {
      refreshController.loadComplete();
    }
    List<dynamic> data = resultFilter["Data"];
    totalAll.value = resultFilter["SupportingData"]["RealCountData"];
    data.forEach((element) {
      listData.add(SubscriptionListRiwayatPesananModel.fromJson(element));
    });
    listLength += data.length;

    if (data.length < limit) {
      refreshController.loadNoData();
    }
  }

  void goToSearchPage() async {
    var result =
        await GetToPage.toNamed<SubscriptionRiwayatPesananListSearchController>(
            Routes.SUBSCRIPTION_RIWAYAT_PESANAN_LIST_SEARCH,
            arguments: [filterSearch.value]);
    if (result != null) {
      filterSearch.value = result;
      _setListHasilPencarian();
      searchBar.text = result;
      refreshController.requestRefresh();
    }
  }

  TextSpan _setTextSpan(String title, bool isBold) {
    return TextSpan(
        text: title,
        style: TextStyle(
            color: isBold ? Colors.black : Color(ListColor.colorDarkBlue2),
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500));
  }

  void _setListHasilPencarian() {
    String isiDesc2 = ("LocationManagementLabelShowLocation".tr)
        .replaceAll("#number", totalAll.value.toString());
    listHasilPencarianInlineSpan.clear();
    listHasilPencarianInlineSpan.add(_setTextSpan(isiDesc2, false));
    listHasilPencarianInlineSpan.add(_setTextSpan(filterSearch.value, true));
    listHasilPencarianInlineSpan.add(_setTextSpan("\"", false));
  }

  void onWillPop() {
    Get.back();
  }
}
