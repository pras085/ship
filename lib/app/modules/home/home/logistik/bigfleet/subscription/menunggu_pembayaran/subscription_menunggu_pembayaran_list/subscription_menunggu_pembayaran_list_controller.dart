import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/api_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/models/subscription_list_menunggu_pembayaran_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SubscriptionMenungguPembayaranListController extends GetxController {
  var searchBar = TextEditingController();
  var focus = false;
  var lastSearch = [].obs;
  var limitLastSearch = 7;
  var refreshList = false;
  var refreshPanel = false;

  var loading = true.obs;
  var listLength = 0.obs;

  var limit = 4;
  final refreshController = RefreshController(initialRefresh: false);

  var listData = <SubscriptionListMenungguPembayaranModel>[].obs;

  Function() listenRefreshSearch;

  @override
  void onInit() async {
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
      "Role": "2",
      // "Limit": limit.toString(),
      // "Offset": offset.toString()
    };

    var resultFilter;
    resultFilter =
        await ApiSubscription(context: Get.context, isShowDialogLoading: false)
            .getPacketSubscriptionActiveByShipper(body);

    if (offset == 0) {
      listLength.value = 0;
      refreshController.resetNoData();
      refreshController.refreshCompleted();
      listData.clear();
    } else {
      refreshController.loadComplete();
    }
    List<dynamic> data = resultFilter["Data"];
    data.forEach((element) {
      listData.add(SubscriptionListMenungguPembayaranModel.fromJson(element));
    });
    listLength += data.length;

    // if (data.length < limit) {
    refreshController.loadNoData();
    // }
  }

  void addListenerSearch(Function listen) {
    listenRefreshSearch = listen;
  }
}
