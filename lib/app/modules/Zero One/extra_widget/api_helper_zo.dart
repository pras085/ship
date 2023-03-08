import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_bid_winner_data_model.dart';

import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_notifikasi_harga_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/ZO_promo_transporter_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_model.dart';
import 'package:muatmuat/app/core/models/carrier_truck_response_model.dart';
import 'package:muatmuat/app/core/models/head_truck_model.dart';
import 'package:muatmuat/app/core/models/head_truck_response_model.dart';

import 'package:muatmuat/app/modules/Zero%20One/extra_widget/transporter_model_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/zo_bid_participant_model.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:path/path.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/create_file_for_debug.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/address_google_place_autocomplete_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/database/database_helper.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/shared_preferences_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:latlong/latlong.dart';
import 'package:quiver/collection.dart';
import 'package:muatmuat/app/network/api_helper.dart' as ah;

/// Class ApiHelper untuk mengakses ke API
class ApiHelper {
  final String _urlLive = "https://www.assetlogistik.com/";
  final String _urlDev = "https://dev.assetlogistik.com/";

  final String _url = ah.ApiHelper.url;
  static String urlInternal = ah.ApiHelper.urlInternal;
  final String _ZO_url = "${ah.ApiHelper.urlzo2}api/";
  final String _ZO_url_promo = "${ah.ApiHelper.urlzo}api/";
  final String _ZO_url_1 = "https://zo1.assetlogistik.com/api/";

  // Old Urls
  // final String _url = "https://devintern.assetlogistik.com/";
  // static String urlInternal = "https://internal.assetlogistik.com/";
  // final String _ZO_url = "https://zo1.assetlogistik.com/api/";
  // final String _ZO_url_promo = "https://devzo.assetlogistik.com/api/";

  //final String _url = "192.168.31.9/wfh/";
  //"http://47.241.76.187/muatmuat/";
  // "http://192.168.1.88:8888/muatmuat";

  ///

  final String _keyAPIGoogle =
      "AIzaSyDw_9D9-4zTechHn1wMEILZqiBv51Q7jHU"; // "AIzaSyCv16x_mZVUmpdNO6DnAwYuymgLClIrz0I";

  final BuildContext context;
  final bool isShowDialogLoading;
  final bool isShowDialogError;
  final bool isDebugGetResponse;

  bool _isShowingDialogLoading = false;
  bool isError = false;
  bool isErrorConnection = false;
  bool isErrorResponse = false;

  String errorMessage = "";

  final _keyDialog = new GlobalKey<State>();
  Function isiFungsi;

  final int _requestTimeOutSecond = 30;

  /// * [context] Context yang digunakan untuk menampilkan dialog. Default `null` jadi harus diisi
  ///
  /// * [isShowDialogLoading] isShowDialogLoading digunakan untuk tanda menampilkan dialog loading atau tidak ketika proses mengakses API. Default `true`.
  ///
  /// * [isShowDialogError] isShowDialogError digunakan untuk tanda menampilkan dialog error atau tidak ketika mendapatkan error. Jika diset `false`, maka sebagai penanda error atau tidak, bisa mengambil variabel [isError] untuk menandakan error atau tidak dan variabel [errorMessage] untuk mengambil pesan errornya. Default `true`.

  ApiHelper(
      {this.context,
      this.isShowDialogLoading = true,
      this.isShowDialogError = true,
      this.isDebugGetResponse = false});

