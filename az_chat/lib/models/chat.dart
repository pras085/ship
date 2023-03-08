import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:azlogistik_chat/models/link_metadata.dart';
import 'package:azlogistik_chat/models/member.dart';
import 'package:azlogistik_chat/models/photo_file.dart';
import 'package:azlogistik_chat/utilities/model_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  @JsonKey(fromJson: ModelHelper.intFromJson)
  int ID, TempID;
  
  @JsonKey(fromJson: ModelHelper.stringFromJson)
  String Message, ReadBy;
  
  @JsonKey(fromJson: ModelHelper.dateTimeLocalFromJson)
  DateTime? Created;

  @JsonKey(fromJson: ModelHelper.boolFromJson)
  bool IsRead, IsViolation, IsError;

  Member? From;
  Member? To;
  
  PhotoFile? File;

  LinkMetaData? UrlMetaData;

  Chat({
    this.ID = 0,
    this.TempID = 0,
    this.Message = '',
    this.ReadBy = '',
    this.Created,
    this.IsRead = false,
    this.IsViolation = false,
    this.IsError = false,
    this.From,
    this.To,
    this.File,
    this.UrlMetaData,
  });

  factory Chat.fromJson(Map<String,dynamic> data) {
    Chat obj = _$ChatFromJson(data);
    if(data['MetaTitle'] != null || data['MetaDescription'] != null || data['MetaImage'] != null){
      obj.UrlMetaData = LinkMetaData(
        Title: data['MetaTitle'] == null ? null : ModelHelper.stringFromJson(data['MetaTitle']),
        Description: data['MetaDescription'] == null ? null : ModelHelper.stringFromJson(data['MetaDescription']),
        Image: data['MetaImage'] == null ? null : ModelHelper.stringFromJson(data['MetaImage']),
        URL: data['URL'] == null ? null : ModelHelper.stringFromJson(data['URL']),
      );
    }
    return obj;
  }

  Map<String,dynamic> toJson() { 
    Map<String,dynamic> result = _$ChatToJson(this);
    result.remove('UrlMetaData');
    result.addAll({
      'MetaTitle': UrlMetaData?.Title,
      'MetaDescription': UrlMetaData?.Description,
      'MetaImage': UrlMetaData?.Image,
      'URL': UrlMetaData?.URL,
    });
    return result;
  }

  bool isReadBy(String id){
    return ReadBy != null && ReadBy.contains(',$id,');
  }

  bool get IsMe {
    return From?.ID == ChatCubit.instance.state.memberId;
  }

}