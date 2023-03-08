// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloudFile _$CloudFileFromJson(Map<String, dynamic> json) => CloudFile(
      ID: json['ID'] as int?,
      URL: ModelHelper.stringFromJson(json['URL']),
    );

Map<String, dynamic> _$CloudFileToJson(CloudFile instance) => <String, dynamic>{
      'ID': instance.ID,
      'URL': instance.URL,
    };
