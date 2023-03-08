import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/api/get_history_transaction_location.dart';
import 'package:muatmuat/app/core/function/api/get_info_from_address_place_id.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/form_pendaftaran_bf/form_pendaftaran_bf_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/manajemen_lokasi_api.dart';
import 'package:muatmuat/app/core/function/search_address_google_function.dart';
import 'package:muatmuat/app/core/models/address_google_info_permintaan_muat_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_autocomplete_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/core/models/history_transaction_location_info_permintaan_muat_response_model.dart';
import 'package:muatmuat/app/core/models/info_from_address_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/manajemen_lokasi_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/edit_manajemen_lokasi_info_permintaan_muat/edit_manajemen_lokasi_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/lokasi_bf_tm/lokasi_bf_tm_controller.dart';
import 'package:muatmuat/app/modules/search_location_map_marker/search_location_map_marker_controller.dart';
import 'package:muatmuat/app/modules/search_manajemen_lokasi_info_permintaan_muat/search_manajemen_lokasi_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final FormPendaftaranBFController registercontroller = Get.find();
// var selectLokasi = Map().obs;

class SearchLocationBFTMController extends GetxController {
  String numberOfMarker = "";

  final searchTextEditingController = TextEditingController().obs;

  final isSearchMode = false.obs;
  final isSearchingData = false.obs;
  final isGettingSavedLocation = false.obs;
  var mapController = MapController();
  final listSearchAddress = [].obs;
  final listSaveLocation = [].obs;
  final listHistoryTransactionLocation = [].obs;

  final _listSearchAddressTemp = [];

  SearchAddressGoogleFunction _searchAddressGoogleFunction;
  AddressGooglePlaceDetailsModel _addressDetail;

  bool _firstTimeBuildWidget = true;

  int _indexOnClick = 0;

  LatLng _latLngFromArgms;

  String _addressFromArgms;
  var totalMarker = 5.obs;

  var showTopRightMarker = true.obs;
  var searchvalue = "".obs;
  var hintText = "LoadRequestInfoLabelHintSearchLocation".tr.obs;
  var devicetype = "".obs;

