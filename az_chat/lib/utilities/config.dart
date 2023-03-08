import 'package:azlogistik_chat/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

class AZLogistikChatConfig {
  final String? toId;
  final String? toName;
  final String? textMessage;
  
  AZLogistikChatConfig({
    this.toId,
    this.toName,
    this.textMessage,
  });
}

class Config {
  static String baseUrl = 'https://apichat.assetlogistik.com';
  static String clientId = '';
  static VoidCallback? onTncClicked;
  static Widget? blockedMessage;
  static Widget? blockedToMessage;
  static Duration serverTimezone = Duration(hours: 7);
  static String roomSeparator = ':';
  // static const double serverTimezone = 8.0; // server timezone  gmt + 7
  // static const double serverTimezone = 8.0; // server timezone  gmt + 7

  static ChatPageController chatPageController = ChatPageController();
}