import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/lokasi_data_perusahaan/lokasi_ubah_data_controller.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/profile_perusahaan/profile_perusahaan_controller.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/models/data_district_model.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/utils/response_state.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:string_validator/string_validator.dart' as sv;

class UbahDataPerusahaanController extends GetxController {
  var p = Get.find<ProfilePerusahaanController>();
  final formKey = GlobalKey<FormState>().obs;

  var dataModelResponse = ResponseState<DistrictModel>().obs;
  var dataDistrict = DistrictModel();

  var kategoriData = [].obs;
  var isSpecialLegal = false.obs;
  var loading = false.obs;
  String numberOfMarker = "";
  var totalMarker = 5.obs;
  var lokasiakhir = " ".obs;
  var namalokasiakhir = " ".obs;
  var alamatlokasiakhir = " ".obs;
  LatLng _latLngFromArgms;
  var markerBounds = LatLngBounds();

  RxString placeidd = "".obs;

  var isOptionalFilled = false.obs;
  var isFilled = true.obs;
  var isValid = false.obs;
  var mapLokasiController = MapController();
  var latlngLokasi = {}.obs;
  var totalLokasi = "1".obs;
  var loadMapLokasi = false.obs;
  var namaLokasi = {}.obs;
  var totalDestinasi = "1".obs;
  var cityLokasi = {}.obs;
  var districtLokasi = {}.obs;
  var deskripsiLokasi = {}.obs;
  var namaPICPickup = {}.obs;
  var nomorPICPickup = {}.obs;
  var mapDestinasiController = MapController();

  var businessFieldController = TextEditingController().obs;
  var districtController = TextEditingController().obs;

  var noTeleponC = TextEditingController();
  var alamatPerusahaanC = TextEditingController();
  var detailAlamatC = TextEditingController(text: '').obs;
  var kecamatanC = TextEditingController();
  var kodePosC = TextEditingController();

  var errorMessage = "".obs;

  //VALUE
  var namaPerusahaan = "".obs;
  var postalCodeList = [].obs;
  var namaDestinasi = {}.obs;
  var latlngDestinasi = {}.obs;
  var cityDestinasi = {}.obs;
  var districtDestinasi = {}.obs;
  var deskripsiDestinasi = {}.obs;
  var kodepos = "".obs;

  var pilihKodePos = Rxn<String>();
  var idKecamatanResult = Rxn<int>();
  var kecamatanPerusahaanText = "".obs;

  //VALIDASI UNDONE
  var isNamaPerusahaanValid = true.obs;
  var isbadanUsahaValid = true.obs;
  var isBidangUsahaValid = true.obs;
  var isAlamaPerusahaanValid = true.obs;
  var isEmailValid = true.obs;
  var isKecamatanValid = true.obs;
  var isKodePosValid = true.obs;
  var isNoTelpValid = true.obs;
  var isLogoPerusahaanValid = true.obs;

  // KEBUTUHAN SUBMIT API
  var noTelpPerusahaan = "".obs;
  var alamatPerusahaanValue = "".obs;
  var detailAlamatPerusahaanValue = "".obs;
  var kecamatanValue = "".obs;
  var kodePosValue = "".obs;
  RxInt idKodePos = 0.obs;
  var namaPic1Value = "".obs;

  final _listSearchAddressTemp = [];

  var postalCodeKey = "Kode Pos Perusahaan";
  var dataLatLong;
  var citySubmit = "".obs;
  var distid = "".obs;
  LatLng latLngSubmit;
  var districtID = 1.obs;
  var provinceID = 1.obs;
  var cityID = 1.obs;

