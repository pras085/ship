import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/from_dest_search_location/from_dest_search_history_model.dart';

class FromDestSearchHistoryResponseModel {
  MessageFromUrlModel message;
  List<FromDestSearchHistoryModel> listData = [];

  FromDestSearchHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      listData.addAll(data
          .map<FromDestSearchHistoryModel>(
              (value) => FromDestSearchHistoryModel.fromJson(value))
          .toList());
    }
  }
}
