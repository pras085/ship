import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/manajemen_lokasi_api.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/detail_manajemen_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/detail_manajemen_lokasi_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/manajemen_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/edit_manajemen_lokasi_info_permintaan_muat/edit_manajemen_lokasi_info_permintaan_muat_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/map_management_lokasi/map_management_lokasi_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class DetailManajemenLokasiController extends GetxController {
  static final String typeEditManajemenLokasiInfoPermintaanMuatKey =
      "TypeEditManajemenLokasiInfoPermintaanMuat";
  static final String addressKey = "Address";
  static final String placeIDKey = "PlaceID";
  static final String manajemenLokasiModelKey = "ManajemenLokasiModel";

  final formKey = GlobalKey<FormState>().obs;

  final namaLokasi = "".obs;
  final lokasi = "".obs;
  final detailLokasi = "".obs;
  final namaPIC = "".obs;
  final postalCode = "".obs;
  final noTelpPIC = "".obs;

  final district = "".obs;
  final city = "".obs;
  final province = "".obs;

  LatLng latLng;

  bool isValidateOnChange = true;
  bool isChange = false;
  var loading = true.obs;

  TypeEditManajemenLokasiInfoPermintaanMuat typeEdit;

  final mapController = MapController().obs;

  bool _isFirstTimeBuildWidget = true;

  DetailManajemenLokasiModel detailManajemenLokasiModel =
      DetailManajemenLokasiModel();

  String _addressFromArgms = "";
  String _placeIDFromArgms = "";

  ManajemenLokasiModel _manajemenLokasiModelFromArgms;

  @override
  void onInit() {
    typeEdit = Get.arguments[typeEditManajemenLokasiInfoPermintaanMuatKey];
    _manajemenLokasiModelFromArgms = Get.arguments[manajemenLokasiModelKey];
    _addressFromArgms = Get.arguments[addressKey];
    _placeIDFromArgms = Get.arguments[placeIDKey];
    if (typeEdit == TypeEditManajemenLokasiInfoPermintaanMuat.UPDATE) {
      _typeUpdate();
    }
    isChange = false;
    print('Debug: ' + 'onInit isChange = ' + isChange.toString());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onCompleteBuildWidget() async {
    if (_isFirstTimeBuildWidget) {
      _isFirstTimeBuildWidget = false;
      await getDetail();
      isChange = false;
      print('Debug: ' +
          'onCompleteBuildWidget isChange = ' +
          isChange.toString());
    } else {
      print('Debug: ' +
          'not onCompleteBuildWidget isChange = ' +
          isChange.toString());
    }
  }

  Future getDetail() async {
    loading.value = true;
    DetailManajemenLokasiResponseModel response =
        await ManajemenLokasiAPI.getDetail(
            detailManajemenLokasiModel.manajemenLokasiModel.id);
    if (response != null) {
      detailManajemenLokasiModel = response.detailManajemenLokasiModel;
      district.value = detailManajemenLokasiModel.manajemenLokasiModel.district;
      city.value = detailManajemenLokasiModel.manajemenLokasiModel.city;
      province.value = detailManajemenLokasiModel.manajemenLokasiModel.province;
      latLng = LatLng(detailManajemenLokasiModel.manajemenLokasiModel.latitude,
          detailManajemenLokasiModel.manajemenLokasiModel.longitude);
      namaLokasi.value = detailManajemenLokasiModel.manajemenLokasiModel.name;
      lokasi.value = detailManajemenLokasiModel.manajemenLokasiModel.address;
      detailLokasi.value = detailManajemenLokasiModel.notes ?? "";
      namaPIC.value = detailManajemenLokasiModel.manajemenLokasiModel.picName;
      postalCode.value =
          detailManajemenLokasiModel.manajemenLokasiModel.postalCode;
      noTelpPIC.value =
          detailManajemenLokasiModel.manajemenLokasiModel.picNoTelp;
      await mapController.value.onReady;
      mapController.value.move(latLng, 15);
      mapController.refresh();
    }
    loading.value = false;
  }

  void goToSearchMarkerMap() async {
    var map = {
      "Nama": lokasi.value,
      "Lokasi": latLng,
    };
    GetToPage.toNamed<MapManagementLokasiController>(
        Routes.MAP_MANAGEMENT_LOKASI,
        arguments: [map]);

    // GetToPage.toNamed<MapDetailTransporterController>(
    //     Routes.MAP_DETAIL_TRANSPORTER,
    //     arguments: [latLng, lokasi.value]);
  }

  void _typeUpdate() async {
    detailManajemenLokasiModel.manajemenLokasiModel =
        _manajemenLokasiModelFromArgms;
    // district.value = detailManajemenLokasiModel.manajemenLokasiModel.district;
    // city.value = detailManajemenLokasiModel.manajemenLokasiModel.city;
    // province.value = detailManajemenLokasiModel.manajemenLokasiModel.province;
    // latLng = LatLng(_manajemenLokasiModelFromArgms.latitude,
    //     _manajemenLokasiModelFromArgms.longitude);
    // namaLokasi.value = _manajemenLokasiModelFromArgms.name;
    // detailLokasi.value = detailManajemenLokasiModel.notes;
    // lokasi.value = _manajemenLokasiModelFromArgms.address;
    // namaPIC.value = _manajemenLokasiModelFromArgms.picName;
    // postalCode.value = _manajemenLokasiModelFromArgms.postalCode;
    // noTelpPIC.value = _manajemenLokasiModelFromArgms.picNoTelp;
    // await mapController.value.onReady;
    // mapController.value.move(latLng, 15);
    // mapController.refresh();
  }

  void onWillPop() {
    Get.back(result: isChange);
  }
}
