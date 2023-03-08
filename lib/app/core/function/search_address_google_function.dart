import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muatmuat/app/core/models/address_google_place_autocomplete_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:uuid/uuid.dart';

class SearchAddressGoogleFunction {
  BuildContext context;

  void Function(List<AddressGooglePlaceAutoCompleteModel>) getResultListAddress;
  void Function(AddressGooglePlaceDetailsModel) getResultDetail;

  Timer _timerGetCityText;
  Timer _timerSeasonToken;

  String _addressSearchKeyword = "";
  String _seasonToken = "";

  bool _isChangeSeasonToken = true;

  List<AddressGooglePlaceAutoCompleteModel> _listAddress = [];

  SearchAddressGoogleFunction(
      {@required this.context,
      @required this.getResultListAddress,
      @required this.getResultDetail});

  void addTextCity(String address) {
    _addressSearchKeyword = address;
    if (_addressSearchKeyword == "") {
      _stopTimerGetCity();
      _listAddress.clear();
    } else {
      _startTimerGetAddress();
    }
  }

  Future<String> getPlaceIDFromAddress(String address) async {
    _addressSearchKeyword = address;
    if (_addressSearchKeyword == "") {
      _stopTimerGetCity();
      _setSeasonToken();
      var responseBody = await ApiHelper(
              context: context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchAutoCompletePlaceAPI(_addressSearchKeyword, _seasonToken);
      if (responseBody != null) {
        try {
          var getList = List<AddressGooglePlaceAutoCompleteModel>.from(responseBody as List);
          return getList[0].placeId;
        } catch (err) {
          print(err);
          return "";
        }
      }
    }
    return "";
  }

  void _startTimerSeasonToken() {
    _stopTimerSeasonToken();
    _timerSeasonToken = Timer(Duration(minutes: 2), () async {
      _isChangeSeasonToken = true;
    });
  }

  void _startTimerGetAddress() {
    _stopTimerGetCity();
    _timerGetCityText = Timer(Duration(seconds: 1), () async {
      await _searchCity();
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

  Future _searchCity() async {
    _listAddress.clear();
    if (_addressSearchKeyword != "") {
      _setSeasonToken();
      var responseBody = await ApiHelper(
              context: context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .fetchAutoCompletePlaceAPI(_addressSearchKeyword, _seasonToken);
      if (responseBody != null) {
        try {
          _listAddress.addAll(List<AddressGooglePlaceAutoCompleteModel>.from(
              responseBody as List));
          // _listAddress.addAll(responseBody
          //     .map((data) => AddressGooglePlaceAutoCompleteModel(
          //         description: data.description,
          //         placeId: data.placeId,
          //         distanceMeters: data.distanceMeters))
          //     .toList());
        } catch (err) {
          print(err);
        }
      }
      if (getResultListAddress != null) getResultListAddress(_listAddress);
    }
  }

  Future onClickListAddress(String placeId) async {
    var responseBody = await ApiHelper(
            context: context,
            isShowDialogLoading: true,
            isShowDialogError: true)
        .fetchPlaceDetailsAPI(placeId, _seasonToken);
    if (getResultDetail != null) getResultDetail(responseBody);
  }
}
