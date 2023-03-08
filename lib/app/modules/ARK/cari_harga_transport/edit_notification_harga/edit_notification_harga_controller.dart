import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/contact_partner_info_pra_tender_transporter_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/filter_custom_controller_ark.dart';
import 'package:muatmuat/app/core/enum/type_in_filter.enum.dart';
import 'package:muatmuat/app/core/function/api/get_contact_transporter_by_shipper.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/core/function/list_data_design_function.dart';
import 'package:muatmuat/app/core/models/checkbox_filter_model.dart';
import 'package:muatmuat/app/core/models/contact_transporter_by_shipper_response_model.dart';
import 'package:muatmuat/app/core/models/data_list_sorting_model.dart';
import 'package:muatmuat/app/core/controllers/sorting_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_head_carrier/list_head_carrier_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_transporter_notif/list_transporter_notif_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/satuan_filter_model_ark.dart';
import 'package:muatmuat/app/core/models/widget_filter_model.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_city_location/select_city_location_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_diumumkan_kepada/select_diumumkan_kepada_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_head_carrier/select_head_carrier_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class EditNotificationHargaController extends GetxController
    with SingleGetTickerProviderMixin {
  var validasiSimpan = false.obs;
  var isLoading = true.obs;
  var save = true;
  var tutupBuat = false.obs;
  var idNotifikasi = 0;
  var idtruk = "0";
  var idcarrier = "0";
  var dataSebelumnya = '';

  var dataNotifikasi = [].obs;
  var idLokasiPickup = 0;
  var idLokasiDestinasi = 0;
  var idTransporter = 0;
  var dataTransporter = [].obs;

  var dataTrukController = TextEditingController().obs;
  var dataCarrierController = TextEditingController().obs;
  var lokasiPickupController = TextEditingController().obs;
  var lokasiDestinasiController = TextEditingController().obs;
  var transporterController = TextEditingController().obs;

  var notifikasi = 0.obs;
  var arrNotifikasi = [
    "",
    "CariHargaTransportIndexSemua",
    "CariHargaTransportIndexEmail",
    "CariHargaTransportIndexWhatsapp",
    "CariHargaTransportIndexSistem",
  ];

  var arrNotifikasiIndo = [
    "",
    "Semua",
    "Email",
    "Whatsapp",
    "Sistem",
  ];

  var errorNotifikasi = "".obs;

  @override
  void onInit() async {
    await getTransporterList();
    await getData(Get.arguments[0]);

    isLoading.value = false;
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

  void getData(data) async {
    print(data);
    idNotifikasi = int.parse(data['id'].toString());
    idLokasiPickup = int.parse(data['idPickup'].toString());
    lokasiPickupController.value.text = data['namaPickup'];
    idLokasiDestinasi = int.parse(data['idDestinasi'].toString());
    lokasiDestinasiController.value.text = data['namaDestinasi'];
    idtruk = data['idTruk'].toString();
    dataTrukController.value.text = data['namaTruk'];
    idcarrier = data['idCarrier'].toString();
    dataCarrierController.value.text = data['namaCarrier'];
    transporterController.value.text = data['namaTransporter'];
    notifikasi.value = arrNotifikasiIndo
        .indexWhere((element) => element == data['notifikasi']);

    lokasiPickupController.refresh();
    lokasiDestinasiController.refresh();
    dataTrukController.refresh();
    dataCarrierController.refresh();
    transporterController.refresh();
    onSetData('SET');
    cekData();
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 1,
        color: Color(ListColor.colorLightGrey10),
        height: 0,
      ),
    );
  }

  void pilihLokasi(String jenis) async {
    var hintText = '';
    if (jenis == 'PICKUP') {
      hintText = 'CariHargaTransportIndexCariLokasiPickup'.tr;
    } else {
      hintText = 'CariHargaTransportIndexCariLokasiDestinasi'.tr;
    }
    var data = await GetToPage.toNamed<SelectCityLocationController>(
        Routes.SELECT_CITY_LOCATION,
        arguments: [hintText]);

    if (data != null) {
      if (jenis == 'PICKUP') {
        idLokasiPickup = data[0];
        lokasiPickupController.value.text = data[1];
        print(lokasiPickupController.value.text);
      } else if (jenis == 'DESTINASI') {
        idLokasiDestinasi = data[0];
        lokasiDestinasiController.value.text = data[1];
        print(lokasiDestinasiController.value.text);
      }

      lokasiPickupController.refresh();
      lokasiDestinasiController.refresh();

      cekData();
    }
  }

  void getTruk() async {
    print(idtruk);
    print(idcarrier);
    var result = await GetToPage.toNamed<ListHeadCarrierController>(
        Routes.LIST_HEAD_CARRIER_TRUCK,
        arguments: ['0', idtruk]);
    if (result != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        idtruk = result['ID'].toString();
        dataTrukController.value.text = result['Description'];
        idcarrier = "0";
        dataCarrierController.value.clear();

        dataTrukController.refresh();

        cekData();
      });
    }
  }

  void getCarrier() async {
    print(idtruk);
    print(idcarrier);
    var result = await GetToPage.toNamed<ListHeadCarrierController>(
        Routes.LIST_HEAD_CARRIER_TRUCK,
        arguments: ['1', idcarrier, idtruk]);
    if (result != null) {
      print(result);
      Future.delayed(const Duration(milliseconds: 100), () {
        idcarrier = result['ID'].toString();
        dataCarrierController.value.text = result['Description'];

        dataCarrierController.refresh();
        cekData();
      });
    }
  }

  Future getTransporterList() async {
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getTransporterList();

    if (result != null && result['Message']['Code'].toString() == '200') {
      var data = result["Data"];
      dataTransporter.clear();
      dataTransporter.add({
        "id": "Semua",
        "nama": "Semua",
      });
      for (int i = 0; i < data.length; i++) {
        dataTransporter.add({
          "id": data[i]['TransporterID'],
          "nama": data[i]['Name'],
        });
      }
    } else {}
  }

  void selectTransporter() async {
    if (dataTransporter.value.length <= 0) {
      await getTransporterList();
    }
    var result = await GetToPage.toNamed<ListTransporterNotifController>(
        Routes.LIST_TRANSPORTER_NOTIF,
        arguments: [
          dataTransporter.value,
          "CariHargaTransportIndexCariTransporter".tr
        ]);
    if (result != null) {
      transporterController.value.text = result['nama'];

      transporterController.refresh();

      cekData();
    }
  }

  void cekData() {
    print(idLokasiPickup);
    print(idLokasiDestinasi);
    print(idtruk);
    print(idcarrier);
    print(transporterController.value.text);
    print(notifikasi.value);
    if (idLokasiPickup != 0 &&
        idLokasiDestinasi != 0 &&
        idtruk != 0 &&
        idcarrier != 0 &&
        transporterController.value.text != "" &&
        notifikasi.value != 0) {
      onSetData('CEKDATA');
      print('BISA SIMPAN');
    } else {
      validasiSimpan.value = false;
      print('TIDAK BISA SIMPAN');
    }
  }

  void simpan() async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        });
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .updateNotifikasi(
            idNotifikasi.toString(),
            shipperID,
            idLokasiPickup.toString(),
            lokasiPickupController.value.text,
            idLokasiDestinasi.toString(),
            lokasiDestinasiController.value.text,
            idtruk.toString(),
            dataTrukController.value.text,
            idcarrier.toString(),
            dataCarrierController.value.text,
            transporterController.value.text,
            arrNotifikasiIndo[notifikasi.value]);

    if (result != null && result['Message']['Code'].toString() == '200') {
      Get.back();
      Get.back(result: true);
      CustomToast.show(
          marginBottom: GlobalVariable.ratioWidth(Get.context) * 50,
          context: Get.context,
          message: "CariHargaTransportIndexBerhasilMengubahNotifikasi"
              .tr); //Berhasil mengubah notifikasi yang sudah pernah dibuat
    }
  }

  void onSetData(jenis) {
    if (jenis == 'SET') {
      dataSebelumnya = (idLokasiPickup.toString() +
          idLokasiDestinasi.toString() +
          idtruk.toString() +
          idcarrier.toString() +
          transporterController.value.text +
          notifikasi.value.toString());
    } else if (jenis == 'CEKDATA') {
      var dataSekarang = (idLokasiPickup.toString() +
          idLokasiDestinasi.toString() +
          idtruk.toString() +
          idcarrier.toString() +
          transporterController.value.text +
          notifikasi.value.toString());
      if (dataSebelumnya == dataSekarang) {
        validasiSimpan.value = false;
      } else {
        validasiSimpan.value = true;
      }
    } else if (jenis == 'COMPARE') {
      var dataSekarang = (idLokasiPickup.toString() +
          idLokasiDestinasi.toString() +
          idtruk.toString() +
          idcarrier.toString() +
          transporterController.value.text +
          notifikasi.value.toString());
      if (dataSebelumnya != dataSekarang) {
        print('POPUP KELUAR');
        GlobalAlertDialog.showAlertDialogCustom(
            context: Get.context,
            title: "ProsesTenderCreateLabelInfoKonfirmasiPembatalan"
                .tr, //Konfirmasi Pembatalan
            message: "ProsesTenderCreateLabelInfoApakahAndaYakinInginKembali"
                    .tr +
                "\n" +
                "ProsesTenderCreateLabelInfoDataTidakDisimpan"
                    .tr, //Apakah anda yakin ingin kembali? Data yang telah diisi tidak akan disimpan
            labelButtonPriority1: GlobalAlertDialog.noLabelButton,
            onTapPriority1: () {},
            onTapPriority2: () async {
              Get.back();
            },
            labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
      } else {
        Get.back();
      }
    }
  }
}
