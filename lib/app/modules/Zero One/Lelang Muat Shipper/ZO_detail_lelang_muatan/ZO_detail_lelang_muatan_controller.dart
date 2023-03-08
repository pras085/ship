import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_map_full_screen/ZO_map_full_screen_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/api_helper_zo.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:latlong/latlong.dart';

//
class ZoDetailLelangMuatanController extends GetxController {
  var slideIndex = 0.obs;
  var pageController;
  var title = "".obs;
  var type = "".obs;

  var mapController = MapController();
  var currentLocation = LatLng(0, 0).obs;
  // var listRoute = List<LatLng>().obs;
  // var location = Location();

  var mapControllerDestinasi = MapController();
  var currentLocationDestinasi = LatLng(0, 0).obs;

  var catatanTambahan = TextEditingController().obs;

  var listDataDetail = {}.obs;
  var imageUrl = "".obs;
  var truckJenis = "".obs;
  var carrierJenis = "".obs;
  var beratMaxDimensiVolume = "".obs;
  var listPickup = [].obs;
  var listDestination = [].obs;
  var listCatatan = [].obs;

  var hargaPenawaran = [].obs;
  var tmpMuat = [].obs;
  var tmpBongkar = [].obs;
  var paymentTerm = "".obs;

  var isTambahCatatan = false.obs;
  var isIconClose = false.obs;
  var status = "".obs;

  var isloading = false.obs;
  var idBid = "".obs;
  var isClickSimpan = false.obs;

  var ispage = 0.obs;

  List iconLocation = [
    'assets/pin1.svg',
    'assets/pin2_biru.svg',
    'assets/pin3_biru.svg',
    'assets/pin4_biru.svg',
    'assets/pin5_biru.svg'
  ];

  @override
  void onInit() {
    type.value = Get.arguments[2];
    idBid.value = Get.arguments[0];
    ispage.value = Get.arguments[1];
    slideIndex.value = Get.arguments[1];
    pageController = PageController(initialPage: ispage.value);

    updateTitle();
    getCurrentLocation();
    getDetailDataLelangMuatan();
    updateViewers();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    // currentLocation.value =
    //     LatLng(_locationData.latitude, _locationData.longitude);
    // mapController.onReady.then((value) {
    //   mapController.move(currentLocation.value, 17.7);
    // });

    // currentLocationDestinasi.value =
    //     LatLng(_locationData.latitude, _locationData.longitude);
    // mapControllerDestinasi.onReady.then((value) {
    //   mapControllerDestinasi.move(currentLocation.value, 17.7);
    // });

    // for (var i = 0; i < dropdownJumlahLokasi.value; i++) {
    //   currentLocationList[i] =
    //       LatLng(_locationData.latitude, _locationData.longitude);
    // }

    // print("KFAFHGDHCA ${currentLocation.value}");
  }

  Future<void> toMapFullScreenPickup() async {
    var result = await GetToPage.toNamed<ZoMapFullScreenController>(
        Routes.ZO_MAP_FULL_SCREEN,
        arguments: [
          List.from(listPickup.value),
          "LelangMuatTabAktifTabAktifLabelTitlePickupLocation".tr
        ],
        preventDuplicates: false);
  }

  Future<void> toMapFullScreenDestination() async {
    var result = await GetToPage.toNamed<ZoMapFullScreenController>(
        Routes.ZO_MAP_FULL_SCREEN,
        arguments: [
          List.from(listDestination.value),
          "LelangMuatBuatLelangBuatLelangLabelTitleLokasiDestinasi".tr
        ],
        preventDuplicates: false);
  }

  Future<void> salinData(String idLelang) async {
    var res = await GetToPage.toNamed<ZoBuatLelangMuatanController>(
        Routes.ZO_BUAT_LELANG_MUATAN,
        preventDuplicates: false,
        arguments: [idLelang]);

    if (res != null) {
      // if (res) {
      //   getListLelangMuatan(type);
      // }
    }
  }

