import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_select_location/ZO_map_select_location_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
// import 'package:permission_handler/permission_handler.dart';

class ZoSearchLokasiController extends GetxController {
  //kosong
  var argumn = "".obs;
  var searchValue = "".obs;
  var cariList = [].obs;

  var terakhirDicariList = [].obs;
  var transaksiTerakhirList = [].obs;
  var typepickup = "".obs;

  //textediting
  final cari = TextEditingController().obs;
  final MapController mapController = MapController();
  var currentLocation = LatLng(0, 0).obs;
  var listRoute = List<LatLng>().obs;
  var location = Location();

  var idx = 0.obs;

  @override
  void onInit() async {
    argumn.value = Get.arguments[0];
    idx.value = Get.arguments[1];
    typepickup.value = Get.arguments[2];
    currentLocation.value = Get.arguments[3];
    if (argumn.value == "") {}
    getTerakhirDicari();
    getTransaksiTerakhir();
    // getCurrentLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void addTextSearch(String value) {
    searchValue.value = value;
    getStreet(value);
  }

  void onSubmitSearch() {
    if (searchValue.isNotEmpty) {
      getStreet(searchValue.value);
    }
  }

  void onClearSearch() {
    cari.value.text = "";
    cariList.clear();
  }

  void chooseLokasi(String val, String placeid) {
    Map backVal = {
      "idx": idx.value,
      "val": val,
      "placeId": placeid,
      "ltlg": "",
      "provinsi": "",
      "kota": ""
    };
    Get.back(result: backVal);
  }

  Future getStreet(String phrase) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getLokasiPeta(phrase);

    if (res["Message"]["Code"] == 200) {
      cariList.clear();
      (res["Data"] as List).forEach((element) {
        cariList.add(element);
      });
    } else {
      // failedGetListFilter.value = true;
    }
  }

  getTerakhirDicari() async {
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      var res = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getTerakhirDicari(typepickup.value, resLoginAs["LoginAs"].toString(),
              GlobalVariable.role);

      if (res["Message"]["Code"] == 200) {
        terakhirDicariList.clear();
        (res["Data"] as List).forEach((element) {
          terakhirDicariList.add(element);
        });
      }
    }
  }

  getTransaksiTerakhir() async {
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      var res = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getTransaksiTerakhir(typepickup.value,
              resLoginAs["LoginAs"].toString(), GlobalVariable.role);

      if (res["Message"]["Code"] == 200) {
        transaksiTerakhirList.clear();
        (res["Data"] as List).forEach((element) {
          transaksiTerakhirList.add(element);
        });
      }
    }
  }

  // Future<void> getCurrentLocation() async {
  //   Location location = new Location();

  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   LocationData _locationData;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _locationData = await location.getLocation();

  //   currentLocation.value =
  //       LatLng(_locationData.latitude, _locationData.longitude);
  //   // mapController.onReady.then((value) {
  //   //   mapController.move(currentLocation.value, 17.7);
  //   // });

  //   // print("KFAFHGDHCA ${currentLocation.value}");
  // }

  toMapPinSelect() async {
    var result = await GetToPage.toNamed<ZoMapSelectLocationController>(
        Routes.ZO_MAP_SELECT_LOCATION,
        arguments: {
          ZoMapSelectLocationController.latLngKey: currentLocation.value,
          ZoMapSelectLocationController.imageMarkerKey: SvgPicture.asset(
            argumn.value,
            width: GlobalVariable.ratioFontSize(Get.context) * 26.27,
            height: GlobalVariable.ratioFontSize(Get.context) * 34,
          ),
          ZoMapSelectLocationController.addressKey: "",
          ZoMapSelectLocationController.idx: idx.value
        });
    if (result != null) {
      Get.back(result: {
        "idx": result[2],
        "val": result[1],
        "placeId": "",
        "ltlg": result[0],
        "provinsi": result[3],
        "kota": result[4]
      });
      // _getDataInfoFromAddressPlaceID(
      //     address: result[1], latLngParam: result[0]);
    }
  }
}