  // void updateMap() async {
  //   await mapController.onReady;
  //   var markerBounds = LatLngBounds();
  //   selectLokasi.values.forEach((element) {
  //     markerBounds.extend(element["Lokasi"]);
  //   });
  //   if (markerBounds.isValid) {
  //     mapController.fitBounds(markerBounds,
  //         options: FitBoundsOptions(padding: EdgeInsets.all(40)));
  //   }
  // }
  @override
  void onInit() {
    numberOfMarker = Get.arguments[0];
    devicetype.value = getDeviceType();
    print('ikura');
    print(devicetype.value + 'ikura');
    // print(listSearchAddress.toString());
    // print(listHistoryTransactionLocation.toString());
    // print(listSaveLocation.toString());
    // totalMarker.value = Get.arguments[1];
    // _addressFromArgms = Get.arguments[2];
    // _latLngFromArgms = Get.arguments[3];
    // if (Get.arguments.length > 4) hintText.value = Get.arguments[4];
    // if (Get.arguments.length > 5) showTopRightMarker.value = Get.arguments[5];
    _searchAddressGoogleFunction = SearchAddressGoogleFunction(
        context: Get.context,
        getResultListAddress: (list) {
          isSearchingData.value = false;
          listSearchAddress.clear();
          for (AddressGooglePlaceAutoCompleteModel data in list) {
            listSearchAddress.add(AddressGoogleInfoPermintaanMuatModel(
                addressAutoComplete: data));
          }
        },
        getResultDetail: (details) {
          //_addressDetail = detail;
          _whenGetDetail(details);
        });
      
       if(Get.arguments[4] == 'map' ){
      WidgetsBinding.instance.addPostFrameCallback((_) { 
         onClickSetPositionMarker();
      });
     
      }
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

  void _addToSharedPref(AddressGoogleInfoPermintaanMuatModel data) {
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
    if (_listSearchAddressTemp.length > 3)
      _listSearchAddressTemp.removeAt(_listSearchAddressTemp.length - 1);
    SharedPreferencesHelper.setHistorySearchLocationInfoPermintaanMuat(
        jsonEncode(_listSearchAddressTemp));
  }

  Future _getListHistorySearch() async {
    try {
      var resultJson = jsonDecode(await SharedPreferencesHelper
          .getHistorySearchLocationInfoPermintaanMuat()) as List;
      listSearchAddress.addAll(resultJson
          .map((data) => AddressGoogleInfoPermintaanMuatModel.fromJson(data))
          .toList());
      listSearchAddress.refresh();
      _listSearchAddressTemp.addAll(listSearchAddress);
    } catch (err) {}
  }

  void onClickAddress(int index) {
    _indexOnClick = index;
    if (listSearchAddress[index].addressDetails != null) {
      _whenGetDetail(listSearchAddress[index].addressDetails);
    } else {
      _searchAddressGoogleFunction.onClickListAddress(
          listSearchAddress[index].addressAutoComplete.placeId);
    }
    //_addToSharedPref(listSearchAddress[index]);
  }

  String getDeviceType(){
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  void onCompleteBuildWidget() async {
    if (_firstTimeBuildWidget) {
      _firstTimeBuildWidget = false;
      _getListHistorySearch();
      _getListSaveLocation();
      _getListHistoryTransactionLocation();
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
  final String namaKey = "Nama";
  final String lokasiKey = "Lokasi";
  final String cityKey = "City";
  final String districtKey = "District";

  dynamic _setMapLokasi(
      String nama, LatLng lokasi, String city, String district) {
    return {
      namaKey: nama,
      lokasiKey: lokasi,
      cityKey: city,
      districtKey: district
    };
  }

  void _whenGetDetail(AddressGooglePlaceDetailsModel detail) async{
    _addToSharedPref(AddressGoogleInfoPermintaanMuatModel(
        addressAutoComplete:
            listSearchAddress[_indexOnClick].addressAutoComplete,
        addressDetails: detail));
      final prefs = await SharedPreferences.getInstance();
      prefs.setDouble('latfinal', detail.latLng.latitude);
      prefs.setDouble('lngfinal', detail.latLng.longitude );
    // updateMap(detail.latLng);
    //  selectLokasi.remove(0.toString());
    //   selectLokasi[0.toString()] = _setMapLokasi(listSearchAddress[_indexOnClick].addressAutoComplete.description as String,
    //       detail.latLng, detail.districtName, detail.cityName);  
    // updateMap();
    // Get.back(result: selectLokasi.value);
        // return Future.value(false);
    _getBackWithResult(
        listSearchAddress[_indexOnClick].addressAutoComplete.description,
        detail.latLng,
        detail.districtName,
        detail.cityName,
         listSearchAddress[_indexOnClick].addressAutoComplete.placeId
        );
    //  Get.back(result: LokasiBFTMController().selectLokasi.value);
    //  return Future.value(false);
    // _getBackWithResult(detail.formattedAddress, detail.latLng,
    //     detail.districtName, detail.cityName);
  }

  Future _getListSaveLocation() async {
    isGettingSavedLocation.value = true;
    listSaveLocation.clear();
    try {
      ManajemenLokasiResponseModel response =
          await ManajemenLokasiAPI.getLocation(
              GlobalVariable.userModelGlobal.docID);
      listSaveLocation.addAll(response.listData);
    } catch (err) {}
    isGettingSavedLocation.value = false;
  }

  Future _getListHistoryTransactionLocation() async {
    try {
      HistoryTransactionLocationInfoPermintaanMuatResponseModel response =
          await GetHistoryTransactionLocation.getLocation(
              GlobalVariable.userModelGlobal.docID);
      listHistoryTransactionLocation.addAll(response.listData);
    } catch (err) {}
  }

  void onClickSetPositionMarker() async {
    var result = await GetToPage.toNamed<SearchLocationMapMarkerController>(
        Routes.PETA_BF_TM               ,
        arguments: {
          SearchLocationMapMarkerController.latLngKey: _latLngFromArgms,
          SearchLocationMapMarkerController.imageMarkerKey:
              Stack(alignment: Alignment.topCenter, children: [
             Image.asset(
             'assets/pin_new.png',
              width: GlobalVariable.ratioWidth(Get.context) * 29.56,
              height: GlobalVariable.ratioWidth(Get.context) * 36.76,),    
            // SvgPicture.asset(
            //   totalMarker.value == 1
            //       ? "assets/pin_truck_icon.svg"
            //       : numberOfMarker == "1"
            //           ? "assets/pin_yellow_icon.svg"
            //           : "assets/pin_blue_icon.svg",
            //   width: GlobalVariable.ratioWidth(Get.context) * 22,
            //   height: GlobalVariable.ratioWidth(Get.context) * 29,
            // ),
            // Container(
            //   margin: EdgeInsets.only(
            //       top: GlobalVariable.ratioWidth(Get.context) * 7),
            //   child: CustomText(totalMarker.value == 1 ? "" : numberOfMarker,
            //       color: numberOfMarker != "1"
            //           ? Colors.white
            //           : Color(ListColor.color4),
            //       fontWeight: FontWeight.w700,
            //       fontSize: 10),
            // )
          ]),
        });
    if (result != null) {
       if(result == 'back'){
      //  _getDataInfoFromAddressPlaceID(address: result[1]);
      Get.back(result: 'back');
    }
    else{
       _getDataInfoFromAddressPlaceID(address: result[1]);
    }
      // _getBackWithResult(
      //   result[1],
      //   result[0],
      // );
    }
  }

  void onClickListSaveLocation(int index) {
    _getBackWithResult(
      listSaveLocation[index].address,
      LatLng(
          listSaveLocation[index].latitude, listSaveLocation[index].longitude),
      listSaveLocation[index].district,
      listSaveLocation[index].city,
      listSearchAddress[index].addressAutoComplete.placeId
    );
  }

  void onClearSearch() {
    searchTextEditingController.value.text = "";
    addTextSearch("");
  }

  void onClickSaveLocation({String address, String placeID}) async {
    var result = await GetToPage.toNamed<
            EditManajemenLokasiInfoPermintaanMuatController>(
        Routes.EDIT_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
        arguments: {
          "Address": address,
          "placeIDKey": placeID,
          "TypeEditManajemenLokasiInfoPermintaanMuat":
              TypeEditManajemenLokasiInfoPermintaanMuat.ADD
        });
    if (result != null) if (result) _getListSaveLocation();
    Timer(Duration(milliseconds: 300), () {
      Get.delete<EditManajemenLokasiInfoPermintaanMuatController>();
    });
  }

  void onClickEditSaveLocation(int index) async {
    var result = await GetToPage.toNamed<
            EditManajemenLokasiInfoPermintaanMuatController>(
        Routes.EDIT_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT,
        arguments: {
          EditManajemenLokasiInfoPermintaanMuatController
              .manajemenLokasiModelKey: listSaveLocation[index],
          EditManajemenLokasiInfoPermintaanMuatController
                  .typeEditManajemenLokasiInfoPermintaanMuatKey:
              TypeEditManajemenLokasiInfoPermintaanMuat.UPDATE
        });
    if (result != null) if (result) _getListSaveLocation();
    Timer(Duration(milliseconds: 300), () {
      Get.delete<EditManajemenLokasiInfoPermintaanMuatController>();
    });
  }

  void onClickListHistoryTransactionLocation(int index) {
    _getDataInfoFromAddressPlaceID(
        address: listHistoryTransactionLocation[index].address);
  }

  Future _getDataInfoFromAddressPlaceID(
      {@required String address, String placeID}) async {
    InfoFromAddressResponseModel response =
        await GetInfoFromAddressPlaceID.getInfo(
            address: placeID != null ? null : address, placeID: placeID);
    print(address + ' diavolo');
    
    _addToSharedPref(AddressGoogleInfoPermintaanMuatModel(
        addressAutoComplete: AddressGooglePlaceAutoCompleteModel(
            description: address, placeId: placeID),
        addressDetails: AddressGooglePlaceDetailsModel(
            formattedAddress: address,
            latLng: LatLng(response.latitude, response.longitude),
            cityName: response.city,
            districtName: response.district)));
    // print(_listSearchAddressTemp[0].addressAutoComplete.placeId.toString()+ ' xsr');
    //refo
    print(response.city.toString() + 'xsr');
    print(address + 'xsr');
    if (response != null) {
      _getBackWithResult(
          address,
          LatLng(
            response.latitude,
            response.longitude,
          ),
          response.district,
          response.city,
          placeID != null ? placeID : ''
          // listSearchAddress[0].addressAutoComplete.placeId
          );
    }
  }

  void _getBackWithResult(
      String address, LatLng latLng, String district, String city, String placeid) {
    onClearSearch();
    print(address+' yoasobi');
    print(latLng.toString()+' yoasobi');
    print(district+' yoasobi');
    print(city+' yoasobi');
    print(placeid ?? ""+' yoasobi');
    Get.back(result: [address, latLng, district, city, true, placeid ?? ""]);
  }

  void goToListAllManajemenLokasi() async {
    var result = await GetToPage.toNamed<
            SearchManajemenLokasiInfoPermintaanMuatController>(
        Routes.SEARCH_MANAJEMEN_LOKASI_INFO_PERMINTAAN_MUAT);
    _getListSaveLocation();
    if (result != null)
      _getBackWithResult(result[0], result[1], result[2], result[3], result[4]);
  }
}
