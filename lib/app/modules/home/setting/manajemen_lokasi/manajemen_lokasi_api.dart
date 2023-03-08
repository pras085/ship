import 'package:get/get.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/detail_manajemen_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/detail_manajemen_lokasi_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/manajemen_lokasi_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/update_delete_save_location_response_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class ManajemenLokasiAPI {
  static Future getDetail(String docID,
      {bool isShowDialogLoading = true}) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: isShowDialogLoading,
            isShowDialogError: true)
        .fetchDetailManajemenLokasi(docID);
    if (responseBody != null) {
      DetailManajemenLokasiResponseModel response =
          DetailManajemenLokasiResponseModel.fromJson(responseBody);
      return response;
    }
    return null;
  }

  static Future getLocation(
    String userID, {
    int offset = 0,
    int limit: 3,
    String searchValue = "",
    Map<dynamic, dynamic> order,
  }) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .fetchListManagementLokasi(searchValue, null,
            order != null ? order : {}, limit, offset, userID);
    if (responseBody != null) {
      ManajemenLokasiResponseModel response =
          ManajemenLokasiResponseModel.fromJson(responseBody);
      return response;
    }
    return null;
  }

  static Future addData(DetailManajemenLokasiModel detailManajemenLokasiModel,
      {bool isShowDialogLoading = true}) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: isShowDialogLoading,
            isShowDialogError: true)
        .fetchAddManajemenLokasi(detailManajemenLokasiModel);
    if (responseBody != null) {
      UpdateDeleteSaveLocationResponseModel response =
          UpdateDeleteSaveLocationResponseModel.fromJson(responseBody);
      return response;
    }
    return null;
  }

  static Future updateData(
      DetailManajemenLokasiModel detailManajemenLokasiModel,
      {bool isShowDialogLoading = true}) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: isShowDialogLoading,
            isShowDialogError: true)
        .fetchUpdateManajemenLokasi(detailManajemenLokasiModel);
    if (responseBody != null) {
      UpdateDeleteSaveLocationResponseModel response =
          UpdateDeleteSaveLocationResponseModel.fromJson(responseBody);
      return response;
    }
    return null;
  }

  static Future deleteData(String docID,
      {bool isShowDialogLoading = true}) async {
    var responseBody = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: isShowDialogLoading,
            isShowDialogError: true)
        .fetchDeleteManajemenLokasi(docID);
    if (responseBody != null) {
      UpdateDeleteSaveLocationResponseModel response =
          UpdateDeleteSaveLocationResponseModel.fromJson(responseBody);
      return response;
    }
    return null;
  }
}
