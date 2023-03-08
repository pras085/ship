part of 'bloc.dart';


class ChatState extends Equatable{
  final String accessToken;
  final String memberId;
  final GlobalKey<NavigatorState> navigatorKey;
  
  const ChatState(
    this.accessToken,
    this.memberId,
    this.navigatorKey,
  );

  @override
  List<Object> get props => [
    accessToken,
    memberId,
    navigatorKey,
  ];

}

class ChatInitial extends ChatState {
  const ChatInitial(GlobalKey<NavigatorState> navigatorKey) : super('', '', navigatorKey);
}

class ChatInitSuccess extends ChatState {
  const ChatInitSuccess(String accessToken, String memberId, GlobalKey<NavigatorState> navigatorKey) : super(accessToken, memberId, navigatorKey);
}
class ChatInitError extends ChatState {
  const ChatInitError(String memberId, GlobalKey<NavigatorState> navigatorKey) : super('', memberId, navigatorKey);
}

class ChatLoadError extends ChatState {
  const ChatLoadError(String accessToken, String memberId, GlobalKey<NavigatorState> navigatorKey) : super(accessToken, memberId, navigatorKey);
}

class ChatLoadPending extends ChatState {
  final List<ChatRoom> rooms;
  final bool isLast;
  final String selectedFilter;
  final String keyword;

  const ChatLoadPending(String accessToken, String memberId, GlobalKey<NavigatorState> navigatorKey, 
    this.selectedFilter, this.keyword, this.rooms, this.isLast) : super(accessToken, memberId, navigatorKey);

  @override
  List<Object> get props => [
    accessToken,
    memberId,
    rooms,
    isLast,
    selectedFilter,
    keyword,
  ];
}

class ChatLoadSuccess extends ChatLoadPending {
  const ChatLoadSuccess(String accessToken, String memberId, GlobalKey<NavigatorState> navigatorKey, 
    String selectedFilter, String keyword, List<ChatRoom> rooms, bool isLast
    ) : super(accessToken, memberId, navigatorKey, selectedFilter, keyword, rooms, isLast);
}