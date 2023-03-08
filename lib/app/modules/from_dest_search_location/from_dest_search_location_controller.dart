import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/all_location_management.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/loading_dialog.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/core/models/location_management_model.dart';
import 'package:muatmuat/app/core/models/place_details_from_dest.dart';
import 'package:muatmuat/app/modules/from_dest_search_location/from_dest_search_history_response_model.dart';
import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';

class FromDestSearchLocationController extends GetxController {
  final textEditingCityFromController = TextEditingController().obs;
  final textEditingCityDestController = TextEditingController().obs;

  final focusNodeCityFrom = FocusNode().obs;
  final focusNodeCityDest = FocusNode().obs;

  final fromAddressGooglePlaceDetailsModel =
      AddressGooglePlaceDetailsModel().obs;
  final destAddressGooglePlaceDetailsModel =
      AddressGooglePlaceDetailsModel().obs;

  Timer _timerGetCityText;
  Timer _timerSeasonToken;
  String _citySearchKeyword = "";
  String _seasonToken = "";

  bool _isChangeSeasonToken = true;
  bool _isSetMap = false;
  bool _isForFrom = false;
  bool _isForDest = false;

  final markerDest = "marker_dest_icon.png".obs;
  final markerFrom = "marker_from_icon.png".obs;

  bool _isCompleteBuildWidget = false;

  final listAllLocationManagement = [].obs;
  final listCity = [].obs;
  final listHistoryLocation = [].obs;

  final isEmptyResult = false.obs;
  final isShowConfirmButton = false.obs;
  final isGettingDataCity = false.obs;
  final isShowSavedPlace = true.obs;
  final isErrorGetAllLocationManagement = false.obs;
  final isLoadingGetAllLocationManagement = false.obs;
  final isLoadingGetAllHistoryLocation = false.obs;

