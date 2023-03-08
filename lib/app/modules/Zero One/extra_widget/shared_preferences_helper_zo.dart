import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/enum/type_list_info_permintaan_muat_enum.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart' as gvark;


class SharedPreferencesHelper {
  static SharedPreferences _sharedPreferences;
  static final String _docIDKey = 'docID';
  static final String _nameKey = 'name';
  static final String _emailKey = 'email';
  static final String _passwordKey = 'password';
  static final String _isGoogleKey = 'isGoogle';
  static final String _tokenAppKey = 'tokenApp';
  static final String _userModelGlobalKey = 'userModelGlobal';
  static final String _userShipperID = 'userShipperID';
  static final String _userShipperType = 'userShipperType';
  static final String _historySearchInfoPermintaanMuatAktifKey =
      'historyInfoPermintaanMuatAktif';
  static final String _historySearchInfoPermintaanMuatHistoryKey =
      'historyInfoPermintaanMuatHistory';
  static final String _historySearchLocationInfoPermintaanMuatKey =
      'historySearchLocationInfoPermintaanMuat';
  static final String _historySearchLocationAddEditManajemenLokasiKey =
      'historySearchLocationAddEditManajemenLokasi';
  static final String _historySearchTransporter = 'historySearchTransporter';
  static final String _historySearchManagementLokasi =
      'historySearchManagementLokasi';
  static final String _historySearchSubscriptionBF =
      'historySearchSubscriptionBF';
  static final String _historySearchSubscriptionSU =
      'historySearchSubscriptionSU';
  static final String _historySearchSubscriptionMenungguPembayaran =
      'historySearchSubscriptionMenungguPembayaran';
  static final String _subscriptionKeuntunganBerlangganan =
      '_subscriptionKeuntunganBerlangganan';
  static final String _historySearchMitra = 'historySearchMitra';
  static final String _historySearchMitraApproveReject =
      'historySearchMitraApproveReject';
  static final String _historySearchMitraRequest = 'historySearchMitraRequest';
  static final String _historySearchMitraGrup = 'historySearchMitraGrup';
  static final String _areaPickupLastSearchCity = 'areaPickupLastSearchCity';
  static final String _lastSearchLelangMuatan = 'lastSearchLelangMuatan';
  static final String _lastSearchLelangMuatanHistory =
      'lastSearchLelangMuatanHistory';
  static final String _lastSearchManajementPromo = 'lastSearchManajementPromo';
  static final String _lastSearchManajementPromoHistory =
      'lastSearchManajementPromoHistory';
  static final String _areaPickupLastSearchDistrict =
      'areaPickupLastSearchDistrict';
  static final String _areaPickupLastTransactionCity =
      'areaPickupLastTransactionCity';
  static final String _areaPickupLastTransactionDistrict =
      'areaPickupLastTransactionDistrict';
  static final String _firstTimeSubscriptionTAC = 'firstTimeSubscriptionTAC';
  static final String _historySearchOrderHistorySubscription =
      'historySearchOrderHistorySubscription';
  static final String _isThereDataOrderHistorySubscription =
      'isThereDataOrderHistorySubscription';

  static final String _firstTimeLelangMuatan = 'firstTimeLelangMuatan';
  static final String _promoTransporterFirstTimerKey =
      'firstTimePromoTransporter';
  static final String _promoTransporterLatestSearchKey =
      'latestSearchPromoTransporter';

  static Future<bool> setFirstTimePromoTransporter(bool value) async {
    await _init();
    return _sharedPreferences.setBool(
        '$_promoTransporterFirstTimerKey-${GlobalVariable.docID}', value);
  }

  static Future<bool> getFirstTimePromoTransporter() async {
    await _init();
    return _sharedPreferences.getBool(
            '$_promoTransporterFirstTimerKey-${GlobalVariable.docID}') ??
        true;
  }

  static Future<bool> setLatestSearchPromoTransporter(
    Map<String, dynamic> json,
  ) async {
    String key = '$_promoTransporterLatestSearchKey-${GlobalVariable.docID}';
    String value = json == null ? json : jsonEncode(json);

    await _init();

    return _sharedPreferences.setString(key, value);
  }

