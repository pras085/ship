import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/controllers/contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_ark_contact_partner_modal_sheet_bottom_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_pemenang/list_halaman_peserta_detail_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_pilih_pemenang/list_halaman_peserta_pilih_pemenang_controller.dart';
import 'package:muatmuat/app/modules/home/home/logistik/bigfleet/transporter/transporter/transporter_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListHalamanPesertaDetailPemenangController extends GetxController {
  var validasiSimpan = false;
  var dataRuteTender = [].obs;
  var satuanTender = 0;
  var satuanVolume = '';
  var idTender = '';
  var noTender = '';
  var judulTender = '';
  var muatan = '';
  var totalKebutuhan = "".obs;
  var sisaKebutuhan = "".obs;
  var tipeListPeserta = "";
  var tanggalPemenang = "";
  var ambilLocal = false;
  var firstTime = true;
  var firstSet = true;
  var errorPemenangTerisiSemua = "".obs;
  var isLoadingData = false.obs;
  CustomARKContactPartnerModalSheetBottomController
      _contactModalBottomSheetController;

        var cekUbahPemenang = false;

  @override
  void onInit() async {
     cekUbahPemenang = await SharedPreferencesHelper.getHakAkses("Ubah Pemenang");
    super.onInit();
    var dataRute = Get.arguments[0];
    satuanTender = Get.arguments[1];
    satuanVolume = Get.arguments[2];
    idTender = Get.arguments[3];
    noTender = Get.arguments[4];
    judulTender = Get.arguments[5];
    muatan = Get.arguments[6];
    totalKebutuhan.value = Get.arguments[7];
    tipeListPeserta = Get.arguments[8];
    print(dataRuteTender);
    isLoadingData.value = true;
    await getDetailPemenang(dataRute);
    _contactModalBottomSheetController =
        Get.put(CustomARKContactPartnerModalSheetBottomController());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void save() {
    Get.back();
  }

  void contactPartner(String transporterid) async {
    _contactModalBottomSheetController.showContact(
      transporterID: transporterid,
      contactDataParam: null,
    );
  }

  Future getDetailPemenang(List dataRute) async {
    dataRuteTender.clear();
    String ID = "";
    ID = await SharedPreferencesHelper.getUserShipperID();
    print(idTender);
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .getDetailPemenang(
      idTender,
      ID,
    );

    if (result['Message']['Code'].toString() == '200') {
      var data = result['Data'];

      tanggalPemenang =
          result['SupportingData']['tanggal_pilih_pemenang'] ?? "";

      var listTruk = [];
      for (var x = 0; x < dataRute.length; x++) {
        listTruk = [];
        for (var y = 0; y < dataRute[x]['data'].length; y++) {
          var statuspemenang = "0";
          var listPemenang = [];
          //DARI API
          for (var i = 0; i < data.length; i++) {
            for (var j = 0; j < data[i]['detail'].length; j++) {
              if (dataRute[x]['pickup'] == data[i]['pickup'] &&
                  dataRute[x]['destinasi'] == data[i]['destinasi'] &&
                  dataRute[x]['data'][y]['nama_truk'] ==
                      data[i]['detail'][j]['head'] &&
                  dataRute[x]['data'][y]['nama_carrier'] ==
                      data[i]['detail'][j]['carrier']) {
                if (data[i]['detail'][j]['tanpa_pemenang'] == 1) {
                  statuspemenang = "2";
                } else {
                  for (var k = 0;
                      k < data[i]['detail'][j]['detail'].length;
                      k++) {
                    statuspemenang = "1";
                    listPemenang.add({
                      'id': data[i]['detail'][j]['detail'][k]['TransporterID']
                          .toString(),
                      'transporter': data[i]['detail'][j]['detail'][k]
                          ['nama_transporter'],
                      'kota': data[i]['detail'][j]['detail'][k]
                          ['kota_transporter'],
                      'hargaPenawaran': '0',
                      'alokasi': data[i]['detail'][j]['detail'][k]['alokasi']
                          .toString(),
                    });
                  }
                }
              }
            }
          }

          var data_values = {
            'jenis_truk': dataRute[x]['data'][y]['jenis_truk'],
            'nama_truk': dataRute[x]['data'][y]['nama_truk'],
            'jenis_carrier': dataRute[x]['data'][y]['jenis_carrier'],
            'nama_carrier': dataRute[x]['data'][y]['nama_carrier'],
            'nilai': dataRute[x]['data'][y]['nilai'],
            'error': '',
            'datapemenang': listPemenang,
            'statuspemenang':
                statuspemenang, //0 = BELUM ADA PEMENANG,  1 = ADA PEMENANG, 2 = TANPA PEMENANG
          };
          print(data_values);
          listTruk.add(data_values);
        }

        var dataHeader = {
          'pickup': dataRute[x]['pickup'],
          'destinasi': dataRute[x]['destinasi'],
          'data': listTruk,
        };

        dataRuteTender.add(dataHeader);
      }

      isLoadingData.value = false;
    }
  }

  Widget unitTrukRuteDitenderkanWidget(int index) {
    return Obx(
        () =>
            dataRuteTender[index]['pickup'] != "" &&
                    dataRuteTender[index]['destinasi'] != ""
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  0,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  index == dataRuteTender.length - 1 &&
                                          errorPemenangTerisiSemua.value != ""
                                      ? 0
                                      : GlobalVariable.ratioWidth(Get.context) *
                                          14),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            1,
                                    color: Color(ListColor.colorLightGrey10)),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: MediaQuery.of(Get.context)
                                            .size
                                            .width,
                                        padding: EdgeInsets.fromLTRB(
                                            GlobalVariable.ratioWidth(Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                                topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                        child: CustomText(
                                            "ProsesTenderLihatPesertaLabelRute"
                                                    .tr +
                                                " " +
                                                (index + 1)
                                                    .toString()
                                                    .tr, // Rute
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color:
                                                Color(ListColor.colorBlack1B))),
                                    Container(
                                      // KARENA ADA HEIGHTNYA
                                      width:
                                          MediaQuery.of(Get.context).size.width,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          2,
                                      color: Color(ListColor.colorLightGrey10),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        minHeight: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            88,
                                      ),
                                      //KALAU INDEX TERAKHIR< TIDAK PERLU
                                      padding: EdgeInsets.symmetric(
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                15.5,
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                3,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  11.8,
                                              child: Dash(
                                                direction: Axis.vertical,
                                                length:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        41,
                                                dashGap: 1.8,
                                                dashThickness: 1.5,
                                                dashLength: 5,
                                                dashColor:
                                                    Color(ListColor.colorDash),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                      bottom: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          26,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  3,
                                                              right: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  10),
                                                          child: SvgPicture.asset(
                                                              GlobalVariable
                                                                      .imagePath +
                                                                  'ic_pickup.svg',
                                                              width: GlobalVariable
                                                                      .ratioWidth(Get
                                                                          .context) *
                                                                  12,
                                                              height: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  12),
                                                        ),
                                                        CustomText(
                                                            dataRuteTender[
                                                                    index]
                                                                ['pickup'],
                                                            fontSize: 14,
                                                            height: 1.2,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(ListColor
                                                                .colorBlack1B)),
                                                      ],
                                                    )),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                3,
                                                            right: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                10),
                                                        child: SvgPicture.asset(
                                                            GlobalVariable
                                                                    .imagePath +
                                                                'ic_destinasi.svg',
                                                            width: GlobalVariable
                                                                    .ratioWidth(Get
                                                                        .context) *
                                                                12,
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                12),
                                                      ),
                                                      CustomText(
                                                          dataRuteTender[index]
                                                              ['destinasi'],
                                                          fontSize: 14,
                                                          height: 1.2,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(ListColor
                                                              .colorBlack1B)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    for (var indexDetail = 0;
                                        indexDetail <
                                            dataRuteTender[index]['data']
                                                .length;
                                        indexDetail++)
                                      Container(
                                          width: MediaQuery.of(Get.context)
                                              .size
                                              .width,
                                          margin: EdgeInsets.only(
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                            right: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                14,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color(ListColor
                                                      .colorLightGrey10)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14,
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            child: CustomText(
                                                                dataRuteTender[index]['data']
                                                                            [
                                                                            indexDetail]
                                                                        [
                                                                        'nama_truk'] +
                                                                    " - " +
                                                                    dataRuteTender[index]
                                                                            [
                                                                            'data'][indexDetail]
                                                                        [
                                                                        'nama_carrier'],
                                                                fontSize: 14,
                                                                height: 1.2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                maxLines: 2,
                                                                wrapSpace: true,
                                                                color: Color(
                                                                    ListColor
                                                                        .colorBlack1B))),
                                                        SizedBox(
                                                            height: GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                6),
                                                        CustomText(
                                                            GlobalVariable.formatCurrencyDecimal(dataRuteTender[index]['data']
                                                                            [
                                                                            indexDetail]
                                                                        [
                                                                        'nilai']
                                                                    .toString()) +
                                                                " Unit",
                                                            fontSize: 14,
                                                            height: 1.2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(ListColor
                                                                .colorLightGrey4)),
                                                      ],
                                                    )),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14,
                                                      bottom: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14), // KARENA ADA HEIGHTNYA
                                                  width:
                                                      MediaQuery.of(Get.context)
                                                          .size
                                                          .width,
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      2,
                                                  color: Color(ListColor
                                                      .colorLightGrey10),
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14,
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14,
                                                    ),
                                                    child: Column(children: [
                                                      dataRuteTender[index]
                                                                          [
                                                                          'data']
                                                                      [
                                                                      indexDetail]
                                                                  [
                                                                  'statuspemenang'] ==
                                                              '2'
                                                          ? Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: CustomText(
                                                                  "ProsesTenderLihatPesertaLabelDiputuskanTanpaPemenang"
                                                                      .tr, // Diputuskan Tanpa Pemenang
                                                                  fontSize: 14,
                                                                  height: 1.2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  color: Colors
                                                                      .red))
                                                          : Column(children: [
                                                              for (var indexPemenang =
                                                                      0;
                                                                  indexPemenang <
                                                                      dataRuteTender[index]['data'][indexDetail]
                                                                              [
                                                                              'datapemenang']
                                                                          .length;
                                                                  indexPemenang++)
                                                                Column(
                                                                    children: [
                                                                      indexPemenang !=
                                                                              0
                                                                          ? Container(
                                                                              margin: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 14, bottom: GlobalVariable.ratioWidth(Get.context) * 14),
                                                                              // KARENA ADA HEIGHTNYA
                                                                              width: MediaQuery.of(Get.context).size.width,
                                                                              height: GlobalVariable.ratioWidth(Get.context) * 0.5,
                                                                              color: Color(ListColor.colorLightGrey10),
                                                                            )
                                                                          : SizedBox(),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 14),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: GlobalVariable.ratioWidth(Get.context) * 3, left: GlobalVariable.ratioWidth(Get.context) * 1, right: GlobalVariable.ratioWidth(Get.context) * 14),
                                                                              child: SvgPicture.asset(GlobalVariable.imagePath + 'pemenang_blue.svg', width: GlobalVariable.ratioWidth(Get.context) * 16, height: GlobalVariable.ratioWidth(Get.context) * 16, color: Color(ListColor.colorBlue)),
                                                                            ),
                                                                            Expanded(child: CustomText(dataRuteTender[index]['data'][indexDetail]['datapemenang'][indexPemenang]['transporter'] + ' (' + dataRuteTender[index]['data'][indexDetail]['datapemenang'][indexPemenang]['kota'] + ')', fontSize: 14, fontWeight: FontWeight.w600, maxLines: 2, height: 1.2, wrapSpace: true, overflow: TextOverflow.ellipsis, color: Color(ListColor.colorBlack1B)))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            top: GlobalVariable.ratioWidth(Get.context) *
                                                                                14,
                                                                            right: GlobalVariable.ratioWidth(Get.context) *
                                                                                14,
                                                                            bottom:
                                                                                GlobalVariable.ratioWidth(Get.context) * 14),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(right: GlobalVariable.ratioWidth(Get.context) * 14),
                                                                              child: SvgPicture.asset(GlobalVariable.imagePath + 'muatan.svg', width: GlobalVariable.ratioWidth(Get.context) * 16, height: GlobalVariable.ratioWidth(Get.context) * 16, color: Color(ListColor.colorBlue)),
                                                                            ),
                                                                            CustomText(GlobalVariable.formatCurrencyDecimal(dataRuteTender[index]['data'][indexDetail]['datapemenang'][indexPemenang]['alokasi'].toString()) + " Unit",
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(ListColor.colorBlack1B))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10), bottomRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                                                                          child: Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  CustomText(""),
                                                                                ],
                                                                              )),
                                                                              Material(
                                                                                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
                                                                                color: Colors.transparent,
                                                                                child: InkWell(
                                                                                    customBorder: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 18),
                                                                                    ),
                                                                                    onTap: () async {
                                                                                      lihatProfil(dataRuteTender[index]['data'][indexDetail]['datapemenang'][indexPemenang]['id']);
                                                                                    },
                                                                                    child: Container(
                                                                                        padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 24, vertical: GlobalVariable.ratioWidth(Get.context) * 6),
                                                                                        decoration: BoxDecoration(border: Border.all(color: Color(ListColor.colorBlue)), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                                                                                        child: Center(
                                                                                          child: CustomText('ProsesTenderLihatPesertaLabelLihatProfil'.tr, //'Lihat Profile'.tr,
                                                                                              fontSize: 12,
                                                                                              color: Color(ListColor.colorBlue),
                                                                                              fontWeight: FontWeight.w600),
                                                                                        ))),
                                                                              ),
                                                                              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                                                                              Material(
                                                                                borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20),
                                                                                color: Colors.transparent,
                                                                                child: InkWell(
                                                                                    customBorder: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 18),
                                                                                    ),
                                                                                    onTap: () async {
                                                                                      hubungi(dataRuteTender[index]['data'][indexDetail]['datapemenang'][indexPemenang]['id']);
                                                                                    },
                                                                                    child: Container(
                                                                                        padding: EdgeInsets.symmetric(horizontal: GlobalVariable.ratioWidth(Get.context) * 24, vertical: GlobalVariable.ratioWidth(Get.context) * 6),
                                                                                        decoration: BoxDecoration(color: Color(ListColor.colorBlue), border: Border.all(color: Color(ListColor.colorBlue)), borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 20)),
                                                                                        child: Center(
                                                                                          child: CustomText('ProsesTenderLihatPesertaLabelHubungi'.tr, //'Hubungi'.tr,
                                                                                              fontSize: 12,
                                                                                              color: Colors.white,
                                                                                              fontWeight: FontWeight.w600),
                                                                                        ))),
                                                                              )
                                                                            ],
                                                                          )),
                                                                    ]),
                                                            ])
                                                    ]))
                                              ]))
                                  ])),
                        )
                      ])
                : SizedBox());
  }

  Widget beratRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          index == dataRuteTender.length - 1 &&
                                  errorPemenangTerisiSemua.value != ""
                              ? 0
                              : GlobalVariable.ratioWidth(Get.context) * 14),
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, GlobalVariable.ratioWidth(Get.context) * 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: GlobalVariable.ratioWidth(Get.context) * 1,
                            color: Color(ListColor.colorLightGrey10)),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(Get.context).size.width,
                              padding: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        "ProsesTenderLihatPesertaLabelRute".tr +
                                            " " +
                                            (index + 1).toString().tr, // Rute
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(ListColor.colorBlack1B)),
                                  ])),
                          Container(
                            // KARENA ADA HEIGHTNYA
                            width: MediaQuery.of(Get.context).size.width,
                            height: GlobalVariable.ratioWidth(Get.context) * 2,
                            color: Color(ListColor.colorLightGrey10),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 16,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              left: GlobalVariable.ratioWidth(Get.context) * 16,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      15.5,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.8,
                                    child: Dash(
                                      direction: Axis.vertical,
                                      length: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          41,
                                      dashGap: 1.8,
                                      dashThickness: 1.5,
                                      dashLength: 5,
                                      dashColor: Color(ListColor.colorDash),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                26,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        3,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        'ic_pickup.svg',
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                              ),
                                              CustomText(
                                                  dataRuteTender[index]
                                                      ['pickup'],
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(
                                                      ListColor.colorBlack1B)),
                                            ],
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          3,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'ic_destinasi.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                            ),
                                            CustomText(
                                                dataRuteTender[index]
                                                    ['destinasi'],
                                                fontSize: 14,
                                                height: 1.2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                    ListColor.colorBlack1B)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 14,
                                right: GlobalVariable.ratioWidth(Get.context) *
                                    14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          3,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath + 'muatan.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      color: Color(ListColor.colorBlue)),
                                ),
                                CustomText(
                                    GlobalVariable.formatCurrencyDecimal(
                                            dataRuteTender[index]['data'][0]
                                                    ['nilai']
                                                .toString()) +
                                        " Ton",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 14,
                                bottom: GlobalVariable.ratioWidth(Get.context) *
                                    14), // KARENA ADA HEIGHTNYA
                            width: MediaQuery.of(Get.context).size.width,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 0.5,
                            color: Color(ListColor.colorLightGrey2),
                          ),
                          dataRuteTender[index]['data'][0]['statuspemenang'] ==
                                  '2'
                              ? Container(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                      "ProsesTenderLihatPesertaLabelDiputuskanTanpaPemenang"
                                          .tr, // Diputuskan Tanpa Pemenang
                                      fontSize: 14,
                                      height: 1.2,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.center,
                                      color: Colors.red))
                              : Column(children: [
                                  for (var indexPemenang = 0;
                                      indexPemenang <
                                          dataRuteTender[index]['data'][0]
                                                  ['datapemenang']
                                              .length;
                                      indexPemenang++)
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14,
                                        ),
                                        child: Column(children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          3,
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          3,
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          8),
                                                  child: SvgPicture.asset(
                                                      GlobalVariable.imagePath +
                                                          'pemenang_blue.svg',
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      color: Color(
                                                          ListColor.colorBlue)),
                                                ),
                                                Expanded(
                                                    child: CustomText(
                                                        dataRuteTender[index]['data']
                                                                            [0]
                                                                        ['datapemenang']
                                                                    [indexPemenang]
                                                                [
                                                                'transporter'] +
                                                            ' (' +
                                                            dataRuteTender[index]
                                                                            ['data'][0]
                                                                        ['datapemenang']
                                                                    [indexPemenang]
                                                                ['kota'] +
                                                            ')',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        height: 1.2,
                                                        maxLines: 2,
                                                        wrapSpace: true,
                                                        color: Color(ListColor.colorBlack1B)))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    14,
                                                right:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          3,
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          8),
                                                  child: SvgPicture.asset(
                                                      GlobalVariable.imagePath +
                                                          'muatan.svg',
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      color: Color(
                                                          ListColor.colorBlue)),
                                                ),
                                                CustomText(
                                                    GlobalVariable.formatCurrencyDecimal(
                                                            dataRuteTender[index]['data'][0]
                                                                            [
                                                                            'datapemenang']
                                                                        [
                                                                        indexPemenang]
                                                                    ['alokasi']
                                                                .toString()) +
                                                        " Ton",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(
                                                        ListColor.colorBlack1B))
                                              ],
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      14),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10))),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CustomText(""),
                                                    ],
                                                  )),
                                                  Material(
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                        customBorder:
                                                            RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  18),
                                                        ),
                                                        onTap: () async {
                                                          lihatProfil(dataRuteTender[
                                                                          index]
                                                                      ['data'][0]
                                                                  [
                                                                  'datapemenang']
                                                              [
                                                              indexPemenang]['id']);
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        24,
                                                                vertical:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        6),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue)),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            20)),
                                                            child: Center(
                                                              child: CustomText(
                                                                  'ProsesTenderLihatPesertaLabelLihatProfil'
                                                                      .tr, //'Lihat Profile'.tr,
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorBlue),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))),
                                                  ),
                                                  SizedBox(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          12),
                                                  Material(
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                        customBorder:
                                                            RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  18),
                                                        ),
                                                        onTap: () async {
                                                          hubungi(dataRuteTender[
                                                                          index]
                                                                      ['data'][0]
                                                                  [
                                                                  'datapemenang']
                                                              [
                                                              indexPemenang]['id']);
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        24,
                                                                vertical:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        6),
                                                            decoration: BoxDecoration(
                                                                color: Color(ListColor
                                                                    .colorBlue),
                                                                border: Border.all(
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue)),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        GlobalVariable.ratioWidth(Get.context) * 20)),
                                                            child: Center(
                                                              child: CustomText(
                                                                  'ProsesTenderLihatPesertaLabelHubungi'
                                                                      .tr, //'Hubungi'.tr,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))),
                                                  )
                                                ],
                                              )),
                                          indexPemenang !=
                                                  dataRuteTender[index]['data']
                                                                  [0]
                                                              ['datapemenang']
                                                          .length -
                                                      1
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14,
                                                      bottom: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14), // KARENA ADA HEIGHTNYA
                                                  width:
                                                      MediaQuery.of(Get.context)
                                                          .size
                                                          .width,
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      0.5,
                                                  color: Color(ListColor
                                                      .colorLightGrey2),
                                                )
                                              : SizedBox(),
                                        ]))
                                ]),
                        ],
                      )),
                )
              ])
        : SizedBox());
  }

  Widget volumeRuteDitenderkanWidget(int index) {
    return Obx(() => dataRuteTender[index]['pickup'] != "" &&
            dataRuteTender[index]['destinasi'] != ""
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                GestureDetector(
                  onTap: () async {},
                  child: Container(
                      margin: EdgeInsets.fromLTRB(
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 16,
                          index == dataRuteTender.length - 1 &&
                                  errorPemenangTerisiSemua.value != ""
                              ? 0
                              : GlobalVariable.ratioWidth(Get.context) * 14),
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, GlobalVariable.ratioWidth(Get.context) * 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: GlobalVariable.ratioWidth(Get.context) * 1,
                            color: Color(ListColor.colorLightGrey10)),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(Get.context).size.width,
                              padding: EdgeInsets.fromLTRB(
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                                  GlobalVariable.ratioWidth(Get.context) * 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10),
                                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 10))),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                        "ProsesTenderLihatPesertaLabelRute".tr +
                                            " " +
                                            (index + 1).toString().tr, // Rute
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Color(ListColor.colorBlack1B)),
                                  ])),
                          Container(
                            // KARENA ADA HEIGHTNYA
                            width: MediaQuery.of(Get.context).size.width,
                            height: GlobalVariable.ratioWidth(Get.context) * 2,
                            color: Color(ListColor.colorLightGrey10),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  GlobalVariable.ratioWidth(Get.context) * 85,
                            ),
                            //KALAU INDEX TERAKHIR< TIDAK PERLU
                            padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 16,
                              bottom:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              left: GlobalVariable.ratioWidth(Get.context) * 16,
                              right:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      15.5,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11.8,
                                    child: Dash(
                                      direction: Axis.vertical,
                                      length: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          41,
                                      dashGap: 1.8,
                                      dashThickness: 1.5,
                                      dashLength: 5,
                                      dashColor: Color(ListColor.colorDash),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            bottom: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                26,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        3,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        10),
                                                child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        'ic_pickup.svg',
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                              ),
                                              CustomText(
                                                  dataRuteTender[index]
                                                      ['pickup'],
                                                  fontSize: 14,
                                                  height: 1.2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(
                                                      ListColor.colorBlack1B)),
                                            ],
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          3,
                                                  right:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          10),
                                              child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      'ic_destinasi.svg',
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          12),
                                            ),
                                            CustomText(
                                                dataRuteTender[index]
                                                    ['destinasi'],
                                                fontSize: 14,
                                                height: 1.2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                    ListColor.colorBlack1B)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 14,
                                right: GlobalVariable.ratioWidth(Get.context) *
                                    14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          3,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8),
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath + 'muatan.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          16,
                                      color: Color(ListColor.colorBlue)),
                                ),
                                CustomText(
                                    GlobalVariable.formatCurrencyDecimal(
                                            dataRuteTender[index]['data'][0]
                                                    ['nilai']
                                                .toString()) +
                                        " " +
                                        satuanVolume,
                                    fontSize: 14,
                                    height: 1.2,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 14,
                                bottom: GlobalVariable.ratioWidth(Get.context) *
                                    14), // KARENA ADA HEIGHTNYA
                            width: MediaQuery.of(Get.context).size.width,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 0.5,
                            color: Color(ListColor.colorLightGrey2),
                          ),
                          dataRuteTender[index]['data'][0]['statuspemenang'] ==
                                  '2'
                              ? Container(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                      "ProsesTenderLihatPesertaLabelDiputuskanTanpaPemenang"
                                          .tr, // Diputuskan Tanpa Pemenang
                                      fontSize: 14,
                                      height: 1.2,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.center,
                                      color: Colors.red))
                              : Column(children: [
                                  for (var indexPemenang = 0;
                                      indexPemenang <
                                          dataRuteTender[index]['data'][0]
                                                  ['datapemenang']
                                              .length;
                                      indexPemenang++)
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14,
                                        ),
                                        child: Column(children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          3,
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          3,
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          8),
                                                  child: SvgPicture.asset(
                                                      GlobalVariable.imagePath +
                                                          'pemenang_blue.svg',
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      color: Color(
                                                          ListColor.colorBlue)),
                                                ),
                                                Expanded(
                                                    child: CustomText(
                                                        dataRuteTender[index]['data']
                                                                            [0]
                                                                        ['datapemenang']
                                                                    [indexPemenang]
                                                                [
                                                                'transporter'] +
                                                            ' (' +
                                                            dataRuteTender[index]
                                                                            ['data'][0]
                                                                        ['datapemenang']
                                                                    [indexPemenang]
                                                                ['kota'] +
                                                            ')',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        height: 1.2,
                                                        maxLines: 2,
                                                        wrapSpace: true,
                                                        color: Color(ListColor.colorBlack1B)))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    14,
                                                right:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          3,
                                                      right: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          8),
                                                  child: SvgPicture.asset(
                                                      GlobalVariable.imagePath +
                                                          'muatan.svg',
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          16,
                                                      color: Color(
                                                          ListColor.colorBlue)),
                                                ),
                                                CustomText(
                                                    GlobalVariable.formatCurrencyDecimal(
                                                            dataRuteTender[index]['data'][0]
                                                                            [
                                                                            'datapemenang']
                                                                        [
                                                                        indexPemenang]
                                                                    ['alokasi']
                                                                .toString()) +
                                                        " " +
                                                        satuanVolume,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(
                                                        ListColor.colorBlack1B))
                                              ],
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      14),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10))),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CustomText(""),
                                                    ],
                                                  )),
                                                  Material(
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                        customBorder:
                                                            RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  18),
                                                        ),
                                                        onTap: () async {
                                                          lihatProfil(dataRuteTender[
                                                                          index]
                                                                      ['data'][0]
                                                                  [
                                                                  'datapemenang']
                                                              [
                                                              indexPemenang]['id']);
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        24,
                                                                vertical:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        6),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue)),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            20)),
                                                            child: Center(
                                                              child: CustomText(
                                                                  'ProsesTenderLihatPesertaLabelLihatProfil'
                                                                      .tr, //'Lihat Profile'.tr,
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorBlue),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))),
                                                  ),
                                                  SizedBox(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          12),
                                                  Material(
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                        customBorder:
                                                            RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  18),
                                                        ),
                                                        onTap: () async {
                                                          hubungi(dataRuteTender[
                                                                          index]
                                                                      ['data'][0]
                                                                  [
                                                                  'datapemenang']
                                                              [
                                                              indexPemenang]['id']);
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        24,
                                                                vertical:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        6),
                                                            decoration: BoxDecoration(
                                                                color: Color(ListColor
                                                                    .colorBlue),
                                                                border: Border.all(
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue)),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        GlobalVariable.ratioWidth(Get.context) * 20)),
                                                            child: Center(
                                                              child: CustomText(
                                                                  'ProsesTenderLihatPesertaLabelHubungi'
                                                                      .tr, //'Hubungi'.tr,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))),
                                                  )
                                                ],
                                              )),
                                          indexPemenang !=
                                                  dataRuteTender[index]['data']
                                                                  [0]
                                                              ['datapemenang']
                                                          .length -
                                                      1
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14,
                                                      bottom: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          14), // KARENA ADA HEIGHTNYA
                                                  width:
                                                      MediaQuery.of(Get.context)
                                                          .size
                                                          .width,
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      0.5,
                                                  color: Color(ListColor
                                                      .colorLightGrey2),
                                                )
                                              : SizedBox(),
                                        ]))
                                ]),
                        ],
                      )),
                )
              ])
        : SizedBox());
  }

  void lihatProfil(String idtransporter) async {
    print(idtransporter);
    var data = await GetToPage.toNamed<TransporterController>(
        Routes.TRANSPORTER,
        arguments: [idtransporter]);
  }

  void hubungi(String idtransporter) async {
    contactPartner(idtransporter);
  }

  void ubahPemenang() async {
    var data =
        await GetToPage.toNamed<ListHalamanPesertaPilihPemenangController>(
            Routes.LIST_HALAMAN_PESERTA_PILIH_PEMENANG,
            arguments: [
          dataRuteTender,
          satuanTender,
          satuanVolume,
          idTender,
          noTender,
          judulTender,
          muatan,
          totalKebutuhan.value,
          tipeListPeserta,
          'UBAH'
        ]);
    if (data != null) {
      isLoadingData.value = true;
      await getDetailPemenang(data[0]);
    }
  }
}
