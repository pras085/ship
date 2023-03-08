import 'dart:convert';

import 'package:azlogistik_chat/azlogistik_chat.dart';
import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/views/chat_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/translate/translate.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:path_provider/path_provider.dart';

// place it here or somewhere that can be access globally
// make sure it initialized just once and included inside the MaterialApp
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ChatPageController chatPageController = ChatPageController();

class HydraBloc {
  static void init() async {
    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  }
}

class Chat{

  static String convertBase64(String id){
    return base64.encode(utf8.encode(id));
  }

  static Widget blockedMessage = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: const TextStyle(
        color: Colors.black87,
      ),
      children: [
        const TextSpan(
          text: 'Anda telah diblokir oleh sistem karena telah 5x mengirimkan kata-kata kasar. Untuk dapat melakukan chat kembali, ',
        ),
        TextSpan(
          text: 'hubungi Admin Muatmuat',
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = (){
              // open browser / page 
            }
        )
      ]
    )
  );

  static Future<void> init(String userID, String fcmToken) async {
    await ChatCubit.instance.init(convertBase64(userID), fcmToken);
  }  

  static void newInstance(){
    ChatCubit.newInstance(navigatorKey, chatPageController, 
      'ee070a623cda451367e56a1f218215a3',
      baseUrl: 'https://apichat.assetlogistik.com',
      onTncClicked: () {
        // on TnC Clicked
      },
      blockedMessage: blockedMessage);
  }

  static void toInbox() {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => AZLogistikChat()));
  }

  static void toID(String id) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => AZLogistikChat(config: AZLogistikChatConfig(toId: convertBase64(id)),)));
  }
}