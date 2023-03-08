import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/api_tm_subscription.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_subscription_list_riwayat_bf_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_subscription_list_riwayat_su_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/models/tm_tipe_paket.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TMSubscriptionRiwayatLanggananBFDanSUListController
    extends GetxController {
  var searchBar = TextEditingController();
  var focus = false;
  var lastSearch = [].obs;
  var limitLastSearch = 7;

  var loading = true.obs;
  var listLength = 0.obs;

  TMTipeLayananSubscription tipeLayanan;

  var limit = 4;
  final refreshController = RefreshController(initialRefresh: false);

  var listDataBF = <TMSubscriptionListRiwayatBFModel>[].obs;
  var listDataSU = <TMSubscriptionListRiwayatSUModel>[].obs;

  Function() listenRefreshSearch;

  @override
  void onInit() async {
    if (Get.arguments == TMTipeLayananSubscription.BF) {
      tipeLayanan = Get.arguments;
    } else if (Get.arguments == TMTipeLayananSubscription.SU) {
      tipeLayanan = Get.arguments;
    } else {
      Get.back();
    }
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
      "Limit": limit.toString(),
      "Offset": offset.toString()
    };

    var resultFilter;
    if (tipeLayanan == TMTipeLayananSubscription.BF) {
      resultFilter = await ApiTMSubscription(
              context: Get.context, isShowDialogLoading: false)
          .getRiwayatLangganan(body);

      if (offset == 0) {
        listLength.value = 0;
        refreshController.resetNoData();
        refreshController.refreshCompleted();
        listDataBF.clear();
      } else {
        refreshController.loadComplete();
      }
      List<dynamic> data = resultFilter["Data"];
      data.forEach((element) {
        listDataBF.add(TMSubscriptionListRiwayatBFModel.fromJson(element));
      });
      listLength += data.length;

      if (data.length < limit) {
        refreshController.loadNoData();
      }
    } else {
      resultFilter = await ApiTMSubscription(
              context: Get.context, isShowDialogLoading: false)
          .getRiwayatSubUsers(body);

      if (offset == 0) {
        listLength.value = 0;
        refreshController.resetNoData();
        refreshController.refreshCompleted();
        listDataSU.clear();
      } else {
        refreshController.loadComplete();
      }
      List<dynamic> data = resultFilter["Data"];
      data.forEach((element) {
        listDataSU.add(TMSubscriptionListRiwayatSUModel.fromJson(element));
      });
      listLength += data.length;

      if (data.length < limit) {
        refreshController.loadNoData();
      }
    }
  }

  void addListenerSearch(Function listen) {
    listenRefreshSearch = listen;
  }
}
