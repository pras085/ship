import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;
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
import 'package:muatmuat/app/modules/ARK/manajemen_user/create_manajemen_user/create_manajemen_user_controller.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/edit_notification_harga/edit_notification_harga_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/manajemen_user_bagi_peran/manajemen_user_bagi_peran_controller.dart';
import 'package:muatmuat/app/modules/ARK/manajemen_user/search_manajemen_user/search_manajemen_user_controller.dart';
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

class CreateNotificationHargaController extends GetxController
    with SingleGetTickerProviderMixin {
  var validasiSimpan = false.obs;
  var isLoading = true.obs;
  var save = true;
  var tutupBuat = false.obs;
  var tutupDetail = false.obs;
  var idtruk = "0";
  var idcarrier = "0";

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
    print(Get.arguments);
    idLokasiPickup = int.parse(Get.arguments[0].toString());
    lokasiPickupController.value.text = Get.arguments[1];
    idLokasiDestinasi = int.parse(Get.arguments[2].toString());
    lokasiDestinasiController.value.text = Get.arguments[3];
    await getTransporterList();
    await getNotifikasi();

    isLoading.value = false;
  }

  @override
  void onReady() {}
  @override
  void onClose() {}

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

  //Menampilkan Box Kuning, ketika pertama kali menggunakan aplikasi
  Widget blueBox() {
    return Container(
        decoration: BoxDecoration(
          color: Color(ListColor.colorBlueBox),
          borderRadius:
              BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 5),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 5,
          //     spreadRadius: 2,
          //     offset: Offset(0, 5),
          //   ),
          // ],
        ),
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 14,
            GlobalVariable.ratioWidth(Get.context) * 6,
            GlobalVariable.ratioWidth(Get.context) * 14,
            GlobalVariable.ratioWidth(Get.context) * 6),
        child: Stack(
          children: [
            Column(children: [
              Container(
                child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text:
                            'CariHargaTransportIndexMasukkanRuteJenisTrukDanCarrier'
                                    .tr +
                                ' ', //'Masukkan Rute'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "AvenirNext",
                          height: 1.3,
                        ),
                        children: [
                          TextSpan(
                            text: ' ' +
                                'CariHargaTransportIndexPenawaranBaru'
                                    .tr, //' Penawaran Baru',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w700,
                              fontFamily: "AvenirNext",
                              height: 1.3,
                            ),
                          ),
                          TextSpan(
                            text: ' ' +
                                'CariHargaTransportIndexAtau'.tr, //' atau',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "AvenirNext",
                              height: 1.3,
                            ),
                          ),
                          TextSpan(
                            text: ' ' +
                                'CariHargaTransportIndexPerubahanHarga'
                                    .tr, //' Perubahan Harga',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w700,
                              fontFamily: "AvenirNext",
                              height: 1.3,
                            ),
                          ),
                          TextSpan(
                            text: ' ' +
                                'CariHargaTransportIndexDariTransporter'
                                    .tr, //' dari Transporter',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "AvenirNext",
                              height: 1.3,
                            ),
                          ),
                        ])),
              ),
              SizedBox(
                height: GlobalVariable.ratioFontSize(Get.context) * 14,
              ),
              Container(
                  child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text:
                              'CariHargaTransportIndexPilihJugaJenisNotifikasi'
                                      .tr +
                                  ' ', //'Pilih juga jenis'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: "AvenirNext",
                            height: 1.3,
                          ),
                          children: [])))
            ]),
          ],
        ));
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

  Future getNotifikasi() async {
    var shipperID = await SharedPreferencesHelper.getUserShipperID();
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getNotifikasi(shipperID);

    if (result != null && result['Message']['Code'].toString() == '200') {
      var data = result["Data"];
      dataNotifikasi.clear();
      for (int i = 0; i < data.length; i++) {
        dataNotifikasi.add({
          "id": data[i]['ID'] ?? "",
          "idPickup": data[i]['pickup'] ?? 0,
          "namaPickup": data[i]['pickup_name'] ?? "",
          "idDestinasi": data[i]['destinasi'] ?? 0,
          "namaDestinasi": data[i]['destinasi_name'] ?? "",
          "idTruk": data[i]['head_id'] ?? 0,
          "namaTruk": data[i]['head_name'] ?? "",
          "idCarrier": data[i]['carrier_id'] ?? 0,
          "namaCarrier": data[i]['carrier_name'] ?? "",
          "namaTransporter": data[i]['transporter_name'] ?? "",
          "notifikasi": data[i]['notification_type'] ?? "",
        });
      }
    }
  }

  Widget expandedWidget() {
    return Container(
        padding: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 16,
          right: GlobalVariable.ratioWidth(Get.context) * 16,
          top: GlobalVariable.ratioWidth(Get.context) * 16,
          bottom: GlobalVariable.ratioWidth(Get.context) * 14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
            topRight:
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
            bottomLeft:
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
            bottomRight:
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
          ),
          // color: Color(ListColor.colorHeaderListTender),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        margin: EdgeInsets.only(
          bottom: GlobalVariable.ratioWidth(Get.context) * 24,
        ),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  tutupDetail.value = !tutupDetail.value;
                  dataNotifikasi.refresh();
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          topRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          bottomLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          bottomRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                        ),
                        color: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                child: CustomText(
                          'CariHargaTransportIndexDaftarNotifikasi'
                              .tr, // Daftar Notifikasi
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ))),
                        SvgPicture.asset(
                          (!tutupDetail.value
                              ? GlobalVariable.imagePath + 'expand.svg'
                              : GlobalVariable.imagePath + 'unexpand.svg'),
                          width: GlobalVariable.ratioWidth(Get.context) * 18,
                          height: GlobalVariable.ratioWidth(Get.context) * 18,
                        ),
                      ],
                    ))),
            !tutupDetail.value
                ? SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16)
                : SizedBox(),
            !tutupDetail.value ? lineDividerWidget() : SizedBox(),
            !tutupDetail.value
                ? SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12)
                : SizedBox(),
            !tutupDetail.value
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                          bottomRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 10),
                        )),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dataNotifikasi.length,
                        itemBuilder: (content, index) {
                          return Column(children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          right: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              2),
                                      child: CustomText(
                                          (index + 1).toString() + ".",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(ListColor.colorGrey3))),
                                  Expanded(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Container(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              CustomText(
                                                  "CariHargaTransportIndexPickupDestinasi"
                                                      .tr, //Pickup - Destinasi
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(
                                                      ListColor.colorGrey3)),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8),
                                              CustomText(
                                                  dataNotifikasi[index]
                                                          ['namaPickup'] +
                                                      " - " +
                                                      dataNotifikasi[index]
                                                          ['namaDestinasi'],
                                                  fontSize: 14,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  wrapSpace: true,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24),
                                              CustomText(
                                                  "CariHargaTransportIndexJenisTrukCarrier"
                                                      .tr, //Jenis Truk - Carrier
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(
                                                      ListColor.colorGrey3)),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8),
                                              CustomText(
                                                  dataNotifikasi[index]
                                                          ['namaTruk'] +
                                                      " - " +
                                                      dataNotifikasi[index][
                                                          'namaCarrier'], //Jenis Truk
                                                  fontSize: 14,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  wrapSpace: true,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24),
                                              CustomText(
                                                  "CariHargaTransportIndexTransporter"
                                                      .tr, //Transporter
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(
                                                      ListColor.colorGrey3)),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8),
                                              CustomText(
                                                  dataNotifikasi[index][
                                                      'namaTransporter'], //Jenis Truk
                                                  fontSize: 14,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  wrapSpace: true,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24),
                                              CustomText(
                                                  "CariHargaTransportIndexJenisNotifikasi"
                                                      .tr, //Jenis Notifikasi
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(
                                                      ListColor.colorGrey3)),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          8),
                                              CustomText(
                                                  dataNotifikasi[index]
                                                      ['notifikasi'],
                                                  fontSize: 14,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  wrapSpace: true,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          24),
                                            ])),
                                      ])),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomText(''),
                                  MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20))),
                                    color: Color(ListColor.colorRed),
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();
                                      hapus(index);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    12),
                                        child: CustomText(
                                          "CariHargaTransportIndexHapus"
                                              .tr, // Hapus
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        )),
                                  ),
                                  SizedBox(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    20))),
                                    color: Color(ListColor.colorBlue),
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();
                                      ubah(index);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    12),
                                        child: CustomText(
                                          "CariHargaTransportIndexUbah"
                                              .tr, // Ubah
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        )),
                                  )
                                ]),
                            index != dataNotifikasi.length - 1
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            13),
                                    child: lineDividerWidget())
                                : SizedBox()
                          ]);
                        }))
                : SizedBox(),
          ],
        ));
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
      validasiSimpan.value = true;
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
        .saveNotifikasi(
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
      CustomToast.show(
          marginBottom: GlobalVariable.ratioWidth(Get.context) * 50,
          context: Get.context,
          message: "CariHargaTransportIndexBerhasilMenyimpan"
              .tr); //Berhasil menyimpan notifikasi
      isLoading.value = true;
      tutupBuat.value = true;
      await getNotifikasi();
      reset();
      isLoading.value = false;
    }
  }

  void reset() {
    idLokasiPickup = 0;
    lokasiPickupController.value.clear();
    idLokasiDestinasi = 0;
    lokasiDestinasiController.value.clear();
    idtruk = "0";
    dataTrukController.value.clear();
    idcarrier = "0";
    dataCarrierController.value.clear();
    transporterController.value.clear();
    notifikasi.value = 0;
    cekData();
  }

  void ubah(int index) async {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "CariHargaTransportIndexKonfirmasiUbah".tr, //Konfirmasi Ubah
        message: "CariHargaTransportIndexPertanyaanKonfirmasiUbah"
            .tr //Apakah anda yakin ingin mengubah
        ,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () async {},
        onTapPriority2: () async {
          var result = await GetToPage.toNamed<EditNotificationHargaController>(
              Routes.EDIT_NOTIFICATION_HARGA,
              arguments: [dataNotifikasi[index]]);
          if (result != null) {
            // print(result);
            isLoading.value = true;
            await getNotifikasi();
            isLoading.value = false;
          }
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }

  void hapus(int index) {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        title: "CariHargaTransportIndexKonfirmasiHapus".tr, //Konfirmasi Hapus
        message: "CariHargaTransportIndexPertanyaanKonfirmasiHapus"
            .tr //Apakah anda yakin ingin menghapus
        ,
        labelButtonPriority1: GlobalAlertDialog.noLabelButton,
        onTapPriority1: () async {},
        onTapPriority2: () async {
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
              .hapusNotifikasi(
                  shipperID, dataNotifikasi[index]['id'].toString());

          if (result != null && result['Message']['Code'].toString() == '200') {
            Get.back();
            CustomToast.show(
                marginBottom: GlobalVariable.ratioWidth(Get.context) * 0,
                context: Get.context,
                message: "CariHargaTransportIndexBerhasilMenghapusNotifikasi"
                    .tr); //Berhasil menghapus notifikasi
            isLoading.value = true;
            await getNotifikasi();
            reset();
            isLoading.value = false;
          }
        },
        labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
  }
}
