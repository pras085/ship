# azlogistik_chat

A Chat plugin for AZ Logistik

## Getting Started
1. add these folowing dependencies :
```yaml
bot_toast: 
firebase_core: 
firebase_messaging: 
flutter_bloc: 
hydrated_bloc: 
path_provider: 
``` 
2. add this plugin as dependency from github : 
```yaml 
azlogistik_chat:
  git:
    url: git@github.com:adisoe/azlogsitik-chat-flutter.git
    ref: master
``` 
3. create a new globalkey 
  ```dart
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  ```
4. add navigatorKey, BotToastInit and NavigatorObserver to MaterialApp
```dart
return MaterialApp(
  navigatorKey: navigatorKey,
  builder: BotToastInit(),
  navigatorObservers: [BotToastNavigatorObserver()],
  home: ...,
);
```
5. add new ChatPageController. This object will be used for firebase notification later.
```dart
ChatPageController chatPageController = ChatPageController();
```
6. add HydratedCubit storage initialize in main.dart before runApp(App())
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  
  await Firebase.initializeApp();
  
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  
  runApp(MyApp());
}
```
7. init ChatCubit new instance before Material App
```dart
// initialize new ChatCubit instance 
ChatCubit.newInstance(navigatorKey, chatPageController, 'CLIENT_ID');
```
there are several optional parameters to initialize newInstance
| Parameter         | Type         | Notes                                                                                            |
| ----------------- | ------------ | ------------------------------------------------------------------------------------------------ |
| baseUrl           | String       | Api base url. Default value is http://apichat.assetlogistik.com                                  |
| onTncClicked      | VoidCallback | A callback that will be triggered if user click "Cek Syarat & Ketentuan" on a censored message   |
| blockedMessage    | Widget       | A message that will be shown if user has been blocked. A RichText widget is preferable.          |
| blockedToMessage  | Widget       | A message that will be shown if receiver got blocked by system. A RichText widget is preferable. |
| serverTimezone    | Duration     | Server timezone, default is GMT+7 ```Duration(hours: 7)```                                       |

blockedMessage example : 
```dart
RichText(
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
)
```

8. once user has been logged in and the app has been initialized, trigger ChatCubit.instance.init() to sync the member id to chat plugin
```dart
ChatCubit.instance.init(memberId, fcmToken);
```    

## Firebase Setup
Please refer to Firebase documentation for the initial setup.
1. Add OnMessage Listener
```dart
FirebaseMessaging.onMessage.listen((event) {
  // to fetch the room list and show all new rooms
  ChatCubit.instance.fetchNewRooms();
  
  // to fetch the new chat if chat page is opened
  chatPageController.fetchNewChats();
});
```
2. Add on notification click action
```dart
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  debugPrint('FirebaseMessaging onMessageOpenedApp event was published!');
});
```

## Open Chat Module
We can use ```navigator.push``` or ```navigator.pushNamed```. 

### Chat Room List
Call the widget constructor ```AZLogistikChat()``` without any parameters.

### Chat 1 on 1
If you are using the navigator.push method, call the widget constructor with config parameter.

```dart
AZLogistikChat(
  config: AZLogistikChatConfig(toId: 'RECEIVER_ID'),
)
```

Or if you are using the pushNamed method, then the config can be send inside the ```arguments``` parameter.
```dart
Navigator.of(context).pushNamed('/chat', arguments: AZLogistikChatConfig(toId: 'RECEIVER_ID'))
```
there are several parameters for AZLogistikChatConfig
| Parameter         | Type         | Notes                                                                                            |
| ----------------- | ------------ | ------------------------------------------------------------------------------------------------ |
| toId              | String       | Receiver ID                                                                                      |
| toName            | String       | Initial Room Name                                                                                |
| textMessage       | String       | Initial text that will be placed inside the text input once the page opened                      |


## Notes
### Json Serialization
We are using json serialization plugin to generate flutter model class. To (re)generate the model class, use the code below
```flutter pub run build_runner build```