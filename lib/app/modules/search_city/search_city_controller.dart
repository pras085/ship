import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/search_city_autocomplete_function.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:uuid/uuid.dart';

class SearchCityController extends GetxController {
  var textEditingCityController = TextEditingController().obs;
  Timer _timerGetCityText;
  String _citySearchKeyword = "";
  final listCity = [].obs;
  String _seasonToken = "";
  SearchCityAutoCompleteFunction _searchCityAutoCompleteFunction;

  @override
  void onInit() {
    _seasonToken = Uuid().v4();
    _searchCityAutoCompleteFunction = SearchCityAutoCompleteFunction();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    _searchCityAutoCompleteFunction.stopTimerSeasonToken();
  }

  void addTextCity(String city) {
    _citySearchKeyword = city;
    _startTimerGetCity();
  }

  void _startTimerGetCity() {
    _stopTimerGetCity();
    _timerGetCityText = Timer(Duration(seconds: 1), () async {
      await _searchCity();
    });
  }

  Future _searchCity() async {
    listCity.clear();
    // listCity.addAllNonNull(
    //     await _searchCityAutoCompleteFunction.searchCity(_citySearchKeyword));
    listCity.addAll(
        await _searchCityAutoCompleteFunction.searchCity(_citySearchKeyword));
    listCity.refresh();
  }

  void _stopTimerGetCity() {
    if (_timerGetCityText != null) _timerGetCityText.cancel();
  }

  Future onClickListCity(String placeId) async {
    AddressGooglePlaceDetailsModel addressGooglePlaceDetailsModel =
        await _searchCityAutoCompleteFunction.getDetails(placeId);
    if (addressGooglePlaceDetailsModel != null) {
      Get.back(result: addressGooglePlaceDetailsModel);
    }
  }
}
