// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoFile _$PhotoFileFromJson(Map<String, dynamic> json) => PhotoFile(
      ID: json['ID'] == null ? 0 : ModelHelper.intFromJson(json['ID']),
      Original: ModelHelper.stringFromJson(json['Original']),
      Small: ModelHelper.stringFromJson(json['Small']),
      Medium: ModelHelper.stringFromJson(json['Medium']),
    );

Map<String, dynamic> _$PhotoFileToJson(PhotoFile instance) => <String, dynamic>{
      'ID': instance.ID,
      'Original': instance.Original,
      'Small': instance.Small,
      'Medium': instance.Medium,
    };