  @override
  void onInit() async {
    super.onInit();
    // ::::::::::::::::::::::::::::::::::
    // :::: ERROR NUNGGU PROFIL AKUN ::::
    // ::::::::::::::::::::::::::::::::::
    await getDataProfile();
    await getPlaceId();
    await getDistrict();

    checkAllFieldIsFilled();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(Duration(seconds: 3));
        latLngSubmit = LatLng(
          double.parse(p.dataPerusahaan.data.companyLatitude),
          double.parse(p.dataPerusahaan.data.companyLongitude),
        );
        log(latLngSubmit.toString());
        mapLokasiController.ready ??
            mapLokasiController.move(
              LatLng(
                latLngSubmit.latitude ?? "0",
                latLngSubmit.longitude ?? "0",
              ),
              mapLokasiController.zoom ?? 0,
            );
        markerBounds.extend(latLngSubmit);
        updateMapp("lokasi", markerBounds);
      },
    );
  }

  Future<void> getDataProfile() async {
    noTeleponC.text = p.dataPerusahaan.data.companyPhone;
    lokasiakhir.value = p.dataPerusahaan.data.companyAddress;
    detailAlamatC.value.text = p.dataPerusahaan.data.companyAddressDetail;
    districtController.value.text = p.dataPerusahaan.data.companyDistrictName;
    cityID.value = p.dataPerusahaan.data.companyCityID;
    provinceID.value = p.dataPerusahaan.data.companyProvinceID;
    districtID.value = p.dataPerusahaan.data.companyDistrictID;
    pilihKodePos.value = p.dataPerusahaan.data.companyPostalCode;
    kodepos.value = p.dataPerusahaan.data.companyPostalCode;
  }

  submitPerubahan() async {
    if (latlngLokasi != null) {
      final resp = await ApiProfile(
        context: Get.context,
        isShowDialogError: false,
        isDebugGetResponse: true,
        isShowDialogLoading: false,
      ).getDistrictsByToken(placeidd.value);
      if (resp != null) {
        dataDistrict = DistrictModel.fromJson(resp);
        if (dataDistrict.message.code == 200) {
          dataModelResponse.value = ResponseState.complete(
            DistrictModel.fromJson(resp),
          );
          latLngSubmit = LatLng(dataDistrict.data.completeLocation.lat, dataDistrict.data.completeLocation.lng);
          provinceID.value = dataDistrict.data.completeLocation.provinceid;
          cityID.value = dataDistrict.data.completeLocation.cityid;
        }
        var parameter = {
          "CompanyLogo": '',
          "CompanyPhone": noTeleponC.text,
          "CompanyAddress": lokasiakhir.value,
          "CompanyAddress_detail": detailAlamatC.value.text,
          "CompanyPostalCode": kodepos.value,
          "CompanyLatitude": latLngSubmit.latitude.toString(),
          "CompanyLongitude": latLngSubmit.longitude.toString(),
          "CompanyProvinceID": provinceID.toString(),
          "CompanyDistrictID": districtID.toString(),
          "CompanyCityID": cityID.toString(),
        };
        var response = await ApiProfile(
          context: Get.context,
          isShowDialogError: true,
          isDebugGetResponse: true,
          isShowDialogLoading: true,
        ).doUpdateProfileCompany(parameter);
        // log("RESPONSE  : $response");
        if (response != null) {
          if (response["Message"]["Code"] == 200) {
            print(response["Message"]['Data']);
            Get.back();
            CustomToastTop.show(
              context: Get.context,
              message: response["Data"]['Message'],
              isSuccess: 1,
            );
            p.fetchDataCompany();
          } else {
            String errorMessage = response["Data"]["Message"];
            print('EROR :: $errorMessage');
            CustomToastTop.show(
              context: Get.context,
              message: errorMessage,
              isSuccess: 0,
            );
          }
        }
      } else {
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  checkAllFieldIsFilled() {
    if (noTeleponC.text != "" && lokasiakhir.value != "" && districtController.value.text.isNotEmpty && kodepos.value != null) {
      isFilled.value = true;
    } else {
      isFilled.value = false;
    }
  }

  Future getPlaceId() async {
    var search = lokasiakhir.value;

    try {
      var response = await ApiProfile(
        context: Get.context,
        isShowDialogError: true,
        isShowDialogLoading: false,
      ).getAutoCompleteStreet(search);
      if (response != null) {
        if (response["Message"]["Code"] == 200) {
          if (response['Data'] != null) {
            placeidd.value = response['Data'][0]['id'].toString();
          } else {
            placeidd.value = '';
            lokasiakhir.value = ' ';
          }
          // log(':::: PLACE ID ' + placeidd.value);
        } else {
          return;
        }
      }
    } catch (e) {
      log(':::: ERORRR ' + e.toString());
    }
  }

  Future getDistrict() async {
    var id = placeidd.value;
    log("G>DISTRICT  ---  ALAMAT : $id");
    if (id != null) {
      try {
        dataModelResponse.value = ResponseState.loading();
        final response = await ApiProfile(
          context: Get.context,
          isShowDialogError: false,
          isShowDialogLoading: false,
        ).getDistrictsByToken(id);
        if (response != null) {
          dataDistrict = DistrictModel.fromJson(response);
          if (dataDistrict.message.code == 200) {
            dataModelResponse.value = ResponseState.complete(
              DistrictModel.fromJson(response),
            );
            // log('LAT : ' + dataDistrict.data.lat.toString() + ' LONG : ' + dataDistrict.data.long.toString());
            // log(':::: LATLONGlOKASI : ' + latlngLokasi.values.toString());
            dataDistrict.data.districts.forEach((e) async {
              // log('====== DISTRIC : ' + '${e.district}');
              districtController.value.text = e.district;
              await getIdUsaha(e.districtID);
              e.postalCodes.forEach((d) {
                // log('====== POSTAL : ' + '${d.iD} ' + ' ${d.postalCode}');
                kodepos.value = d.postalCode;
              });
            });
          } else {
            if (dataDistrict.message.code != null) {
              throw (dataDistrict.message.text);
            }
            throw ("failed to fetch data!");
          }
        }
      } catch (e) {
        log(':::: ERORRRD ' + e.toString());
        dataModelResponse.value = ResponseState.error("$e");
      }
    } else {
      districtController.value.text = "";
      kodepos.value = "";
    }
  }

  checkNoTelpField(String value) {
    var length = sv.isLength(value, 8, 14);
    if (value.isEmpty || value == "") {
      CustomToastTop.show(
        message: "No. Telepon Perusahaan minimal 8 digit!",
        context: Get.context,
        isSuccess: 0,
      );
      isNoTelpValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (length == false) {
      CustomToastTop.show(
        message: "No. Telepon Perusahaan minimal 8 digit! ",
        context: Get.context,
        isSuccess: 0,
      );
      isNoTelpValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    // log('noHPValid : ${isNoTelpValid.value}');
  }

  // void onClickSetPositionMarker() async {
  //   var result = await GetToPage.toNamed<SearchLocationUbahDataMapController>(
  //     Routes.PETA_UBAH_DATA,
  //     arguments: {
  //       SearchLocationUbahDataMapController.latLngKey: _latLngFromArgms,
  //       SearchLocationUbahDataMapController.imageMarkerKey: Stack(
  //         alignment: Alignment.topCenter,
  //         children: [
  //           //  totalMarker.value == 1 && numberOfMarker == "1" ?
  //           Image.asset(
  //             'assets/pin_new.png',
  //             width: GlobalVariable.ratioWidth(Get.context) * 29.56,
  //             height: GlobalVariable.ratioWidth(Get.context) * 36.76,
  //           ),
  //           Container(
  //             margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 7),
  //             child: CustomText(
  //               totalMarker.value == 1 ? "" : numberOfMarker,
  //               color: numberOfMarker != "1" ? Colors.white : Color(ListColor.color4),
  //               fontWeight: FontWeight.w700,
  //               fontSize: 10,
  //             ),
  //           )
  //         ],
  //       ),
  //     },
  //   );
  //   if (result != null) {
  //     // log(':: (RES) : ' + result.toString());
  //     placeidd.value = result[0]['Lokasi'];
  //     // log(':: (RES)PLACE ID : ' + placeidd.value);
  //     districtController.value.clear();
  //     kecamatanPerusahaanText.value = null;
  //     kodepos.value = null;
  //     pilihKodePos.value = null;
  //     _getDataInfoFromAddressPlaceID(address: result[1]);
  //     // _getBackWithResult(
  //     //   result[1],
  //     //   result[0],
  //     // );
  //   }
  // }

  // Future _getDataInfoFromAddressPlaceID({@required String address, String placeID}) async {
  //   InfoFromAddressResponseModel response = await GetInfoFromAddressPlaceID.getInfo(address: placeID != null ? null : address, placeID: placeID);
  //   _addToSharedPref(
  //     AddressGoogleInfoPermintaanMuatModel(
  //       addressAutoComplete: AddressGooglePlaceAutoCompleteModel(description: address, placeId: placeID),
  //       addressDetails: AddressGooglePlaceDetailsModel(
  //         formattedAddress: address,
  //         latLng: LatLng(response.latitude, response.longitude),
  //         cityName: response.city,
  //         districtName: response.district,
  //       ),
  //     ),
  //   );
  //   if (response != null) {
  //     _getBackWithResult(
  //         address,
  //         LatLng(
  //           response.latitude,
  //           response.longitude,
  //         ),
  //         response.district,
  //         response.city);
  //   }
  // }

  // void _getBackWithResult(String address, LatLng latLng, String district, String city) {
  //   onClearSearch();
  //   Get.back(result: [address, latLng, district, city]);
  // }

  // final searchTextEditingController = TextEditingController().obs;
  // final listSearchAddress = [].obs;
  // final isSearchMode = false.obs;
  // final isSearchingData = false.obs;
  // SearchAddressGoogleFunction _searchAddressGoogleFunction;

  // void onClearSearch() {
  //   searchTextEditingController.value.text = "";
  //   addTextSearch("");
  // }

  // void addTextSearch(String value) {
  //   listSearchAddress.clear();
  //   if (value == "") {
  //     listSearchAddress.addAll(_listSearchAddressTemp);
  //   }
  //   isSearchMode.value = value != "";
  //   isSearchingData.value = value != "";
  //   _searchAddressGoogleFunction.addTextCity(value);
  // }

  // void _addToSharedPref(AddressGoogleInfoPermintaanMuatModel data) {
  //   if (_listSearchAddressTemp.length > 0) {
  //     for (int i = 0; i < _listSearchAddressTemp.length; i++) {
  //       if (_listSearchAddressTemp[i].addressAutoComplete.description.toLowerCase() == data.addressAutoComplete.description.toLowerCase()) {
  //         _listSearchAddressTemp.removeAt(i);
  //         break;
  //       }
  //     }
  //   }
  //   _listSearchAddressTemp.insert(0, AddressGoogleInfoPermintaanMuatModel.copyData(data));
  //   if (_listSearchAddressTemp.length > 3) _listSearchAddressTemp.removeAt(_listSearchAddressTemp.length - 1);
  //   SharedPreferencesHelper.setHistorySearchLocationInfoPermintaanMuat(jsonEncode(_listSearchAddressTemp));
  // }

  var selectLokasi = Map().obs;
  final String namaKey = "Nama";
  final String lokasiKey = "Lokasi";
  final String cityKey = "City";
  final String districtKey = "District";

  void onClickAddresss(String type) async {
    var map = {};
    var total = 1;
    if (type == "lokasi") {
      total = int.parse(totalLokasi.value);
      namaLokasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaLokasi[key],
          "Lokasi": latlngLokasi[key],
          "City": cityLokasi[key],
          "District": districtLokasi[key],
        };
      });
    } else {
      total = int.parse(totalDestinasi.value);
      namaDestinasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaDestinasi[key],
          "Lokasi": latlngDestinasi[key],
          "City": cityDestinasi[key],
          "District": districtDestinasi[key],
        };
      });
    }
    var result = await GetToPage.toNamed<LokasiUbahDataController>(
      Routes.LOKASI_PROFIL_PERUSAHAAN,
      arguments: [type, map, total, '', false, 'search'],
    );

    if (result != null) {
      // log(':: (RES) : ' + result.toString());
      distid.value = "";
      placeidd.value = result[1];
      // log(':: (RES)PLACE ID : ' + placeidd.value);
      districtController.value.clear();
      kecamatanPerusahaanText.value = null;
      kodepos.value = null;
      pilihKodePos.value = null;
      if (type == "lokasi") {
        namaLokasi.clear();
        latlngLokasi.clear();
        cityLokasi.clear();
        districtLokasi.clear();
      } else {
        namaDestinasi.clear();
        latlngDestinasi.clear();
        cityDestinasi.clear();
        districtDestinasi.clear();
      }
      var markerBounds = LatLngBounds();
      (result[0] as Map).keys.forEach((key) {
        if (type == "lokasi") {
          namaLokasi[key] = result[0][key]["Nama"];
          latlngLokasi[key] = result[0][key]["Lokasi"];
          cityLokasi[key] = result[0][key]["City"];
          districtLokasi[key] = result[0][key]["District"];
        } else {
          namaDestinasi[key] = result[0][key]["Nama"];
          latlngDestinasi[key] = result[0][key]["Lokasi"];
          cityDestinasi[key] = result[0][key]["City"];
          districtDestinasi[key] = result[0][key]["District"];
        }
        markerBounds.extend(result[0][key]["Lokasi"]);
      });
      if (markerBounds.isValid) {
        updateMapp(type, markerBounds);
      }

      namaLokasi.refresh();
      lokasiakhir.value = (namaLokasi.values.toString().substring(1, namaLokasi.values.toString().length - 1));
      // log(':: LOC AKHIR : ' + '${lokasiakhir.value}');
      // print(latlngLokasi.toString().substring(20)+' ikura');
      int index = lokasiakhir.indexOf(',');
      namalokasiakhir.value = lokasiakhir.substring(0, index).trim();
      alamatlokasiakhir.value = lokasiakhir.substring(index + 1).trim();
      // log(':: NAMA LOC AKHIR : ' + '${namalokasiakhir.value}');
      // log(':: ALAMAT LOC AKHIR :' + '${alamatlokasiakhir.value}');
      checkAllFieldIsFilled();
    } else {}
  }

  void cancel() {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "ShipperUbahDataPerusahaanIndexLabelAlert".tr,
      context: Get.context,
      customMessage: Container(
        margin: EdgeInsets.only(
          bottom: GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        child: GestureDetector(
          onTap: () => Get.back,
          child: CustomText(
            "ShipperUbahDataPerusahaanIndexLabelIsiAlert".tr,
            textAlign: TextAlign.center,
            fontSize: 14,
            height: 21 / 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      borderRadius: 12,
      labelButtonPriority1: "Batal",
      labelButtonPriority2: "Simpan",
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      onTapPriority1: () {},
      onTapPriority2: () {
        if (isFilled.value == true)
          checkFieldIsValid();
        else
          CustomToastTop.show(context: Get.context, isSuccess: 0, message: "Terdapat field yang kosong");
      },
      widthButton1: 104,
      widthButton2: 104,
      heightButton1: 31,
      heightButton2: 31,
    );
  }

  Future<void> updateMapp(String type, LatLngBounds markerBounds) async {
    // log('::UPDATE MAPSS');
    if (type == "lokasi") {
      await mapLokasiController.onReady;
      mapLokasiController.fitBounds(
        markerBounds,
        options: FitBoundsOptions(
          padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 20),
        ),
      );
    } else {
      await mapDestinasiController.onReady;
      mapDestinasiController.fitBounds(
        markerBounds,
        options: FitBoundsOptions(
          padding: EdgeInsets.all(GlobalVariable.ratioWidth(Get.context) * 20),
        ),
      );
    }
  }

  checkFieldIsValid() async {
    await checkNoTelpField(noTeleponC.text);
    if (isNoTelpValid.value != false) {
      isValid.value = true;
      submitPerubahan();
    } else {
      isValid.value = false;
    }
  }

  checkAlamatField(String value) {
    if (value.isEmpty || value == "") {
      CustomToastTop.show(message: "Alamat tidak boleh kososng", context: Get.context, isSuccess: 0);
      isAlamaPerusahaanValid.value = false;
      isFilled.value = false;
    }
  }

  void onClickAddressMap(String type) async {
    var map = {};
    var total = 1;
    if (type == "lokasi") {
      total = int.parse(totalLokasi.value);
      namaLokasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaLokasi[key],
          "Lokasi": latlngLokasi[key],
          "City": cityLokasi[key],
          "District": districtLokasi[key],
        };
      });
    } else {
      total = int.parse(totalDestinasi.value);
      namaDestinasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaDestinasi[key],
          "Lokasi": latlngDestinasi[key],
          "City": cityDestinasi[key],
          "District": districtDestinasi[key],
        };
      });
    }
    var result = await GetToPage.toNamed<LokasiUbahDataController>(
      Routes.LOKASI_UBAH_DATA_INDIVIDU,
      arguments: [type, map, total, '', false, 'map'],
    );
    if (result != null) {
      // log(':: (RES) : ' + result.toString());
      distid.value = "";

      placeidd.value = result[1];
      districtController.value.clear();

      // log(':: (RES)PLACE ID : ' + placeidd.value);
      // log(':: (RES)CITY SUBMT: ' + citySubmit.value);
      kecamatanPerusahaanText.value = null;
      kodepos.value = null;
      pilihKodePos.value = null;
      if (type == "lokasi") {
        namaLokasi.clear();
        latlngLokasi.clear();
        cityLokasi.clear();
        districtLokasi.clear();
      } else {
        namaDestinasi.clear();
        latlngDestinasi.clear();
        cityDestinasi.clear();
        districtDestinasi.clear();
      }
      var markerBounds = LatLngBounds();
      (result as Map).keys.forEach((key) {
        if (type == "lokasi") {
          namaLokasi[key] = result[key]["Nama"];
          latlngLokasi[key] = result[key]["Lokasi"];
          cityLokasi[key] = result[key]["City"];
          districtLokasi[key] = result[key]["District"];
        } else {
          namaDestinasi[key] = result[key]["Nama"];
          latlngDestinasi[key] = result[key]["Lokasi"];
          cityDestinasi[key] = result[key]["City"];
          districtDestinasi[key] = result[key]["District"];
        }
        markerBounds.extend(result[key]["Lokasi"]);
      });
      if (markerBounds.isValid) {
        updateMapp(type, markerBounds);
      }
      namaLokasi.refresh();
      lokasiakhir.value = (namaLokasi.values.toString().substring(1, namaLokasi.values.toString().length - 1));
      // log(':: LOC AKHIR : ' + '${lokasiakhir.value}');
      int index = lokasiakhir.indexOf(',');
      namalokasiakhir.value = lokasiakhir.substring(0, index).trim();
      alamatlokasiakhir.value = lokasiakhir.substring(index + 1).trim();
      // log(':: NAMA LOC AKHIR : ' + '${namalokasiakhir.value}');
      // log(':: ALAMAT LOC AKHIR :' + '${alamatlokasiakhir.value}');
      checkAllFieldIsFilled();
    } else {}
  }

  getIdUsaha(int idKecamatan) async {
    postalCodeList.clear();
    pilihKodePos.value = null;
    var result = await ApiHelper(
      context: Get.context,
      isDebugGetResponse: false,
      isShowDialogLoading: false,
    ).getPostalCode(idKecamatan.toString());
    postalCodeList.value = result == null ? [] : result['Data'];
    // print(postalCodeList);
  }
}