  _getResponseFromURLMuatMuat(var response, bool isResponseBody,
      {bool isEnableCheckMessage = true}) {
    var responseResult;
    var responseBody = isResponseBody ? response.body : response;
    var errorMessage;
    try {
      _checkDebug(responseBody);
      responseResult = jsonDecode(responseBody);
    } catch (err) {
      responseResult = null;
      errorMessage = err.toString();
    }
    _closeDialogLoading();
    if (responseResult != null) {
      return isEnableCheckMessage
          ? _checkResponseBodyMuatMuat(responseResult)
          : responseResult;
    } else {
      _setError(isErrorConnection, true,
          errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
      if (isShowDialogError)
        return _showDialogError(
            errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
      else
        return null;
    }
  }

  _getResponseFromURLGooglePlaceAutoComplete(var response) {
    var responseResult;
    var errorMessage;
    try {
      responseResult = jsonDecode(response.body);
    } catch (err) {
      responseResult = null;
      errorMessage = err.toString();
    }
    // GlobalVariable.showMessageToastDebug(
    //     "_getResponseFromURLGoogle: " + responseResult.toString());
    _closeDialogLoading();
    if (responseResult != null) {
      return _checkResponseBodyGooglePlaceAutoComplete(responseResult);
    } else {
      _setError(isErrorConnection, true,
          errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
      if (isShowDialogError)
        return _showDialogError(
            errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
      else
        return null;
    }
  }

  _getResponseFromURLGooglePlaceDetails(var response) {
    var responseResult;
    var errorMessage;
    try {
      responseResult = jsonDecode(response.body);
    } catch (err) {
      responseResult = null;
      errorMessage = err.toString();
    }
    // GlobalVariable.showMessageToastDebug(
    //     "_getResponseFromURLGooglePlaceDetails: " + responseResult.toString());
    _closeDialogLoading();
    if (responseResult != null) {
      return _checkResponseBodyGooglePlaceDetails(responseResult);
    } else {
      _setError(isErrorConnection, true,
          errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
      if (isShowDialogError)
        return _showDialogError(
            errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
      else
        return null;
    }
  }

  _getResponseFromURLGoogleDirection(var response) {
    var responseResult;
    var errorMessage;
    try {
      responseResult = jsonDecode(response.body);
    } catch (err) {
      responseResult = null;
      errorMessage = err.toString();
    }
    _closeDialogLoading();
    if (responseResult != null) {
      return _checkResponseBodyGoogleDirectionAPI(responseResult);
    } else {
      _setError(isErrorConnection, true,
          errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
      if (isShowDialogError)
        return _showDialogError(
            errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
      else
        return null;
    }
  }

  Future _checkConnection() async {
    var errorMessage;
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        isError = true;
      }
    } catch (err) {
      isError = true;
      errorMessage = err.toString();
    }
    if (isError) {
      _setError(true, isErrorResponse,
          errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
      _showDialogError(errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
    }
  }

  _showDialogError(String message) {
    _closeDialogLoading();
    if (isShowDialogError) {
      GlobalAlertDialog.showDialogError(
          isDismissible: false, message: message, context: context);
      //GlobalAlertDialog.showDialogError(message: message, context: context);
      return;
    }
  }

  _checkDebug(String message) {
    if (kDebugMode) print("result message:" + message);
  }

  Future fetchDataFromUrlPOSTMuatMuatAfterLogin(String url, dynamic body,
      {bool isEnableCheckMessage = true, String vendor}) async {
    print('Debug: ' + 'before _fetchDataFromUrlPOSTMuatMuatAfterLogin');
    return await fetchDataFromUrlPOSTMuatMuat(url, body,
        afterLogin: true,
        isEnableCheckMessage: isEnableCheckMessage,
        vendor: vendor);
  }

  Future fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(String url,
      dynamic body, io.File imageFile, String imageField, MediaType fileContent,
      {String vendor}) async {
    return await fetchDataFromUrlPOSTMuatMuat(url, body,
        afterLogin: true,
        isMultiPart: true,
        fileField: imageField,
        file: imageFile,
        fileContent: fileContent,
        vendor: vendor);
  }

  Future fetchDataFromUrlPOSTMuatMuat(String url, dynamic body,
      {bool afterLogin = false,
      bool isMultiPart = false,
      bool isEnableCheckMessage = true,
      String fileField = "",
      io.File file = null,
      MediaType fileContent,
      String vendor}) async {
    print('Debug: ' + 'before _fetchDataFromUrlPOSTMuatMuat');
    bool isResponseBody = true;
    _checkDebug(url);
    print('Debug: ' + 'after _checkDebug');
    _resetError();
    print('Debug: ' + 'after _resetError');
    if (isShowDialogLoading) _showDialogLoading();
    await _checkConnection();
    print('Debug: ' + 'after _checkConnection');
    var response;
    var errorMessage;
    if (!isError) {
      try {
        print('Debug: ' + 'before afterLogin ' + body.toString());
        body = afterLogin
            ? _setBodyFetchURLAfterLogin(body, vendor: vendor)
            : _setBodyFetchURL(body, vendor: vendor);
        print('Debug: ' + 'after afterLogin ' + body.toString());
        if (body == null) {
          print('Debug: ' + 'before post 1');
          response = await http
              .post(url)
              .timeout(Duration(seconds: _requestTimeOutSecond));
          print('Debug: ' + 'after post ' + response.toString());
        } else {
          print('Debug: ' + 'before post 2');
          if (isMultiPart && file != null) {
            isResponseBody = false;
            var request = http.MultipartRequest("POST", Uri.parse(url));
            // var stream =
            //     http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
            // var length = await imageFile.length();
            // var request = http.MultipartRequest("POST", Uri.parse(url))..fields;
            // var multipart = http.MultipartFile('Avatar', stream, length,
            //     filename: basename(imageFile.path));
            request.files.add(http.MultipartFile.fromBytes(
                fileField, file.readAsBytesSync(),
                contentType: fileContent, filename: file.path.split("/").last));

            // request.files.add(
            //     await http.MultipartFile.fromPath('Avatar', imageFile.path));
            //var listEntry = body.entries.toList();
            for (var data in body.entries) {
              request.fields[data.key] = data.value;
            }

            var response2 = await request.send();
            response = await response2.stream.bytesToString();
            print("done");
          } else
            response = await http
                .post(url, body: body)
                .timeout(Duration(seconds: _requestTimeOutSecond));
        }
        print('Debug: ' + 'after post 2 ' + response.toString());
      } on TimeoutException {
        errorMessage = "GlobalLabelErrorNoConnection".tr;
      } catch (err) {
        errorMessage = err.toString();
        print("error _fetchDataFromUrlPOSTMuatMuat: " + err.toString());
      }
      if (response != null)
        return _getResponseFromURLMuatMuat(response, isResponseBody,
            isEnableCheckMessage: isEnableCheckMessage);
      else {
        _setError(true, isErrorResponse,
            errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
        if (isShowDialogError)
          return _showDialogError(
              errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
        else
          return null;
      }
    }
  }

  Future _fetchDataFromUrlGoogleAPI(String url) async {
    _resetError();
    if (isShowDialogLoading) _showDialogLoading();
    await _checkConnection();
    var response;
    var errorMessage;
    if (!isError) {
      try {
        response = await http.Client()
            .get(url)
            .timeout(Duration(seconds: _requestTimeOutSecond));
      } on TimeoutException {
        errorMessage = "GlobalLabelErrorNoConnection".tr;
      } catch (err) {
        errorMessage = err.toString();
      }
      if (response != null)
        return response;
      else {
        _setError(true, isErrorResponse,
            errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
        if (isShowDialogError)
          return _showDialogError(
              errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
        else
          return null;
      }
    }
  }

  Future _fetchDataFromUrlGooglePlaceAutoComplete(String url) async {
    var response = await _fetchDataFromUrlGoogleAPI(url);
    if (response != null)
      return _getResponseFromURLGooglePlaceAutoComplete(response);
    return response;
  }

  Future _fetchDataFromUrlGooglePlaceDetails(String url) async {
    var response = await _fetchDataFromUrlGoogleAPI(url);
    if (response != null)
      return _getResponseFromURLGooglePlaceDetails(response);
    return response;
  }

  Future _fetchDataFromUrlDirectionAPI(String url) async {
    var response = await _fetchDataFromUrlGoogleAPI(url);
    if (response != null) return _getResponseFromURLGoogleDirection(response);
    return response;
  }

  _setBodyFetchURL(Map<String, dynamic> body, {String vendor}) {
    Map<String, dynamic> rBody = body;
    if (body == null) {
      rBody = {
        'Lang': GlobalVariable.languageType,
      };
    } else if (rBody['Lang'] == null) {
      rBody['Lang'] = GlobalVariable.languageType;
    }
    if (vendor != null) {
      rBody = {
        'vendor': vendor,
      };
    }
    return rBody;
  }

  _setBodyFetchURLAfterLogin(Map<String, dynamic> body, {String vendor}) {
    Map<String, dynamic> baseBody = {
      'base_data': jsonEncode({
        'App': "1",
        'Locale': GlobalVariable.languageType,
        'Email': GlobalVariable.emailLogin,
        'Token': GlobalVariable.tokenApp,
        'Key': 'AZthebestsystem',
        'ID': GlobalVariable.docID
      })
    };
    print('Debug: ' + 'on _setBodyFetchURLAfterLogin ' + body.toString());
    Map<String, dynamic> rBody = {};
    if (body == null) {
      rBody = baseBody;
    } else {
      rBody.addAll(body);
      try {
        rBody.addAll(baseBody);
        //rBody.addEntries(baseBody['base_data']);
        //rBody.putIfAbsent('base_data', baseBody['base_data']);
        // rBody['base_data'] = {
        //   'App': "1",
        //   'Locale': GlobalVariable.languageType,
        //   'Email': GlobalVariable.emailLogin,
        //   'Token': GlobalVariable.tokenApp,
        // };
      } catch (err) {
        print(err.toString());
      }
    }

    if (vendor != null) {
      rBody = {
        'vendor': vendor,
      };
    }
    print(
        'Debug: ' + 'on _setBodyFetchURLAfterLogin rBody ' + rBody.toString());
    return rBody;
  }

  void _setError(
      bool isErrorConnection, bool isErrorResponse, String errorMessage) {
    isError = true;
    this.isErrorConnection = isErrorConnection;
    this.isErrorResponse = isErrorResponse;
    this.errorMessage = errorMessage;
  }

  void _resetError() {
    isError = false;
    isErrorResponse = false;
    isErrorConnection = false;
  }

  void _closeDialogLoading() {
    try {
      if (isShowDialogLoading && _isShowingDialogLoading) {
        _isShowingDialogLoading = false;
        Get.back();
      }
    } catch (err) {}
  }

  Future _showDialogLoading() async {
    _isShowingDialogLoading = true;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: _keyDialog,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText('GlobalLabelDialogLoading'.tr,
                            color: Colors.blueAccent)
                      ]),
                    )
                  ]));
        });
  }

  _checkResponseBodyMuatMuat(var responseBody) {
    Map<String, dynamic> json = responseBody;
    MessageFromUrlModel messageFromUrlModel =
        MessageFromUrlModel.fromJson(json["Message"]);
    //Cek Token salah
    if (messageFromUrlModel.code == 403) {
      GlobalAlertDialog.showDialogError(
          message: 'GlobalLabelErrorFalseTokenApp'.tr,
          context: context,
          onTapPriority1: () {
            LoginFunction().signOut();
          });
      return;
    } else {
      return responseBody;
    }
  }

  _checkResponseBodyGooglePlaceAutoComplete(var responseBody) {
    Map<String, dynamic> json = responseBody;
    GooglePlaceAutoCompleteResponse googleResponse =
        GooglePlaceAutoCompleteResponse.fromJson(json);
    if (googleResponse.status != 'OK') {
      // GlobalAlertDialog.showDialogError(
      //     message: googleResponse.status, context: context);
      return;
    } else {
      // GlobalVariable.showMessageToastDebug(
      //     "_checkResponseBodyGoogle: " + googleResponse.predictions.toString());
      return googleResponse.predictions
          .map((data) => AddressGooglePlaceAutoCompleteModel.fromJson(data))
          .toList();
    }
  }

  _checkResponseBodyGooglePlaceDetails(var responseBody) {
    // GlobalVariable.showMessageToastDebug(
    //     "_checkResponseBodyGooglePlaceDetails: " + responseBody.toString());
    Map<String, dynamic> json = responseBody;
    GooglePlaceDetailsResponse googleResponse =
        GooglePlaceDetailsResponse.fromJson(json);
    if (googleResponse.status != 'OK') {
      // GlobalAlertDialog.showDialogError(
      //     message: googleResponse.status, context: context);
      return;
    } else {
      // GlobalVariable.showMessageToastDebug(
      //     "_checkResponseBodyGooglePlaceDetails2: " +
      //         googleResponse.result.toString());
      return AddressGooglePlaceDetailsModel.fromJson(googleResponse.result);
    }
  }

  _checkResponseBodyGoogleDirectionAPI(var responseBody) {
    // GlobalVariable.showMessageToastDebug(
    //     "_checkResponseBodyGooglePlaceDetails: " + responseBody.toString());
    Map<String, dynamic> json = responseBody;
    GoogleDirectionAPIResponse googleResponse =
        GoogleDirectionAPIResponse.setListLatLng(json);
    if (googleResponse.status != 'OK') {
      // GlobalAlertDialog.showDialogError(
      //     message: googleResponse.status, context: context);
      return;
    } else {
      // GlobalVariable.showMessageToastDebug(
      //     "_checkResponseBodyGooglePlaceDetails2: " +
      //         googleResponse.result.toString());
      return googleResponse.listLatLng;
    }
  }

  Future fetchLogin(UserModel user, bool isGoogle) async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "api/users_login", {
      'Email': user.email,
      'Password': user.password,
      'IsGoogle': isGoogle ? "1" : "0",
      "Lang": GlobalVariable.languageType
    });
  }

  Future fetchRegister(UserModel user, bool isGoogle) async {
    await SharedPreferencesHelper.getLanguage();
    return await fetchDataFromUrlPOSTMuatMuat(
        _url + GlobalVariable.languageCode + "/api/users_register", {
      'Name': user.name,
      'Email': user.email,
      'Phone': user.phone,
      'Password': user.password,
      'ReferralCode': user.referralCode,
      'IsGoogle': isGoogle ? "1" : "0",
      'Lang': GlobalVariable.languageType
    });
  }

  Future fetchUpdateUsersDataForIsGoogle(UserModel user) async {
    await SharedPreferencesHelper.getLanguage();
    return await fetchDataFromUrlPOSTMuatMuat(
        _url + "api/doCreateGoogleAccount", {
      'ID': user.docID,
      'Name': user.name,
      'Email': user.email,
      'Phone': user.phone,
      'ReferralCode': user.referralCode,
    });
  }

  Future fetchVerifyEmail(String email) async {
    return await fetchDataFromUrlPOSTMuatMuat(
        _url + "verify/check_activation_email", {'Email': email, 'App': '1'});
    // var response =
    //     await http.post(_url + "verify/check_activation_email", body: {
    //   'Email': email,
    // });
    // return response;
  }

  Future fetchResendVerifyEmail(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "api/request_email",
        {'DocID': docID, 'Lang': GlobalVariable.languageType});
    // var response = await http.post(_url + "api/request_email", body: {
    //   'DocID': docID,
    // });
    // return response;
  }

  Future fetchResendVerifyPhone(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "api/request_phone", {
      'DocID': docID,
      'App': "1",
      'Lang': GlobalVariable.languageType,
    });
    // var response = await http.post(_url + "api/request_phone", body: {
    //   'DocID': docID,
    //   'App': "1",
    // });
    // return response;
  }

