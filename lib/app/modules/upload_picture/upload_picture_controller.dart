import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muatmuat/app/core/function/cool_alert_dialog.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/google_sign_in_function.dart';
import 'package:muatmuat/app/core/function/login_function.dart';
import 'package:muatmuat/app/core/models/user_model.dart';
import 'package:muatmuat/app/modules/home/home/home/home_view.dart';
import 'package:muatmuat/app/modules/login/login_response_model.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_controller.dart';
import 'package:muatmuat/app/modules/register_user/register_user_old/register_user_view.dart';
import 'package:muatmuat/app/modules/verify_phone/verify_phone_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

import 'package:mime/mime.dart';
import 'package:path/path.dart';

class UploadPictureController extends GetxController {
  var file = File("").obs;
  var errorMessage = "".obs;

  var onCreate = false.obs;

  // cek validasi di view
  var isValid = true.obs;
  var isFilled = false.obs;
  var canSave = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void chooseFile(int type) async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      // log("Choosen File: " + pickedFile.names.toString());
      log("Choosen File: " + pickedFile.files.first.name.toString());
      log("Choosen File: " + pickedFile.files.first.size.toString());
      log("Choosen File: " + pickedFile.files.first.extension.toString());
      log("Choosen File: " + pickedFile.files.first.path.toString());
      // file.value = File(pickedFile.files.single.path);
      file.value = File(pickedFile.files.first.path);
      viewResult(file.value);
    }
  }

  void getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      viewResult(File(pickedFile.path));
      // _cropImage(pickedFile.path);
    }
    else {
      Get.back();
    }
  }

  void getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      file.value = File(pickedFile.path);
      viewResult(file.value);
    }
  }

  void _cropImage(filePath) async {
    File croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      file.value = croppedImage;
      // viewResult(file.value);
    }
    else {
      Get.back();
    }
  }

  double getFileSize(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    return sizeInMb;
  }

  bool isAllowedFormat(String path) {
    final mimeType = lookupMimeType(path);

    log("File mimetype: " + mimeType);
    if (mimeType.endsWith('jpg') || mimeType.endsWith('jpeg') || mimeType.endsWith('png') || mimeType.endsWith('pdf') || mimeType.endsWith('zip')) {
      return true;
    }

    return false;
  }

  void viewResult(File file) {
    String fileName = basename(file.path).toString();
    log("File: " + fileName);
    log("File path: " + file.path);
    if (getFileSize(file) > 5 && !isAllowedFormat(file.path)) {
      errorMessage.value = "Format file tidak sesuai ketentuan dan file maksimal 5MB!";
      // addToList(type, null, errorMessage.value);
    } 
    else {
      if (getFileSize(file) <= 5) {
        if (isAllowedFormat(file.path)) {
          // log("File: " + basename(file.path));
          canSave.value = true;
          errorMessage.value = "";
          log("File: SAFE");
          _cropImage(file.path);
          // addToList(type, file, fileName);
        } 
        else {
          errorMessage.value = "Format file tidak sesuai ketentuan!";
          // addToList(type, null, errorMessage.value);
        }
      } 
      else {
        errorMessage.value = "Format file jpg/png max. 5MB!";
        // addToList(type, null, errorMessage.value);
      }
    }

    if (errorMessage.value != "") {
      canSave.value = false;
      // this.file.value = File("");
      log("File: " + errorMessage.toString());
      CustomToastTop.show(context: Get.context, message: errorMessage.value, isSuccess: 0);
    }

    // Navigator.pop(Get.context);
  }
}
