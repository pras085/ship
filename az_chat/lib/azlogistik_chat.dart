import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:azlogistik_chat/bloc/meta_bloc.dart';
import 'package:azlogistik_chat/models/chat_room.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/utilities/network.dart';
import 'package:azlogistik_chat/utilities/theme_helper.dart';
import 'package:azlogistik_chat/views/chat_list.dart';
import 'package:azlogistik_chat/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AZLogistikChat extends StatefulWidget {
  
  final AZLogistikChatConfig? config;

  const AZLogistikChat({
    Key? key,
    this.config,
  }) : super(key: key);

  @override
  State<AZLogistikChat> createState() => _AZLogistikChatState();
}

class _AZLogistikChatState extends State<AZLogistikChat> {

  AZLogistikChatConfig? get _args {
    var tempArgs = ModalRoute.of(context)!.settings.arguments;
    return widget.config ?? (tempArgs == null ? null : tempArgs as AZLogistikChatConfig);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // debugPrint('get token');
      // setState(() {
      //   Config.currentConfig = widget.config ?? _args;
      // });
      // ChatCubit.instance.init();
      if(_args?.toId != null){
        ChatRoom room = ChatRoom(
          Code: '${_args!.toId}${Config.roomSeparator}${ChatCubit.instance.state.memberId}',
          Title: _args?.toName ?? '',
          CountUnread: 0,
        );
        ChatCubit.instance.state.navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (_) => ChatPage(
              room: room,
              defaultText: _args?.textMessage,
            )
          )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return _scaffold();
    return BlocProvider<ChatCubit>.value(
      value: ChatCubit.instance,
      child: _scaffold()
    );
  }

  Widget _scaffold() {
    return Scaffold(
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Theme(
            data: ThemeHelper.azTheme,
            child: page(state)
          );
          // return page(state);
        },
      ),
    );
  }

  Widget page(ChatState state){
    if(state is ChatInitial){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    else if(state is ChatInitError){
      return const Center(
        child: Text('Cannot Get Token'),
      );
    }
    else {
      return ChatListPage();
    }
  }
}
