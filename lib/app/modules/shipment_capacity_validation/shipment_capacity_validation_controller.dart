import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:mime/src/mime_type.dart';

class ShipmentCapacityValidationController extends GetxController {
  TextEditingController transporterCompany = TextEditingController();
  TextEditingController transporterPICName = TextEditingController();
  TextEditingController transporterPICPhone = TextEditingController();

  var isTransporterCompanyValid = true.obs;
  var isTransporterPICNameValid = true.obs;
  var isTransporterPICPhoneValid = true.obs;
  var isAllValid = false.obs;

  var tipeModul = TipeModul.BF.obs;

  var selectedFile = File("").obs;
  var dispatchNote = [].obs;
  var dispatchNoteResult = [].obs;
  var errorMessage = "".obs;
  int changeIndex = -1.obs;

  var time = 0.obs;
  var totalTime = 10;
  var ratio = (-1.0).obs;

  Timer timer;

  var dispatchNoteUrl = "${ApiHelper.urlInternal}_resources/themes/muat/image/png/contoh_surat_jalan.png";

  @override
  void onInit() async {
    super.onInit();
    tipeModul.value = Get.arguments;

    // PENYESUAIAN API, SEMENTARA SET QTY DISINI KARENA DIALOG UNTUK ISI CAPACITY QTY ADA DI VENDOR
    await ApiHelper(context: Get.context, isShowDialogLoading: false).setShipperCapacityQty("50");
  }

