import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/core/function/api/get_info_from_address_place_id.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/manajemen_lokasi_api.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/detail_manajemen_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/detail_manajemen_lokasi_response_model.dart';
import 'package:muatmuat/app/core/models/info_from_address_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/manajemen_lokasi_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/models/update_delete_save_location_response_model.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/search_location_add_edit_manajemen_lokasi/search_location_add_edit_manajemen_lokasi_controller.dart';
import 'package:muatmuat/app/modules/home/setting/manajemen_lokasi/detail_manajemen_lokasi/detail_manajemen_lokasi_controller.dart';
import 'package:muatmuat/app/modules/search_location_map_marker/search_location_map_marker_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class EditManajemenLokasiInfoPermintaanMuatController extends GetxController {
  static final String typeEditManajemenLokasiInfoPermintaanMuatKey =
      "TypeEditManajemenLokasiInfoPermintaanMuat";
  static final String addressKey = "Address";
  static final String placeIDKey = "PlaceID";
  static final String manajemenLokasiModelKey = "ManajemenLokasiModel";

  final formKey = GlobalKey<FormState>().obs;

  final district = "".obs;
  final city = "".obs;
  final province = "".obs;

  LatLng latLng;

  bool isValidateOnChange = true;
  bool isChange = false;

  TypeEditManajemenLokasiInfoPermintaanMuat typeEdit;

  TextEditingController namaLokasiTextEditingController =
      TextEditingController();
  TextEditingController lokasiTextEditingController = TextEditingController();
  TextEditingController detailLokasiTextEditingController =
      TextEditingController();
  TextEditingController namaPICTextEditingController = TextEditingController();
  TextEditingController postalCodeTextEditingController =
      TextEditingController();
  TextEditingController noTelpPICTextEditingController =
      TextEditingController();

  var errorNamaLokasi = false.obs;
  var errorLokasi = false.obs;
  var errorDetailLokasi = false.obs;
  var errorPostalCode = false.obs;
  var errorNamaPIC = false.obs;
  var errorNoTelpPIC = false.obs;

  var errorMessagePostalCode = "".obs;
  var errorMessageNoTelpPic = "".obs;

  final mapController = MapController().obs;

  bool _isFirstTimeBuildWidget = true;

  DetailManajemenLokasiModel _detailManajemenLokasiModel =
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
    } else {
      isValidateOnChange = false;
      _typeAdd();
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
      if (typeEdit == TypeEditManajemenLokasiInfoPermintaanMuat.UPDATE)
        await _getDetail();
      else {
        if (_addressFromArgms.isNotEmpty || _placeIDFromArgms.isNotEmpty) {
          await _getDataInfoFromAddressPlaceID(
              address: _addressFromArgms, placeID: _placeIDFromArgms);
        }
      }
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

  Future _getDetail() async {
    DetailManajemenLokasiResponseModel response =
        await ManajemenLokasiAPI.getDetail(
            _detailManajemenLokasiModel.manajemenLokasiModel.id);
    if (response != null) {
      _detailManajemenLokasiModel = response.detailManajemenLokasiModel;
      detailLokasiTextEditingController.text =
          _detailManajemenLokasiModel.notes;
    }
  }

  void onSaveButton() async {
    if (typeEdit == TypeEditManajemenLokasiInfoPermintaanMuat.ADD) {
      isValidateOnChange = true;
      formKey.refresh();
    }
    print(formKey.value.currentState.validate());
    if (formKey.value.currentState.validate()) {
      _detailManajemenLokasiModel.manajemenLokasiModel.address =
          lokasiTextEditingController.text;
      _detailManajemenLokasiModel.manajemenLokasiModel.city = city.value;
      _detailManajemenLokasiModel.manajemenLokasiModel.province =
          province.value;
      _detailManajemenLokasiModel.manajemenLokasiModel.district =
          district.value;
      _detailManajemenLokasiModel.manajemenLokasiModel.latitude =
          latLng.latitude;
      _detailManajemenLokasiModel.manajemenLokasiModel.longitude =
          latLng.longitude;
      if (typeEdit == TypeEditManajemenLokasiInfoPermintaanMuat.UPDATE)
        _detailManajemenLokasiModel.manajemenLokasiModel.id =
            _manajemenLokasiModelFromArgms.id;
      _detailManajemenLokasiModel.manajemenLokasiModel.postalCode =
          postalCodeTextEditingController.text;
      _detailManajemenLokasiModel.manajemenLokasiModel.name =
          namaLokasiTextEditingController.text;
      _detailManajemenLokasiModel.manajemenLokasiModel.picName =
          namaPICTextEditingController.text;
      _detailManajemenLokasiModel.manajemenLokasiModel.picNoTelp =
          noTelpPICTextEditingController.text;
      // if (typeEdit == TypeEditManajemenLokasiInfoPermintaanMuat.ADD)
      _detailManajemenLokasiModel.notes =
          detailLokasiTextEditingController.text;

      UpdateDeleteSaveLocationResponseModel response = typeEdit ==
              TypeEditManajemenLokasiInfoPermintaanMuat.ADD
          ? await ManajemenLokasiAPI.addData(_detailManajemenLokasiModel)
          : await ManajemenLokasiAPI.updateData(_detailManajemenLokasiModel);
      if (response != null) {
        if (response.message.code == 200) {
          CustomToast.show(
              context: Get.context, message: response.messageResponse);
          Get.back(result: response.message.code == 200 ? true : false);
        } else {
          GlobalAlertDialog.showAlertDialogCustom(
              context: Get.context,
              title: "",
              message: response.message.text,
              labelButtonPriority1: "OK",
              onTapPriority1: () {});
        }
      }
    }
  }

  void onDeleteButton() async {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "LocationManagementAlertTitleDelete".tr,
        message: "LocationManagementAlertMessageDelete".tr,
        labelButtonPriority1: GlobalAlertDialog.yesLabelButton,
        labelButtonPriority2: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () async {
          UpdateDeleteSaveLocationResponseModel response =
              await ManajemenLokasiAPI.deleteData(
                  _detailManajemenLokasiModel.manajemenLokasiModel.id);
          if (response != null) {
            if (response.message.code == 200) {
              CustomToast.show(
                  context: Get.context, message: response.messageResponse);
              DetailManajemenLokasiController controllers = Get.find();
              if (controllers != null) {
                Get.back();
              }
              Get.back(result: response.message.code == 200 ? true : false);
            } else {
              GlobalAlertDialog.showAlertDialogCustom(
                  context: Get.context,
                  title: "",
                  message: response.message.text,
                  labelButtonPriority1: "OK",
                  onTapPriority1: () {});
            }
          }
        },
        onTapPriority2: () {},
        positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2);
  }

  void goToSearchMarkerMap() async {
    var result = await GetToPage.toNamed<SearchLocationMapMarkerController>(
        Routes.SEARCH_LOCATION_MAP_MARKER,
        arguments: {
          SearchLocationMapMarkerController.latLngKey: latLng,
          SearchLocationMapMarkerController.imageMarkerKey: SvgPicture.asset(
            "assets/pin_truck_icon.svg",
            width: 14,
            height: 35,
          ),
          SearchLocationMapMarkerController.addressKey: _addressFromArgms
        });
    if (result != null) {
      _getDataInfoFromAddressPlaceID(
          address: result[1], latLngParam: result[0]);
    }
  }

  void _typeUpdate() {
    _detailManajemenLokasiModel.manajemenLokasiModel =
        _manajemenLokasiModelFromArgms;
    district.value = _detailManajemenLokasiModel.manajemenLokasiModel.district;
    city.value = _detailManajemenLokasiModel.manajemenLokasiModel.city;
    province.value = _detailManajemenLokasiModel.manajemenLokasiModel.province;
    latLng = LatLng(_manajemenLokasiModelFromArgms.latitude,
        _manajemenLokasiModelFromArgms.longitude);
    namaLokasiTextEditingController.text = _manajemenLokasiModelFromArgms.name;
    lokasiTextEditingController.text = _manajemenLokasiModelFromArgms.address;
    namaPICTextEditingController.text = _manajemenLokasiModelFromArgms.picName;
    postalCodeTextEditingController.text =
        _manajemenLokasiModelFromArgms.postalCode;
    noTelpPICTextEditingController.text =
        _manajemenLokasiModelFromArgms.picNoTelp;
  }

  void _typeAdd() {
    if (_manajemenLokasiModelFromArgms != null) {
      _detailManajemenLokasiModel.manajemenLokasiModel =
          _manajemenLokasiModelFromArgms;
      district.value =
          _detailManajemenLokasiModel.manajemenLokasiModel.district;
      city.value = _detailManajemenLokasiModel.manajemenLokasiModel.city;
      province.value =
          _detailManajemenLokasiModel.manajemenLokasiModel.province;
      latLng = LatLng(_manajemenLokasiModelFromArgms.latitude,
          _manajemenLokasiModelFromArgms.longitude);
      namaLokasiTextEditingController.text =
          _manajemenLokasiModelFromArgms.name;
      postalCodeTextEditingController.text =
          _manajemenLokasiModelFromArgms.postalCode;
      lokasiTextEditingController.text = _manajemenLokasiModelFromArgms.address;
      namaPICTextEditingController.text =
          _manajemenLokasiModelFromArgms.picName;
      noTelpPICTextEditingController.text =
          _manajemenLokasiModelFromArgms.picNoTelp;
    } else {
      _detailManajemenLokasiModel.manajemenLokasiModel = ManajemenLokasiModel();
    }
  }

  void getLocation() async {
    String addressName = lokasiTextEditingController.text;
    var result =
        await GetToPage.toNamed<SearchLocationAddEditManajemenLokasiController>(
            Routes.SEARCH_LOCATION_ADD_EDIT_MANAJEMEN_LOKASI,
            arguments: [
          "",
          addressName,
          latLng,
        ]);
    if (result != null) {
      lokasiTextEditingController.text = result[0];
      latLng = result[1];
      district.value = result[2];
      city.value = result[3];
      province.value = result[4];
      postalCodeTextEditingController.text = result[5];
      mapController.value.move(latLng, 15);
      mapController.refresh();
    }
  }

  Future _getDataInfoFromAddressPlaceID(
      {String address, String placeID, LatLng latLngParam}) async {
    InfoFromAddressResponseModel response =
        await GetInfoFromAddressPlaceID.getInfo(
            address: placeID != null ? null : address, placeID: placeID);
    if (response != null) {
      lokasiTextEditingController.text = address;
      if (_detailManajemenLokasiModel.manajemenLokasiModel == null)
        _detailManajemenLokasiModel.manajemenLokasiModel =
            ManajemenLokasiModel();
      _detailManajemenLokasiModel.manajemenLokasiModel.latitude =
          latLngParam == null ? response.latitude : latLngParam.latitude;
      _detailManajemenLokasiModel.manajemenLokasiModel.longitude =
          latLngParam == null ? response.longitude : latLngParam.longitude;
      latLng = LatLng(_detailManajemenLokasiModel.manajemenLokasiModel.latitude,
          _detailManajemenLokasiModel.manajemenLokasiModel.longitude);
      _detailManajemenLokasiModel.manajemenLokasiModel.city = response.city;
      _detailManajemenLokasiModel.manajemenLokasiModel.district =
          response.district;
      _detailManajemenLokasiModel.manajemenLokasiModel.postalCode =
          response.postal;
      _detailManajemenLokasiModel.manajemenLokasiModel.province =
          response.province;
      district.value =
          _detailManajemenLokasiModel.manajemenLokasiModel.district;
      city.value = _detailManajemenLokasiModel.manajemenLokasiModel.city;
      province.value =
          _detailManajemenLokasiModel.manajemenLokasiModel.province;
      mapController.value.move(latLng, 15);
      mapController.refresh();
    }
  }

  void onWillPop() {
    print('Debug: ' + 'onWillPop isChange = ' + isChange.toString());
    if (isChange) {
      GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          title: "Konfirmasi Pembatalan",
          message:
              "Apakah Anda yakin ingin kembali? Data yang telah diisi tidak akan disimpan",
          labelButtonPriority1: GlobalAlertDialog.yesLabelButton,
          labelButtonPriority2: GlobalAlertDialog.noLabelButton,
          onTapPriority1: () async {
            Get.back();
          },
          onTapPriority2: () {},
          positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2);
    } else {
      Get.back();
    }
  }
}

enum TypeEditManajemenLokasiInfoPermintaanMuat { ADD, UPDATE }
