import 'dart:async';

import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/address_google_place_autocomplete_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:uuid/uuid.dart';

class SearchCityAutoCompleteFunction {
  Timer _timerSeasonToken;
  String _seasonToken = "";

  bool _isChangeSeasonToken = false;

  Future searchCity(String searchKeyword) async {
    List<AddressGooglePlaceAutoCompleteModel> listCity = [];
    _setSeasonToken();
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchAutoCompletePlaceAPI(searchKeyword, _seasonToken);
    if (responseBody != null) {
      try {
        //listCity = responseBody;
        listCity = List<AddressGooglePlaceAutoCompleteModel>.from(
            responseBody.where((i) => i.placeId != ""));
        //listCity.addAll(responseBody.map((data) => data).toList());
      } catch (err) {
        print(err.toString());
      }
    }
    return listCity;
  }

  void _startTimerSeasonToken() {
    stopTimerSeasonToken();
    _timerSeasonToken = Timer(Duration(minutes: 2), () async {
      _isChangeSeasonToken = true;
    });
  }

  void stopTimerSeasonToken() {
    if (_timerSeasonToken != null) _timerSeasonToken.cancel();
  }

  void _setSeasonToken() {
    if (_isChangeSeasonToken) {
      _isChangeSeasonToken = false;
      _seasonToken = Uuid().v4();
      _startTimerSeasonToken();
    }
  }

  Future getDetails(String placeId) async {
    AddressGooglePlaceDetailsModel addressGooglePlaceDetailsModel;
    try {
      var responseBody = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: true,
              isShowDialogError: true)
          .fetchPlaceDetailsAPI(placeId, _seasonToken);
      if (responseBody != null) {
        addressGooglePlaceDetailsModel = responseBody;
      }
    } catch (err) {}
    return addressGooglePlaceDetailsModel;
  }
}
