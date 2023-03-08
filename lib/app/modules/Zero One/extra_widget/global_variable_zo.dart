import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:latlong/latlong.dart';

class GlobalVariable {
  static String name = "";
  static String docID = "";
  static String emailLogin = "";
  static String passwordLogin = "";
  static String tokenApp = "";
  static String languageCode = "";
  static String languageType = "";
  static String languageName = "";
  static bool isGoogleLogin = false;
  static bool isDebugMode = false;
  static LatLng centerMap = LatLng(-7.25143, 112.75079);
  static double zoomMap = 15.0;
  static UserModel userModelGlobal = UserModel();
  static int loginVersion = 0;
  static int timeoutToken = 0;
  static final String role = "2";
  // static final String urlImage = "https://devintern.assetlogistik.com/assets/";
  static final String urlImage = "https://qc.assetlogistik.com/assets/";
  static final Size preferredSizeAppBar = Size.fromHeight(64);
  //Profile Shipper

  static double ratioWidth(BuildContext context) {
    return MediaQuery.of(context).size.width / 360;
  }

  // static double ratioHeight(BuildContext context) {
  //   return MediaQuery.of(context).size.height / 698;
  // }

  static double ratioFontSize(BuildContext context) {
    return ratioWidth(context);
  }

  static void showMessageToastDebug(String message) {
    if (isDebugMode) Fluttertoast.showToast(msg: message);
  }
}
