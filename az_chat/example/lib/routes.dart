import 'package:azlogistik_chat/azlogistik_chat.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/chat': (context) => AZLogistikChat(),
  };
}