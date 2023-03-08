import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/dialog_search_city_by_google.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/api_permintaan_muat.dart';
import 'package:muatmuat/app/modules/list_user/list_user_controller.dart';
import 'package:muatmuat/app/modules/select_list_lokasi/select_list_lokasi_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class CreatePermintaanMuatController extends GetxController {
  var slideIndex = 0.obs;
  var pageController = PageController();
  var title = "".obs;
  var loadingAPI = false.obs;
  // var subtitle = "".obs;

  // var deskripsiController = TextEditingController();
  // var catatanTambahanController = TextEditingController();

  var dateFormat = DateFormat('yyyy-MM-dd kk:mm:ss');
  // var dateFormatAPI = DateFormat('dd-MM-yyyy kk:mm:ss');
  
  var firstTimeInit = true;

  //First page
  var formOne = GlobalKey<FormState>();
  var tanggalDibuat = "".obs;
  var jenisLokasi = "0".obs;
  var totalLokasi = "1".obs;
  var selectedWaktuLokasi = DateTime.now().obs;
  var selectedWaktuLokasiController = TextEditingController();
  var selectedTimezoneLokasi = "WITA".obs;
  var namaLokasi = {}.obs;
  var latlngLokasi = {}.obs;
  var cityLokasi = {}.obs;
  var districtLokasi = {}.obs;
  var deskripsiLokasi = {}.obs;
  var namaPICPickup = {}.obs;
  var nomorPICPickup = {}.obs;
  var textEditingControllerNoPICPickUp = {}.obs;
  var mapLokasiController = MapController();
  var loadMapLokasi = false.obs;

  //Second page
  var formTwo = GlobalKey<FormState>();
  var jenisDestinasi = "0".obs;
  var totalDestinasi = "1".obs;
  var selectedWaktuDestinasi = DateTime.now().obs;
  var selectedWaktuDestinasiController = TextEditingController();
  var selectedTimezoneDestinasi = "WITA".obs;
  var namaDestinasi = {}.obs;
  var latlngDestinasi = {}.obs;
  var cityDestinasi = {}.obs;
  var districtDestinasi = {}.obs;
  var deskripsiDestinasi = {}.obs;
  var namaPICDestinasi = {}.obs;
  var nomorPICDestinasi = {}.obs;
  var textEditingControllerNoPICDestinasi = {}.obs;
  var mapDestinasiController = MapController();
  var loadMapDestinasi = false.obs;

  //Third page
  var formThree = GlobalKey<FormState>();
  var editHeadTruk = {}.obs;
  var editHeadTruckController = TextEditingController();
  var editKarierTruk = {}.obs;
  var editKarierTruckController = TextEditingController();
  var kapasitas = "-".obs;
  var linkImage = "".obs;
  var jumlahTruckController = TextEditingController();

  //Fourth page
  var formFour = GlobalKey<FormState>();
  var deskripsi = "".obs;
  var beratController = TextEditingController();
  var berat = "".obs;
  var volumeController = TextEditingController();
  var volume = "".obs;
  // var panjangController = TextEditingController();
  // var lebarController = TextEditingController();
  // var tinggiController = TextEditingController();
  var dimensiController = TextEditingController();
  var jumlahKoliController = TextEditingController();
  var catatanTambahan = "".obs;
  var selectedJenisMitra = {}.obs;
  var selectedGroup = [].obs;
  var selectedTransporter = [].obs;
  var listInvited = {}.obs;
  var jumlahMitra = 0.obs;
  // var status = "0".obs;
  var limitTampil = 7;
  var listStatus = [
    "InfoPermintaanMuatLabelAktif".tr,
    "InfoPermintaanMuatLabelNonAktif".tr,
    "InfoPermintaanMuatLabelBatal".tr
  ];

  var diumumkanKepadaTextSpan = [].obs;

  var inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(ListColor.colorGrey2), width: 1)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(ListColor.colorGrey2), width: 1)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(ListColor.colorGrey2), width: 1)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(ListColor.color4), width: 1)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(ListColor.colorRed), width: 1)),
  );

  @override
  void onInit() {
  }

  void firstInit() {
    if(firstTimeInit){
      firstTimeInit = false;
      tanggalDibuat.value = dateFormat.format(DateTime.now());
      updateTitle();
      setTextEditingControllerNoPICPickUp();
      setTextEditingControllerNoPICDestinasi();

      if (Get.arguments != null) {
        var map = Get.arguments[0];

        //First Page
        var position = 0;
        var lokasiBounds = LatLngBounds();
        jenisLokasi.value = map["type_pickup"].toString();
        totalLokasi.value = map["countPickUp"].toString();
        setTextEditingControllerNoPICPickUp();
        selectedWaktuLokasi.value = DateTime.parse(map["estimasi_muat"]);
        selectedWaktuLokasiController.text =
            dateFormat.format(selectedWaktuLokasi.value);
        selectedTimezoneLokasi.value = map["zona_muat_code_new"];
        (map["AlamatPickup"] as List).forEach((element) {
          namaLokasi[position.toString()] = element["Alamat"];
          latlngLokasi[position.toString()] =
              LatLng(element["Lat"], element["Lng"]);
          lokasiBounds.extend(LatLng(element["Lat"], element["Lng"]));
          deskripsiLokasi[position] = element["AlamatDetail"];
          cityLokasi[position] = element["Kota"];
          districtLokasi[position] = element["Kecamatan"];
          namaPICPickup[position] = element["nama_pic"];
          nomorPICPickup[position] = element["no_pic"].toString();
          (textEditingControllerNoPICPickUp[position] as TextEditingController)
              .text = element["no_pic"].toString();
          position++;
        });
        if (lokasiBounds.isValid) {
          updateMap("lokasi", lokasiBounds);
        }

        //Second page
        position = 0;
        var destinasiBounds = LatLngBounds();
        jenisDestinasi.value = map["type_bongkar"].toString();
        totalDestinasi.value = map["countBongkar"].toString();
        setTextEditingControllerNoPICDestinasi();
        selectedWaktuDestinasi.value = DateTime.parse(map["estimasi_bongkar"]);
        selectedWaktuDestinasiController.text =
            dateFormat.format(selectedWaktuDestinasi.value);
        selectedTimezoneDestinasi.value = map["zona_bongkar_code_new"];
        (map["AlamatBongkar"] as List).forEach((element) {
          namaDestinasi[position.toString()] = element["Alamat"];
          latlngDestinasi[position.toString()] =
              LatLng(double.parse(element["Lat"]), double.parse(element["Lng"]));
          destinasiBounds.extend(
              LatLng(double.parse(element["Lat"]), double.parse(element["Lng"])));
          deskripsiDestinasi[position] = element["AlamatDetail"];
          cityDestinasi[position] = element["Kota"];
          districtDestinasi[position] = element["Kecamatan"];
          namaPICDestinasi[position] = element["nama_pic"];
          nomorPICDestinasi[position] = element["no_pic"];
          (textEditingControllerNoPICDestinasi[position] as TextEditingController)
              .text = element["no_pic"].toString();
          position++;
        });
        if (destinasiBounds.isValid) {
          updateMap("destinasi", destinasiBounds);
        }

        //Third page
        editHeadTruk.value = {
          "ID": map["dbm_head_truckID"],
          "Description": map["jenis_truck"]
        };
        editHeadTruckController.text = map["jenis_truck"];
        editKarierTruk.value = {
          "ID": map["dbm_carrier_truckID"],
          "Description": map["jenis_carrier"]
        };
        editKarierTruckController.text = map["jenis_carrier"];
        checkImage();
        jumlahTruckController.text = map["jumlah_truck_str"];

        //Fourth page
        deskripsi.value = map["deskripsi"];
        beratController.text = map["berat"].toString();
        berat.value = map["berat"].toString();
        volumeController.text = map["volume"].toString();
        volume.value = map["volume"].toString();
        dimensiController.text = map["dimensi"] != null
            ? map["dimensi"]
            : '${map["dimensi_p"]}m x ${map["dimensi_l"]}m x ${map["dimensi_t"]}m';
        jumlahKoliController.text = map["jumlah_koli"].toString();
        var updateCatatan = "";
        (map["AllCatatan"] as List).forEach((element) {
          var textAdd = (map["AllCatatan"] as List).first == element ? "" : "\n";
          updateCatatan = updateCatatan + textAdd + element["catatan"];
        });
        catatanTambahan.value = updateCatatan;
        selectedJenisMitra.clear();
        selectedGroup.clear();
        selectedTransporter.clear();
        (map["invitation"] as List).forEach((element) {
          selectedTransporter
              .add({"id": element["TransporterID"], "name": element["name"]});
        });
        jumlahMitra.value = selectedJenisMitra.length +
            selectedGroup.length +
            selectedTransporter.length +
            listInvited.length;
        //status.value = map["status_str"];
      }
    }
  }

  void onCompleteBuildWidget() {
    firstInit();
  }

  void updateTitle() {
    switch (slideIndex.value) {
      case 0:
        {
          title.value = "Data Pickup/Muat";
          break;
        }
      case 1:
        {
          title.value = "Data Destinasi/Bongkar";
          break;
        }
      case 2:
        {
          title.value = "Data Kebutuhan Truk";
          break;
        }
      case 3:
        {
          title.value = "Data Muatan";
          break;
        }
    }
  }

  void onClickAddress(String type) async {
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
    var result = await GetToPage.toNamed<SelectListLokasiController>(
        Routes.SELECT_LIST_LOKASI,
        arguments: [type, map, total]);
    if (result != null) {
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
        updateMap(type, markerBounds);
      }
      namaLokasi.refresh();
    }
  }

  void updateMap(String type, LatLngBounds markerBounds) async {
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

  void refreshMap(int index) async {
    var markerBounds = LatLngBounds();
    switch (index) {
      case 0:
        {
          loadMapLokasi.value = true;
          latlngLokasi.values.forEach((element) {
            markerBounds.extend(element);
          });
          if (markerBounds.isValid) {
            await mapLokasiController.onReady;
            mapLokasiController.fitBounds(markerBounds,
                options: FitBoundsOptions(padding: EdgeInsets.all(20)));
          }
          loadMapLokasi.value = false;
          break;
        }
      case 1:
        {
          loadMapDestinasi.value = true;
          latlngDestinasi.values.forEach((element) {
            markerBounds.extend(element);
          });
          if (markerBounds.isValid) {
            await mapDestinasiController.onReady;
            mapDestinasiController.fitBounds(markerBounds,
                options: FitBoundsOptions(padding: EdgeInsets.all(20)));
          }
          loadMapDestinasi.value = false;
          break;
        }
    }
  }

  void checkImage() async {
    if (editHeadTruk.isNotEmpty && editKarierTruk.isNotEmpty) {
      var result = await ApiHelper(
              context: Get.context, isShowDialogLoading: false)
          .getSpecificTruck(
              editHeadTruk["ID"].toString(), editKarierTruk["ID"].toString());
      if (result["Data"].isNotEmpty)
        linkImage.value = result["Data"]["TruckURL"];
        kapasitas.value = "${result["Data"]["Tonase"]} ton (${result["Data"]["Width"]}m x ${result["Data"]["Height"]}m x ${result["Data"]["Height"]}m)";
    } else {
      linkImage.value = "";
      kapasitas.value = "-";
    }
  }

  @override
  void onReady() {}

  void onSave() async {
    loadingAPI.value = true;
    String shipperID = await SharedPreferencesHelper.getUserShipperID();
    var latPickup = [];
    var lngPickup = [];
    latlngLokasi.values.toList().forEach((element) {
      latPickup.add((element as LatLng).latitude.toString());
      lngPickup.add((element as LatLng).longitude.toString());
    });

    var latDestinasi = [];
    var lngDestinasi = [];
    latlngDestinasi.values.toList().forEach((element) {
      latDestinasi.add((element as LatLng).latitude.toString());
      lngDestinasi.add((element as LatLng).longitude.toString());
    });

    var invitation = {};
    var transporter = [];
    selectedTransporter.forEach((element) {
      transporter.add(element["id"].toString());
    });
    if (transporter.length > 0) invitation["transporter"] = transporter;

    var grup = [];
    selectedGroup.forEach((element) {
      grup.add(element["ID"].toString());
    });
    if (grup.length > 0) invitation["group"] = grup;
    var allInvitationList = [];
    if (selectedJenisMitra.values.toList().contains("Semua Transporter")) {
      allInvitationList.add("allTransporter");
    } 
    if (selectedJenisMitra.values.toList().contains("Semua Mitra")) {
      allInvitationList.add("allMitra");
    }
    if(allInvitationList.isNotEmpty){
      invitation["all"] = allInvitationList;
    }
    
    var response = await ApiPermintaanMuat(
            context: Get.context, isShowDialogLoading: false)
        .createPermintaanMuat(
            shipperID,
            tanggalDibuat.value,
            jenisLokasi.value,
            totalLokasi.value,
            latPickup,
            lngPickup,
            namaLokasi.values.toList(),
            deskripsiLokasi.values.toList(),
            cityLokasi.values.toList(),
            districtLokasi.values.toList(),
            namaPICPickup.values.toList(),
            nomorPICPickup.values.toList(),
            dateFormat.format(selectedWaktuLokasi.value),
            jenisDestinasi.value,
            totalDestinasi.value,
            latDestinasi,
            lngDestinasi,
            namaDestinasi.values.toList(),
            deskripsiDestinasi.values.toList(),
            cityDestinasi.values.toList(),
            districtDestinasi.values.toList(),
            namaPICDestinasi.values.toList(),
            nomorPICDestinasi.values.toList(),
            dateFormat.format(selectedWaktuDestinasi.value),
            editHeadTruk["ID"].toString(),
            editKarierTruk["ID"].toString(),
            jumlahTruckController.text,
            deskripsi.value,
            beratController.text,
            volumeController.text,
            dimensiController.text,
            jumlahKoliController.text,
            catatanTambahan.value,
            invitation,
            selectedTimezoneLokasi.value,
            selectedTimezoneDestinasi.value);
    var message = MessageFromUrlModel.fromJson(response['Message']);
    if (message.code == 200) {
    loadingAPI.value = false;
      CustomToast.show(
          context: Get.context, message: "Permintaan muat telah dibuat");
      Get.back(result: true);
    }
    loadingAPI.value = false;
  }

  void setTextEditingControllerNoPICPickUp() {
    for (int i = 0; i < int.parse(totalLokasi.value); i++)
      textEditingControllerNoPICPickUp[i] = TextEditingController();
    textEditingControllerNoPICPickUp.refresh();
  }

  void setTextEditingControllerNoPICDestinasi() {
    for (int i = 0; i < int.parse(totalDestinasi.value); i++)
      textEditingControllerNoPICDestinasi[i] = TextEditingController();
    textEditingControllerNoPICDestinasi.refresh();
  }

  @override
  void onClose() {
    FocusManager.instance.primaryFocus.unfocus();
    // FocusScope.of(Get.context).unfocus();
  }

  void setDiumumkanKepada() {
    String isiDesc2 = "LoadRequestInfoLabelResult".tr + " ";
    diumumkanKepadaTextSpan.clear();
    for (var index = 0; index < selectedJenisMitra.length; index++)
      diumumkanKepadaTextSpan
          .add(setTextSpan(selectedJenisMitra.values.toList()[index]));
    for (var index = 0;
        index <
            ((limitTampil - selectedJenisMitra.length > selectedGroup.length)
                ? selectedGroup.length
                : limitTampil - selectedJenisMitra.length);
        index++)
      diumumkanKepadaTextSpan.add(setTextSpan(selectedGroup[index]["Name"]));
    for (var index = 0;
        index <
            ((limitTampil - (selectedJenisMitra.length + selectedGroup.length) >
                    selectedTransporter.length)
                ? selectedTransporter.length
                : limitTampil -
                    (selectedJenisMitra.length + selectedGroup.length));
        index++)
      diumumkanKepadaTextSpan
          .add(setTextSpan(selectedTransporter[index]["name"]));
    for (var index = 0;
        index <
            ((limitTampil -
                        (selectedJenisMitra.length +
                            selectedGroup.length +
                            selectedTransporter.length) >
                    listInvited.length)
                ? listInvited.length
                : limitTampil -
                    (selectedJenisMitra.length +
                        selectedGroup.length +
                        selectedTransporter.length));
        index++) diumumkanKepadaTextSpan.add(setTextSpan(listInvited[index]));
    if (diumumkanKepadaTextSpan.length > limitTampil){
      diumumkanKepadaTextSpan.add(setTextSpan("... "));
      diumumkanKepadaTextSpan.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: GestureDetector(
        onTap: () {
          GetToPage.toNamed<ListUserController>(Routes.LIST_USER, arguments: [
            false,
            {
              "semua": selectedJenisMitra.value,
              "group": selectedGroup.value,
              "transporter": selectedTransporter.value,
              "invited": listInvited.value
            }
          ]);
        },
        child: Container(
            constraints: BoxConstraints(
                minWidth: GlobalVariable.ratioWidth(Get.context) * 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(GlobalVariable.ratioWidth(Get.context) * 5)),
                border: Border.all(
                    width: GlobalVariable.ratioWidth(Get.context) * 1,
                    color: Color(ListColor.color4))),
            padding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 6,
                vertical: GlobalVariable.ratioWidth(Get.context) * 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  (jumlahMitra.value - 5).toString(),
                  color: Color(ListColor.color4),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ],
            )),
      )));
    }
  }

  TextSpan setTextSpan(String title) {
    return TextSpan(
        text: (diumumkanKepadaTextSpan.length > 0 ? ", " : "") + title,
        style: TextStyle(
            color: Colors.black,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            fontWeight: FontWeight.w600));
  }
}
