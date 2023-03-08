import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:geocoding/geocoding.dart' as geoc;
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/global_variable.dart';

class SearchLocationMapMarkerController extends GetxController {
  static final String latLngKey = "LatLng";
  static final String addressKey = "Address";
  static final String imageMarkerKey = "ImageMarker";

  final isGetLocationUser = false.obs;

  var currentLocation = LatLng(0, 0).obs;

  final informationMarker = AddressGooglePlaceDetailsModel().obs;

  final listMarker = [].obs;

  final mapController = MapController().obs;

  Widget imageMarker;

  bool _isGetLocationUser = false;
  bool _isFirstTimeBuildWidget = true;
  bool _isFirstTimeOnChangePosition = true;

  var _location = Location();

  Timer _timerGetPositionMarker;

  LatLng _latLngPositionMarker;

  LatLng _latLng;

  var locationValid = true.obs;
  var showWarning = false.obs;

  @override
  void onInit() {
    informationMarker.value.formattedAddress = "";
    if (Get.arguments != null) {
      _latLng = Get.arguments[latLngKey];
      informationMarker.value.formattedAddress =
          Get.arguments[addressKey] ?? "";
      imageMarker = Get.arguments[imageMarkerKey] ??
          Icon(
            Icons.location_on,
            color: Color(ListColor.color4),
            size: GlobalVariable.ratioWidth(Get.context) * 29,
          );
      _isFirstTimeOnChangePosition =
          informationMarker.value.formattedAddress != "";
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void setPositionMarker(LatLng latLng) async {
    if (_isFirstTimeOnChangePosition)
      _isFirstTimeOnChangePosition = false;
    else {
      await mapController.value.onReady;
      informationMarker.value.formattedAddress = "";
      informationMarker.refresh();
      _latLngPositionMarker = latLng;
      _startTimerGetPositionMarker();
    }
  }

  void _startTimerGetPositionMarker() {
    _stopTimerGetPositionMarker();
    _timerGetPositionMarker = Timer(Duration(seconds: 1), () async {
      if (isGetLocationUser.value)
        await _getInformationFromLatLng();
      else
        setPositionMarker(_latLngPositionMarker);
    });
  }

  void _stopTimerGetPositionMarker() {
    if (_timerGetPositionMarker != null) _timerGetPositionMarker.cancel();
  }

  void _addMarkertoList(LatLng latLng, int index) {
    if (listMarker.length > 0 && index < listMarker.length) {
      listMarker[index] = latLng;
    } else {
      listMarker.add(latLng);
    }
  }

  Future _getInformationFromLatLng() async {
    informationMarker.value.formattedAddress = "";
    List<geoc.Placemark> placemark;
    try{
      placemark = await geoc.placemarkFromCoordinates(
        _latLngPositionMarker.latitude, _latLngPositionMarker.longitude);
    } catch (e){
      GlobalAlertDialog.showDialogError(context: Get.context, message: e.toString());
    }
    if (placemark.length > 0) {
      // GlobalAlertDialog.showDialogError(.showAlertDialogSuccess(
      //     placemark[0].country +
      //         ";" +
      //         placemark[0].locality +
      //         ";" +
      //         placemark[0].administrativeArea +
      //         ";" +
      //         placemark[0].postalCode +
      //         ";" +
      //         placemark[0].name +
      //         ";" +
      //         placemark[0].isoCountryCode +
      //         ";" +
      //         placemark[0].subLocality +
      //         ";" +
      //         placemark[0].subThoroughfare +
      //         ";" +
      //         placemark[0].thoroughfare +
      //         ";" +
      //         placemark[0].subAdministrativeArea +
      //         ";end",
      //     Get.context);
      String street = placemark[0].thoroughfare == "" &&
              placemark[0].subThoroughfare == ""
          ? placemark[0].street
          : (placemark[0].thoroughfare + " " + placemark[0].subThoroughfare);
      if (placemark[0].subLocality.isNotEmpty)
        street += ", " + placemark[0].subLocality;
      if (placemark[0].locality.isNotEmpty)
        street += ", " + placemark[0].locality;
      if (placemark[0].subAdministrativeArea.isNotEmpty)
        street += ", " + placemark[0].subAdministrativeArea;
      if (street.split(",").length < 3 || placemark[0].isoCountryCode != "ID") {
        locationValid.value = false;
        showWarning.value = true;
        // informationMarker.value.formattedAddress = "Empty";
        // informationMarker.refresh();
      } else {
        locationValid.value = true;
        showWarning.value = false;
        informationMarker.value.formattedAddress = street;
        informationMarker.value.latLng = LatLng(
            _latLngPositionMarker.latitude, _latLngPositionMarker.longitude);
        informationMarker.refresh();
      }
    } else
      GlobalAlertDialog.showDialogError(message: "Gagal", context: Get.context);
  }

  void getBack() {
    Get.back(result: locationValid.value ? informationMarker.value : null);
  }

  void _getLocationUser() {
    _location.onLocationChanged.listen((LocationData current) {
      if (current.accuracy < 50) {
        if (!_isGetLocationUser) {
          _isGetLocationUser = true;
          currentLocation.value = LatLng(current.latitude, current.longitude);
          //_addMarkertoList(currentLocation.value, 0);
          isGetLocationUser.value = true;
          mapController.value
              .move(currentLocation.value, GlobalVariable.zoomMap);
        }
      }
    });
  }

  void onCompleteBuildWidget() async {
    if (_isFirstTimeBuildWidget) {
      await mapController.value.onReady;
      if (_latLng == null) {
        _isFirstTimeBuildWidget = false;
        _getLocationUser();
      } else {
        currentLocation.value = LatLng(_latLng.latitude, _latLng.longitude);
        isGetLocationUser.value = true;
        _isFirstTimeOnChangePosition = true;
        mapController.value.move(currentLocation.value, GlobalVariable.zoomMap);
      }
    }
  }

  void onApplyButton() {
    if (informationMarker.value.formattedAddress != "")
      Get.back(result: [
        _latLngPositionMarker,
        informationMarker.value.formattedAddress
      ]);
  }
}
