// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
      Code: ModelHelper.stringFromJson(json['Code']),
      Title: ModelHelper.stringFromJson(json['Title']),
      CountUnread: json['CountUnread'] == null
          ? 0
          : ModelHelper.intFromJson(json['CountUnread']),
      LastEdited: ModelHelper.dateTimeFromJson(json['LastEdited']),
      LastMessage: json['LastMessage'] == null
          ? null
          : Chat.fromJson(json['LastMessage'] as Map<String, dynamic>),
      Participants: (json['Participants'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
      'Code': instance.Code,
      'Title': instance.Title,
      'CountUnread': instance.CountUnread,
      'LastEdited': instance.LastEdited?.toIso8601String(),
      'LastMessage': instance.LastMessage,
      'Participants': instance.Participants,
    };
