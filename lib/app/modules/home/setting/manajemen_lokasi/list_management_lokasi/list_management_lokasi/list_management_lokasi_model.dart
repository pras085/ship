import 'package:latlong/latlong.dart';

class ListManagementLokasiModel {
  String id;
  String name;
  String address;
  LatLng latLng;
  String province;
  String city;
  String district;
  String postalCode;
  String picName;
  String picNoTelp;

  ListManagementLokasiModel.fromJson(Map<String, dynamic> json) {
    id = json["ID"].toString();
    name = json["Name"];
    address = json["Address"];
    latLng = LatLng(double.parse(json['Latitude'].toString()),
        double.parse(json['Longitude'].toString()));
    province = json["Province"] ?? "";
    city = json["City"] ?? "";
    district = json["District"] ?? "";
    postalCode = json["PostalCode"];
    picName = json["PicName"];
    picNoTelp = json["PicNoTelp"];
  }
}
