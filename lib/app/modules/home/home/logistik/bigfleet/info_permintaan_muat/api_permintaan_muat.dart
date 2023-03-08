import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:muatmuat/app/network/api_helper.dart';

class ApiPermintaanMuat {
  final BuildContext context;
  final bool isShowDialogLoading;
  final bool isShowDialogError;
  final bool isDebugGetResponse;

  ApiPermintaanMuat(
      {this.context,
      this.isShowDialogLoading = true,
      this.isShowDialogError = true,
      this.isDebugGetResponse = false});

  Future fetchInfoPermintaanMuat(
      {String search,
      Map<dynamic, dynamic> order,
      Map<dynamic, dynamic> filter,
      int limit,
      int pageNow,
      bool isHistory = false}) async {
    var query = {
      "search": search,
      "limit": limit.toString(),
      "pageNow": pageNow.toString()
    };
    if (isHistory) {
      query["history"] = "1";
    }
    if (filter.isNotEmpty) {
      query["filter"] = jsonEncode(filter);
    }
    if (order.isNotEmpty) {
      var stringOrder = "";
      order.keys.forEach((element) {
        if (order.keys.first == element) {
          stringOrder += element;
        } else {
          stringOrder += ",$element";
        }
      });
      var stringOrderMode = "";
      order.values.forEach((element) {
        if (order.values.first == element) {
          stringOrderMode += element;
        } else {
          stringOrderMode += ",$element";
        }
      });
      query["sortBy"] = stringOrder;
      query["sortType"] = stringOrderMode;
    }
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_data_permintaan_muat", query);
  }

  Future getListDiumumkan(String shipperID) async {
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_data_diumumkan_kepada_permintaan_muat",
            {"ShipperID": shipperID});
  }

  Future createPermintaanMuat(
      String shipperID,
      String tanggalDibuat,
      String tipePickup,
      String jumlahLokasiPickup,
      List latPickUp,
      List lngPickup,
      List pickUpAddress,
      List pickUpDetailAddress,
      List pickupCity,
      List pickupDistrict,
      List pickupNamaPic,
      List pickupNoPic,
      String estimasiPickup,
      String tipeBongkar,
      String jumlahLokasiBongkar,
      List latBongkar,
      List lngBongkar,
      List addressBongkar,
      List detailBongkar,
      List cityBongkar,
      List districtBongkar,
      List namaPicBongkar,
      List bongkarNoPic,
      String estimasiBongkar,
      String jenisTruck,
      String jenisCarrier,
      String jumlahTruck,
      String deskripsiMuatan,
      String berat,
      String volume,
      String dimensi,
      String jumlahKoli,
      String deskripsi,
      Map invitation,
      String zonaMuat,
      String zonaBongkar) async {
    var query = {
      "ShipperID": shipperID,
      "tanggal_dibuat": tanggalDibuat,
      "tipePickUp": tipePickup,
      "jumlahLokasiPickUp": jumlahLokasiPickup,
      "latPickUp": jsonEncode(latPickUp),
      "lngPickUp": jsonEncode(lngPickup),
      "pickUpAddress": jsonEncode(pickUpAddress),
      "pickUpDetailAddress": jsonEncode(pickUpDetailAddress),
      "cityPickup": jsonEncode(pickupCity),
      "districtPickup": jsonEncode(pickupDistrict),
      "pickup_nama_pic": jsonEncode(pickupNamaPic),
      "pickup_no_pic": jsonEncode(pickupNoPic),
      "estimasi_pickup": estimasiPickup,
      "tipeBongkar": tipeBongkar,
      "jumlahLokasiBongkar": jumlahLokasiBongkar,
      "latBongkar": jsonEncode(latBongkar),
      "lngBongkar": jsonEncode(lngBongkar),
      "addressBongkar": jsonEncode(addressBongkar),
      "detailBongkar": jsonEncode(detailBongkar),
      "cityBongkar": jsonEncode(cityBongkar),
      "districtBongkar": jsonEncode(districtBongkar),
      "bongkar_nama_pic": jsonEncode(namaPicBongkar),
      "bongkar_no_pic": jsonEncode(bongkarNoPic),
      "estimasi_bongkar": estimasiBongkar,
      "jenis_truck": jenisTruck,
      "jenis_carrier": jenisCarrier,
      "jumlah_truck": jumlahTruck,
      "deskripsimuatan": deskripsiMuatan,
      "berat": berat,
      "volume": volume,
      "dimensi": dimensi,
      "jumlah_koli": jumlahKoli,
      "deskripsi": deskripsi,
      "invitation": jsonEncode(invitation),
      "zona_muat_code": zonaMuat,
      "zona_bongkar_code": zonaBongkar
    };
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/save_data_permintaan_muat", query);
  }

  Future detailPermintaanMuat(String shipperID, String muatID) async {
    var query = {"ShipperID": shipperID, "PermintaanMuatID": muatID};
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/get_data_detail_permintaan_muat", query);
  }

  Future updatePermintaanMuat(
      String shipperID, String muatID, List deskripsi, String status) async {
    var query = {
      "ShipperID": shipperID,
      "PermintaanMuatID": muatID,
      "deskripsi": jsonEncode(deskripsi),
      "status": status
    };
    return await ApiHelper(context: context, isShowDialogLoading: false)
        .fetchDataFromUrlPOSTMuatMuatAfterLogin(
            ApiHelper.url + "backend/save_data_edit_permintaan_muat", query);
  }
}
