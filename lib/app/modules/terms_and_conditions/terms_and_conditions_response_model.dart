import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/terms_and_conditions/terms_and_condition_point_model.dart';

class TermsAndConditionsResponseModel {
  MessageFromUrlModel message;
  String data;
  List<TermsAndConditionsPointModel> listPoint;

  TermsAndConditionsResponseModel({this.message});

  TermsAndConditionsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    listPoint = json['Data']
        .map<TermsAndConditionsPointModel>(
            (data) => TermsAndConditionsPointModel(data['Content']))
        .toList();
  }
}
