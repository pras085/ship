import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/loading_dialog.dart';
import 'package:muatmuat/app/modules/choose_area_pickup/choose_area_pickup_controller.dart';
import 'package:muatmuat/app/modules/choose_area_pickup_internal/choose_area_pickup_internal_controller.dart';
import 'package:muatmuat/app/modules/list_search_truck_siap_muat/list_search_truck_siap_muat_controller.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_get_count_response.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_status_enum.dart';
import 'package:muatmuat/app/modules/search_location_lokasi_truk_siap_muat/search_location_lokasi_truk_siap_muat_controller.dart';
import 'package:muatmuat/app/modules/select_head_carrier/select_head_carrier_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class LokasiTrukSiapMuatController extends GetxController {
  final mapController = MapController().obs;
  final snappingSheetController = SnappingSheetController();

  final scaffoldKey = GlobalKey<ScaffoldState>().obs;

  final currState = LokasiTrukSiapMuatStatus.MIN.obs;

  Location _location = Location();
  final markerList = [].obs;
  final markerAreaPickupList = [].obs;
  final position = LatLng(0, 0).obs;

  var jumlahTruk = "0".obs;
  var address = Map().obs;
  var dest = Map().obs;
  var jenisTruk = Map().obs;
  var jenisCarrier = Map().obs;

  var isEmptyAlamat = false.obs;
  var isEmptyTruk = false.obs;
  var isEmptyCarrier = false.obs;

  final textEditingAddressController = TextEditingController();
  final textEditingDestController = TextEditingController();
  final textEditingTrukController = TextEditingController();
  final textEditingCarrierController = TextEditingController();

  bool _isFirstTimeBuildWidget = true;
  bool _isGetLocationUser = false;
  final isGetLocationUser = false.obs;

  final String namaKey = "Nama";
  final String lokasiKey = "Lokasi";
  final String cityKey = "City";
  final String districtKey = "District";

  var snappingScrollController = ScrollController();

  final LoadingDialog _loadingDialog = LoadingDialog(Get.context);

  var limitLastTransaction = 4;

  @override
  // ignore: must_call_super
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<bool> onWillPop() async {
    return Future.value(true);
  }

  void afterDone() async {
    if (_isFirstTimeBuildWidget) {
      _isFirstTimeBuildWidget = false;
      await mapController.value.onReady;
      _getLocationUser();
    }
    _getCountLokasiTrukSiapMuat();
  }

  void _getLocationUser() {
    _location.onLocationChanged.listen((LocationData current) {
      if (current.accuracy < 50) {
        if (!_isGetLocationUser) {
          _isGetLocationUser = true;
          updateMap(LatLng(current.latitude, current.longitude), false);
        }
      }
    });
  }

  Future _getCountLokasiTrukSiapMuat() async {
    try {
      var response =
          await ApiHelper(context: Get.context, isShowDialogLoading: false)
              .fetchGetCountLTSM();
      if (response != null) {
        LokasiTrukSiapMuatGetCountResponseModel
            lokasiTrukSiapMuatGetCountResponseModel =
            LokasiTrukSiapMuatGetCountResponseModel.fromJson(response);
        jumlahTruk.value = lokasiTrukSiapMuatGetCountResponseModel.count;
        // print('Debug: ' + 'jumlahTruk = ' + jumlahTruk.toString());
      }
    } catch (err) {}
  }

  void selectAddress() async {
    FocusManager.instance.primaryFocus.unfocus();
    // FocusScope.of(Get.context).unfocus();
    String addressName = "";
    // (address.containsKey(namaKey)) ? address[namaKey] ?? "" : "";
    LatLng latLng = (address.containsKey(lokasiKey))
        ? address[lokasiKey]
        : (position.value ?? null);
    var result =
        await GetToPage.toNamed<SearchLocationLokasiTrukSiapMuatController>(
            Routes.SEARCH_LOCATION_LOKASI_TRUK_SIAP_MUAT,
            arguments: [
          "",
          addressName,
          latLng,
          "Posisi Truk Siap Muat",
          false
        ]);
    // var result = await Get.toNamed(Routes.SEARCH_LOCATION_LOKASI_TRUK_SIAP_MUAT,
    //     arguments: ["", addressName, latLng, "Posisi Truk Siap Muat", false]);
    if (result != null) {
      address.clear();
      address.value = _setMapLokasi(result[0] as String, result[1] as LatLng,
          result[2] as String, result[3] as String);
      textEditingAddressController.text = address[namaKey];
      updateMap(address[lokasiKey], true);
    }
    // Timer(Duration(milliseconds: 200), () {
    //   Get.delete<SearchLocationInfoPermintaanMuatController>();
    // });
  }

  dynamic _setMapLokasi(
      String nama, LatLng lokasi, String district, String city) {
    return {
      namaKey: nama,
      lokasiKey: lokasi,
      cityKey: city,
      districtKey: district
    };
  }

  void updateMap(LatLng latLng, bool showMarker) async {
    position.value = latLng;
    markerList.clear();
    if (showMarker) {
      Marker _marker = Marker(
          width: 48.0,
          height: 48.0,
          point: position.value,
          builder: (ctx) => Stack(alignment: Alignment.topCenter, children: [
                SvgPicture.asset(
                  "assets/marker_transporter_icon.svg",
                  width: 48,
                  height: 48,
                )
              ]));
      markerList.add(_marker);
    }
    isGetLocationUser.value = true;
    await mapController.value.onReady;
    mapController.value.move(position.value, GlobalVariable.zoomMap);
  }

  void selectDest() async {
    FocusManager.instance.primaryFocus.unfocus();
    // FocusScope.of(Get.context).unfocus();
    var result = await GetToPage.toNamed<ChooseAreaPickupInternalController>(
        Routes.CHOOSE_AREA_PICKUP_INTERNAL,
        arguments: [int.parse("0"), Map.from(dest)]);
    // var result = await Get.toNamed(Routes.CHOOSE_AREA_PICKUP,
    //     arguments: [int.parse("0"), Map.from(dest)]);
    if (result != null) {
      var resultMap = result as Map;
      if (resultMap.toString() != "{}") {
        dest.value = resultMap;
        textEditingDestController.text =
            resultMap.isEmpty ? "" : resultMap.values.first;
      }
    }
    // Timer(Duration(milliseconds: 200), () {
    //   Get.delete<ChooseAreaPickupController>();
    // });
  }

  void selectHeadCarrier(String headCarrier) async {
    FocusManager.instance.primaryFocus.unfocus();
    // FocusScope.of(Get.context).unfocus();
    List<dynamic> arguments = [headCarrier]; // argument 0 type
    if (headCarrier == "0") {
      arguments
          .add(jenisTruk.isNotEmpty ? jenisTruk["ID"] : 0); // selected data
      arguments.add(0);
      arguments.add("Cari Jenis Truk"); // argument 3 title
    } else {
      arguments.add(
          jenisCarrier.isNotEmpty ? jenisCarrier["ID"] : 0); // selected data
      arguments
          .add(jenisTruk.isNotEmpty ? jenisTruk["ID"] : 0); // selected head
      arguments.add("Cari Jenis Carrier"); // argument 3 title
    }
    arguments.add(0); // argument 4 show button simpan

    var result = await GetToPage.toNamed<SelectHeadCarrierController>(
        Routes.SELECT_HEAD_CARRIER_TRUCK_INTERNAL,
        arguments: arguments,
        preventDuplicates: false);
    // var result = await Get.toNamed(Routes.SELECT_HEAD_CARRIER_TRUCK,
    //     arguments: arguments, preventDuplicates: false);
    FocusScope.of(Get.context).unfocus();
    if (result != null) {
      if (headCarrier == "0") {
        jenisTruk.value = result;
        textEditingTrukController.text = result["Description"];
        jenisCarrier.clear();
        textEditingCarrierController.text = "";
      } else {
        jenisCarrier.value = result;
        textEditingCarrierController.text = result["Description"];
      }
    }
    // Timer(Duration(milliseconds: 300), () {
    //   Get.delete<SelectHeadCarrierController>();
    // });
  }

  Future<Map> _getLastSearchCity() async {
    var stringCity =
        await SharedPreferencesHelper.getAreaPickupLastSearchCity() ?? "";
    return stringCity.isEmpty ? {} : jsonDecode(stringCity);
  }

  Future<Map> _getLastSearchDistrict() async {
    var stringCity =
        await SharedPreferencesHelper.getAreaPickupLastSearchCity() ?? "";
    return stringCity.isEmpty ? {} : jsonDecode(stringCity);
  }

  Future _removeLastSearchCity(String cityID, String city) async {
    var listCity = await _getLastSearchCity();
    listCity.removeWhere((key, value) => key.toString() == cityID);
    // if (!listCity.keys.toList().contains(cityID)) {
    //   listCity.remove(listCity[listCity.keys.first]);
    // }
    await SharedPreferencesHelper.setAreaPickupLastSearchCity(listCity);
  }

  Future _removeLastSearchDistrict(String districtID, String district) async {
    var listDistrict = await _getLastSearchDistrict();
    listDistrict.removeWhere((key, value) => key.toString() == districtID);
    // if (!listDistrict.keys.toList().contains(districtID)) {
    //   listDistrict.remove(listDistrict[listDistrict.keys.first]);
    // }
    await SharedPreferencesHelper.setAreaPickupLastSearchDistrict(listDistrict);
  }

  Future<Map> _getLastTransactionCity() async {
    var stringCity =
        await SharedPreferencesHelper.getAreaPickupLastTransactionCity() ?? "";
    return stringCity.isEmpty ? {} : jsonDecode(stringCity);
  }

  Future<Map> _getLastTransactionDistrict() async {
    var stringDistrict =
        await SharedPreferencesHelper.getAreaPickupLastTransactionDistrict() ??
            "";
    return stringDistrict.isEmpty ? {} : jsonDecode(stringDistrict);
  }

  Future _setLastTransactionCity(String cityID, String city) async {
    var listCity = await _getLastTransactionCity();
    // if (!listCity.keys.toList().contains(cityID)) {
    //   if (listCity.length == limitLastTransaction)
    //     listCity.remove(listCity[listCity.keys.first]);
    //   listCity[cityID] = city;

    if (listCity.keys.toList().contains(cityID)) {
      listCity.removeWhere((key, value) => key == cityID);
    }
    while (listCity.length > limitLastTransaction) {
      listCity.removeWhere((key, value) => key == listCity.keys.first);
    }
    listCity[cityID] = city;

    await SharedPreferencesHelper.setAreaPickupLastTransactionCity(listCity);
  }

  Future _setLastTransactionDistrict(String districtID, String district) async {
    var listDistrict = await _getLastTransactionDistrict();
    if (listDistrict.keys.toList().contains(districtID)) {
      if (listDistrict.length == limitLastTransaction)
        listDistrict.remove(listDistrict[listDistrict.keys.first]);
      listDistrict[districtID] = district;
    }
    await SharedPreferencesHelper.setAreaPickupLastTransactionDistrict(
        listDistrict);
  }

  void cariTrukSiapMuat() async {
    // print('Debug: ' + address.toString());
    // print('Debug: ' + dest.toString());
    // print('Debug: ' + jenisTruk.toString());
    // print('Debug: ' + jenisCarrier.toString());
    // {Nama: GALAXY MALL 2, Jl. Dharmahusada, Mulyorejo, Kota Surabaya, Jawa Timur, Indonesia, Lokasi: LatLng(latitude:-7.274594, longitude:112.781978), City: Surabaya, District: Kecamatan Sukolilo}
    // {0: Kota Surabaya}
    // {ID: 1, Description: Colt Diesel Engkel, ImageHead: https://devintern.assetlogistik.com/assets/head/cold-diesel-engkel.png}
    // {ID: 1, Description: Box, ImageCarrier: https://devintern.assetlogistik.com/assets/truck/No-truck-image-v2.png}

    print('Debug: ' + 'cariTrukSiapMuat');
    print('Debug: ' + dest.keys.first.toString());
    print('Debug: ' + dest.values.first.toString());
    if (dest.keys.first.toString().length == 4) {
      await _setLastTransactionCity(
          dest.keys.first.toString(), dest.values.first.toString());
      // await _removeLastSearchCity(
      //     dest.keys.first.toString(), dest.values.first.toString());
    } else {
      await _setLastTransactionDistrict(
          dest.keys.first.toString(), dest.values.first.toString());
      // await _removeLastSearchDistrict(
      //     dest.keys.first.toString(), dest.values.first.toString());
    }
    List<dynamic> arguments = [];
    arguments.add(address[namaKey]);
    arguments.add(address[cityKey]);
    arguments.add(address[districtKey]);
    arguments.add(address[lokasiKey]);
    arguments.add(dest);
    arguments
        .add({jenisTruk["ID"].toString(): jenisTruk["Description"].toString()});
    arguments.add({
      jenisCarrier["ID"].toString(): jenisCarrier["Description"].toString()
    });

    var result = await GetToPage.toNamed<ListSearchTruckSiapMuatController>(
            Routes.LIST_SEARCH_TRUCK_SIAP_MUAT,
            arguments: arguments)
        .then((value) {
      _getCountLokasiTrukSiapMuat();
    });
    // var result = await Get.toNamed(Routes.LIST_SEARCH_TRUCK_SIAP_MUAT,
    //         arguments: arguments)
    //     .then((value) {
    //   _getCountLokasiTrukSiapMuat();
    // });
    if (result != null) {}
  }
}
