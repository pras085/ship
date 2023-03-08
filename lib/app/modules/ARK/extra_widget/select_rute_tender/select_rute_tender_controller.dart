import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/create_info_pra_tender/create_info_pra_tender_view.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SelectRuteTenderController extends GetxController {
  var form = GlobalKey<FormState>();
  var dataTrukTender = [].obs;
  var dataRuteTenderSebelumSimpan = {}.obs;
  var dataRuteTender = {}.obs;
  var dataRuteTenderAll = [].obs;
  var JmlTrukPerRute = [].obs;
  var jmlTrukTemp = [];
  var satuanTender = "".obs;
  var ruteke = 1.obs;
  var listTruk = [].obs;
  var cekPengisian = false.obs;
  var validasiSimpan = true;
  var jenisTransaksi = "";

  @override
  void onInit() {
    dataRuteTender.value = Get.arguments[0];
    dataRuteTenderSebelumSimpan.value =
        json.decode(json.encode(Get.arguments[0]));
    dataTrukTender.value = Get.arguments[1];
    dataRuteTenderAll.value = Get.arguments[2];
    ruteke.value = Get.arguments[3];
    jenisTransaksi = Get.arguments[4];

    print(dataRuteTender);

    //STATE AWAL PASTI TIDAK SAMA JUMLAH DATA TRUK YANG TERSEDIA DAN TRUK YANG DIGUNAKAN

    for (var x = 0; x < dataRuteTender['data'].length; x++) {
      JmlTrukPerRute.add(TextEditingController(
          text: GlobalVariable.formatCurrencyDecimal(
              dataRuteTender['data'][x]['nilai'].toString())));
      jmlTrukTemp.add(0);
    }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Widget kebutuhanTrukWidget(index) {
    return Obx(() => Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 24,
            ),
            lineDividerWidget(),
            SizedBox(
              height: GlobalVariable.ratioWidth(Get.context) * 16,
            ),
            CustomText(
                "InfoPraTenderCreateLabelJenisTrukCarrier"
                    .tr, // Jenis Truk - Carrier
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.4,
                color: Color(ListColor.colorLightGrey14)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 11),
            CustomText(
                dataTrukTender[index]['nama_truk'] +
                    ' - ' +
                    dataTrukTender[index]['nama_carrier'],
                fontSize: 14,
                height: 1.2,
                fontWeight: FontWeight.w600,
                color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 16),
            CustomText(
                'InfoPraTenderCreateLabelInfoJumlahTruk'
                    .tr, //Jumlah Unit Truk untuk Rute Ini
                fontSize: 14,
                height: 1.2,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorGrey3)),
            Obx(() => CustomText(
                "(" +
                    "InfoPraTenderCreateLabelInfoMaksimalJumlahTruk".tr +
                    " " + //Maksimal
                    ((dataTrukTender[index]['jumlah_truck'] -
                                    jmlTrukTemp[index]) <=
                                0
                            ? 0
                            : (dataTrukTender[index]['jumlah_truck'] -
                                jmlTrukTemp[index]))
                        .toString() +
                    ' Unit)'.tr,
                fontSize: 12,
                height: 1.2,
                fontWeight: FontWeight.w500,
                color: Color(ListColor.colorGrey3))),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 90,
                      child: Stack(alignment: Alignment.centerLeft, children: [
                        Obx(() => Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(ListColor.colorLightGrey10)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4))),
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 22,
                              child: CustomTextField(
                                context: Get.context,
                                controller: JmlTrukPerRute[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                  DecimalInputFormatter(
                                      digit: 4,
                                      digitAfterComma: 0,
                                      controller: JmlTrukPerRute[index])
                                ],
                                newContentPadding: EdgeInsets.only(top: 1.0),
                                newInputDecoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText: '',
                                    errorMaxLines: 2,
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white,
                                    )),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white,
                                    ))),
                                onChanged: (value) {
                                  if (value == "") {
                                    value = "0";
                                  }
                                  print(dataRuteTender['data'][index]['nilai']);
                                  jmlTrukTemp[index] = int.parse(
                                          GlobalVariable.formatDoubleDecimal(
                                              value)) -
                                      dataRuteTender['data'][index]['nilai'];
                                  dataRuteTender.refresh();
                                },
                              ),
                            )),
                        Positioned(
                            child: GestureDetector(
                                onTap: () {
                                  FocusManager.instance.primaryFocus.unfocus();

                                  if (JmlTrukPerRute[index].text == "") {
                                    JmlTrukPerRute[index].text = "0";
                                  }
                                  if (int.parse(
                                          GlobalVariable.formatDoubleDecimal(
                                              JmlTrukPerRute[index].text)) >
                                      0) {
                                    JmlTrukPerRute[index].text =
                                        GlobalVariable.formatCurrencyDecimal(
                                            (int.parse(GlobalVariable
                                                        .formatDoubleDecimal(
                                                            JmlTrukPerRute[
                                                                    index]
                                                                .text)) -
                                                    1)
                                                .toString());
                                    jmlTrukTemp[index]--;
                                    dataRuteTender.refresh();
                                  }
                                },
                                child: Container(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            22,
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            22,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Color(ListColor.colorBlue),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    4))),
                                    child: Icon(Icons.remove,
                                        size: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            20,
                                        color: Color(ListColor.colorBlue))))),
                        Positioned(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();
                                      if (JmlTrukPerRute[index].text == "") {
                                        JmlTrukPerRute[index].text = "0";
                                      }
                                      if (int.parse(GlobalVariable
                                              .formatDoubleDecimal(
                                                  JmlTrukPerRute[index].text)) <
                                          10000) {
                                        JmlTrukPerRute[index].text =
                                            GlobalVariable.formatCurrencyDecimal(
                                                (int.parse(GlobalVariable
                                                            .formatDoubleDecimal(
                                                                JmlTrukPerRute[
                                                                        index]
                                                                    .text)) +
                                                        1)
                                                    .toString());

                                        jmlTrukTemp[index]++;
                                        dataRuteTender.refresh();
                                      }
                                    },
                                    child: Container(
                                        height:
                                            GlobalVariable.ratioWidth(Get.context) *
                                                22,
                                        width:
                                            GlobalVariable.ratioWidth(Get.context) *
                                                22,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Color(ListColor.colorBlue),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        4))),
                                        child: Icon(Icons.add,
                                            size: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20,
                                            color: Color(ListColor.colorBlue)))))),
                      ])),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                  Expanded(
                    child: CustomText('Unit'.tr,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.2,
                        color: Colors.black),
                  ),
                  //: SizedBox(),
                ]),
            Obx(() => dataRuteTender['data'][index]['error'] != ""
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 8),
                      Row(
                        children: [
                          Expanded(
                              child: CustomText(
                            dataRuteTender['data'][index]['error'],
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            height: 1.2,
                            color: Color(ListColor.colorRed),
                          )),
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 74)
                        ],
                      ),
                    ],
                  )
                : SizedBox()),
            index == dataRuteTender['data'].length - 1
                ? SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 10)
                : SizedBox(),
          ],
        )));
  }

  //Membuat Garis Pemisah
  Widget lineDividerWidget() {
    return Container(
      child: Divider(
        thickness: GlobalVariable.ratioWidth(Get.context) * 1,
        color: Color(ListColor.colorLightGrey5).withOpacity(0.29),
        height: 0,
      ),
    );
  }

  void cekRuteKembar() async {
    //CEK DALAM RUTE INI APAKAH ADA RUTE YANG SAMA DAN TRUK YANG SAMA
    if (dataRuteTender['pickup'] != "" &&
        dataRuteTender['destinasi'] != "" &&
        dataRuteTenderAll
                .where((element) =>
                    element['pickup'] == dataRuteTender['pickup'] &&
                    element['destinasi'] == dataRuteTender['destinasi'])
                .toList()
                .length >
            1) {
      validasiSimpan = false;
      //RUTE KEMBAR
      var ruteKembar = 0;
      for (var x = 0; x < dataRuteTenderAll.length; x++) {
        if ((x + 1) != ruteke.value &&
            dataRuteTenderAll[x]['pickup'] == dataRuteTender['pickup'] &&
            dataRuteTenderAll[x]['destinasi'] == dataRuteTender['destinasi']) {
          ruteKembar = (x + 1);
        }
      }
      print(ruteKembar);
      dataRuteTender['error_lokasi_kembar'] =
          "InfoPraTenderCreateAlertRuteSama1".tr +
              ' ' +
              ruteke.value.toString() +
              ' ' +
              'InfoPraTenderCreateAlertRuteSama2'.tr +
              ' ' +
              ruteKembar
                  .toString(); //Harap kosongkan jumlah unit di salah satu rute
    } else {
      dataRuteTender['error_lokasi_kembar'] = "";
    }
    dataRuteTender.refresh();
  }
}
