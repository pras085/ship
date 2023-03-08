import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:flutter_map/flutter_map.dart';

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
  static TileLayerOptions tileLayerOptions = TileLayerOptions(
    urlTemplate:
        "https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
    subdomains: ['mt0','mt1','mt2','mt3']);
    // urlTemplate:
    //     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    // subdomains: ['a', 'b', 'c']);
  // PENYESUAIAN GOOGLE
  static bool isGoogleRegister = false;
  static bool isDebugMode = false;
  static bool isSuperDebugMode = false;
  static LatLng centerMap = LatLng(-7.25143, 112.75079);
  static double zoomMap = 15.0;
  static UserModel userModelGlobal = UserModel();
  static int loginVersion = 0;
  static int timeoutToken = 0;
  static final String role = "2";
  static final String urlImage = "${ApiHelper.urlInternal}assets/";
  static final Size preferredSizeAppBar = Size.fromHeight(64);
  static final String urlImageTemplateBuyer = "assets/template_buyer/";
  static String imagePath = "assets/";
  static String fcmToken = "";

  //Profile Shipper

  static double ratioWidth(BuildContext context) {
    return MediaQuery.of(context).size.width / 360;
  }

  static double ratioHeight(BuildContext context) {
    return MediaQuery.of(context).size.height / 698;
  }

  static double ratioFontSize(BuildContext context) {
    // return 103.5 / 100;
    return ratioWidth(context);
  }

  static void showMessageToastDebug(String message) {
    if (isDebugMode) Fluttertoast.showToast(msg: message);
  }

  static GoogleSignIn googleSignIn = GoogleSignIn();
  static GoogleSignInAccount user;
}
