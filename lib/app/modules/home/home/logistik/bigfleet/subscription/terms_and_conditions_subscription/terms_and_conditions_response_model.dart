import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/subscription/terms_and_conditions_subscription/tac_point_model.dart';

class TermsAndConditionsResponseModel {
  MessageFromUrlModel message;
  String data;
  List<TACPointModel> listPoint;

  TermsAndConditionsResponseModel({this.message});

  TermsAndConditionsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    listPoint = json['Data']
        .map<TACPointModel>((data) => TACPointModel(data['Content']))
        .toList();
  }
}
