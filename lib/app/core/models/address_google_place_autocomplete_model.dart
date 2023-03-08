import 'package:latlong/latlong.dart';

class AddressGooglePlaceAutoCompleteModel {
  //Kembalian API AutoComplete saja
  String description;
  String placeId;
  double distanceMeters;

  AddressGooglePlaceAutoCompleteModel(
      {this.description, this.placeId, this.distanceMeters});

  AddressGooglePlaceAutoCompleteModel.fromJson(Map<String, dynamic> json) {
    this.description = json['description'];
    this.placeId = json['place_id'];
    this.distanceMeters = json['distance_meters'];
  }

  AddressGooglePlaceAutoCompleteModel.fromJsonBasedVariableName(
      Map<String, dynamic> json) {
    this.description = json['description'];
    this.placeId = json['placeId'];
    this.distanceMeters = json['distanceMeters'];
  }

  Map toJson() {
    return {
      'description': description,
      'placeId': placeId,
      'distanceMeters': distanceMeters,
    };
  }
}
