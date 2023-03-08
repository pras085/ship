import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/terms_and_conditions_bftm/terms_and_conditions_bftm_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'dart:math' as math;
import 'package:http_parser/src/media_type.dart';
import 'package:mime/src/mime_type.dart';

import '../../../global_variable.dart';

class UploadLegalitasController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;

  var file = File("").obs;
  var fileAkta1 = [].obs;
  var fileAkta2 = [].obs;
  var fileAkta3 = [].obs;
  var fileKtpDirektur = [].obs;
  var fileAkta4 = [].obs;
  var fileNib = [].obs;
  var fileSertifikat = [].obs;
  var fileNpwpPerusahaan = [].obs;
  var fileKtp = [].obs;

  var fileAkta1Result = [].obs;
  var fileAkta2Result = [].obs;
  var fileAkta3Result = [].obs;
  var fileKtpDirekturResult = [].obs;
  var fileAkta4Result = [].obs;
  var fileNibResult = [].obs;
  var fileSertifikatResult = [].obs;
  var fileNpwpPerusahaanResult = [].obs;
  var fileKtpResult = [].obs;

  var fileAkta1Timer = 0.obs;

  var errorMessage = "".obs;
  int changeIndex = -1.obs;

  TextEditingController ktpDirekturController = TextEditingController();
  TextEditingController npwpPerusahaanController = TextEditingController();
  TextEditingController ktpController = TextEditingController();

  // cek validasi di view
  var isValidKtpDirektur = true.obs;
  var isValidNpwpPerusahaan = true.obs;
  var isValidKtp = true.obs;
  var isFilled = false.obs;

  var param = {};

  // file download
  ReceivePort _port = ReceivePort();
  var onDownloading = false.obs;
  var onProgress = 0.0.obs;
  var processing = false.obs;
  var tapDownload = false;
  String filePath = "";
  String downloadId;
  var url = "".obs;

  // var time = 0.obs;
  var totalTime = 10;
  // var ratio = (-1.0).obs;

  var timePerForm = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0].obs;
  var ratioPerForm = [-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0].obs;

  Timer timer;

  @override
  void onInit() {
    super.onInit();
    param = Get.arguments;
    log("Type: " + param["type"].toString());
    log("Entity: " + param["entity"].toString());
    //FlutterStatusbarManager.setColor(Colors.transparent);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future setLegality() async {
    List<String> fileFields = [];
    List<File> files = [];
    List<MediaType> fileContents = [];

    for (var i = 0; i < fileKtpDirektur.length; i++) {
      fileFields.add("FileKtpDirektur[$i]");
      files.addAll(fileKtpDirektur.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileKtpDirektur[i] as File).path)));
    }

    for (var i = 0; i < fileNpwpPerusahaan.length; i++) {
      fileFields.add("FileNpwp[$i]");
      files.addAll(fileNpwpPerusahaan.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileNpwpPerusahaan[i] as File).path)));
    }

    for (var i = 0; i < fileKtp.length; i++) {
      fileFields.add("FileKtpPic[$i]");
      files.addAll(fileKtp.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileKtp[i] as File).path)));
    }

    for (var i = 0; i < fileAkta1.value.length; i++) {
      fileFields.add("FileAktaPendirian[$i]");
      files.addAll(fileAkta1.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileAkta1[i] as File).path)));
    }

    for (var i = 0; i < fileAkta2.value.length; i++) {
      fileFields.add("FileAktaADT[$i]");
      files.addAll(fileAkta2.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileAkta2[i] as File).path)));
    }

    for (var i = 0; i < fileAkta3.value.length; i++) {
      fileFields.add("FileAktaDireksi[$i]");
      files.addAll(fileAkta3.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileAkta3[i] as File).path)));
    }

    for (var i = 0; i < fileAkta4.value.length; i++) {
      fileFields.add("FileAktaPerubahan[$i]");
      files.addAll(fileAkta4.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileAkta4[i] as File).path)));
    }

    for (var i = 0; i < fileNib.value.length; i++) {
      fileFields.add("FileNIB[$i]");
      files.addAll(fileNib.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileNib[i] as File).path)));
    }

    for (var i = 0; i < fileSertifikat.value.length; i++) {
      fileFields.add("FileSertifikatStandard[$i]");
      files.addAll(fileSertifikat.value.map((e) => File((e as File).path)));
      fileContents.add(MediaType.parse(lookupMimeType((fileSertifikat[i] as File).path)));
    }

    await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false).setShipperRegistrationLegality(
      fileFields: fileFields, 
      files: files, 
      fileContents: fileContents,
      body: {
        'KtpDirektur': ktpDirekturController.text,
        'Npwp': npwpPerusahaanController.text,
        'KtpPic': ktpController.text
      }
    );
  }

  Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              key: key,
              backgroundColor: Colors.black54,
              children: <Widget>[
                Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      "Please Wait....",
                      color: Colors.blueAccent,
                    )
                  ]),
                )
              ],
            ),
          );
        });
  }

  showHintFile(int type) {
    // type 1 = akta pendirian
    // type 2 = akta anggaran
    // type 3 = akta direksi
    // type 4 = ktp Direktur
    // type 5 = akta perubahan
    // type 6 = nib
    // type 7 = sertifikat standard
    // type 8 = npwp perusahaan
    // type 9 = ktp pendaftar
    String title = "";
    if(type == 1){
      title = "Contoh File Akta Pendirian Perusahaan dan SK KEMENKUMHAM";
    }
    else if(type == 2){
      title = "Contoh File Akta Anggaran Dasar Terakhir dan SK";
    }
    else if(type == 3){
      title = "Contoh File Akta Direksi dan Dewan Komisaris terakhir dan SK Menkumham";
    }
    else if(type == 5){
      title = "Contoh File Akta Perubahan terakhir dan SK";
    }
    else if(type == 6){
      title = "Contoh File NIB";
    }
    else if(type == 7){
      title = "Contoh File Sertifikat Standar";
    }
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
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 8,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                child: Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 94,
                  height: GlobalVariable.ratioWidth(Get.context) * 5,
                  decoration: BoxDecoration(
                      color: Color(ListColor.colorLightGrey10),
                      borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 90))),
                )),
              Container(
                margin: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16, 
                  GlobalVariable.ratioWidth(Get.context) * 0, 
                  GlobalVariable.ratioWidth(Get.context) * 16, 
                  GlobalVariable.ratioWidth(Get.context) * 16
                ),
                child: CustomText(
                  title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  textAlign: TextAlign.center,
                )
              ),
              Container(
                width: GlobalVariable.ratioWidth(Get.context) * 328,
                height: GlobalVariable.ratioWidth(Get.context) * 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                  border: Border.all(
                    color: Color(ListColor.colorGrey6)
                  )
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
                  child: Image.network(
                    "https://blog-static.mamikos.com/wp-content/uploads/2021/04/Surat-jalan-1.png",
                    fit: BoxFit.fitWidth
                  ),
                ),
              ),
              _button(
                width: 139,
                height: 30,
                marginLeft: 16,
                marginTop: 24,
                marginRight: 16,
                marginBottom: 24,
                useBorder: false,
                borderRadius: 18,
                backgroundColor: Color(ListColor.colorBlue),
                customWidget: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/ic_download.svg",
                      width: GlobalVariable.ratioWidth(Get.context) * 14,
                      height: GlobalVariable.ratioWidth(Get.context) * 14,
                    ),
                    SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 6),
                    CustomText(
                      "Download",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ],
                ),
                onTap: (){
                  downloadFile("https://blog-static.mamikos.com/wp-content/uploads/2021/04/Surat-jalan-1.png");
                }
              )
            ],
          );
      });
  }

  showUpload(int type) {
    // type 1 = akta pendirian
    // type 2 = akta anggaran
    // type 3 = akta direksi
    // type 4 = ktp Direktur
    // type 5 = akta perubahan
    // type 6 = nib
    // type 7 = sertifikat standard
    // type 8 = npwp perusahaan
    // type 9 = ktp pendaftar
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
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: GlobalVariable.ratioWidth(Get.context) * 8,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 18),
                child: Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 94,
                  height: GlobalVariable.ratioWidth(Get.context) * 5,
                  decoration: BoxDecoration(
                      color: Color(ListColor.colorLightGrey10),
                      borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 90))),
                )),
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
                            borderRadius:
                                BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                          ),
                          child: Material(
                            borderRadius:
                                BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(context) * 50),
                              ),
                              onTap: () {
                                Get.back();
                                getFromCamera(type);
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
                          "Ambil Foto",
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
                            borderRadius:
                                BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                          ),
                          child: Material(
                            borderRadius:
                                BorderRadius.circular(GlobalVariable.ratioWidth(context) * 50),
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(context) * 50),
                              ),
                              onTap: () {
                                Get.back();
                                chooseFile(type);
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
      });
  }

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
      startProgressBar(file.value, type);
      // viewResult(file.value, type);
    }
  }

  void getFromGallery(int type) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    _cropImage(pickedFile.path, type);
  }

  void getFromCamera(int type) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      file.value = File(pickedFile.path);
      startProgressBar(file.value, type);
      // viewResult(file.value, type);
    }
  }

  void _cropImage(filePath, int type) async {
    File croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      file.value = croppedImage;
      viewResult(file.value, type);
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

  void viewResult(File file, int type){
    String fileName = basename(file.path).toString();
    log("File: " + fileName);
    if(getFileSize(file) > 5 && !isAllowedFormat(file.path)){
      errorMessage.value = "Format file tidak sesuai ketentuan dan file maksimal 5MB!";
      log("File: " + errorMessage.toString());
      addToList(type, null, errorMessage.value);
    }
    else{
      if(getFileSize(file) <= 5){
        if(isAllowedFormat(file.path)){
          // log("File: " + basename(file.path));
          errorMessage.value = "";
          log("File: SAFE");
          addToList(type, file, fileName);
        }
        else{
          errorMessage.value = "Format file Anda tidak sesuai !";
          log("File: " + errorMessage.toString());
          addToList(type, null, errorMessage.value);
        }
      }
      else{
        errorMessage.value = "Ukuran File melebihi batas 5MB !";
        log("File: " + errorMessage.toString());
        addToList(type, null, errorMessage.value);
      }
    }
    log("List Akta1: " + fileAkta1Result.length.toString());
    log("List Akta2: " + fileAkta2Result.length.toString());
    log("List Akta3: " + fileAkta3Result.length.toString());
    log("List Ktp Direktur: " + fileKtpDirekturResult.length.toString());
    log("List Akta4: " + fileAkta4Result.length.toString());
    log("List Nib: " + fileNibResult.length.toString());
    log("List Sertifikat: " + fileSertifikatResult.length.toString());
    log("List Npwp Perusahaan: " + fileNpwpPerusahaanResult.length.toString());
    log("List Ktp: " + fileKtpResult.length.toString());
    // Navigator.pop(Get.context);

    checkFormFilled();
  }

  void addToList(int type, File file, String message){
    if(type == 1){
      addToAkta1List(file, message);
    }
    else if(type == 2){
      addToAkta2List(file, message);
    }
    else if(type == 3){
      addToAkta3List(file, message);
    } 
    else if(type == 4){
      addToKtpDirekturList(file, message);
    } 
    else if(type == 5){
      addToAkta4List(file, message);
    }
    else if(type == 6){
      addToNibList(file, message);
    } 
    else if(type == 7){
      addToSertifikatList(file, message);
    } 
    else if(type == 8){
      addToNpwpPerusahaanList(file, message);
    } 
    else if(type == 9){
      addToKtpList(file, message);
    } 

    errorMessage.value = "";
    changeIndex = -1;
  }

  void addToAkta1List(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileAkta1Result.length > 0){
        // check previous
        if(fileAkta1[fileAkta1.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileAkta1.length - 1;
          fileAkta1[changeIndex] = file;
          fileAkta1Result[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileAkta1.add(file);
          fileAkta1Result.add(message);
        }
      }
      else{
        fileAkta1.add(file);
        fileAkta1Result.add(message);
      }
    }
    else{
      // update existing
      fileAkta1[changeIndex] = file;
      fileAkta1Result[changeIndex] = message;
    }
  }

  void addToAkta2List(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileAkta2Result.length > 0){
        // check previous
        if(fileAkta2[fileAkta2.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileAkta2.length - 1;
          fileAkta2[changeIndex] = file;
          fileAkta2Result[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileAkta2.add(file);
          fileAkta2Result.add(message);
        }
      }
      else{
        fileAkta2.add(file);
        fileAkta2Result.add(message);
      }
    }
    else{
      // update existing
      fileAkta2[changeIndex] = file;
      fileAkta2Result[changeIndex] = message;
    }
  }

  void addToAkta3List(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileAkta3Result.length > 0){
        // check previous
        if(fileAkta3[fileAkta3.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileAkta3.length - 1;
          fileAkta3[changeIndex] = file;
          fileAkta3Result[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileAkta3.add(file);
          fileAkta3Result.add(message);
        }
      }
      else{
        fileAkta3.add(file);
        fileAkta3Result.add(message);
      }
    }
    else{
      // update existing
      fileAkta3[changeIndex] = file;
      fileAkta3Result[changeIndex] = message;
    }
  }

  void addToKtpDirekturList(File file, String message){
    // single
    if(fileKtpDirekturResult.length > 0){
      changeIndex = 0;
      fileKtpDirektur[changeIndex] = file;
      fileKtpDirekturResult[changeIndex] = message;
    }
    else{
      fileKtpDirektur.add(file);
      fileKtpDirekturResult.add(message);
    }
  }

  void addToAkta4List(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileAkta4Result.length > 0){
        // check previous
        if(fileAkta4[fileAkta4.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileAkta4.length - 1;
          fileAkta4[changeIndex] = file;
          fileAkta4Result[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileAkta4.add(file);
          fileAkta4Result.add(message);
        }
      }
      else{
        fileAkta4.add(file);
        fileAkta4Result.add(message);
      }
    }
    else{
      // update existing
      fileAkta4[changeIndex] = file;
      fileAkta4Result[changeIndex] = message;
    }
  }

  void addToNibList(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileNibResult.length > 0){
        // check previous
        if(fileNib[fileNib.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileNib.length - 1;
          fileNib[changeIndex] = file;
          fileNibResult[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileNib.add(file);
          fileNibResult.add(message);
        }
      }
      else{
        fileNib.add(file);
        fileNibResult.add(message);
      }
    }
    else{
      // update existing
      fileNib[changeIndex] = file;
      fileNibResult[changeIndex] = message;
    }
  }

  void addToSertifikatList(File file, String message){
    if(changeIndex == -1){
      // insert new
      if(fileSertifikatResult.length > 0){
        // check previous
        if(fileSertifikat[fileSertifikat.length - 1] == null){
          // if previous null then update previous
          changeIndex = fileSertifikat.length - 1;
          fileSertifikat[changeIndex] = file;
          fileSertifikatResult[changeIndex] = message;
        }
        else{
          // if not null then insert new
          fileSertifikat.add(file);
          fileSertifikatResult.add(message);
        }
      }
      else{
        fileSertifikat.add(file);
        fileSertifikatResult.add(message);
      }
    }
    else{
      // update existing
      fileSertifikat[changeIndex] = file;
      fileSertifikatResult[changeIndex] = message;
    }
  }

  void addToNpwpPerusahaanList(File file, String message){
    // single
    if(fileNpwpPerusahaanResult.length > 0){
      changeIndex = 0;
      fileNpwpPerusahaan[changeIndex] = file;
      fileNpwpPerusahaanResult[changeIndex] = message;
    }
    else{
      fileNpwpPerusahaan.add(file);
      fileNpwpPerusahaanResult.add(message);
    }
  }

  void addToKtpList(File file, String message){
    // single
    if(fileKtpResult.length > 0){
      changeIndex = 0;
      fileKtp[changeIndex] = file;
      fileKtpResult[changeIndex] = message;
    }
    else{
      fileKtp.add(file);
      fileKtpResult.add(message);
    }
  }

  void checkFormFilled() {
    // if(fileKtpDirektur[0] != null && fileNib[0] != null && fileNpwpPerusahaan[0] != null && fileKtp[0] != null && ktpDirekturController.text.isNotEmpty && npwpPerusahaanController.text.isNotEmpty && ktpController.text.isNotEmpty) {}
    if(ktpDirekturController.text.isNotEmpty && npwpPerusahaanController.text.isNotEmpty && ktpController.text.isNotEmpty) {
      if(fileKtpDirektur.isNotEmpty && fileNib.isNotEmpty && fileNpwpPerusahaan.isNotEmpty && fileKtp.isNotEmpty){
        if(fileKtpDirektur[0] != null && fileNib[0] != null && fileNpwpPerusahaan[0] != null && fileKtp[0] != null){
          isFilled.value = true;
        }
        else{
          isFilled.value = false;
        }
      }
      else{
        isFilled.value = false;
      }
    }
    else {
      isFilled.value = false;
    }
    log("Filled: " + isFilled.value.toString());
    log("Valid Ktp Direktur: " + isValidKtpDirektur.value.toString());
    log("Valid Npwp Perusahaan: " + isValidNpwpPerusahaan.value.toString());
    log("Valid Ktp: " + isValidKtp.value.toString());
  }

  void startProgressBar(File file, int type) {
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) async {
      Utils.checkConnection();
      if (timePerForm[type] == totalTime) {
        viewResult(file, type);
        timer.cancel();
        await Future.delayed(Duration(milliseconds: 500));
        timePerForm[type] = 0;
        ratioPerForm[type] = -1;
      } else {
        timePerForm[type]++;
        ratioPerForm[type] = (timePerForm[type]/totalTime);
      }
    });
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

  void submit() {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "Daftar", 
      context: Get.context,
      customMessage: Container(
        margin: EdgeInsets.only(
          bottom: GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        child: CustomText(
          "Apakah Anda yakin data yang Anda inputkan sudah benar dan tidak ada data yang ingin diubah?",
          textAlign: TextAlign.center,
          fontSize: 14,
          height: 21 / 14,
          color: Colors.black,
          fontWeight: FontWeight.w600
        ),
      ),
      borderRadius: 12,
      labelButtonPriority1: "Batal",
      labelButtonPriority2: "Simpan",
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      onTapPriority1: () {
        // Get.back();
      },
      onTapPriority2: () {
        // CustomToastTop.show(
        //   context: Get.context, 
        //   message: "SUCCESS",
        //   isSuccess: 1
        // );
        GetToPage.toNamed<TermsAndConditionsBFTMController>(
          Routes.TERMS_AND_CONDITIONS_BFTM,
          arguments: param
        );
      },
      widthButton1: 81,
      widthButton2: 81,
      heightButton1: 31,
      heightButton2: 31,
    );
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  void bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, "downloader_send_port");
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    _port.listen((message) {
      onProgress.value = message[2] / 100;
      print(message[2].toString());
      if (message[2] == 100.0 && onDownloading.value) {
        onDownloading.value = false;
        if (tapDownload) {
          CustomToast.show(
            context: Get.context,
            message: "DetailTransporterLabelDownloadComplete".tr
          );
        } else {
          Share.shareFiles([filePath]);
        }
      }
    });
  }

  static void downloadCallBack(id, status, progress) {
    SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  Future<String> _findLocalPath() async {
    if (!Platform.isAndroid) {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
    return "/storage/emulated/0/";
  }

  Future downloadFile(String url) async {
    print(url);
    print(url.split(".")[url.split(".").length - 1]);
    var status = await Permission.storage.request();
    if (status.isGranted) {
      onDownloading.value = true;
      onProgress.value = 0.0;
      processing.value = true;
      var savedLocation = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
      processing.value = false;
      downloadId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: savedLocation,
        showNotification: true,
        fileName: "${DateFormat('ddMMyyyyhhmmss').format(DateTime.now())}.${url.split(".")[url.split(".").length - 1]}",
        openFileFromNotification: true
      );
    } else {
      print('Permission Denied!');
    }
  }

  Widget _button({
    double height,
    double width,
    bool maxWidth = false,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double paddingLeft = 0,
    double paddingTop = 0,
    double paddingRight = 0,
    double paddingBottom = 0,
    bool useShadow = false,
    bool useBorder = false,
    double borderRadius = 18,
    double borderSize = 1,
    String text = "",
    @required Function onTap,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 14,
    Color color = Colors.white,
    Color backgroundColor = Colors.white,
    Color borderColor,
    Widget customWidget,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GlobalVariable.ratioWidth(Get.context) * marginLeft,
          GlobalVariable.ratioWidth(Get.context) * marginTop,
          GlobalVariable.ratioWidth(Get.context) * marginRight,
          GlobalVariable.ratioWidth(Get.context) * marginBottom),
      width: width == null
          ? maxWidth
              ? MediaQuery.of(Get.context).size.width
              : null
          : GlobalVariable.ratioWidth(Get.context) * width,
      height: height == null
          ? null
          : GlobalVariable.ratioWidth(Get.context) * height,
      decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: useShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: Color(ListColor.shadowColor).withOpacity(0.08),
                    blurRadius: GlobalVariable.ratioWidth(Get.context) * 4,
                    spreadRadius: 0,
                    offset:
                        Offset(0, GlobalVariable.ratioWidth(Get.context) * 2),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(
              GlobalVariable.ratioWidth(Get.context) * borderRadius),
          border: useBorder
              ? Border.all(
                  width: GlobalVariable.ratioWidth(Get.context) * borderSize,
                  color: borderColor ?? Color(ListColor.colorBlue),
                )
              : null),
      child: Material(
        borderRadius: BorderRadius.circular(
            GlobalVariable.ratioWidth(Get.context) * borderRadius),
        color: Colors.transparent,
        child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  GlobalVariable.ratioWidth(Get.context) * borderRadius),
            ),
            onTap: () {
              onTap();
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * paddingLeft,
                  GlobalVariable.ratioWidth(Get.context) * paddingTop,
                  GlobalVariable.ratioWidth(Get.context) * paddingRight,
                  GlobalVariable.ratioWidth(Get.context) * paddingBottom),
              width: maxWidth ? double.infinity : null,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: customWidget == null
                  ? CustomText(
                      text ?? "",
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: color,
                    )
                  : customWidget,
            )),
      ),
    );
  }

  getApplicationDocumentsDirectory() {}
}
