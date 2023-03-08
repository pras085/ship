import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muatmuat/app/core/function/api/get_info_from_address_place_id.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/core/function/search_address_google_function.dart';
import 'package:muatmuat/app/core/models/address_google_info_permintaan_muat_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_autocomplete_model.dart';
import 'package:muatmuat/app/core/models/address_google_place_details_model.dart';
import 'package:muatmuat/app/core/models/info_from_address_response_model.dart';
import 'package:muatmuat/app/modules/lokasi_bf_tm/lokasi_bf_tm_controller.dart';
import 'package:muatmuat/app/modules/peta_bf_tm/search_location_map_bf_tm_controller.dart';
import 'package:muatmuat/app/modules/select_list_lokasi/select_list_lokasi_controller.dart';
import 'package:muatmuat/app/modules/upload_legalitas/upload_legalitas_controller.dart';

import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:string_validator/string_validator.dart' as sv;
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong/latlong.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:mime/src/mime_type.dart';

import '../api_login_register.dart';

class FormPendaftaranBFController extends GetxController {
  var kategoriData = [].obs;
  var isSpecialLegal = false.obs;
  var loading = false.obs;
  static SharedPreferences _sharedPreferences;
  int _indexOnClick = 0;
  String numberOfMarker = "";
  var mapController = MapController();
  var totalMarker = 5.obs;
  var lokasiakhir = " ".obs;
  var namalokasiakhir = " ".obs;
  var alamatlokasiakhir = " ".obs;

  LatLng _latLngFromArgms;

  String _addressFromArgms;

  var isOptionalFilled = false.obs;
  var isFilled = false.obs;
  var isValid = false.obs;
  var mapLokasiController = MapController();
  var latlngLokasi = {}.obs;
  var totalLokasi = "1".obs;
  var loadMapLokasi = false.obs;
  var namaLokasi = {}.obs;
  var totalDestinasi = "1".obs;
  var cityLokasi = {}.obs;
  var districtLokasi = {}.obs;
  var placeid = {}.obs;
  var deskripsiLokasi = {}.obs;
  var namaPICPickup = {}.obs;
  var nomorPICPickup = {}.obs;
  var mapDestinasiController = MapController();
  var devicetype = "".obs;

  final formKey = GlobalKey<FormState>().obs;

  // TextEditingController namaPerusahaanC = TextEditingController();
  var businessFieldController = TextEditingController().obs;
  var districtController = TextEditingController().obs;
  Rx<TextEditingController> emailCtrl = Rx<TextEditingController>(TextEditingController());
  var isEditable = true.obs;

  TextEditingController alamatPerusahaanC = TextEditingController();

  TextEditingController namaPIC1 = TextEditingController();
  TextEditingController noHpPIC1 = TextEditingController();
  TextEditingController noTelp = TextEditingController();
  TextEditingController namaPIC2 = TextEditingController();
  TextEditingController noHpPIC2 = TextEditingController();
  TextEditingController namaPIC3 = TextEditingController();
  TextEditingController noHpPIC3 = TextEditingController();


  // FOTO
  var file = File("").obs;
  var fileDisplay = File('').obs;
  var isSuccessUpload = false.obs;
  var errorMessage = "".obs;
  var picturefill = false.obs;

  //VALUE
  var namaPerusahaan = "".obs;
  var pilihBadanUsaha = Rxn<String>();
  // var kodePosPerusahaanText = Rxn<String>();
  var pilihBidangUsaha = Rxn<String>();
  var pilihKodePos = Rxn<String>();
  var cityStoreArg = "".obs;
  var provinceStoreArg = "".obs;
  var text = "".obs;
  var postalCodeList = [].obs;
  var badanUsahaList = [].obs;
  var bidangUsahaList = [].obs;
  var namaDestinasi = {}.obs;
  var latlngDestinasi = {}.obs;
  var cityDestinasi = {}.obs;
  var districtDestinasi = {}.obs;
  var deskripsiDestinasi = {}.obs;

  var idKecamatanResult = Rxn<int>();
  var kecamatanPerusahaanText = "".obs;

  //CONTACT PICKER
  final ContactPicker contactPicker = ContactPicker();
  final ContactPicker contactPicker2 = ContactPicker();
  final ContactPicker contactPicker3 = ContactPicker();
  Contact contact1;
  Contact contact2;
  Contact contact3;

