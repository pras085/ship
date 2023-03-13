import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:http_parser/src/media_type.dart';

class ApiBuyer {
  final BuildContext context;
  final bool isShowDialogLoading;
  final bool isShowDialogError;
  final bool isDebugGetResponse;

  ApiHelper _apiHelper;

  ApiBuyer(
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

  Future getSubKategori(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlSeller + "buyer/getSubKategori", body);
  }

  Future getData(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
        ApiHelper.urlSeller + "buyer/getData", body);
  }

  Future getDataPromo(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
        ApiHelper.urlSeller + "buyer/getDataPromo", body);
  }

  Future getFormByTagFrontend(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlSeller + "buyer/getFormByTagFrontend", body);
  }

  Future getDataDetail(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlSeller + "buyer/getDataDetail", body);
  }

  Future saveWishlist(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
      ApiHelper.urlSeller + "buyer/saveWishlist",
      body 
    );
  }

  Future getWishlist(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
      ApiHelper.urlSeller + "buyer/getWishlist", 
      body
    );
  }

  Future getRegion(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/get_region", body);
  }

  Future getBrand(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/get_brand", body);
  }
  
  Future getInformationLocationByLatLong(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "api/get_information_location_by_lat_long", body);
  }

  Future getTransporterTruckList(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "backend/get_transporter_truck_list_info", body);
  }

  Future getBuyerBannerAds(Map<String, dynamic> body) async {
    return _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlBanner + "api/get_buyer_banner_ads", body);
  }

  Future updateCountDiaksesBannerAds(Map<String, dynamic> body) async {
    return _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlBanner + "api/update_count_diakses_banner_ads", body);
  }

  Future getContactSellerProfile(String sellerID) async {
    var body = {'UserID' : sellerID};
    return _apiHelper.fetchDataFromUrlPOSTMuatMuatAfterLogin(
        ApiHelper.urlInternal + "base/get_contact_seller_profile", body);
  }

  Future getDataBarangSeller(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
        ApiHelper.urlSeller + "buyer/getDataBarangSeller", body);
  }

  Future getEmailSeller(String sellerID) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
        ApiHelper.urlInternal + "api/get_email_status_by_seller_id", {"SellerID": sellerID});
  }

  Future getDataLayanan(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
        ApiHelper.urlSeller + "buyer/getDataLayanan", body);
  }

  Future getCounterPromoIklan(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
        ApiHelper.urlSeller + "buyer/getCounterPromoIklan", body);
  }

  Future getCounterIklan(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
        ApiHelper.urlFian + "api/get_counter_iklan", body);
  }

  Future getPlacesPromo(Map<String, dynamic> body) async {
    return await _apiHelper.fetchDataFromUrlPOSTMuatMuat(
        ApiHelper.urlzo + "api/get_places_promo", body);
  }

}