  static Future<Map<String, dynamic>> getLatestSearchPromoTransporter() async {
    await _init();

    var key = '$_promoTransporterLatestSearchKey-${GlobalVariable.docID}';
    var value = _sharedPreferences.getString(key) ?? "";

    if (value?.trim()?.isEmpty ?? true) return null;

    return jsonDecode(value);
  }

  static Future setHistorySearchInfoPermintaanMuat(String json,
      TypeListInfoPermintaanMuat typeListInfoPermintaanMuat) async {
    await _init();
    _sharedPreferences.setString(
        typeListInfoPermintaanMuat == TypeListInfoPermintaanMuat.AKTIF
            ? _historySearchInfoPermintaanMuatAktifKey
            : _historySearchInfoPermintaanMuatHistoryKey,
        json);
  }

  static Future<String> getHistorySearchInfoPermintaanMuat(
      TypeListInfoPermintaanMuat typeListInfoPermintaanMuat) async {
    await _init();
    String result = _sharedPreferences.getString(
            typeListInfoPermintaanMuat == TypeListInfoPermintaanMuat.AKTIF
                ? _historySearchInfoPermintaanMuatAktifKey
                : _historySearchInfoPermintaanMuatHistoryKey) ??
        "";
    return result;
  }

  static Future setStatusIntro(bool isAlreadyIntro) async {
    await _init();
    _sharedPreferences.setBool("isAlreadyIntro", isAlreadyIntro);
  }

  static Future getStatusIntro() async {
    await _init();
    bool isStatusIntro = _sharedPreferences.getBool("isAlreadyIntro") ?? true;
    return isStatusIntro;
  }

  static Future setUserShipperID(String userType) async {
    await _init();
    _sharedPreferences.setString(_userShipperID, userType);
  }

  static Future getUserShipperID() async {
    await _init();
    String userType = _sharedPreferences.getString(_userShipperID) ?? "";
    return userType;
  }

  static Future setUserLogin(UserModel user) async {
    await _init();
    _sharedPreferences.setString(_emailKey, user.email);
    _sharedPreferences.setString(_passwordKey, user.password);
    _sharedPreferences.setBool(_isGoogleKey, user.isGoogle);
    _sharedPreferences.setString(_tokenAppKey, GlobalVariable.tokenApp);
    _sharedPreferences.setString(_docIDKey, user.docID);
    _sharedPreferences.setString(_nameKey, user.name);
    _setUserToGlobal(user, GlobalVariable.tokenApp);
    _sharedPreferences.setString(_userModelGlobalKey, jsonEncode(user));
  }

  static Future setLogOut() async {
    await _init();
    UserModel user = UserModel();
    _sharedPreferences.setString(_emailKey, user.email);
    _sharedPreferences.setString(_passwordKey, user.password);
    _sharedPreferences.setBool(_isGoogleKey, user.isGoogle);
    _sharedPreferences.setString(_tokenAppKey, "");
    _sharedPreferences.setString(_docIDKey, "");
    _sharedPreferences.setString(_nameKey, "");
    setUserShipperID("");
    _setUserToGlobal(user, "");
    setHistorySearchInfoPermintaanMuat("", TypeListInfoPermintaanMuat.AKTIF);
    setHistorySearchInfoPermintaanMuat("", TypeListInfoPermintaanMuat.HISTORY);
    setHistorySearchLocationInfoPermintaanMuat("");
    setHistoryTransporter("");
    setFirstTimeSubscriptionTAC(true);
    setIsThereDataOrderHistorySubscription(false);
  }

