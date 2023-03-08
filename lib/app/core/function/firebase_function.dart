import 'dart:io';

import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:muatmuat/app/core/function/chat_function.dart';
import 'package:muatmuat/global_variable.dart';

class FirebaseCloudMessaging {
  static FirebaseMessaging fcm;

  static Future firebaseInit() async {
    fcm = FirebaseMessaging();
    GlobalVariable.fcmToken = await fcm.getToken();
    if (Platform.isIOS) {
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        ChatCubit.instance.fetchNewRooms();
        if(!chatPageController.isShowNotification(message['data']['ChatRoomID'])){
          chatPageController.fetchNewChats();
        }
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }
}