  @override
  void onInit() {
    fromAddressGooglePlaceDetailsModel.value = null;
    destAddressGooglePlaceDetailsModel.value = null;
    focusNodeCityFrom.value.addListener(() {
      print("autofocus from: " + focusNodeCityFrom.value.hasFocus.toString());
      if (focusNodeCityFrom.value.hasFocus) {
        textEditingCityFromController.value.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textEditingCityFromController.value.text.length);
      }
    });
    focusNodeCityDest.value.addListener(() {
      print("autofocus dest: " + focusNodeCityDest.value.hasFocus.toString());
      if (focusNodeCityDest.value.hasFocus) {
        textEditingCityDestController.value.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textEditingCityDestController.value.text.length);
      }
    });
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    _stopTimerGetCity();
    _stopTimerSeasonToken();
  }

  void addTextCity(String city, TextEditingController textEditingController) {
    if (!_isSetMap) {
      _citySearchKeyword = city;
      if (_citySearchKeyword == "") {
        clearTextFromDest(textEditingController);
        _stopTimerGetCity();
        listCity.clear();
      } else {
        isShowSavedPlace.value = false;
        _startTimerGetCity();
        refreshEditText();
      }
    }
  }

  void _startTimerGetCity() {
    _stopTimerGetCity();
    _timerGetCityText = Timer(Duration(seconds: 1), () async {
      await _searchCity();
    });
  }

  Future forceSearchCity(String city, FocusNode focusNode) async {
    //focusNode.requestFocus();
    _stopTimerGetCity();
    _citySearchKeyword = city;
    await _searchCity();
  }

  Future _searchCity() async {
    if (_citySearchKeyword != "") {
      isGettingDataCity.value = true;
      isEmptyResult.value = false;
      listCity.clear();
      _setSeasonToken();
      var responseBody = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchAutoCompletePlaceAPI(_citySearchKeyword, _seasonToken);
      if (responseBody != null) {
        try {
          listCity.addAll(responseBody);
          // GlobalVariable.showMessageToastDebug(
          //     "listCityCount: " + listCity.length.toString());
        } catch (err) {
          // GlobalVariable.showMessageToastDebug("listCity: " + err.toString());
        }

        // listCity.addAll(responseBody
        //     .map((data) => SearchCityModel.fromJson(responseBody))
        //     .toList());
      } else {
        isEmptyResult.value = true;
      }
      listCity.refresh();
      isGettingDataCity.value = false;
    }
  }

  void _startTimerSeasonToken() {
    _stopTimerSeasonToken();
    _timerSeasonToken = Timer(Duration(minutes: 2), () async {
      _isChangeSeasonToken = true;
    });
  }

  void _stopTimerGetCity() {
    if (_timerGetCityText != null) _timerGetCityText.cancel();
  }

  void _stopTimerSeasonToken() {
    if (_timerSeasonToken != null) _timerSeasonToken.cancel();
  }

  void _setSeasonToken() {
    if (_isChangeSeasonToken) {
      _isChangeSeasonToken = false;
      _seasonToken = Uuid().v4();
      _startTimerSeasonToken();
    }
  }

  Future onClickListCity(String placeId) async {
    _isForFrom = focusNodeCityFrom.value.hasFocus;
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: true,
            isShowDialogError: true)
        .fetchPlaceDetailsAPI(placeId, _seasonToken);
    if (responseBody != null) {
      if (_isForFrom) {
        fromAddressGooglePlaceDetailsModel.value = responseBody;
        textEditingCityFromController.value.text =
            fromAddressGooglePlaceDetailsModel.value.formattedAddress;
      } else {
        destAddressGooglePlaceDetailsModel.value = responseBody;
        textEditingCityDestController.value.text =
            destAddressGooglePlaceDetailsModel.value.formattedAddress;
      }
      _checkFromDestWhenGetAddress();
    } else {
      // GlobalVariable.showMessageToastDebug("responseBody = null");
    }
  }

  Future goToMap() async {
    _isSetMap = true;
    _isForFrom = focusNodeCityFrom.value.hasFocus;
    var result =
        await Get.toNamed(Routes.SEARCH_LOCATION_MAP_MARKER, arguments: {
      'Marker': focusNodeCityFrom.value.hasFocus
          ? markerFrom.value
          : markerDest.value,
      'LatLng': _isForFrom
          ? (fromAddressGooglePlaceDetailsModel.value == null
              ? null
              : fromAddressGooglePlaceDetailsModel.value.latLng)
          : (destAddressGooglePlaceDetailsModel.value == null
              ? null
              : destAddressGooglePlaceDetailsModel.value.latLng)
    }

            // focusNodeCityFrom.value.hasFocus
            //     ? markerFrom.value
            //     : markerDest.value
            );
    if (result != null) {
      if (_isForFrom) {
        fromAddressGooglePlaceDetailsModel.value = result;
        textEditingCityFromController.value.text =
            fromAddressGooglePlaceDetailsModel.value.formattedAddress;
      } else {
        destAddressGooglePlaceDetailsModel.value = result;
        textEditingCityDestController.value.text =
            destAddressGooglePlaceDetailsModel.value.formattedAddress;
      }
    }
    _isSetMap = false;
    _checkFromDestWhenGetAddress();
  }

  void _checkFromDestWhenGetAddress() {
    if (fromAddressGooglePlaceDetailsModel.value != null &&
        destAddressGooglePlaceDetailsModel.value != null) {
      _checkIsShowConfirmButton();
      // Get.back(
      //     result: PlaceDetailsFromDest(
      //         fromAddressGooglePlaceDetailsModel:
      //             fromAddressGooglePlaceDetailsModel.value,
      //         destAddressGooglePlaceDetailsModel:
      //             destAddressGooglePlaceDetailsModel.value));
    } else {
      _checkIsShowConfirmButton();
      if (fromAddressGooglePlaceDetailsModel.value == null) {
        focusNodeCityFrom.value.requestFocus();
      } else {
        focusNodeCityDest.value.requestFocus();
      }
    }
  }

  void getBack() {
    Get.back(
        result: PlaceDetailsFromDest(
            fromAddressGooglePlaceDetailsModel:
                fromAddressGooglePlaceDetailsModel.value,
            destAddressGooglePlaceDetailsModel:
                destAddressGooglePlaceDetailsModel.value));
  }

  void clearTextFromDest(TextEditingController textEditingController) {
    if (textEditingCityFromController.value == textEditingController)
      fromAddressGooglePlaceDetailsModel.value = null;
    else
      destAddressGooglePlaceDetailsModel.value = null;
    textEditingController.text = "";
    isShowSavedPlace.value = true;
    refreshEditText();
  }

  void _checkIsShowConfirmButton() {
    if (fromAddressGooglePlaceDetailsModel.value != null &&
        destAddressGooglePlaceDetailsModel.value != null) {
      isShowConfirmButton.value = true;
    } else {
      isShowConfirmButton.value = false;
    }
  }

  void refreshEditText() {
    _checkIsShowConfirmButton();
    textEditingCityFromController.refresh();
  }

  Future onCompleteBuildWidget() async {
    if (!_isCompleteBuildWidget) {
      _isCompleteBuildWidget = true;
      await getLocationManagement();
      await _getHistoryLocation();
    }
  }

  Future getLocationManagement() async {
    listAllLocationManagement.clear();
    isLoadingGetAllLocationManagement.value = true;
    AllLocationManagement allLocationManagement =
        AllLocationManagement(isShowLoading: false);
    try {
      isErrorGetAllLocationManagement.value =
          !await allLocationManagement.getAllLocationManagement();
      if (!isErrorGetAllLocationManagement.value) {
        // listAllLocationManagement.addAllNonNull(allLocationManagement.listData);
        listAllLocationManagement.addAll(allLocationManagement.listData);
        listAllLocationManagement.refresh();
      }
    } catch (err) {}
    isLoadingGetAllLocationManagement.value = false;
  }

  bool isLengthLocationManagementZero() {
    return listAllLocationManagement.length == 0;
  }

  Future _getHistoryLocation() async {
    listHistoryLocation.clear();
    isLoadingGetAllHistoryLocation.value = true;
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAllHistoryLocation();
    if (responseBody != null) {
      try {
        FromDestSearchHistoryResponseModel fromDestSearchHistoryResponseModel =
            FromDestSearchHistoryResponseModel.fromJson(responseBody);
        listHistoryLocation.addAll(fromDestSearchHistoryResponseModel.listData);
      } catch (err) {}
    } else {
      isEmptyResult.value = true;
    }
    listHistoryLocation.refresh();
    isLoadingGetAllHistoryLocation.value = false;
  }

  // @override
  // void onInit() {}

  // @override
  // void onReady() {}

  // @override
  // void onClose() {}

  // void setValueFromDest(String from, String dest) {
  //   _locationTruckReadyController.setDest(dest);
  // }

  // void gotoSearchCityFrom() async {
  //   textEditingCityFromController.value.text = await _gotoSearchCity();
  // }

  // void gotoSearchCityDest() async {
  //   textEditingCityDestController.value.text = await _gotoSearchCity();
  // }

  // Future<String> _gotoSearchCity() async {
  //   var returnSearchCity = await Get.toNamed(Routes.SEARCH_CITY);
  //   return returnSearchCity.toString();
  // }
}
