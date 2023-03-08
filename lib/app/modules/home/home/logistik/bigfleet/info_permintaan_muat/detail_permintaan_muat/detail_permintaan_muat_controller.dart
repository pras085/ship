import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/api/get_detail_info_permintaan_muat.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/info_permintaan_muat/api_permintaan_muat.dart';
import 'package:muatmuat/app/modules/list_user/list_user_controller.dart';
import 'package:muatmuat/app/network/api_helper.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/shared_preferences_helper.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class DetailPermintaanMuatController extends GetxController {
  var loading = true.obs;
  var onUpdate = false.obs;
  var slideIndex = 0.obs;
  var pageController = PageController();
  var title = "".obs;
  var dataMuat = Map().obs;
  var editable = false.obs;
  // var jumlahTruckController = TextEditingController();
  // var deskripsiTambahanController = TextEditingController();
  // var deskripsiController = TextEditingController();
  // var beratController = TextEditingController();
  // var volumeController = TextEditingController();
  // var panjangController = TextEditingController();
  // var lebarController = TextEditingController();
  // var tinggiController = TextEditingController();
  var catatanTambahanController = TextEditingController();
  var listStatus = [
    "InfoPermintaanMuatLabelAktif".tr,
    "InfoPermintaanMuatNonAktif".tr,
    "InfoPermintaanMuatLabelBatal".tr
  ];
  var statusColor = Color(ListColor.color4).obs;

  var muatID = "";
  var change = false;

  //First page
  var tanggalDibuat = "".obs;
  var waktuLokasi = "".obs;
  var lokasi = [].obs;
  var deskripsiLokasi = [].obs;
  var namaPICLokasi = [].obs;
  var nomorPICLokasi = [].obs;
  var latlngLokasi = [].obs;
  var mapLokasiController = MapController();
  var loadMapLokasi = false.obs;

  //Second page
  var waktuDestinasi = "".obs;
  var destinasi = [].obs;
  var deskripsiDestinasi = [].obs;
  var namaPICDestinasi = [].obs;
  var nomorPICDestinasi = [].obs;
  var latlngDestinasi = [].obs;
  var mapDestinasiController = MapController();
  var loadMapDestinasi = false.obs;

  //Third page
  // var editTruk = false.obs;
  var jenisTruk = "Tronton".obs;
  var karierTruk = "Wingbox".obs;
  var linkImage = "".obs;
  // var editDeskripsiTambahan = false.obs;

  //Fourth page
  // var editDeskripsi = false.obs;
  // var editBerat = false.obs;
  // var editVolume = false.obs;
  var formKey = GlobalKey<FormState>();
  var limitCatatan = 6;
  var editCatatanTambahan = false.obs;
  var catatanTambahan = [].obs;
  var editStatusPermintaanMuat = false.obs;
  var selectedJenisMitra = {}.obs;
  var selectedGroup = [].obs;
  var selectedTransporter = [].obs;
  var listInvited = {}.obs;
  var jumlahMitra = 9.obs;
  var status = "0".obs;
  var limitTampil = 7;

  var diumumkanKepadaTextSpan = [].obs;

  @override
  void onInit() async {
    updateTitle();
    // Timer(Duration(seconds: 3), () async {
    //   loadList.value = false;
    // });
    // selectedJenisMitra.value = {"0": "Semua Transporter"};
    // selectedGroup.value = [
    //   {"ID": "23", "Name": "Group Surabaya"},
    //   {"ID": "48", "Name": "Group Jakarta"}
    // ];
    // selectedTransporter.value = [
    //   {"id": "1", "name": "PT. Jaya Abadi"},
    //   {"id": "2", "name": "PT. Sumber Makmur"},
    //   {"id": "3", "name": "PT. Sentosa"},
    //   {"id": "4", "name": "PT. Shipper Sejahtera"},
    //   {"id": "5", "name": "PT. Sinar Terang"},
    //   {"id": "6", "name": "PT. Truk Jaya"}
    // ];
    // catatanTambahan
    //     .add("Mohon ketika pengangkutan barang jangan sampai terbalik");
    muatID = Get.arguments[0];
    editable.value = Get.arguments[1];
    await getDetailPermintaanMuat();
    await updateColor();
    await getTruckImage();
    updateData();

    log('::: ${latlngDestinasi.value}');
    loading.value = false;
  }

  Future<void> getDetailPermintaanMuat() async {
    // var response = await GetDetailInfoPermintaanMuat.getDetail("1",
    //     isShowDialogLoading: false);
    var response = await GetDetailInfoPermintaanMuat.getDetail(muatID,
        isShowDialogLoading: false);
    if (response != null) dataMuat.value = response.data;
  }

  void updateData() async {
    lokasi.clear();
    latlngLokasi.clear();
    namaPICLokasi.clear();
    nomorPICLokasi.clear();

    destinasi.clear();
    latlngDestinasi.clear();
    namaPICDestinasi.clear();
    nomorPICDestinasi.clear();

    tanggalDibuat.value = dataMuat["tanggal_dibuat"];
    jenisTruk.value = dataMuat["jenis_truck"];
    karierTruk.value = dataMuat["jenis_carrier"];

    List daftarPickup = dataMuat["AlamatPickup"];
    daftarPickup.forEach((element) {
      latlngLokasi.add(LatLng(element["Lat"], element["Lng"]));
      lokasi.add(element["Alamat"]);
      deskripsiLokasi.add(element["AlamatDetail"]);
      namaPICLokasi.add(element["nama_pic"]);
      nomorPICLokasi.add(element["no_pic"]);
    });

    List daftarBongkar = dataMuat["AlamatBongkar"];
    daftarBongkar.forEach((element) {
      latlngDestinasi.add(LatLng(element["Lat"], element["Lng"]));
      destinasi.add(element["Alamat"]);
      deskripsiDestinasi.add(element["AlamatDetail"]);
      namaPICDestinasi.add(element["nama_pic"]);
      nomorPICDestinasi.add(element["no_pic"]);
    });

    await mapLokasiController.onReady;
    var markerBounds = LatLngBounds();
    latlngLokasi.forEach((element) {
      markerBounds.extend(element);
    });
    if (markerBounds.isValid) {
      mapLokasiController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(40)));
    }

    await mapDestinasiController.onReady;
    markerBounds = LatLngBounds();
    latlngDestinasi.forEach((element) {
      markerBounds.extend(element);
    });
    if (markerBounds.isValid) {
      mapDestinasiController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(40)));
    }
    catatanTambahan.clear();
    (dataMuat["AllCatatan"] as List).forEach((element) {
      catatanTambahan.add(element);
    });
    status.value = dataMuat["status"].toString();

    // selectedJenisMitra.value = dataMuat["invitation"];
    // selectedGroup.value = dataMuat["invitation"];
    selectedJenisMitra.clear();
    selectedGroup.clear();
    selectedTransporter.clear();
    (dataMuat["invitation"] as List).forEach((element) {
      selectedTransporter.add(
          {"id": element["TransporterID"].toString(), "name": element["name"]});
    });
    setDiumumkanKepada();
    // selectedTransporter.value = dataMuat["invitation"];
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

  void changeStatus() {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "Ubah Status",
      message:
          "Apakah anda yakin ingin mengubah status info permintaan muat ini?"
              .tr,
      context: Get.context,
      labelButtonPriority1: "Tidak",
      labelButtonPriority2: "Ya",
      onTapPriority1: () {
        Get.back();
      },
      onTapPriority2: () async {
        editStatusPermintaanMuat.value = true;
      },
    );
  }

  void updatePermintaanMuat() async {
    onUpdate.value = true;
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var response = await ApiPermintaanMuat(
            context: Get.context, isShowDialogLoading: false)
        .updatePermintaanMuat(
            shipperID, muatID, [catatanTambahanController.text], status.value);
    if (response["Code"] == 200) {
      dataMuat["status_str"] = status.value;
      editStatusPermintaanMuat.value = false;
      catatanTambahan.add(catatanTambahanController.text);
      catatanTambahanController.text = "";
      limitCatatan++;
      editCatatanTambahan.value = false;
      change = true;
      CustomToast.show(
          context: Get.context, message: "Permintaan muat berhasil diubah");
    }
    onUpdate.value = false;
  }

  void refreshMap(int index) async {
    var markerBounds = LatLngBounds();
    switch (index) {
      case 0:
        {
          loadMapLokasi.value = true;
          latlngLokasi.forEach((element) {
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
          latlngDestinasi.forEach((element) {
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

  @override
  void onReady() {}

  @override
  void onClose() {}

  void onSave() async {}

  Future updateColor() {
    switch (dataMuat["status"]) {
      case 0:
        statusColor.value = Color(ListColor.colorGreen);
        break;
      case 1:
        statusColor.value = Color(ListColor.colorYellow3);
        break;
      case 2:
        statusColor.value = Color(ListColor.colorRed);
        break;
    }
  }

  Future getTruckImage() async {
    var result =
        await ApiHelper(context: Get.context, isShowDialogLoading: false)
            .getSpecificTruck(dataMuat["dbm_head_truckID"].toString(),
                dataMuat["dbm_carrier_truckID"].toString());
    if (result["Data"].isNotEmpty) linkImage.value = result["Data"]["TruckURL"];
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
    if (diumumkanKepadaTextSpan.length > limitTampil) {
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
                borderRadius: BorderRadius.all(Radius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 5)),
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
        text: title,
        style: TextStyle(
            color: Colors.black,
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
            fontWeight: FontWeight.w600));
  }
}
