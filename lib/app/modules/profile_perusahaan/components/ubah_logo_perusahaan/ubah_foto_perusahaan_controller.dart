import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:mime/mime.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:path/path.dart';

class UbahLogoPerusahaanController extends GetxController {
  var p = Get.find<ProfilePerusahaanController>();
  var onCreate = false.obs;
  var mime = "".obs;
  var file = File('').obs;
  var errorMessage = "".obs;
  // var croppedFile = File('').obs;
  var loading = false.obs;
  var base64Image = "".obs;
  // ::::::::::::::::::::::::::::::::::
  // :::: ERROR NUNGGU PROFIL AKUN ::::
  // UserProfil userProfil = UserProfil();
  // UserStatus userStatus = UserStatus();
  // ::::::::::::::::::::::::::::::::::

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
  void _cropImage(filePath) async {
    File croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      log('croppeddddddd');
      file.value = croppedImage;
      final ext = file.value.path.split('.').last;
      final encode64 = File(file.value.path).readAsBytesSync();
      base64Image.value = "data:image/$ext;base64," + base64Encode(encode64);
      // log('${base64Image.value}');
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
    if (mimeType.endsWith('jpg') || mimeType.endsWith('jpeg') || mimeType.endsWith('png')) {
      return true;
    }

    return false;
  }

  Future<String> convertIntoBase64(File file) async {
    List<int> imageBytes = file.readAsBytesSync();
    String base64file = base64Encode(imageBytes);
    // log("FILE READY Up :: $base64file");
    return base64file;
  }

  void viewResult(File file) {
    String fileName = basename(file.path).toString();
    log("File: " + fileName);
    log("File path: " + file.path);
    if (getFileSize(file) > 5 && !isAllowedFormat(file.path)) {
      errorMessage.value = "Format file tidak sesuai ketentuan dan file maksimal 5MB!";
      log("File: " + errorMessage.toString());
      // addToList(type, null, errorMessage.value);
    } else {
      if (getFileSize(file) <= 5) {
        if (isAllowedFormat(file.path)) {
          // log("File: " + basename(file.path));
          errorMessage.value = "";
          log("File: SAFE");
          _cropImage(file.path);
          // addToList(type, file, fileName);
        } else {
          errorMessage.value = "Format file tidak sesuai ketentuan!";
          log("File: " + errorMessage.toString());
          // addToList(type, null, errorMessage.value);
        }
      } else {
        errorMessage.value = "Format file jpg/png max. 5MB!";
        log("File: " + errorMessage.toString());
        // addToList(type, null, errorMessage.value);
      }
    }

    if (errorMessage.value != "") {
      CustomToastTop.show(context: Get.context, message: errorMessage.value, isSuccess: 0);
    }

    // Navigator.pop(Get.context);
  }

  Future simpanFoto() async {
    log('::: SAVE BEGIN');
    if (file.value.path != "") {
      log('2 ========== UPDT BEGIN');
      await updatePhotoCompanyLogo(base64Image.value);
      await p.fetchDataCompany();
      log('2 ========== PROFILPERUSHAAAN C');
    } else {}
    log('2 ========== SUKSES');
  }

  void cancel() {
    GlobalAlertDialog2.showAlertDialogCustom(
      title: "Batal ubah foto",
      context: Get.context,
      customMessage: Padding(
        padding: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 20),
        child: CustomText(
          "Foto Anda tidak akan tersimpan bila Anda membatalkan ubah foto",
          textAlign: TextAlign.center,
          color: Colors.black,
        ),
      ),
      borderRadius: 12,
      labelButtonPriority1: "Batal",
      fontSizeButton1: 14,
      labelButtonPriority2: "Simpan",
      fontSizeButton2: 14,
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      onTapPriority1: () => Get.back(),
      onTapPriority2: () => simpanFoto(),
      widthButton1: 104,
      widthButton2: 104,
      heightButton1: 36,
      heightButton2: 36,
    );
  }

  Future<void> getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      viewResult(File(pickedFile.path));
    } else {
      Get.back();
    }
    // _cropImage(pickedFile.path);
  }

  Future<void> getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      viewResult(File(pickedFile.path));
    } else {
      Get.back();
    }
    // _cropImage(pickedFile.path);
  }

  Future showUpload() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20), topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 20))),
      backgroundColor: Colors.white,
      context: Get.context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // GARIS ABU
              Container(
                  margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 4),
                  child: Container(
                    width: GlobalVariable.ratioWidth(Get.context) * 38,
                    height: GlobalVariable.ratioWidth(Get.context) * 3,
                    decoration: BoxDecoration(color: Color(ListColor.colorLightGrey16), borderRadius: BorderRadius.all(Radius.circular(20))),
                  )),

              Container(
                padding: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 12,
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 8), // - 12
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        'Ubah Foto',
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.color4),
                        withoutExtraPadding: true,
                        fontSize: 14,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // onPop();
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          GlobalVariable.urlImageTemplateBuyer + "ic_close_shipper.svg",
                          color: Color(ListColor.colorBlack),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              listContent(
                context,
                () async {
                  Get.back();
                  await getFromGallery();
                },
                'assets/ic_gallery.svg',
                'Pilih dari galeri',
              ),
              listContent(context, () async {
                //TUTUP BOTTOMSHEET
                Get.back();
                await getFromCamera();
              }, 'assets/ic_camera.svg', 'Ambil foto'),
              listContent(
                context,
                () async {
                  Get.back();
                  await deletePhoto();
                  // fetchDataCompany();
                },
                'assets/ic_trash.svg',
                'Hapus foto profil',
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12)
            ],
          ),
        );
      },
    );
  }

  Future deletePhoto() async {
    log('DELETEE PHOTOO');
    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: true, isDebugGetResponse: true).deletePhotoProfile({});
      if (response != null) {
        Get.back();
        if (response["Message"]["Code"] == 200) {
          CustomToastTop.show(context: Get.context, message: response["Data"]['Message'], isSuccess: 1);
        } else {
          String errorMessage = response["Data"]["Message"];
          CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        }
      }
    } catch (err) {
      print("Can't delete photo : " + err.toString());
    }
  }

  Future updatePhotoCompanyLogo(String image) async {
    log('UPDATE PHOTOO COMPANY');

    try {
      var response = await ApiProfile(context: Get.context, isShowDialogLoading: true, isDebugGetResponse: true).updatePhotoProfileCompany(image);
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          Get.back();
          CustomToastTop.show(context: Get.context, message: response["Data"]['Message'], isSuccess: 1);
        } else {
          String errorMessage = response["Data"]["Message"];
          Get.back();
          CustomToastTop.show(message: errorMessage, context: Get.context, isSuccess: 0);
        }
      }
    } catch (err) {
      print("Can't update photo : " + err.toString());
    }
  }

  Widget listContent(
    BuildContext context,
    void Function() onTap,
    String icon,
    String text,
  ) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(context) * 16),
          padding: EdgeInsets.symmetric(vertical: GlobalVariable.ratioWidth(context) * 12),
          constraints: BoxConstraints(
            minHeight: GlobalVariable.ratioWidth(context) * 36,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: GlobalVariable.ratioWidth(context) * 1,
                color: Color(ListColor.colorLightGrey10),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: GlobalVariable.ratioWidth(Get.context) * 8,
                ),
                child: SvgPicture.asset(
                  icon,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
                ),
              ),
              Expanded(
                child: CustomText(
                  text,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
