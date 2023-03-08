import 'package:flutter/material.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/detail_ltsm/marker_truck.dart';

class DetailLTSMResponseModel {
  MessageFromUrlModel message;
  List<MarkerTruck> listMarkerTruck = [];

  DetailLTSMResponseModel.fromJson(BuildContext context,
      Map<String, dynamic> json, void Function() onTapWhenClose) {
    message = json['Message'] != null
        ? MessageFromUrlModel.fromJson(json['Message'])
        : null;
    var data = json['Data'];
    if (data != null) {
      try {
        (data as List).forEach((element) {
          listMarkerTruck.add(MarkerTruck(
              baseLTSMMarkerModel:
                  BaseLTSMMarkerModel.fromJson(context, element, onTapWhenClose)));
        });
        // listMarkerTruck.addAll(data
        //     .map((element) => MarkerTruck(
        //         baseLTSMMarkerModel:
        //             BaseLTSMMarkerModel.fromJson(element, onTapWhenClose)))
        //     .toList());
      } catch (err) {
        print(err.toString());
      }
    }
  }
}
