import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/maps_function.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_search_lokasi/ZO_search_lokasi_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:geocoding/geocoding.dart' as geoc;

class ZoMapFullScreenTambahController extends GetxController {
  static final String latLngKey = "LatLng";
  static final String addressKey = "Address";
  // static final String imageMarkerKey = "ImageMarker";
  static final String listCurLok = "listCurLok";
  static final String typePickupDestinasi = "pickupDestinasi";
  static final String latLngKeyList = "LatLngList";
  static final String latLngList = "LatLngListVal";
  static final String kotaListPar = "kotaListPar";
  static final String provinsiListPar = "provinsiListPar";

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

  LatLng latLngPositionMarker;

  LatLng _latLng;
  var addressForm = [];

  var locationValid = true.obs;
  var showWarning = false.obs;

  var listCurentLocation = [].obs;
  List iconLocation = [
    'assets/pin1.svg',
    'assets/pin2_biru.svg',
    'assets/pin3_biru.svg',
    'assets/pin4_biru.svg',
    'assets/pin5_biru.svg'
  ];

  var boolif = [].obs;
  var idx = 0.obs;
  var isLoading = [].obs;

  var ltlg = LatLng(0, 0).obs;
  var listReturnLokasiAddress = [].obs;
  var listReturnLatlong = [].obs;

  var isCanChose = false.obs;
  var provinsiList = [].obs;
  var placeID = [].obs;
  var kota = [].obs;
  var pickupDestinasi = "".obs;
  List<TextEditingController> controllerForm = [];
  var ltlngval = [].obs;
  var addressListVal = [].obs;
  var provinsiListVal = [].obs;
  var kotaListVal = [].obs;

