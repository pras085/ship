import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/views/chat_page.dart';
import 'package:azlogistik_chat_example/routes.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:azlogistik_chat/azlogistik_chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // await Firebase.initializeApp();
  
  // HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp());
}

// place it here or somewhere that can be access globally
// make sure it initialized just once and included inside the MaterialApp
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key){
    // _initFirebase();
  }

  ChatPageController chatPageController = ChatPageController();

  
  // void _initFirebase() {
  //   FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, // Required to display a heads up notification
  //     badge: true,
  //     sound: true,
  //   );

  //   FirebaseMessaging.onMessage.listen((event) {
  //     ChatCubit.instance.fetchNewRooms();
  //     chatPageController.fetchNewChats();
  //   });
    
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     debugPrint('FirebaseMessaging onMessageOpenedApp event was published!');
  //   });
  // }

  final Widget _blockedMessage = RichText(
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Tesssss'),
        ),
      )
    );

    // initialize new ChatCubit instance
    ChatCubit.newInstance(
      navigatorKey, 
      chatPageController, 
      'ee070a623cda451367e56a1f218215a3',
      baseUrl: 'https://apichat.assetlogistik.com',
      onTncClicked: () {
        // on TnC Clicked
      },
      blockedMessage: _blockedMessage
    );

    return MaterialApp(
      routes: Routes.routes,
      navigatorKey: navigatorKey,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2. registered route observer
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AZ Logistik Chat Example App'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AZLogistikChatConfig chatConfig = AZLogistikChatConfig();

  String? memberId;

  TextEditingController _memberTextController = TextEditingController();
  TextEditingController _toIdTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseMessaging().getToken(),
      builder: (context, snapshot) {

        if(snapshot.hasData){

          // once user has been logged in and firebase get token has been called
          // trigger ChatCubit.instance.init() to sync the member id to chat plugin
          if(memberId != null && memberId != ''){
            ChatCubit.instance.init(memberId!, snapshot.data.toString());
          }

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _memberTextController,
                      decoration: const InputDecoration(
                        labelText: 'Member ID : ',
                      ),
                    ),
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () { 
                        setState((){
                          memberId = _memberTextController.text;
                        });
                       },
                      child: Text('LOGIN'),
                    ),
                  ),
                  if(memberId != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                      child: Text('Open Chat List ($memberId)', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  if(memberId != null)
                    ElevatedButton(
                      onPressed: (){
                        navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => AZLogistikChat()));
                      }, 
                      child: Text('Open Chat List With .Push'),
                    ),
                  const SizedBox(height: 20,),
                  if(memberId != null)
                    ElevatedButton(
                      onPressed: (){
                        navigatorKey.currentState?.pushNamed('/chat');
                      }, 
                      child: Text('Open Chat List With .PushNamed'),
                    ),
                  if(memberId != null)
                    Container(
                      width: 200,
                      child: TextField(
                        controller: _toIdTextController,
                        decoration: const InputDecoration(
                          labelText: 'Chat To ID : '
                        ),
                      ),
                    ),
                  if(memberId != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                      child: const Text('Open Chat Room', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  if(memberId != null)
                    ElevatedButton(
                      onPressed: (){
                        navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => AZLogistikChat(config: AZLogistikChatConfig(toId: _toIdTextController.text),)));
                      }, 
                      child: Text('Open Chat Room With .Push'),
                    ),
                  const SizedBox(height: 20,),
                  if(memberId != null)
                    ElevatedButton(
                      onPressed: (){
                        navigatorKey.currentState?.pushNamed('/chat', arguments: AZLogistikChatConfig(
                          toId: _toIdTextController.text,
                          textMessage: 'Default text, can be use to send a link like https://lapak.io/linzshop or https://tokopedia.com'
                        ));
                      }, 
                      child: Text('Open Chat Room With .PushNamed'),
                    ),
                ],
              ),
            ),
          );
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
