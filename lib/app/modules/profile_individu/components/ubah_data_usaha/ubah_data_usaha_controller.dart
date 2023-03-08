import 'dart:developer';

import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/api_profile.dart';
import 'package:muatmuat/app/modules/profile_individu/profile_individu_controller.dart';
import 'package:muatmuat/app/modules/ubah_data_perusahaan/component/lokasi_data_perusahaan/lokasi_ubah_data_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:string_validator/string_validator.dart' as sv;

class UbahDataUsahaController extends GetxController {
  var profilC = Get.find<ProfileIndividuController>();
  final ContactPicker contactPicker = ContactPicker();

  // VARIBAEL FIELD
  var namaUsahaValue = "".obs;
  var namaPICValue = "".obs;
  var noHpPICValue = "".obs;
  TextEditingController namaUsaha = TextEditingController();
  TextEditingController namaPICC = TextEditingController();
  TextEditingController alamatUsahaC = TextEditingController();
  TextEditingController noPICC = TextEditingController();

  var postalCodeList = [].obs;

  var provinceStoreArg = "".obs;
  var cityStoreArg = "".obs;
  var idKecamatanResult = Rxn<int>();
  var kecamatanPerusahaanText = "".obs;

  // MAPS
  var namaLokasi = {}.obs;
  var latlngLokasi = {}.obs;
  var cityLokasi = {}.obs;
  var districtLokasi = {}.obs;
  var totalLokasi = "1".obs;
  var totalDestinasi = "1".obs;
  var namaDestinasi = {}.obs;
  var latlngDestinasi = {}.obs;
  var cityDestinasi = {}.obs;
  var districtDestinasi = {}.obs;
  RxString placeidd = "".obs;
  var markerBounds = LatLngBounds();
  var mapLokasiController = MapController();
  var mapDestinasiController = MapController();
  var lokasiakhir = " ".obs;
  var namalokasiakhir = " ".obs;
  var alamatlokasiakhir = " ".obs;
  var distid = "".obs;
  var districtID = 1.obs;
  var provinceID = 1.obs;
  var cityID = 1.obs;

  // VALIDASI
  var isValid = false.obs;
  var isFilled = false.obs;
  var isNamaUsahaValid = true.obs;
  var isNamaPicValid = true.obs;
  var isNoPicValid = true.obs;
  var kodepos = "".obs;
  var pilihKodePos = Rxn<String>();
  var districtController = TextEditingController().obs;

