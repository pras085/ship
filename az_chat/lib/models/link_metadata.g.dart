// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkMetaData _$LinkMetaDataFromJson(Map<String, dynamic> json) => LinkMetaData(
      Title: ModelHelper.stringFromJson(json['Title']),
      Description: ModelHelper.stringFromJson(json['Description']),
      Image: ModelHelper.stringFromJson(json['Image']),
      URL: ModelHelper.stringFromJson(json['URL']),
      HasURL: json['HasURL'] == null
          ? false
          : ModelHelper.boolFromJson(json['HasURL']),
    );

Map<String, dynamic> _$LinkMetaDataToJson(LinkMetaData instance) =>
    <String, dynamic>{
      'Image': instance.Image,
      'Title': instance.Title,
      'Description': instance.Description,
      'URL': instance.URL,
      'HasURL': instance.HasURL,
    };
