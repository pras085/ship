import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:mime/mime.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:mime/src/mime_type.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:path/path.dart';

class ReportController extends GetxController {
  var loading = false.obs;
  var isFilled = false.obs;
  var isFilledSecondPage = false.obs;
  
  var pageIndex = 1.obs;
  var scrollControllerFirstPage = ScrollController();
  var scrollControllerSecondPage = ScrollController();

  var file = File("").obs;
  var fileProof = [].obs;
  var fileProofResult = [].obs;
  var fileProofScrollController = ScrollController();
  var errorMessage = "".obs;
  int changeIndex = -1.obs;

  Timer timer;
  var totalTime = 10;
  var timePerForm = [0].obs;
  var ratioPerForm = [-1.0].obs;

  var reportCategory = [].obs;
  var groupValue = "".obs;

  var textEditingController = TextEditingController();
  var counter = 0.obs;

  var transporterId = "".obs;
  var selectedCategory = "".obs;

  @override
  void onInit() async {
    super.onInit();
    // PENYESUAIAN PROFILE PENGGUNA LAIN
    transporterId.value = "169";
    loading.value = true;
    final result = await ApiHelper(context: Get.context, isShowDialogLoading: false, isDebugGetResponse: false).getReportCategory();
    if (result['Message']['Code'] == 200) {
      
      reportCategory.value = (result['Data']['Categories']).map((e) => {
        'ID': e['ID'],
        'name': e['Description']
      }).toList();
    }
    loading.value = false;
  }

  Future doReport() async {
    List<String> fileFields = [];
    List<MediaType> fileContents = [];
    for (var i = 0; i < fileProof.value.length; i++) {
      fileFields.add("FileBuktiLaporan[$i]");
      fileContents.add(MediaType.parse(lookupMimeType((fileProof.value[i] as File).path)));
    }
    await ApiHelper(context: Get.context).reportTransporter(
      body: {
        "TransporterID": transporterId.value,
        "CategoryID": selectedCategory.value,
        "Description": textEditingController.text
      },
      fileFields: fileFields, 
      files: fileProof.value.map((e) => File((e as File).path)).toList(), 
      fileContents: fileContents,
    );
    Get.back(result: true);
  }

  void back() {
    if (pageIndex.value == 1) {
      Get.back();
    } else {
      fileProof.clear();
      fileProofResult.clear();
      file.value = File("");
      changeIndex = -1;
      errorMessage.value = "";
      pageIndex.value = 1;
    }
  }

  void checkFormFilled(int pageIdx) {
    if(pageIdx == 1) {
      isFilled.value = groupValue.value.isNotEmpty;
    } else if(pageIdx == 2) {
      isFilledSecondPage.value = counter > 0;
    }
  }

  // Upload
  showUpload() {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 25), 
          topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 25)
        )
      ),
      backgroundColor: Colors.white,
      context: Get.context,
      builder: (context) {
        FocusManager.instance.primaryFocus.unfocus();
        FocusScope.of(context).unfocus();
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: GlobalVariable.ratioWidth(Get.context) * 8,
                bottom: GlobalVariable.ratioWidth(Get.context) * 18
              ),
              child: Container(
                width: GlobalVariable.ratioWidth(Get.context) * 94,
                height: GlobalVariable.ratioWidth(Get.context) * 5,
                decoration: BoxDecoration(
                  color: Color(ListColor.colorLightGrey10),
                  borderRadius: BorderRadius.all(
                    Radius.circular(GlobalVariable.ratioWidth(Get.context) * 90)
                  )
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
                      SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
                      CustomText(
                        "Ambil Foto",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 84),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: GlobalVariable.ratioWidth(context) * 64,
                        width: GlobalVariable.ratioWidth(context) * 64,
                        decoration: BoxDecoration(
                          color: Color(ListColor.colorBlue),
                          borderRadius:
                            BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50
                          ),
                        ),
                        child: Material(
                          borderRadius:
                              BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
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
                                // width: GlobalVariable.ratioWidth(Get.context) * 24,
                                // height: GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
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
  
  void chooseFile() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      // log("Choosen File: " + pickedFile.names.toString());
      log("Choosen File: " + pickedFile.files.first.name.toString());
      log("Choosen File: " + pickedFile.files.first.size.toString());
      log("Choosen File: " + pickedFile.files.first.extension.toString());
      log("Choosen File: " + pickedFile.files.first.path.toString());
      // file.value = File(pickedFile.files.single.path);
      file.value = File(pickedFile.files.first.path);
      startProgressBar(file.value);
      // viewResult(file.value, type);
    }
  }

  void getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    _cropImage(pickedFile.path);
  }

  void getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      file.value = File(pickedFile.path);
      startProgressBar(file.value);
      // viewResult(file.value, type);
    }
  }

  void _cropImage(filePath) async {
    File croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      file.value = croppedImage;
      viewResult(file.value);
    }
  }

  double getFileSize(File file){
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    return sizeInMb;
  }

  bool isAllowedFormat(String path) {
    final mimeType = lookupMimeType(path);

    log("File mimetype: " + mimeType);
    if(mimeType.endsWith('jpg') || mimeType.endsWith('jpeg') || mimeType.endsWith('png') || mimeType.endsWith('pdf') || mimeType.endsWith('zip')){
      return true;
    }

    return false;
  }

  void viewResult(File file){
    String fileName = basename(file.path).toString();
    log("File: " + fileName);
    if(isAllowedFormat(file.path)){
      if(getFileSize(file) <= 5){
        errorMessage.value = "";
        log("File: SAFE");
        addToList(file, fileName);
      }
      else{
        // errorMessage.value = "Ukuran File melebihi batas 5MB !";
        errorMessage.value = "GlobalValidationLabelFileSize5Mb".tr;
        log("File Error: " + errorMessage.toString());
        addToList(null, errorMessage.value);
      }
    } else{
      // errorMessage.value = "Format file Anda tidak sesuai !";
      errorMessage.value = "GlobalValidationLabelFileFormatIncorrect".tr;
      log("File Error: " + errorMessage.toString());
      addToList(null, errorMessage.value);
    }

    checkFormFilled(pageIndex.value);
  }

  void addToList(File file, String message){
    addToProofList(file, message);
    errorMessage.value = "";
    changeIndex = -1;
  }

  void addToProofList(File file, String message) {
    if (changeIndex == -1) {
      // insert new
      if (fileProofResult.length > 0) {
        // check previous
        if (fileProof[fileProof.length - 1] == null) {
          // if previous null then update previous
          changeIndex = fileProof.length - 1;
          fileProof[changeIndex] = file;
          fileProofResult[changeIndex] = message;
        } else {
          // if not null then insert new
          fileProof.add(file);
          fileProofResult.add(message);
        }
      } else {
        fileProof.add(file);
        fileProofResult.add(message);
      }
    } else {
      // update existing
      fileProof[changeIndex] = file;
      fileProofResult[changeIndex] = message;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fileProofScrollController.animateTo(fileProofScrollController.position.maxScrollExtent, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void startProgressBar(File file) {
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) async {
      Utils.checkConnection();
      if (timePerForm[0] == totalTime) {
        viewResult(file);
        timer.cancel();
        await Future.delayed(Duration(milliseconds: 500));
        timePerForm[0] = 0;
        ratioPerForm[0] = -1;
      } else {
        timePerForm[0]++;
        ratioPerForm[0] = (timePerForm[0]/totalTime);
      }
    });
  }
}