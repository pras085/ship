import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class InfoFromAddressResponseModel {
  double latitude;
  double longitude;
  String village;
  String district;
  String city;
  String province;
  String postal;

  InfoFromAddressResponseModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      latitude = json["lat"] as double;
      longitude = json["lng"] as double;
      village = json["village"];
      district = json["district"];
      city = json["city"];
      province = json["province"];
      postal = json["postal"];
    }
  }
}
