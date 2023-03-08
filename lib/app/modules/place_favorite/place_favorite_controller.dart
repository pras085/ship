import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/all_location_management.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class PlaceFavoriteController extends GetxController {
  bool _isCompleteBuildWidget = false;

  AllLocationManagement _allLocationManagement;

  /*=====.obs=====*/
  final isLoadingGetAllLocationManagement = false.obs;
  final isErrorGetAllLocationManagement = false.obs;

  final listAllLocationManagement = [].obs;
  /*=====.obs=====*/

  @override
  void onInit() {
    _allLocationManagement = AllLocationManagement(isShowLoading: false);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  onCompleteBuildWidget() {
    if (!_isCompleteBuildWidget) {
      _isCompleteBuildWidget = true;
      getLocationManagement();
    }
  }

  Future getLocationManagement() async {
    listAllLocationManagement.clear();
    listAllLocationManagement.refresh();
    isLoadingGetAllLocationManagement.value = true;
    try {
      isErrorGetAllLocationManagement.value =
          !await _allLocationManagement.getAllLocationManagement();
      if (!isErrorGetAllLocationManagement.value) {
        listAllLocationManagement
            .addAll(_allLocationManagement.listData);
        // listAllLocationManagement
        //     .addAllNonNull(_allLocationManagement.listData);
        listAllLocationManagement.refresh();
      }
    } catch (err) {}
    isLoadingGetAllLocationManagement.value = false;
  }

  bool isLengthLocationManagementZero() {
    return listAllLocationManagement.length == 0;
  }

  Future gotoPlaceFavoriteEditor({int index}) async {
    var isRefresh =
        await Get.toNamed(Routes.PLACE_FAVORITE_CRUD, arguments: index);
    if (isRefresh != null) {
      if (isRefresh) {
        getLocationManagement();
      }
    }
  }
}
