import 'dart:convert';
import 'dart:io' as io;

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/detail_manajemen_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/setting/profile_shipper_model.dart';
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
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:latlong/latlong.dart';
import 'package:quiver/collection.dart';
import 'package:muatmuat/app/network/api_helper.dart' as ah;

/// Class ApiHelper untuk mengakses ke API
class ApiHelper {
  final String _urlLive = "https://www.assetlogistik.com/";
  final String _urlDev = "https://dev.assetlogistik.com/";
  // final String _urlDevZO = "https://devzo.assetlogistik.com/";

  // final String _url = "https://devintern.assetlogistik.com/";
  // final String _urlInternal = "https://internal.assetlogistik.com/";
  // final String _url = "https://qc.assetlogistik.com/"; //devintern;
  // final String _urlInternal =
  //     "https://internalqc.assetlogistik.com/"; //internal
  // final String _urlqc = "https://qc.assetlogistik.com/";
  // final String _urlzo3 = "https://zo3.assetlogistik.com/";
  // static final String urlChatInternal = "https://internal.assetlogistik.com/";

  final String _url = ah.ApiHelper.url; //devintern;
  final String _urlqc = ah.ApiHelper.url;
  final String _urlDevZO = ah.ApiHelper.urlzo;
  final String _urlzo3 = ah.ApiHelper.urlzo;
  final String _urlInternal = ah.ApiHelper.urlInternal; //internal
  static final String urlChatInternal = ah.ApiHelper.urlInternal;
  String _urlInternalSeller = ah.ApiHelper.urlSeller;
  final String _urlDevZOBanner = "https://devzo.assetlogistik.com/";

