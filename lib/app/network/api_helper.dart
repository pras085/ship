import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/detail_manajemen_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_model.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
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
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:latlong/latlong.dart';

typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

/// Class ApiHelper untuk mengakses ke API
class ApiHelper {

  //url qc
  static String url = "https://qc.assetlogistik.com/";
  static String urlzo = "https://zo3.assetlogistik.com/";
  static String urlzo2 = "https://zo2.assetlogistik.com/";
  static String urlInternal = "https://internalqc.assetlogistik.com/";

  //url developer
  // static String url = "https://devintern.assetlogistik.com/";
  // static String urlzo = "https://devzo.assetlogistik.com/";
  // static String urlzo2 = "https://zo1.assetlogistik.com/";
  // static String urlInternal = "https://internal.assetlogistik.com/";

  //url demo
  // static String url = "https://demobf.assetlogistik.id/";
  // static String urlzo = "https://demotm.assetlogistik.id/";
  // static String urlzo2 = "https://demotmlelang.assetlogistik.id/";
  // static String urlInternal = "https://demo.assetlogistik.id/";
  static String urlIklan = "https://demoiklan.assetlogistik.id/";
  static String urlSeller = "https://apiiklan.assetlogistik.com/";
  static String urlBanner = "https://bannerads.assetlogistik.com/";

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

  static int requestTimeOutSecond = 30;

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

  static io.HttpClient getHttpClient() {
    io.HttpClient httpClient = io.HttpClient()
      ..connectionTimeout = Duration(seconds: 15);
    return httpClient;
  }

  getResponseFromURLMuatMuat(var response, bool isResponseBody,
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

  Future getOnBoard() async {
    var body = {
      "Locale": GlobalVariable.languageType,
      "Role": "2"
    };
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      urlInternal + "api/get_onboard",
      body,
    );
  }

  // Future getOnBoarden() async {
  //   var body = {
  //     "Locale": 'en_US',
  //   };
  //   return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //     urlIklan + "api/get_onboard",
  //     body,
  //   );
  // }

  // Future getOnBoardid() async {
  //   var body = {
  //     "Locale": 'id_ID',
  //   };
  //   return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //     urlIklan + "api/get_onboard",
  //     body,
  //   );
  // }