  Future setCapacityValidation() async {
    List<String> fileFields = [];
    List<MediaType> fileContents = [];
    for (var i = 0; i < dispatchNote.value.length; i++) {
      fileFields.add("FileSuratJalan[$i]");
      fileContents.add(MediaType.parse(lookupMimeType((dispatchNote[i] as File).path)));
    }
    await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false).setShipperRegistrationInfo(
      body: tipeModul.value == TipeModul.BF ? null : {
        'LastTransporterName': transporterPICName.text,
        'LastTransporterPhone': transporterPICPhone.text
      },
      fileFields: fileFields, 
      files: dispatchNote.value.map((e) => File((e as File).path)).toList(), 
      fileContents: fileContents,
    );
  }

  void checkCompanyName(String value, {bool useToast = true}) {
    if (validateFormatCompanyName(value).isNotEmpty) {
      isTransporterCompanyValid.value = false;
      if (useToast) CustomToastTop.show(context: Get.context, message: validateFormatCompanyName(value), isSuccess: 0);
    } else {
      isTransporterCompanyValid.value = true;
    }
  }

  void checkContactName(String value, {bool useToast = true}) {
    if (Utils.validateFormatName(value, customMin3CharsMsg: "BFTMRegisterTMNamaMinimal3".tr, customFormatMsg: "BFTMRegisterTMKontakTidakValid".tr).isNotEmpty) {
      isTransporterPICNameValid.value = false;
      if (useToast) CustomToastTop.show(context: Get.context, message: Utils.validateFormatName(value), isSuccess: 0);
    } else {
      isTransporterPICNameValid.value = true;
    }
  }

  void checkPhone(String value, {bool useToast = true}) {
    if (value.length < 8) {
      isTransporterPICPhoneValid.value = false;
      if (useToast) CustomToastTop.show(context: Get.context, message: 'BFTMRegisterTMNoHpMinimal8'.tr, isSuccess: 0);
    } else {
      isTransporterPICPhoneValid.value = true;
    }
  }

  bool isValid() {
    if (tipeModul.value == TipeModul.BF) {
      return dispatchNote.where((e) => e != null).isNotEmpty;
    } else {
      // checkCompanyName(transporterCompany.value.text);
      // checkContactName(transporterPICName.value.text);
      // checkPhone(transporterPICPhone.value.text);
      return dispatchNote.where((e) => e != null).isNotEmpty && isTransporterCompanyValid.value && isTransporterPICNameValid.value && isTransporterPICPhoneValid.value;
    }
  }

  String validateFormatCompanyName(String value) {
    if (value.length < 3) return "Nama perusahaan minimal 3 karakter!".tr;
    if (!RegExp(r"^[A-Za-z0-9_]").hasMatch(value)) return "BFTMRegisterTMNamaTidakValid".tr;
    return "";
  }

  void cancel() {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "BFTMRegisterAllBatalkanPendaftaran".tr, 
      context: Get.context,
      customMessage: Container(
        margin: EdgeInsets.only(
          bottom: GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        child: CustomText(
          "BFTMRegisterAllConfirmation".tr,
          textAlign: TextAlign.center,
          fontSize: 14,
          height: 21 / 14,
          color: Colors.black,
          fontWeight: FontWeight.w600
        ),
      ),
      borderRadius: 12,
      labelButtonPriority1: "BFTMRegisterAllSure".tr,
      labelButtonPriority2: "BFTMRegisterAllCancel".tr,
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      onTapPriority1: () {
        Get.back();
      },
      widthButton1: 81,
      widthButton2: 81,
      heightButton1: 31,
      heightButton2: 31,
    );
  }

  void startProgressBar(File file) {
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) async {
      Utils.checkConnection();
      if (time.value == totalTime) {
        viewResult(file);
        timer.cancel();
        await Future.delayed(Duration(milliseconds: 500));
        time.value = 0;
        ratio.value = -1;
      } else {
        time.value++;
        ratio.value = (time.value/totalTime);
      }
    });
  }

  void chooseFile() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      selectedFile.value = File(pickedFile.files.first.path);
      startProgressBar(selectedFile.value);
      // viewResult(selectedFile.value);
    }
  }
 
  void viewResult(File file) {
    String fileName = basename(file.path).toString();
    if (Utils.getFileSize(file) > 5 && !Utils.isAllowedFormat(file.path)) {
      errorMessage.value = "GlobalValidationLabelFileFormatAndSize".tr;
      addToList(null, errorMessage.value);
    } else {
      if(Utils.getFileSize(file) <= 5){
        if(Utils.isAllowedFormat(file.path)){
          selectedFile.value = file;
          addToList(file, fileName);
        } else { 
          errorMessage.value = "GlobalValidationLabelFileFormatIncorrect".tr;
          addToList(null, errorMessage.value);
        }
      } else {
        errorMessage.value = "GlobalValidationLabelFileSize5Mb".tr;
        addToList(null, errorMessage.value);
      }
    }
  }

  void addToList(File file, String message) {
    if (changeIndex == -1) {
      // insert new
      if (dispatchNoteResult.length > 0) {
        // check previous
        if (dispatchNote[dispatchNote.length - 1] == null) {
          // if previous null then update previous
          changeIndex = dispatchNote.length - 1;
          dispatchNote[changeIndex] = file;
          dispatchNoteResult[changeIndex] = message;
        } else {
          // if not null then insert new
          dispatchNote.add(file);
          dispatchNoteResult.add(message);
        }
      } else {
        dispatchNote.add(file);
        dispatchNoteResult.add(message);
      }
    } else {
      // update existing
      dispatchNote[changeIndex] = file;
      dispatchNoteResult[changeIndex] = message;
    }
    errorMessage.value = "";
    changeIndex = -1;
  }

  showUpload() {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), 
          topRight: Radius.circular(25)
        )
      ),
      backgroundColor: Colors.white,
      context: Get.context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: GlobalVariable.ratioHeight(Get.context) * 8,
                bottom: GlobalVariable.ratioHeight(Get.context) * 18
              ),
              child: Container(
                width: GlobalVariable.ratioHeight(Get.context) * 94,
                height: GlobalVariable.ratioHeight(Get.context) * 5,
                decoration: BoxDecoration(
                  color: Color(ListColor.colorLightGrey10),
                  borderRadius: BorderRadius.all(Radius.circular(90))
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(bottom: GlobalVariable.ratioWidth(Get.context) * 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 64,
                        width: GlobalVariable.ratioWidth(context) * 64,
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorBlue),
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                            ),
                            onTap: () {
                              Get.back();
                              getFromCamera();
                            },
                            child: Container(
                              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 20),
                              child: SvgPicture.asset(
                                "assets/ic_camera_seller.svg",
                                color: Colors.white,
                                // width: GlobalVariable.ratioWidth(Get.context) * 24,
                                // height: GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 16,
                      ),
                      CustomText(
                        "BFTMRegisterAllAmbilFoto".tr,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 84,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 64,
                        width: GlobalVariable.ratioWidth(context) * 64,
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorBlue),
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                            ),
                            onTap: () {
                              Get.back();
                              chooseFile();
                            },
                            child: Container(
                              padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 20),
                              child: SvgPicture.asset(
                                "assets/ic_upload_seller.svg",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 16,
                      ),
                      CustomText(
                        "Upload File",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      }
    );
  }

  void getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedFile.value = File(pickedFile.path);
      startProgressBar(selectedFile.value);
      // viewResult(selectedFile.value);
    }
  }
}