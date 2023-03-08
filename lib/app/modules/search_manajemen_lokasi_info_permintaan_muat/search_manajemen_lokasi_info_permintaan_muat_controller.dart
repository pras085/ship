import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/manajemen_lokasi_api.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/manajemen_lokasi_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/edit_manajemen_lokasi_info_permintaan_muat/edit_manajemen_lokasi_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:latlong/latlong.dart';

import '../../../global_variable.dart';

class SearchManajemenLokasiInfoPermintaanMuatController extends GetxController {
  final isUsingLoadingManualCircular = false.obs;

  final isGettingData = false.obs;

  final listSaveLocation = [].obs;

  final searchTextEditingController = TextEditingController().obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final _listSaveLocationTemp = [];

  final _maxLimitData = 10;

  bool _firstTimeBuildWidget = true;

  Timer _timerGetSaveLocation;

  final isShowClearSearch = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void _startTimerGetSaveLocation() {
    _stopTimerGetSaveLocation();
    _timerGetSaveLocation = Timer(Duration(seconds: 1), () async {
      await onRefreshData(isUsingLoadingManual: true);
    });
  }

  void _stopTimerGetSaveLocation() {
    if (_timerGetSaveLocation != null) _timerGetSaveLocation.cancel();
  }

  void onLoadingData() {
    _getAllManajemenLokasi(
        offset: listSaveLocation.length,
        list: listSaveLocation,
        refreshControllerFunction: () => refreshController,
        clearRefreshController: () {
          refreshController = null;
          refreshController = RefreshController(initialRefresh: false);
        },
        searchValue: searchTextEditingController.value.text);
  }

  Future<dynamic> onRefreshData({bool isUsingLoadingManual = false}) {
    return _getAllManajemenLokasi(
        offset: 0,
        list: listSaveLocation,
        refreshControllerFunction: () => refreshController,
        clearRefreshController: () {
          refreshController = null;
          refreshController = RefreshController(initialRefresh: false);
        },
        searchValue: searchTextEditingController.value.text);
  }

  Future _getAllManajemenLokasi(
      {@required int offset,
      @required RxList<dynamic> list,
      @required RefreshController Function() refreshControllerFunction,
      @required void Function() clearRefreshController,
      // @required Map<String, dynamic> mapSorting,
      // @required Map<String, dynamic> mapFilter,
      String searchValue = "",
      bool isUsingLoadingManual = false}) async {
    try {
      isGettingData.value = true;
      if (offset == 0) {
        list.clear();
        if (searchValue == "") _listSaveLocationTemp.clear();
        if (isUsingLoadingManual) {
          isUsingLoadingManualCircular.value = true;
          clearRefreshController();
        }
      }
      ManajemenLokasiResponseModel response =
          await ManajemenLokasiAPI.getLocation(
              GlobalVariable.userModelGlobal.docID,
              offset: offset,
              limit: _maxLimitData,
              searchValue: searchValue);

      if (response != null) {
        list.addAll(response.listData);
        if (searchValue == "") _listSaveLocationTemp.addAll(response.listData);
        list.refresh();
        if (refreshControllerFunction != null) {
          if (offset == 0) {
            refreshControllerFunction().resetNoData();
            refreshControllerFunction().refreshCompleted();
          } else
            refreshControllerFunction().loadComplete();

          if (list.length < _maxLimitData)
            refreshControllerFunction().loadNoData();
        }
      } else {
        if (refreshControllerFunction != null) {
          if (offset == 0) {
            refreshControllerFunction().resetNoData();
            refreshControllerFunction().refreshCompleted();
          } else
            refreshControllerFunction().loadComplete();
        }
      }
    } catch (err) {}
    isUsingLoadingManualCircular.value = false;
    isGettingData.value = false;
  }

  void onClickEdit(int index) async {
    var result = await Get.toNamed(
        Routes.EDIT_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
        arguments: {
          EditManajemenLokasiInfoPermintaanMuatController
              .manajemenLokasiModelKey: listSaveLocation[index],
          EditManajemenLokasiInfoPermintaanMuatController
                  .typeEditManajemenLokasiInfoPermintaanMuatKey:
              TypeEditManajemenLokasiInfoPermintaanMuat.UPDATE
        });
    Timer(Duration(milliseconds: 300), () {
      Get.delete<EditManajemenLokasiInfoPermintaanMuatController>();
    });
    if (result) onRefreshData(isUsingLoadingManual: true);
  }

  void onCompleteBuildWidget() {
    if (_firstTimeBuildWidget) {
      _firstTimeBuildWidget = false;
      onRefreshData(isUsingLoadingManual: true);
    }
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    isShowClearSearch.value = false;
    addTextSearch(searchTextEditingController.value.text);
  }

  void addTextSearch(String value) {
    isShowClearSearch.value = value.isNotEmpty;
    if (value.isEmpty) {
      _stopTimerGetSaveLocation();
      listSaveLocation.clear();
      listSaveLocation.addAll(_listSaveLocationTemp);
    } else {
      _startTimerGetSaveLocation();
    }
    isShowClearSearch.value = value != "";
  }

  void onClickListManajemenLokasi(int index) {
    Get.back(result: [
      listSaveLocation[index].address,
      LatLng(
          listSaveLocation[index].latitude, listSaveLocation[index].longitude),
      listSaveLocation[index].district,
      listSaveLocation[index].city,
    ]);
  }
}
