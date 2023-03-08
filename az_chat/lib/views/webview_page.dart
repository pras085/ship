import 'package:azlogistik_chat/models/member.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
// import 'package:webview_flutter_android/webview_android.dart';
// Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

class WebViewPage extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewPage({
    Key? key, 
    required this.url, 
    this.title
  }) : super(key: key);

  static void open({
    required BuildContext context,
    required String url, 
    String? title
  }) async {
    if(WebViewPage._isOpenBrowser(url)){
      debugPrint("url not contains admincerdas.com");
      debugPrint(url);
      if (await canLaunch(url)) {
        launch(url);
        return;
      } 
    }

    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => WebViewPage(url: url, title: title,))));
  }

  static bool _isOpenBrowser(String url){
    return !url.contains("https://admincerdas.com") && !url.contains("https://app.admincerdas.com")
        && !url.contains("demanda.id")
        // && !url.contains("shopeemobile.com") && !url.contains("open.shopee.com")
        && !url.contains("accounts.bukalapak.com")
        && !url.contains("ngrok.io")
        // && !url.contains("xendit.co")
        && !url.contains("tawk.to");
  }

  @override
  State<StatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _webviewController;
  Member? _member;
  late Widget activePage;
  bool clearCache = false;
  String _referrerDetails = "";

  String _prevUrl = '';
  int _numRetry = 0;

  @override
  void initState() {
    super.initState();
    activePage = _buildLoading();
    // member.loadMember().then((member){
    //   setState(() {
    //     _member = member;
    //     activePage = _buildWebview();
    //   });
    // });

    if(widget.url == '/member/register') {
      // initReferrerDetails();
    }

//     flutterWebViewPlugin.onUrlChanged.listen((String url) async {
//       debugPrint("flutterWebViewPlugin onUrlChanged "+url);

//       // kalau link diluar aci, open browser
//       // todo tidak bisa proses xendit di dlm app
//       // error I/chromium(10100): [INFO:CONSOLE(1)] "Uncaught TypeError: window.snowplow is not a function", source: https://checkout-staging.xendit.co/web/615ff907f6b2733eefeb5629 (1)
//       // && !url.contains("xendit.co")
//       if(
//         WebViewPage._isOpenBrowser(url)
//         // !url.contains("https://admincerdas.com") && !url.contains("https://app.admincerdas.com")
//         // && !url.contains("demanda.id")
//         // // && !url.contains("shopeemobile.com") && !url.contains("open.shopee.com")
//         // && !url.contains("accounts.bukalapak.com")
//         // && !url.contains("ngrok.io")
//         // // && !url.contains("xendit.co")
//         // && !url.contains("tawk.to")
//       ) {
//         debugPrint("url not contains admincerdas.com");
//         debugPrint(url);
//         if (await canLaunch(url)) {
//           await launch(url);
//           flutterWebViewPlugin.goBack();
// //          if (Navigator.canPop(context)) {
// //            Navigator.pop(context);
// //          } else {
// //            SystemNavigator.pop();
// //          }
//         } else {
//           throw 'Could not launch $url';
//         }
//       }
//       // else if(url.contains("https://app.admincerdas.com/member/login")) {
//       //   if(_numRetry == 0 && _prevUrl != ''){
//       //     flutterWebViewPlugin.reloadUrl(_prevUrl, 
//       //       headers: {
//       //         'AccessToken': (_member != null) ? _member.AccessToken : 'aciaciaci'
//       //       }
//       //     );
//       //   }
//       //   else{
//       //     debugPrint("member login ????");
//       //     _viewLogin();
//       //     flutterWebViewPlugin.goBack();
//       //   }
//       // }
//       // else if(url.contains("https://admincerdas.com") || url.contains("https://app.admincerdas.com")){
//       //   debugPrint('open admincerdas web');
//       //   debugPrint('Access Token : ' + ((_member != null) ? _member.AccessToken : 'aciaciaci'));
//       //   if(_prevUrl != url){
//       //     _prevUrl = url;
//       //     _numRetry = 0;
//       //   }
//       //   else{
//       //     _numRetry++;
//       //   }
//       // }
//     });
    //flutterWebViewPlugin.close();

//     flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) async {
//       if (mounted) {
//         debugPrint('onStateChanged: ${state.type} ${state.url}');
//         if(state.type == WebViewState.shouldStart){
//           if(state.url.contains(RegExp('^intent://.*\$'))){
//             // intent:// open in browser
//             debugPrint("url contain intent");
// //            final intent = AndroidIntent(
// //                action: 'action_view',
// //                data: state.url
// //            );
// //            intent.launch();
// //              launch(state.url);
// //              flutterWebViewPlugin.goBack();
//             if (await canLaunch(state.url)) {
//               await launch(state.url);
//               flutterWebViewPlugin.goBack();
//             } else {
//               flutterWebViewPlugin.goBack();
//               BotToast.showSimpleNotification(
//                   title: 'Gagal membuka halaman '+state.url,
//                   duration: Duration(seconds: 3),
//                   backgroundColor: Colors.red,
//               );
//               throw 'Could not launch '+state.url;
//               // // check for browser fallback
//               // var tempComponents = state.url.split(';');
//               // var fallbackUrl = '';
//               // for(var component in tempComponents){
//               //   if(component.contains('browser_fallback_url')){
//               //     fallbackUrl = Uri.decodeFull(component.split('=').last);
//               //   }
//               // }
//               // // debugPrint('fallback url : $fallbackUrl');
//               // if (await canLaunch(fallbackUrl)) {
//               //   await launch(fallbackUrl);
//               //   flutterWebViewPlugin.goBack();
//               // } else {
//               //   flutterWebViewPlugin.goBack();
//               //   BotToast.showSimpleNotification(
//               //       title: 'Gagal membuka halaman '+state.url,
//               //       duration: Duration(seconds: 3),
//               //       backgroundColor: Colors.red,
//               //   );
//               //   throw 'Could not launch '+state.url;
//               // }
//             }
//           }
//           else if(state.url.contains("https://app.admincerdas.com/member/login")) {
//             if(_numRetry == 0 && _prevUrl != ''){
//               flutterWebViewPlugin.reloadUrl(_prevUrl, 
//                 headers: {
//                   'AccessToken': _member?.AccessToken ?? 'aciaciaci'
//                 }
//               );
//             }
//             else{
//               debugPrint("member login ????");
//               _viewLogin();
//               flutterWebViewPlugin.goBack();
//             }
//           }
//           else if(state.url.contains("https://admincerdas.com") || state.url.contains("https://app.admincerdas.com")){
//             debugPrint('open admincerdas web');
//             debugPrint('Access Token : ' + (_member?.AccessToken ?? 'aciaciaci'));
//             if(_prevUrl != state.url){
//               _prevUrl = state.url;
//               _numRetry = 0;
//             }
//             else{
//               _numRetry++;
//             }
//           }
//         }
//       }
//     });

//    flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error){
//      if (mounted) {
//        debugPrint('onHttpError: ${error.code} ${error.url}');
//      }
//    });
  }

  _viewLogin(){
    // MemberCubit.instance.logout();
    Navigator.of(context).pop();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => LoginPage()),
    //         (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("build "+_member.Name);
    return Scaffold(
      appBar: AppBar(
        // elevation: 8.0,
        // centerTitle: true,
        //backgroundColor: _barColor,
          title: Text(
            widget.title ?? '', 
            style: ATheme.textHeader2
          ),
          backgroundColor: AColors.appBarBackground,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.sync, 
                color: AColors.gray2, 
                size: 20,
              ),
              onPressed: (){
                //setState(() {
                  clearCache = true;
                  //activePage = _buildLoading();
                  BotToast.showText(text: 'Memuat ulang halaman...');
                  // flutterWebViewPlugin.clearCache();
                  // flutterWebViewPlugin.reload();
                  //activePage = _buildWebview();
                //});
              },
            )
          ],
      ),
      body: activePage,
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Text("Loading...")
    );
  }

  Widget _buildWebview(){
    String final_url = widget.url;
    if(!widget.url.contains("https://") && !widget.url.contains("http://")) {
      final_url = Config.baseUrl + widget.url;
    }
    debugPrint(final_url);

    // if register page, add CustomerReferrer header
    // if(widget.url == '/member/register'){
    //   //final _referrerDetails = await initReferrerDetails();
    //   return WebviewScaffold(
    //     url: final_url,
    //     withJavascript: true,
    //     headers: {
    //       'AccessToken': (_member != null) ? _member.AccessToken : 'aciaciaci',
    //       'CustomReferrer': _referrerDetails != null ? _referrerDetails : ''
    //     },
    //     //clearCache: clearCache, // for css
    //   );
    // }

    return WebView(
        initialUrl: final_url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (_controller){
          _webviewController = _controller;
        },
        onPageStarted: (url) async {
          if(
            WebViewPage._isOpenBrowser(url)
          ) {
            debugPrint("url not contains admincerdas.com");
            debugPrint(url);
            if (await canLaunch(url)) {
              await launch(url);
              _webviewController?.goBack();
            } else {
              throw 'Could not launch $url';
            }
          }
        }
        // headers: {'AccessToken': (_member != null) ? _member.AccessToken : 'aciaciaci'},
        //clearCache: clearCache, // for css
    );
  }

//   Future<void> initReferrerDetails() async {
//     String referrerDetailsString;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       ReferrerDetails referrerDetails = await AndroidPlayInstallReferrer.installReferrer;

//       referrerDetailsString = referrerDetails.toString();
//     } catch (e) {
//       referrerDetailsString = 'Failed to get referrer details: $e';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       debugPrint("REFERRER: "+referrerDetailsString);
//       _referrerDetails = referrerDetailsString;
// //    return _referrerDetails;
//     });
//   }
}

class PlatformWebViewControllerCreationParams {
}
