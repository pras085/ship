import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/all_location_management.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/loading_dialog.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/core/models/head_truck_response_model.dart';
import 'package:muatmuat/app/core/models/location_management_model.dart';
import 'package:muatmuat/app/core/models/place_details_from_dest.dart';
import 'package:muatmuat/app/modules/location_truck_ready/location_truck_ready_controller.dart';
import 'package:muatmuat/app/core/models/carrier_truck_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_response_model.dart';
import 'package:muatmuat/app/core/models/head_truck_model.dart';
import 'package:muatmuat/app/modules/location_truck_ready_search/location_truck_ready_search_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class LocationTruckReadySearchController extends GetxController {
  //LocationTruckReadyController _locationTruckReadyController = Get.find();

  final textEditingCityFromController = TextEditingController().obs;
  final textEditingCityDestController = TextEditingController().obs;
  final textEditingTypeTruckController = TextEditingController().obs;
  final textEditingNumberTruckController = TextEditingController().obs;

  final placeDetailsFromDest = PlaceDetailsFromDest().obs;

  final markerDest = "marker_dest_icon.png".obs;
  final markerFrom = "marker_from_icon.png".obs;

  final valueHeadTruck = 'LTRChooseHeadTruck'.tr.obs;
  final valueCarrierTruck = 'LTRChooseCarrierTruck'.tr.obs;

  final listHeadTruck =
      [HeadTruckModel(id: "0", description: 'LTRChooseHeadTruck'.tr)].obs;
  final listCarrierTruck =
      [CarrierTruckModel(id: "0", description: 'LTRChooseCarrierTruck'.tr)].obs;

  bool _isFromLocationTruckReadyResult = false;

  String _idHeadTruck = "";
  String _idCarrierTruck = "";

  @override
  void onInit() async {
    await _getHeadTruck();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void _checkIsFromLocationTruckReadyResult() {
    LocationTruckReadyController locationTruckReadyController;
    try {
      locationTruckReadyController = Get.find();
    } catch (err) {}
    _isFromLocationTruckReadyResult = locationTruckReadyController != null;
  }

  void setValueFromDest(String from, String dest) {
    //_locationTruckReadyController.setDest(dest);
  }

  Future gotoSearchCityFromDest() async {
    var result = await Get.toNamed(Routes.FROM_DEST_SEARCH_LOCATION);
    if (result != null) {
      placeDetailsFromDest.value = result;
      textEditingCityFromController.value.text = placeDetailsFromDest
          .value.fromAddressGooglePlaceDetailsModel.formattedAddress;
      textEditingCityDestController.value.text = placeDetailsFromDest
          .value.destAddressGooglePlaceDetailsModel.formattedAddress;
    }
  }

  Future gotoResult() async {
    if (_idHeadTruck == "" ||
        _idCarrierTruck == "" ||
        placeDetailsFromDest.value.fromAddressGooglePlaceDetailsModel == null ||
        placeDetailsFromDest.value.destAddressGooglePlaceDetailsModel == null) {
      if (placeDetailsFromDest.value.fromAddressGooglePlaceDetailsModel ==
              null ||
          placeDetailsFromDest.value.destAddressGooglePlaceDetailsModel ==
              null) {
        GlobalAlertDialog.showDialogError(
            message: 'LTRSearchFromDestEmptyError'.tr, context: Get.context);
      } else if (_idHeadTruck == "") {
        GlobalAlertDialog.showDialogError(
            message: 'LTRSearchHeadTruckEmptyError'.tr, context: Get.context);
      } else {
        GlobalAlertDialog.showDialogError(
            message: 'LTRSearchCarrierTruckEmptyError'.tr,
            context: Get.context);
      }
    } else {
      _saveHistoryLocation();
      if (_isFromLocationTruckReadyResult)
        Get.back(result: placeDetailsFromDest.value);
      else {
        var result = await ApiHelper(
                context: Get.context,
                isShowDialogLoading: true,
                isShowDialogError: false)
            .fetchSearchLocationTruckReady(
                placeDetailsFromDest
                    .value.fromAddressGooglePlaceDetailsModel.cityName,
                placeDetailsFromDest
                    .value.destAddressGooglePlaceDetailsModel.cityName,
                _idHeadTruck,
                _idCarrierTruck);
        try {
          if (result != null) {
            LocationTruckReadySearchResponseModel
                locationTruckReadySearchResponse =
                LocationTruckReadySearchResponseModel.fromJson(result);
            if (locationTruckReadySearchResponse.message.code == 200) {
              if (locationTruckReadySearchResponse.listData.length > 0) {
                Get.offNamed(
                  Routes.LOCATION_TRUCK_READY,
                  arguments: {
                    "FromDest": placeDetailsFromDest.value,
                    "ListTransporter": locationTruckReadySearchResponse.listData
                  },
                );
              } else {
                GlobalAlertDialog.showDialogError(
                    message: 'No Result', context: Get.context);
              }

              //listCarrierTruck.addAll(carrierTruckResponseModel.listData);
            }
          }
        } catch (err) {}
      }
    }
  }

  void setHeadTruck(String value) {
    _getIDHeadTruck(value);
    if (_idHeadTruck != "0")
      _getCarrierTruck(_idHeadTruck);
    else
      _clearListCarrierTruck();
  }

  void setCarrierTruck(String value) {
    _getIDCarrierTruck(value);
  }

  void _getIDHeadTruck(String value) {
    valueHeadTruck.value = value;
    for (HeadTruckModel data in listHeadTruck) {
      if (data.description == value) {
        _idHeadTruck = data.id;
        break;
      }
    }
  }

  void _getIDCarrierTruck(String value) {
    valueCarrierTruck.value = value;
    for (CarrierTruckModel data in listCarrierTruck) {
      if (data.description == value) {
        _idCarrierTruck = data.id;
        break;
      }
    }
  }

  Future _getHeadTruck() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchHeadTruck();
    try {
      if (result != null) {
        HeadTruckResponseModel headTruckResponseModel =
            HeadTruckResponseModel.fromJson(result);
        if (headTruckResponseModel.message.code == 200) {
          listHeadTruck.addAll(headTruckResponseModel.listData);
        }
      }
    } catch (err) {}
    listHeadTruck.refresh();
  }

  Future _getCarrierTruck(String idHeadTruck) async {
    _clearListCarrierTruck();
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: true,
            isShowDialogError: false)
        .fetchCarrierTruck(headID: idHeadTruck);
    try {
      if (result != null) {
        CarrierTruckResponseModel carrierTruckResponseModel =
            CarrierTruckResponseModel.fromJson(result);
        if (carrierTruckResponseModel.message.code == 200) {
          listCarrierTruck.addAll(carrierTruckResponseModel.listData);
        }
      }
    } catch (err) {}
    listCarrierTruck.refresh();
  }

  void _clearListCarrierTruck() {
    valueCarrierTruck.value = 'LTRChooseCarrierTruck'.tr;
    for (int i = listCarrierTruck.length - 1; i > 0; i--) {
      listCarrierTruck.removeAt(i);
    }
    listCarrierTruck.refresh();
  }

  Future _saveHistoryLocation() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAddHistoryLocation(
            address: placeDetailsFromDest
                .value.destAddressGooglePlaceDetailsModel.formattedAddress,
            latitude: placeDetailsFromDest
                .value.destAddressGooglePlaceDetailsModel.latLng.latitude
                .toString(),
            longitude: placeDetailsFromDest
                .value.destAddressGooglePlaceDetailsModel.latLng.longitude
                .toString(),
            district: placeDetailsFromDest
                .value.destAddressGooglePlaceDetailsModel.districtName);
    try {
      if (result != null) {
        // HeadTruckResponseModel headTruckResponseModel =
        //     HeadTruckResponseModel.fromJson(result);
        // if (headTruckResponseModel.message.code == 200) {
        //   listHeadTruck.addAll(headTruckResponseModel.listData);
        // }
      }
    } catch (err) {}
    //listHeadTruck.refresh();
  }
}