  Future fetchVerifyPhone(String docID, String phone) async {
    return await fetchDataFromUrlPOSTMuatMuat(
        _url + "verify/check_activation_phone", {
      'DocID': docID,
      'Phone': phone,
    });
    // var response =
    //     await http.post(_url + "verify/check_activation_phone", body: {
    //   'DocID': docID,
    // });
    // return response.body;
  }

  Future fetchVerifyOTPEmail(String verifID, String otp) async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "verify/input_otp_email",
        {'VerifID': verifID, 'Pin': otp, 'App': '1'});
  }

  Future fetchVerifyOTPPhone(String verifID, String otp) async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "verify/input_otp_phone",
        {'VerifID': verifID, 'Pin': otp, 'App': '1'});
  }

  Future fetchResetPassword(String email) async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "api/forgot_password", {
      'Email': email,
      'App': "1",
    });
    // var response = await http.post(_url + "api/forgot_password", body: {
    //   'Email': email,
    //   'App': "1",
    // });
    // return response.body;
  }

  Future fetchChangeNumber(String docID, String phone) async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "api/change_number", {
      'DocID': docID,
      'txtKontak': phone,
      'App': "1",
      'Lang': GlobalVariable.languageType
    });
    // var response = await http.post(_url + "api/change_number", body: {
    //   'DocID': docID,
    //   'txtKontak': phone,
    // });
    // return response.body;
  }

  Future fetchPrivacyPolicy({String type = "general"}) async {
    return await fetchDataFromUrlPOSTMuatMuat(
        _url + "api/privacy_policy", {'App': "1", 'Type': type});
  }

  Future fetchTermCondition({String type = "general"}) async {
    return await fetchDataFromUrlPOSTMuatMuat(
        _url + "api/terms_condition", {'App': "1", 'Type': type});
  }

  Future fetchLanguage() async {
    var body = {"Lang": GlobalVariable.languageType};
    var result = await DatabaseHelper.instance.getLanguageVersion();
    if (result.length > 0) {
      var params = List<Map<String, dynamic>>();
      result.forEach((language) {
        var languageParam = Map<String, dynamic>();
        languageParam["Data"] = language["class"];
        languageParam["Versi"] = language["version"];
        params.add(languageParam);
      });
      var stringParams = jsonEncode(params);
      body["Param"] = stringParams;
      print(stringParams);
    }
    // return await _fetchDataFromUrlPOSTMuatMuat("http://47.241.76.187/muatmuat/lang/", body);
    return await fetchDataFromUrlPOSTMuatMuat(_url + "lang/backend", body);
  }

  Future fetchHeadTruck() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_head_truck", null);
  }

  Future fetchAllCarrierTruck() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_carrier_truck", null);
  }

  Future fetchAllCity() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_destination", null);
  }

  Future requestAsPartner(String shipperID, String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doAddMitraWithPermission", {
      "ShipperID": shipperID,
      "TransporterID": transporterID,
      "Role": GlobalVariable.role
    });
    // return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
    //     _url + "backend/doAddMitra", {
    //   "ShipperID": shipperID.toString(),
    //   "TransporterID": transporterID.toString()
    // });
  }

  Future removePartner(String docID,
      {String transporterID = "", String shipperID = ""}) async {
    var body = {"Void": "1"};
    if (docID.isNotEmpty) {
      body["DocID"] = docID;
    } else {
      body["TransporterID"] = transporterID;
      body["ShipperID"] = shipperID;
    }
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/void_mitra", body);
  }

  Future fetchCheckDuplicateAccount(UserModel userModel) async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "api/check_email_phone", {
      'Email': userModel.email,
      'Phone': userModel.phone,
      'Lang': GlobalVariable.languageType
    });
  }

  Future getCheckValidRefferal(UserModel userModel) async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "api/check_ref_code", {
      'RefCode': userModel.referralCode,
    });
  }

  Future fetchListLanguage() async {
    // return await _fetchDataFromUrlPOSTMuatMuat(_url + "lang/available", null);
    return await fetchDataFromUrlPOSTMuatMuat(_url + "lang/available", null);
  }

  Future fetchCheckDevice() async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "api/check_device", {
      'Email': GlobalVariable.emailLogin,
    });
  }

  Future fetchAutoCompletePlaceAPI(String input, String token) async {
    input = input.replaceAll(" ", "+");
    return await _fetchDataFromUrlGooglePlaceAutoComplete(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?language=id&input=" +
            input +
            "&components=country:id&key=" +
            _keyAPIGoogle +
            "&sessiontoken=" +
            token);
  }

  Future fetchPlaceDetailsAPI(String placeId, String token) async {
    return await _fetchDataFromUrlGooglePlaceDetails(
        "https://maps.googleapis.com/maps/api/place/details/json?language=id&place_id=" +
            placeId +
            "&fields=address_components,formatted_address,geometry&key=" +
            _keyAPIGoogle +
            "&sessiontoken=" +
            token);
  }

  Future fetchDirectionAPI(LatLng latLngFrom, LatLng latLngDest) async {
    return await _fetchDataFromUrlDirectionAPI(
        "https://maps.googleapis.com/maps/api/directions/json?origin=" +
            latLngFrom.latitude.toString() +
            "," +
            latLngFrom.longitude.toString() +
            "&destination=" +
            latLngDest.latitude.toString() +
            ", " +
            latLngDest.longitude.toString() +
            "&mode=driving&key=" +
            _keyAPIGoogle);
  }

  Future fetchBusinessEntity() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_business_entity", null);
  }

  Future fetchBusinessField() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_business_field", null);
  }

  Future fetchCategoryCapacity() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_category_capacity", null);
  }

  Future fetchProvince() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_province", null);
  }

  Future fetchProfileShipper() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_profile_shipper",
        {"UsersID": GlobalVariable.userModelGlobal.docID});
  }

  Future fetchShipperRegister(
    String userID,
    String accountType,
    String youAre,
    String nameAlias,
    String businessEntity,
    String businessField,
    String address,
    String province,
    String city,
    String postalCode,
    String capacityCategory,
    String capacity,
    String namePic1,
    String tlpPic1,
    String namePic2,
    String tlpPic2,
    String namePic3,
    String tlpPic3,
  ) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "api/doRegisterShipperBuyer", {
      'UserID': userID,
      'param': jsonEncode({
        'rbAccountType': accountType,
        'rbYouAre': youAre,
        'txtNameAlias': nameAlias,
        'ddBusinessEntity': businessEntity,
        'ddBusinessField': businessField,
        'txtAlamat': address,
        'ddProvince': province,
        'ddKota': city,
        'txtKodePos': postalCode,
        'ddKategoriKapasitas': capacityCategory,
        'txtKapasitas': capacity,
        'NamePic1': namePic1,
        'TlpPic1': tlpPic1,
        'NamePic2': namePic2,
        'TlpPic2': tlpPic2,
        'NamePic3': namePic3,
        'TlpPic3': tlpPic3,
      })
    });
  }

  Future fetchCity(String provinceId) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_kota", {'provinceID': provinceId});
  }

  Future fetchCarrierTruck({String headID}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_carrier_truck",
        headID != null ? {'HeadID': headID} : null);
  }

  Future fetchAreaPickupSearch(String cityPickup, String districtPickup,
      String cityDestination, String jenisTruk, String jenisCarrier) async {
    var query = {
      "Type": "1",
      "cityPickup": cityPickup,
      "districtPickup": districtPickup,
      "cityDestination": cityDestination,
      "jenis_truk": jenisTruk,
      "jenis_carrier": jenisCarrier,
    };
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_all_filter_master_truk_siap_muat", query);
  }

  Future fetchAreaPickupTransporter(String transporterID) async {
    var query = {"Type": "2", "TransporterID": transporterID};
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_all_filter_master_truk_siap_muat", query);
  }

  Future fetchSearchLocationTruckReady(String sourceCity, String destCity,
      String headID, String carrierID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_list_location_truck_ready", {
      'q[SourceCity]': sourceCity,
      'q[DestinationCity]': destCity,
      'q[HeadID]': headID,
      'q[CarrierID]': carrierID
    });
  }

  Future fetchCheckUser() async {
    //Mode 1 = All; Mode 2 = Shipper; Mode 4 = Transporter; Mode 8 = Seller; Mode 16 = Jobseeker
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "api/check_user", {'Mode': "2"});
  }

  Future fetchCheckRoleRegister() async {
    UserModel userModel = await SharedPreferencesHelper.getUserModel();
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/check_role_register", {"UsersID": userModel.docID});
  }

  Future fetchAddLocationManagement(
      {@required String name,
      @required String address,
      @required String latitude,
      @required String longitude,
      @required String district}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doAddSaveLocation", {
      'param': jsonEncode({
        'Name': name,
        'Address': address,
        'Latitude': latitude,
        'Longitude': longitude,
        'District': district,
        'Role': GlobalVariable.role,
        'UsersID': GlobalVariable.userModelGlobal.docID,
      })
    });
  }

  Future fetchAddHistoryLocation(
      {@required String address,
      @required String latitude,
      @required String longitude,
      @required String district}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doAddHistoryLocation", {
      'param': jsonEncode({
        'Address': address,
        'Latitude': latitude,
        'Longitude': longitude,
        'District': district,
        'Role': GlobalVariable.role,
        'UsersID': GlobalVariable.userModelGlobal.docID,
      })
    });
  }

  Future fetchAllHistoryLocation() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_history_location", {
      'Role': GlobalVariable.role,
      'UsersID': GlobalVariable.userModelGlobal.docID,
    });
  }


  Future fetchSetting() async {
    return await fetchDataFromUrlPOSTMuatMuat(_url + "api/get_setting", null);
  }

  Future fetchInfoPermintaanMuat(
      {String search,
      Map<dynamic, dynamic> order,
      Map<dynamic, dynamic> filter,
      int limit,
      int pageNow,
      bool isHistory = false}) async {
    var query = {
      "search": search,
      "limit": limit.toString(),
      "pageNow": pageNow.toString()
    };
    if (isHistory) {
      query["history"] = "1";
    }
    if (filter.isNotEmpty) {
      query["filter"] = jsonEncode(filter);
    }
    if (order.isNotEmpty) {
      var stringOrder = "";
      order.keys.forEach((element) {
        if (order.keys.first == element) {
          stringOrder += element;
        } else {
          stringOrder += ",$element";
        }
      });
      var stringOrderMode = "";
      order.values.forEach((element) {
        if (order.values.first == element) {
          stringOrderMode += element;
        } else {
          stringOrderMode += ",$element";
        }
      });
      query["sortBy"] = stringOrder;
      query["sortType"] = stringOrderMode;
    }
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_permintaan_muat", query);
  }

  Future createPermintaanMuat(
      String shipperID,
      String tanggalDibuat,
      String tipePickup,
      String jumlahLokasiPickup,
      List latPickUp,
      List lngPickup,
      List pickUpAddress,
      List pickUpDetailAddress,
      List pickupCity,
      List pickupDistrict,
      List pickupNamaPic,
      List pickupNoPic,
      String estimasiPickup,
      String tipeBongkar,
      String jumlahLokasiBongkar,
      List latBongkar,
      List lngBongkar,
      List addressBongkar,
      List detailBongkar,
      List cityBongkar,
      List districtBongkar,
      List namaPicBongkar,
      List bongkarNoPic,
      String estimasiBongkar,
      String jenisTruck,
      String jenisCarrier,
      String jumlahTruck,
      String deskripsiMuatan,
      String berat,
      String volume,
      String dimensi,
      String jumlahKoli,
      String deskripsi,
      Map invitation,
      String zonaMuat,
      String zonaBongkar) async {
    var query = {
      "ShipperID": shipperID,
      "tanggal_dibuat": tanggalDibuat,
      "tipePickUp": tipePickup,
      "jumlahLokasiPickUp": jumlahLokasiPickup,
      "latPickUp": jsonEncode(latPickUp),
      "lngPickUp": jsonEncode(lngPickup),
      "pickUpAddress": jsonEncode(pickUpAddress),
      "pickUpDetailAddress": jsonEncode(pickUpDetailAddress),
      "cityPickup": jsonEncode(pickupCity),
      "districtPickup": jsonEncode(pickupDistrict),
      "pickup_nama_pic": jsonEncode(pickupNamaPic),
      "pickup_no_pic": jsonEncode(pickupNoPic),
      "estimasi_pickup": estimasiPickup,
      "tipeBongkar": tipeBongkar,
      "jumlahLokasiBongkar": jumlahLokasiBongkar,
      "latBongkar": jsonEncode(latBongkar),
      "lngBongkar": jsonEncode(lngBongkar),
      "addressBongkar": jsonEncode(addressBongkar),
      "detailBongkar": jsonEncode(detailBongkar),
      "cityBongkar": jsonEncode(cityBongkar),
      "districtBongkar": jsonEncode(districtBongkar),
      "bongkar_nama_pic": jsonEncode(namaPicBongkar),
      "bongkar_no_pic": jsonEncode(bongkarNoPic),
      "estimasi_bongkar": estimasiBongkar,
      "jenis_truck": jenisTruck,
      "jenis_carrier": jenisCarrier,
      "jumlah_truck": jumlahTruck,
      "deskripsiMuatan": deskripsiMuatan,
      "berat": berat,
      "volume": volume,
      "dimensi": dimensi,
      "jumlah_koli": jumlahKoli,
      "deskripsi": deskripsi,
      "invitation": jsonEncode(invitation),
      "zona_muat_code": zonaMuat,
      "zona_bongkar_code": zonaBongkar
    };
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/save_data_permintaan_muat", query);
  }

  Future detailPermintaanMuat(String shipperID, String muatID) async {
    var query = {"ShipperID": shipperID, "PermintaanMuatID": muatID};
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_detail_permintaan_muat", query);
  }

  Future updatePermintaanMuat(
      String shipperID, String muatID, List deskripsi, String status) async {
    var query = {
      "ShipperID": shipperID,
      "PermintaanMuatID": muatID,
      "deskripsi": jsonEncode(deskripsi),
      "status": status
    };
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/save_data_edit_permintaan_muat", query);
  }

  Future listHeadTruck() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_head_truck", null);
  }

  Future listCarrierTruck() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_carrier_truck", null);
  }

  Future listCarrierTruckByTruck({String headID}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_carrier_truck_by_truck",
        headID != null ? {'HeadID': headID} : null);
  }

  Future getSpecificTruck(String headID, String carrierID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_truck",
        {"HeadID": headID, "CarrierID": carrierID});
  }

  Future getListDiumumkan(String shipperID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_diumumkan_kepada_permintaan_muat",
        {"ShipperID": shipperID});
  }

  Future fetchListSearchTruckSiapMuat(
      String page,
      String limit,
      String addressPickup,
      String city,
      String district,
      String destinasi,
      String head,
      String carrier,
      Map<dynamic, dynamic> order,
      Map<dynamic, dynamic> filter,
      {String search = ""}) async {
    var query = {
      "limit": limit,
      "pageNow": page,
      "IsShipper": "1",
      "addres_pickup": addressPickup,
      "cityPickup": city,
      "districtPickup": district,
      "cityDestination": destinasi,
      "jenis_truk": head,
      "jenis_carrier": carrier,
    };
    var stringOrder = "";
    var stringOrderMode = "";
    if (order.isNotEmpty) {
      order.keys.forEach((element) {
        if (order.keys.first == element) {
          stringOrder += element;
          stringOrderMode += order[element];
        } else {
          stringOrder += ",$element";
          stringOrderMode += ",${order[element]}";
        }
      });
    }
    query["sortBy"] = stringOrder;
    query["sortType"] = stringOrderMode;
    if (search.isNotEmpty) {
      query["search"] = search;
    }
    if (filter.isNotEmpty) {
      query["filter"] = jsonEncode(filter);
    }
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_truk_siap_muat", query);
  }

  Future getHistoryTransactLocation(String userID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_history_location",
        {"UsersID": userID, "Role": GlobalVariable.role});
  }

  Future fetchDetailManajemenLokasi(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_detail_save_location", {"DocID": docID});
  }

  Future fetchDeleteManajemenLokasi(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doDeleteSaveLocation", {"DocID": docID});
  }

  Future fetchInfoFromAddress({String address, String placeID}) async {
    var body = (placeID != null) ? {"place_id": placeID} : {"address": address};
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "api/get_lat_long", body,
        isEnableCheckMessage: false);
  }

  Future fetchMaxTruck({String shipperID}) async {
    var body = (shipperID != null) ? {"ShipperID": shipperID} : null;
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_max_truck", body,
        isEnableCheckMessage: false);
  }

  Future fetchLTSMAllLocation(
      {@required String transporterID,
      Map<String, dynamic> sort,
      Map<String, dynamic> filter,
      String search = ""}) async {
    var body = {"IsShipper": "1", "IsAll": "1", "transporterID": transporterID};
    if (sort.isNotEmpty) {
      var stringOrder = "";
      var stringOrderMode = "";
      sort.keys.forEach((element) {
        if (sort.keys.first == element) {
          stringOrder += element;
          stringOrderMode += sort[element];
        } else {
          stringOrder += ",$element";
          stringOrderMode += ",${sort[element]}";
        }
      });
      body["sortBy"] = stringOrder;
      body["sortType"] = stringOrderMode;
    }
    if (filter != null && filter.length > 0) {
      // if (filter.containsKey("pickup")) {
      //   if (filter["pickup"] != "") {
      //     filter["pickup"] = "[" + filter["pickup"] + "]";
      //   }
      // }
      body["filter"] = jsonEncode(filter);
    }
    if (search.isNotEmpty) {
      body["search"] = search;
    }
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_truk_siap_muat", body,
        isEnableCheckMessage: false);
  }

  List<String> _getParamForSortFilter(Map<String, dynamic> data) {
    String stringKey = "";
    data.keys.forEach((element) {
      if (data.keys.first == element) {
        stringKey += element;
      } else {
        stringKey += ",$element";
      }
    });
    String stringValue = "";
    data.values.forEach((element) {
      if (data.values.first == element) {
        stringValue += element;
      } else {
        stringValue += ",$element";
      }
    });
    return [stringKey, stringValue];
  }

  Future fetchGetCountLTSM() async {
    var body;
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_count_truk_siap_muat", body,
        isEnableCheckMessage: false);
  }

  Future fetchSearchCity(String search) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_all_kota", {"q": search});
  }

  Future fetchListMuatan(String roleprofil, String loginAS, String type) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "get_search_filter",
        {"roleProfile": roleprofil, "type": type, "loginAs": loginAS});
  }

  Future getCurrentDate(String roleprofil, String loginAS) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "get_current_date",
        {"roleProfile": roleprofil, "loginAs": loginAS});
  }

  Future fetchAllDistrict(String search) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_all_district", {"q": search});
  }

  Future fetchLastTransaction(String shipperID, String type) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_last_transaction_location", {
      "TransporterID": shipperID,
      "Type": type
    }); // belum bisa API untuk shipper ID
  }

  Future fetchGetDataUserTypeInformation() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_user_type_information", {}); // belum ada data
  }

  Future fetchListManagementLokasi(
      String search,
      Map<dynamic, dynamic> filter,
      Map<dynamic, dynamic> order,
      int limit,
      int offset,
      String usersID) async {
    var query = {
      "q": search,
      "Limit": limit.toString(),
      "Offset": offset.toString()
    };
    if (filter != null) {
      query["filter"] = jsonEncode(filter);
    }
    if (order.isNotEmpty) {
      var stringOrder = "";
      var stringOrderMode = "";
      order.keys.forEach((element) {
        if (order.keys.first == element) {
          stringOrder += element;
          stringOrderMode += order[element];
        } else {
          stringOrder += ",$element";
          stringOrderMode += ",${order[element]}";
        }
      });
      query["Order"] = stringOrder;
      query["OrderMode"] = stringOrderMode;
    }
    query["Role"] = "2";
    query["UsersID"] = usersID;
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_save_location", query);
  }

  Future fetchPaketLangganan() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_paket_langganan",
        {"Role": "2", "SuperMenuID": "1"});
  }

  Future fetchPaketLanggananSubuser(
      int paketLanggananID, String usedPaketSubuser,
      {bool nextLangganan = false,
      bool fromBigfleet = true,
      int detailPaketSubuser}) async {
    var body = {
      "PaketLanggananID": paketLanggananID.toString(),
      "UsePaketID": usedPaketSubuser,
      "LimitMode": fromBigfleet.toString(),
      "Role": "2",
      "SuperMenuID": "1",
      "IsNext": nextLangganan ? "1" : "0"
    };
    if (detailPaketSubuser != null) {
      body["PaketID"] = detailPaketSubuser.toString();
    }
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_paket_sub_users", body);
  }

  Future getCheckSegmented(
      {@required String role, @required String roleUserId}) async {
    var body = {
      "Role": role,
      "RoleUserID": roleUserId,
    };
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/check_segmented_user_bf", body);
  }

  Future getTimelineSubscription(Map<String, dynamic> body) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_timeline_subscription", body);
  }

  Future getDashboardSubscriptionShipper() async {
    var body = Map<String, dynamic>();
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_dashboard_subscription_shipper", body);
  }

  Future getRiwayatLangganan(Map<String, dynamic> body) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_riwayat_langganan", body);
  }

  Future getRiwayatSubUsers(Map<String, dynamic> body) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_riwayat_sub_users", body);
  }

  Future fetchListSubscriptionVoucher(int isFirst, String paketID,
      {String search = ""}) async {
    var body = {"IsFirst": isFirst.toString(), "PaketID": paketID, "q": search};
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_voucher", body);
  }

  Future checkSubscriptionVoucher(
    List paketID,
    String voucherID,
  ) async {
    var body = {
      "Role": "2",
      "VoucherID": voucherID,
      "trans": jsonEncode(paketID)
    };
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/check_voucher", body);
  }

  Future doAddSubscription(List paketSubuser, String paketID, String voucherID,
      String paymentID) async {
    var body = {
      "PaketLanggananID": paketID,
      "VoucherID": voucherID.isEmpty ? "0" : voucherID,
      "PaymentID": paymentID
    };
    if (paketSubuser.length > 0) body["trans"] = jsonEncode(paketSubuser);
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doAddOrderSubscriptionBFByShipper", body);
  }

  Future getDetailOrderByShipper(Map<String, dynamic> body) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_detail_order_by_shipper", body);
  }

  Future getDetailOrderSubusersByShipper(Map<String, dynamic> body) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_detail_order_subusers_by_shipper", body);
  }

  Future getPeriodePaketSubuser(String subscriptionID, String paketID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_periode_paket_subusers",
        {"Role": "2", "SubscriptionID": subscriptionID, "PaketID": paketID});
  }

  Future cekPeriodePaketSubuser(
      String subscriptionID, String paketID, String tanggal) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_periode_subscription", {
      "Role": "2",
      "SubscriptionID": subscriptionID,
      "PaketID": paketID,
      "Tanggal": tanggal
    });
  }

  Future doAddSubuser(List paketSubuser, String subscriptionID,
      String voucherID, String paymentID) async {
    var body = {
      "trans": jsonEncode(paketSubuser),
      "VoucherID": voucherID.isEmpty ? "0" : voucherID,
      "PaymentID": paymentID,
      "SubscriptionID": subscriptionID,
    };
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doAddOrderSubscriptionSubUsersByShipper", body);
  }

  Future getPacketSubscriptionActiveByShipper(Map<String, dynamic> body) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_packet_subscription_active_by_shipper", body);
  }

  Future getPacketSubscriptionHistoryByShipper(
      Map<String, dynamic> body) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_packet_subscription_history_by_shipper", body);
  }

  Future getListPaymentMethod() async {
    print('Debug: ' + 'before getListMetodePembayaran');
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_payment_method", null);
  }

  Future getListStepPayment() async {
    print('Debug: ' + 'before getListMetodePembayaran');
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_step_payment", null);
  }

  Future doUpdatePaymentSubscription(
      String orderID, String type, String paymentID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doUpdatePaymentMethodForShipper",
        {"OrderID": orderID, "Type": type, "PaymentID": paymentID});
  }

  Future doUpdateStatusOrderSubscription(String orderID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doPaymentSubscriptionBFByShipper",
        {"OrderID": orderID});
  }

  Future doUpdateStatusOrderSubuser(String orderID, String isNext) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doPaymentSubscriptionSubUsersByShipper",
        {"OrderID": orderID, "IsNext": isNext});
  }

  Future doCancelOrderSubscription(String orderID, String notes) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doCancelOrderSubscriptionBFByShipper",
        {"OrderID": orderID, "Notes": notes});
  }

  Future doCancelOrderSubuser(String orderID, String notes) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doCancelOrderSubscriptionSubUsersByShipper",
        {"OrderID": orderID, "Notes": notes});
  }