  //final String _url = "192.168.31.9/wfh/";
  //"http://47.241.76.187/muatmuat/";
  //47.241.76.187;192.168.10.121:8888
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
    try {
      _checkDebug(responseBody);
      responseResult = jsonDecode(responseBody);
    } catch (err) {
      responseResult = null;
    }
    _closeDialogLoading();
    if (responseResult != null) {
      return isEnableCheckMessage
          ? _checkResponseBodyMuatMuat(responseResult)
          : responseResult;
    } else {
      _setError(isErrorConnection, true, 'GlobalLabelErrorNoConnection'.tr);
      if (isShowDialogError)
        return _showDialogError('GlobalLabelErrorNoConnection'.tr);
      else
        return null;
    }
  }

  _getResponseFromURLGooglePlaceAutoComplete(var response) {
    var responseResult;
    try {
      responseResult = jsonDecode(response.body);
    } catch (err) {
      responseResult = null;
    }
    // GlobalVariable.showMessageToastDebug(
    //     "_getResponseFromURLGoogle: " + responseResult.toString());
    _closeDialogLoading();
    if (responseResult != null) {
      return _checkResponseBodyGooglePlaceAutoComplete(responseResult);
    } else {
      _setError(isErrorConnection, true, 'GlobalLabelErrorNoConnection'.tr);
      if (isShowDialogError)
        return _showDialogError('GlobalLabelErrorNoConnection'.tr);
      else
        return null;
    }
  }

  _getResponseFromURLGooglePlaceDetails(var response) {
    var responseResult;
    try {
      responseResult = jsonDecode(response.body);
    } catch (err) {
      responseResult = null;
    }
    // GlobalVariable.showMessageToastDebug(
    //     "_getResponseFromURLGooglePlaceDetails: " + responseResult.toString());
    _closeDialogLoading();
    if (responseResult != null) {
      return _checkResponseBodyGooglePlaceDetails(responseResult);
    } else {
      _setError(isErrorConnection, true, 'GlobalLabelErrorNoConnection'.tr);
      if (isShowDialogError)
        return _showDialogError('GlobalLabelErrorNoConnection'.tr);
      else
        return null;
    }
  }

  _getResponseFromURLGoogleDirection(var response) {
    var responseResult;
    try {
      responseResult = jsonDecode(response.body);
    } catch (err) {
      responseResult = null;
    }
    _closeDialogLoading();
    if (responseResult != null) {
      return _checkResponseBodyGoogleDirectionAPI(responseResult);
    } else {
      _setError(isErrorConnection, true, 'GlobalLabelErrorNoConnection'.tr);
      if (isShowDialogError)
        return _showDialogError('GlobalLabelErrorNoConnection'.tr);
      else
        return null;
    }
  }

  Future _checkConnection() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        isError = true;
      }
    } catch (err) {
      isError = true;
    }
    if (isError) {
      _setError(true, isErrorResponse, 'GlobalLabelErrorNoConnection'.tr);
      _showDialogError('GlobalLabelErrorNoConnection'.tr);
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

  Future _fetchDataFromUrlPOSTMuatMuatAfterLogin(String url, dynamic body,
      {bool isEnableCheckMessage = true, String vendor}) async {
    return await _fetchDataFromUrlPOSTMuatMuat(url, body,
        afterLogin: true,
        isEnableCheckMessage: isEnableCheckMessage,
        vendor: vendor);
  }

  Future _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(String url,
      dynamic body, io.File file, String fileField, MediaType fileContent,
      {String vendor}) async {
    return await _fetchDataFromUrlPOSTMuatMuat(url, body,
        afterLogin: true,
        isMultiPart: true,
        fileField: fileField,
        file: file,
        fileContent: fileContent,
        vendor: vendor);
  }

  Future cekUserPertamaPakai() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + 'backend/check_first_timer_on_after_login', null);
  }

  Future getChooseMe() async {
    var body = {
      "Locale": GlobalVariable.languageType,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + 'api/get_choose_me', body);
  }

  Future getMenuAvailable() async {
    var body = {
      "Locale": GlobalVariable.languageType,
    };
    print(body);
    print(_urlInternal + 'api/get_menu_available');
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + 'api/get_menu_available', body);
  }

  Future getKeuntungan(String role, String modul) async {
    var body = {"Locale": GlobalVariable.languageType, "Role": role};

    if (modul == 'BIGFLEET') {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _url + 'api/get_join_benefit', body);
    } else {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _urlInternal + 'api/get_join_benefit', body);
    }
  }

  Future getDropdownMenu() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + 'base/get_super_menu_muat', null);
  }

  Future getPersyaratan(String type) async {
    var body = {
      "Lang": GlobalVariable.languageType,
      "Type": type,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + 'api/terms_condition', body);
  }

  Future getDemo(String modul) async {
    if (modul == 'BIGFLEET') {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _url + 'base/get_demo', null);
    } else {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _urlDevZO + 'base/get_demo', null);
    }
  }

  Future getDemoLainnya(String docid, String userrole, String modul) async {
    var body = {"DocID": docid, "Role": userrole};

    print(_url + 'base/get_related_demo');
    print(body);

    if (modul == 'BIGFLEET') {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _url + 'base/get_related_demo', body);
    } else {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _urlDevZO + 'base/get_related_demo', body);
    }
  }

  Future getUserStatus() async {
    print(_urlInternal + 'backend/get_user_status');
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + 'backend/get_user_status', null);
  }

  Future setKapasitasPengiriman(String qty, String modul, String force) async {
    var body = {'Qty': qty, 'Forced': force};
    print(body);
    print(_urlInternal +
        (modul == 'BIGFLEET'
            ? 'backend/set_shipper_capacity_qty'
            : 'backend/set_tm_shipper_capacity_qty'));
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal +
            (modul == 'BIGFLEET'
                ? 'backend/set_shipper_capacity_qty'
                : 'backend/set_tm_shipper_capacity_qty'),
        body);
  }

  Future setJumlahArmada(String qty, String modul, String force) async {
    var body = {'Qty': qty, 'Forced': force};
    print(body);
    print(_urlInternal +
        (modul == 'BIGFLEET'
            ? 'backend/set_transporter_truck_qty'
            : 'backend/set_tm_transporter_truck_qty'));
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal +
            (modul == 'BIGFLEET'
                ? 'backend/set_transporter_truck_qty'
                : 'backend/set_tm_transporter_truck_qty'),
        body);
  }

  Future fetchListManajemenRole(String ID, String limit, String pageNow,
      String sortBy, String search, String sortType, var filter) async {
    var _sendJson = {
      "UsersID": ID,
      "Limit": limit,
      "Offset": pageNow,
      "q": search,
      "filter": jsonEncode(filter),
      "role_profile": GlobalVariable.role,
    };

    if (sortBy != "") {
      _sendJson["Order"] = sortBy;
      _sendJson["OrderMode"] = sortType;
    }

    var _path = "backend/get_list_role_sub_user_apps";

    print(_sendJson);
    print(_path);

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future hapusRole(String ID) async {
    var _sendJson = {
      "RoleID": ID,
    };
    var _path = "backend/doDeleteRole";

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future aktifNonRole(String ID, String status) async {
    var _sendJson = {
      "RoleID": ID,
      "status": status,
    };
    var _path = "backend/doNonActiveUserRole";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future getMenu() async {
    var _path = "backend/dropdown_bagi_peran_sub_user";
    print(_urlInternal + _path);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, null);
  }

  Future getDetailRole(String UserID, String RoleID) async {
    var _path = "backend/get_detail_role_sub_user";
    var _sendJson = {
      "UsersID": UserID,
      "RoleID": RoleID,
    };
    print(_urlInternal + _path);
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future fetchListManajemenHakAkses(
      String ID, String search, var filter) async {
    // "limit": limit,
    // "pageNow": pageNow,
    // "sortBy": sortBy,
    // "search": search,
    // "sortType": sortType,
    // "filter": jsonEncode(filter)

    var _sendJson = {
      "SuperMenuID": ID,
      "RoleID": GlobalVariable.role, //GlobalVariable.role
      "q": search
    };
    var _path = "backend/get_list_menu_muat";
    print(_sendJson);
    print(_path);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future simpanManajemenRole(String params) async {
    var _sendJson = {
      "params": params,
    };

    var _path = "backend/doAddRole";

    print(_urlInternal + _path);
    print(_sendJson);

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future _fetchDataFromUrlPOSTMuatMuat(String url, dynamic body,
      {bool afterLogin = false,
      bool isMultiPart = false,
      bool isEnableCheckMessage = true,
      String fileField = "",
      MediaType fileContent,
      io.File file = null,
      String vendor}) async {
    bool isResponseBody = true;
    _checkDebug(url);
    _resetError();
    if (isShowDialogLoading) _showDialogLoading();
    await _checkConnection();
    var response;
    if (!isError) {
      try {
        body = afterLogin
            ? _setBodyFetchURLAfterLogin(body, vendor: vendor)
            : _setBodyFetchURL(body, vendor: vendor);
        if (body == null) {
          response = await http
              .post(url)
              .timeout(Duration(seconds: _requestTimeOutSecond));
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
          } else
            response = await http
                .post(url, body: body)
                .timeout(Duration(seconds: _requestTimeOutSecond));
        }
      } catch (err) {
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
        return _getResponseFromURLMuatMuat(response, isResponseBody,
            isEnableCheckMessage: isEnableCheckMessage);
      } else {
        _closeDialogLoading();
        _setError(true, isErrorResponse, 'GlobalLabelErrorNoConnection'.tr);
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

  Future _fetchDataFromUrlGoogleAPI(String url) async {
    _resetError();
    if (isShowDialogLoading) _showDialogLoading();
    await _checkConnection();
    var response;
    if (!isError) {
      try {
        response = await http.Client()
            .get(url)
            .timeout(Duration(seconds: _requestTimeOutSecond));
      } catch (err) {}
      if (response != null)
        return response;
      else {
        _setError(true, isErrorResponse, 'GlobalLabelErrorNoConnection'.tr);
        if (isShowDialogError)
          return _showDialogError('GlobalLabelErrorNoConnection'.tr);
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
        'ID': GlobalVariable.docID,
        'Key': "ARKalphasolution88"
      })
    };
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
    print('ini base data');
    print(rBody);
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
                        Text(
                          'GlobalLabelDialogLoading'.tr,
                          style: TextStyle(color: Colors.blueAccent),
                        )
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

  Future getDataMenuUserRole() async {
    var query = {
      "q": "",
      "role": "2",
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "backend/get_all_menu_user_role", query);
  }

  Future getDataRoleUserRole() async {
    var query = {
      "q": "",
      "Role": "2",
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "backend/get_all_role_menu_user_role", query);
  }

  Future getDataArticle(String articleRole) async {
    var query = {
      "article_role": articleRole,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "api/get_article", query);
  }

  Future getDataCarousel() async {
    var query = {
      'Locale': GlobalVariable.languageType,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "api/get_promo_primary", query);
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
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/users_login", {
      'Email': user.email,
      'Password': user.password,
      'IsGoogle': isGoogle ? "1" : "0",
      "Lang": GlobalVariable.languageType
    });
  }

  Future fetchRegister(UserModel user, bool isGoogle) async {
    await SharedPreferencesHelper.getLanguage();
    return await _fetchDataFromUrlPOSTMuatMuat(
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
    return await _fetchDataFromUrlPOSTMuatMuat(
        _url + "api/doCreateGoogleAccount", {
      'ID': user.docID,
      'Name': user.name,
      'Email': user.email,
      'Phone': user.phone,
      'ReferralCode': user.referralCode,
    });
  }

  Future fetchVerifyEmail(String email) async {
    return await _fetchDataFromUrlPOSTMuatMuat(
        _url + "verify/check_activation_email", {'Email': email, 'App': '1'});
    // var response =
    //     await http.post(_url + "verify/check_activation_email", body: {
    //   'Email': email,
    // });
    // return response;
  }

  Future fetchResendVerifyEmail(String docID) async {
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/request_email",
        {'DocID': docID, 'Lang': GlobalVariable.languageType});
    // var response = await http.post(_url + "api/request_email", body: {
    //   'DocID': docID,
    // });
    // return response;
  }

  Future fetchResendVerifyPhone(String docID) async {
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/request_phone", {
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

  Future fetchVerifyPhone(String docID) async {
    return await _fetchDataFromUrlPOSTMuatMuat(
        _url + "verify/check_activation_phone", {
      'DocID': docID,
    });
    // var response =
    //     await http.post(_url + "verify/check_activation_phone", body: {
    //   'DocID': docID,
    // });
    // return response.body;
  }

  Future fetchVerifyOTPEmail(String verifID, String otp) async {
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "verify/input_otp_email",
        {'VerifID': verifID, 'Pin': otp, 'App': '1'});
  }

  Future fetchVerifyOTPPhone(String verifID, String otp) async {
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "verify/input_otp_phone",
        {'VerifID': verifID, 'Pin': otp, 'App': '1'});
  }

  Future fetchResetPassword(String email) async {
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/forgot_password", {
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
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/change_number", {
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
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/privacy_policy",
        {'App': "1", 'Type': type}); //_url + "api/privacy_policy"
    // return await _fetchDataFromUrlPOSTMuatMuat(_url + "base/get_privacy_policy",
    //     {'App': "1", 'Type': "general"}); //_url + "api/privacy_policy"
  }

  Future fetchTermCondition({String type = "general"}) async {
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/terms_condition",
        {'App': "1", 'Type': type}); //_url + "api/terms_condition"
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
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "lang/backend", body);
  }

  Future fetchHeadTruck() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "base/get_head_truck", null);
  }

  Future getTransporterContact(String transporterID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_contact_transporter_by_shipper",
        {"TransporterID": transporterID});
  }

  Future getTransporterContactCustomARK(String transporterID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_contact_transporter",
        {"TransporterID": transporterID});
  }

  Future getTransporterWACustomARK(String transporterID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_wa_transporter", {"TransporterID": transporterID});
  }

  Future getShipperContact(String shipperID) async {
    print("shipper contact");
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_contact_shipper", {"ShipperID": shipperID});
  }

  Future getShipperWA(String shipperID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_wa_shipper", {"ShipperID": shipperID});
  }

  Future getInfoPraTenderTransporterAllCounter(String userID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_all_counter_tender", {"UserID": userID});
  }

  Future getTransporterProfile(String transporterID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_profile_transporter_by_shipper",
        {"TransporterID": transporterID});
  }

  Future getTransporterMedia(String transporterID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_media_transporter_by_shipper",
        {"TransporterID": transporterID});
  }

  Future getTransporterTestimony(String transporterID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_testimony_transporter_by_shipper",
        {"TransporterID": transporterID});
  }

  Future getTransporterRating(String transporterID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_rate_transporter",
        {"TransporterID": transporterID});
  }

  Future fetchAllCarrierTruck() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "base/get_carrier_truck", null);
  }

  Future fetchAllCity() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_destination", null);
  }

  Future requestAsPartner(String shipperID, String transporterID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/void_mitra", body);
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_mitra_by_shipper", query);
  }

  Future fetchNonFilteredMitra(String shipperID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_mitra_by_shipper", {"ShipperID": shipperID});
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

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_mitra_by_shipper", body);
  }

  Future fetchGetCountReqMitra(String shipperID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_count_data_approve_request_mitra",
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

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_transporter_to_shipper", body);
  }

  Future fetchCheckStatusTransporterAsMitra(
      String shipperID, String transporterID) async {
    var body = {"ShipperID": shipperID, "TransporterID": transporterID};
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/check_transporter_mitra_by_shipper", body);
  }

  Future fetchSetGroupMitraStatus(String groupID, String status) async {
    var body = {"GroupID": groupID, "Status": status};
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/update_status_group_mitra", body);
  }

  Future fetchDeleteGroupMitra(String groupID) async {
    var body = {"GroupID": groupID, "Void": "1"};
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/void_group_mitra_by_shipper", body);
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/approve_reject_mitra_by_shipper", body);
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/cancel_request_mitra_by_shipper", body);
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_shipper_to_transporter", body);
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_list_group_mitra_by_shipper", query);
  }

  Future fetchMitraCV(String url) async {
    var response =
        await http.get(url).timeout(Duration(seconds: _requestTimeOutSecond));
    return _getResponseFromURLMuatMuat(response, true);
  }

  Future fetchListPartnerInGroup(String groupID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_detail_group_mitra_by_shipper",
        {"GroupID": groupID});
  }

  Future createGroupMitra(String name, String description, String shipperID,
      String listMitra, io.File imageFile) async {
    if (imageFile == null) {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _url + "backend/doAddGroupMitra", {
        "Name": name,
        "Description": description,
        "ShipperID": shipperID,
        "MitraID": listMitra
      });
    } else {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(
          _url + "backend/doAddGroupMitra",
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
      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _url + "backend/doUpdateGroupMitra", {
        "ID": groupID,
        "Name": name,
        "Description": description,
        "MitraID": listMitra
      });
    } else {
      return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(
          _url + "backend/doUpdateGroupMitra",
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doAddGroupMitraTransaction",
        {"GroupID": groupID, "MitraID": mitraID});
  }

  Future removeMitraFromGroup(String docID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/void_member_group_mitra_by_shipper",
        {"MitraID": docID, "Void": "1"});
  }

  Future fetchDetailTransporter(String transporterID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_transporter_detail",
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_transporter_list", query);
  }

  Future getDetailPermintaanMuat(String docID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_detail_permintaan_muat",
        {"ShipperID": "120", "PermintaanMuat": "1"});
  }

  Future fetchCheckDuplicateAccount(UserModel userModel) async {
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/check_email_phone", {
      'Email': userModel.email,
      'Phone': userModel.phone,
      'Lang': GlobalVariable.languageType
    });
  }

  Future fetchListLanguage() async {
    // return await _fetchDataFromUrlPOSTMuatMuat(_url + "lang/available", null);
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "lang/available", null);
  }

  Future fetchCheckDevice() async {
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/check_device", {
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_business_entity", null);
  }

  Future fetchBusinessField() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_business_field", null);
  }

  Future fetchCategoryCapacity() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_category_capacity", null);
  }

  Future fetchProvince() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_province", null);
  }

  Future fetchProfileShipper() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_kota", {'provinceID': provinceId});
  }

  Future fetchCarrierTruck({String headID}) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "base/get_carrier_truck",
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_all_filter_master_truk_siap_muat", query);
  }

  Future fetchAreaPickupTransporter(String transporterID) async {
    var query = {"Type": "2", "TransporterID": transporterID};
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_all_filter_master_truk_siap_muat", query);
  }

  Future fetchSearchLocationTruckReady(String sourceCity, String destCity,
      String headID, String carrierID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_list_location_truck_ready", {
      'q[SourceCity]': sourceCity,
      'q[DestinationCity]': destCity,
      'q[HeadID]': headID,
      'q[CarrierID]': carrierID
    });
  }

  Future fetchCheckUser() async {
    //Mode 1 = All; Mode 2 = Shipper; Mode 4 = Transporter; Mode 8 = Seller; Mode 16 = Jobseeker
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "api/check_user", {'Mode': "2"});
  }

  Future fetchAddLocationManagement(
      {@required String name,
      @required String address,
      @required String latitude,
      @required String longitude,
      @required String district}) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
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

  Future fetchAllLocationManagement() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_save_location", {
      'Role': GlobalVariable.role,
      'UsersID': GlobalVariable.userModelGlobal.docID,
    });
  }

  Future fetchAddHistoryLocation(
      {@required String address,
      @required String latitude,
      @required String longitude,
      @required String district}) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_history_location", {
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
        _url + "backend/doUpdateProfileShipper",
        body,
        imageFile,
        'Avatar',
        MediaType('images', 'jpeg'));
  }

  Future fetchSetting() async {
    return await _fetchDataFromUrlPOSTMuatMuat(_url + "api/get_setting", null);
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/save_data_permintaan_muat", query);
  }

  Future detailPermintaanMuat(String shipperID, String muatID) async {
    var query = {"ShipperID": shipperID, "PermintaanMuatID": muatID};
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
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
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/save_data_edit_permintaan_muat", query);
  }

  //CEK AKSES
  Future getAllHakAkses() async {
    var _sendJson = {"Role": GlobalVariable.role};
    var url = _urlInternal + "api/get_all_hak_akses_app";
    print(url);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(url, _sendJson);
  }

  Future getHakAkses(String id) async {
    var _sendJson = {"MenuID": id};

    var url = _urlInternal + "api/get_hak_akses";
    print(url);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(url, _sendJson);
  }
  //CEK AKSES

  Future setFavourite(String kategoriID, String subKategoriID, String iklanID,
      String isWishList) async {
    var _sendJson = {
      "KategoriID": kategoriID,
      "SubKategoriID": subKategoriID,
      "IklanID": iklanID,
      "isWishList": isWishList,
      "UserID": GlobalVariable.docID
    };

    var url = _urlInternalSeller + "buyer/saveWishList";
    print(url);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(url, _sendJson);
  }

  Future getListBuyer(String layanan, int limit, bool login) async {
    var _sendJson = {
      "nama_layanan": layanan,
      "pageNow": "1",
      "limit": limit.toString()
    };

    if (login) {
      _sendJson['UserID'] = GlobalVariable.docID;
    }

    var url = _urlInternalSeller + "buyer/getDataByLayanan";
    print(url);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(url, _sendJson);
  }

  //INFO PRA TENDER

  Future fetchListInfoPratender(
      String ID,
      String limit,
      String pageNow,
      String sortBy,
      String search,
      String sortType,
      var filter,
      String PageName,
      String LangLink,
      String RealLink,
      String IsShipper,
      String history,
      {String browseUntuk}) async {
    print("datafilter di api");
    print(filter);
    var _sendJson = {
      "limit": limit,
      "pageNow": pageNow,
      "sortBy": sortBy,
      "search": search,
      "sortType": sortType,
      "filter": jsonEncode(filter),
      "PageName": PageName,
      "LangLink": LangLink,
      "RealLink": RealLink,
    };

    if (IsShipper == "1") {
      _sendJson["ShipperID"] = ID;
      _sendJson["IsShipper"] = IsShipper;
    } else {
      _sendJson["TransporterID"] = ID;
    }

    if (history == "1") {
      _sendJson["history"] = history;
    }

    if (browseUntuk == "PROSES TENDER") {
      _sendJson["forProsesTender"] = "1";
    }

    var _path = "backend/get_data_info_pra_tender";

    print(_path);
    print(_sendJson);

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + _path, _sendJson);
  }

  Future getDetailInfoPraTender(String id, String IDTrans) async {
    print('ShipperID ' +
        id.toString() +
        " InfoPraTenderID " +
        IDTrans.toString());
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_detail_info_pra_tender",
        {'ShipperID': id, "InfoPraTenderID": IDTrans});
  }

  Future createInfoPratender(
    String ShipperID,
    String namaPratender,
    String satuan_tender,
    String nama_muatan,
    String jenis_muatan,
    String berat_muatan,
    String volume_muatan,
    String satuan_volume,
    String panjang,
    String lebar,
    String tinggi,
    String satuan_dimensi,
    String jumlah_koli,
    String jumlah_rute,
    String kualifikasi_lampiran,
    String nama_file,
    String catatan_tambahan,
    invitation, // Map
    List<dynamic> invited_email,
    List<dynamic> tahap_tender,
    List<dynamic> unit_truk,
    List<dynamic> rute,
    io.File fileUpload,
  ) async {
    var body = {
      'ShipperID': ShipperID,
      'namaPratender': namaPratender,
      'satuan_tender': satuan_tender,
      'nama_muatan': nama_muatan,
      'jenis_muatan': jenis_muatan,
      'berat_muatan': berat_muatan,
      'volume_muatan': volume_muatan,
      'satuan_volume': satuan_volume,
      'panjang': panjang,
      'lebar': lebar,
      'tinggi': tinggi,
      'satuan_dimensi': satuan_dimensi,
      'jumlah_koli': jumlah_koli,
      'jumlah_rute': jumlah_rute,
      'kualifikasi_lampiran': kualifikasi_lampiran,
      'nama_file': nama_file,
      'catatan_tambahan': catatan_tambahan,
      'invitation': jsonEncode(invitation),
      'invited_email': jsonEncode(invited_email),
      'tahap_tender': jsonEncode(tahap_tender),
      'unit_truck': jsonEncode(unit_truk),
      'rute': jsonEncode(rute),
    };
    print('DATA INVITATION');
    print(jsonEncode(invitation));
    print('DATA EMAIL INVITATION');
    print(jsonEncode(invited_email));
    print('DATA TAHAP TENDER');
    print(jsonEncode(tahap_tender));
    print('DATA UNIT TRUK');
    print(jsonEncode(unit_truk));
    print('DATA RUTE');
    print(jsonEncode(rute));
    print('DATA LAINNYA');
    print(body);

    String extension = "";
    if (nama_file != "" && nama_file != null) {
      List<String> arr_nama = nama_file.split(".");
      extension = arr_nama[arr_nama.length - 1];
    }

    return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(
        _url + "backend/save_data_info_pra_tender",
        body,
        fileUpload,
        'dokumen_pendukung',
        MediaType('application', extension));
  }

  Future editInfoPratender(
    String tipeEdit,
    String InfoPraTenderID,
    String status,
    String ShipperID,
    String namaPratender,
    String satuan_tender,
    String nama_muatan,
    String jenis_muatan,
    String berat_muatan,
    String volume_muatan,
    String satuan_volume,
    String panjang,
    String lebar,
    String tinggi,
    String satuan_dimensi,
    String jumlah_koli,
    String jumlah_rute,
    String kualifikasi_lampiran,
    String nama_file,
    String catatan_tambahan,
    invitation, // Map
    List<dynamic> invited_email,
    List<dynamic> tahap_tender,
    List<dynamic> unit_truk,
    List<dynamic> rute,
    io.File fileUpload,
  ) async {
    if (tipeEdit == "SEBELUM") {
      var body = {
        'InfoPraTenderID': InfoPraTenderID,
        'status': status,
        'ShipperID': ShipperID,
        'namaPratender': namaPratender,
        'satuan_tender': satuan_tender,
        'nama_muatan': nama_muatan,
        'jenis_muatan': jenis_muatan,
        'berat_muatan': berat_muatan,
        'volume_muatan': volume_muatan,
        'satuan_volume': satuan_volume,
        'panjang': panjang,
        'lebar': lebar,
        'tinggi': tinggi,
        'satuan_dimensi': satuan_dimensi,
        'jumlah_koli': jumlah_koli,
        'jumlah_rute': jumlah_rute,
        'kualifikasi_lampiran': kualifikasi_lampiran,
        'nama_file': nama_file,
        'catatan_tambahan': catatan_tambahan,
        'invitation': jsonEncode(invitation),
        'invited_email': jsonEncode(invited_email),
        'tahap_tender': jsonEncode(tahap_tender),
        'unit_truck': jsonEncode(unit_truk),
        'rute': jsonEncode(rute),
      };

      print('DATA INVITATION');
      print(jsonEncode(invitation));
      print('DATA EMAIL INVITATION');
      print(jsonEncode(invited_email));
      print('DATA TAHAP TENDER');
      print(jsonEncode(tahap_tender));
      print('DATA UNIT TRUK');
      print(jsonEncode(unit_truk));
      print('DATA RUTE');
      print(jsonEncode(rute));
      print('DATA LAINNYA');
      print(body);

      String extension = "";
      if (nama_file != "" && nama_file != null) {
        List<String> arr_nama = nama_file.split(".");
        extension = arr_nama[arr_nama.length - 1];
      }

      return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(
          _url + "backend/save_data_info_pra_tender",
          body,
          fileUpload,
          'dokumen_pendukung',
          MediaType('application', extension));
    } else {
      var body = {
        'InfoPraTenderID': InfoPraTenderID,
        'status': status,
        'ShipperID': ShipperID,
        'kualifikasi_pratender': kualifikasi_lampiran,
        'catatan_tambahan': catatan_tambahan,
        'tahap_tender': jsonEncode(tahap_tender),
      };

      print('DATA TAHAP TENDER');
      print(jsonEncode(tahap_tender));
      print('DATA LAINNYA');
      print(body);

      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _url + "backend/save_data_edit_masa_info_pra_tender", body);
    }
  }

  Future hapusFileInfoPraTender(
    String idtrans,
  ) async {
    var query = {
      "InfoPraTenderID": idtrans,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/delete_file_pra_tender", query);
  }

  Future sharePDFDetailInfoPraTender(
    String id,
    String infoPraTenderID,
  ) async {
    var query = {
      "ShipperID": id,
      "InfoPraTenderID": infoPraTenderID,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_export_info_pra_tender", query);
  }

  Future sharePDFListInfoPraTender(
    String id,
    String exportPeriodeAwal,
    String exportPeriodeAkhir,
    String history,
  ) async {
    var query = {
      "ShipperID": id,
      "export_periode_awal": exportPeriodeAwal,
      "export_periode_akhir": exportPeriodeAkhir,
      "history": history,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_export_list_info_pra_tender", query);
  }

  Future sendEmailInfoPraTender(
    String shipperID,
    String infoPraTenderID,
    List<dynamic> invitedEmail,
  ) async {
    var query = {
      "ShipperID": shipperID,
      "InfoPraTenderID": infoPraTenderID,
      "invited_email": jsonEncode(invitedEmail),
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/send_email_pra_tender", query);
  }

  Future resendEmailInfoPraTender(
    String shipperID,
    String invitationID,
  ) async {
    var query = {
      "ShipperID": shipperID,
      "InvitationID": invitationID,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/resend_email_pra_tender", query);
  }
  //INFO PRA TENDER

  //PROSES TENDER

  Future fetchListProsesTender(
      String ID,
      String limit,
      String pageNow,
      String sortBy,
      String search,
      String sortType,
      var filter,
      String PageName,
      String LangLink,
      String RealLink,
      String IsShipper,
      String history) async {
    print("datafilter di api");
    print(filter);
    var _sendJson = {
      "limit": limit,
      "pageNow": pageNow,
      "sortBy": sortBy,
      "search": search,
      "sortType": sortType,
      "filter": jsonEncode(filter),
      "PageName": PageName,
      "LangLink": LangLink,
      "RealLink": RealLink,
    };

    if (IsShipper == "1") {
      _sendJson["ShipperID"] = ID;
      _sendJson["IsShipper"] = IsShipper;
    } else {
      _sendJson["TransporterID"] = ID;
    }

    if (history == "1") {
      _sendJson["history"] = history;
    }

    var _path = "mgebackend/get_data_proses_tender";

    print(_path);
    print(_sendJson);

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + _path, _sendJson);
  }

  Future getDetailProsesTender(String id, String IDTrans) async {
    var data = {'ShipperID': id, "ProsesTenderID": IDTrans};
    print(data);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_data_detail_proses_tender", data);
  }

  Future createProsestender(
      String ShipperID,
      String namaPratender,
      String satuan_tender,
      String nama_muatan,
      String jenis_muatan,
      String berat_muatan,
      String volume_muatan,
      String satuan_volume,
      String panjang,
      String lebar,
      String tinggi,
      String satuan_dimensi,
      String jumlah_koli,
      String jumlah_rute,
      String kualifikasi_lampiran,
      String nama_file,
      String catatan_tambahan,
      invitation, // Map
      List<dynamic> invited_email,
      List<dynamic> tahap_tender,
      List<dynamic> unit_truk,
      List<dynamic> rute,
      io.File fileUpload,
      String idpratender,
      String jenis_tender,
      String tertutup_peserta_tender,
      String tertutup_pemenang_tender,
      String format_dokumen,
      String format_dokumen_desc) async {
    var body = {
      'ShipperID': ShipperID,
      'namaPratender': namaPratender,
      'satuan_tender': satuan_tender,
      'nama_muatan': nama_muatan,
      'jenis_muatan': jenis_muatan,
      'berat_muatan': berat_muatan,
      'volume_muatan': volume_muatan,
      'satuan_volume': satuan_volume,
      'panjang': panjang,
      'lebar': lebar,
      'tinggi': tinggi,
      'satuan_dimensi': satuan_dimensi,
      'jumlah_koli': jumlah_koli,
      'jumlah_rute': jumlah_rute,
      'kualifikasi_lampiran': kualifikasi_lampiran,
      'nama_file': nama_file,
      'catatan_tambahan': catatan_tambahan,
      'pratender_ID': idpratender,
      'jenis_tender': jenis_tender,
      'tertutup_peserta_tender': tertutup_peserta_tender,
      'tertutup_pemenang_tender': tertutup_pemenang_tender,
      'format_dokumen': format_dokumen,
      'format_dokumen_desc': format_dokumen_desc,
      'invitation': jsonEncode(invitation),
      'invited_email': jsonEncode(invited_email),
      'tahap_tender': jsonEncode(tahap_tender),
      'unit_truck': jsonEncode(unit_truk),
      'rute': jsonEncode(rute),
    };
    print('DATA INVITATION');
    print(jsonEncode(invitation));
    print('DATA EMAIL INVITATION');
    print(jsonEncode(invited_email));
    print('DATA TAHAP TENDER');
    print(jsonEncode(tahap_tender));
    print('DATA UNIT TRUK');
    print(jsonEncode(unit_truk));
    print('DATA RUTE');
    print(jsonEncode(rute));
    print('DATA LAINNYA');
    print(body);

    String extension = "";
    if (nama_file != "" && nama_file != null) {
      List<String> arr_nama = nama_file.split(".");
      extension = arr_nama[arr_nama.length - 1];
    }

    return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(
        _url + "mgebackend/save_data_proses_tender",
        body,
        fileUpload,
        'dokumen_pendukung',
        MediaType('application', extension));
  }

  Future editProsestender(
      String tipeEdit,
      String ProsesTenderID,
      String status,
      String ShipperID,
      String namaPratender,
      String satuan_tender,
      String nama_muatan,
      String jenis_muatan,
      String berat_muatan,
      String volume_muatan,
      String satuan_volume,
      String panjang,
      String lebar,
      String tinggi,
      String satuan_dimensi,
      String jumlah_koli,
      String jumlah_rute,
      String kualifikasi_lampiran,
      String nama_file,
      String catatan_tambahan,
      String catatan_perubahan,
      invitation, // Map
      List<dynamic> invited_email,
      List<dynamic> tahap_tender,
      List<dynamic> unit_truk,
      List<dynamic> rute,
      io.File fileUpload,
      String idpratender,
      String jenis_tender,
      String tertutup_peserta_tender,
      String tertutup_pemenang_tender,
      String format_dokumen,
      String format_dokumen_desc) async {
    if (tipeEdit == "SEBELUM") {
      var body = {
        'ProsesTenderID': ProsesTenderID,
        'status': status,
        'ShipperID': ShipperID,
        'namaPratender': namaPratender,
        'satuan_tender': satuan_tender,
        'nama_muatan': nama_muatan,
        'jenis_muatan': jenis_muatan,
        'berat_muatan': berat_muatan,
        'volume_muatan': volume_muatan,
        'satuan_volume': satuan_volume,
        'panjang': panjang,
        'lebar': lebar,
        'tinggi': tinggi,
        'satuan_dimensi': satuan_dimensi,
        'jumlah_koli': jumlah_koli,
        'jumlah_rute': jumlah_rute,
        'kualifikasi_lampiran': kualifikasi_lampiran,
        'nama_file': nama_file,
        'catatan_tambahan': catatan_tambahan,
        'pratender_ID': idpratender,
        'jenis_tender': jenis_tender,
        'tertutup_peserta_tender': tertutup_peserta_tender,
        'tertutup_pemenang_tender': tertutup_pemenang_tender,
        'format_dokumen': format_dokumen,
        'format_dokumen_desc': format_dokumen_desc,
        'catatan_perubahan': catatan_perubahan,
        'invitation': jsonEncode(invitation),
        'invited_email': jsonEncode(invited_email),
        'tahap_tender': jsonEncode(tahap_tender),
        'unit_truck': jsonEncode(unit_truk),
        'rute': jsonEncode(rute),
      };

      print('DATA INVITATION');
      print(jsonEncode(invitation));
      print('DATA EMAIL INVITATION');
      print(jsonEncode(invited_email));
      print('DATA TAHAP TENDER');
      print(jsonEncode(tahap_tender));
      print('DATA UNIT TRUK');
      print(jsonEncode(unit_truk));
      print('DATA RUTE');
      print(jsonEncode(rute));
      print('DATA LAINNYA');
      print(body);

      String extension = "";
      if (nama_file != "" && nama_file != null) {
        List<String> arr_nama = nama_file.split(".");
        extension = arr_nama[arr_nama.length - 1];
      }

      return await _fetchDataFromUrlPOSTMuatMuatAfterLoginMultipart(
          _url + "mgebackend/save_data_proses_tender",
          body,
          fileUpload,
          'dokumen_pendukung',
          MediaType('application', extension));
    } else {
      var body = {
        'ProsesTenderID': ProsesTenderID,
        'status': status,
        'ShipperID': ShipperID,
        'kualifikasi_pratender': kualifikasi_lampiran,
        'catatan_tambahan': catatan_tambahan,
        'catatan_perubahan': catatan_perubahan,
        'tahap_tender': jsonEncode(tahap_tender),
      };

      print('DATA TAHAP TENDER');
      print(jsonEncode(tahap_tender));
      print('DATA LAINNYA');
      print(body);

      return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
          _url + "mgebackend/save_data_edit_masa_proses_tender", body);
    }
  }

  Future hapusFileProsesTender(
    String idtrans,
  ) async {
    var query = {
      "ProsesTenderID": idtrans,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/delete_file_proses_tender", query);
  }

  Future sharePDFDetailProsesTender(
    String id,
    String prosesTenderID,
  ) async {
    var query = {
      "ShipperID": id,
      "ProsesTenderID": prosesTenderID,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_export_proses_tender", query);
  }

  Future sharePDFListProsesTender(
    String id,
    String exportPeriodeAwal,
    String exportPeriodeAkhir,
    String history,
  ) async {
    var query = {
      "ShipperID": id,
      "export_periode_awal": exportPeriodeAwal,
      "export_periode_akhir": exportPeriodeAkhir,
      "history": history,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_export_list_proses_tender", query);
  }

  Future sharePDFListPemenangTender(
    String id,
    String exportPeriodeAwal,
    String exportPeriodeAkhir,
    String history,
  ) async {
    var query = {
      "ShipperID": id,
      "export_periode_awal": exportPeriodeAwal,
      "export_periode_akhir": exportPeriodeAkhir,
      "history": history,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_export_list_pemenang_tender", query);
  }

  Future sendEmailProsesTender(
    String shipperID,
    String prosesTenderID,
    List<dynamic> invitedEmail,
  ) async {
    var query = {
      "ShipperID": shipperID,
      "ProsesTenderID": prosesTenderID,
      "invited_email": jsonEncode(invitedEmail),
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/send_email_proses_tender", query);
  }

  Future resendEmailProsesTender(
    String shipperID,
    String invitationID,
  ) async {
    var query = {
      "ShipperID": shipperID,
      "InvitationID": invitationID,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/resend_email_proses_tender", query);
  }

  Future getLastSearchTransactionTender(
      String shipperID, String kode, String type, String isShipper) async {
    var query = {
      "Type": type.toLowerCase(),
      "ShipperID": shipperID,
      "Kode": kode,
      "IsShipper": isShipper,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/last_search", query);
  }

  Future deleteLastSearchTransactionTender(String searchID) async {
    var query = {
      "LastSearchID": searchID,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/delete_last_search", query);
  }

  Future deleteAllLastSearchTransactionTender(
      String shipperID, String kode, String type, String isShipper) async {
    var query = {
      "Type": type.toLowerCase(),
      "ShipperID": shipperID,
      "Kode": kode,
      "IsShipper": isShipper,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/delete_all_last_search", query);
  }

  //PROSES TENDER

  //PESERTA TENDER
  Future fetchListPeserta(
      String idTender,
      String ID,
      String limit,
      String pageNow,
      String sortBy,
      String search,
      String sortType,
      var filter) async {
    var query = {
      "ProsesTenderID": idTender,
      "ShipperID": ID,
      "limit": limit,
      "pageNow": pageNow,
      "sortBy": sortBy,
      "search": search,
      "sortType": sortType,
      "filter": jsonEncode(filter)
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_data_peserta_proses_tender", query);
  }

  Future getPenawaranTransporter(String idTender, String idTransporter) async {
    var query = {
      "ProsesTenderID": idTender,
      "TransporterID": idTransporter,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_data_penawaran", query);
  }

  Future getDataPemenang(String idTender) async {
    var query = {
      "ProsesTenderID": idTender,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_data_pemenang_tender", query);
  }

  Future getDetailPemenang(String idTender, String idShipper) async {
    var query = {
      "ProsesTenderID": idTender,
      "ShipperID": idShipper,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_data_detail_pemenang_tender", query);
  }

  Future fetchPilihPemenang(String idrute, String ID, String limit,
      String pageNow, String sortBy, String search, String sortType) async {
    var query = {
      "RuteID": idrute,
      "ShipperID": ID,
      "limit": limit,
      "pageNow": pageNow,
      "sortBy": sortBy,
      "search": search,
      "sortType": sortType,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/get_data_pilih_pemenang_tender", query);
  }

  Future simpanPemenangTender(String idtender, List datarutetender) async {
    var query = {
      "ProsesTenderID": idtender,
      "datarutetender": jsonEncode(datarutetender)
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/save_data_pemenang_tender", query);
  }

  Future getDateTimeNow() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_time_now", null);
  }
  //PESERTA TENDER

  //SAVE LOCATION
  Future saveSearchLocationTender(
      String ID, String Kode, String Type, String searchText) async {
    var body = {
      'ShipperID': ID,
      'Kode': Kode,
      'Type': Type,
      'IsShipper': '1',
      'search': searchText,
    };

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/save_search_location", body);
  }

  Future getLastTransactionLocationTender(
      String id, String tipe, String kode) async {
    var query = {
      "UserID": id,
      "Type": tipe,
      "Kode": kode,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_last_transaction_location_tender", query);
  }

  Future getLastSearchLocationTender(
      String id, String tipe, String kode) async {
    var query = {
      "ShipperID": id,
      "Kode": kode,
      "Type": tipe,
      'IsShipper': '1',
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/last_search_location", query);
  }
  //SAVE LOCATION

  //PEMENANG TENDER

  Future fetchListPemenangTender(
      String ID,
      String limit,
      String pageNow,
      String sortBy,
      String search,
      String sortType,
      var filter,
      String PageName,
      String LangLink,
      String RealLink,
      String IsShipper,
      String history,
      {String jenisBelumDiumumkan}) async {
    print("datafilter di api");
    print(filter);
    var _sendJson = {
      "limit": limit,
      "pageNow": pageNow,
      "sortBy": sortBy,
      "search": search,
      "sortType": sortType,
      "filter": jsonEncode(filter),
      "PageName": PageName,
      "LangLink": LangLink,
      "RealLink": RealLink,
    };

    if (IsShipper == "1") {
      _sendJson["ShipperID"] = ID;
      _sendJson["IsShipper"] = IsShipper;
    } else {
      _sendJson["TransporterID"] = ID;
    }

    var _path;

    if (PageName == 'BelumDiumumkan') {
      _path = "mgebackend/get_data_pemenang_tender_belum_diumumkan";

      if (jenisBelumDiumumkan != null)
        _sendJson["halaman"] = jenisBelumDiumumkan;
    } else if (PageName == 'Diumumkan') {
      _path = "mgebackend/get_data_pemenang_tender_diumumkan";
    }

    print(_path);
    print(_sendJson);

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + _path, _sendJson);
  }

  Future setUmumkanLebihAwal(String idTender) async {
    var query = {
      "ProsesTenderID": idTender,
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "mgebackend/umumkan_lebih_awal", query);
  }

  Future listHeadTruck() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "base/get_head_truck", null);
  }

  Future listTransporterMitraGroup(String shipperID) async {
    var query = {
      "ShipperID": shipperID,
      "Order": "Name,Status",
      "OrderMode": "ASC,ASC",
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_all_list_group_mitra_by_shipper", query);
  }

  Future listTransporterSaja(String shipperID) async {
    var query = {
      "ShipperID": shipperID,
      "Order": "Name",
      "OrderMode": "ASC",
    };
    print(query);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_all_transporter_list", query);
  }

  Future listCarrierTruck() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "base/get_carrier_truck", null);
  }

  Future listCarrierTruckByTruck({String headID}) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "base/get_carrier_truck_by_truck",
        headID != null ? {'HeadID': headID} : null);
  }

  Future getSpecificTruck(String headID, String carrierID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "base/get_truck", {"HeadID": headID, "CarrierID": carrierID});
  }

  Future getListDiumumkan(String shipperID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_diumumkan_kepada_permintaan_muat",
        {"ShipperID": shipperID});
  }

  Future fetchSaveLocation(
    String userID, {
    int offset = 0,
    int limit = 10,
    String searchValue,
    Map<dynamic, dynamic> order,
  }) async {
    var query = {
      "UsersID": userID,
      "Role": GlobalVariable.role,
      "Limit": limit.toString()
    };
    if (searchValue != null) {
      query["q"] = searchValue;
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
        query["Order"] = stringOrder;
        query["OrderMode"] = stringOrderMode;
      }
    }
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_save_location", query);
  }

  Future getHistoryTransactLocation(String userID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_history_location",
        {"UsersID": userID, "Role": GlobalVariable.role});
  }

  Future fetchDetailManajemenLokasi(String docID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_detail_save_location", {"DocID": docID});
  }

  Future fetchAddManajemenLokasi(
      DetailManajemenLokasiModel detailManajemenLokasiModel) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doAddSaveLocation",
        {"param": jsonEncode(detailManajemenLokasiModel.toJson())});
  }

  Future fetchUpdateManajemenLokasi(
      DetailManajemenLokasiModel detailManajemenLokasiModel) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doUpdateSaveLocation",
        {"param": jsonEncode(detailManajemenLokasiModel.toJson())});
  }

  Future fetchDeleteManajemenLokasi(String docID) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/doDeleteSaveLocation", {"DocID": docID});
  }

  Future fetchInfoFromAddress({String address, String placeID}) async {
    var body = (placeID != null) ? {"place_id": placeID} : {"address": address};
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "api/get_lat_long", body,
        isEnableCheckMessage: false);
  }

  Future fetchMaxTruck({String shipperID}) async {
    var body = (shipperID != null) ? {"ShipperID": shipperID} : null;
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_max_truck", body,
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

  Future fetchSearchCity(String search) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_all_kota", {"q": search});
  }

  Future fetchAllDistrict(String search) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "base/get_all_district", {"q": search});
  }

  Future fetchLastTransaction(String shipperID, String type) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_last_transaction_location", {
      "TransporterID": shipperID,
      "Type": type
    }); // belum bisa API untuk shipper ID
  }

  Future fetchGetDataUserTypeInformation() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_user_type_information", {}); // belum ada data
  }

  //TRANSPORTER

  Future fetchListInfoPratenderTransporter(
      String ID,
      String limit,
      String pageNow,
      String sortBy,
      String search,
      String sortType,
      var filter,
      String PageName,
      String LangLink,
      String RealLink,
      String history) async {
    var _sendJson = {
      "limit": limit,
      "pageNow": pageNow,
      "sortBy": sortBy,
      "search": search,
      "sortType": sortType,
      "filter": jsonEncode(filter),
      "PageName": PageName,
      "LangLink": LangLink,
      "RealLink": RealLink,
      "TransporterID": ID,
    };

    if (history == "1") {
      _sendJson["history"] = history;
    }

    var _path = "backend/get_data_info_pra_tender";

    print("start param dikirim");
    print(_path);
    print(_sendJson);
    print("end param dikirim");

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + _path, _sendJson);
  }

  Future getDetailInfoPraTenderTransporter(String id, String IDTrans) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_data_detail_info_pra_tender",
        {"TransporterID": id, "InfoPraTenderID": IDTrans});
  }

  Future sharePDFDetailInfoPraTenderTransporter(
    String id,
    String infoPraTenderID,
  ) async {
    var query = {
      "TransporterID": id,
      "InfoPraTenderID": infoPraTenderID,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/get_export_info_pra_tender", query);
  }

  Future resendEmailInfoPraTenderTransporter(
    String id,
    String invitationID,
  ) async {
    var query = {
      "TransporterID": id,
      "InvitationID": invitationID,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _url + "backend/resend_email_pra_tender", query);
  }

  // CARI HARGA TRANSPORT
  Future getAutoCompleteStreet(String search) async {
    var query = {
      "phrase": search,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "api/get_autocomplete_street_json", query);
  }

  Future getDistrictByToken(String search) async {
    var query = {
      "place_id": search,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "api/get_districts_by_token", query);
  }

  Future getTruckDetail(
    String truckID,
    String carrierID,
  ) async {
    var query = {
      "HeadID": truckID,
      "CarrierID": carrierID,
    };
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "base/get_truck", query);
  }

  Future getTransporterList() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlqc + "backend/get_transporter_list_free", null);
  }

  Future fetchLatestSearchLocation() async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlzo3 + "base/doGetHistoryCariHargaTransport", null);
  }

  Future saveLatestSearchLocation(String search) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlzo3 + "base/doAddHistoryCariHargaTransport", {"q": search});
  }

  Future centanganGoldTransporter() async {
    var _path = "backend/get_gold_transporter_status";
    print(_urlInternal + _path);

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, null);
  }

  Future fetchListHargaTransport(
      String ID,
      String limit,
      String pageNow,
      String sortBy,
      String search,
      String sortType,
      var initData,
      var filter,
      String multiSort,
      String isFilter) async {
    if (isFilter == "false") {
      filter["min_truck_qty"] = "";
      filter["min_truck_qty"] = "";
      filter["min_capacity"] = "";
      filter["max_capacity"] = "";
      filter["harga_min"] = "";
      filter["harga_max"] = "";
      filter["category_transporter"] = "all";
      filter["capacity_unit"] = null;
      filter['head_id'] = [];
      filter["carrier_id"] = [];
    }

    print("ini filter " + filter.value.toString());

    filter['initdata'] = initData;
    print(sortBy);
    var _sendJson = {
      "Limit": limit,
      "Offset": pageNow,
      "Order": sortBy,
      "q": search,
      "OrderMode": sortType,
      "filter": jsonEncode(filter.value),
      "roleProfile": "4",
      "Multiorder": multiSort,
      "loginAs": "4",
      "isFilter": isFilter,
      "isSearch": search == "" ? "false" : "true",
      "type": "cari-harga-transport",
    };

    var _path = "api/get_list_harga";

    print("start param dikirim");
    print(_path);
    print(_sendJson);
    print("end param dikirim");

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlDevZO + _path, _sendJson);
  }

  // MANAJEMEN USER
  // halaman verify otp
  Future ubahNoWA(String newPhone, String token) async {
    var query = {
      "phone_baru": newPhone,
      "Token": token,
    };
    print("ubah no WA " + query.toString());
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "api/otp_change_hp_sub_user", query);
  }

  Future sendOTPSubUser(String phone, String otp) async {
    var query = {
      "phone": phone,
      "otp": otp,
      "App": "1",
      "verif_type": "3",
    };
    print("ubah no WA " + query.toString());
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "api/check_otp_sub_user", query);
  }

  Future resendOTPSubUser(String phone) async {
    var query = {
      "phone_baru": phone,
      "App": "1",
    };
    print("resend OTP dengan nomor " + phone);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "api/resend_otp_sub_user", query);
  }

  Future fetchListManajemenUser(
    String ID,
    String limit,
    String pageNow,
    String sortBy,
    String search,
    String sortType,
    var filter,
  ) async {
    var _sendJson = {
      "Limit": limit,
      "Offset": pageNow,
      // "Order": sortBy,
      "q": search,
      // "OrderMode": sortType,
      "filter": jsonEncode(filter),
      "UsersID": ID,
    };
    if (sortBy != "") {
      _sendJson["Order"] = sortBy;
      _sendJson["OrderMode"] = sortType;
    }

    var _path = "backend/get_list_sub_user_app";

    print("start param dikirim");
    print(_path);
    print(_sendJson);
    print("end param dikirim");

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future resendEmailManajemenUser(String subUserID) async {
    var query = {
      "SubUsersID": subUserID,
    };
    print("resend email dengan id " + subUserID);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "backend/resend_email", query);
  }

  Future fetchLatestSearchSubUser(String type) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "backend/get_all_history_manajemen_user",
        {"Type": type}); // belum ada data
  }

  Future saveLatestSearchSubUser(String search, String type) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "backend/history_manajemen_user",
        {"history_input": search, "Type": type});
  }

  Future deleteLatestSearchSubUser(id) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "backend/delete_history_manajemen_user",
        {"history_id": id});
  }

  Future deleteAllLatestSearchSubUser(String type) async {
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + "backend/delete_all_history_manajemen_user",
        {"Type": type});
  }

  Future getDropdownSubUser() async {
    var _sendJson = {"role": GlobalVariable.role};

    var _path = "backend/dropdown_bagi_peran_sub_user_apps";

    print("start param dikirim");
    print(_path);
    print(_sendJson);
    print("end param dikirim");

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future getPeriodeSubUser(url, String isNext, bool isTM) async {
    var _sendJson = {
      "Role": GlobalVariable.role,
      "IsDashboard": "true",
      "IsNext": isNext
    };

    var _path = "api/" + url;

    print("start param dikirim");
    print(_path);
    print(_sendJson);
    print("end param dikirim");

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        isTM ? _urlzo3 + _path : _url + _path, _sendJson);
  }

  Future getAllRoleSubUser(String superMenu) async {
    var _sendJson = {
      "role_profile": GlobalVariable.role,
      "super_menu": superMenu
    };

    var _path = "backend/get_all_role_user";

    print("start param dikirim");
    print(_path);
    print(_sendJson);
    print("end param dikirim");

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future getListAssignSubUser(
      url, String awal, String akhir, String search, String isNext) async {
    var _sendJson = {
      "Role": GlobalVariable.role,
      "PeriodeAwal": awal,
      "PeriodeAkhir": akhir,
      "IsDashboard": "true",
      'IsNext': isNext,
      'q': search
    };

    var _path = "api/" + url;

    print("start param dikirim");
    print(_path);
    print(_sendJson);
    print("end param dikirim");

    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future getDataUserSubscription() async {
    var url = GlobalVariable.role == "2"
        ? "backend/get_dashboard_subscription_shipper"
        : "backend/get_dashboard_subscription_transporter";
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(_url + url, null);
  }

  Future aktifNonManajemenUser(String ID, String status) async {
    var _sendJson = {
      "SubUsersID": ID,
      "status": status,
    };
    var _path = "backend/do_non_active_sub_user_app";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future createSubUser(
      String id, String name, String email, String phone) async {
    var _sendJson = null;
    if (id != "") {
      _sendJson = {"name": name, "email": email, "phone": phone, "id": id};
    } else {
      _sendJson = {"name": name, "email": email, "phone": phone};
    }
    var _path = "backend/do_add_sub_user";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, {"params": jsonEncode(_sendJson)});
  }

  Future createNewPasswordSubUser(
      String token, String password, String confirmPassword) async {
    var _sendJson = {
      "App": "1",
      "token": token,
      "password": password,
      "ulangi_password": confirmPassword
    };
    var _path = "api/active_sub_user_email";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future hapusManajemenUser(String ID) async {
    var _sendJson = {
      "SubUsersID": ID,
    };
    var _path = "backend/do_delete_sub_user";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future getNotifikasi(String loginAs) async {
    var _sendJson = {
      "loginAs": loginAs,
      "roleProfile": GlobalVariable.role,
    };
    var _path = "api/get_notifikasi_harga";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlDevZO + _path, _sendJson);
  }

  Future saveNotifikasi(
      String loginAs,
      String idpickup,
      String pickup,
      String iddestinasi,
      String destinasi,
      String idTruk,
      String namaTruk,
      String idCarrier,
      String namaCarrier,
      String namaTransporter,
      String notification) async {
    var _sendJson = {
      "loginAs": loginAs,
      "roleProfile": GlobalVariable.role,
      "from_city": idpickup,
      "from_city_name": pickup,
      "to_city": iddestinasi,
      "to_city_name": destinasi,
      "head_id": idTruk,
      "head_name": namaTruk,
      "carrier_id": idCarrier,
      "carrier_name": namaCarrier,
      "transporter_name": namaTransporter,
      "notification_type": notification,
    };
    var _path = "api/post_save_notifikasi_harga";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlDevZO + _path, _sendJson);
  }

  Future updateNotifikasi(
      String id,
      String loginAs,
      String idpickup,
      String pickup,
      String iddestinasi,
      String destinasi,
      String idTruk,
      String namaTruk,
      String idCarrier,
      String namaCarrier,
      String namaTransporter,
      String notification) async {
    var _sendJson = {
      "id": id,
      "loginAs": loginAs,
      "roleProfile": GlobalVariable.role,
      "from_city": idpickup,
      "from_city_name": pickup,
      "to_city": iddestinasi,
      "to_city_name": destinasi,
      "head_id": idTruk,
      "head_name": namaTruk,
      "carrier_id": idCarrier,
      "carrier_name": namaCarrier,
      "transporter_name": namaTransporter,
      "notification_type": notification,
    };
    var _path = "api/post_save_notifikasi_harga";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlDevZO + _path, _sendJson);
  }

  Future hapusNotifikasi(
    String loginAs,
    String id,
  ) async {
    var _sendJson = {
      "loginAs": loginAs,
      "roleProfile": GlobalVariable.role,
      "id": id,
    };
    var _path = "api/post_delete_notifikasi_harga";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlDevZO + _path, _sendJson);
  }

  Future doAssignUser(
    String PeriodeAwal,
    String PeriodeAkhir,
    String Kuota,
    String PaketID,
    String ID,
    String SubUserID,
    String RoleID,
  ) async {
    var _sendJson = {
      "PeriodeAwal": PeriodeAwal,
      "PeriodeAkhir": PeriodeAkhir,
      "Kuota": Kuota,
      "PaketID": PaketID,
      "SubUserID": SubUserID,
      "RoleID": RoleID,
    };

    if (ID != "") {
      _sendJson["ID"] = ID;
    }

    var _path = "api/do_assign_sub_user_app";

    print("ini data send json");
    print(_sendJson);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlInternal + _path, _sendJson);
  }

  Future getBanner() async {
    var _sendJson = {
      "type": (GlobalVariable.role == "2" ? "shipper_app" : "transporter_app"),
    };

    var _path = "api/get_banner";

    print("ini data send json");
    print(_sendJson);
    print(_urlDevZOBanner + _path);
    return await _fetchDataFromUrlPOSTMuatMuatAfterLogin(
        _urlDevZOBanner + _path, _sendJson);
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
