import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/modules/buyer/detail/detail_iklan_product_view.dart';
import 'package:path/path.dart';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static String formatUang(double value,
      {String currency = "Rp", String comaSeparator = "."}) {
    var string = "";
    var convertString = value.toString().split(comaSeparator);
    for (var index = 0; index < convertString[0].length; index++)
      string = (index % 3 == 2 && index != (convertString[0].length - 1)
              ? "."
              : "") +
          convertString[0][(convertString[0].length - 1 - index)] +
          string;
    if (convertString.length > 1 && int.parse(convertString[1]) > 0)
      string += "," + convertString[1];
    return "$currency$string";
  }

  static String validateFormatName(String value, {String customMin3CharsMsg, String customFormatMsg}) {
    if (value.length < 3) return customMin3CharsMsg == null ? "GlobalValidationLabelNamaLengkapMinimal3".tr : customMin3CharsMsg;
    if (!RegExp(r"^(?=.*[a-zA-Z])\w+[a-zA-Z .,']+$").hasMatch(value)) return customFormatMsg == null ? "GlobalValidationLabelNamaLengkapTidakValid".tr : customFormatMsg;
    return "";
  }

  static String validateFormatEmail(String value) {
    if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)) return "Format Email tidak valid!";
    return "";
  }

  static List<String> get isItImage => [
    'jpg',
    'jpeg',
    'jfif',
    'pjpeg',
    'pjp',
    'png',
    'svg',
    'gif',
    'apng',
    'webp',
    'avif'
  ];

  static List<String> get isItVideo => [
    "3g2",
    "3gp",
    "aaf",
    "asf",
    "avchd",
    "avi",
    "drc",
    "flv",
    "m2v",
    "m3u8",
    "m4p",
    "m4v",
    "mkv",
    "mng",
    "mov",
    "mp2",
    "mp4",
    "mpe",
    "mpeg",
    "mpg",
    "mpv",
    "mxf",
    "nsv",
    "ogg",
    "ogv",
    "qt",
    "rm",
    "rmvb",
    "roq",
    "svi",
    "vob",
    "webm",
    "wmv",
    "yuv"
  ];

  static String validateFormatPhone(String value) {
    String message;
    int indexCheck = 0; 
    int total = 0;
    double result = 0;
    for(int i = indexCheck; i < value.length; i++){
      total += int.parse(value[i]);
    }
    result = total / (value.length - indexCheck);

    if(result == double.parse(value.substring(indexCheck, indexCheck+1))){
      // SAME NUMBER
      message = '1. Angka sama semua! ';
    }

    indexCheck = (value.substring(0,2) == "08") ? 2 : 3;
    if (value.substring(0, indexCheck) == "08" || value.substring(0, indexCheck) == "628") { 
      // value indo valid
      total = 0;
      result = 0;
      for(int i = indexCheck; i < value.length; i++){
        total += int.parse(value[i]);
      }
      result = total / (value.length - indexCheck);

      if(result == double.parse(value.substring(indexCheck, indexCheck+1))){
        // SAME NUMBER
        message = '2. Angka sama semua! ';
      }
    }
    else{
      total = 0;
      result = 0;
      for(int i = indexCheck; i < value.length; i++){
        total += int.parse(value[i]);
      }
      result = total / (value.length - indexCheck);

      if(result == double.parse(value.substring(indexCheck, indexCheck+1))){
        // SAME NUMBER
        message = '3. Angka sama semua! ';
      }
    }
  }

  static String validateFormatPassword(String value) {
    String message = "";
    // RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])$').hasMatch(value);
    log("0. " + RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value).toString());
    log("1. " + RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])").hasMatch(value).toString());
    log("2. " + RegExp(r'^[A-Z]+$').hasMatch(value).toString());
    log("3. " + RegExp(r'^[a-z]+$').hasMatch(value).toString());
    log("4. " + RegExp(r'^[0-9]+$').hasMatch(value).toString());
    if(value.length < 8) {
      if (!RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])").hasMatch(value)) {
        message = "Password harus terdapat huruf kecil, kapital, dan angka. Minimal 8 karakter!";
      }
      else {
        message = "Password minimal terdapat 8 karakter!";
      }
    }
    else{
      if (!RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])").hasMatch(value)) {
        message = "Password harus terdapat huruf kecil, kapital, dan angka!";
      }
      else {

      }
    }
    // if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)) message = "Password harus terdapat huruf kecil, kapital, dan angka. Minimal 8 karakter!";
    return message;
  }

  static Future<File> chooseFile() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      // log("Choosen File: " + pickedFile.names.toString());
      log("Choosen File: " + pickedFile.files.first.name.toString());
      log("Choosen File: " + pickedFile.files.first.size.toString());
      log("Choosen File: " + pickedFile.files.first.extension.toString());
      log("Choosen File: " + pickedFile.files.first.path.toString());
      // file.value = File(pickedFile.files.single.path);
      return File(pickedFile.files.first.path);
    }
  }

  static void getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    _cropImage(pickedFile.path);
  }

  static Future<File> getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
  }

  static Future<File> _cropImage(filePath) async {
    File croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      return croppedImage;
    }
  }

  static double getFileSize(File file){
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    return sizeInMb;
  }

  static bool isAllowedFormat(String path) {
    print(path);
    final mimeType = lookupMimeType(path);

    log("File mimetype: " + mimeType);
    if(mimeType.endsWith('jpg') || mimeType.endsWith('jpeg') || mimeType.endsWith('png') || mimeType.endsWith('pdf') || mimeType.endsWith('zip')){
      return true;
    }

    return false;
  }

  static void checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      CustomToastTop.show(
        context: Get.context, 
        isSuccess: 0, 
        message: 'GlobalValidationLabelConnectionFailed'.tr
      );
    }
  }

  static String base64Image(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String string64 = base64Encode(imageBytes);
    return "data:image/${file.path.split('.')[file.path.split('.').length - 1]};base64,$string64";
  }

  static String delimeter(String number) {
    if (number == "") return number;
    if (number == "null" || number == null) return "";

    final formatter = NumberFormat("#,###.####");
    double raw = double.tryParse(number) ?? 0;
    String result = formatter.format(raw).toString();
    result = result.replaceAll(",", "~~");
    result = result.replaceAll(".", "||");
    result = result.replaceAll("~~", ".");
    result = result.replaceAll("||", ",");

    return result;
  }

  static String removeNumberFormat(String number) {
    String result = number;
    result = result.replaceAll(",", "~~");
    result = result.replaceAll(".", "||");
    result = result.replaceAll("~~", ".");
    result = result.replaceAll("||", "");
    
    return result;
  }

  static formatDate({@required String value, @required String format}) {
    if (value.isEmpty) return "";
    if (Get.locale == null) return DateFormat(format).format(DateTime.parse(value));
    return DateFormat(format, Get.locale == const Locale('id') ? 'id' : 'en_US').format(DateTime.parse(value));
  }

  static formatCurrency({@required double value, int decimalDigits = 2}) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: value % 1 == 0 ? 0 : decimalDigits).format(value);
  }

  static bool hasValidUrl(String value) {
    String pattern = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  } 

  static Future<void> initDynamicLinks() async {
    try {
      FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
      dynamicLinks.onLink(
        onSuccess: (PendingDynamicLinkData linkData) async {
          if (linkData != null) {
            final Uri deepLink = linkData.link;
            if (deepLink != null) {
              Map params = linkData.link.queryParameters;
              String link = linkData.link.toString();
              if (link.contains('detail') && link.contains('kategoriID') && link.contains('subKategoriID')) {
                Get.to(() => DetailIklanProductView(),
                  arguments: {
                    'KategoriID': params['kategoriID'],
                    'SubKategoriID': params['subKategoriID'],
                    'IklanID': params['detail'],
                    'Layanan': linkData.link.toString().split("/")[3]
                  },
                );
              }
            }
          }
        },
        onError: (linkData)  async{
          print("error");
          Fluttertoast.showToast(msg: linkData.toString());
        }
      );

      final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
      if (data != null) {
        final Uri deepLink = data.link;
        if (deepLink != null) {
          Map params = data.link.queryParameters;
          String link = data.link.toString();
          if (link.contains('detail') && link.contains('kategoriID') && link.contains('subKategoriID')) {
            Get.to(() => DetailIklanProductView(),
              arguments: {
                'KategoriID': params['kategoriID'],
                'SubKategoriID': params['subKategoriID'],
                'IklanID': params['detail'],
                'Layanan': data.link.toString().split("/")[3]
              },
            );
          }
        }
      }
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
    }
  }
}

enum NumberType {PRICE, YEAR}