//ZO
  Future getListLelangMuatan(
      String type, String search, String filter, String roleId,
      {String word,
      String startdate,
      String enddate,
      String startcreateddate,
      String endcreateddate,
      String startpickupdate,
      String endpickupdate,
      String startdestinationdate,
      String enddestinationdate,
      String mintrukqty,
      String maxtrukqty,
      String minkoliqty,
      String maxkoliqty,
      String dimension,
      String length,
      String width,
      String height,
      String dimensionUnit,
      String volume,
      List idcargotype,
      List status,
      List cargo,
      List pickuplocation,
      List destinationlocation,
      List province,
      List headid,
      List carrierid,
      String orderBy,
      String orderMode,
      String multiOrder,
      String limit,
      String offset}) async {
    Map filterdata = {
      "start_date": startdate,
      "end_date": enddate,
      "start_created_date": startcreateddate,
      "end_created_date": endcreateddate,
      "start_pickup_date": startpickupdate,
      "end_pickup_date": endpickupdate,
      "start_destination_date": startdestinationdate,
      "end_destination_date": enddestinationdate,
      "min_truck_qty": mintrukqty,
      "max_truck_qty": maxtrukqty,
      "min_koli_qty": minkoliqty,
      "max_koli_qty": maxkoliqty,
      "dimension": dimension,
      "length": length,
      "width": width,
      "height": height,
      "dimension_unit": dimensionUnit,
      "volume": volume,
      "id_cargo_type": idcargotype,
      "status": status,
      "cargo": cargo,
      "pickup_location": pickuplocation,
      "destination_location": destinationlocation,
      "province": province,
      "head_id": headid,
      "carrier_id": carrierid
    };
    String filterStr = json.encode(filterdata);
    if (orderBy == "") {
      return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _ZO_url + "get_list_bids", {
        "roleProfile": "2",
        "loginAs": roleId,
        "name": "",
        "city_id": "",
        "type": type,
        "isSearch": search,
        "isFilter": filter,
        "q": word,
        "filter": filterStr,
        "Limit": limit,
      });
    } else {
      return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _ZO_url + "get_list_bids", {
        "roleProfile": "2",
        "loginAs": roleId,
        "name": "",
        "type": type,
        "city_id": "",
        "isSearch": search,
        "isFilter": filter,
        "q": word,
        "filter": filterStr,
        "Order": orderBy,
        "OrderMode": orderMode,
        "Multiorder": multiOrder,
        "Limit": limit,
        // "Offset": offset
      });
    }
  }

