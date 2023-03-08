import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_model.dart';

class ProfileShipperResponseModel {
  MessageFromUrlModel message;
  ProfileShipperModel profileShipperModel;
  ProfileShipperResponseModel({this.message});

  ProfileShipperResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    profileShipperModel = ProfileShipperModel.fromJson(json['Data']);
  }
}
