import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/api/get_info_from_address_place_id.dart';
import 'package:muatmuat/app/core/function/search_address_google_function.dart';
import 'package:muatmuat/app/core/models/address_google_info_permintaan_muat_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_autocomplete_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/core/models/info_from_address_response_model.dart';
import 'package:muatmuat/app/modules/search_location_map_marker/search_location_map_marker_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:latlong/latlong.dart';

class SearchLocationAddEditManajemenLokasiController extends GetxController {
  String numberOfMarker = "";

  final searchTextEditingController = TextEditingController().obs;

  final isSearchMode = false.obs;
  final isSearchingData = false.obs;
  final isGettingSavedLocation = false.obs;

  final listSearchAddress = [].obs;
  // final listSaveLocation = [].obs;
  // final listHistoryTransactionLocation = [].obs;

  final _listSearchAddressTemp = [];

  SearchAddressGoogleFunction _searchAddressGoogleFunction;
  AddressGooglePlaceDetailsModel _addressDetail;

  bool _firstTimeBuildWidget = true;

  int _indexOnClick = 0;

  LatLng _latLngFromArgms;

  String _addressFromArgms;

  var showTopRightMarker = false.obs;
  var hintText = "LoadRequestInfoLabelHintSearchLocation".tr.obs;
  var limitAddress = 3;

  @override
  void onInit() {
    numberOfMarker = Get.arguments[0];
    _addressFromArgms = Get.arguments[1];
    _latLngFromArgms = Get.arguments[2];
    if (Get.arguments.length > 3) hintText.value = Get.arguments[3];
    if (Get.arguments.length > 4) showTopRightMarker.value = Get.arguments[4];
    _searchAddressGoogleFunction = SearchAddressGoogleFunction(
        context: Get.context,
        getResultListAddress: (list) {
          isSearchingData.value = false;
          listSearchAddress.clear();
          for (AddressGooglePlaceAutoCompleteModel data
              in list.sublist(0, limitAddress)) {
            listSearchAddress.add(AddressGoogleInfoPermintaanMuatModel(
                addressAutoComplete: data));
          }
        },
        getResultDetail: (details) {
          //_addressDetail = detail;
          _whenGetDetail(details);
        });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void addTextSearch(String value) {
    listSearchAddress.clear();
    if (value == "") {
      listSearchAddress.addAll(_listSearchAddressTemp);
    }
    isSearchMode.value = value != "";
    isSearchingData.value = value != "";
    _searchAddressGoogleFunction.addTextCity(value);
  }

  void _addToSharedPref(AddressGoogleInfoPermintaanMuatModel data) async {
    if (_listSearchAddressTemp.length > 0) {
      for (int i = 0; i < _listSearchAddressTemp.length; i++) {
        if (_listSearchAddressTemp[i]
                .addressAutoComplete
                .description
                .toLowerCase() ==
            data.addressAutoComplete.description.toLowerCase()) {
          _listSearchAddressTemp.removeAt(i);
          break;
        }
      }
    }
    _listSearchAddressTemp.insert(
        0, AddressGoogleInfoPermintaanMuatModel.copyData(data));
    if (_listSearchAddressTemp.length > limitAddress)
      _listSearchAddressTemp.removeAt(_listSearchAddressTemp.length - 1);
    await SharedPreferencesHelper
        .setHistorySearchLocationAddEditManajemenLokasi(
            jsonEncode(_listSearchAddressTemp));
  }

  Future _getListHistorySearch() async {
    try {
      var resultJson = jsonDecode(await SharedPreferencesHelper
          .getHistorySearchLocationAddEditManajemenLokasi()) as List;
      listSearchAddress.addAll(resultJson
          .map((data) => AddressGoogleInfoPermintaanMuatModel.fromJson(data))
          .toList());
      listSearchAddress.refresh();
      _listSearchAddressTemp.addAll(listSearchAddress);
    } catch (err) {}
  }

  void onClickAddress(int index) {
    _indexOnClick = index;
    // selectedPlaceID = listSearchAddress[index].addressAutoComplete.placeId;
    if (listSearchAddress[index].addressDetails != null) {
      _whenGetDetail(listSearchAddress[index].addressDetails);
    } else {
      _searchAddressGoogleFunction.onClickListAddress(
          listSearchAddress[index].addressAutoComplete.placeId);
    }
    //_addToSharedPref(listSearchAddress[index]);
  }

  void onCompleteBuildWidget() async {
    if (_firstTimeBuildWidget) {
      _firstTimeBuildWidget = false;
      _getListHistorySearch();
      // _getListSaveLocation();
      // _getListHistoryTransactionLocation();
      searchTextEditingController.value.text = _addressFromArgms;
      searchTextEditingController.value.selection = TextSelection(
          baseOffset: 0,
          extentOffset: searchTextEditingController.value.text.length);
      addTextSearch(searchTextEditingController.value.text);
      // addTextSearchInfoPermintaanMuat(_arguments[searchValueKey] ?? "");
      // searchTextEditingController.value.text = _searchText;
      // if (_searchText.length > 0) {
      //   searchTextEditingController.value.selection =
      //       TextSelection.fromPosition(
      //           TextPosition(offset: _searchText.length));
      // }
    }
  }

  void _whenGetDetail(AddressGooglePlaceDetailsModel detail) {
    _addToSharedPref(AddressGoogleInfoPermintaanMuatModel(
        addressAutoComplete:
            listSearchAddress[_indexOnClick].addressAutoComplete,
        addressDetails: detail));
    _getDataInfoFromAddressPlaceID(
        address:
            listSearchAddress[_indexOnClick].addressAutoComplete.description);
    // _getBackWithResult(
    //     listSearchAddress[_indexOnClick].addressAutoComplete.description,
    //     detail.latLng,
    //     detail.districtName,
    //     detail.cityName,
    //     "",
    //     "00000");
    // _getBackWithResult(detail.formattedAddress, detail.latLng,
    //     detail.districtName, detail.cityName);
  }

  // Future _getListSaveLocation() async {
  //   isGettingSavedLocation.value = true;
  //   listSaveLocation.clear();
  //   try {
  //     ManajemenLokasiResponseModel response =
  //         await ManajemenLokasiAPI.getLocation(
  //             GlobalVariable.userModelGlobal.docID);
  //     listSaveLocation.addAll(response.listData);
  //   } catch (err) {}
  //   isGettingSavedLocation.value = false;
  // }

  // Future _getListHistoryTransactionLocation() async {
  //   try {
  //     HistoryTransactionLocationInfoPermintaanMuatResponseModel response =
  //         await GetHistoryTransactionLocation.getLocation(
  //             GlobalVariable.userModelGlobal.docID);
  //     listHistoryTransactionLocation.addAll(response.listData);
  //   } catch (err) {}
  // }

  void onClickSetPositionMarker() async {
    var result =
        await Get.toNamed(Routes.SEARCH_LOCATION_MAP_MARKER, arguments: {
      SearchLocationMapMarkerController.latLngKey: _latLngFromArgms,
      SearchLocationMapMarkerController.imageMarkerKey: SvgPicture.asset(
        "assets/pin_truck_icon.svg",
        width: 14,
        height: 35,
      ),
    });
    if (result != null) {
      _getDataInfoFromAddressPlaceID(address: result[1]);
      // _getBackWithResult(
      //   result[1],
      //   result[0],
      // );
    }
  }

  // void onClickListSaveLocation(int index) {
  //   _getBackWithResult(
  //     listSaveLocation[index].address,
  //     LatLng(
  //         listSaveLocation[index].latitude, listSaveLocation[index].longitude),
  //     listSaveLocation[index].district,
  //     listSaveLocation[index].city,
  //   );
  // }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    addTextSearch("");
  }

