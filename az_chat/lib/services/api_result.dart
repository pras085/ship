import 'dart:convert';

import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiResult{
  dynamic _data;    // object Data, example: Member2, Order, etc
  dynamic _jsonData;
  dynamic _error;
  Response? _response;
  Map<String, dynamic>? _responseData;

  ApiResult();

  setResponse(Response response){
    _response = response;
    _responseData = response.data is Map ? response.data : jsonDecode(response.data);
    debugPrint(response.request.uri.toString());
    debugPrint("ApiResult response "+response.toString());
    debugPrint("ApiResult response data : "+response.data.toString());
    if(_responseData != null && _responseData![Params.PARAM_META] != null && _responseData![Params.PARAM_META][Params.PARAM_CODE] != null){
      if(int.tryParse(_responseData![Params.PARAM_META][Params.PARAM_CODE].toString()) == 200){
        if(_responseData![Params.PARAM_DATA] != null){
          debugPrint("ApiResult ada data");
          _jsonData = _responseData![Params.PARAM_DATA];
        }
      }
      else{
        _data = null;
        _jsonData = null;//_responseData![Params.PARAM_DATA];
        debugPrint("error Meta Code "+_responseData![Params.PARAM_META][Params.PARAM_CODE].toString());
        debugPrint("error Meta Code "+_responseData![Params.PARAM_META][Params.PARAM_MESSAGE].toString());
        //this._error = _responseData![api.PARAM_META][api.PARAM_CODE].toString()+' '+_responseData![api.PARAM_META][api.PARAM_MESSAGE].toString();
        _error = _responseData![Params.PARAM_META][Params.PARAM_MESSAGE].toString();
      }
    }
  }

  success(data){
    _data = data;
    _error = null;
  }

  error(message){
    _data = null;
    _error = message;
  }

  getData(){
    return _data;
  }

  getJsonData(){
    return _jsonData;
  }

  getError(){
    return _error;
  }

  getResponseData(){
    return _responseData;
  }

  String? getJsonMessage(){
    if(_responseData != null && _responseData![Params.PARAM_META] != null && _responseData![Params.PARAM_META][Params.PARAM_CODE] != null){
      if(_responseData![Params.PARAM_META][Params.PARAM_CODE] == 200){
        if(_responseData![Params.PARAM_META][Params.PARAM_MESSAGE] != null){
          //debugPrint("ApiResult ada data");
          return _responseData![Params.PARAM_META][Params.PARAM_MESSAGE];
        }
      }
    }
    return null;
  }

  bool isMetaCode200(){
    if(_responseData != null && _responseData![Params.PARAM_META] != null && _responseData![Params.PARAM_META][Params.PARAM_CODE] != null){
      if(_responseData![Params.PARAM_META][Params.PARAM_CODE] == 200){
        return true;
      }
    }
    return false;
  }

  String? getMetaMessage(){
    if(_responseData != null && _responseData![Params.PARAM_META] != null && _responseData![Params.PARAM_META][Params.PARAM_CODE] != null){
      if(_responseData![Params.PARAM_META][Params.PARAM_MESSAGE] != null){
        //debugPrint("ApiResult ada data");
        return _responseData![Params.PARAM_META][Params.PARAM_MESSAGE];
      }
    }
    return null;
  }
}