  Future getBusinessField() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_business_field", null);
  }

  Future readSingleNotif(String id) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/read_single_notif", {"NotifID" : id});
  }

  Future readAllNotif(String type) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/read_all_notif", {"Type" : type,"CategoryID" : "", "SubCategoryID": ""});
  }
  
  Future readAllNotifCategoryID(String kategori) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/read_all_notif", {"Type" : "","CategoryID" : kategori, "SubCategoryID": ""});
  }

  Future readAllNotifSub(String subkategori) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/read_all_notif", {"Type" : "","CategoryID" : "", "SubCategoryID": subkategori});
  }

  Future getListNotifKategori(String kategori) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_all_notif", {"FilterKategori" : kategori, "Type" : "3"});
  }

  Future getCount(String kategori, String subkategori) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_all_notif", {"FilterKategori" : kategori, "FilterSubKategori" : subkategori, "Type" : "3"});
  }

  Future getCountUnread(String kategori, String subkategori) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_all_notif", {"FilterKategori" : kategori, "FilterSubKategori" : subkategori, "Type" : "3", "FilterByRead" : "1"});
  }

  Future getListNotifAll() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_all_notif", {"Type" : "3"});
  }

  Future getListNotifAllUnread() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_all_notif", {"Type" : "3", "FilterByRead" : "1"});
  }

  Future getListNotifAllUnreadKategori(String id) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_all_notif", {"Type" : "3", "FilterByRead" : "1", "FilterKategori" : id});
  }

  Future getBusinessEntity() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_business_entity", null);
  }

  Future getAllNotif() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_all_notif_kategori", {"Type" : "3"});
  }

  Future getPostalCode(String districtId) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_postal_code", {"DistrictID": districtId});
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

  Future _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(String url,
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

  Future _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipartFiles(
      String url, dynamic body,
      {bool afterLogin = false,
      bool isMultiPart = false,
      bool isEnableCheckMessage = true,
      List<String> fileFields = const [],
      List<io.File> files = const [],
      List<MediaType> fileContents,
      String vendor}) async {
    bool isResponseBody = true;
    _checkDebug(url);
    _resetError();
    if (isShowDialogLoading) _showDialogLoading();
    await _checkConnection();
    var response;
    var errorMessage;
    if (!isError) {
      try {
        body = afterLogin
            ? _setBodyFetchURLAfterLogin(body, vendor: vendor)
            : _setBodyFetchURL(body, vendor: vendor);
        if (kDebugMode) {
          print("=========================");
          print("URL REQUEST :: $url");
          print("=========================");
          print("REQUEST BODY :: $body");
          print("=========================");
        }
        if (body == null) {
          response = await http
              .post(url)
              .timeout(Duration(seconds: requestTimeOutSecond));
        } else {
          if (isMultiPart && files.isNotEmpty) {
            isResponseBody = false;
            var request = http.MultipartRequest("POST", Uri.parse(url));
            for (var i = 0; i < fileFields.length; i++) {
              request.files.add(http.MultipartFile.fromBytes(
                  fileFields[i], files[i].readAsBytesSync(),
                  contentType: fileContents[i],
                  filename: files[i].path.split("/").last));
            }

            for (var data in body.entries) {
              request.fields[data.key] = data.value;
            }

            var response2 = await request.send();
            response = await response2.stream.bytesToString();
            print("done");
          } else {
            response = await http
                .post(url, body: body)
                .timeout(Duration(seconds: requestTimeOutSecond));
            if (kDebugMode) {
              print("=========================");
              print("RESPONSE BODY :: ${response.body}");
              print("=========================");
            }
          }
        }
      } on TimeoutException {
        errorMessage = "GlobalLabelErrorNoConnection".tr;
      } catch (err) {
        errorMessage = err.toString();
        print("error _fetchDataFromUrlPOSTMuatMuat: " + err.toString());
      }
      if (response != null) {
        _closeDialogLoading();
        if (GlobalVariable.isDebugMode) {
          if (response.statusCode != 200) {
            await _showDialogDebug(url, body, response);
          }
        }
        return getResponseFromURLMuatMuat(response, isResponseBody,
            isEnableCheckMessage: isEnableCheckMessage);
      } else {
        _closeDialogLoading();
        _setError(true, isErrorResponse, errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
        if (GlobalVariable.isDebugMode) {
          return await _showDialogDebug(url, body, response);
        } else {
          if (isShowDialogError) {
            return _showDialogError(
                errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
          } else {
            return null;
          }
        }
      }
    }
  }

  Future sendMultipart(String url, dynamic body,
      {
      bool isEnableCheckMessage = true,
      List<String> fileFields = const [],
      List<io.File> files = const [],
      List<MediaType> fileContents,
      String vendor,
      OnUploadProgressCallback onUploadProgressCallback,
      }) async {
    bool isResponseBody = true;
    _checkDebug(url);
    _resetError();
    if (isShowDialogLoading) _showDialogLoading();
    await _checkConnection();
    var response;
    var errorMessage;
    if (!isError) {
      try {
        body = _setBodyFetchURLAfterLogin(body, vendor: vendor);
        if (kDebugMode) {
          print("=========================");
          print("URL REQUEST :: $url");
          print("=========================");
          print("REQUEST BODY :: $body");
          print("=========================");
        }
        if (body == null) {
          response = await http.post(url).timeout(Duration(seconds: requestTimeOutSecond));
        } else {
          isResponseBody = false;

          var httpClient = getHttpClient();

          var req = await httpClient.postUrl(Uri.parse(url));

          var requestMultipart = http.MultipartRequest("POST", Uri.parse(url));
          for (var i = 0; i < fileFields.length; i++) {
            requestMultipart.files.add(http.MultipartFile.fromBytes(fileFields[i], files[i].readAsBytesSync(), contentType: fileContents[i], filename: files[i].path.split("/").last));
          }
          
          for (var data in body.entries) {
            requestMultipart.fields[data.key] = data.value;
          }

          final stream = requestMultipart.finalize();
          final totalByteLength = requestMultipart.contentLength;

          req.contentLength = totalByteLength;

          int byteCount = 0;

          req.headers.set(HttpHeaders.contentTypeHeader, requestMultipart.headers[HttpHeaders.contentTypeHeader]);

          Stream<List<int>> streamUpload = stream.transform(
            StreamTransformer.fromHandlers(
              handleData: (data, sink) {
                sink.add(data);

                byteCount += data.length;

                if (onUploadProgressCallback != null) {
                  onUploadProgressCallback(byteCount, totalByteLength);
                }
              },
              handleError: (error, stack, sink) {
                throw error;
              },
              handleDone: (sink) {
                sink.close();
              }
            ),
          );

          await req.addStream(streamUpload);

          final httpResponse = await req.close();

          if (httpResponse.statusCode != 200) {
            throw Exception("Error uploading file, Status code: ${httpResponse.statusCode}");
          }
          final resp = await readResponseAsString(httpResponse);
          if (kDebugMode) {
            print("=========================");
            print("RESPONSE BODY :: $resp");
            print("=========================");
          }
          return resp;    
        }
      } on TimeoutException {
        errorMessage = "GlobalLabelErrorNoConnection".tr;
      } catch (err) {
        errorMessage = err.toString();
        print("error _fetchDataFromUrlPOSTMuatMuat: " + err.toString());
      }
      if (response != null) {
        if (GlobalVariable.isDebugMode) {
          if (response.statusCode != 200) {
            await _showDialogDebug(url, body, response);
          }
        }
        return getResponseFromURLMuatMuat(response, isResponseBody, isEnableCheckMessage: isEnableCheckMessage);
      } else {
        _closeDialogLoading();
        _setError(true, isErrorResponse, errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
        if (GlobalVariable.isDebugMode) {
          return await _showDialogDebug(url, body, response);
        } else {
          if (isShowDialogError) {
            return _showDialogError( errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
          } else {
            return null;
          }
        }
      }
    }
  }

  Future fetchDataFromUrlPOSTMuatMuat(String url, dynamic body,
      {bool afterLogin = false,
      bool isMultiPart = false,
      bool isEnableCheckMessage = true,
      String fileField = "",
      io.File file = null,
      MediaType fileContent,
      String vendor}) async {
    bool isResponseBody = true;
    _checkDebug(url);
    _resetError();
    if (isShowDialogLoading) _showDialogLoading();
    await _checkConnection();
    var response;
    var errorMessage;
    if (!isError) {
      try {
        body = afterLogin
            ? _setBodyFetchURLAfterLogin(body, vendor: vendor)
            : _setBodyFetchURL(body, vendor: vendor);
        if (kDebugMode) {
          print("=========================");
          print("URL REQUEST :: $url");
          print("=========================");
          print("REQUEST BODY :: $body");
          print("=========================");
        }
        if (body == null) {
          response = await http
              .post(url)
              .timeout(Duration(seconds: requestTimeOutSecond));
        } else {
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
          } else {
            response = await http
                .post(url, body: body)
                .timeout(Duration(seconds: requestTimeOutSecond));
            if (kDebugMode) {
              print("=========================");
              print("RESPONSE BODY :: ${response.body}");
              print("=========================");
            }
          }
        }
      } on TimeoutException {
        errorMessage = "GlobalLabelErrorNoConnection".tr;
      } catch (err) {
        errorMessage = err.toString();
        print("error _fetchDataFromUrlPOSTMuatMuat: " + err.toString());
      }
      if (response != null) {
        _closeDialogLoading();
        if (GlobalVariable.isSuperDebugMode) {
          await _showDialogDebug(url, body, response);
        } else if (GlobalVariable.isDebugMode) {
          if (response.statusCode != 200) {
            await _showDialogDebug(url, body, response);
          }
        }
        return getResponseFromURLMuatMuat(response, isResponseBody,
            isEnableCheckMessage: isEnableCheckMessage);
      } else {
        _closeDialogLoading();
        _setError(true, isErrorResponse,
            errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
        if (GlobalVariable.isDebugMode || GlobalVariable.isSuperDebugMode) {
          return await _showDialogDebug(url, body, response);
        } else {
          if (isShowDialogError) {
            return _showDialogError(
                errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
          } else {
            return null;
          }
        }
      }
    }
  }

  static Future<String> readResponseAsString(HttpClientResponse res) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    res.transform(utf8.decoder).listen((event) {
      contents.write(event);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  // Future fetchDataFromUrlPOSTMuatMuat(String url, dynamic body,
  //     {bool afterLogin = false,
  //     bool isMultiPart = false,
  //     bool isEnableCheckMessage = true,
  //     String fileField = "",
  //     io.File file = null,
  //     MediaType fileContent,
  //     String vendor}) async {
  //   print('Debug: ' + 'before _fetchDataFromUrlPOSTMuatMuat');
  //   bool isResponseBody = true;
  //   _checkDebug(url);
  //   print('Debug: ' + 'after _checkDebug');
  //   _resetError();
  //   print('Debug: ' + 'after _resetError');
  //   if (isShowDialogLoading) _showDialogLoading();
  //   await _checkConnection();
  //   print('Debug: ' + 'after _checkConnection');
  //   var response;
  //   var errorMessage;
  //   if (!isError) {
  //     try {
  //       print('Debug: ' + 'before afterLogin ' + body.toString());
  //       body = afterLogin
  //           ? _setBodyFetchURLAfterLogin(body, vendor: vendor)
  //           : _setBodyFetchURL(body, vendor: vendor);
  //       print('Debug: ' + 'after afterLogin ' + body.toString());
  //       if (body == null) {
  //         print('Debug: ' + 'before post 1');
  //         response = await http
  //             .post(url)
  //             .timeout(Duration(seconds: requestTimeOutSecond));
  //         print('Debug: ' + 'after post ' + response.toString());
  //       } else {
  //         print('Debug: ' + 'before post 2');
  //         if (isMultiPart && file != null) {
  //           isResponseBody = false;
  //           var request = http.MultipartRequest("POST", Uri.parse(url));
  //           // var stream =
  //           //     http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //           // var length = await imageFile.length();
  //           // var request = http.MultipartRequest("POST", Uri.parse(url))..fields;
  //           // var multipart = http.MultipartFile('Avatar', stream, length,
  //           //     filename: basename(imageFile.path));
  //           request.files.add(http.MultipartFile.fromBytes(
  //               fileField, file.readAsBytesSync(),
  //               contentType: fileContent, filename: file.path.split("/").last));

  //           // request.files.add(
  //           //     await http.MultipartFile.fromPath('Avatar', imageFile.path));
  //           //var listEntry = body.entries.toList();
  //           for (var data in body.entries) {
  //             request.fields[data.key] = data.value;
  //           }

  //           var response2 = await request.send();
  //           response = await response2.stream.bytesToString();
  //           print("done");
  //         } else
  //           response = await http
  //               .post(url, body: body)
  //               .timeout(Duration(seconds: requestTimeOutSecond));
  //       }
  //       print('Debug: ' + 'after post 2 ' + response.toString());
  //     } on TimeoutException {
  //       errorMessage = "GlobalLabelErrorNoConnection".tr;
  //     } catch (err) {
  //       errorMessage = err.toString();
  //       print("error _fetchDataFromUrlPOSTMuatMuat: " + err.toString());
  //     }
  //     if (response != null)
  //       return getResponseFromURLMuatMuat(response, isResponseBody,
  //           isEnableCheckMessage: isEnableCheckMessage);
  //     else {
  //       _setError(true, isErrorResponse,
  //           errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
  //       if (isShowDialogError)
  //         return _showDialogError(
  //             errorMessage ?? 'GlobalLabelErrorNoConnection'.tr);
  //       else
  //         return null;
  //     }
  //   }
  // }

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
            .timeout(Duration(seconds: requestTimeOutSecond));
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
        barrierDismissible: kDebugMode ? true : false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => kDebugMode ? true : false,
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

  var _k = new GlobalKey<State>();
  Future _showDialogDebug(url, body, response) async {
    return showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => true,
              child: Dialog(
                  key: _k,
                  insetPadding: EdgeInsets.all(0),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(context) * 16,
                          right: GlobalVariable.ratioWidth(context) * 16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BackButton(
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            CustomText("Url : "),
                            SelectableText(
                              url.toString() ?? "null",
                              style: TextStyle(
                                  fontSize:
                                      GlobalVariable.ratioWidth(context) * 14,
                                  color: Colors.black),
                            ),
                            Container(
                              height: GlobalVariable.ratioWidth(context) * 16,
                            ),
                            CustomText("body : "),
                            SelectableText(
                              body.toString() ?? "null",
                              style: TextStyle(
                                  fontSize:
                                      GlobalVariable.ratioWidth(context) * 14,
                                  color: Colors.black),
                            ),
                            Container(
                              height: GlobalVariable.ratioWidth(context) * 16,
                            ),
                            CustomText(
                                "Response error Android dr try catch : "),
                            SelectableText(
                              errorMessage == null
                                  ? "null"
                                  : errorMessage.isEmpty
                                      ? "Tidak ada error Android"
                                      : errorMessage,
                              style: TextStyle(
                                  fontSize:
                                      GlobalVariable.ratioWidth(context) * 14,
                                  color: Colors.black),
                            ),
                            Container(
                              height: GlobalVariable.ratioWidth(context) * 16,
                            ),
                            CustomText("Status dari Api: "),
                            SelectableText(
                              response == null
                                  ? "null"
                                  : response.statusCode.toString(),
                              style: TextStyle(
                                  fontSize:
                                      GlobalVariable.ratioWidth(context) * 14,
                                  color: Colors.black),
                            ),
                            Container(
                              height: GlobalVariable.ratioWidth(context) * 16,
                            ),
                            CustomText("Response dari Api : "),
                            SelectableText(
                              response == null
                                  ? "null"
                                  : response.body.toString(),
                              style: TextStyle(
                                  fontSize:
                                      GlobalVariable.ratioWidth(context) * 14,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )));
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
            LoginFunction().signOut2();
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
    return await fetchDataFromUrlPOSTMuatMuat(url + "api/users_login", {
      'Email': user.email,
      'Password': user.password,
      'IsGoogle': isGoogle ? "1" : "0",
      "Lang": GlobalVariable.languageType
    });
  }

  Future fetchRegister(UserModel user, bool isGoogle) async {
    await SharedPreferencesHelper.getLanguage();
    return await fetchDataFromUrlPOSTMuatMuat(
        url + GlobalVariable.languageCode + "/api/users_register", {
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
        url + "api/doCreateGoogleAccount", {
      'ID': user.docID,
      'Name': user.name,
      'Email': user.email,
      'Phone': user.phone,
      'ReferralCode': user.referralCode,
    });
  }

  Future fetchVerifyEmail(String email) async {
    return await fetchDataFromUrlPOSTMuatMuat(
        url + "verify/check_activation_email", {'Email': email, 'App': '1'});
    // var response =
    //     await http.post(_url + "verify/check_activation_email", body: {
    //   'Email': email,
    // });
    // return response;
  }

  Future fetchResendVerifyEmail(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuat(url + "api/request_email",
        {'DocID': docID, 'Lang': GlobalVariable.languageType});
    // var response = await http.post(_url + "api/request_email", body: {
    //   'DocID': docID,
    // });
    // return response;
  }

  Future fetchResendVerifyPhone(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuat(url + "api/request_phone", {
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
        url + "verify/check_activation_phone", {
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
    return await fetchDataFromUrlPOSTMuatMuat(url + "verify/input_otp_email",
        {'VerifID': verifID, 'Pin': otp, 'App': '1'});
  }

  Future fetchVerifyOTPPhone(String verifID, String otp) async {
    return await fetchDataFromUrlPOSTMuatMuat(url + "verify/input_otp_phone",
        {'VerifID': verifID, 'Pin': otp, 'App': '1'});
  }

  Future fetchResetPassword(String email) async {
    return await fetchDataFromUrlPOSTMuatMuat(url + "api/forgot_password", {
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
    return await fetchDataFromUrlPOSTMuatMuat(url + "api/change_number", {
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
        urlInternal + "api/privacy_policy",
        {'App': "1", 'Type': type, 'Lang': GlobalVariable.languageType});
  }

  Future fetchTermCondition({String type = "general"}) async {
    return await fetchDataFromUrlPOSTMuatMuat(
        urlInternal + "api/terms_condition",
        {'App': "1", 'Type': type, 'Lang': GlobalVariable.languageType});
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
    return await fetchDataFromUrlPOSTMuatMuat(url + "lang/backend", body);
  }

  Future fetchHeadTruck() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_head_truck", null);
  }

  Future getTransporterContact(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_contact_transporter_by_shipper",
        {"TransporterID": transporterID});
  }

  Future getTransporterProfile(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_profile_transporter_by_shipper",
        {"TransporterID": transporterID});
  }

  Future getTransporterDataDetail(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_preview_data_perusahaan_profile_company",
        {"TargetUserID": transporterID, "Role" : "4"});
  }

  Future getTransporterJoinedDate(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_preview_bergabung_sejak",
        {"TargetUserID": transporterID, "Role" : "4"});
  }

  Future getAllTransporterRating(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_all_testimonial_shipper_to_transporter_tab_transporter",
        {"TargetUserID": transporterID});
  }

  Future getAllTransporterUnit(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_transporter_truck_list",
        {"TargetUserID": transporterID});
  }


  Future getTransporterMedia(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_media_transporter_by_shipper",
        {"TransporterID": transporterID});
  }

  Future getTransporterTestimony(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_testimony_transporter_by_shipper",
        {"TransporterID": transporterID});
  }

  Future getTransporterRating(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_rate_transporter", {"TransporterID": transporterID});
  }

  Future fetchAllCarrierTruck() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_carrier_truck", null);
  }

  Future fetchAllCity() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "base/get_destination", null);
  }

  Future requestAsPartner(String shipperID, String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/doAddMitraWithPermission", {
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
      body["MitraID"] = docID;
    } else {
      body["TransporterID"] = transporterID;
      body["ShipperID"] = shipperID;
    }
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/void_mitra", body);
  }

  Future fetchFilteredMitra(String shipperID, String name,
      Map<dynamic, dynamic> order, int limit, int offset) async {
    var query = {
      "ShipperID": shipperID,
      "q": name,
      "Limit": limit.toString(),
      "Offset": offset.toString()
    };
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
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_data_mitra_by_shipper", query);
  }

  Future fetchNonFilteredMitra(String shipperID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_data_mitra_by_shipper", {"ShipperID": shipperID});
  }

  Future fetchGetDataMitraByShipper(String shipperID, int limit, int offset,
      {Map<dynamic, dynamic> order,
      String name = "",
      Map<String, dynamic> filter}) async {
    var body = {
      "ShipperID": shipperID,
      "Limit": limit.toString(),
      "Offset": offset.toString()
    };
    if (name != "") {
      body["q"] = name;
    }
    if (order != null) {
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
        body["Order"] = stringOrder;
        body["OrderMode"] = stringOrderMode;
      }
    }
    if (filter != null) {
      body["filter"] = jsonEncode(filter);
    }

    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_data_mitra_by_shipper", body);
  }

  Future fetchGetCountReqMitra(String shipperID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_count_data_approve_request_mitra",
        {"ShipperID": shipperID});
  }

  Future fetchGetDataApproveMitraByShipper(
      String shipperID, int limit, int offset,
      {Map<dynamic, dynamic> order,
      String name = "",
      Map<String, dynamic> filter}) async {
    var body = {
      "ShipperID": shipperID,
      "Limit": limit.toString(),
      "Offset": offset.toString()
    };
    if (name != "") {
      body["q"] = name;
    }
    if (order != null) {
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
        body["Order"] = stringOrder;
        body["OrderMode"] = stringOrderMode;
      }
    }
    if (filter != null) {
      body["filter"] = jsonEncode(filter);
    }

    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_data_transporter_to_shipper", body);
  }

  Future fetchCheckStatusTransporterAsMitra(
      String shipperID, String transporterID) async {
    var body = {"ShipperID": shipperID, "TransporterID": transporterID};
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/check_transporter_mitra_by_shipper", body);
  }

  Future fetchSetGroupMitraStatus(String groupID, String status) async {
    var body = {"GroupID": groupID, "Status": status};
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/update_status_group_mitra", body);
  }

  Future fetchDeleteGroupMitra(String groupID) async {
    var body = {"GroupID": groupID, "Void": "1"};
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/void_group_mitra_by_shipper", body);
  }

  Future fetchSetDataApproveRejectMitraByShipper(String docID, String status,
      {String transporterID = "", String shipperID = ""}) async {
    var body = {"Status": status};
    if (docID.isNotEmpty) {
      body["DocID"] = docID;
    } else {
      body["TransporterID"] = transporterID;
      body["ShipperID"] = shipperID;
    }
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/approve_reject_mitra_by_shipper", body);
  }

  Future fetchSetDataRequestCancelMitraByShipper(String docID,
      {String transporterID = "", String shipperID = ""}) async {
    var body = Map<String, dynamic>();
    if (docID.isNotEmpty) {
      body["DocID"] = docID;
    } else {
      body["TransporterID"] = transporterID;
      body["ShipperID"] = shipperID;
    }
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/cancel_request_mitra_by_shipper", body);
  }

  Future fetchGetDataRequestMitraByShipper(
      String shipperID, int limit, int offset,
      {Map<dynamic, dynamic> order,
      String name = "",
      Map<String, dynamic> filter}) async {
    var body = {
      "ShipperID": shipperID,
      "Limit": limit.toString(),
      "Offset": offset.toString()
    };
    if (name != "") {
      body["q"] = name;
    }
    if (order != null) {
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
        body["Order"] = stringOrder;
        body["OrderMode"] = stringOrderMode;
      }
    }
    if (filter != null) {
      body["filter"] = jsonEncode(filter);
    }
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_data_shipper_to_transporter", body);
  }

  Future fetchFilteredGroupMitra(
      String shipperID,
      String name,
      Map<dynamic, dynamic> order,
      Map<dynamic, dynamic> filter,
      int limit,
      int offset) async {
    var query = {
      "ShipperID": shipperID,
      "q": name,
      "Limit": limit.toString(),
      "Offset": offset.toString()
    };
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
        if (order.keys.first == element) {
          stringOrderMode += element;
        } else {
          stringOrderMode += ",$element";
        }
      });
      query["Order"] = stringOrder;
      query["OrderMode"] = stringOrderMode;
    }
    if (filter != null) query["filter"] = jsonEncode(filter);
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_list_group_mitra_by_shipper", query);
  }

  Future fetchMitraCV(String url) async {
    var response =
        await http.get(url).timeout(Duration(seconds: requestTimeOutSecond));
    return getResponseFromURLMuatMuat(response, true);
  }

  Future fetchListPartnerInGroup(String groupID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_detail_group_mitra_by_shipper",
        {"GroupID": groupID});
  }

  Future createGroupMitra(String name, String description, String shipperID,
      String listMitra, io.File imageFile) async {
    if (imageFile == null) {
      return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
          url + "backend/doAddGroupMitra", {
        "Name": name,
        "Description": description,
        "ShipperID": shipperID,
        "MitraID": listMitra
      });
    } else {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(
          url + "backend/doAddGroupMitra",
          {
            "Name": name,
            "Description": description,
            "ShipperID": shipperID,
            "MitraID": listMitra
          },
          imageFile,
          'Avatar',
          MediaType('images', 'jpeg'));
    }
  }

  Future editGroupMitra(String groupID, String name, String description,
      String listMitra, io.File imageFile) async {
    if (imageFile == null) {
      return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
          url + "backend/doUpdateGroupMitra", {
        "ID": groupID,
        "Name": name,
        "Description": description,
        "MitraID": listMitra
      });
    } else {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(
          url + "backend/doUpdateGroupMitra",
          {
            "ID": groupID,
            "Name": name,
            "Description": description,
            "MitraID": listMitra
          },
          imageFile,
          'Avatar',
          MediaType('images', 'jpeg'));
    }
  }

  Future addMitraIntoGroup(String groupID, String mitraID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/doAddGroupMitraTransaction",
        {"GroupID": groupID, "MitraID": mitraID});
  }

  Future removeMitraFromGroup(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/void_member_group_mitra_by_shipper",
        {"MitraID": docID, "Void": "1"});
  }

  Future fetchDetailTransporter(String transporterID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_transporter_detail",
        {"TransporterID": transporterID});
  }

  Future fetchFilteredTransporter(
      String search,
      Map<dynamic, dynamic> filter,
      Map<dynamic, dynamic> order,
      int limit,
      int offset,
      String shipperID) async {
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

    query["ShipperID"] = shipperID;
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_transporter_list", query);
  }

  Future getDetailPermintaanMuat(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_data_detail_permintaan_muat",
        {"ShipperID": "120", "PermintaanMuat": "1"});
  }

  Future fetchCheckDuplicateAccount(UserModel userModel) async {
    return await fetchDataFromUrlPOSTMuatMuat(url + "api/check_email_phone", {
      'Email': userModel.email,
      'Phone': userModel.phone,
      'Lang': GlobalVariable.languageType
    });
  }

  Future getCheckValidRefferal(UserModel userModel) async {
    return await fetchDataFromUrlPOSTMuatMuat(url + "api/check_ref_code", {
      'RefCode': userModel.referralCode,
    });
  }

  Future fetchListLanguage() async {
    // return await _fetchDataFromUrlPOSTMuatMuat(_url + "lang/available", null);
    return await fetchDataFromUrlPOSTMuatMuat(url + "lang/available", null);
  }

  Future fetchCheckDevice() async {
    return await fetchDataFromUrlPOSTMuatMuat(url + "api/check_device", {
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
        urlInternal + "base/get_business_entity", null);
  }

  Future fetchBusinessField() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "base/get_business_field", null);
  }

  Future fetchCategoryCapacity() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "base/get_category_capacity", null);
  }

  Future fetchProvince() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "base/get_province", null);
  }

  Future fetchProfileShipper() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_profile_shipper",
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
        url + "api/doRegisterShipperBuyer", {
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
        url + "base/get_kota", {'provinceID': provinceId});
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
        url + "backend/get_all_filter_master_truk_siap_muat", query);
  }

  Future fetchAreaPickupTransporter(String transporterID) async {
    var query = {"Type": "2", "TransporterID": transporterID};
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_all_filter_master_truk_siap_muat", query);
  }

  Future fetchSearchLocationTruckReady(String sourceCity, String destCity,
      String headID, String carrierID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_list_location_truck_ready", {
      'q[SourceCity]': sourceCity,
      'q[DestinationCity]': destCity,
      'q[HeadID]': headID,
      'q[CarrierID]': carrierID
    });
  }

  Future fetchCheckUser() async {
    //Mode 1 = All; Mode 2 = Shipper; Mode 4 = Transporter; Mode 8 = Seller; Mode 16 = Jobseeker
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "api/check_user", {'Mode': "2"});
  }

  Future fetchCheckRoleRegister() async {
    UserModel userModel = await SharedPreferencesHelper.getUserModel();
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "base/check_role_register", {"UsersID": userModel.docID});
  }

  Future fetchAddLocationManagement(
      {@required String name,
      @required String address,
      @required String latitude,
      @required String longitude,
      @required String district}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/doAddSaveLocation", {
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
        url + "backend/doAddHistoryLocation", {
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
        url + "backend/get_history_location", {
      'Role': GlobalVariable.role,
      'UsersID': GlobalVariable.userModelGlobal.docID,
    });
  }

  Future fetchUpdateProfile(
      io.File imageFile, ProfileShipperModel profile) async {
    var body = {
      'Username': profile.username,
      'ID': profile.shipperID,
      'Type': profile.type == "Individu" ? "0" : "1",
      'Name': profile.shopName,
      'Address': profile.address,
      'PostalCode': profile.postalCode,
      'ProvinceID': profile.provinceCode,
      'CityID': profile.cityID,
      'PhoneWA': profile.numberWhatssapp,
      'CapacityID': profile.categoryCapacityID,
      'Capacity': profile.capacity,
    };
    if (profile.type != "Individu") {
      body['BusinessEntityID'] = profile.businessEntityID;
      body['BusinessFieldID'] = profile.businessFieldID;
      body['NamePic1'] = profile.namePIC1;
      body['ContactPic1'] = profile.contactPIC1;
      body['NamePic2'] = profile.namePIC2;
      body['ContactPic2'] = profile.contactPIC2;
      body['NamePic3'] = profile.namePIC3;
      body['ContactPic3'] = profile.contactPIC3;
      body['is_wa_1'] = "false";
      body['is_wa_2'] = "false";
      body['is_wa_3'] = "false";
      body['is_wa_3'] = "false";
      body['is_wa_3'] = "false";
    }
    if (profile.latitude != "" && profile.longitude != "") {
      body['lat'] = profile.latitude;
      body['lng'] = profile.longitude;
    }
    return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(
        url + "backend/doUpdateProfileShipper",
        body,
        imageFile,
        'Avatar',
        MediaType('images', 'jpeg'));
  }

  Future fetchSetting() async {
    return await fetchDataFromUrlPOSTMuatMuat(urlInternal + "api/get_setting", null);
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
        urlInternal + "base/get_truck", {"HeadID": headID, "CarrierID": carrierID});
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
        url + "backend/get_data_truk_siap_muat", query);
  }

  Future getHistoryTransactLocation(String userID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_history_location",
        {"UsersID": userID, "Role": GlobalVariable.role});
  }

  Future fetchDetailManajemenLokasi(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/get_detail_save_location", {"DocID": docID});
  }

  Future fetchAddManajemenLokasi(
      DetailManajemenLokasiModel detailManajemenLokasiModel) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/doAddSaveLocation",
        {"param": jsonEncode(detailManajemenLokasiModel.toJson())});
  }

  Future fetchUpdateManajemenLokasi(
      DetailManajemenLokasiModel detailManajemenLokasiModel) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/doUpdateSaveLocation",
        {"param": jsonEncode(detailManajemenLokasiModel.toJson())});
  }

  Future fetchDeleteManajemenLokasi(String docID) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "backend/doDeleteSaveLocation", {"DocID": docID});
  }

  Future fetchInfoFromAddress({String address, String placeID}) async {
    var body = (placeID != null) ? {"place_id": placeID} : {"address": address};
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "api/get_lat_long", body,
        isEnableCheckMessage: false);
  }

  Future fetchMaxTruck({String shipperID}) async {
    var body = (shipperID != null) ? {"ShipperID": shipperID} : null;
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "base/get_max_truck", body,
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
        url + "backend/get_data_truk_siap_muat", body,
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
        url + "backend/get_count_truk_siap_muat", body,
        isEnableCheckMessage: false);
  }

  Future fetchSearchCity(String search) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "base/get_all_kota", {"q": search});
  }

  Future fetchAllDistrict(String search) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "base/get_all_district", {"q": search});
  }

  Future fetchDistrict(String search) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_independent_district", {"search": search});
  }

  Future fetchInformationLocationByToken(String placeId) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + "base/get_information_location_by_token",
        {"place_id": placeId});
  }

  Future fetchInformationLatlong(String lat, String long) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(urlInternal + "base/get_information_location_by_lat_long", {
      "Lat": lat,
      "Long": long
    });
  }

  Future fetchLastTransaction(String shipperID, String type) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_last_transaction_location", {
      "TransporterID": shipperID,
      "Type": type
    }); // belum bisa API untuk shipper ID
  }

  Future fetchGetDataUserTypeInformation() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        url + "backend/get_data_user_type_information", {}); // belum ada data
  }

  Future isEmailVerified(String email) async {
    return await fetchDataFromUrlPOSTMuatMuat(
        urlInternal + "api/is_email_verified", {'email': email});
  }

  Future getShipperRegistration({TipeModul tipeModul = TipeModul.BF}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal +
            (tipeModul == TipeModul.BF
                ? "backend/get_shipper_registration"
                : "backend/get_tm_shipper_registration"),
        null);
  }

  Future registerShipper({TipeModul tipeModul = TipeModul.BF}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal +
            (tipeModul == TipeModul.BF
                ? "backend/register_shipper_bf"
                : "backend/register_shipper_tm"),
        null);
  }

  Future setShipperCapacityQty(String qty,
      {TipeModul tipeModul = TipeModul.BF}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal +
            (tipeModul == TipeModul.BF
                ? "backend/set_shipper_capacity_qty"
                : "backend/set_tm_shipper_capacity_qty"),
        {'Qty': qty, 'Forced': "0"});
  }

  Future setShipperRegistrationInfo(
      {TipeModul tipeModul = TipeModul.BF,
      Map<String, dynamic> body,
      List<String> fileFields,
      List<io.File> files,
      List<MediaType> fileContents}) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipartFiles(
        urlInternal +
            (tipeModul == TipeModul.BF
                ? "backend/set_shipper_registration_info"
                : "backend/set_tm_shipper_registration_info"),
        body,
        fileFields: fileFields,
        files: files,
        fileContents: fileContents,
        afterLogin: true,
        isMultiPart: true,
        vendor: null);
  }

  Future setShipperRegistrationCompanyData(
      {TipeModul tipeModul = TipeModul.BF, Map<String, dynamic> body}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
      urlInternal +
          (tipeModul == TipeModul.BF
              ? "backend/set_shipper_registration_company_data"
              : "backend/set_tm_shipper_registration_company_data"),
      body,
    );
  }

  Future setShipperRegistrationLegality(
      {TipeModul tipeModul = TipeModul.BF,
      TipeBadanUsaha tipeBadanUsaha = TipeBadanUsaha.PT_CV,
      Map<String, dynamic> body,
      List<String> fileFields,
      List<io.File> files,
      List<MediaType> fileContents}) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipartFiles(
        urlInternal +
            (tipeModul == TipeModul.BF
                ? "backend/set_shipper_registration_legality"
                : "backend/set_tm_shipper_registration_legality") +
            (tipeBadanUsaha == TipeBadanUsaha.PT_CV ? "" : "_firma"),
        body,
        fileFields: fileFields,
        files: files,
        fileContents: fileContents,
        afterLogin: true,
        isMultiPart: true,
        vendor: null);
  }

  Future resendEmailRegistrationLevel2(
      {String email, TipeModul tipeModul = TipeModul.BF}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + 'backend/resend_email_registration_level_2', {
      "Email": email,
      "Role": "2",
      "SuperMenuID": tipeModul == TipeModul.BF ? "1" : "2"
    });
  }

  Future changeEmailRegistrationLevel2(
      {String email, TipeModul tipeModul = TipeModul.BF}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + 'backend/change_email_registration_level_2', {
      "Email": email,
      "Role": "2",
      "SuperMenuID": tipeModul == TipeModul.BF ? "1" : "2"
    });
  }

  Future verifyEmailRegistrationLevel2(
      {String email, String otp, TipeModul tipeModul = TipeModul.BF}) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + 'backend/verify_email_registration_level_2', {
      "Email": email,
      "Otp": otp,
      "Role": "2",
      "SuperMenuID": tipeModul == TipeModul.BF ? "1" : "2"
    });
  }

  Future getEmailStatus() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + 'backend/get_email_status', null);
  }

  Future checkRegisterStatus() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(urlInternal + 'backend/check_register_status', null);
  }

  Future getReportCategory() async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(urlInternal + 'backend/get_kategori_laporkan', {'Type': 'transporter'});
  }

  Future reportTransporter({
      Map<String, dynamic> body,
      List<String> fileFields,
      List<io.File> files,
      List<MediaType> fileContents}) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipartFiles(
        urlInternal + 'backend/report_transporter',
        body,
        fileFields: fileFields,
        files: files,
        fileContents: fileContents,
        afterLogin: true,
        isMultiPart: true,
        vendor: null);
  }

  Future getAllTruck(Map<String, dynamic> body) async {
  return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
    urlInternal + 'backend/get_transporter_truck_list', body);
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
        urlInternal + "backend/get_save_location", query);
  }

  Future getHakAkses(String menuId) async {
    return await fetchDataFromUrlPOSTMuatMuatAfterLogin(
        urlInternal + 'api/get_hak_akses', {
          "MenuID": menuId
        });
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
