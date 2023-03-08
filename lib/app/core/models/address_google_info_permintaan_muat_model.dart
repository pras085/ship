import 'package:muatmuat/app/core/models/address_google_place_autocomplete_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';

class AddressGoogleInfoPermintaanMuatModel {
  AddressGooglePlaceAutoCompleteModel addressAutoComplete;
  AddressGooglePlaceDetailsModel addressDetails;

  final String _addressAutoCompleteKey = "AddressAutoComplete";
  final String _addressDetailsKey = "AddressDetails";

  AddressGoogleInfoPermintaanMuatModel(
      {this.addressAutoComplete, this.addressDetails});

  AddressGoogleInfoPermintaanMuatModel.copyData(
      AddressGoogleInfoPermintaanMuatModel data) {
    addressAutoComplete = data.addressAutoComplete;
    addressDetails = data.addressDetails;
  }

  AddressGoogleInfoPermintaanMuatModel.fromJson(dynamic json) {
    addressAutoComplete =
        AddressGooglePlaceAutoCompleteModel.fromJsonBasedVariableName(
            json[_addressAutoCompleteKey]);
    addressDetails = AddressGooglePlaceDetailsModel.fromJsonBasedVariableName(
        json[_addressDetailsKey]);
  }

  Map toJson() {
    return {
      _addressAutoCompleteKey: addressAutoComplete.toJson(),
      _addressDetailsKey: addressDetails.toJson(),
    };
  }
}
