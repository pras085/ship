import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/zo_bid_information_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/zo_bid_participant_model.dart';

class ZoBidWinnerData {
  final ZoBidInformation bidInformation;
  final List<ZoBidParticipant> bidParticipantList;

  const ZoBidWinnerData({
    this.bidInformation,
    this.bidParticipantList,
  });

  factory ZoBidWinnerData.fromJson(Map<String, dynamic> json) {
    var bidItem = json['BidItem'] ?? json['DataInformationBid'];
    var listJson = json['DataParticipant'] ?? json['DataParticipantWinner'];
    print("fromJson-json['DataParticipant']: ${json['DataParticipant']}");
    print(listJson == null
        ? []
        : (listJson as List)
            .map((participant) => ZoBidParticipant.fromJson(participant))
            .toList()
            .toString());
    return ZoBidWinnerData(
      bidInformation: bidItem == null
          ? null
          : ZoBidInformation.fromJson(bidItem is List ? bidItem[0] : bidItem),
      bidParticipantList: listJson == null
          ? []
          : (listJson as List)
              .map((participant) => ZoBidParticipant.fromJson(participant))
              .toList(),
    );
  }
}

class ZoBidWinnerResponseModel {
  final MessageFromUrlModel message;
  final ZoBidWinnerData data;
  final String type;

  const ZoBidWinnerResponseModel._({this.message, this.data, this.type});

  ZoBidWinnerResponseModel copyWith({
    MessageFromUrlModel message,
    ZoBidWinnerData data,
    String type,
  }) {
    return ZoBidWinnerResponseModel._(
      message: message ?? this.message,
      data: data ?? this.data,
      type: type ?? this.type,
    );
  }

  factory ZoBidWinnerResponseModel.fromJson(Map<String, dynamic> json) {
    return ZoBidWinnerResponseModel._(
      message: MessageFromUrlModel.fromJson(json['Message']),
      data: ZoBidWinnerData.fromJson(json['Data']),
      type: json['Type'],
    );
  }
}
