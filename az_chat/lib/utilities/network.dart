import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:azlogistik_chat/views/webview_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
var dio = Dio();

class Network{
  static bool _initialized = false;

  static void init(){
    if(!_initialized){
      debugPrint('network init');
      dio.options.baseUrl = Config.baseUrl;
      dio.options.connectTimeout = 30000;
      dio.options.receiveTimeout = 10000;
      //onRequest: _requestInterceptor()
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options) => _requestInterceptor(options),
        onResponse: (response) => _responseInterceptor(response),
        onError: (DioError e) => _errorInterceptor(e)
      ));

      _initialized = true;
    }
  }

  static dynamic _requestInterceptor(RequestOptions options) async {
    debugPrint("_requestInterceptor "+options.path);
    if(!options.headers.containsKey('Authorization') || options.headers['Authorization'] == ''){
      // var memberData = await member.loadMember();
      if(options.path.startsWith(Config.baseUrl) && ChatCubit.instance.state.accessToken != ''){
        options.headers['Authorization'] = "Bearer ${ChatCubit.instance.state.accessToken}";
        debugPrint("Bearer ${ChatCubit.instance.state.accessToken}");
      }
    }
    return options;
    // return handler.next(options);
  }

  static dynamic _responseInterceptor(Response response) async {
    debugPrint("_responseInterceptor");
    final statusCode = response.statusCode;
    if(statusCode == 200){
      if(response.data is! Map){
        // convert to json if needed
        try{
          response.data = json.decode(response.data);
        }
        catch(e){
          debugPrint('response json decode error');
          debugPrint(e.toString());
          BotToast.showSimpleNotification(
            title: e.toString(),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            titleStyle: const TextStyle(color: Colors.white),
          );
        }
      }
      debugPrint(response.data.toString());
      if(response.data != null && response.data[Params.PARAM_META] != null && response.data[Params.PARAM_META][Params.PARAM_CODE] != null){
        if(response.data[Params.PARAM_META][Params.PARAM_CODE] != 200){
          debugPrint(response.request.uri.toString());
          debugPrint("error Meta Code "+response.data[Params.PARAM_META][Params.PARAM_CODE].toString());
          debugPrint("error Meta Code "+response.data[Params.PARAM_META][Params.PARAM_MESSAGE].toString());

          // cek link
          var link = response.data[Params.PARAM_LINK];

          // https://github.com/MMMzq/bot_toast/blob/master/example/lib/notification/simple_notification.dart
          BotToast.showSimpleNotification(
              title: response.data[Params.PARAM_META][Params.PARAM_MESSAGE].toString(),
              subTitle: link != null ? 'Lihat Detail' : null,
              subTitleStyle: link != null 
              ? const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                )
              : null,
              duration: Duration(seconds: link != null ? 6 : 3),
              backgroundColor: Colors.red,
              titleStyle: const TextStyle(color: Colors.white),
              onTap: link != null 
              ? (){
                WebViewPage.open(
                  context: ChatCubit.instance.state.navigatorKey.currentContext!,
                  title: response.data[Params.PARAM_META][Params.PARAM_MESSAGE].toString(),
                  url: link,
                );
              }
              : null
          );
          //return handler.reject("abc");
          //DioError error = DioError(requestOptions: response.requestOptions);
          //error.error = response.data[api.PARAM_META][api.PARAM_CODE].toString()+' '+response.data[api.PARAM_META][api.PARAM_MESSAGE].toString();
          //return handler.reject(error);
          //return response;
        }
      }
    }
    else{
      debugPrint("else "+statusCode.toString());
      BotToast.showSimpleNotification(
        title: statusCode.toString() +  ' ' + (response.statusMessage ?? ''),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        titleStyle: const TextStyle(color: Colors.white),
      );
    }
    // return handler.next(response);
    return response;
  }

  static dynamic _errorInterceptor(DioError e){
    debugPrint("_errorInterceptor");
    if(e.response != null) {
      debugPrint('e.response is not null');
      debugPrint(e.response!.data);
      debugPrint("${e.response!.statusCode} ${e.request.path} ${e.message}");
    }
    else{
      debugPrint('e.response is null');
    }
    BotToast.showSimpleNotification(
      //title: "${e.response.statusCode} - ${e.message}",
      title: e.message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      titleStyle: const TextStyle(color: Colors.white),
    );
    // return handler.next(e);
    return e;
  }
}