  getDetailDataLelangMuatan() async {
    try {
      var resLoginAs = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getUserShiper(GlobalVariable.role);

      if (resLoginAs["Message"]["Code"] == 200) {
        var res = await ApiHelper(
                context: Get.context,
                isShowDialogLoading: false,
                isShowDialogError: false)
            .getDetailBid(idBid.value, resLoginAs["LoginAs"].toString(),
                GlobalVariable.role);

        if (res["Message"]["Code"] == 200) {
          listPickup.clear();
          listDestination.clear();
          listCatatan.clear();
          (res["Data"]["BidItem"] as List).forEach((element) {
            listDataDetail.value = element;
            hargaPenawaran.value =
                element["PriceInclude"].toString().split("*_*_*");
            tmpMuat.value =
                element["HandlingLoadingPrice"].toString().split("*_*_*");
            tmpBongkar.value =
                element["HandlingUnloadingPrice"].toString().split("*_*_*");
            paymentTerm.value =
                element["PaymentTerm"].toString().replaceAll("*_*_*", " - ");
            if (element["Status"] == 1) {
              status.value = "LelangMuatTabAktifTabAktifLabelTitleActive".tr;
            } else if (element["Status"] == 2) {
              status.value =
                  "LelangMuatBuatLelangBuatLelangLabelTitlePilihPemenang".tr;
            } else if (element["Status"] == 3) {
              status.value =
                  "LelangMuatBuatLelangBuatLelangLabelTitleSudahDitutup".tr;
            } else {
              status.value =
                  "LelangMuatTabAktifTabAktifLabelTitleCancelFilter".tr;
            }
            getSpecificTruck(
                element["HeadId"].toString(), element["CarrierId"].toString());
          });
          (res["Data"]["BidLocation"] as List).forEach((element) {
            if (element["Type"] == "0") {
              listPickup.add(element);
              currentLocation.value = LatLng(double.parse(element["Latitude"]),
                  double.parse(element["Longitude"]));
              mapController.onReady.then((value) {
                mapController.move(currentLocation.value, 4);
              });
            }
            if (element["Type"] == "1") {
              listDestination.add(element);
              currentLocationDestinasi.value = LatLng(
                  double.parse(element["Latitude"]),
                  double.parse(element["Longitude"]));
              mapControllerDestinasi.onReady.then((value) {
                mapControllerDestinasi.move(currentLocationDestinasi.value, 4);
              });
            }
            // print("SAKFLAKF $listDestination");
          });
          (res["Data"]["BidNote"] as List).forEach((element) {
            listCatatan.add(element);
          });
        } else {
          CustomToast.show(
              context: Get.context,
              sizeRounded: 6,
              message: res["Message"]["Text"].toString());
        }
      }
    } catch (e) {
      print("GAGAL $e");
    }
  }

  Future getSpecificTruck(String headID, String carrierID) async {
    var res = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getSpecificTruck(headID, carrierID);

    if (res["Message"]["Code"] == 200) {
      imageUrl.value = res["Data"]["TruckURL"];
      truckJenis.value = res["Data"]["Truck"];
      carrierJenis.value = res["Data"]["Truck"];
      beratMaxDimensiVolume.value = res["Data"]["Tonase"].toString() +
          " Ton/" +
          res["Data"]["Length"].toString() +
          " x " +
          res["Data"]["Width"].toString() +
          " x " +
          res["Data"]["Height"].toString() +
          "/" +
          res["Data"]["Volume"].toString();
    }
  }

  tambahCatatanAction(String note) async {
    print("SFAJKNG $note");
    try {
      var resLoginAs = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .getUserShiper(GlobalVariable.role);

      if (resLoginAs["Message"]["Code"] == 200) {
        var res = await ApiHelper(
                context: Get.context,
                isShowDialogLoading: false,
                isShowDialogError: false)
            .postInsertNote(idBid.value, resLoginAs["LoginAs"].toString(),
                GlobalVariable.role, note);
        if (res["Message"]["Code"] == 200) {
          // Get.back();
          isClickSimpan.value = false;
          isTambahCatatan.value = false;
          catatanTambahan.value.text = "";
          CustomToast.show(
              context: Get.context,
              sizeRounded: 6,
              message:
                  "LelangMuatBuatLelangBuatLelangLabelTitleBerhasilMenambahCatatan"
                      .tr);
          getDetailDataLelangMuatan();
        } else {
          CustomToast.show(
              context: Get.context,
              sizeRounded: 6,
              message: res["Message"]["Text"].toString());
        }
      }
    } catch (e) {
      CustomToast.show(
          context: Get.context, sizeRounded: 6, message: e.toString());
      print("GAGAL $e");
    }
  }

  Future showDialogLoading() async {
    // _isShowingDialogLoading = true;
    return showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                  // key: _keyDialog,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText('GlobalLabelDialogLoading'.tr,
                            color: Colors.blueAccent)
                      ]),
                    )
                  ]));
        });
  }

  updateViewers() async {
    var resLoginAs = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getUserShiper(GlobalVariable.role);

    if (resLoginAs["Message"]["Code"] == 200) {
      var res = await ApiHelper(
              context: Get.context,
              isShowDialogLoading: false,
              isShowDialogError: false)
          .postUpdateViewers(
        idBid.value,
        resLoginAs["LoginAs"].toString(),
        GlobalVariable.role,
      );
    }
  }

  String converttoIDR(int number) {
    NumberFormat currFormater =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return currFormater.format(number);
  }

  void updateTitle() {
    switch (slideIndex.value) {
      case 0:
        {
          title.value = "LelangMuatBuatLelangBuatLelangLabelTitleBidData".tr;
          break;
        }
      case 1:
        {
          title.value =
              "LelangMuatBuatLelangBuatLelangLabelTitleDataKebutuhan".tr;
          break;
        }
      case 2:
        {
          title.value = "LelangMuatBuatLelangBuatLelangLabelTitleCargoData".tr;
          break;
        }
      case 3:
        {
          title.value =
              "LelangMuatBuatLelangBuatLelangLabelTitleInformasiPickup".tr;
          break;
        }
      case 4:
        {
          title.value =
              "LelangMuatBuatLelangBuatLelangLabelTitleInformasiDestinasi".tr;
          break;
        }
      case 5:
        {
          title.value =
              "LelangMuatBuatLelangBuatLelangLabelTitleDataPenawaran".tr;
          break;
        }
    }
  }
}
