
import 'package:azlogistik_chat/models/chat_room.dart';
import 'package:azlogistik_chat/services/chat_request.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/utilities/network.dart';
import 'package:azlogistik_chat/views/chat_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'state.dart';

class ChatCubit extends HydratedCubit<ChatState> {

  static late ChatCubit instance;
  static GlobalKey<NavigatorState>? _navigatorKey;
  
  ChatCubit(
    GlobalKey<NavigatorState> navigatorKey,
  ) : super(ChatInitial(navigatorKey));

  @override
  ChatState? fromJson(Map<String, dynamic> json) {
    if(json['type'] == 'initial'){
      return ChatInitial(ChatCubit._navigatorKey ?? ChatCubit.instance.state.navigatorKey);
    }
    else if(json['type'] == 'initSuccess'){
      return ChatInitSuccess(json['accessToken'], json['memberId'], ChatCubit._navigatorKey ?? ChatCubit.instance.state.navigatorKey);
    }
    else if(json['type'] == 'initError'){
      return ChatInitError(json['memberId'], ChatCubit._navigatorKey ?? ChatCubit.instance.state.navigatorKey);
    }
    else if(json['type'] == 'loadError'){
      return ChatLoadError(json['accessToken'], json['memberId'], ChatCubit._navigatorKey ?? ChatCubit.instance.state.navigatorKey);
    }
    else if(json['type'] == 'success'){
      return ChatLoadSuccess(json['accessToken'], 
        json['memberId'], 
        ChatCubit._navigatorKey ?? ChatCubit.instance.state.navigatorKey, 
        (json['selectedFilter'] ?? '').toString(),
        (json['keyword'] ?? '').toString(),
        (json['rooms'] as List).map((e) => ChatRoom.fromJson(e)).toList(),
        json['isLast']
      );
    }
    return ChatState('', '', ChatCubit._navigatorKey ?? ChatCubit.instance.state.navigatorKey);
  }

  @override
  Map<String, dynamic>? toJson(ChatState state) {
    Map<String, dynamic> json = {
      'type' : '',
      'accessToken' : state.accessToken,
      'memberId': state.memberId,
    };
    if(state is ChatInitial) {
      json['type'] = 'initial'; 
    } else if(state is ChatInitSuccess) {
      json['type'] = 'initSuccess'; 
    } else if(state is ChatInitError) {
      json['type'] = 'initError'; 
    } else if(state is ChatLoadError) {
      json['type'] = 'loadError'; 
    } else if(state is ChatLoadSuccess) {
      json['type'] = 'loadSuccess'; 
      json.addAll({
        'rooms': state.rooms.map((e) => e.toJson()).toList(),
        'isLast': state.isLast,
        'selectedFilter': state.selectedFilter,
        'keyword': state.keyword,
      });
    }
    return json;
  }

  /// Params :
  /// - GlobalKey<NavigatorState> navigatorKey (required)
  /// - ChatPageController chatPageController (required)
  /// - String clientId (required)
  /// - VoidCallback? onTncClicked 
  ///     A callback that will be triggered if user click "Cek Syarat & Ketentuan" on a censored message
  /// - Widget? blockedMessage
  ///     A message that will be shown if user has been blocked. A RichText widget is recommended
  static void newInstance(
    GlobalKey<NavigatorState> navigatorKey, 
    ChatPageController chatPageController,
    String clientId, {
      String? baseUrl,
      VoidCallback? onTncClicked,
      Widget? blockedMessage,
      Widget? blockedToMessage,
      Duration? serverTimezone
    }
  ) {
    ChatCubit._navigatorKey = navigatorKey;
    ChatCubit.instance = ChatCubit(navigatorKey);
    Config.chatPageController = chatPageController;
    if(baseUrl != null){
      Config.baseUrl = baseUrl;
    }
    Config.clientId = clientId;
    Config.onTncClicked = onTncClicked;
    Config.blockedMessage = blockedMessage;
    Config.blockedToMessage = blockedToMessage;
    if(serverTimezone != null){
      Config.serverTimezone = serverTimezone;
    }
    Network.init();
  }

