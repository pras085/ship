import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/privacy_and_policy/privacy_and_policy_point_model.dart';

class PrivacyAndPolicyResponseModel {
  MessageFromUrlModel message;
  List<PrivacyAndPolicyPointModel> listPoint;

  PrivacyAndPolicyResponseModel({this.message});

  PrivacyAndPolicyResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    listPoint = json['Data']
        .map<PrivacyAndPolicyPointModel>(
            (data) => PrivacyAndPolicyPointModel(data['Content']))
        .toList();
  }
}
