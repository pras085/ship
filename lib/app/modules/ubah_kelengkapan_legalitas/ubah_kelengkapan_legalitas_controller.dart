import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/home/profile/profil_controller.dart';
import 'package:muatmuat/app/modules/ubah_kelengkapan_legalitas/ubah_kelengkapan_legalitas_model.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:mime/mime.dart';
import 'package:muatmuat/app/utils/upload_model.dart';

class UbahKelengkapanLegalitasController extends GetxController {

  var dataModelResponse = ResponseState<UbahKelengkapanLegalitasModel>().obs;
  final scrollController = ScrollController();
  var mapController = MapController();
  final profilController = Get.find<ProfilController>();
  var bCategory = 0;
  String subject = "";

  var aktaUpload = UploadModel().obs;
  var sertifikatUpload = UploadModel().obs;

  @override
  void onInit() async {
    super.onInit();
    fetchDataLegalitas();
    bCategory = profilController.userStatus.businessCategory;
    subject = bCategory == 1 ? "Direktur" : bCategory == 2 ? "Pengurus" : "-";
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    super.onClose();
  }

  // type = 0 => akta | 1 => sertifikat
  void uploadFile(String field, int type) async {
    try {
      FilePickerResult pickedFile = await FilePicker.platform.pickFiles();
      if (pickedFile != null) {
        final file = File(pickedFile.files.first.path);
        if(getFileSize(file) > 5 || !isAllowedFormat(file.path, 1)) {
          if (getFileSize(file) > 5) {
            if (type == 0) {
              aktaUpload.value = UploadModel(
                errorMessage: "Format file tidak sesuai ketentuan dan file maksimal 5MB!",
              );
            } else if (type == 1) {
              sertifikatUpload.value = UploadModel(
                errorMessage: "Format file tidak sesuai ketentuan dan file maksimal 5MB!",
              );
            }
          }
          if (!isAllowedFormat(file.path, 1)) {
            if (type == 0) {
              aktaUpload.value = UploadModel(
                errorMessage: "GlobalValidationLabelFileFormatAndSize".tr,
              );
            } else if (type == 1) {
              sertifikatUpload.value = UploadModel(
                errorMessage: "GlobalValidationLabelFileFormatAndSize".tr,
              );
            }
          }
        } else {
          if (type == 0) {
            aktaUpload.value = UploadModel(
              isUpload: true,
              errorMessage: "",
            );
          } else if (type == 1) {
            sertifikatUpload.value = UploadModel(
              isUpload: true,
              errorMessage: "",
            );
          }
          List<String> fileFields = [];
          List<File> files = [];
          List<MediaType> fileContents = [];
          fileFields.add("DocumentFile[0]");
          files.add(file);
          fileContents.add(MediaType.parse(lookupMimeType(file.path)));
          await ApiProfile(
            context: Get.context,
          ).uploadMultipleFileV2({
            'FieldName': field,
            'UserType': "1",
            'MimeType': "0",
            'MaxFileSize': "5",
            'Role': "0",
            'SuperMenuID': "0",
          },
            fileFields: fileFields,
            files: files,
            fileContents: fileContents,
            onUploadProgressCallback: (sent, total) {
              print("UPLOAD PROGRESS : $sent/$total ${DateTime.now().toString()}");
              if (type == 0) {
                aktaUpload.value = UploadModel(
                  isUpload: sent == total ? false : true,
                  sent: sent,
                  total: total,
                );
              } else if (type == 1) {
                sertifikatUpload.value = UploadModel(
                  isUpload: sent == total ? false : true,
                  sent: sent,
                  total: total,
                );
              }
            }
          );
          fetchDataLegalitas(isRefresh: false);
        }
      }
    } catch (e) {
      print("ERROR $e");
    }
  }

  void deleteFile(int id, String field) async {
    try {
      // update the ui
      final data = dataModelResponse.value;
      data.data.file.removeWhere((el) => el.fileID == id);
      dataModelResponse.value = ResponseState.complete<UbahKelengkapanLegalitasModel>(data.data);
      // update the database via API
      final Map<String, dynamic> body = {
        'FileID': "$id",
        'FieldName': field,
        'UserType': "1",
        'Role': "0",
        'SuperMenuID': "0",
      };
      await ApiProfile(
        context: Get.context,
        isShowDialogLoading: true,
      ).deleteMultipleFileV2(body);
    } catch (error) {
      CustomToastTop.show(
        context: Get.context, 
        isSuccess: 0,
        message: "$error",
      );
    }
  }

  void fetchDataLegalitas({isRefresh = true}) async {
    try {
      if (isRefresh) dataModelResponse.value = ResponseState.loading();
      final response = await ApiProfile(context: Get.context).getDataKelengkapanLegalitasPerusahaan({});
      if (response != null) {
        // convert json to object
        dataModelResponse.value = ResponseState.complete(UbahKelengkapanLegalitasModel.fromJson(response));
        if (dataModelResponse.value.data.message.code == 200) {
          // sukses
        } else {
          // error
          if (dataModelResponse.value.data.message != null && dataModelResponse.value.data.message.code == 200) {
            throw("${dataModelResponse.value.data.message.text}");
          }
          throw("failed to fetch data!");
        }
      } else {
        // error
        throw("failed to fetch data!");
      }
    } catch (error) {
      // error
      print("ERROR :: $error");
      dataModelResponse.value = ResponseState.error("$error");
    }
  }

  double getFileSize(File file){
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    return sizeInMb;
  }

  bool isAllowedFormat(String path, int type) {
    final mimeType = lookupMimeType(path);
    return type == 0 ? mimeType.endsWith('sheet') : (mimeType.endsWith('jpg') || mimeType.endsWith('jpeg') || mimeType.endsWith('png') || mimeType.endsWith('pdf') || mimeType.endsWith('zip'));
  }

}
