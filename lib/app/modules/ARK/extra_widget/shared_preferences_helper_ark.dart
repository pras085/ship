import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/enum/type_list_info_permintaan_muat_enum.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/manajemen_mitra/manajemen_mitra/manajemen_mitra_type_enum.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list_colors_ark.dart';

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
  static final String _userTransporterID = 'userTransporterID';
  static final String _userShipperType = 'userShipperType';
  static final String _userType = 'userShipperType';
  static final String _historySearchInfoPermintaanMuatAktifKey =
      'historyInfoPermintaanMuatAktif';
  static final String _historySearchInfoPermintaanMuatHistoryKey =
      'historyInfoPermintaanMuatHistory';
  static final String _historySearchLocationInfoPermintaanMuatKey =
      'historySearchLocationInfoPermintaanMuat';
  static final String _historySearchLocationInfoPraTenderKey =
      'historySearchLocationInfoPraTender';
  static final String _historySearchTransporter = 'historySearchTransporter';
  static final String _historySearchMitra = 'historySearchMitra';
  static final String _historySearchMitraApproveReject =
      'historySearchMitraApproveReject';
  static final String _historySearchMitraRequest = 'historySearchMitraRequest';
  static final String _historySearchMitraGrup = 'historySearchMitraGrup';
  static final String _areaPickupLastSearchCity = 'areaPickupLastSearchCity';
  static final String _areaPickupLastSearchDistrict =
      'areaPickupLastSearchDistrict';
  static final String _areaPickupLastTransactionCity =
      'areaPickupLastTransactionCity';
  static final String _areaPickupLastTransactionDistrict =
      'areaPickupLastTransactionDistrict';
  static final String tenderPertamaKali = 'tenderPertamaKali';
  static final String infoPraTenderPertamaKali = 'infoPraTenderPertamaKali';
  static final String infoPraTenderYellowPopUp = 'infoPraTenderYellowPopUp';

  static final String cariHargaTransportPertamaKali =
      'cariHargaTransportPertamaKali';

  static final String historyInfoPraTenderAktif = 'infoPraTenderAktif';
  static final String historyInfoPraTenderHistory = 'infoPraTenderHistory';

  static final String prosesTenderPertamaKali = 'prosesTenderPertamaKali';
  static final String prosesTenderYellowPopUp = 'prosesTenderYellowPopUp';

  static final String historyProsesTenderAktif = 'prosesTenderAktif';
  static final String historyProsesTenderHistory = 'prosesTenderHistory';

  static final String pemenangTenderPertamaKali = 'pemenangTenderPertamaKali';
  static final String pemenangTenderYellowPopUp = 'pemenangTenderYellowPopUp';

  static final String historyPemenangTenderBelumDiumumkan =
      'pemenangTenderBelumDiumumkan';
  static final String historyPemenangTenderDiumumkan =
      'pemenangTenderDiumumkan';

  static final String historyLihatPeserta = 'lihatPeserta';

  static final String dataPemenang = 'dataPemenang';

  static final String hakAkses = 'hakAkses';

  static Future setHistorySearchManajemenMitra(
      String json, TypeMitra typeMitra) async {
    await _init();
    String key = "";
    if (typeMitra == TypeMitra.GROUP_MITRA) {
      key = _historySearchMitraGrup;
    } else if (typeMitra == TypeMitra.APPROVE_MITRA)
      key = _historySearchMitraApproveReject;
    else if (typeMitra == TypeMitra.REQUEST_MITRA)
      key = _historySearchMitraRequest;
    else
      key = _historySearchMitra;
    _sharedPreferences.setString(key, json);
  }

  static Future<String> getHistorySearchManajemenMitra(
      TypeMitra typeMitra) async {
    await _init();
    String key = "";
    if (typeMitra == TypeMitra.GROUP_MITRA) {
      key = _historySearchMitraGrup;
    } else if (typeMitra == TypeMitra.APPROVE_MITRA)
      key = _historySearchMitraApproveReject;
    else if (typeMitra == TypeMitra.REQUEST_MITRA)
      key = _historySearchMitraRequest;
    else
      key = _historySearchMitra;
    String result = _sharedPreferences.getString(key) ?? "";
    return result;
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

  static Future setHistorySearchLihatPeserta(String json) async {
    await _init();
    _sharedPreferences.setString(historyLihatPeserta, json);
  }

  static Future<String> getHistorySearchLihatPeserta() async {
    await _init();
    String result = _sharedPreferences.getString(historyLihatPeserta) ?? "";
    return result;
  }

  static Future setHakAkses() async {
    await _init();
    print('GET AKSES');
    var resultAkses = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getAllHakAkses();

    if (resultAkses != null && resultAkses['Message'] != null && resultAkses['Message']['Code'].toString() == '200') {
      var data = resultAkses['Data'];
      print(data);
      _sharedPreferences.setString(hakAkses, jsonEncode(data));
    }
  }

  static Future<bool> getHakAkses(String nama,
      {bool denganLoading = false}) async {
    if (denganLoading) {
      showDialog(
          context: Get.context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          });
    }

    print(nama);

    var valid = true;

    if (GlobalVariable.subUser) {
      //DI SET LAGI KARENA, KADANG TIDAK ADA DI AKSES
      await SharedPreferencesHelper.setHakAkses();
      await _init();
      var list = _sharedPreferences.getString(hakAkses) == null
          ? []
          : jsonDecode(_sharedPreferences.getString(hakAkses));

      if (list.length == 0) {
        valid = false;
        print('TIDAK ADA DATA');
      } else if (list
              .where((element) => element["Menu"] == nama)
              .toList()
              .length ==
          0) {
        valid = false;
        print('NAMANYA TIDAK ADA');
      }

      if (valid) {
        var ID = list.where((element) => element["Menu"] == nama).toList()[0]
            ['ID']; //nama
        print(ID);
        var resultAkses = await ApiHelper(
                context: Get.context,
                isShowDialogLoading: false,
                isShowDialogError: false)
            .getHakAkses(ID.toString());

        if (resultAkses['Message']['Code'].toString() == '200') {
          var data = resultAkses['Data'];
          print(data);
          if (denganLoading) {
            Get.back();
          }
          return data['Message'];
        }
      } else {
        if (denganLoading) {
          Get.back();
        }
        return false;
      }
    }
    if (denganLoading) {
      Get.back();
    }
    return true;
  }

  static bool cekAkses(bool cek) {
    if (!cek) {
      GlobalVariable.alertNoAksesWidget();
    }
    return cek;
  }

  static Future setHistorySearchInfoPraTender(
      String json, String jenisInfoPraTender) async {
    await _init();
    _sharedPreferences.setString(
        jenisInfoPraTender == "Aktif"
            ? historyInfoPraTenderAktif
            : historyInfoPraTenderHistory,
        json);
  }

  static Future<String> getHistorySearchInfoPraTender(
      String jenisInfoPraTender) async {
    await _init();
    String result = _sharedPreferences.getString(jenisInfoPraTender == "Aktif"
            ? historyInfoPraTenderAktif
            : historyInfoPraTenderHistory) ??
        "";
    return result;
  }

  static Future setDataPemenang(String json) async {
    await _init();
    _sharedPreferences.setString(dataPemenang, json);
  }

  static Future<String> getDataPemenang() async {
    await _init();
    String result = _sharedPreferences.getString(dataPemenang) ?? "";
    return result;
  }

  static Future setHistorySearchProsesTender(
      String json, String jenisProsesTender) async {
    await _init();
    _sharedPreferences.setString(
        jenisProsesTender == "Aktif"
            ? historyProsesTenderAktif
            : historyProsesTenderHistory,
        json);
  }

  static Future<String> getHistorySearchProsesTender(
      String jenisProsesTender) async {
    await _init();
    String result = _sharedPreferences.getString(jenisProsesTender == "Aktif"
            ? historyProsesTenderAktif
            : historyProsesTenderHistory) ??
        "";
    return result;
  }

  static Future setHistorySearchPemenangTender(
      String json, String jenisProsesTender) async {
    await _init();
    _sharedPreferences.setString(
        jenisProsesTender == "Belum Diumumkan"
            ? historyPemenangTenderBelumDiumumkan
            : historyPemenangTenderDiumumkan,
        json);
  }

  static Future<String> getHistorySearchPemenangTender(
      String jenisProsesTender) async {
    await _init();
    String result = _sharedPreferences.getString(
            jenisProsesTender == "Belum Diumumkan"
                ? historyPemenangTenderBelumDiumumkan
                : historyPemenangTenderDiumumkan) ??
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

  static Future setUserTransporterID(String userType) async {
    await _init();
    _sharedPreferences.setString(_userTransporterID, userType);
  }

  static Future getUserTransporterID() async {
    await _init();
    String userType = _sharedPreferences.getString(_userTransporterID) ?? "";
    return userType;
  }

  static Future setUserType(String userType) async {
    await _init();
    _sharedPreferences.setString(_userType, userType);
  }

  static Future getUserType() async {
    await _init();
    String userType = _sharedPreferences.getString(_userType) ?? "";
    return userType;
  }

  static Future getUserID() async {
    await _init();
    String userType = _sharedPreferences.getString(_docIDKey) ?? "";
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
    setHistorySearchLocationInfoPraTender("");
    setHistoryTransporter("");
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
  }

  static Future setTenderPertamaKali(bool status) async {
    await _init();
    _sharedPreferences.setBool(tenderPertamaKali, status);
  }

  static Future getTenderPertamaKali() async {
    await _init();
    bool hasil = _sharedPreferences.getBool(tenderPertamaKali) ?? true;
    return hasil;
  }

  static Future setInfoPraTenderPertamaKali(bool status) async {
    await _init();
    _sharedPreferences.setBool(infoPraTenderPertamaKali, status);
  }

  static Future getInfoPraTenderPertamaKali() async {
    await _init();
    bool hasil = _sharedPreferences.getBool(infoPraTenderPertamaKali) ?? true;
    return hasil;
  }

  static Future setCariHargaTransportPertamaKali(bool status) async {
    await _init();
    _sharedPreferences.setBool(cariHargaTransportPertamaKali, status);
  }

  static Future getCariHargaTransportPertamaKali() async {
    await _init();
    bool hasil =
        _sharedPreferences.getBool(cariHargaTransportPertamaKali) ?? true;
    return hasil;
  }

  static Future setInfoPraTenderYellowPopUp(bool status) async {
    await _init();
    _sharedPreferences.setBool(infoPraTenderYellowPopUp, status);
  }

  static Future getInfoPraTenderYellowPopUp() async {
    await _init();
    bool hasil = _sharedPreferences.getBool(infoPraTenderYellowPopUp) ?? true;
    return hasil;
  }

  static Future setProsesTenderPertamaKali(bool status) async {
    await _init();
    _sharedPreferences.setBool(prosesTenderPertamaKali, status);
  }

  static Future getProsesTenderPertamaKali() async {
    await _init();
    bool hasil = _sharedPreferences.getBool(prosesTenderPertamaKali) ?? true;
    return hasil;
  }

  static Future setProsesTenderYellowPopUp(bool status) async {
    await _init();
    _sharedPreferences.setBool(prosesTenderYellowPopUp, status);
  }

  static Future getProsesTenderYellowPopUp() async {
    await _init();
    bool hasil = _sharedPreferences.getBool(prosesTenderYellowPopUp) ?? true;
    return hasil;
  }

  static Future setPemenangTenderPertamaKali(bool status) async {
    await _init();
    _sharedPreferences.setBool(pemenangTenderPertamaKali, status);
  }

  static Future getPemenangTenderPertamaKali() async {
    await _init();
    bool hasil = _sharedPreferences.getBool(pemenangTenderPertamaKali) ?? true;
    return hasil;
  }

  static Future setPemenangTenderYellowPopUp(bool status) async {
    await _init();
    _sharedPreferences.setBool(pemenangTenderYellowPopUp, status);
  }

  static Future getPemenangTenderYellowPopUp() async {
    await _init();
    bool hasil = _sharedPreferences.getBool(pemenangTenderYellowPopUp) ?? true;
    return hasil;
  }

  static Future setHistorySearchLocationInfoPermintaanMuat(String json) async {
    await _init();
    _sharedPreferences.setString(
        _historySearchLocationInfoPermintaanMuatKey, json);
  }

  static Future setHistorySearchLocationInfoPraTender(String json) async {
    await _init();
    _sharedPreferences.setString(_historySearchLocationInfoPraTenderKey, json);
  }

  static Future<String> getHistorySearchLocationInfoPermintaanMuat() async {
    await _init();
    String result = _sharedPreferences
            .getString(_historySearchLocationInfoPermintaanMuatKey) ??
        "";
    return result;
  }

  static Future<String> getHistorySearchLocationInfoPraTender() async {
    await _init();
    String result =
        _sharedPreferences.getString(_historySearchLocationInfoPraTenderKey) ??
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
}
