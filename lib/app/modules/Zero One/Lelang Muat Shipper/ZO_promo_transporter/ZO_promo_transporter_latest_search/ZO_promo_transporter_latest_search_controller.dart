import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_promo_transporter_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_promo_transporter/ZO_promo_transporter_search_view.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/shared_preferences_helper_zo.dart';

class ZoPromoTransporterLatestSearchController extends GetxController {
  final _data = <ZoPromoTransporterLatestSearchDataModel>[].obs;
  final data = <ZoPromoTransporterLatestSearchDataModel>[].obs;
  var initialSearch = ''.obs;

  @override
  void onInit() {
    initialSearch.value =
        Get.find<ZoPromoTransporterController>().searchQueryObs.value;
    SharedPreferencesHelper.getLatestSearchPromoTransporter()
        .then((json) => ZoPromoTransporterLatestSearchModel.fromJson(json))
        .then((model) => initData(model?.data ?? []))
        .then((_) => onSearchChanged(initialSearch.value));
    super.onInit();
  }

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
    if (_data.isNotEmpty) {
      if (text?.isEmpty ?? true) {
        setDataVisible([..._data]);
      } else {
        setDataVisible(
          _data
              .where((e) =>
                  e.query.toLowerCase().contains(text.trim().toLowerCase()))
              .toList(),
        );
      }
    }
  }

  void onSearchSubmit(String text) {
    final newItem = ZoPromoTransporterLatestSearchDataModel(
      query: text,
      createdAt: DateTime.now(),
    );
    add(newItem);
    // initData(_data);
    // _data.add(newItem);
    // _data.refresh();
    // setDataLocally(_data);
    Get.back(result: newItem.query);
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

  void onTapped(int index, {bool isLatestSearchPage = true}) {
    var tapped = removeAt(index).copyWith(createdAt: DateTime.now());
    add(tapped);
    setDataLocally(_data);
    if (isLatestSearchPage) {
      Get.back(result: tapped.query);
    } else {
      Get.find<ZoPromoTransporterController>().loadPromo(tapped.query);
    }
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
}
