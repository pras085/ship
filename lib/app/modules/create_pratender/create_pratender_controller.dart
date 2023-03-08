import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePratenderController extends GetxController {
  // var file = File("").obs;

  var namaController = TextEditingController();
  var tipePickupController = TextEditingController();
  var lokasiPickupController = TextEditingController();
  var lokasiDestinasiController = TextEditingController();
  var jenisTrukController = TextEditingController();
  var jenisKurirController = TextEditingController();
  var jumlahTrukController = TextEditingController();
  var deskripsiController = TextEditingController();
  var pesertaController = TextEditingController();
  var uploadFile = File("").obs;

  var date = DateTime.now().obs;
  var status = "Active".obs;
  var periodeStartDate = DateTime.now().obs;
  var periodeEndDate = DateTime.now().obs;
  var pekerjaanStartDate = DateTime.now().obs;
  var pekerjaanEndDate = DateTime.now().obs;
  final uploader = FlutterUploader();

  @override
  void onInit() {
    uploadFile.value = null;
    periodeStartDate.value = null;
    periodeEndDate.value = null;
    pekerjaanStartDate.value = null;
    pekerjaanEndDate.value = null;
    date.value = null;
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void chooseFile() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "xls", "xlsx"]
    );
    if (pickedFile != null) {
      uploadFile.value = File(pickedFile.files.first.path);
      // final taskId = await uploader.enqueue(
      //   url: "your upload link", //required: url to upload to
      //   files: [FileItem(filename: filename, savedDir: savedDir, fieldname:"file")], // required: list of files that you want to upload
      //   method: UploadMethod.POST, // HTTP method  (POST or PUT or PATCH)
      //   headers: {"apikey": "api_123456", "userkey": "userkey_123456"},
      //   data: {"name": "john"}, // any data you want to send in upload request
      //   showNotification: false, // send local notification (android only) for upload status
      //   tag: "upload 1"); // unique tag for upload task
      // );
      print(pickedFile.names);
    }
  }
}
