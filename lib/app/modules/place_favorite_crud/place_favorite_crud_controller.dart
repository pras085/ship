import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/modules/place_favorite_crud/place_favorite_crud_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class PlaceFavoriteCrudController extends GetxController {
  final textEditingNameController = TextEditingController().obs;
  final textEditingAddressController = TextEditingController().obs;

  AddressGooglePlaceDetailsModel _addressGooglePlaceDetailsModel;

  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future gotoSearchCity() async {
    var result = await Get.toNamed(Routes.SEARCH_CITY);
    AddressGooglePlaceDetailsModel resultAddress = result;
    if (result != null) {
      _addressGooglePlaceDetailsModel = result;
      textEditingAddressController.value.text =
          _addressGooglePlaceDetailsModel.formattedAddress;
    }
  }

  Future saveLocationManagement() async {
    if (textEditingNameController.value.text != "" &&
        textEditingAddressController.value.text != "") {
      try {
        var result = await ApiHelper(context: Get.context)
            .fetchAddLocationManagement(
                name: textEditingNameController.value.text,
                address: _addressGooglePlaceDetailsModel.formattedAddress,
                latitude:
                    _addressGooglePlaceDetailsModel.latLng.latitude.toString(),
                longitude:
                    _addressGooglePlaceDetailsModel.latLng.longitude.toString(),
                district: _addressGooglePlaceDetailsModel.districtName);
        if (result != null) {
          PlaceFavoriteCRUDResponseModel crud =
              PlaceFavoriteCRUDResponseModel.fromJson(result);
          if (crud.message.code == 200) {
            Get.back(result: true);
          }
        }
      } catch (err) {}
    } else {}
  }
}
