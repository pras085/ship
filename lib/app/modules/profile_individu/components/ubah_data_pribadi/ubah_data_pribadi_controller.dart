import 'dart:developer';

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

class UbahDataPribadiController extends GetxController {
  var profilC = Get.find<ProfileIndividuController>();

  // VARIBAEL FIELD
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
    lokasiakhir.value = profilC.dataPribadi.data.personalAddress;
    districtController.value.text = profilC.dataPribadi.data.personalDistrictName;
    kodepos.value = profilC.dataPribadi.data.personalPostalCode;
    pilihKodePos.value = profilC.dataPribadi.data.personalPostalCode;

    cityID.value = profilC.dataPribadi.data.personalCityID;
    provinceID.value = profilC.dataPribadi.data.personalProvinceID;
    districtID.value = profilC.dataPribadi.data.personalDistrictID;
    await getIdUsaha(districtID.value);
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
      onTapPriority2: () => submitPerubahan(),
      onTapPriority1: () {},
      widthButton1: 104,
      widthButton2: 104,
      heightButton1: 31,
      heightButton2: 31,
    );
  }

  checkAllFieldIsFilled() {
    if (lokasiakhir.value != "" && districtController.value.text != "" && kodepos.value != "") {
      isFilled.value = true;
    } else {
      isFilled.value = false;
    }
    log('VALID : (${isValid.value}) ' +
        'FIELD ' +
        '(${isFilled.value})  \n' +
        'Alamat : ' '${lokasiakhir.value}' +
        ', Kecamatan : ' '${districtController.value.text}' +
        ', Kode Pos: ' '${kodepos.value}');
  }

  submitPerubahan() async {
    var parameter = {
      "PersonalAddress": lokasiakhir.value,
      "PersonalDistrictID": districtID.value.toString(),
      "PersonalCityID": cityID.value.toString(),
      "PersonalProvinceID": provinceID.value.toString(),
      "PersonalPostalCode": kodepos.value,
    };

    var response = await ApiProfile(
      context: Get.context,
      isShowDialogError: true,
      isShowDialogLoading: true,
    ).updateDataPribadiUsers(parameter);
    if (response != null) {
      if (response["Message"]["Code"] == 200) {
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
    }
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
      log(':: (RES) : ' + result.toString());
      placeidd.value = result[1];
      log(':: (RES)PLACE ID : ' + placeidd.value);
      districtController.value.clear();
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
      log(':: LOC AKHIR : ' + '${lokasiakhir.value}');
      // print(latlngLokasi.toString().substring(20)+' ikura');
      int index = lokasiakhir.indexOf(',');
      namalokasiakhir.value = lokasiakhir.substring(0, index).trim();
      alamatlokasiakhir.value = lokasiakhir.substring(index + 1).trim();
      log(':: NAMA LOC AKHIR : ' + '${namalokasiakhir.value}');
      log(':: ALAMAT LOC AKHIR :' + '${alamatlokasiakhir.value}');
      checkAllFieldIsFilled();
      // var namalokasiakhir = " ".obs;
      // var alamatlokasiakhir
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
    // print(postalCodeList);
  }
}