  //FOTO
  File imageFileValue;
  // File cropFile = ImageCropper().cropImage(sourcePath: imageFileValue!=null ?Image.file(image))

//VALIDASI UNDONE
  var isNamaPerusahaanValid = true.obs;
  var isbadanUsahaValid = true.obs;
  var isBidangUsahaValid = true.obs;
  var isAlamaPerusahaanValid = true.obs;
  var isEmailValid = true.obs;
  var isKecamatanValid = true.obs;
  var isKodePosValid = true.obs;
  var isNamaPic1Valid = true.obs;
  var isNoPic1Valid = true.obs;
  var isNoTelpValid = true.obs;
  var isNamaPic2Valid = true.obs;
  var isNoPic2Valid = true.obs;
  var isNamaPic3Valid = true.obs;
  var isNoPic3Valid = true.obs;
  var isLogoPerusahaanValid = true.obs;

// FIELD VALUEE UNDONE
  var namaPerusahaanValue = "".obs;
  var badanUsahaValue = "".obs;
  var bidangUsahaValue = "".obs;
  var alamatPerusahaanValue = "".obs;
  var email= "".obs;
  var kecamatanValue = "".obs;
  var kodePosValue = "".obs;
  var namaPic1Value = "".obs;
  var noTelpPerusahaan = "".obs;
  var naoPic1Value = "".obs;
  var namaPic2Value = "".obs;
  var naoPic2Value = "".obs;
  var namaPic3Value = "".obs;
  var naoPic3Value = "".obs;
  RxString emailuser = "".obs;
  final _listSearchAddressTemp = [];

  var tipeModul = TipeModul.BF.obs;

