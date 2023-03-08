import 'package:muatmuat/app/core/models/message_from_url_model.dart';

class GetSettingResponseModel {
  MessageFromUrlModel message;
  int timeoutToken = 0;
  String shipperVersion = "";
  String transporterVersion = "";
  String sellerVersion = "";
  String langVersion = "";

  GetSettingResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;

    if (json['Data'] != null) {
      try {
        timeoutToken = json['Data']['TimeoutToken'];
        shipperVersion = json['Data']['VersionShipperApp'];
        transporterVersion = json['Data']['VersionTransporterApp'];
        sellerVersion = json['Data']['VersionSellerApp'];
        langVersion = json['Data']['VersionLang'];
      } catch (err) {}
    }
  }
}