//ZO
  Future getUserShiper(String role) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "get_login_as", {"Role": role});
  }

  Future postCloseLelang(String id, String loginAS, String role) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "post_close_bid",
        {"id": id, "loginAs": loginAS, "roleProfile": role});
  }

  Future postInsertNote(
      String idLelang, String loginAS, String role, String note) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "post_insert_note", {
      "id": idLelang,
      "loginAs": loginAS,
      "roleProfile": role,
      "notes": note
    });
  }

  Future postChoseWiner(String loginas, String id, List pemenang) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "post_choose_winner", {
      "roleProfile": GlobalVariable.role,
      "loginAs": loginas,
      "id": id,
      "pemenang": jsonEncode(pemenang)
    });
  }

  Future postBatalLelang(String id, String loginAS, String role) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "post_cancel_bid",
        {"id": id, "loginAs": loginAS, "roleProfile": role});
  }

  Future getDetailBid(String id, String loginAS, String role) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "get_detail_bid",
        {"loginAs": loginAS, "roleProfile": role, "id": id});
  }

  Future postUpdateViewers(String idLelang, String loginAS, String role) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "post_updated_viewers",
        {"loginAs": loginAS, "roleProfile": role, "doc_ID": idLelang});
  }

  Future getTerakhirDicari(
      String typePickup, String loginAS, String role) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "get_last_searched_location",
        {"LoginAs": loginAS, "RoleProfile": role, "type": typePickup});
  }

  Future getTransaksiTerakhir(
      String typePickup, String loginAS, String role) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "get_last_location",
        {"LoginAs": loginAS, "RoleProfile": role, "type": typePickup});
  }

  Future postBuatLelangMuatan(
      String roleProfile,
      String loginAs,
      String shippercode,
      String shipperemail,
      String shippername,
      String shipperavatar,
      String shippertimezone,
      String startdate,
      String enddate,
      String bidtype,
      String truckqty,
      String truckpicture,
      String headid,
      String headname,
      String carrierid,
      String carriername,
      String truckid,
      String cargo,
      String idcargotype,
      String weight,
      String volume,
      String dimension,
      String koliqty,
      String pickuptype,
      String pickupeta,
      String pickupetatimezone,
      String destinationtype,
      String destinationeta,
      String destinationetatimezone,
      String maxprice,
      String priceinclude,
      String itemprice,
      String handlingloadingprice,
      String handlingunloadingprice,
      String paymentterm,
      String provincepickup,
      String provincedestination,
      String citypickup,
      String citydestination,
      String notes,
      List location) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "post_create_bid", {
      "roleProfile": roleProfile,
      "loginAs": loginAs,
      "shipper_code": shippercode,
      "shipper_email": shipperemail,
      "shipper_name": shippername,
      "shipper_avatar": shipperavatar,
      "shipper_timezone": shippertimezone,
      "start_date": startdate,
      "end_date": enddate,
      "bid_type": bidtype,
      "truck_qty": truckqty,
      "truck_picture": truckpicture,
      "head_id": headid,
      "head_name": headname,
      "carrier_id": carrierid,
      "carrier_name": carriername,
      "truck_id": truckid,
      "cargo": cargo,
      "id_cargo_type": idcargotype,
      "weight": weight,
      "volume": volume,
      "dimension": dimension,
      "koli_qty": koliqty,
      "pickup_type": pickuptype,
      "pickup_eta": pickupeta,
      "pickup_eta_timezone": pickupetatimezone,
      "destination_type": destinationtype,
      "destination_eta": destinationeta,
      "destination_eta_timezone": destinationetatimezone,
      "max_price": maxprice,
      "price_include": priceinclude,
      "item_price": itemprice,
      "handling_loading_price": handlingloadingprice,
      "handling_unloading_price": handlingunloadingprice,
      "payment_term": paymentterm,
      "province_pickup": provincepickup,
      "province_destination": provincedestination,
      "city_pickup": citypickup,
      "city_destination": citydestination,
      "notes": notes,
      "location": jsonEncode(location)
    });
  }

  Future getProfilShipper(String shiperID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_profile_by_shipper", {"ShipperID": shiperID});
  }

  Future getTimeZoneShipper(String userID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_list_timezone", {"UsersID": userID});
  }

  Future getListNotifikasi(String loginAS, String role) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "get_notification",
        {"loginAs": loginAS, "roleProfile": role});
  }

  Future postReadNotifikasi(String loginAS, String id) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "post_read_notification",
        {"loginAs": loginAS, "roleProfile": GlobalVariable.role, "id": id});
  }

  Future fetchProvinceFilter(String province) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_province", {"q": province});
  }

  Future getListPesertaLelang(String idLelang, String loginAs, String orderby,
      String ordermode, String limit, String multiorder, String q) async {
    var t = {
      "doc_ID": idLelang,
      "roleProfile": GlobalVariable.role,
      "loginAs": loginAs,
      "OrderBy": orderby,
      "OrderMode": ordermode,
      "Limit": limit,
      "Offset": "0",
      "MultiOrder": multiorder,
      "q": q
    };

    print("GetDataPesertaLelang $t");
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "get_participants_bid", {
      "doc_ID": idLelang,
      "roleProfile": GlobalVariable.role,
      "loginAs": loginAs,
      "OrderBy": orderby,
      "OrderMode": ordermode,
      "Limit": limit,
      "Offset": "0",
      "MultiOrder": multiorder,
      "q": q
    });
  }

  Future getSharePDF(String loginas, String type) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url_1 + "get_share_bid",
        {"loginAs": loginas, "roleProfile": GlobalVariable.role, "type": type});
  }

  Future getContactTransporter(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_contact_transporter_profile",
        {"TransporterID": transporterID});
  }

  Future postPermintaanHarga(String idLelang, String idParticipant,
      String price, String loginas) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(_ZO_url + "post_nego", {
      "roleProfile": GlobalVariable.role,
      "doc_ID": idLelang,
      "participantID": idParticipant,
      "price": price,
      "loginAs": loginas,
    });
  }

  Future getListManajementPromo(String loginAS, String type, String isFilter,
      String isSearch, String limit,
      {String order,
      String ordermode,
      String search = "",
      String periodStart = "",
      String periodEnd = "",
      String minCapacity = "",
      String maxCapacity = "",
      String minHarga = "",
      String maxHarga = "",
      String kuotaMax = "",
      String kuotaMin = "",
      String capacityUnit = "",
      List headId,
      List carrierId,
      List pickupLocationId,
      List destinationLocationId,
      List payment}) async {
    var filterpar = {
      "period_start": periodStart,
      "period_end": periodEnd,
      "min_capacity": minCapacity,
      "max_capacity": maxCapacity,
      "min_harga": minHarga,
      "max_harga": maxHarga,
      "kuota_max": kuotaMax,
      "kuota_min": kuotaMin,
      "capacity_unit": capacityUnit,
      "head_id": headId,
      "carrier_id": carrierId,
      "pickup_location_id": pickupLocationId,
      "destination_location_id": destinationLocationId,
      "payment": payment
    };

    var tesPar = {
      "loginAs": loginAS,
      "roleProfile": "4",
      "type": type,
      "isFilter": isFilter,
      "isSearch": isSearch,
      "Order": order,
      "OrderMode": ordermode,
      "Limit": limit,
      "Offset": "0",
      "q": search,
      "filter": json.encode(filterpar)
    };

    print("GET PAR TES $tesPar");

    if (order != null) {
      return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _ZO_url_promo + "get_list_promo", {
        "loginAs": loginAS,
        "roleProfile": "4",
        "type": type,
        "isFilter": isFilter,
        "isSearch": isSearch,
        "Order": order,
        "OrderMode": ordermode,
        "Limit": limit,
        "Offset": "0",
        "q": search,
        "filter": json.encode(filterpar)
      });
    } else {
      return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _ZO_url_promo + "get_list_promo", {
        "loginAs": loginAS,
        "roleProfile": "4",
        "type": type,
        "isFilter": isFilter,
        "isSearch": isSearch,
        "Limit": limit,
        "Offset": "0",
        "q": search,
        "filter": json.encode(filterpar)
      });
    }
  }

  Future postPromoStatus(
      String idCardPromo, String status, String loginas) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url_promo + "post_update_promo_status", {
      "roleProfile": "4",
      "status": status,
      "ID": idCardPromo,
      "loginAs": loginas,
    });
  }

  Future<TransporterResponseModel> fetchTransporterContact(int id) async {
    var response = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      _url + 'backend/get_contact_transporter_profile',
      {"TransporterID": "$id"},
    );
    var responsePIC;
    try {
      responsePIC = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + 'backend/get_data_pic_transporter',
        {"TargetUserID": "$id"},
      );
    } catch (e) {
      debugPrint('debug-error-fetchTransporterContact: $e');
    }

    if ((response?.isNotEmpty ?? false) &&
        (response['Data']?.isNotEmpty ?? false) &&
        (responsePIC?.isNotEmpty ?? false) &&
        (responsePIC['Data']?.isNotEmpty ?? false)) {
      response['Data'].addAll(responsePIC['Data']);
    }

    print('debug-fetchTrasporterContract: $response');

    if ((response?.isNotEmpty ?? false) &&
        (response['Message']?.isNotEmpty ?? false)) {
      return TransporterResponseModel.fromJson(response);
    } else {
      return null;
    }
  }

