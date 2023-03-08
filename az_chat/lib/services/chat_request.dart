
import 'dart:convert';
import 'package:azlogistik_chat/utilities/model_helper.dart';
import 'package:html/dom.dart';
import 'package:azlogistik_chat/models/chat.dart';
import 'package:azlogistik_chat/models/chat_room.dart';
import 'package:azlogistik_chat/models/cloud_file.dart';
import 'package:azlogistik_chat/models/link_metadata.dart';
import 'package:azlogistik_chat/services/api_result.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:azlogistik_chat/utilities/network.dart';
import 'package:azlogistik_chat/utilities/text_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
 import 'package:crypto/crypto.dart';
import 'package:metadata_fetch/metadata_fetch.dart';


class ChatRequest {
  static String _generateSecretCode(String memberId, int time){
    String data = 'gettoken' + Config.clientId + memberId + time.toString();
    return sha256.convert(utf8.encode(data)).toString();
  }

  static Future<String?> getToken(String memberId) async {
    Response response;
    ApiResult result = ApiResult();
    String url = Urls.URL_GET_TOKEN;
    DateTime now = DateTime.now();
    // int time = ((now.millisecondsSinceEpoch - now.timeZoneOffset.inMilliseconds) / 1000).floor() + (Config.serverTimezone * 3600).floor(); 
    int time = (now.millisecondsSinceEpoch / 1000).floor(); 
    var formData = FormData.fromMap({
      'ClientID': Config.clientId,
      'SecretCode': _generateSecretCode(memberId, time),
      'Time': time,
      'MemberID': memberId.toString(),
    });
    // debugPrint(time.toString());
    try {
      response = await dio.post(url, data: formData);
      result.setResponse(response);
      // log('result registerDeviceID: '+response.toString());
      if(result.getResponseData() != null) {
        String token = result.getResponseData()['Token'];
        debugPrint('TOKEN : ' + token);
        return token;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<bool> registerDeviceID(String memberId, String token, String deviceInfo, String identifier) async {
    Response response;
    ApiResult result = ApiResult();
    String url = Urls.URL_REGISTER_DEVICE_ID;
    DateTime now = DateTime.now();
    // int time = ((now.millisecondsSinceEpoch - now.timeZoneOffset.inMilliseconds) / 1000).floor() + (Config.serverTimezone * 3600).floor(); 
    int time = (now.millisecondsSinceEpoch / 1000).floor(); 
    var formData = FormData.fromMap({
      'ClientID': Config.clientId,
      'AndroidID': token,
      // 'SecretCode': _generateSecretCode(memberId, time),
      'Time': time,
      'DeviceInfo': deviceInfo,
      'DeviceID': identifier,
      'MemberID': memberId,
    });
    try {
      response = await dio.post(url, data: formData);
      result.setResponse(response);
      // log('result registerDeviceID: '+response.toString());
      if(result.isMetaCode200()) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    
    return false;
  }

  static Future<CloudFile?> uploadFile(String filePath) async {
    Response response;
    ApiResult result = ApiResult();
    try{
      String url = Urls.URL_UPLOAD_FILE + '?App=1';
      FormData formData = FormData.fromMap({
        'File': await MultipartFile.fromFile(filePath, filename: filePath.split('/').last),
      });

      response = await dio.post(url, data: formData);
      result.setResponse(response);
      if(result.getJsonData() != null) {
        //member2 = Member2.fromJson(result.getJsonData());
        //result.success(result.getJsonData());
        return CloudFile.fromJson(result.getJsonData());
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
    return null;
  }
  
  static Future<List<ChatRoom>?> getRooms({
    String filter = '',
    String keyword = '',
    int start = 0,
    DateTime? lastEdited,
  }) async {
    Response response;
    ApiResult result = ApiResult();
    try{
      //param.toString();
      String readStatus = '';
      if(filter == 'unread'){
        readStatus = 'UNREAD';
      }
      else if(filter == 'read'){
        readStatus = 'READ';
      }
      Map<String, dynamic> params = {
        'ReadStatus' : readStatus
      };
      if(start > 0){
        params['Start'] = start;
      }
      if(keyword.isNotEmpty){
        params['Search'] = keyword;
      }
      if(lastEdited != null){
        params['LastEdited'] = TextHelper.convertDateToMysql(lastEdited);
      }
      String url = Urls.URL_CHAT_GET_ROOM;
      debugPrint('getRooms url: '+url);
      response = await dio.get(url,
        queryParameters: params
      );
      result.setResponse(response);
      if(result.getJsonData() != null) {
        return (response.data[Params.PARAM_DATA] as List<dynamic>).map((e) => ChatRoom.fromJson(e)).toList();
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  static Future<ChatRoom?> getRoomDetail({
    required String roomId,
  }) async {
    Response response;
    ApiResult result = ApiResult();
    try{
      //param.toString();
      Map<String, dynamic> params = {
        'RoomID': roomId,
      };
      String url = Urls.URL_CHAT_GET_ROOM_DETAIL;
      debugPrint('getRoom detail url: '+url);
      response = await dio.get(url,
        queryParameters: params
      );
      result.setResponse(response);
      if(result.getJsonData() != null) {
        if(ModelHelper.boolFromJson(response.data['IsBlocked'])){
          Config.chatPageController.blocked();
        }
        if(ModelHelper.boolFromJson(response.data['IsBlockedTo'])){
          Config.chatPageController.blocked(false);
        }
        return ChatRoom.fromJson(response.data[Params.PARAM_DATA]);
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
    return null;
  }
  
  static Future<bool> markAsRead({
    required String toId,
    required int messageId,
  }) async {
    Response response;
    ApiResult result = ApiResult();
    try{
      //param.toString();
      Map<String, dynamic> params = {
        'ToID' : toId,
        'MessageID': messageId
      };
      String url = Urls.URL_CHAT_READ_CHAT;
      debugPrint('readChats url: '+url);
      response = await dio.get(url, queryParameters: params);
      result.setResponse(response);
      if(result.getJsonData() != null) {
        return true;
      }
    }catch(e){
      debugPrint(e.toString());
      return false;
    }
    return false;
  }

  static Future<List<Chat>?> getChats({
    required String toId,
    int? lastId,
    int? start,
  }) async {
    Response response;
    ApiResult result = ApiResult();
    try{
      //param.toString();
      Map<String, dynamic> params = {
        'ToID' : toId,
      };
      if(lastId != null){
        params['LastID'] = lastId;
      }
      if(start != null){
        params['Start'] = start;
      }
      String url = Urls.URL_CHAT_GET_CHAT;
      debugPrint('getChats url: '+url);
      response = await dio.get(url, queryParameters: params);
      result.setResponse(response);
      if(result.getJsonData() != null) {
        if(ModelHelper.boolFromJson(response.data['IsBlocked'])){
          Config.chatPageController.blocked();
        }
        if(ModelHelper.boolFromJson(response.data['IsBlockedTo'])){
          Config.chatPageController.blocked(false);
        }
        return (response.data[Params.PARAM_DATA] as List<dynamic>).map((e) => Chat.fromJson(e)).toList();
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  static Future<Chat?> sendChat({
    required String toId,
    required String text,
    int? fileId,
  }) async {
    Response response;
    ApiResult result = ApiResult();
    try{
      var data = {
        'ToID': toId,
        'Message': text,
      };
      if(fileId != null && fileId > 0){
        data['FileID'] = fileId.toString();
      }
      //param.toString();
      String url = Urls.URL_CHAT_ADD_CHAT;
      debugPrint('add chat url: '+url);
      response = await dio.post(
        url, 
        data: FormData.fromMap(data),
      );
      result.setResponse(response);
      if(result.getJsonData() != null) {
        if(ModelHelper.boolFromJson(response.data['IsBlocked'])){
          Config.chatPageController.blocked();
        }
        return Chat.fromJson(response.data[Params.PARAM_DATA]);
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  static Document? responseToDocument(Response response) {
    if (response.statusCode != 200) {
      return null;
    }

    Document? document;
    try {
      // debugPrint('RESPONSE STRING : ');
      // debugPrint(response.data.toString());
      document = Document.html(response.data.toString());
    } catch (err) {
      return document;
    }

    return document;
  }

  static Future<LinkMetaData?> getUrlMeta(String message) async {
    Response response;
    ApiResult result = ApiResult();
    try{
      Map<String, dynamic> params = {
        'Message' : message
      };
      String url = Urls.URL_CHAT_PREVIEW;
      debugPrint('getRooms url: '+url);
      response = await dio.get(url,
        queryParameters: params
      );
      result.setResponse(response);
      if(result.getJsonData() != null) {
        return LinkMetaData.fromJson(response.data[Params.PARAM_DATA]);
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
    return null;
  }
}