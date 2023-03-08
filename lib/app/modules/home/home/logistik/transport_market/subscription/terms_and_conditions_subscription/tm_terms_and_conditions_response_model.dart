import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/transport_market/subscription/terms_and_conditions_subscription/tm_tac_point_model.dart';

class TMTermsAndConditionsResponseModel {
  MessageFromUrlModel message;
  String data;
  List<TM_TACPointModel> listPoint;

  TMTermsAndConditionsResponseModel({this.message});

  TMTermsAndConditionsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    listPoint = json['Data']
        .map<TM_TACPointModel>((data) => TM_TACPointModel(data['Content']))
        .toList();
  }
}
