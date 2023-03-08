import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:http_parser/src/media_type.dart';

class ApiProfile {
  final BuildContext context;
  final bool isShowDialogLoading;
  final bool isShowDialogError;
  final bool isDebugGetResponse;

  ApiHelper _apiHelper;

  ApiProfile(
      {@required this.context,
      this.isShowDialogLoading = false,
      this.isShowDialogError = false,
      this.isDebugGetResponse = false}) {
    _apiHelper = ApiHelper(
      context: context,
      isShowDialogLoading: isShowDialogLoading,
      isShowDialogError: isShowDialogError,
      isDebugGetResponse: isDebugGetResponse,
    );
  }

  Future getUserStatus(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/get_user_status", body);
  }

  Future getUsersMuat(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/get_users_muat", body);
  }

  Future getListTimezone(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.url + "base/get_list_timezone", body);
  }

  Future getListLanguage(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/get_list_language", body);
  }

  Future setUserLanguage(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/set_user_language", body);
  }

  Future termsConditionType(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/terms_condition_type", body);
  }

  Future doUpdateTimeZoneUser(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.url + "backend/doUpdateTimezoneUser", body);
  }

  Future setShipperCapacityQty(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/set_shipper_capacity_qty", body);
  }

  Future setTmShipperCapacityQty(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/set_tm_shipper_capacity_qty", body);
  }

  Future getShipperReputasiAdminAndStatus(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/get_shipper_reputasi_admin_and_status",
        body);
  }

  Future getDataUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/get_data_users", body);
  }

  Future getDataProfileSubGeneralCompany(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/get_data_profile_sub_general_company",
        body);
  }

  Future getDataKelengkapanLegalitasPerusahaan(
      Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal +
            "backend/get_data_kelengkapan_legalitas_perusahaan",
        body);
  }

  Future getDataKelengkapanLegalitasIndividu(
      Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal +
            "backend/get_data_kelengkapan_legalitas_users",
        body);
  }

  Future getAllTestimonialShipperToTransporterTabShipper(
      Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal +
            "backend/get_all_testimonial_shipper_to_transporter_tab_shipper",
        body);
  }

  Future getAllTestimonialShipperToTransporterTabTransporter(
      Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal +
            "backend/get_all_testimonial_shipper_to_transporter_tab_transporter",
        body);
  }

  Future doUpdateTestimonialShipperToTransporter(
      Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal +
            "backend/do_update_testimonial_shipper_to_transporter",
        body);
  }

  Future updatePhotoProfile(String image) async {
    var body = {"Image": image};
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/update_profile_picture_users', body);
  }

  Future deletePhotoProfile(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/delete_profile_picture_users', body);
  }

  Future deleteLogoCompany(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/delete_profile_picture_company', body);
  }

  Future getDataPicShipper(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/get_data_pic_shipper', body);
  }

  Future doUpdateDataPicShipper(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/doUpdate_data_pic_shipper', body);
  }

  Future doUpdateProfileCompany(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/doUpdate_profile_company_apps', body);
  }

  Future getTimerSetting(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'api/get_timer_setting', body);
  }

  Future otpConfirmUsersPhone(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/otp_confirm_users_phone', body);
  }

  Future zipFileOnDownload(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/zip_file_on_download", body);
  }

  Future uploadMultipleFileV2(Map<String, dynamic> body, {List<String> fileFields, List<File> files, List<MediaType> fileContents, OnUploadProgressCallback onUploadProgressCallback}) async {
    return await _apiHelper.sendMultipart(
        ApiHelper.urlInternal + "backend/upload_multiple_file_v2", body,
          fileFields: fileFields,
          files: files,
          fileContents: fileContents,
          onUploadProgressCallback: onUploadProgressCallback,
        );
  }

  Future deleteMultipleFileV2(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/delete_multiple_file_v2", body);
  }

  Future checkOtpConfirmUsersPhone(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/check_otp_confirm_users_phone', body);
  }

  Future otpChangeWaUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/otp_change_wa_users', body);
  }

  Future checkOtpChangeWaUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/check_otp_change_wa_users', body);
  }

  Future resendOtpChangeWaUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/resend_otp_change_wa_users', body);
  }

  Future getTimerSettingEmail(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'api/get_timer_setting_email', body);
  }

  // Future otpConfirmUsersEmail(Map<String, dynamic> body) async {
  //   return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //       ApiHelper.urlInternal + 'backend/otp_confirm_users_email', body);
  // }

  // Future checkOtpConfirmUsersEmail(Map<String, dynamic> body) async {
  //   return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //       ApiHelper.urlInternal + 'backend/check_otp_confirm_users_email', body);
  // }

  Future otpEmailUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/otp_email_users', body);
  }

  Future checkOtpEmailUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/check_otp_email_users', body);
  }

  Future resendOtpEmailUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/resend_otp_email_users', body);
  }

  Future getTransporterReputasiAdminAndStatus(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/get_transporter_reputasi_admin_and_status", body);
  }

  Future getGoldTransporterStatus(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/get_gold_transporter_status", body);
  }

  // Future doChangePasswordUsers(Map<String, dynamic> body) async {
  //   return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //       ApiHelper.urlInternal + 'backend/do_change_password_users', body);
  // }

  // Future otpForgotPasswordUsers(Map<String, dynamic> body) async {
  //   return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //       ApiHelper.urlInternal + 'backend/otp_forgot_password_users', body);
  // }

  // Future checkOtpForgotPasswordUsers(Map<String, dynamic> body) async {
  //   return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //       ApiHelper.urlInternal + 'backend/check_otp_forgot_password_users', body);
  // }

  // Future resendOtpForgotPasswordUsers(Map<String, dynamic> body) async {
  //   return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //       ApiHelper.urlInternal + 'backend/resend_otp_forgot_password_users', body);
  // }

  // Future forgotPasswordUsers(Map<String, dynamic> body) async {
  //   return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
  //       ApiHelper.urlInternal + 'backend/forgot_password_users', body);
  // }

  Future doCheckPasswordUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/do_check_password_users_apps', body);
  }

  Future checkOtpConfirmUsersPassword(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/check_otp_confirm_users_password', body);
  }

  Future doChangePasswordUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/do_change_password_users_apps', body);
  }

  Future updatePhotoProfileCompany(String image) async {
    var body = {"Image": image};
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/update_profile_picture_company', body);
  }

  Future getDistrictsByToken(String id) async {
    var body = {"place_id": id};
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'api/get_districts_by_token', body);
  }  

  Future getAutoCompleteStreet(String search) async {
    var body = {"phrase": search};
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'api/get_autocomplete_street_json', body);
  }

  Future getDataPribadiUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/get_data_pribadi_users', body);
  }
  
  Future getDataUsahaUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/get_data_usaha_users', body);
  }

  Future getDataKapasitasPengirimanShipper(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/get_data_kapasitas_pengiriman_shipper', body);
  }

  Future getNotifSetting(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/get_notif_setting', body);
  }

  Future setNotifSettingAll(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/set_notif_setting_all', body);
  }

  Future setNotifSetting(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/set_notif_setting', body);
  }

  Future setNotifSettingChild(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/set_notif_setting_child', body);
  }
  
  Future getKecamatan(String search) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "base/get_independent_district", {"search": search});
  }

  Future getPostalCode(String districtId) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "base/get_postal_code", {"DistrictID": districtId});
  }

  Future getDataTransporterProfilePerusahaan(String targetUserID) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/get_data_transporter_profile_perusahaan', {'TargetUserID':targetUserID});
  }

  Future getFotoVideoTransporter(String targetUserID) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/get_foto_video_transporter", {'TargetUserID':targetUserID});
  }

   Future getDataPicTransporter(String targetUserID) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/get_data_pic_transporter', {'TargetUserID':targetUserID});
  }

  Future updateDataUsahaUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/update_data_usaha_users', body);
  }

  Future updateDataPribadiUsers(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + 'backend/update_data_pribadi_users', body);
  }
}