  @override
  Future<void> onInit() async {
    informationMarker.value.formattedAddress = "";
    if (Get.arguments != null) {
      _latLng = Get.arguments[latLngKey];
      informationMarker.value.formattedAddress =
          Get.arguments[addressKey] ?? "";
      ltlngval.clear();
      ltlngval.value = List.from(Get.arguments[latLngList]);
      addressListVal.clear();
      provinsiListVal.clear();
      provinsiListVal.value = List.from(Get.arguments[provinsiListPar]);
      kotaListVal.clear();
      kotaListVal.value = List.from(Get.arguments[kotaListPar]);
      for (var l = 0; l < ltlngval.length; l++) {
        List<geoc.Placemark> placemark = await geoc.placemarkFromCoordinates(
            ltlngval[l].latitude, ltlngval[l].longitude);
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
              : (placemark[0].thoroughfare +
                  " " +
                  placemark[0].subThoroughfare);
          if (placemark[0].subLocality.isNotEmpty)
            street += ", " + placemark[0].subLocality;
          if (placemark[0].locality.isNotEmpty)
            street += ", " + placemark[0].locality;
          if (placemark[0].subAdministrativeArea.isNotEmpty)
            street += ", " + placemark[0].subAdministrativeArea;
          if (street.split(",").length < 3 ||
              placemark[0].isoCountryCode != "ID") {
            locationValid.value = false;
            showWarning.value = true;
            // informationMarker.value.formattedAddress = "Empty";
            // informationMarker.refresh();
          } else {
            locationValid.value = true;
            showWarning.value = false;
            informationMarker.value.formattedAddress = street;
            // informationMarker.value.latLng =
            //     LatLng(ltlngval[l].latitude, ltlngval[l].longitude);

            // ltlg.value = informationMarker.value.latLng;
            // informationMarker.value.cityName = placemark[0].administrativeArea;
            // informationMarker.value.districtName =
            //     placemark[0].subAdministrativeArea;

            // provinsiListVal.add("");
            // kotaListVal.add("");

            informationMarker.refresh();
          }
        } else
          GlobalAlertDialog.showDialogError(
              message: "Gagal", context: Get.context);
      }
      // imageMarker = Get.arguments[imageMarkerKey] ??
      //     Icon(
      //       Icons.location_on,
      //       color: Color(ListColor.color4),
      //       size: 30,
      //     );
      _isFirstTimeOnChangePosition =
          informationMarker.value.formattedAddress != "";
      listCurentLocation.clear();
      listCurentLocation.value = List.from(Get.arguments[listCurLok]);
      boolif.clear();
      listReturnLokasiAddress.clear();
      listReturnLatlong.clear();
      provinsiList.clear();
      placeID.clear();
      kota.clear();
      isLoading.clear();

      addressForm.clear();
      addressForm = List.from(Get.arguments[latLngKeyList]);
      for (var k = 0; k < addressForm.length; k++) {
        controllerForm.add(TextEditingController());
        controllerForm[k].text = addressForm[k].text;
        // var dress = "";
        // if (addressForm[k].text == "") {
        //   dress = informationMarker.value.formattedAddress;
        // } else {
        //   dress = addressForm[k].text;
        // }
        // controllerForm[k].text = dress;
        addressListVal.add(addressForm[k].text);
      }

      for (var i = 0; i < listCurentLocation.value.length; i++) {
        boolif.add(false);
        listReturnLokasiAddress.add(addressListVal[i]);
        listReturnLatlong.add(ltlngval[i]);
        provinsiList.add(provinsiListVal[i].text);
        kota.add(kotaListVal[i].text);
        iconLocation[i];

        isLoading.add(false);
        placeID.add("0");
      }
    }
    pickupDestinasi.value = Get.arguments[typePickupDestinasi];
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void cariLokasi(String argu, int idx) async {
    isLoading[idx] = true;
    var curLok;
    curLok = listCurentLocation[idx];
    var result = await GetToPage.toNamed<ZoSearchLokasiController>(
        Routes.ZO_SEARCH_LOKASI,
        arguments: [argu, idx, "0", curLok],
        preventDuplicates: false);
    if (result != null) {
      if (result == "loading") {
        isLoading[idx] = false;
      } else {
        controllerForm[idx].text = result["val"];
        listReturnLokasiAddress.removeAt(idx);
        listReturnLokasiAddress.insert(idx, result["val"]);

        if (result["placeId"] != "") {
          placeID.removeAt(idx);
          placeID.insert(idx, result["placeId"]);
          getLokasiDetail(result["placeId"], result["idx"]);
        } else {
          listReturnLatlong.removeAt(idx);
          listReturnLatlong.insert(idx, result["ltlg"]);
          kota.removeAt(idx);
          kota.insert(idx, result["kota"].toString());
          provinsiList.removeAt(idx);
          provinsiList.insert(idx, result["provinsi"]);
          if (result["ltlg"] != "") {
            listCurentLocation[idx] = result["ltlg"];
            mapController.value
                .move(listCurentLocation[idx], GlobalVariable.zoomMap);
          }
          isLoading[idx] = false;
        }
      }
    }
  }

  void cariLokasiDestinasi(String argu, int idx) async {
    isLoading[idx] = true;
    var curLok;
    curLok = listCurentLocation[idx];
    var result = await GetToPage.toNamed<ZoSearchLokasiController>(
        Routes.ZO_SEARCH_LOKASI,
        arguments: [argu, idx, "1", curLok],
        preventDuplicates: false);
    if (result != null) {
      if (result == "loading") {
        isLoading[idx] = false;
      } else {
        controllerForm[idx].text = result["val"];
        listReturnLokasiAddress.removeAt(idx);
        listReturnLokasiAddress.insert(idx, result["val"]);

        if (result["placeId"] != "") {
          placeID.removeAt(idx);
          placeID.insert(idx, result["placeId"]);
          getLokasiDetail(result["placeId"], result["idx"]);
        } else {
          listReturnLatlong.removeAt(idx);
          listReturnLatlong.insert(idx, result["ltlg"]);
          kota.removeAt(idx);
          kota.insert(idx, result["kota"].toString());
          provinsiList.removeAt(idx);
          provinsiList.insert(idx, result["provinsi"]);
          if (result["ltlg"] != "") {
            listCurentLocation[idx] = result["ltlg"];
            mapController.value
                .move(listCurentLocation[idx], GlobalVariable.zoomMap);
          }
          isLoading[idx] = false;
        }
      }
    }
  }