  // static ChatCubit getInstance(BuildContext context) {
  //   return BlocProvider.of<ChatCubit>(context);
  // }

  Future<void> init(String memberId, String fcmToken) async {
    
    // get token 
    var token = await ChatRequest.getToken(memberId);
    if(token != null){
      emit(ChatInitSuccess(token, memberId, state.navigatorKey));
      
      // register device id
      // debugPrint('Cubit State : ' + ChatCubit.instance.state.toString());
      ChatRequest.registerDeviceID(memberId, fcmToken, '', '');
    }
    else{
      emit(ChatInitError(memberId, state.navigatorKey));
    }
  }

  Future<void> applyFilter(String filter) async {
    if(state is ChatLoadSuccess || state is ChatLoadPending){
      emit(ChatLoadPending(state.accessToken, state.memberId, state.navigatorKey, 
        filter, 
        (state as ChatLoadPending).keyword, 
        (state as ChatLoadPending).rooms, 
        (state as ChatLoadPending).isLast));
    }
  }
  Future<void> applyKeyword(String keyword) async {
    if(state is ChatLoadSuccess || state is ChatLoadPending){
      emit(ChatLoadPending(state.accessToken, state.memberId, state.navigatorKey, 
        (state as ChatLoadPending).selectedFilter,
        keyword,
        (state as ChatLoadPending).rooms, 
        (state as ChatLoadPending).isLast));
    }
  }

  Future<void> fetchRoom({
    String selectedFilter = '',
    String keyword = '',
    int pageKey = 0,
  }) async {
    var rooms = await ChatRequest.getRooms(
      filter: selectedFilter,
      keyword: keyword,
      start: pageKey,
    );
    if(rooms != null){
      var isLast = false;
      if(pageKey > 0 && (state is ChatLoadSuccess || state is ChatLoadPending)){
        isLast = rooms.length < 10;
        rooms = (state as ChatLoadPending).rooms + rooms;
      }
      // if(MemberCubit.instance.state is MemberAuthSuccess){
      //   MemberCubit.instance.fetch();
      // }
      debugPrint('fetchRoom success');
      emit(ChatLoadSuccess(state.accessToken, state.memberId, state.navigatorKey, selectedFilter, keyword, rooms, isLast));
    }
    else{
      debugPrint('fetchRoom error');
      emit(ChatLoadError(state.accessToken, state.memberId, state.navigatorKey));
    }
  }

  Future<void> fetchNewRooms() async {
    DateTime? lastEdited;
    List<ChatRoom> oldRooms = [];
    bool isLast = false;
    if(state is ChatLoadSuccess || state is ChatLoadPending){
      if((state as ChatLoadPending).rooms.isNotEmpty){
        lastEdited = (state as ChatLoadPending).rooms.first.LastEdited;
        oldRooms = (state as ChatLoadPending).rooms;
        isLast = (state as ChatLoadPending).isLast;
      }
    }

    var rooms = await ChatRequest.getRooms(
      lastEdited: lastEdited
    );
    if(rooms != null){
      //combine with oldRooms
      for(var room in rooms){
        oldRooms.removeWhere((element) => element.Code == room.Code);
      }
      rooms = rooms + oldRooms;

      // if(MemberCubit.instance.state is MemberAuthSuccess){
      //   MemberCubit.instance.fetch();
      // }
      var _filter = '';
      var _keyword = '';
      if(state is ChatLoadSuccess || state is ChatLoadPending){
        _filter = (state as ChatLoadPending).selectedFilter;
        _keyword = (state as ChatLoadPending).keyword;
      }

      emit(ChatLoadSuccess(state.accessToken, state.memberId, state.navigatorKey, _filter, _keyword, rooms, isLast));
    }
    else{
      emit(ChatLoadError(state.accessToken, state.memberId, state.navigatorKey));
    }
  }
}