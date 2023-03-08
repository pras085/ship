import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:validators/sanitizers.dart';

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
  static bool isSuperDebugMode = false;
  static LatLng centerMap = LatLng(-7.25143, 112.75079);
  static double zoomMap = 15.0;
  static UserModel userModelGlobal = UserModel();
  static int loginVersion = 0;
  static int timeoutToken = 0;
  static final String role = "2";
  static final String roleName = "Shipper";
  static final String urlImage = "https://internalqc.assetlogistik.com/assets/";
  static final String urlFile = "https://internalqc.assetlogistik.com";
  static final String urlBF = "https://internalqc.assetlogistik.com";
  static final String urlTM =
      "https://zo3.assetlogistik.com/"; //https://devzo.assetlogistik.com
  static final Size preferredSizeAppBar = Size.fromHeight(64);
  static String imagePath = "assets/";
  static String imagePathArk = "lib/app/modules/ARK/assets/";

  static String regexToRemoveEmoji =
      "   /\uD83C\uDFF4\uDB40\uDC67\uDB40\uDC62(?:\uDB40\uDC77\uDB40\uDC6C\uDB40\uDC73|\uDB40\uDC73\uDB40\uDC63\uDB40\uDC74|\uDB40\uDC65\uDB40\uDC6E\uDB40\uDC67)\uDB40\uDC7F|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC68(?:\uD83C\uDFFF\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFE])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFC-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D)?\uD83D\uDC68|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D[\uDC66\uDC67])|[\u2695\u2696\u2708]\uFE0F|\uD83D[\uDC66\uDC67]|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708])\uFE0F|\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69(?:\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D(?:\uD83D[\uDC68\uDC69])|\uD83D[\uDC68\uDC69])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFF\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69\uD83C\uDFFF\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFE])|\uD83D\uDC69\uD83C\uDFFE\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83D\uDC69\uD83C\uDFFD\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83D\uDC69\uD83C\uDFFC\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83D\uDC69\uD83C\uDFFB\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFC-\uDFFF])|\uD83D\uDC69\u200D\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D\uDC41\uFE0F\u200D\uD83D\uDDE8|\uD83D\uDC69(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83C\uDFF3\uFE0F\u200D\u26A7|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83D\uDC3B\u200D\u2744|(?:(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF])\u200D[\u2640\u2642]|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])\u200D[\u2640\u2642]|\uD83C\uDFF4\u200D\u2620|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])\u200D[\u2640\u2642]|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u2328\u23CF\u23ED-\u23EF\u23F1\u23F2\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB\u25FC\u2600-\u2604\u260E\u2611\u2618\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u2692\u2694-\u2697\u2699\u269B\u269C\u26A0\u26A7\u26B0\u26B1\u26C8\u26CF\u26D1\u26D3\u26E9\u26F0\u26F1\u26F4\u26F7\u26F8\u2702\u2708\u2709\u270F\u2712\u2714\u2716\u271D\u2721\u2733\u2734\u2744\u2747\u2763\u2764\u27A1\u2934\u2935\u2B05-\u2B07\u3030\u303D\u3297\u3299]|\uD83C[\uDD70\uDD71\uDD7E\uDD7F\uDE02\uDE37\uDF21\uDF24-\uDF2C\uDF36\uDF7D\uDF96\uDF97\uDF99-\uDF9B\uDF9E\uDF9F\uDFCD\uDFCE\uDFD4-\uDFDF\uDFF5\uDFF7]|\uD83D[\uDC3F\uDCFD\uDD49\uDD4A\uDD6F\uDD70\uDD73\uDD76-\uDD79\uDD87\uDD8A-\uDD8D\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA\uDECB\uDECD-\uDECF\uDEE0-\uDEE5\uDEE9\uDEF0\uDEF3])\uFE0F|\uD83D\uDC69\u200D\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|\uD83C\uDFF3\uFE0F\u200D\uD83C\uDF08|\uD83D\uDC69\u200D\uD83D\uDC67|\uD83D\uDC69\u200D\uD83D\uDC66|\uD83D\uDC15\u200D\uD83E\uDDBA|\uD83D\uDC69(?:\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83C\uDDFD\uD83C\uDDF0|\uD83C\uDDF6\uD83C\uDDE6|\uD83C\uDDF4\uD83C\uDDF2|\uD83D\uDC08\u200D\u2B1B|\uD83D\uDC41\uFE0F|\uD83C\uDFF3\uFE0F|\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])?|\uD83C\uDDFF(?:\uD83C[\uDDE6\uDDF2\uDDFC])|\uD83C\uDDFE(?:\uD83C[\uDDEA\uDDF9])|\uD83C\uDDFC(?:\uD83C[\uDDEB\uDDF8])|\uD83C\uDDFB(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDEE\uDDF3\uDDFA])|\uD83C\uDDFA(?:\uD83C[\uDDE6\uDDEC\uDDF2\uDDF3\uDDF8\uDDFE\uDDFF])|\uD83C\uDDF9(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDED\uDDEF-\uDDF4\uDDF7\uDDF9\uDDFB\uDDFC\uDDFF])|\uD83C\uDDF8(?:\uD83C[\uDDE6-\uDDEA\uDDEC-\uDDF4\uDDF7-\uDDF9\uDDFB\uDDFD-\uDDFF])|\uD83C\uDDF7(?:\uD83C[\uDDEA\uDDF4\uDDF8\uDDFA\uDDFC])|\uD83C\uDDF5(?:\uD83C[\uDDE6\uDDEA-\uDDED\uDDF0-\uDDF3\uDDF7-\uDDF9\uDDFC\uDDFE])|\uD83C\uDDF3(?:\uD83C[\uDDE6\uDDE8\uDDEA-\uDDEC\uDDEE\uDDF1\uDDF4\uDDF5\uDDF7\uDDFA\uDDFF])|\uD83C\uDDF2(?:\uD83C[\uDDE6\uDDE8-\uDDED\uDDF0-\uDDFF])|\uD83C\uDDF1(?:\uD83C[\uDDE6-\uDDE8\uDDEE\uDDF0\uDDF7-\uDDFB\uDDFE])|\uD83C\uDDF0(?:\uD83C[\uDDEA\uDDEC-\uDDEE\uDDF2\uDDF3\uDDF5\uDDF7\uDDFC\uDDFE\uDDFF])|\uD83C\uDDEF(?:\uD83C[\uDDEA\uDDF2\uDDF4\uDDF5])|\uD83C\uDDEE(?:\uD83C[\uDDE8-\uDDEA\uDDF1-\uDDF4\uDDF6-\uDDF9])|\uD83C\uDDED(?:\uD83C[\uDDF0\uDDF2\uDDF3\uDDF7\uDDF9\uDDFA])|\uD83C\uDDEC(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEE\uDDF1-\uDDF3\uDDF5-\uDDFA\uDDFC\uDDFE])|\uD83C\uDDEB(?:\uD83C[\uDDEE-\uDDF0\uDDF2\uDDF4\uDDF7])|\uD83C\uDDEA(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDED\uDDF7-\uDDFA])|\uD83C\uDDE9(?:\uD83C[\uDDEA\uDDEC\uDDEF\uDDF0\uDDF2\uDDF4\uDDFF])|\uD83C\uDDE8(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDEE\uDDF0-\uDDF5\uDDF7\uDDFA-\uDDFF])|\uD83C\uDDE7(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEF\uDDF1-\uDDF4\uDDF6-\uDDF9\uDDFB\uDDFC\uDDFE\uDDFF])|\uD83C\uDDE6(?:\uD83C[\uDDE8-\uDDEC\uDDEE\uDDF1\uDDF2\uDDF4\uDDF6-\uDDFA\uDDFC\uDDFD\uDDFF])|[#\*0-9]\uFE0F\u20E3|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|\uD83C\uDFF4|(?:[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5])(?:\uD83C[\uDFFB-\uDFFF])|(?:[\u261D\u270C\u270D]|\uD83D[\uDD74\uDD90])(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC08\uDC15\uDC3B\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5]|\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD]|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF]|[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF84\uDF86-\uDF93\uDFA0-\uDFC1\uDFC5\uDFC6\uDFC8\uDFC9\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC07\uDC09-\uDC14\uDC16-\uDC3A\uDC3C-\uDC3E\uDC40\uDC44\uDC45\uDC51-\uDC65\uDC6A\uDC79-\uDC7B\uDC7D-\uDC80\uDC84\uDC88-\uDCA9\uDCAB-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDDA4\uDDFB-\uDE44\uDE48-\uDE4A\uDE80-\uDEA2\uDEA4-\uDEB3\uDEB7-\uDEBF\uDEC1-\uDEC5\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0D\uDD0E\uDD10-\uDD17\uDD1D\uDD20-\uDD25\uDD27-\uDD2F\uDD3A\uDD3F-\uDD45\uDD47-\uDD76\uDD78\uDD7A-\uDDB4\uDDB7\uDDBA\uDDBC-\uDDCB\uDDD0\uDDE0-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6]|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26A7\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDED5-\uDED7\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])\uFE0F|(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDC8F\uDC91\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1F\uDD26\uDD30-\uDD39\uDD3C-\uDD3E\uDD77\uDDB5\uDDB6\uDDB8\uDDB9\uDDBB\uDDCD-\uDDCF\uDDD1-\uDDDD])/";
  //Profile Shipper

  //pembagian warna APPS
  //warna utama APPS
  static Color appsMainColor = Color(ListColor.colorBlue);
  //warna button tab index
  static Color tabButtonMainColor = Color(ListColor.colorWhite);
  //warna button dan text tab halaman detail
  static Color tabDetailAcessoriesMainColor = Color(ListColor.colorWhite);
  //warna border indicator halaman pada tab
  static Color tabDetailBorderPageIndicatorColor = Color(ListColor.colorYellow);
  //warna border indicator halaman sekarang pada tab
  static Color tabDetailBackgroundPageIndicatorCurrentColor =
      Color(ListColor.colorYellow);
  //warna button/tulisan ketika disable
  static Color tabDetailAcessoriesDisableColor =
      Color(ListColor.colorLightGrey2);
  //url image navbar
  static String urlImageNavbar = imagePath + "header_bg.png";
  static String backgroundAfterLogin =
      GlobalVariable.imagePathArk + "blue_background.png";
  //warna header card
  static Color ItemCardHeaderColor = Color(ListColor.colorHeaderListTender);

  static Color cardHeaderManajemenColor =
      Color(ListColor.colorHeaderListTender);

  static String allowInput = "[A-Za-z0-9 \n\,\@\.\?\!\:\"\'\+\%\=\(\)\/\&\-]";

  static bool subUser;

  static void alertNoAksesWidget() {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 32,
                  right: GlobalVariable.ratioWidth(Get.context) * 32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Stack(children: [
                        Positioned(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                  ),
                                  child: CustomText(
                                    "TenderMenuIndexLabelAkses".tr,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          96),
                                  width: double.infinity,
                                  child: MaterialButton(
                                    elevation: 0,
                                    onPressed: () {
                                      Navigator.of(Get.context).pop();
                                    },
                                    color: Color(ListColor.color4),
                                    padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            12,
                                        bottom: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            10,
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            41,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            41),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18)),
                                    ),
                                    child: Text("OK",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ])))));
        });
  }

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

  static String formatNamaFile(String text) {
    text = text.replaceAll("-", "");
    return text;
  }

  // static String cekFotoOrVideo(url) {
  //   String nama = url.toString().split("/").last;
  //   String tipe = lookupMimeType(nama).split("/")[0];
  //   return tipe;
  // }

  //update internal
  static String cekFotoOrVideo(String url) {
    final path = url.split("/");
    if (path.isNotEmpty) {
      final nama = path.last;
      String res = '';
      try {
        final tipeSplit = (lookupMimeType(nama) ?? '').split("/");
        res =  tipeSplit.isNotEmpty ? tipeSplit.first : '';
      } catch (e) {}
      return res;
    }
    return '';
  }

  static Future<Map> getStatusUser(BuildContext context) async {
    var result = await ApiHelper(
            context: context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserStatus();

    if (result['Message']['Code'].toString() == '200') {
      print(result['Data']);
      return result['Data'];
    }
  }

  static Future<DateTime> getDateTimeFromServer(BuildContext context) async {
    var result = await ApiHelper(
            context: context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDateTimeNow();

    if (result['Message']['Code'].toString() == '200') {
      return DateTime.parse(result['Data']['DateTime']);
    }
  }

  static void showMessageToastDebug(String message) {
    if (isDebugMode) Fluttertoast.showToast(msg: message);
  }

  //DARI FORMAT CURRENCY JADI DOUBLE FLUTTER
  //1.000 -> 1000.00  | 1.500,05 -> 1500.05
  static String formatDoubleDecimal(String text) {
    text = text.replaceAll(".", "").replaceAll(",", ".");
    return text;
  }

  static String penyebut(int nilai) {
    nilai = nilai.abs();
    List<String> huruf = [
      "",
      "Satu",
      "Dua",
      "Tiga",
      "Empat",
      "Lima",
      "Enam",
      "Tujuh",
      "Delapan",
      "Sembilan",
      "Sepuluh",
      "Sebelas"
    ];
    String temp = "";

    if (nilai < 12) {
      temp = " " + huruf[nilai];
    } else if (nilai < 20) {
      temp = penyebut(nilai - 10) + " Belas";
    } else if (nilai < 100) {
      temp = penyebut(nilai ~/ 10) + " Puluh" + penyebut(nilai % 10);
    } else if (nilai < 200) {
      temp = " Seratus" + penyebut(nilai - 100);
    } else if (nilai < 1000) {
      temp = penyebut(nilai ~/ 100) + " Ratus" + penyebut(nilai % 100);
    } else if (nilai < 2000) {
      temp = " Seribu" + penyebut(nilai - 1000);
    } else if (nilai < 1000000) {
      temp = penyebut(nilai ~/ 1000) + " Ribu" + penyebut(nilai % 1000);
    } else if (nilai < 1000000000) {
      temp = penyebut(nilai ~/ 1000000) + " Juta" + penyebut(nilai % 1000000);
    } else if (nilai < 1000000000000) {
      temp = penyebut(nilai ~/ 1000000000) +
          " Milyar" +
          penyebut(nilai % 1000000000);
    } else if (nilai < 1000000000000000) {
      temp = penyebut(nilai ~/ 1000000000000) +
          " Trilyun" +
          penyebut(nilai % 1000000000000);
    }
    return temp;
  }

  static String terbilang(int nilai, String satuan) {
    String hasil = "";
    if (nilai == 0) {
      hasil = "Nol";
    } else if (nilai < 0) {
      hasil = "Minus " + trim(penyebut(nilai));
    } else {
      hasil = trim(penyebut(nilai));
    }
    return hasil = hasil + " " + satuan;
  }

  static String terbilangKoma(double nilai, String satuan) {
    List<String> angka = nilai.toString().split(".");
    String hasil = "";
    int nilaiAwal = int.parse(angka[0]);
    double nilaiAkhir = double.parse("0." + angka[1]);
    if (nilaiAwal == 0) {
      hasil = "Nol";
    } else if (nilaiAwal < 0) {
      hasil = "Minus " + trim(penyebut(nilaiAwal));
    } else {
      hasil = trim(penyebut(nilaiAwal));
    }

    if (nilaiAkhir > 0) {
      String bilanganAkhir = "";
      List<String> listAkhir = angka[1].split("");
      for (int i = 0; i < listAkhir.length; i++) {
        bilanganAkhir = bilanganAkhir +
            (listAkhir[i] == "0" ? " Nol" : penyebut(int.parse(listAkhir[i])));
      }
      hasil = hasil + " Koma " + trim(bilanganAkhir);
    }
    return hasil = hasil + " " + satuan;
  }

  static String uppercaseFirstLetter(String kalimat) {
    List<String> words = kalimat.replaceAll("-", " ").split(" ");
    String res = "";
    for (int i = 0; i < words.length; i++) {
      List<String> letters = words[i].split("");
      String kata = "";
      for (int j = 0; j < words[i].length; j++) {
        if (j == 0) {
          kata += letters[j].toUpperCase();
        } else {
          kata += letters[j];
        }
      }
      res += " " + kata;
    }
    return trim(res);
  }

  static String terbilangKomaInggris(double nilai, String satuan) {
    List<String> angka = nilai.toString().split(".");
    String hasil = "";
    int nilaiAwal = int.parse(angka[0]);
    double nilaiAkhir = double.parse("0." + angka[1]);
    if (nilaiAwal == 0) {
      hasil = "Zero";
    } else if (nilaiAwal < 0) {
      hasil = "Minus " +
          uppercaseFirstLetter(NumberToWordsEnglish.convert(nilaiAwal));
    } else {
      hasil = uppercaseFirstLetter(NumberToWordsEnglish.convert(nilaiAwal));
    }

    if (nilaiAkhir > 0) {
      String bilanganAkhir = "";
      List<String> listAkhir = angka[1].split("");
      for (int i = 0; i < listAkhir.length; i++) {
        bilanganAkhir = bilanganAkhir +
            (listAkhir[i] == "0"
                ? " Zero"
                : " " +
                    uppercaseFirstLetter(
                        NumberToWordsEnglish.convert(int.parse(listAkhir[i]))));
      }
      hasil = hasil + " Point " + trim(bilanganAkhir);
    }
    return hasil = hasil + " " + satuan;
  }

  //DARI FORMAT DOUBLE / INT FLUTTER JADI CURRENCY
  //1000.00 -> 1.000  | 1500.05 -> 1.500,05
  static String formatCurrencyDecimal(String text) {
    String newText = "";
    var firstTime = true;
    var subsText = "";

    //SEPARATOR KOMA
    var arrText = text.toString().split(".");

    for (var i = arrText[0].length - 1; i >= 0; i--) {
      if ((subsText.length == 3 && firstTime) ||
          (subsText.length == 2 && !firstTime)) {
        subsText = "";
        newText += "." + arrText[0][i];
        firstTime = false;
      } else {
        subsText += arrText[0][i];
        newText += arrText[0][i];
      }
    }

    //JIKA MENGANDUNG KOMA
    if (arrText.length > 1) {
      if (int.parse(arrText[1]) != 0) {
        arrText[1] = arrText[1].split('').reversed.join('');
        newText = arrText[1] + "," + newText;
      }
    }

    newText = newText.split('').reversed.join('');
    return newText;
  }

  //UNTUK TEXTBOX YANG MENGGUNAKAN FORMAT CURRENCY
  static String formatCurrency(String text, int digitAfterComma) {
    String newText = "";
    var arrText = text.split(".");

    var subsText = "";
    var firstTime = true;
    for (var i = arrText[0].length - 1; i >= 0; i--) {
      if ((subsText.length == 3 && firstTime) ||
          (subsText.length == 2 && !firstTime)) {
        subsText = "";
        newText += "." + arrText[0][i];
        firstTime = false;
      } else {
        subsText += arrText[0][i];
        newText += arrText[0][i];
      }
    }

    //JIKA MENGANDUNG KOMA
    if (arrText.length > 1) {
      arrText[1] = arrText[1].split('').reversed.join('');
      newText = arrText[1] + "," + newText;
    }

    //DI REVERSE, KARENA DICEK DARI BELAKANG
    newText = newText.split('').reversed.join('');

    return newText;
  }

  static String formatMuatan(String text) {
    return text.replaceAll("m&sup3", "m\u00B3");
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  final int digit;
  final int digitAfterComma;
  final TextEditingController controller;

  DecimalInputFormatter({this.digit, this.digitAfterComma, this.controller});

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newText = "";
    String value = "";
    if (newValue.text[0] == ",") {
      value = newValue.text[0].replaceAll(",", "0,");
    } else {
      value = newValue.text;
    }

    var arrText = value.split(",");

    //BERSIHKAN TITIK NYA DAHULU
    arrText[0] = arrText[0].replaceAll(".", "");

    if (arrText[0].length > this.digit) {
      controller.text = oldValue.text;
      return oldValue;
    }

    var subsText = "";
    var firstTime = true;

    if (arrText[0].length > 1) {
      arrText[0] = arrText[0].replaceFirst(RegExp(r'^0+'), "");
    }

    for (var i = arrText[0].length - 1; i >= 0; i--) {
      if ((subsText.length == 3 && firstTime) ||
          (subsText.length == 2 && !firstTime)) {
        subsText = "";
        newText += "." + arrText[0][i];
        firstTime = false;
      } else {
        subsText += arrText[0][i];
        newText += arrText[0][i];
      }
    }

    //JIKA MENGANDUNG KOMA
    if (arrText.length > 1) {
      if (arrText[1].length > this.digitAfterComma) {
        controller.text = oldValue.text;
        return oldValue;
      }

      arrText[1] = arrText[1].split('').reversed.join('');
      newText = arrText[1] + "," + newText;
    }

    //DI REVERSE, KARENA DICEK DARI BELAKANG
    newText = newText.split('').reversed.join('');
    if (digitAfterComma <= 0) {
      newText = newText.replaceAll(",", "");
    }
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class LimitInputFormatter extends TextInputFormatter {
  final int limit;
  final TextEditingController controller;

  LimitInputFormatter({this.limit, this.controller});

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = "";

    if (newValue.text.length > this.limit) {
      controller.text = oldValue.text;
      return oldValue;
    }
    newText = newValue.text;

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