//ZO
  Future getJenisMuatan() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_jenis_muatan", null);
  }

  Future getLokasiPeta(String phrase) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "api/get_autocomplete_street_json", {"phrase": phrase});
  }

  Future<MessageFromUrlModel> postReviewTransporter({
    int bidId,
    String loginAs,
    int score,
    String quality,
    String price,
    int transporterId,
  }) async {
    var body = {
      "doc_ID": bidId.toString(),
      "roleProfile": GlobalVariable.role,
      "loginAs": loginAs,
      "transporter_id": "$transporterId",
      "transporter_score": "$score",
      "service_quality": quality,
      "service_price": price,
    };
    print('post_review_transporter: $body');
    var response = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "post_review_transporter", body);

    return MessageFromUrlModel.fromJson(response['Message']);
  }

  Future<ZoBidWinnerResponseModel> fetchBidWinnerData(
    String idLelang,
    String loginAS,
    String roleProfile, {
    Map<String, dynamic> sortMap,
    String query,
  }) async {
    String id = idLelang;

    // Untuk coba list yang sudah ada pemenang lelang
    // id = "31";

    var orderBy = "";
    var orderMode = "";

    if (sortMap != null && sortMap.isNotEmpty) {
      orderBy = sortMap.keys.join(',');
      orderMode = sortMap.values.join(',');
    }

    var body = {
      "id": "$id",
      "roleProfile": "$roleProfile",
      "loginAs": "$loginAS",
      "q": query ?? "",
      "OrderBy": orderBy,
      "OrderMode": orderMode,
    };

    print("api_helper-body: ${jsonEncode(body)}");

    var getBidWinnerResponse = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _ZO_url + "get_bid_winner", {
      "id": "$id",
      "roleProfile": "$roleProfile",
      "loginAs": "$loginAS",
      "q": query ?? "",
      "OrderBy": orderBy,
      "OrderMode": orderMode,
    });
    var getParticipantsBidResponse =
        await fetchDataFromUrlPOSTMuatMuatAfterLogin(
            _ZO_url + "get_participants_bid", {"doc_ID": "$id"});

    print("api_helper-getBidWinnerResponse:$getBidWinnerResponse");
    // print("api_helper-getParticipantsBidResponse:$getParticipantsBidResponse");

    var getBidWinnerModel = getBidWinnerResponse == null
        ? null
        : ZoBidWinnerResponseModel.fromJson(getBidWinnerResponse);
    var getParticipantsBidModel = getParticipantsBidResponse == null
        ? null
        : ZoBidWinnerResponseModel.fromJson(getParticipantsBidResponse);

    print(
        "api_helper-getBidWinnerModel.message.code:${getBidWinnerModel.message.code}");
    print(
        "api_helper-getParticipantsBidResponse:${getParticipantsBidModel.message.code}");

    ZoBidWinnerData data;

    // if (getBidWinnerModel.message.code == 500) {
    //   if (Get.isDialogOpen) {
    //     Get.back();
    //   }
    //   GlobalAlertDialog.showDialogError(
    //     message: 'GlobalLabelErrorNullResponse'.tr,
    //     context: context,
    //     isDismissible: false,
    //   );
    // }
    if (getBidWinnerModel.message.code == 200) {
      data = getBidWinnerModel.data;
    }
    if (getParticipantsBidModel.message.code == 200) {
      List<ZoBidParticipant> winnerListWithCreated = [];

      getBidWinnerModel.data.bidParticipantList.forEach((winner) {
        var winnerParticipant = getParticipantsBidModel.data.bidParticipantList
            .firstWhere((participant) => participant.id == winner.id,
                orElse: () => winner);

        winnerListWithCreated
            .add(winner.copyWith(created: winnerParticipant.created));
      });

      data = ZoBidWinnerData(
        bidInformation: getBidWinnerModel.data.bidInformation ??
            getParticipantsBidModel.data.bidInformation,
        bidParticipantList: winnerListWithCreated,
      );
    }
    // return getBidWinnerModel;
    return getBidWinnerModel.copyWith(data: data);
    // print("Debug: $result");
    // print('fetchBidWinnerData-bidParticipants: $getParticipantsBidResponse');
    // print('fetchBidWinnerData-bidWinner: $getBidWinnerResponse');
    // var bitItemList = (getBidWinnerResponse['Data'] as Map)['BidItem'] as List;
    // var result = {
    //   'DataInformationBid': bitItemList.isEmpty ? null : bitItemList[0],
    //   'DataParticipantWinner':
    //       (getParticipantsBidResponse['Data'] as Map)['DataParticipantWinner'],
    // };
    // print('fetchBidWinnerData-result: $result');
    // return result;
    // // return result['Data'];
  }

  Future<List<ZoTransporterFreeModel>> fetchTransporterListFree({
    String query,
    int limit,
    int offset,
  }) async {
    final body = {
      'q': query?.trim() ?? '',
      'Limit': '$limit',
      'Offset': '$offset',
    };
    var fetchResult = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      _url + 'backend/get_transporter_list_free',
      body,
    );

    debugPrint('$fetchResult');

    if (fetchResult == null) {
      return Future.error('GlobalLabelErrorNullResponse'.tr);
    }
    var response = ZoTransporterFreeResponseModel.fromJson(fetchResult);
    var statusCode = response?.message?.code;
    var message = response?.message?.text;

    if ((response?.message?.code ?? -1) == 200) {
      return response.data;
    }
    return Future.error('Gagal memuat transporter. '
        '${statusCode ?? ''} ${message ?? ''}.');
  }

  Future<List<ZoRegionByCityModel>> fetchRegionByCity(String query) async {
    final body = {
      "q": query?.trim() ?? '',
    };
    var fetchResult = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      urlInternal + 'base/get_all_kota',
      body,
    );

    if (fetchResult == null) {
      return Future.error('GlobalLabelErrorNullResponse'.tr);
    }
    var response = ZoRegionByCityResponseModel.fromJson(fetchResult);
    var statusCode = response?.message?.code;
    var message = response?.message?.text;

    if ((response?.message?.code ?? -1) == 200) {
      return response.data;
    }
    return Future.error('Gagal memuat lokasi. '
        '${statusCode ?? ''} ${message ?? ''}.');
  }

  Future<List<CarrierTruckModel>>
      fetchCarrierTruckForPriceNotification() async {
    var fetchResult = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      urlInternal + 'base/get_carrier_truck',
      <String, dynamic>{},
    );

    if (fetchResult == null) {
      return Future.error('GlobalLabelErrorNullResponse'.tr);
    }
    var response = CarrierTruckResponseModel.fromJson(fetchResult);
    var statusCode = response?.message?.code;
    var message = response?.message?.text;

    if ((response?.message?.code ?? -1) == 200) {
      return response.listData;
    }
    return Future.error('Gagal memuat jenis carrier. '
        '${statusCode ?? ''} ${message ?? ''}.');
  }

  Future<List<HeadTruckModel>> fetchHeadTruckForPriceNotification() async {
    var fetchResult = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      urlInternal + 'base/get_head_truck',
      <String, dynamic>{},
    );

    if (fetchResult == null) {
      return Future.error('GlobalLabelErrorNullResponse'.tr);
    }
    var response = HeadTruckResponseModel.fromJson(fetchResult);
    var statusCode = response?.message?.code;
    var message = response?.message?.text;

    if ((response?.message?.code ?? -1) == 200) {
      return response.listData;
    }
    return Future.error('Gagal memuat jenis truk. '
        '${statusCode ?? ''} ${message ?? ''}.');
  }

  Future<String> fetchTransporterPromoCondition({
    @required String loginAS,
    @required String roleProfile,
    @required int idPromo,
    int searchId,
  }) async {
    final body = {
      "roleProfile": "$roleProfile",
      "loginAs": "$loginAS",
      "ID": "$idPromo",
      "searchID": "${searchId ?? ''}"
    };
    var fetchResult = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      _ZO_url_promo + "get_keterangan_promo",
      body,
    );

    var result = '';

    if (fetchResult != null && fetchResult['Message'] != null) {
      if ((fetchResult['Message']['Code'] ?? -1) == 200) {
        result = '${fetchResult['notes'] ?? ''}';
      } else {
        result = 'GlobalLabelErrorNullResponse'.tr +
            '\n${fetchResult['Message']['Text'] ?? ''}';
      }
    }

    // log('fetchResult: $fetchResult');
    // log(JsonEncoder.withIndent('  ').convert(fetchResult));

    return result;
  }

  Future<ZoDeleteNotifikasiHargaResponseModel> deleteNotification({
    @required int id,
    @required String loginAS,
    @required String roleProfile,
  }) async {
    var body = {
      "roleProfile": "$roleProfile",
      "loginAs": "$loginAS",
      "ID": "$id",
    };

    final fetchResult = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      _ZO_url_promo + "post_delete_promo_notification",
      body,
    );

    // log(JsonEncoder.withIndent('  ').convert(fetchResult));

    return ZoDeleteNotifikasiHargaResponseModel.fromJson(fetchResult);
  }

  Future<ZoCreateUpdateNotifikasiHargaResponseModel> createUpdateNotification({
    int id,
    @required String loginAS,
    @required String roleProfile,
    @required String pickup,
    @required String destination,
    @required String truck,
    @required String carrier,
    @required String type,
    @required String priceRange,
    @required String transporterName,
  }) async {
    var body = {
      "roleProfile": "$roleProfile",
      "loginAs": "$loginAS",
      "pickup_location": '$pickup',
      "destination_location": '$destination',
      "head_name": '$truck',
      "carrier_name": '$carrier',
      "notification_type": '$type',
      "harga_range": '$priceRange'.toLowerCase().replaceAll('.', ''),
      "transporter_name": '$transporterName',
    };

    if (id != null) {
      body.addEntries([MapEntry("id_promo", "$id")]);
    }

    final fetchResult = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      _ZO_url_promo +
          "post_${id == null ? 'create' : 'update'}_notification_promo",
      body,
    );

    // log(JsonEncoder.withIndent('  ').convert(fetchResult));

    return ZoCreateUpdateNotifikasiHargaResponseModel.fromJson(fetchResult);
  }

  Future<ZoNotifikasiHargaResponseModel> fetchPromoNotificationList({
    @required String loginAS,
    @required String roleProfile,
  }) async {
    var body = {
      "roleProfile": "$roleProfile",
      "loginAs": "$loginAS",
    };

    final fetchResult = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      _ZO_url_promo + "get_list_promo_notification",
      body,
    );

    // log(JsonEncoder.withIndent('  ').convert(fetchResult));

    return ZoNotifikasiHargaResponseModel.fromJson(fetchResult);
  }

  Future<ZoPromoTransporterResponseModel> fetchTransporterPromoList({
    @required String loginAS,
    @required String roleProfile,
    Map<String, dynamic> sortMap,
    String query,
    int limit,
    int offset,
    Map<String, dynamic> filter,
    bool isFilter = false,
  }) async {
    final isSearch = query?.trim()?.isNotEmpty ?? false;
    // bool isFilter = filter?.isNotEmpty ?? false;
    bool isSort = sortMap != null && sortMap.isNotEmpty;
    var orderBy = "";
    var orderMode = "";
    bool isMultiorder = false;

    var body = {
      "type": "data-promo-transporter",
      "roleProfile": "$roleProfile",
      "loginAs": "$loginAS",
      "isFilter": "$isFilter",
      "isSearch": "$isSearch",
      "Limit": limit == null ? null : "$limit",
      "Offset": offset == null ? null : "$offset",
      // "Filter": "",
    };
    if (isFilter) {
      body.addEntries([MapEntry('filter', jsonEncode(filter))]);
    }
    if (isSearch) {
      body.addEntries([MapEntry('q', '${query?.trim() ?? ''}')]);
    }
    if (isSort) {
      Map<String, dynamic> replace(
        String key,
        String replacement,
        Map<String, dynamic> map,
      ) {
        var list = map.entries.map((e) => MapEntry(e.key, e.value)).toList();
        int index;
        for (var entry in list.asMap().entries) {
          if (entry.value.key == key) {
            index = entry.key;
            break;
          }
        }

        if (index != null) {
          var result = <String, dynamic>{};

          list[index] = MapEntry(replacement, map[key]);

          result.addEntries(list);

          result.remove(key);

          return result;
        } else {
          return map;
        }
      }

      if (sortMap.containsKey('Created')) {
        if (!sortMap.containsKey('transporter_name')) {
          sortMap.addEntries([MapEntry('transporter_name', 'ASC')]);
        }
      }
      if (sortMap.containsKey('truck_qty')) {
        if (sortMap['truck_qty'] == 'ASC') {
          sortMap = replace('truck_qty', 'least_truck_qty', sortMap);
        } else {
          sortMap = replace('truck_qty', 'most_truck_qty', sortMap);
        }
        if (!sortMap.containsKey('transporter_name')) {
          sortMap.addEntries([MapEntry('transporter_name', 'ASC')]);
        }
      }
      if (sortMap.length > 1) {
        if (sortMap.containsKey('promo_price')) {
          if (sortMap['promo_price'] == 'ASC') {
            sortMap = replace('promo_price', 'price_least', sortMap);
          } else {
            sortMap = replace('promo_price', 'price_most', sortMap);
          }
        }
        if (sortMap.containsKey('max_capacity')) {
          sortMap = replace('max_capacity', 'most_capacity', sortMap);
        }
        if (!sortMap.containsKey('transporter_name')) {
          sortMap.addEntries([MapEntry('transporter_name', 'ASC')]);
        }
      }
      if (sortMap.length > 1) {
        isMultiorder = true;
      }
      orderBy = sortMap.keys.join(',');
      orderMode = sortMap.values.join(',');
      body.addEntries([
        MapEntry('Order', orderBy),
        MapEntry('OrderMode', orderMode),
        MapEntry('Multiorder', '$isMultiorder')
      ]);
    }

    var fetchResult = await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      _ZO_url_promo + "get_list_promo_transporter",
      body,
    );

    // log(JsonEncoder.withIndent('  ').convert(fetchResult));

    return ZoPromoTransporterResponseModel.fromJson(fetchResult);
  }

  Future<Map<String, dynamic>> fetchBanner() async {
    final body = {
      'type': 'shipper_app',
    };
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      _ZO_url_promo + "get_banner",
      body,
    );
  }
}