  static Future getUserLogin(Function functionTryAgain) async {
    await _init();
    String email = _sharedPreferences.getString(_emailKey) ?? "";
    String password = _sharedPreferences.getString(_passwordKey) ?? "";
    bool isGoogle = _sharedPreferences.getBool(_isGoogleKey) ?? false;
    String tokenApp = _sharedPreferences.getString(_tokenAppKey) ?? "";
    String name = _sharedPreferences.getString(_nameKey) ?? "";
    String docID = _sharedPreferences.getString(_docIDKey) ?? "";
    UserModel userModelGlobal;
    try {
      var result = _sharedPreferences.getString(_userModelGlobalKey) ?? "";
      if (result != "")
        userModelGlobal = UserModel.fromJson(jsonDecode(result), false);
    } catch (err) {
      userModelGlobal = null;
    }
    if (email != "" && tokenApp != "") {
      // UserModel userModel = UserModel(
      //     email: email,
      //     password: password,
      //     isGoogle: isGoogle,
      //     name: name,
      //     docID: docID);
      if (userModelGlobal == null) {
        userModelGlobal = UserModel(
            email: email,
            password: password,
            isGoogle: isGoogle,
            name: name,
            docID: docID);
      }
      UserModel userModel;
      if (_isCheckNewVariable(userModelGlobal)) {
        userModel = await _loginUser(userModelGlobal, functionTryAgain);
      } else {
        userModel = userModelGlobal;
      }
      if (userModel == null)
        return;
      else {
        userModelGlobal.setForUserModelGlobal(userModel);
        GlobalVariable.tokenApp = tokenApp;
        gvark.GlobalVariable.tokenApp = tokenApp;
        gvark.GlobalVariable.emailLogin = email;
        gvark.GlobalVariable.docID = docID;
        gvark.GlobalVariable.userModelGlobal = userModel;
        setUserLogin(userModelGlobal);
        return true;
      }
    }
    return false;
  }

  static Future _loginUser(
    UserModel user,
    Function functionConfirmBtn,
  ) async {
    LoginFunction loginFunction = LoginFunction();
    await loginFunction.loginUser(user, false, Get.context, true);
    if (loginFunction.isSuccess) {
      user = loginFunction.userModel;
      return user;
    } else {
      GlobalAlertDialog.showDialogError(
          message: loginFunction.messageError,
          context: Get.context,
          onTapPriority1: functionConfirmBtn,
          labelButtonPriority1: "Try Again",
          onTapPriority2: () {
            SystemNavigator.pop();
          },
          labelButtonPriority2: "Exit");
      return;
    }
  }

  static bool _isCheckNewVariable(UserModel userModel) {
    String docID = userModel.docID;
    String name = userModel.name;
    String phone = userModel.phone;

    return docID == "" || name == "" || phone == "";
  }

  static _setUserToGlobal(UserModel user, String tokenApp) {
    GlobalVariable.docID = user.docID;
    GlobalVariable.name = user.name;
    GlobalVariable.emailLogin = user.email;
    GlobalVariable.passwordLogin = user.password;
    GlobalVariable.isGoogleLogin = user.isGoogle;
    GlobalVariable.tokenApp = tokenApp;
    GlobalVariable.userModelGlobal = user;

    gvark.GlobalVariable.docID = user.docID;
    gvark.GlobalVariable.name = user.name;
    gvark.GlobalVariable.emailLogin = user.email;
    gvark.GlobalVariable.passwordLogin = user.password;
    gvark.GlobalVariable.isGoogleLogin = user.isGoogle;
    gvark.GlobalVariable.tokenApp = tokenApp;
    gvark.GlobalVariable.userModelGlobal = user;
  }