  Future<void> getLokasiDetail(String placeid, int idx) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchInfoFromAddress(placeID: placeid);

    listReturnLatlong.removeAt(idx);
    listReturnLatlong.insert(idx, LatLng(res["lat"], res["lng"]));
    kota.removeAt(idx);
    kota.insert(idx, res["city"].toString());
    provinsiList.removeAt(idx);
    provinsiList.insert(idx, res["province"]);
    if (res["lat"] != "") {
      listCurentLocation[idx] = LatLng(res["lat"], res["lng"]);
      mapController.value.move(listCurentLocation[idx], GlobalVariable.zoomMap);
      // mapController.value.onReady.then((value) {

      // });
    }
    isLoading[idx] = false;
    // getProvinceFilter(res["province"], idx);

    // provinsiMulti[idx].text = res["province"];

    // city[idx].text = res["city"].toString();
    // lat[idx].text = res["lat"].toString();
    // lng[idx].text = res["lng"].toString();
    // currentLocation.value = LatLng(res["lat"], res["lng"]);
    // currentLocationList[idx] = LatLng(res["lat"], res["lng"]);
    // listCurentLocation = [];
    // listCurentLocation = currentLocationList;
    // mapController.onReady.then((value) {
    //   mapController.move(currentLocationList[idx], 6);
    // });
  }

  getProvinceFilter(String province, int idx) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchProvinceFilter(province);
    if (res["Message"]["Code"] == 200) {
      (res["Data"] as List).forEach((element) {
        provinsiList.removeAt(idx);
        provinsiList.insert(idx, element["Description"].toString());
        isLoading[idx] = false;

        // provinsiMulti[idx].text = element["Description"].toString();
        // provinceIdList[idx].text = element["Code"].toString();
      });
    }
  }

  // void setPositionMarker(LatLng latLng) async {
  //   if (_isFirstTimeOnChangePosition)
  //     _isFirstTimeOnChangePosition = false;
  //   else {
  //     await mapController.value.onReady;
  //     informationMarker.value.formattedAddress = "";
  //     informationMarker.refresh();
  //     latLngPositionMarker = latLng;
  //     ltlg.value = latLng;
  //     _startTimerGetPositionMarker();
  //   }
  // }

  // void _startTimerGetPositionMarker() {
  //   _stopTimerGetPositionMarker();
  //   _timerGetPositionMarker = Timer(Duration(seconds: 1), () async {
  //     if (isGetLocationUser.value)
  //       await _getInformationFromLatLng();
  //     else
  //       setPositionMarker(latLngPositionMarker);
  //   });
  // }

  // void _stopTimerGetPositionMarker() {
  //   if (_timerGetPositionMarker != null) _timerGetPositionMarker.cancel();
  // }

  // void _addMarkertoList(LatLng latLng, int index) {
  //   if (listMarker.length > 0 && index < listMarker.length) {
  //     listMarker[index] = latLng;
  //   } else {
  //     listMarker.add(latLng);
  //   }
  // }

  // Future _getInformationFromLatLng() async {
  //   informationMarker.value.formattedAddress = "";
  //   informationMarker.value.cityName = "";
  //   informationMarker.value.districtName = "";
  //   List<geoc.Placemark> placemark = await geoc.placemarkFromCoordinates(
  //       latLngPositionMarker.latitude, latLngPositionMarker.longitude);
  //   if (placemark.length > 0) {
  //     // GlobalAlertDialog.showDialogError(.showAlertDialogSuccess(
  //     //     placemark[0].country +
  //     //         ";" +
  //     //         placemark[0].locality +
  //     //         ";" +
  //     //         placemark[0].administrativeArea +
  //     //         ";" +
  //     //         placemark[0].postalCode +
  //     //         ";" +
  //     //         placemark[0].name +
  //     //         ";" +
  //     //         placemark[0].isoCountryCode +
  //     //         ";" +
  //     //         placemark[0].subLocality +
  //     //         ";" +
  //     //         placemark[0].subThoroughfare +
  //     //         ";" +
  //     //         placemark[0].thoroughfare +
  //     //         ";" +
  //     //         placemark[0].subAdministrativeArea +
  //     //         ";end",
  //     //     Get.context);
  //     String street = placemark[0].thoroughfare == "" &&
  //             placemark[0].subThoroughfare == ""
  //         ? placemark[0].street
  //         : (placemark[0].thoroughfare + " " + placemark[0].subThoroughfare);
  //     if (placemark[0].subLocality.isNotEmpty)
  //       street += ", " + placemark[0].subLocality;
  //     if (placemark[0].locality.isNotEmpty)
  //       street += ", " + placemark[0].locality;
  //     if (placemark[0].subAdministrativeArea.isNotEmpty)
  //       street += ", " + placemark[0].subAdministrativeArea;
  //     if (street.split(",").length < 3 || placemark[0].isoCountryCode != "ID") {
  //       locationValid.value = false;
  //       showWarning.value = true;
  //       // informationMarker.value.formattedAddress = "Empty";
  //       // informationMarker.refresh();
  //     } else {
  //       locationValid.value = true;
  //       showWarning.value = false;
  //       informationMarker.value.formattedAddress = street;
  //       informationMarker.value.latLng = LatLng(
  //           latLngPositionMarker.latitude, latLngPositionMarker.longitude);

  //       ltlg.value = informationMarker.value.latLng;

  //       informationMarker.value.cityName = placemark[0].administrativeArea;
  //       informationMarker.value.districtName =
  //           placemark[0].subAdministrativeArea;
  //       informationMarker.refresh();
  //     }
  //   } else
  //     GlobalAlertDialog.showDialogError(message: "Gagal", context: Get.context);
  // }

  void getBack() {
    Get.back(result: locationValid.value ? informationMarker.value : null);
  }

  // void _getLocationUser() {
  //   _location.onLocationChanged.listen((LocationData current) {
  //     if (current.accuracy < 50) {
  //       if (!_isGetLocationUser) {
  //         _isGetLocationUser = true;
  //         currentLocation.value = LatLng(current.latitude, current.longitude);
  //         //_addMarkertoList(currentLocation.value, 0);
  //         isGetLocationUser.value = true;
  //         mapController.value
  //             .move(currentLocation.value, GlobalVariable.zoomMap);
  //       }
  //     }
  //   });
  // }

  // void onCompleteBuildWidget() async {
  //   if (_isFirstTimeBuildWidget) {
  //     _isFirstTimeBuildWidget = false;
  //     await mapController.value.onReady;
  //     if (_latLng == null) {
  //       _getLocationUser();
  //     } else {
  //       currentLocation.value = LatLng(_latLng.latitude, _latLng.longitude);
  //       isGetLocationUser.value = true;
  //       mapController.value.move(listCurentLocation[0], GlobalVariable.zoomMap);
  //     }
  //   }
  // }

  void onApplyButton() {
    // if (informationMarker.value.formattedAddress != "") {
    Get.back(result: {
      "address": listReturnLokasiAddress.value,
      "ltlg": listReturnLatlong.value,
      "provinsi": provinsiList.value,
      "kota": kota.value,
      "placeId": placeID.value
    });
    var t = {
      "address": listReturnLokasiAddress.value,
      "ltlg": listReturnLatlong.value,
      "provinsi": provinsiList.value,
      "kota": kota.value,
      "placeId": placeID.value
    };
    print("KAKAKAKAKA loh $t");
    // }
  }
}
