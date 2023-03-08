// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      ID: json['ID'] == null ? 0 : ModelHelper.intFromJson(json['ID']),
      TempID:
          json['TempID'] == null ? 0 : ModelHelper.intFromJson(json['TempID']),
      Message: json['Message'] == null
          ? ''
          : ModelHelper.stringFromJson(json['Message']),
      ReadBy: json['ReadBy'] == null
          ? ''
          : ModelHelper.stringFromJson(json['ReadBy']),
      Created: ModelHelper.dateTimeLocalFromJson(json['Created']),
      IsRead: json['IsRead'] == null
          ? false
          : ModelHelper.boolFromJson(json['IsRead']),
      IsViolation: json['IsViolation'] == null
          ? false
          : ModelHelper.boolFromJson(json['IsViolation']),
      IsError: json['IsError'] == null
          ? false
          : ModelHelper.boolFromJson(json['IsError']),
      From: json['From'] == null
          ? null
          : Member.fromJson(json['From'] as Map<String, dynamic>),
      To: json['To'] == null
          ? null
          : Member.fromJson(json['To'] as Map<String, dynamic>),
      File: json['File'] == null
          ? null
          : PhotoFile.fromJson(json['File'] as Map<String, dynamic>),
      UrlMetaData: json['UrlMetaData'] == null
          ? null
          : LinkMetaData.fromJson(json['UrlMetaData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'ID': instance.ID,
      'TempID': instance.TempID,
      'Message': instance.Message,
      'ReadBy': instance.ReadBy,
      'Created': instance.Created?.toIso8601String(),
      'IsRead': instance.IsRead,
      'IsViolation': instance.IsViolation,
      'IsError': instance.IsError,
      'From': instance.From,
      'To': instance.To,
      'File': instance.File,
      'UrlMetaData': instance.UrlMetaData,
    };
