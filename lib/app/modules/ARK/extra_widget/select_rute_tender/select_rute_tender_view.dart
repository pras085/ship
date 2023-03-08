import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_rute_tender/select_rute_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_custom2.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiver/strings.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SelectRuteTenderView extends GetView<SelectRuteTenderController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
            child: SafeArea(
                child: Scaffold(
          backgroundColor: Color(ListColor.colorLightGrey6),
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(GlobalVariable.ratioWidth(Get.context) * 56),
            child: Container(
              alignment: Alignment.center,
              height: GlobalVariable.ratioWidth(Get.context) * 56,
              padding: EdgeInsets.symmetric(
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12),
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(ListColor.colorLightGrey).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ], color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: GestureDetector(
                            onTap: () {
                              onWillPop();
                            },
                            child: SvgPicture.asset(
                                GlobalVariable.imagePath +
                                    "ic_back_blue_button.svg",
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    24))),
                  )),
                  Positioned(
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: CustomText(
                              "InfoPraTenderCreateLabelDataRute".tr +
                                  " " +
                                  (controller.ruteke.value)
                                      .toString(), //Data Rute
                              height: 1.2,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.00,
                            ),
                          ))),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10),
                  topRight: Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 11,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 96),
            child: MaterialButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 20))),
              color: Color(ListColor.color4),
              onPressed: () {
                controller.validasiSimpan =
                    controller.form.currentState.validate();

                //PENGECEKAN LOKASI KEMBAR
                controller.cekRuteKembar();
                if (controller.dataRuteTender['error_lokasi_kembar'] == "") {
                  controller.validasiSimpan = true;
                }

                if (controller.validasiSimpan) {
                  for (var x = 0;
                      x < controller.dataRuteTender['data'].length;
                      x++) {
                    controller.dataRuteTender['data'][x]['error'] = "";

                    //CEK APAKAH TERDAPAT JUMLAH TRUK DIISI NOL ATAU TIDAK
                    if (controller.dataRuteTender['data'][x]['nilai']
                            .toString() ==
                        "") {
                      // controller.validasiSimpan = false;
                      // controller.dataRuteTender['data'][x]['error'] =
                      //     "Jumlah Truk Harus Diisi";
                      controller.dataRuteTender['data'][x]['nilai'] = 0;
                    }
                    print('JUmlah Perubahan');
                    print(controller.jmlTrukTemp[x]);

                    print('Nilai Awal');
                    print(controller.dataRuteTender['data'][x]['nilai']);
                    //PENGECEKAN JIKA UNIT TRUK DIPILIH LEBIH DARI SISANYA

                    if (controller.jmlTrukTemp[x] >
                        controller.dataTrukTender[x]['jumlah_truck']) {
                      controller.validasiSimpan = false;
                      controller.dataRuteTender['data'][x]
                          ['error'] = 'InfoPraTenderCreateLabelAlertJumlahUnit'
                              .tr +
                          ' ' + //Jumlah yang diinputkan melebihi batas maksimal
                          GlobalVariable.formatCurrencyDecimal(controller
                              .dataTrukTender[x]['jumlah_truck']
                              .toString()) +
                          ' unit';
                    } else {}
                  }

                  controller.dataRuteTender['error_pickup'] = "";
                  controller.dataRuteTender['error_destinasi'] = "";
                  controller.dataRuteTender['error_lokasi_kembar'] = "";

                  if (controller.dataRuteTender['pickup'] == "") {
                    controller.dataRuteTender['error_pickup'] =
                        "InfoPraTenderCreateLabelAlertLokasiPickUp"
                            .tr; //Lokasi Pickup Belum Dimasukan
                    controller.validasiSimpan = false;
                  }
                  if (controller.dataRuteTender['destinasi'] == "") {
                    controller.dataRuteTender['error_destinasi'] =
                        "InfoPraTenderCreateLabelAlertLokasiDestinasi"
                            .tr; //Lokasi Destinasi Belum Dimasukan
                    controller.validasiSimpan = false;
                  }
                }

                controller.dataRuteTender.refresh();
                if (controller.validasiSimpan) {
                  for (var x = 0;
                      x < controller.dataRuteTender['data'].length;
                      x++) {
                    controller.dataRuteTender['data'][x]['error'] = '';

                    controller.dataRuteTender['data'][x]['nilai'] +=
                        controller.jmlTrukTemp[x];
                  }
                  print('HASIL');
                  print(controller.dataRuteTender);
                  Get.back(result: controller.dataRuteTender);
                }
              },
              child: CustomText(
                "InfoPraTenderCreateLabelButtonSimpan".tr, // Simpan
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.2,
              ),
            ),
          ),
          body: Obx(() => Container(
              margin: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              child: Form(
                  key: controller.form,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            bottom: GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          child: CustomText(
                              "InfoPraTenderCreateLabelLokasiPickup"
                                  .tr, //Lokasi Pickup
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              height: 1.4,
                              color: Color(ListColor.colorGrey3)),
                        ),
                        GestureDetector(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: controller.dataRuteTender[
                                                    'error_pickup'] !=
                                                ""
                                            ? Color(ListColor.colorRed)
                                            : Color(
                                                ListColor.colorLightGrey10)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) * 6)),
                                child: CustomText(
                                    controller.dataRuteTender['pickup'] == ""
                                        ? "InfoPraTenderCreateLabelMasukkanLokasiPickUp".tr // Masukkan Lokasi Pickup
                                        : controller.dataRuteTender['pickup'],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: controller.dataRuteTender['pickup'] == "" ? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey4))),
                            onTap: () async {
                              FocusManager.instance.primaryFocus.unfocus();
                              var result = await Get.toNamed(
                                  Routes.CHOOSE_AREA_PICKUP,
                                  arguments: [
                                    0,
                                    {},
                                    "InfoPraTenderCreateLabelPlaceholderCariLokasiPickup"
                                        .tr,
                                    "1",
                                    controller.jenisTransaksi
                                  ]); //Cari Lokasi Pickup
                              if (result != null) {
                                (result as Map).keys.forEach((key) {
                                  //Lokasi
                                  print(result[key]);
                                  controller.dataRuteTender['pickup'] =
                                      result[key];

                                  controller.dataRuteTender.refresh();

                                  controller.cekRuteKembar();
                                });
                              }
                            }),
                        controller.dataRuteTender['error_pickup'] != ""
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                                controller.dataRuteTender[
                                                    'error_pickup'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                height: 1.2,
                                                color:
                                                    Color(ListColor.colorRed),
                                              ))),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              74)
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          child: CustomText(
                              "InfoPraTenderCreateLabelDestinasi"
                                  .tr, // Lokasi Destinasi
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              height: 1.4,
                              color: Color(ListColor.colorGrey3)),
                        ),
                        GestureDetector(
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            11),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: controller.dataRuteTender[
                                                    'error_destinasi'] !=
                                                ""
                                            ? Color(ListColor.colorRed)
                                            : Color(
                                                ListColor.colorLightGrey10)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) * 6)),
                                child: CustomText(
                                    controller.dataRuteTender['destinasi'] == ""
                                        ? "InfoPraTenderCreateLabelMasukkanLokasiDestinasi".tr //Masukkan Lokasi Destinasi
                                        : controller.dataRuteTender['destinasi'],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: controller.dataRuteTender['destinasi'] == "" ? Color(ListColor.colorLightGrey2) : Color(ListColor.colorLightGrey4))),
                            onTap: () async {
                              FocusManager.instance.primaryFocus.unfocus();
                              var result = await Get.toNamed(
                                  Routes.CHOOSE_AREA_PICKUP,
                                  arguments: [
                                    0,
                                    {},
                                    "InfoPraTenderCreateLabelPlaceholderCariLokasiDestinasi"
                                        .tr,
                                    "2",
                                    controller.jenisTransaksi
                                  ]); // Cari Lokasi Destinasi
                              if (result != null) {
                                (result as Map).keys.forEach((key) {
                                  //Lokasi
                                  print(result[key]);
                                  controller.dataRuteTender['destinasi'] =
                                      result[key];

                                  controller.dataRuteTender.refresh();

                                  controller.cekRuteKembar();
                                });
                              }
                            }),
                        controller.dataRuteTender['error_destinasi'] != ""
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                                controller.dataRuteTender[
                                                    'error_destinasi'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                height: 1.2,
                                                color:
                                                    Color(ListColor.colorRed),
                                              ))),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              74)
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        controller.dataRuteTender['error_lokasi_kembar'] != ""
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Obx(() => CustomText(
                                                controller.dataRuteTender[
                                                    'error_lokasi_kembar'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                height: 1.2,
                                                color:
                                                    Color(ListColor.colorRed),
                                              ))),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              74)
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (var index = 0;
                                index < controller.dataTrukTender.length;
                                index++)
                              controller.kebutuhanTrukWidget(index),
                            SizedBox(
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    20),
                          ],
                        )
                      ],
                    ),
                  )))),
        ))));
  }

  Future<bool> onWillPop() async {
    //JIKA JUMLAHNYA MAP SEBELUMNYA DAN AP SEKARANG TIDAK SAMA
    if (controller.dataRuteTenderSebelumSimpan['data'].length !=
        controller.dataRuteTender['data'].length) {
      controller.cekPengisian.value = true;
    } else {
      for (var index = 0;
          index < controller.dataRuteTender['data'].length;
          index++) {
        if (controller.dataRuteTender['data'][index]['jenis_truk'] !=
            controller.dataRuteTenderSebelumSimpan['data'][index]
                ['jenis_truk']) {
          controller.cekPengisian.value = true;
          print('Jenis Truk Tidak Sama');
        } else if (controller.dataRuteTender['data'][index]['jenis_carrier'] !=
            controller.dataRuteTenderSebelumSimpan['data'][index]
                ['jenis_carrier']) {
          controller.cekPengisian.value = true;
          print('Jenis Carrier Tidak Sama');
        } else if (controller.dataRuteTender['data'][index]['nilai'] !=
            controller.dataRuteTenderSebelumSimpan['data'][index]['nilai']) {
          controller.cekPengisian.value = true;
          print('Nilai Tidak Sama');
        }
      }
    }
    //CEK PICKUP DAN DESTINASI, SAMA ATAU TIDAK
    if (controller.dataRuteTenderSebelumSimpan['pickup'] !=
            controller.dataRuteTender['pickup'] ||
        controller.dataRuteTenderSebelumSimpan['destinasi'] !=
            controller.dataRuteTender['destinasi']) {
      controller.cekPengisian.value = true;
      print('Lokasi Pick Up / Destinasi Tidak Sama');
    }

    if (controller.cekPengisian.value) {
      GlobalAlertDialog.showAlertDialogCustom(
          context: Get.context,
          title: "InfoPraTenderCreateLabelInfoKonfirmasiPembatalan"
              .tr, //Konfirmasi Pembatalan
          message: "InfoPraTenderCreateLabelInfoApakahAndaYakinInginKembali"
                  .tr +
              "\n" +
              "InfoPraTenderCreateLabelInfoDataTidakDisimpan"
                  .tr, //Apakah anda yakin ingin kembali? Data yang telah diisi tidak akan disimpan
          labelButtonPriority1: GlobalAlertDialog.noLabelButton,
          onTapPriority1: () {},
          onTapPriority2: () async {
            Get.back(result: controller.dataRuteTenderSebelumSimpan);
          },
          labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
    } else {
      Get.back(result: controller.dataRuteTenderSebelumSimpan);
    }
  }
}