  static Future _init() async {
    if (_sharedPreferences == null)
      _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future setStringVariable(String key, String value) async {
    await _init();
    _sharedPreferences.setString(key, value);
  }

  static Future getStringVariable(String key) async {
    await _init();
    String stringVariable = _sharedPreferences.getString(key) ?? "";
    return stringVariable;
  }

  static Future setLanguage(
      String idLanguage, String typeLanguage, String nameLanguage) async {
    await _init();
    _sharedPreferences.setString("IDLanguage", idLanguage);
    _sharedPreferences.setString("TypeLanguage", typeLanguage);
    _sharedPreferences.setString("NameLanguage", nameLanguage);
    GlobalVariable.languageCode = idLanguage;
    GlobalVariable.languageType = typeLanguage;
    GlobalVariable.languageName = nameLanguage;
    gvark.GlobalVariable.languageCode = idLanguage;
    gvark.GlobalVariable.languageType = typeLanguage;
    gvark.GlobalVariable.languageName = nameLanguage;
    await getLanguage();
  }

  static Future getLanguage() async {
    await _init();
    String idLanguage = _sharedPreferences.getString("IDLanguage") ?? "";
    String typeLanguage = _sharedPreferences.getString("TypeLanguage") ?? "";
    String nameLanguage = _sharedPreferences.getString("NameLanguage") ?? "";
    GlobalVariable.languageCode = idLanguage;
    GlobalVariable.languageType = typeLanguage;
    GlobalVariable.languageName = nameLanguage;
    gvark.GlobalVariable.languageCode = idLanguage;
    gvark.GlobalVariable.languageType = typeLanguage;
    gvark.GlobalVariable.languageName = nameLanguage;
  }

  static Future setHistorySearchLocationInfoPermintaanMuat(String json) async {
    await _init();
    _sharedPreferences.setString(
        _historySearchLocationInfoPermintaanMuatKey, json);
  }

  static Future<String> getHistorySearchLocationInfoPermintaanMuat() async {
    await _init();
    String result = _sharedPreferences
            .getString(_historySearchLocationInfoPermintaanMuatKey) ??
        "";
    return result;
  }

  static Future setHistoryTransporter(String json) async {
    await _init();
    _sharedPreferences.setString(_historySearchTransporter, json);
  }

  static Future<String> getHistoryTransporter() async {
    await _init();
    String result =
        _sharedPreferences.getString(_historySearchTransporter) ?? "";
    return result;
  }

  static Future setHistoryManagementLokasi(String json) async {
    await _init();
    _sharedPreferences.setString(_historySearchManagementLokasi, json);
  }

  static Future<String> getHistoryManagementLokasi() async {
    await _init();
    String result =
        _sharedPreferences.getString(_historySearchManagementLokasi) ?? "";
    return result;
  }

  static Future setHistorySubscriptionBF(String json) async {
    await _init();
    _sharedPreferences.setString(_historySearchSubscriptionBF, json);
  }

  static Future<String> getHistorySubscriptionBF() async {
    await _init();
    String result =
        _sharedPreferences.getString(_historySearchSubscriptionBF) ?? "";
    return result;
  }

  static Future setHistorySubscriptionSU(String json) async {
    await _init();
    _sharedPreferences.setString(_historySearchSubscriptionSU, json);
  }

  static Future<String> getHistorySubscriptionSU() async {
    await _init();
    String result =
        _sharedPreferences.getString(_historySearchSubscriptionSU) ?? "";
    return result;
  }

  static Future setHistorySubscriptionMenungguPembayaran(String json) async {
    await _init();
    _sharedPreferences.setString(
        _historySearchSubscriptionMenungguPembayaran, json);
  }

  static Future<String> getHistorySubscriptionMenungguPembayaran() async {
    await _init();
    String result = _sharedPreferences
            .getString(_historySearchSubscriptionMenungguPembayaran) ??
        "";
    return result;
  }

  static Future setHistorySearchOrderHistorySubscription(String json) async {
    await _init();
    _sharedPreferences.setString(_historySearchOrderHistorySubscription, json);
  }

  static Future<String> getHistorySearchOrderHistorySubscription() async {
    await _init();
    String result =
        _sharedPreferences.getString(_historySearchOrderHistorySubscription) ??
            "";
    return result;
  }

  static Future setSubscriptionKeuntunganBerlangganan(bool activated) async {
    await _init();
    _sharedPreferences.setBool(_subscriptionKeuntunganBerlangganan, activated);
  }

  static Future<bool> getSubscriptionKeuntunganBerlangganan() async {
    await _init();
    bool result =
        _sharedPreferences.getBool(_subscriptionKeuntunganBerlangganan) ??
            false;
    return result;
  }

  static Future setAreaPickupLastSearchCity(Map value) async {
    await _init();
    _sharedPreferences.setString(_areaPickupLastSearchCity, jsonEncode(value));
  }

  static Future<String> getAreaPickupLastSearchCity() async {
    await _init();
    String value =
        _sharedPreferences.getString(_areaPickupLastSearchCity) ?? "";
    return value;
  }

  static Future setLastSearchLelangMuatan(List value) async {
    await _init();
    _sharedPreferences.setString(_lastSearchLelangMuatan, jsonEncode(value));
  }

  static Future getLastSearchLelangMuatan() async {
    await _init();
    var value = _sharedPreferences.getString(_lastSearchLelangMuatan) ?? "";
    return jsonDecode(value);
  }

  static Future setLastSearchManajementPromo(List value) async {
    await _init();
    _sharedPreferences.setString(_lastSearchManajementPromo, jsonEncode(value));
  }

  static Future getLastSearchManajementPromo() async {
    await _init();
    var value = _sharedPreferences.getString(_lastSearchManajementPromo) ?? "";
    return jsonDecode(value);
  }

  static Future setLastSearchManajementPromoHistory(List value) async {
    await _init();
    _sharedPreferences.setString(
        _lastSearchManajementPromoHistory, jsonEncode(value));
  }

  static Future getLastSearchManajementPromoHistory() async {
    await _init();
    var value =
        _sharedPreferences.getString(_lastSearchManajementPromoHistory) ?? "";
    return jsonDecode(value);
  }

  static Future setLastSearchLelangMuatanHistory(List value) async {
    await _init();
    _sharedPreferences.setString(
        _lastSearchLelangMuatanHistory, jsonEncode(value));
  }

  static Future getLastSearchLelangMuatanHistory() async {
    await _init();
    var value =
        _sharedPreferences.getString(_lastSearchLelangMuatanHistory) ?? "";
    return jsonDecode(value);
  }

  static Future setAreaPickupLastSearchDistrict(Map value) async {
    await _init();
    _sharedPreferences.setString(
        _areaPickupLastSearchDistrict, jsonEncode(value));
  }

  static Future<String> getAreaPickupLastSearchDistrict() async {
    await _init();
    String value =
        _sharedPreferences.getString(_areaPickupLastSearchDistrict) ?? "";
    return value;
  }

  static Future setAreaPickupLastTransactionCity(Map value) async {
    await _init();
    _sharedPreferences.setString(
        _areaPickupLastTransactionCity, jsonEncode(value));
  }

  static Future<String> getAreaPickupLastTransactionCity() async {
    await _init();
    String value =
        _sharedPreferences.getString(_areaPickupLastTransactionCity) ?? "";
    return value;
  }

  static Future setAreaPickupLastTransactionDistrict(Map value) async {
    await _init();
    _sharedPreferences.setString(
        _areaPickupLastTransactionDistrict, jsonEncode(value));
  }

  static Future<String> getAreaPickupLastTransactionDistrict() async {
    await _init();
    String value =
        _sharedPreferences.getString(_areaPickupLastTransactionDistrict) ?? "";
    return value;
  }

  static Future<UserModel> getUserModel() async {
    await _init();
    UserModel userModelGlobal;
    try {
      var result = _sharedPreferences.getString(_userModelGlobalKey) ?? "";
      if (result != "")
        userModelGlobal = UserModel.fromJson(jsonDecode(result), false);
    } catch (err) {
      userModelGlobal = null;
    }
    return userModelGlobal;
  }

  static Future setHistorySearchLocationAddEditManajemenLokasi(
      String json) async {
    await _init();
    _sharedPreferences.setString(
        _historySearchLocationAddEditManajemenLokasiKey, json);
  }

  static Future<String> getHistorySearchLocationAddEditManajemenLokasi() async {
    await _init();
    String result = _sharedPreferences
            .getString(_historySearchLocationAddEditManajemenLokasiKey) ??
        "";
    return result;
  }

  static Future setFirstTimeSubscriptionTAC(bool isFirstTime) async {
    await _init();
    await _sharedPreferences.setBool(_firstTimeSubscriptionTAC, isFirstTime);
  }

  static Future<bool> getFirstTimeSubscriptionTAC() async {
    await _init();
    bool result = _sharedPreferences.getBool(_firstTimeSubscriptionTAC) ?? true;
    return result;
  }

  static Future setIsThereDataOrderHistorySubscription(bool isFirstTime) async {
    await _init();
    await _sharedPreferences.setBool(
        _isThereDataOrderHistorySubscription, isFirstTime);
  }

  static Future<bool> getIsThereDataOrderHistorySubscription() async {
    await _init();
    bool result =
        _sharedPreferences.getBool(_isThereDataOrderHistorySubscription) ??
            false;
    return result;
  }

  static Future setFirstTimeLelangMuatan(bool isFirstTime) async {
    await _init();
    await _sharedPreferences.setBool(_firstTimeLelangMuatan, isFirstTime);
  }

  static Future<bool> getFirstTimeLelangMuatan() async {
    await _init();
    bool result = _sharedPreferences.getBool(_firstTimeLelangMuatan) ?? true;
    return result;
  }
}