  @override
  void onInit() async {
    super.onInit();
    print(Get.arguments);
    tipeModul.value = Get.arguments;
    email.value = GlobalVariable.userModelGlobal.email;
    emailCtrl.value.text = email.value;
    loading.value = true;
    devicetype.value = getDeviceType();
    print('ikura');
    print(devicetype.value + 'ikura');
    await getBadanUsaha();
    await getBidangUsaha();
    final response = await ApiHelper(context: Get.context, isShowDialogLoading: false).getEmailStatus();
    GlobalVariable.userModelGlobal.email = response['Data']['Email'];
    loading.value = false;
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future setCompanyData() async {
    await ApiHelper(context: Get.context, isShowDialogLoading: false, isShowDialogError: false).setShipperRegistrationCompanyData(
      // PENYESUAIAN API, PASANG DATA YANG AKAN DIINPUT
      body: {
        'Email': email.value,
        'CompanyLogo': Utils.base64Image(file.value),
        'CompanyName': namaPerusahaanValue.value,
        'BusinessEntityId': "2",
        'BusinessFieldId': "3",
        'CompanyAddress': "Jalan Dukuh Kupang 86D, Putat Jaya, Kecamatan Sawahan, Kota Surabaya",
        'AddressDetail': "",
        'CompanyDistrictId': "1",
        'CompanyProvinceId': "1",
        'CompanyCityId': "1",
        'CompanyPostalCode': "60295",
        'Lat': "-7.389789",
        'Long': "112.789789",
        'CompanyPhone': "087855151511",
        'Pic1Name': namaPIC1.text,
        'Pic1Phone': noHpPIC1.text,
        'Pic2Name': namaPIC2.text,
        'Pic2Phone': noHpPIC2.text,
        'Pic3Name': namaPIC3.text,
        'Pic3Phone': noHpPIC3.text,
      }
    );
  }

  // getIdUsaha(int idKecamatan) async {
  //   postalCodeList.clear();
  //   pilihKodePos.value = null;
  //   var result = await ApiHelper(
  //           context: Get.context,
  //           isDebugGetResponse: true,
  //           isShowDialogLoading: false)
  //       .getPostalCode(idKecamatan.toString());
  //   postalCodeList.value = result == null ? [] : result['Data'];
  //   // print(postalCodeList);
  // }

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
          "District": districtLokasi[key]
        };
      });
    } else {
      total = int.parse(totalDestinasi.value);
      namaDestinasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaDestinasi[key],
          "Lokasi": latlngDestinasi[key],
          "City": cityDestinasi[key],
          "District": districtDestinasi[key]
        };
      });
    }
    var result = await GetToPage.toNamed<LokasiBFTMController>(
        Routes.LOKASI_BF_TM,
        arguments: [type, map, total, '', false, 'search']);
    // var result = await GetToPage.toNamed<SelectListLokasiController>(
    //     Routes.SELECT_LIST_LOKASI,
    //     arguments: [type, map, total]);
    if (result != null) {
      print(result[1].toString() + 'refoo');
      if (type == "lokasi") {
        print('refoo masuk');
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
      // print(namaLokasi.values.toString() +'ikura');
      // print(namaLokasi.values.toString().replaceAll("(", " ")+'ikura');
      // print(namaLokasi.values.toString().substring(1,namaLokasi.values.toString().length -1)+'ikura');
      lokasiakhir.value = (namaLokasi.values.toString().substring(1,namaLokasi.values.toString().length -1));
      print(lokasiakhir+' ikura');
      int index = lokasiakhir.indexOf(',');
      namalokasiakhir.value = lokasiakhir.substring(0,index).trim();
      alamatlokasiakhir.value = lokasiakhir.substring(index+1).trim();
      print(namalokasiakhir+' ikura');
      print(alamatlokasiakhir+' ikura');
  // var namalokasiakhir = " ".obs;
  // var alamatlokasiakhir
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
          "District": districtLokasi[key]
        };
      });
    } else {
      total = int.parse(totalDestinasi.value);
      namaDestinasi.keys.forEach((key) {
        map[key] = {
          "Nama": namaDestinasi[key],
          "Lokasi": latlngDestinasi[key],
          "City": cityDestinasi[key],
          "District": districtDestinasi[key]
        };
      });
    }
    var result = await GetToPage.toNamed<LokasiBFTMController>(
        Routes.LOKASI_BF_TM,
        arguments: [type, map, total, '', false, 'map']);
    // var result = await GetToPage.toNamed<SelectListLokasiController>(
    //     Routes.SELECT_LIST_LOKASI,
    //     arguments: [type, map, total]);
    if (result != null) {
      // print(result.toString()+ ' yoasobii');
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
      // print(namaLokasi.values.toString() +'ikura');
      // print(namaLokasi.values.toString().replaceAll("(", " ")+'ikura');
      // print(namaLokasi.values.toString().substring(1,namaLokasi.values.toString().length -1)+'ikura');
      lokasiakhir.value = (namaLokasi.values.toString().substring(1,namaLokasi.values.toString().length -1));
      print(lokasiakhir+' ikura');
      int index = lokasiakhir.indexOf(',');
      namalokasiakhir.value = lokasiakhir.substring(0,index).trim();
      alamatlokasiakhir.value = lokasiakhir.substring(index+1).trim();
      print(namalokasiakhir+' ikura');
      print(alamatlokasiakhir+' ikura');
  // var namalokasiakhir = " ".obs;
  // var alamatlokasiakhir
    }
  }

  void updateMapp(String type, LatLngBounds markerBounds) async {
    if (type == "lokasi") {
      await mapLokasiController.onReady;
      mapLokasiController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(20)));
    } else {
      await mapDestinasiController.onReady;
      mapDestinasiController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(20)));
    }
  }

  void onClickSetPositionMarker() async {
    var result = await GetToPage.toNamed<PetaBFTMController>(
        Routes.PETA_BF_TM               ,
        arguments: {
          PetaBFTMController.latLngKey: _latLngFromArgms,
          PetaBFTMController.imageMarkerKey:
              Stack(alignment: Alignment.topCenter, children: [
            //  totalMarker.value == 1 && numberOfMarker == "1" ?
            Image.asset(
              'assets/pin_new.png',
              width: GlobalVariable.ratioWidth(Get.context) * 29.56,
              height: GlobalVariable.ratioWidth(Get.context) * 36.76,
            ),
            // SvgPicture.asset(
            //   totalMarker.value == 1
            //       ? "assets/pin_truck_icon.svg"
            //       : numberOfMarker == "1"
            //           ? "assets/pin_yellow_icon.svg"
            //           : "assets/pin_blue_icon.svg",
            //   width: GlobalVariable.ratioWidth(Get.context) * 22,
            //   height: GlobalVariable.ratioWidth(Get.context) * 29,
            // ),
            Container(
              margin: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 7),
              child: CustomText(totalMarker.value == 1 ? "" : numberOfMarker,
                  color: numberOfMarker != "1"
                      ? Colors.white
                      : Color(ListColor.color4),
                  fontWeight: FontWeight.w700,
                  fontSize: 10),
            )
          ]),
        });
    if (result != null) {
      _getDataInfoFromAddressPlaceID(address: result[1]);
      // _getBackWithResult(
      //   result[1],
      //   result[0],
      // );
    }
  }

  Future _getDataInfoFromAddressPlaceID(
      {@required String address, String placeID}) async {
    InfoFromAddressResponseModel response =
        await GetInfoFromAddressPlaceID.getInfo(
            address: placeID != null ? null : address, placeID: placeID);
    _addToSharedPref(AddressGoogleInfoPermintaanMuatModel(
        addressAutoComplete: AddressGooglePlaceAutoCompleteModel(
            description: address, placeId: placeID),
        addressDetails: AddressGooglePlaceDetailsModel(
            formattedAddress: address,
            latLng: LatLng(response.latitude, response.longitude),
            cityName: response.city,
            districtName: response.district)));
    if (response != null) {
      _getBackWithResult(
          address,
          LatLng(
            response.latitude,
            response.longitude,
          ),
          response.district,
          response.city);
    }
  }

  void _getBackWithResult(
      String address, LatLng latLng, String district, String city) {
    onClearSearch();
    Get.back(result: [address, latLng, district, city]);
  }

  final searchTextEditingController = TextEditingController().obs;
  final listSearchAddress = [].obs;
  final isSearchMode = false.obs;
  final isSearchingData = false.obs;
  SearchAddressGoogleFunction _searchAddressGoogleFunction;


  void onClearSearch() {
    searchTextEditingController.value.text = "";
    addTextSearch("");
  }

  void addTextSearch(String value) {
    listSearchAddress.clear();
    if (value == "") {
      listSearchAddress.addAll(_listSearchAddressTemp);
    }
    isSearchMode.value = value != "";
    isSearchingData.value = value != "";
    _searchAddressGoogleFunction.addTextCity(value);
  }

   void _addToSharedPref(AddressGoogleInfoPermintaanMuatModel data) {
    if (_listSearchAddressTemp.length > 0) {
      for (int i = 0; i < _listSearchAddressTemp.length; i++) {
        if (_listSearchAddressTemp[i]
                .addressAutoComplete
                .description
                .toLowerCase() ==
            data.addressAutoComplete.description.toLowerCase()) {
          _listSearchAddressTemp.removeAt(i);
          break;
        }
      }
    }
    _listSearchAddressTemp.insert(
        0, AddressGoogleInfoPermintaanMuatModel.copyData(data));
    if (_listSearchAddressTemp.length > 3)
      _listSearchAddressTemp.removeAt(_listSearchAddressTemp.length - 1);
    SharedPreferencesHelper.setHistorySearchLocationInfoPermintaanMuat(
        jsonEncode(_listSearchAddressTemp));
  }