class GooglePlaceAutoCompleteResponse {
  var predictions;
  String status;

  GooglePlaceAutoCompleteResponse.fromJson(Map<String, dynamic> response) {
    status = response['status'];
    predictions = response['predictions'];
  }
}

class GooglePlaceDetailsResponse {
  var result;
  String status;

  GooglePlaceDetailsResponse.fromJson(Map<String, dynamic> response) {
    status = response['status'];
    result = response['result'];
    // formattedAddress = result['formatted_address'];
    // var geometryLocation = result['geometry']['location'];
    // latLng = LatLng(
    //     geometryLocation['lat'].toDouble(), geometryLocation['lng'].toDouble());
  }
}

class GoogleDirectionAPIResponse {
  final _routes;
  String status;
  List<dynamic> _legs;
  List<dynamic> _step;
  List<LatLng> listLatLng = [];

  GoogleDirectionAPIResponse.setListLatLng(this._routes) {
    status = _routes['status'];
    _legs = _routes['routes'].map((data) => data['legs']).toList();
    _step = _legs[_legs.length - 1].map((data) => data['steps']).toList();
    for (Map map in _step[_step.length - 1]) {
      var startLocation = map['start_location'];
      var endLocation = map['end_location'];
      listLatLng.add(LatLng(
          startLocation['lat'].toDouble(), startLocation['lng'].toDouble()));
      listLatLng.add(
          LatLng(endLocation['lat'].toDouble(), endLocation['lng'].toDouble()));
    }
  }
}

// class BodyAfterLogin {
//   final _routes;
//   String status;
//   List<dynamic> _legs;
//   List<dynamic> _step;
//   List<LatLng> listLatLng = [];

//   GoogleDirectionAPIResponse.setListLatLng(this._routes) {
//     status = _routes['status'];
//     _legs = _routes['routes'].map((data) => data['legs']).toList();
//     _step = _legs[_legs.length - 1].map((data) => data['steps']).toList();
//     for (Map map in _step[_step.length - 1]) {
//       var startLocation = map['start_location'];
//       var endLocation = map['end_location'];
//       listLatLng.add(LatLng(
//           startLocation['lat'].toDouble(), startLocation['lng'].toDouble()));
//       listLatLng.add(
//           LatLng(endLocation['lat'].toDouble(), endLocation['lng'].toDouble()));
//     }
//   }
// }
//

enum TypeHTTP {
  POST,
  GET,
}
