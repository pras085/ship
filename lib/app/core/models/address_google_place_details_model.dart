import 'package:latlong/latlong.dart';

class AddressGooglePlaceDetailsModel {
  String formattedAddress;
  String cityName = "";
  String districtName = "";
  LatLng latLng;

  AddressGooglePlaceDetailsModel(
      {this.formattedAddress, this.latLng, this.districtName, this.cityName});

  AddressGooglePlaceDetailsModel.fromJson(Map<String, dynamic> response) {
    formattedAddress = response['formatted_address'];
    var geometryLocation = response['geometry']['location'];
    //var address_components = response['address_components'];
    List<dynamic> address_components =
        List.from(response['address_components']);
    for (Map<String, dynamic> data in address_components) {
      List<String> types = List.from(data['types']);
      for (int i = 0; i < types.length; i++) {
        if (types[i] == "administrative_area_level_3") {
          districtName = data['long_name'];
          break;
        } else if (types[i] == "administrative_area_level_2") {
          cityName = data['long_name']
              .replaceAllMapped(RegExp("(^Kota )|( City\$)"), (match) => "");
          break;
        }
      }
      if (cityName != "") break;
    }
    latLng = LatLng(
        geometryLocation['lat'].toDouble(), geometryLocation['lng'].toDouble());
  }

  AddressGooglePlaceDetailsModel.copyData(AddressGooglePlaceDetailsModel data) {
    formattedAddress = data.formattedAddress;
    cityName = data.cityName;
    districtName = data.districtName;
    latLng = data.latLng;
  }

  AddressGooglePlaceDetailsModel.fromJsonBasedVariableName(
      Map<String, dynamic> response) {
    formattedAddress = response['formattedAddress'];
    cityName = response['cityName'];
    districtName = response['districtName'];
    latLng = LatLng(response['lat'].toDouble(), response['lng'].toDouble());
  }

  Map toJson() {
    return {
      'formattedAddress': formattedAddress,
      'cityName': cityName,
      'districtName': districtName,
      'lat': latLng.latitude,
      'lng': latLng.longitude,
    };
  }
}

class AddressComponentsGooglePlaceDetailsModel {}
