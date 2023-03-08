import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:latlong/latlong.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/routes/app_pages.dart';

class LokasiBFTMController extends GetxController {
  var title = "".obs;
  var selectLokasi = Map().obs;
  var totalLokasi = 3;
  var mapController = MapController();

  final String namaKey = "Nama";
  final String lokasiKey = "Lokasi";
  final String cityKey = "City";
  final String districtKey = "District";

  @override
  void onInit() {
    print(Get.arguments);
    title.value = Get.arguments[0];
    selectLokasi.value = Get.arguments[1];
    totalLokasi = Get.arguments[2];
    // var lokasiA = {
    //   namaKey: "Jl. Kalianyar No. 27",
    //   "Lokasi": LatLng(-7.123123123, 112.7669188)
    // };
    // var lokasiB = {
    //   namaKey: "Jl. Sembako No. 27",
    //   "Lokasi": LatLng(-7.293123123, 112.7009188)
    // };
    // var lokasi = {"0": lokasiA, "2": lokasiB};
    // selectLokasi.value = lokasi;
    updateMap();

    if(Get.arguments[4] != null){
      WidgetsBinding.instance.addPostFrameCallback((_) { 
         onClickAddress(0);
      });
     
      }
  }

  void clearLokasi(int index) {
    GlobalAlertDialog.showAlertDialogCustom(
      title: "Hapus Lokasi".tr,
      message: "Apakah anda yakin untuk menghapus lokasi ini?",
      context: Get.context,
      labelButtonPriority1: "Hapus",
      onTapPriority1: () {
        selectLokasi.removeWhere((key, value) => key == index.toString());
        updateMap();
      },
      labelButtonPriority2: "Cancel".tr,
    );
  }

  void updateMap() async {
    await mapController.onReady;
    var markerBounds = LatLngBounds();
    selectLokasi.values.forEach((element) {
      print(element["Lokasi"]);
      markerBounds.extend(element["Lokasi"]);
    });
    if (markerBounds.isValid) {
      print('kono diavolo da');
      mapController.fitBounds(markerBounds,
          options: FitBoundsOptions(padding: EdgeInsets.all(40)));
    }
  }

  @override
  void onReady() {
  }

  @override
  void onClose() {
  }

  void onClickAddress(int index) async {
    String addressName = selectLokasi[index.toString()] != null
        ? selectLokasi[index.toString()][namaKey] ?? ""
        : "";
    LatLng latLng = selectLokasi[index.toString()] != null
        ? selectLokasi[index.toString()][lokasiKey]
        : null;
    var result = Get.arguments[5] == 'map' ? 
      await Get.toNamed(Routes.SEARCH_LOCATION_BF_TM,
        arguments: [
          (index + 1).toString(),
          totalLokasi,
          addressName,
          latLng,
          'map'
        ]) : 
       await Get.toNamed(Routes.SEARCH_LOCATION_BF_TM,
        arguments: [
          (index + 1).toString(),
          totalLokasi,
          addressName,
          latLng,
          'normal'
        ]);
    if (result != null) {
      print('refoooo');
      print(result.toString()+ 'refooo');
    if(result == 'back'){
      Get.back();
    }
    else {
      print('diavolo');
      if (selectLokasi[index.toString()] != null)
        selectLokasi.remove(index.toString());
       print('diavolo 1');
      selectLokasi[index.toString()] = _setMapLokasi(result[0] as String,
          result[1] as LatLng, result[2] as String, result[3] as String);
           print('diavolo 2');
      updateMap();
       print('diavolo 4');
      if(result[4] == true){
       print('diavolo 5');
       print('o '+result[5] + 'diavolo');
      print('o '+selectLokasi.value.toString() + ' diavolo');
      Get.back(result: [selectLokasi.value, result[5]]);
    }
    }
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
}