  // void onClickSaveLocation({String address, String placeID}) async {
  //   var result = await Get.toNamed(
  //       Routes.EDIT_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
  //       arguments: {
  //         "Address": address,
  //         "placeIDKey": placeID,
  //         "TypeEditManajemenLokasiInfoPermintaanMuat":
  //             TypeEditManajemenLokasiInfoPermintaanMuat.ADD
  //       });
  //   if (result != null) if (result) _getListSaveLocation();
  //   Timer(Duration(milliseconds: 300), () {
  //     Get.delete<EditManajemenLokasiInfoPermintaanMuatController>();
  //   });
  // }

  // void onClickEditSaveLocation(int index) async {
  //   var result = await Get.toNamed(
  //       Routes.EDIT_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
  //       arguments: {
  //         EditManajemenLokasiInfoPermintaanMuatController
  //             .manajemenLokasiModelKey: listSaveLocation[index],
  //         EditManajemenLokasiInfoPermintaanMuatController
  //                 .typeEditManajemenLokasiInfoPermintaanMuatKey:
  //             TypeEditManajemenLokasiInfoPermintaanMuat.UPDATE
  //       });
  //   if (result != null) if (result) _getListSaveLocation();
  //   Timer(Duration(milliseconds: 300), () {
  //     Get.delete<EditManajemenLokasiInfoPermintaanMuatController>();
  //   });
  // }

  // void onClickListHistoryTransactionLocation(int index) {
  //   _getDataInfoFromAddressPlaceID(
  //       address: listHistoryTransactionLocation[index].address);
  // }

  Future _getDataInfoFromAddressPlaceID(
      {@required String address, String placeID}) async {
    InfoFromAddressResponseModel response =
        await GetInfoFromAddressPlaceID.getInfo(
            address: placeID != null ? null : address, placeID: placeID);
    _addToSharedPref(AddressGoogleInfoPermintaanMuatModel(
        addressAutoComplete: AddressGooglePlaceAutoCompleteModel(
            description: address, placeId: placeID),
        addressDetails: AddressGooglePlaceDetailsModel(
            formattedAddress: address,
            latLng: LatLng(response.latitude, response.longitude),
            cityName: response.city,
            districtName: response.district)));
    if (response != null) {
      _getBackWithResult(
          address,
          LatLng(
            response.latitude,
            response.longitude,
          ),
          response.district,
          response.city,
          response.province,
          response.postal);
    }
  }

  void _getBackWithResult(String address, LatLng latLng, String district,
      String city, String province, String postal) {
    onClearSearch();
    Get.back(result: [address, latLng, district, city, province, postal]);
  }

  // void goToListAllManajemenLokasi() async {
  //   var result =
  //       await Get.toNamed(Routes.SEARCH_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT);
  //   _getListSaveLocation();
  //   if (result != null)
  //     _getBackWithResult(result[0], result[1], result[2], result[3]);
  // }
}
