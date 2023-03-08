
import 'package:azlogistik_chat/utilities/model_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link_metadata.g.dart';


@JsonSerializable()
class LinkMetaData {
  @JsonKey(fromJson: ModelHelper.stringFromJson)
  String? Image, Title, Description, URL;

  @JsonKey(fromJson: ModelHelper.boolFromJson)
  bool HasURL;

  LinkMetaData({
    this.Title,
    this.Description,
    this.Image,
    this.URL,
    this.HasURL = false,
  });

  factory LinkMetaData.fromJson(Map<String,dynamic> data) => _$LinkMetaDataFromJson(data);

  Map<String,dynamic> toJson() => _$LinkMetaDataToJson(this);
}