var selectLokasi = Map().obs;
final String namaKey = "Nama";
  final String lokasiKey = "Lokasi";
  final String cityKey = "City";
  final String districtKey = "District";

  

void onClickAddress(int index) async {
    String addressName = selectLokasi[index.toString()] != null
        ? selectLokasi[index.toString()][namaKey] ?? ""
        : "";
    LatLng latLng = selectLokasi[index.toString()] != null
        ? selectLokasi[index.toString()][lokasiKey]
        : null;
    var result = await Get.toNamed(Routes.SEARCH_LOCATION_BF_TM,
        arguments: [
          (index + 1).toString(),
          totalLokasi,
          addressName,
          latLng,
        ]);
    if (result != null) {
      if (selectLokasi[index.toString()] != null)
        selectLokasi.remove(index.toString());
      selectLokasi[index.toString()] = _setMapLokasi(result[0] as String,
          result[1] as LatLng, result[2] as String, result[3] as String);
      updateMap();
      // totalLokasi.refresh();
    }
  }

  dynamic _setMapLokasi(
      String nama, LatLng lokasi, String city, String district) {
    return {
      namaKey: nama,
      lokasiKey: lokasi,
      cityKey: city,
      districtKey: district
    };
  }

  void updateMap() async {
    await mapController.onReady;
    var markerBounds = LatLngBounds();
    selectLokasi.values.forEach((element) {
      markerBounds.extend(element["Lokasi"]);
    });
    if (markerBounds.isValid) {
      mapController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(40)));
    }
  }

  checkCategory() {
    var bool = kategoriData.where((e) => e['IsSpecialLegal'] == 1).isNotEmpty;
    log('$bool');
    if (bool == true) {
      log('WITH LEGAL');
      isSpecialLegal.value = true;
    } else {
      log('WITHOUT LEGAL');
      isSpecialLegal.value = false;
      // GetToPage.offAllNamed<LegalitasNormalController>(
      //     Routes.SUCCESS_REGISTER_SELLER_WITHOUT_LEGALITY);
    }
  }

  //  void updateMap(String type, LatLngBounds markerBounds) async {
  //   if (type == "lokasi") {
  //     await mapLokasiController.onReady;
  //     mapLokasiController.fitBounds(markerBounds,
  //         options: FitBoundsOptions(padding: EdgeInsets.all(20)));
  //   } else {
  //     await mapDestinasiController.onReady;
  //     mapDestinasiController.fitBounds(markerBounds,
  //         options: FitBoundsOptions(padding: EdgeInsets.all(20)));
  //   }
  // }

  Future showUpload() {
    // type 1 = npwp
    // type 2 = ktp
    // type 3 = nib
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        backgroundColor: Colors.white,
        context: Get.context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: GlobalVariable.ratioHeight(Get.context) * 8,
                      bottom: GlobalVariable.ratioHeight(Get.context) * 18),
                  child: Container(
                    width: GlobalVariable.ratioHeight(Get.context) * 94,
                    height: GlobalVariable.ratioHeight(Get.context) * 5,
                    decoration: BoxDecoration(
                        color: Color(ListColor.colorLightGrey10),
                        borderRadius: BorderRadius.all(Radius.circular(90))),
                  )),
              Container(
                margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(Get.context) * 24),
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
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(context) * 50),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(context) * 50),
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(context) * 50),
                              ),
                              onTap: () async {
                                await getFromCamera();
                                // Get.back();
                                checkAllFieldIsFilled();
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20),
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
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(context) * 50),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(context) * 50),
                            color: Colors.transparent,
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(context) * 50),
                              ),
                              onTap: () async {
                                // getFromGallery(type);
                                await chooseFile();
                                // Get.back();
                                checkAllFieldIsFilled();
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20),
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

  // void getFromGallery(int type) async {
  //   PickedFile pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   _cropImage(pickedFile.path);
  // }
  Future<void> getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      // file.value = File(pickedFile.path);
      // await viewResult(file.value);
    }
  }

  Future<void> _cropImage(filePath) async {
    isSuccessUpload.value = false;
    fileDisplay.value.delete();

    // final fileResult = await GetToPage.toNamed<UploadLogoPerusahaanController>(
    //     Routes.UPLOAD_LOGO_PERUSAHAAN,
    //     arguments: filePath);
    // if (fileResult != null) {
    //   print("FILE RESULT :: $fileResult");
    //   fileDisplay.value = fileResult;
    //   isSuccessUpload.value = true;
    //   log("FILE VAL :: ${file.value}");
    // } else {
    //   isSuccessUpload.value = false;
    //   log("FILE VAL :: ${file.value}");
    // }
  }

  Future<double> getFileSize(File file) async {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);

    return sizeInMb;
  }

  Future<bool> isAllowedFormat(String path) async {
    final mimeType = lookupMimeType(path);

    log("File mimetype: " + mimeType);
    if (mimeType.endsWith('jpg') ||
        mimeType.endsWith('jpeg') ||
        mimeType.endsWith('png')) {
      return true;
    }

    return false;
  }

  Future<void> chooseFile() async {
    FilePickerResult pickedFile =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (pickedFile != null) {
      // log("Choosen File: " + pickedFile.names.toString());
      log("Choosen File: " + pickedFile.files.first.name.toString());
      log("Choosen File: " + pickedFile.files.first.size.toString());
      log("Choosen File: " + pickedFile.files.first.extension.toString());
      log("Choosen File: " + pickedFile.files.first.path.toString());
      // file.value = File(pickedFile.files.single.path);
      // file.value = File(pickedFile.files.first.path);
      // _cropImage(file.value);
      // await viewResult(file.value);
    }
  }

  Future<void> viewResult(File file) async {
    Get.back();
    String fileName = basename(file.path).toString();
    log("File: " + fileName);
    if (await getFileSize(file) <= 5) {
      if (await isAllowedFormat(file.path)) {
        // log("File: " + basename(file.path));
        errorMessage.value = "";
        log("File: SAFE");
        // addToList(type, file, fileName);
        await _cropImage(file);
      } else {
        errorMessage.value = "Format file Anda tidak sesuai!";
        CustomToastTop.show(
            context: Get.context, isSuccess: 0, message: errorMessage.value);
        file.writeAsString('');
        update();
        // log("File: " + errorMessage.toString());
        // addToList(type, null, errorMessage.value);
        return;
      }
    } else {
      errorMessage.value = "Ukuran File melebihi batas 5MB !";
      CustomToastTop.show(
          context: Get.context, isSuccess: 0, message: errorMessage.value);
      file.writeAsString('');
      update();

      return;
      // log("File: " + errorMessage.toString());
      // addToList(type, null, errorMessage.value);
    }
    // Navigator.pop(Get.context);
  }

  checkAllFieldIsFilled() {
    if (namaPerusahaanValue.value != "" &&
            // pilihBadanUsaha.value != null &&
            pilihBidangUsaha.value != null && 
        //     fileDisplay.value.path != "" ||
        // fileDisplay.value.path.isEmpty &&
            // alamatPerusahaanValue.value != "" &&
            // kecamatanPerusahaanText.value != "" &&
            // pilihKodePos.value != null &&
            namaPic1Value.value != "" &&
            email.value != "" &&
            noTelpPerusahaan.value != "" &&
            naoPic1Value.value != "") {
      isFilled.value = true;
    } else {
      isFilled.value = false;
    }
    log('VALID : (${isValid.value}) ' +
        'FIELD ' +
        '(${isFilled.value})  \n' +
        ' Nama Usaha : ${namaPerusahaanValue.value}' +
        ', Badan Usaha : ${pilihBadanUsaha.value}' +
        ', Bidang Usaha : ${pilihBidangUsaha.value}' +
        ', Alamat : ' '${alamatPerusahaanC.text}' +
        ', Kecamatan : ${kecamatanPerusahaanText.value}' +
        ', Logo : ${fileDisplay.value.path}' +
        ', KodePos : ${pilihKodePos.value}' +
        ', Kota : ${cityStoreArg.value}' +
        ', Prov : ${provinceStoreArg.value}' +
        ', NamaPIC1 : ${namaPIC1.text}' +
        ', NoPIC1 : ${noHpPIC1.text}' +
        ', NamaPIC2 : ${namaPIC2.text}' +
        ', NoPIC2 : ${noHpPIC2.text}' +
        ', NamaPIC3 : ${namaPIC2.text}' +
        ', Email : ${email.value}' +
        ', NoHpPIC3 : ${noHpPIC3.text}');
  }

  checkNamleField(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(
          message: "Nama PIC minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      return;
    }

    if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
      CustomToastTop.show(
          message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
      isNamaPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(
            message: "Nama PIC tidak valid!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic1Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  checkNamleField2(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(
          message: "Nama PIC minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPic2Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      return;
    }

    if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
      CustomToastTop.show(
          message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
      isNamaPic2Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(
            message: "Nama PIC tidak valid!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  pickContact1() async {
    isNamaPic1Valid.value = true;
    isNoPic1Valid.value = true;
    if (await checkAppPermissionContact() == PermissionStatus.granted) {
      // JIKA GRANTED
      Contact contactPicked = await contactPicker.selectContact();
      if (contactPicked != null) {
        var namaPicked = contactPicked.fullName.toString();
        namaPic1Value.value = namaPicked;
        namaPIC1.text = namaPic1Value.value;
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+ )'), "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+?0[0-9]{14}$'), "");
        naoPic1Value.value = noPicked;
        noHpPIC1.text = naoPic1Value.value;
        checkNamleField(namaPic1Value.value);
        log('NUMBER: ${naoPic1Value.value}----${naoPic1Value.value.length} ');
      }

      // LAKUKAN APA

    }
  }

  pickContact2() async {
    isNamaPic2Valid.value = true;
    isNoPic2Valid.value = true;
    if (await checkAppPermissionContact() == PermissionStatus.granted) {
      // JIKA GRANTED
      Contact contactPicked = await contactPicker.selectContact();
      if (contactPicked != null) {
        var namaPicked = contactPicked.fullName.toString();
        namaPic2Value.value = namaPicked;
        namaPIC2.text = namaPic2Value.value;
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+ )'), "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+?0[0-9]{14}$'), "");
        naoPic2Value.value = noPicked;
        noHpPIC2.text = naoPic2Value.value;
        checkNamleField2(namaPic2Value.value);
        log('NUMBER: ${naoPic2Value.value}----${naoPic2Value.value.length} ');
      }

      // LAKUKAN APA

    }
  }

  pickContact3() async {
    isNamaPic3Valid.value = true;
    isNoPic3Valid.value = true;
    if (await checkAppPermissionContact() == PermissionStatus.granted) {
      // JIKA GRANTED
      Contact contactPicked = await contactPicker.selectContact();
      if (contactPicked != null) {
        var namaPicked = contactPicked.fullName.toString();
        namaPic3Value.value = namaPicked;
        namaPIC3.text = namaPic3Value.value;
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+ )'), "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+?0[0-9]{14}$'), "");
        naoPic3Value.value = noPicked;
        noHpPIC3.text = naoPic3Value.value;
        checkNamleField3(namaPic3Value.value);
        log('NUMBER: ${naoPic3Value.value}----${naoPic3Value.value.length} ');
      }

      // LAKUKAN APA

    }
  }

  checkNamleField3(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(
          message: "Nama PIC minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPic3Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      return;
    }

    if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
      CustomToastTop.show(
          message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
      isNamaPic3Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(
            message: "Nama PIC tidak valid!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  Future<PermissionStatus> checkAppPermissionContact() async {
    //CEK STATUS PERMISSION
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      //JIKA TIDAK DISETUJUI / DITOLAK
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request(); //REQUEST PERMISION
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission; //RETURN CONTACT PERMISSIOn
    }
  }

  getBadanUsaha() async {
    // postalCodeUsahaList.clear();
    pilihBadanUsaha.value = null;
    var result = await ApiHelper(
            context: Get.context,
            isDebugGetResponse: true,
            isShowDialogLoading: false)
        .getBusinessField();
    badanUsahaList.value = result == null ? [] : result['Data'];
    print(badanUsahaList);
  }
  
  String getDeviceType(){
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  getBidangUsaha() async {
    // postalCodeUsahaList.clear();
    pilihBidangUsaha.value = null;
    var result = await ApiHelper(
            context: Get.context,
            isDebugGetResponse: true,
            isShowDialogLoading: false)
        .getBusinessEntity();
    bidangUsahaList.value = result == null ? [] : result['Data'];
    print(bidangUsahaList);
  }

  direct() async {
    if (isSpecialLegal.value == true) {
      // GetToPage.offAllNamed<LegalitasKhususController>(
      //   Routes.SUCCESS_REGISTER_SELLER_WITH_LEGALITY,
      // );
    } else {
      // await GetToPage.offAllNamed<LegalitasNormalController>(
      //   Routes.SUCCESS_REGISTER_SELLER_WITHOUT_LEGALITY,
      //   arguments: kategoriData,
      // );
    }
  }

  submitPendaftaran() async {
    loading.value = true;

    // MessageFromUrlModel message;

    var parameter = {
      "name": namaPerusahaanValue.value,
      "address": alamatPerusahaanC.text,
      "postal_code": pilihKodePos.value,
      "CityID": cityStoreArg.value,
      "ProvinceID": provinceStoreArg.value,
      "BusinessEntityID": pilihBadanUsaha.value,
      "BusinessFieldID": pilihBidangUsaha.value,
      "name1": namaPIC1.text,
      "no1": noHpPIC1.text,
      "name2": namaPIC2.text,
      "no2": noHpPIC2.text,
      "name3": namaPIC3.text,
      "no3": noHpPIC3.text,
    };

    var body = {"user_data": jsonEncode(parameter)};

    log("ISI JSON DI DAFTAR PERUSAHAAN : $body");

    // var response = await ApiLoginRegister(
    //   context: Get.context,
    //   isShowDialogError: true,
    //   isShowDialogLoading: true,
    // ).doRegisterUserSellerPerusahaan(body);
    // // message = response['Message'] != null
    // //     ? MessageFromUrlModel.fromJson(response['Data']['Message'])
    // //     : null;
    // log("RESPONSE DAFTAR PERUSAHAAN : $response");
    // if (response != null) {
    //   if (response["Message"]["Code"] == 200) {
    //     CustomToastTop.show(
    //         context: Get.context,
    //         message: response["Data"]['Message'],
    //         isSuccess: 1);
    //     if (isSpecialLegal.value == true) {
    //       // GetToPage.offAllNamed<LegalitasKhususController>(
    //       //   Routes.SUCCESS_REGISTER_SELLER_WITH_LEGALITY,
    //       // );
    //     } else {
    //       // await GetToPage.offAllNamed<LegalitasNormalController>(
    //       //   Routes.SUCCESS_REGISTER_SELLER_WITHOUT_LEGALITY,
    //       //   arguments: kategoriData,
    //       // );
    //     }
    //   } else {
    //     String errorMessage = response["Data"]["Message"];

    //     CustomToastTop.show(
    //         message: errorMessage, context: Get.context, isSuccess: 0);
    //   }
    //   loading.value = false;
    // }
  }
  
  checkNoTelpField(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isEmpty || value == "") {
      CustomToastTop.show(
          message: "No. HP PIC minimal 8 digit!", context: Get.context, isSuccess: 0);
      isNoTelpValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (length == false) {
      CustomToastTop.show(
          message: "No. HP PIC minimal 8 digit! ", context: Get.context, isSuccess: 0);
      isNoTelpValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (numeric == false) {
      CustomToastTop.show(
          message: "Format No Hp tidak sesuai!",
          context: Get.context,
          isSuccess: 0);
      isNoTelpValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    log('noHPValid : ${isNoPic1Valid.value}');
  }

  checkNoHP1Field(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isEmpty || value == "") {
      CustomToastTop.show(
          message: "No. HP PIC minimal 8 digit!", context: Get.context, isSuccess: 0);
      isNoPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (length == false) {
      CustomToastTop.show(
          message: "No. HP PIC minimal 8 digit!", context: Get.context, isSuccess: 0);
      isNoPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (numeric == false) {
      CustomToastTop.show(
          message: "Format No Hp tidak sesuai!",
          context: Get.context,
          isSuccess: 0);
      isNoPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    log('noHPValid : ${isNoPic1Valid.value}');
  }

  checkNoHP2Field(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isNotEmpty) {
      if (length == false) {
        CustomToastTop.show(
            message: "No. HP PIC minimal 8 digit!",
            context: Get.context,
            isSuccess: 0);
        isNoPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else if (numeric == false) {
        CustomToastTop.show(
            message: "No. HP PIC minimal 8 digit!",
            context: Get.context,
            isSuccess: 0);
        isNoPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }

    log('noHPValid : ${isNoPic2Valid.value}');
  }

  checkNoHP3Field(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isNotEmpty) {
      if (length == false) {
        CustomToastTop.show(
            message: "No. HP PIC minimal 8 digit!",
            context: Get.context,
            isSuccess: 0);
        isNoPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else if (numeric == false) {
        CustomToastTop.show(
            message: "Format No Hp tidak sesuai!",
            context: Get.context,
            isSuccess: 0);
        isNoPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
      log('noHPValid : $isNoPic3Valid{.value}');
    }
  }

  checkNameUsahaField(String value) {
    if (value == "" || value.isEmpty) {
      CustomToastTop.show(
          message: "Nama Minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPerusahaanValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    if (value.length.isLowerThan(3)) {
      CustomToastTop.show(
          message: "Nama Minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPerusahaanValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    if (value.isNumericOnly || value.isNum) {
      CustomToastTop.show(
          message: "Format Nama tidak sesuai!",
          context: Get.context,
          isSuccess: 0);
      isNamaPerusahaanValid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(
            message: "Format Nama tidak sesuai!",
            context: Get.context,
            isSuccess: 0);
        isNamaPerusahaanValid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  checkBadanUsahaField(String value) {
    if (value == "" || value.isEmpty) {
      CustomToastTop.show(
          message: "Field badan usaha harus diisi!",
          context: Get.context,
          isSuccess: 0);
      isbadanUsahaValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
  }

  checkBidangUsahaField(String value) {
    if (value == "" || value.isEmpty) {
      CustomToastTop.show(
          message: "Field bidang usaha harus diisi!",
          context: Get.context,
          isSuccess: 0);
      isBidangUsahaValid.value = false;
      isFilled.value = false;
      isValid.value = false;
      return;
    }
  }

  checkNamle1Field(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(
          message: "Nama Minimal 3 karakter!",
          context: Get.context,
          isSuccess: 0);
      isNamaPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    else
    if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
      CustomToastTop.show(
          message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
      isNamaPic1Valid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(
            message: "Nama PIC tidak valid!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic1Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
    // if (value.isNumericOnly || value.isNum) {
    //   CustomToastTop.show(
    //       message: "Format Nama tidak sesuai!",
    //       context: Get.context,
    //       isSuccess: 0);
    //   isNamaPic1Valid.value = false;
    //   isFilled.value = false;
    //   isValid.value = false;
    //   var start = value[0];
    //   if (value.endsWith(start)) {
    //     CustomToastTop.show(
    //         message: "Format Nama tidak sesuai!",
    //         context: Get.context,
    //         isSuccess: 0);
    //     isNamaPic1Valid.value = false;
    //     isFilled.value = false;
    //     isValid.value = false;
    //   }
    //   CustomToastTop.show(
    //       message: "Format Nama tidak sesuai!",
    //       context: Get.context,
    //       isSuccess: 0);
    //   isNamaPic1Valid.value = false;
    //   isFilled.value = false;
    //   isValid.value = false;
    // } else {
    //   var start = value[0];
    //   if (value.endsWith(start)) {
    //     CustomToastTop.show(
    //         message: "Format Nama tidak sesuai!",
    //         context: Get.context,
    //         isSuccess: 0);
    //     isNamaPic1Valid.value = false;
    //     isFilled.value = false;
    //     isValid.value = false;
    //   }
    // }
  }

  checkNamle2Field(String value) {
    if (value.isNotEmpty) {
      if (value.length.isLowerThan(3)) {
        CustomToastTop.show(
            message: "Nama Minimal 3 karakter!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
      if (value.isNumericOnly || value.isNum) {
        CustomToastTop.show(
            message: "Format Nama tidak sesuai!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(
              message: "Format Nama tidak sesuai!",
              context: Get.context,
              isSuccess: 0);
          isNamaPic2Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
        CustomToastTop.show(
            message: "Format Nama tidak sesuai!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic2Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else {
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(
              message: "Format Nama tidak sesuai!",
              context: Get.context,
              isSuccess: 0);
          isNamaPic2Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
      }
    }
  }

  checkNamle3Field(String value) {
    if (value.isNotEmpty) {
      if (value.length.isLowerThan(3)) {
        CustomToastTop.show(
            message: "Nama Minimal 3 karakter!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
      if (value.isNumericOnly || value.isNum) {
        CustomToastTop.show(
            message: "Format Nama tidak sesuai!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(
              message: "Format Nama tidak sesuai!",
              context: Get.context,
              isSuccess: 0);
          isNamaPic3Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
        CustomToastTop.show(
            message: "Format Nama tidak sesuai!",
            context: Get.context,
            isSuccess: 0);
        isNamaPic3Valid.value = false;
        isFilled.value = false;
        isValid.value = false;
      } else {
        var start = value[0];
        if (value.endsWith(start)) {
          CustomToastTop.show(
              message: "Format Nama tidak sesuai!",
              context: Get.context,
              isSuccess: 0);
          isNamaPic3Valid.value = false;
          isFilled.value = false;
          isValid.value = false;
        }
      }
    }
  }

  checkAlamatField(String value) {
    if (value.isEmpty || value == "") {
      CustomToastTop.show(
          message: "Alamat tidak boleh kososng",
          context: Get.context,
          isSuccess: 0);
      isAlamaPerusahaanValid.value = false;
      isFilled.value = false;
    }
  }

  checkEmailField(String value) {
    print('zehahaha');
    if (value.isEmpty || value == "") {
    isEmailValid.value = false;
    isFilled.value = false;
      CustomToastTop.show(
          message: "Email tidak boleh kosong",
          context: Get.context,
          isSuccess: 0);
    }
    else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
    
    }
    else {
    isEmailValid.value = false;
    isFilled.value = false;
      CustomToastTop.show(
          message: "Format penulisan email Anda salah!",
          context: Get.context,
          isSuccess: 0);
    }
  }

  checkFieldIsValid() async {
    // await checkAlamatField(alamatPerusahaanC.text);
    await checkNameUsahaField(namaPerusahaanValue.value);
    await checkBidangUsahaField(pilihBidangUsaha.value);
    // await checkBadanUsahaField(pilihBadanUsaha.value);
    await checkNamle1Field(namaPIC1.text);
    await checkNoHP1Field(noHpPIC1.text);
    await checkEmailField(email.value);
    if (isNamaPerusahaanValid.value != false &&
        // isbadanUsahaValid.value != false &&
        isBidangUsahaValid.value != false &&
        isAlamaPerusahaanValid.value != false &&
        isEmailValid.value != false &&
        isKecamatanValid.value != false &&
        isKodePosValid.value != false &&
        isNamaPic1Valid.value != false &&
        isNoPic1Valid.value != false &&
        isNoTelpValid.value != false) {
      isValid.value = true;
      
      if(isValid.value == true){
        GetToPage.toNamed<UploadLegalitasController>(Routes.UPLOAD_LEGALITAS, arguments: {"type": tipeModul.value, "entity": TipeBadanUsaha.PT_CV});
      }
      else{

      }
    } else {
      isValid.value = false;
    }
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
}