  @override
  void onInit() async {
    super.onInit();
    await getData();
    await checkAllFieldIsFilled();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> getData() async {
    namaUsaha.text = profilC.dataUsaha.data.companyName;
    namaPICC.text = profilC.dataUsaha.data.pic1Name;
    namaPICValue.value = profilC.dataUsaha.data.pic1Name;
    noPICC.text = profilC.dataUsaha.data.pic1Phone;
    lokasiakhir.value = profilC.dataUsaha.data.companyAddress;
    districtController.value.text = profilC.dataUsaha.data.personalDistrictName;
    kodepos.value = profilC.dataUsaha.data.companyPostalCode;
    pilihKodePos.value = profilC.dataUsaha.data.companyPostalCode;
    cityID.value = profilC.dataUsaha.data.companyCityID;
    provinceID.value = profilC.dataUsaha.data.companyProvinceID;
    districtID.value = profilC.dataUsaha.data.companyDistrictID;
  }

  submitPendaftaran() async {
    var parameter = {
      "CompanyName": namaUsaha.value.text,
      "CompanyAddress": lokasiakhir.value,
      "CompanyDistrictID": districtID.value.toString(),
      "CompanyCityID": cityID.value.toString(),
      "CompanyProvinceID": provinceID.value.toString(),
      "CompanyPostalCode": kodepos.value,
      "CompanyLogo": '',
      "Pic1Name": namaPICC.text,
      "Pic1Phone": noPICC.text,
    };

    var response = await ApiProfile(
      context: Get.context,
      // isShowDialogError: true,
      isShowDialogLoading: true,
      // isDebugGetResponse: true,
    ).updateDataUsahaUsers(parameter);
    if (response != null) {
      if (response["Message"]["Code"] == 200) {
        print(response["Message"]['Data']);
        Get.back();
        CustomToastTop.show(
          context: Get.context,
          message: response["Data"]['Message'],
          isSuccess: 1,
        );
        profilC.fetchDataIndividu();
      } else {
        String errorMessage = response["Data"]["Message"];
        print('EROR :: $errorMessage');
        CustomToastTop.show(
          context: Get.context,
          message: errorMessage,
          isSuccess: 0,
        );
      }
    } else {
      isFilled.value = false;
      isValid.value = false;
    }
  }

  void cancel() {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "ShipperUbahDataPerusahaanIndexLabelAlert".tr,
      context: Get.context,
      customMessage: Container(
        margin: EdgeInsets.only(
          bottom: GlobalVariable.ratioWidth(Get.context) * 16,
        ),
        child: CustomText(
          "ShipperUbahDataPerusahaanIndexLabelIsiAlert".tr,
          textAlign: TextAlign.center,
          fontSize: 14,
          height: 21 / 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      borderRadius: 12,
      labelButtonPriority1: "Batal",
      labelButtonPriority2: "Simpan",
      positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY2,
      onTapPriority2: () => submitPendaftaran(),
      onTapPriority1: () {},
      widthButton1: 104,
      widthButton2: 104,
      heightButton1: 31,
      heightButton2: 31,
    );
  }

  checkNoHPField(String value) {
    var length = sv.isLength(value, 8, 14);
    var numeric = sv.isNumeric(value);
    if (value.isEmpty || value == "") {
      CustomToastTop.show(message: "No Hp minimal 8 digit", context: Get.context, isSuccess: 0);
      isNoPicValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (length == false) {
      CustomToastTop.show(message: "No Hp minimal 8 digit", context: Get.context, isSuccess: 0);
      isNoPicValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    } else if (numeric == false) {
      CustomToastTop.show(message: "Format No Hp tidak sesuai", context: Get.context, isSuccess: 0);
      isNoPicValid.value = false;
      isFilled.value = false;
      isValid.value = false;
    }
    // log('noHPValid : ${isNoPicValid.value}');
  }

  pickContact() async {
    isNamaPicValid.value = true;
    isNoPicValid.value = true;
    if (await checkAppPermissionContact() == PermissionStatus.granted) {
      // JIKA GRANTED
      Contact contactPicked = await contactPicker.selectContact();
      if (contactPicked != null) {
        var namaPicked = contactPicked.fullName.toString();
        namaPICValue.value = namaPicked;
        namaPICC.text = namaPICValue.value;
        var noPicked = contactPicked.phoneNumber.number.toString();
        noPicked = noPicked.replaceAll('+', "");
        noPicked = noPicked.replaceAll('-', "");
        noPicked = noPicked.replaceAll(' ', "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+ )'), "");
        // var noFormat = noPicked.replaceAll(RegExp(r'(\-+?0[0-9]{14}$'), "");
        noHpPICValue.value = noPicked;
        noPICC.text = noHpPICValue.value;
        checkNamleField(namaPICValue.value);
        log('NUMBER: ${noHpPICValue.value}----${noHpPICValue.value.length} ');
      }

      // LAKUKAN APA

    }
  }

  Future<PermissionStatus> checkAppPermissionContact() async {
    //CEK STATUS PERMISSION
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.denied) {
      //JIKA TIDAK DISETUJUI / DITOLAK
      final Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request(); //REQUEST PERMISION
      return permissionStatus[Permission.contacts] ?? PermissionStatus.undetermined;
    } else {
      return permission; //RETURN CONTACT PERMISSIOn
    }
  }

  checkNamleField(String value) {
    if (value == "" || value.isEmpty || value.length.isLowerThan(3)) {
      CustomToastTop.show(message: "Nama PIC minimal 3 karakter!", context: Get.context, isSuccess: 0);
      isNamaPicValid.value = false;
      isFilled.value = false;
      isValid.value = false;
      return;
    }

    if (!value.contains(RegExp(r"[a-zA-Z0-9.' ]")) || value.isNumericOnly) {
      CustomToastTop.show(message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
      isNamaPicValid.value = false;
      isFilled.value = false;
      isValid.value = false;
      var start = value[0];
      if (value.endsWith(start)) {
        CustomToastTop.show(message: "Nama PIC tidak valid!", context: Get.context, isSuccess: 0);
        isNamaPicValid.value = false;
        isFilled.value = false;
        isValid.value = false;
      }
    }
  }

  checkFieldIsValid() async {
    await checkNamleField(namaUsaha.text);
    await checkNamleField(namaPICC.text);
    await checkNoHPField(noPICC.text);
    if (isNamaUsahaValid.value != false && isNamaPicValid.value != false && isNoPicValid.value != false) {
      isValid.value = true;
      submitPendaftaran();
    } else {
      isValid.value = false;
    }
  }

  checkAllFieldIsFilled() {
    if (namaUsaha.text != "" &&
        lokasiakhir.value != "" &&
        namaPICC.text != "" &&
        noPICC.text != "" &&
        districtController.value.text.isNotEmpty &&
        kodepos.value != null) {
      isFilled.value = true;
    } else {
      isFilled.value = false;
    }
    log('VALID : (${isValid.value}) ' +
            'FIELD ' +
            '(${isFilled.value})  \n' +
            ' NamaUsaha : ${namaUsaha.text}' +
            ', NamaPIC : ${namaPICC.text}' +
            ', NoPIC : ${noPICC.text}' +
            ', Alamat : ' '${lokasiakhir.value}' +
            ', Kecamatan : ' '${districtController.value.text}' +
            ', Kode Pos: ' '${kodepos.value}'
        // ', Distri : ${idKecamatanResult.value}' +
        // ', Kota : ${cityArg.value}' +
        // ', Prov : ${provinceArg.value}' +
        // ', KodePos : ${pilihKodePosValue.value}' +
        // ', Logo : ${uploadLogoC.file.value.path}' +
        // ', AlmtStr : ${alamatUsahaValue.value}' +
        // ', KotaStr : ${cityStoreArg.value}' +
        // ', KodePosStr : ${pilihKodePosUsahaValue.value}',

        );
  }

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
      distid.value = "";
      // log(':: (RES) : ' + result.toString());
      placeidd.value = result[1];
      // log(':: (RES)PLACE ID : ' + placeidd.value);
      districtController.value.clear();
      kecamatanPerusahaanText.value = null;
      kodepos.value = null;
      pilihKodePos.value = null;
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

      namaLokasi.refresh();
      lokasiakhir.value = (namaLokasi.values.toString().substring(1, namaLokasi.values.toString().length - 1));
      // log(':: LOC AKHIR : ' + '${lokasiakhir.value}');
      // print(latlngLokasi.toString().substring(20)+' ikura');
      int index = lokasiakhir.indexOf(',');
      namalokasiakhir.value = lokasiakhir.substring(0, index).trim();
      alamatlokasiakhir.value = lokasiakhir.substring(index + 1).trim();
      // log(':: NAMA LOC AKHIR : ' + '${namalokasiakhir.value}');
      // log(':: ALAMAT LOC AKHIR :' + '${alamatlokasiakhir.value}');
      // var namalokasiakhir = " ".obs;
      // var alamatlokasiakhir
      checkAllFieldIsFilled();
    } else {}
  }

  getIdUsaha(int idKecamatan) async {
    postalCodeList.clear();
    pilihKodePos.value = null;
    var result = await ApiHelper(
      context: Get.context,
      isDebugGetResponse: true,
      isShowDialogLoading: false,
    ).getPostalCode(idKecamatan.toString());
    postalCodeList.value = result == null ? [] : result['Data'];
  }
}
