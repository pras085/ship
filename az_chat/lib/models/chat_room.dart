import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:azlogistik_chat/models/chat.dart';
import 'package:azlogistik_chat/models/member.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/utilities/model_helper.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom{
  @JsonKey(fromJson: ModelHelper.stringFromJson)
  String? Code, Title;
  
  @JsonKey(fromJson: ModelHelper.intFromJson)
  int CountUnread;

  @JsonKey(fromJson: ModelHelper.dateTimeFromJson)
  DateTime? LastEdited;
  
  Chat? LastMessage;
  List<Member>? Participants;

  ChatRoom({
    this.Code, 
    this.Title,
    this.CountUnread = 0,
    this.LastEdited,
    this.LastMessage,
    this.Participants,
  });

  factory ChatRoom.fromJson(Map<String,dynamic> data) => _$ChatRoomFromJson(data);

  Map<String,dynamic> toJson() => _$ChatRoomToJson(this);

  String name() {
    if(Title != null && Title != ''){
      return Title!;
    }
    if(LastMessage != null){
      if(LastMessage!.From?.ID == ChatCubit.instance.state.memberId){
        return LastMessage!.To?.Name ?? '';
      }
      else {
        return LastMessage!.From?.Name ?? '';
      }
    }
    return '';
  }
  
  String avatar() {
    if(LastMessage != null){
      if(LastMessage!.From?.ID == ChatCubit.instance.state.memberId){
        return LastMessage!.To?.Avatar ?? '';
      }
      else {
        return LastMessage!.From?.Avatar ?? '';
      }
    }
    return '';
  }
  
  String toId() {
    if(LastMessage != null){
      if(LastMessage!.From?.ID == ChatCubit.instance.state.memberId){
        return LastMessage!.To?.ID ?? '';
      }
      else {
        return LastMessage!.From?.ID ?? '';
      }
    }
    else if(Code != null){
      var temp = Code!.split(Config.roomSeparator);
      if(temp.length == 2){
        if(temp[0].toString() == ChatCubit.instance.state.memberId){
          return temp[1].toString();
        }
        else {
          return temp[0].toString();
        }
      }
    }
    return '';
  }
}