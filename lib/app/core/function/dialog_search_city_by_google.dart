import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muatmuat/app/core/function/search_city_autocomplete_function.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class DialogSearchCityByGoogle extends StatefulWidget {
  void Function(AddressGooglePlaceDetailsModel) onTapItem;
  String address;

  DialogSearchCityByGoogle({this.onTapItem, this.address = ""});

  @override
  _DialogSearchCityByGoogleState createState() =>
      _DialogSearchCityByGoogleState();
}

class _DialogSearchCityByGoogleState extends State<DialogSearchCityByGoogle> {
  bool _isGettingData = false;
  var _textEditingCityController = TextEditingController();
  Timer _timerGetCityText;
  String _citySearchKeyword = "";
  final _listCity = [];
  SearchCityAutoCompleteFunction _searchCityAutoCompleteFunction =
      SearchCityAutoCompleteFunction();

  @override
  void initState() {
    _textEditingCityController.text = widget.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.width - 20,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: CustomTextField(
                context: Get.context,
                controller: _textEditingCityController,
                textInputAction: TextInputAction.search,
                newInputDecoration: InputDecoration(
                  hintText:
                      "GlobalDialogSearchAddressByGoogleLabelHintSearch".tr,
                ),
                onChanged: (value) {
                  addTextCity(value);
                },
              ),
            ),
            Expanded(
              child: _isGettingData
                  ? Center(
                      child: Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ))
                  : ListView.builder(
                      itemCount: _listCity.length,
                      itemBuilder: (context, index) {
                        return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                                _onClickListCity(_listCity[index].placeId);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: CustomText(_listCity[index].description),
                              ),
                            ));
                      }),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
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
    _isGettingData = true;
    setState(() {});
    _listCity.clear();
    var response =
        await _searchCityAutoCompleteFunction.searchCity(_citySearchKeyword);
    if (response != null) {
      _listCity.addAll(response);
      _isGettingData = false;
      setState(() {});
    }
  }

  void _stopTimerGetCity() {
    if (_timerGetCityText != null) _timerGetCityText.cancel();
  }

  Future _onClickListCity(String placeId) async {
    AddressGooglePlaceDetailsModel addressGooglePlaceDetailsModel =
        await _searchCityAutoCompleteFunction.getDetails(placeId);
    if (addressGooglePlaceDetailsModel != null) {
      widget.onTapItem(addressGooglePlaceDetailsModel);
    }
  }

  // void _onCompleteBuild() {
  //   if (_isOnFirstTime) {
  //     _isOnFirstTime = false;
  //     final renderBox = globalKeyContainerCountDown.currentContext
  //         .findRenderObject() as RenderBox;
  //     widthCountdownContainer = renderBox.size.width;
  //     heightCountdownContainer = renderBox.size.height;
  //     _startInitSend();
  //   }
  // }
}
