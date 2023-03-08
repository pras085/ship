import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/api_helper_ark.dart';
import 'package:muatmuat/app/modules/login/model_data.dart';
import 'package:muatmuat/app/modules/register_shipper_bf_tm/register_shipper_bf_tm_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:url_launcher/url_launcher.dart';

class LihatDokumenPersyaratanController extends GetxController {
  var modul = "";
  var sisi = "";
  var tab = "";
  var dataPersyaratan = [].obs;
  var dataDokumen = [].obs;
  var jmlArmadaController = TextEditingController().obs;
  var kapasitasPengirimanController = TextEditingController().obs;
  var changePengiriman = "".obs;
  var changeJumlahArmada = "".obs;
  var loading = true.obs;
  var onLoad = true.obs;
  var url = ''.obs;

  @override
  void onInit() async {
    modul = Get.arguments[0];
    sisi = Get.arguments[1];
    tab = Get.arguments[2];

    if (tab == "SHIPPER" && modul == "BIGFLEET") {
      url.value = GlobalVariable.urlBF + "/demo-terms-condition-bf/shipper";
    } else if (tab == "SHIPPER" && modul == "TRANSPORTMARKET") {
      url.value = GlobalVariable.urlTM + "/demo-terms-condition-tm/shipper";
    } else if (tab == "TRANSPORTER" && modul == "BIGFLEET") {
      url.value = GlobalVariable.urlBF + "/demo-terms-condition-bf/transporter";
    } else if (tab == "TRANSPORTER" && modul == "TRANSPORTMARKET") {
      url.value = GlobalVariable.urlTM + "/demo-terms-condition-tm/transporter";
    }

    //url.value = "https://google.com/";
    print(url.value);
    // _launchInWebViewOrVC(url.value);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void popUpPemberitahuan() async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 34,
                  right: GlobalVariable.ratioWidth(Get.context) * 34),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
              child: IntrinsicHeight(
                  child: Stack(
                children: [
                  Positioned(
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              margin: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                top:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                              ),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'pemberitahuan.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  120,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  120),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12),
                                          CustomText(
                                              "DemoBigFleetsTransporterIndexPemberitahuan"
                                                  .tr, //Pemberitahuan.
                                              fontSize: 18,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12),
                                          CustomText(
                                              modul == 'BIGFLEET' &&
                                                      GlobalVariable.role == '2'
                                                  ? "DemoBigFleetsShipperIndexUntukMempermudah"
                                                      .tr
                                                  : modul == 'BIGFLEET' &&
                                                          GlobalVariable.role ==
                                                              '4'
                                                      ? "DemoBigFleetsTransporterIndexUntukMempermudah"
                                                          .tr
                                                      : modul == 'TRANSPORTMARKET' &&
                                                              GlobalVariable
                                                                      .role ==
                                                                  '2'
                                                          ? "DemoTransportMarketShipperIndexUntukMempermudah"
                                                              .tr
                                                          : "DemoTransportMarketTransporterIndexUntukMempermudah"
                                                              .tr, //Untuk mempermudah.
                                              fontSize: 12,
                                              height: 1.5,
                                              wrapSpace: true,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20),
                                          Container(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  180,
                                              child: Material(
                                                borderRadius: BorderRadius
                                                    .circular(GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        20),
                                                color:
                                                    Color(ListColor.colorBlue),
                                                child: InkWell(
                                                    customBorder:
                                                        RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              18),
                                                    ),
                                                    onTap: () async {
                                                      Get.back();
                                                      if (sisi == 'SHIPPER') {
                                                        popUpKapasitasPengiriman();
                                                      } else {
                                                        popUpJumlahArmada();
                                                      }
                                                    },
                                                    child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    20,
                                                            vertical:
                                                                GlobalVariable.ratioWidth(Get.context) *
                                                                    7),
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
                                                              'DemoBigFleetsTransporterIndexLanjutkan'
                                                                  .tr, // Lanjutkan di Aplikasi
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ))),
                                              )),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16)
                                        ]))
                                  ])))),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                        child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'ic_close_blue.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  color: Color(ListColor.color4),
                                ))),
                              ))))
                ],
              )));
        });
  }

  void popUpKapasitasPengiriman() async {
    kapasitasPengirimanController.value.clear();
    changePengiriman.value = "";
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 17.0),
                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 17.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 13,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 14),
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: 2.0,
                      color: Color(ListColor.colorLightGrey16)),
                  CustomText(
                      'DemoBigFleetsShipperIndexKapasitasPengiriman'
                          .tr, //Kapasitas Pengiriman
                      color: Color(ListColor.colorBlue),
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  CustomText(
                      'DemoBigFleetsShipperIndexSebelumMelanjutkanProsesRegistrasi'
                          .tr, //Sebelum melanjutkan Proses Registrasi sebagai Shipper mohon mengisi jumlah kapasitas pengiriman rata-rata Anda per hari
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.5,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
                  Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 228,
                      child: CustomTextFormField(
                          context: Get.context,
                          onChanged: (value) {
                            changePengiriman.value = value;
                          },
                          newContentPadding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                            right: GlobalVariable.ratioWidth(Get.context) * 17,
                            //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9\,]")),
                            DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 0,
                                controller: kapasitasPengirimanController.value)
                          ],
                          textSize: 14,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          newInputDecoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: Colors.white,
                            filled: true,
                            prefix: SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    17),
                            suffix: SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    17),
                            suffixIconConstraints:
                                BoxConstraints(minHeight: 0.0),
                            suffixIcon: Container(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 90,
                              child: CustomText(
                                  "DemoBigFleetsShipperIndexUnitTrukPerHari"
                                      .tr, //unit truk/hari
                                  fontWeight: FontWeight.w400,
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: 14),
                            ),
                            isDense: true,
                            isCollapsed: true,
                          ),
                          controller: kapasitasPengirimanController.value)),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
                  Obx(() => Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 90,
                      child: Material(
                        borderRadius: BorderRadius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        color: kapasitasPengirimanController.value.text != ""
                            ? Color(ListColor.colorBlue)
                            : Color(ListColor.colorStroke),
                        child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 18),
                            ),
                            onTap: () async {
                              if (kapasitasPengirimanController.value.text !=
                                  "") {
                                kirimKapasitas();
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: changePengiriman.value != ""
                                            ? Color(ListColor.colorBlue)
                                            : Color(ListColor.colorStroke)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20)),
                                child: Center(
                                  child: CustomText(
                                      'DemoBigFleetsShipperIndexKirim'
                                          .tr, // Kirim
                                      fontSize: 14,
                                      color: changePengiriman.value != ""
                                          ? Colors.white
                                          : Color(ListColor.colorLightGrey4),
                                      fontWeight: FontWeight.w600),
                                ))),
                      ))),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
                ],
              ),
            ));
  }

  void popUpJumlahArmada() async {
    jmlArmadaController.value.clear();
    changeJumlahArmada.value = "";
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 17.0),
                      topRight: Radius.circular(GlobalVariable.ratioWidth(Get.context) * 17.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 13,
                          bottom: GlobalVariable.ratioWidth(Get.context) * 14),
                      width: GlobalVariable.ratioWidth(Get.context) * 38,
                      height: 2.0,
                      color: Color(ListColor.colorLightGrey16)),
                  CustomText(
                      'DemoBigFleetsTransporterIndexJumlahArmada'
                          .tr, // Jumlah Armada
                      color: Color(ListColor.colorBlue),
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 15),
                  CustomText(
                      'DemoBigFleetsTransporterIndexSebelumMelanjutkanProsesRegistrasi'
                          .tr, //Sebelum melanjutkan Proses Registrasi sebagai Transporter mohon mengisi jumlah truk yang Anda miliki
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.5,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
                  Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 228,
                      child: CustomTextFormField(
                          onChanged: (value) {
                            changeJumlahArmada.value = value;
                            print(value);
                          },
                          context: Get.context,
                          newContentPadding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                            right: GlobalVariable.ratioWidth(Get.context) * 17,
                            //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9\,]")),
                            DecimalInputFormatter(
                                digit: 5,
                                digitAfterComma: 0,
                                controller: jmlArmadaController.value)
                          ],
                          textSize: 14,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          newInputDecoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: Colors.white,
                            filled: true,
                            prefix: SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    17),
                            suffix: SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    17),
                            suffixIconConstraints:
                                BoxConstraints(minHeight: 0.0),
                            suffixIcon: Container(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 60,
                              child: CustomText(
                                  "DemoBigFleetsTransporterIndexUnitTruk"
                                      .tr, // unit truk
                                  fontWeight: FontWeight.w400,
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: 14),
                            ),
                            isDense: true,
                            isCollapsed: true,
                          ),
                          controller: jmlArmadaController.value)),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 20),
                  Obx(() => Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 90,
                      child: Material(
                        borderRadius: BorderRadius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        color: jmlArmadaController.value.text != ""
                            ? Color(ListColor.colorBlue)
                            : Color(ListColor.colorStroke),
                        child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 18),
                            ),
                            onTap: () async {
                              if (jmlArmadaController.value.text != "") {
                                kirimArmada(modul);
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: changeJumlahArmada.value != ""
                                            ? Color(ListColor.colorBlue)
                                            : Color(ListColor.colorStroke)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20)),
                                child: Center(
                                  child: CustomText(
                                      'DemoBigFleetsTransporterIndexKirim'
                                          .tr, // Kirim
                                      fontSize: 14,
                                      color: changeJumlahArmada.value != ""
                                          ? Colors.white
                                          : Color(ListColor.colorLightGrey4),
                                      fontWeight: FontWeight.w600),
                                ))),
                      ))),
                  SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
                ],
              ),
            ));
  }

  void kirimKapasitas() {
    Get.back();

    simpanKapasitasPengiriman(
        GlobalVariable.formatDoubleDecimal(
            kapasitasPengirimanController.value.text),
        '0');
  }

  void kirimArmada(String modul) {
    Get.back();
    simpanJumlahArmada(
        GlobalVariable.formatDoubleDecimal(jmlArmadaController.value.text),
        '0');
  }

  void popUpPendingVerifikasiTransporter() {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        customTitle: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 32),
              Container(
                padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                child: CustomText(
                    "DemoBigFleetsTransporterIndexPengajuanVerifikasiTransporter"
                            .tr +
                        "\n" +
                        "DemoBigFleetsTransporterIndexSedangDiProses"
                            .tr, //Pengajuan Verifikasi Transporter\nSedang Diproses
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    color: Colors.black),
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_blue.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: Color(ListColor.color4)),
                      ))),
            ])),
        customMessage: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  "DemoBigFleetsTransporterIndexMohonMenunggu"
                      .tr, //Mohon menunggu sampai proses verifikasi oleh Admin muatmuat selesai. Periksa pemberitahuan secara berkala untuk mengetahui perkembangan pengajuan Anda.
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 193,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoBigFleetsTransporterIndexLihatPemberitahuan'
                                      .tr, // Lihat Pemberitahuan
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ))),
                  ))
            ]),
        isShowButton: false);
  }

  void popUpPendingVerifikasiShipper() {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        customTitle: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 32),
              Container(
                padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                child: CustomText(
                    "DemoBigFleetsShipperIndexPengajuanVerifikasiShipper".tr +
                        "\n" +
                        "DemoBigFleetsShipperIndexSedangDiProses"
                            .tr, //Pengajuan Verifikasi Shipper\nSedang Diproses
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    color: Colors.black),
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_blue.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: Color(ListColor.color4)),
                      ))),
            ])),
        customMessage: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  "DemoBigFleetsShipperIndexMohonMenunggu"
                      .tr, //Mohon menunggu sampai proses verifikasi oleh Admin muatmuat selesai. Periksa pemberitahuan secara berkala untuk mengetahui perkembangan pengajuan Anda.
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 193,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoBigFleetsShipperIndexLihatPemberitahuan'
                                      .tr, //Lihat Pemberitahuan
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ))),
                  ))
            ]),
        isShowButton: false);
  }

  void popUpBergabungMenjadiTransporter(String jenis) {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        customTitle: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 32),
              Container(
                padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                child: CustomText(
                    (jenis == 'BIGFLEET'
                        ? "DemoBigFleetsTransporterIndexBergabungMenjadiTransporter"
                                .tr +
                            "\n" +
                            "Big Fleets" //Bergabung Menjadi Transporter\nBig Fleets
                        : "DemoBigFleetsTransporterIndexBergabungMenjadiTransporter"
                                .tr +
                            "\n" +
                            "Transport Market"), //Bergabung Menjadi Transporter\nTransport Market),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    color: Colors.black),
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_blue.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: Color(ListColor.color4)),
                      ))),
            ])),
        customMessage: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  (jenis == 'BIGFLEET'
                      ? "DemoBigFleetsTransporterIndexAndaMerupakanIntermediat"
                          .tr //Anda merupakan intermediat yang memiliki sejumlah truk di atas batas ketentuan. Apakah Anda yakin untuk mendaftar sebagai Transporter Big Fleets?
                      : "DemoTransportMarketTransporterIndexAndaMerupakanIntermediat"
                          .tr), //Anda merupakan intermediat yang memiliki sejumlah truk di atas batas ketentuan. Apakah Anda yakin untuk mendaftar sebagai Transporter Transport Market?
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 230,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Color(ListColor.colorBlue),
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                          GetToPage.toNamed<LihatDokumenPersyaratanController>(
                              Routes.LIHAT_DOKUMEN_PERSYARATAN,
                              arguments: [modul, 'TRANSPORTER', 'TRANSPORTER']);
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoTransportMarketTransporterIndexLihatPersyaratanDanDokumenUppersum'
                                      .tr, //Lihat Persyaratan & Dokumen
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ))),
                  )),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 230,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Colors.white,
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                          popUpPemberitahuan();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 6),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoTransportMarketTransporterIndexYakinGabungSekarang'
                                      .tr, //Yakin, Gabung Sekarang
                                  fontSize: 14,
                                  color: Color(ListColor.colorBlue),
                                  fontWeight: FontWeight.w600),
                            ))),
                  ))
            ]),
        isShowButton: false);
  }

  void popUpBergabungMenjadiShipper(String modul) {
    GlobalAlertDialog.showAlertDialogCustom(
        context: Get.context,
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        customTitle: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 32),
              Container(
                padding: EdgeInsets.only(
                  top: GlobalVariable.ratioWidth(Get.context) * 20,
                ),
                child: CustomText(
                    (modul == 'BIGFLEET'
                        ? "DemoBigFleetsShipperIndexBergabungMenjadiShipper"
                                .tr +
                            "\n" +
                            "Big Fleets" //"Bergabung Menjadi Shipper\nBig Fleets
                        : "DemoTransportMarketShipperIndexBergabungMenjadiShipper"
                                .tr +
                            "\n" +
                            "Transport Market"), //"Bergabung Menjadi Shipper\nTransport Market
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                    color: Colors.black),
              ),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioWidth(Get.context) * 8,
                          right: GlobalVariable.ratioWidth(Get.context) * 8),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + 'ic_close_blue.svg',
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height: GlobalVariable.ratioWidth(Get.context) * 24,
                            color: Color(ListColor.color4)),
                      ))),
            ])),
        customMessage: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  (modul == 'BIGFLEET'
                      ? "DemoBigFleetsShipperIndexAndaMerupakanIntermediat"
                          .tr //Anda merupakan intermediat yang harus memiliki kapasitas pengiriman per hari di atas batas minimum ketentuan. Apakah Anda yakin untuk mendaftar Shipper Big Fleets?
                      : "DemoTransportMarketShipperIndexAndaMerupakanIntermediat"
                          .tr //Anda merupakan intermediat yang harus memiliki kapasitas pengiriman per hari di atas batas minimum ketentuan. Apakah Anda yakin untuk mendaftar Shipper Transport Market?),
                  ),
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              modul == 'TRANSPORTMARKET'
                  ? Container(
                      width: GlobalVariable.ratioWidth(Get.context) * 230,
                      child: Material(
                        borderRadius: BorderRadius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 20),
                        color: Color(ListColor.colorBlue),
                        child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 18),
                            ),
                            onTap: () async {
                              Get.back();
                              GetToPage.toNamed<
                                      LihatDokumenPersyaratanController>(
                                  Routes.LIHAT_DOKUMEN_PERSYARATAN,
                                  arguments: [modul, 'SHIPPER', 'SHIPPER']);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            7),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(ListColor.colorBlue)),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20)),
                                child: Center(
                                  child: CustomText(
                                      'DemoTransportMarketShipperIndexLihatPersyaratanDanDokumenUppersum'
                                          .tr, //Lihat Persyaratan & Dokumen
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ))),
                      ))
                  : SizedBox(),
              modul == 'TRANSPORTMARKET'
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 12)
                  : SizedBox(),
              Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 230,
                  child: Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Colors.white,
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: () async {
                          Get.back();
                          popUpPemberitahuan();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 6),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(ListColor.colorBlue)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'DemoTransportMarketTransporterIndexYakinGabungSekarang'
                                      .tr, //Yakin, Gabung Sekarang
                                  fontSize: 14,
                                  color: Color(ListColor.colorBlue),
                                  fontWeight: FontWeight.w600),
                            ))),
                  ))
            ]),
        isShowButton: false);
  }

  void popUpKapasitasAndaMemenuhiKetentuanBigFleets(String qty, String sisi) {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 32),
                          Expanded(
                            // margin: EdgeInsets.only(
                            //   top: GlobalVariable.ratioWidth(Get.context) *
                            //       24,
                            // ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              "DemoTransportMarketTransporterIndexKapasitasMemenuhi".tr +
                                                  "\n" +
                                                  "DemoTransportMarketTransporterIndexKetentuan"
                                                      .tr +
                                                  " Big Fleets"
                                                      .tr, //Kapasitas Anda memenuhi\nketentuan Big Fleets
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              height: 1.2,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    (sisi == 'SHIPPER'
                                                        ? "DemoTransportMarketShipperIndexApakahAndaYakin"
                                                            .tr //Apakah Anda yakin untuk melanjutkan pendaftaran sebagai Shipper Transport Market?
                                                        : "DemoTransportMarketTransporterIndexApakahAndaYakin"
                                                            .tr //Apakah Anda yakin untuk melanjutkan pendaftaran sebagai Transporter Transport Market?
                                                    ),
                                                    fontSize: 12,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.5,
                                                    color: Colors.black),
                                                SizedBox(
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        24),
                                                Container(
                                                    width: (sisi == 'SHIPPER'
                                                        ? GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            205
                                                        : GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            220),
                                                    child: Material(
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              20),
                                                      color: Color(
                                                          ListColor.colorBlue),
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
                                                            Get.back();
                                                            if (sisi ==
                                                                'SHIPPER') {
                                                              simpanKapasitasPengiriman(
                                                                  qty, '1');
                                                            } else if (sisi ==
                                                                'TRANSPORTER') {
                                                              simpanJumlahArmada(
                                                                  qty, '1');
                                                            }
                                                            // Get.back();
                                                            // Get.back();
                                                            // showDialog(
                                                            //     context:
                                                            //         Get.context,
                                                            //     barrierDismissible:
                                                            //         true,
                                                            //     builder:
                                                            //         (BuildContext
                                                            //             context) {
                                                            //       return Center(
                                                            //           child:
                                                            //               CircularProgressIndicator());
                                                            //     });
                                                            // var dataUser =
                                                            //     await GlobalVariable
                                                            //         .getStatusUser(
                                                            //             Get.context);

                                                            // Get.back();
                                                            // if (sisi ==
                                                            //     "SHIPPER") {
                                                            //   if ((dataUser[
                                                            //               'UserLevel'] ??
                                                            //           0) !=
                                                            //       1) {
                                                            //     Get.toNamed(Routes
                                                            //         .BIGFLEETS2);
                                                            //   } else {
                                                            //     Get.toNamed(
                                                            //         Routes
                                                            //             .SELAMAT_DATANG,
                                                            //         arguments: [
                                                            //           'BIGFLEET',
                                                            //           (GlobalVariable.role ==
                                                            //                   "2"
                                                            //               ? "SHIPPER"
                                                            //               : "TRANSPORTER")
                                                            //         ]);
                                                            //   }
                                                            // } else if (sisi ==
                                                            //     "TRANSPORTER") {
                                                            //   if ((dataUser[
                                                            //               'UserLevel'] ??
                                                            //           0) !=
                                                            //       1) {
                                                            //     Get.toNamed(Routes
                                                            //         .BIGFLEETS2);
                                                            //   } else {
                                                            //     Get.toNamed(
                                                            //         Routes
                                                            //             .SELAMAT_DATANG,
                                                            //         arguments: [
                                                            //           'BIGFLEET',
                                                            //           (GlobalVariable.role ==
                                                            //                   "2"
                                                            //               ? "SHIPPER"
                                                            //               : "TRANSPORTER")
                                                            //         ]);
                                                            //   }
                                                            // }
                                                          },
                                                          child: Container(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          12,
                                                                  vertical:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          7),
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
                                                                    (sisi == 'SHIPPER'
                                                                        ? 'DemoTransportMarketShipperIndexDaftarShipperBigFleets'.tr //Daftar Shipper Big Fleets
                                                                        : 'DemoTransportMarketTransporterIndexDaftarTransporterBigFleets'.tr), //Daftar Transporter Big Fleets
                                                                    fontSize: 14,
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600),
                                                              ))),
                                                    )),
                                                SizedBox(
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        12),
                                                Container(
                                                    width: (sisi == 'SHIPPER'
                                                        ? GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            205
                                                        : GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            220),
                                                    child: Material(
                                                      borderRadius: BorderRadius
                                                          .circular(GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              20),
                                                      color: Colors.white,
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
                                                            Get.back();

                                                            if (sisi ==
                                                                'SHIPPER') {
                                                              Get.back();
                                                              if(modul == 'BIGFLEET'){
                                                                GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.BF);
                                                              } else {
                                                                GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.TM);
                                                              }
                                                              // CustomToast.show(context: Get.context, message: "test 1");
                                                              // Get.toNamed(Routes
                                                              //     .SHIPPER_BUYER_REGISTER);
                                                            } else {
                                                              GlobalAlertDialog.showAlertDialogCustom(
                                                                  paddingLeft:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          16,
                                                                  paddingRight:
                                                                      GlobalVariable.ratioWidth(Get.context) *
                                                                          16,
                                                                  context: Get
                                                                      .context,
                                                                  title: "",
                                                                  customMessage: CustomText(
                                                                      "Internal AZ Halaman form Informasi Truk Bigfleet"
                                                                          .tr,
                                                                      fontSize:
                                                                          12,
                                                                      height:
                                                                          1.5,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .black),
                                                                  isShowButton:
                                                                      false);
                                                            }
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
                                                                    'DemoTransportMarketTransporterIndexLanjutkan'
                                                                        .tr, //Lanjutkan
                                                                    fontSize:
                                                                        14,
                                                                    color: Color(
                                                                        ListColor
                                                                            .colorBlue),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ))),
                                                    ))
                                              ]),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24)
                                        ])),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                    child: GestureDetector(
                                        child: SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      'ic_close_blue.svg',
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          24,
                                  color: Color(ListColor.color4),
                                ))),
                              ))
                        ],
                      )))));
        });
  }

  void simpanJumlahArmada(String qty, String force) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        });
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .setJumlahArmada(qty, modul, force);
    print(result);
    if (result['Message']['Code'].toString() == '200') {
      Get.back();

      GlobalAlertDialog.showAlertDialogCustom(
          paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
          paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
          context: Get.context,
          title: "",
          customMessage: CustomText(
              "Internal AZ Halaman form Informasi Truk Bigfleet".tr,
              fontSize: 12,
              height: 1.5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              color: Colors.black),
          isShowButton: false);
    } else if (result['Message']['Code'].toString() == '500' &&
        result['Data'].toString() != '') {
      Get.back();

      if (result['Data']['ValidateResult'].toString() == "1") {
        popUpKapasitasAndaMemenuhiKetentuanBigFleets(qty, sisi);
      } else if (result['Data']['ValidateResult'].toString() == "-1") {
        showDialog(
            context: Get.context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return Dialog(
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
                  child: Container(
                      child: Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                              child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          32),
                              Expanded(
                                // margin: EdgeInsets.only(
                                //   top: GlobalVariable.ratioWidth(Get.context) *
                                //       24,
                                // ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20,
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                  modul == 'TRANSPORTMARKET'
                                                      ? "DemoTransportMarketTransporterIndexMohonMaaf"
                                                          .tr //Mohon maaf, jumlah truk yang Anda miliki kurang dari ketentuan Transport Market
                                                      : "DemoBigFleetsTransporterIndexMohonMaaf"
                                                          .tr, //Mohon maaf, jumlah truk yang Anda miliki kurang dari ketentuan Transporter Big Fleets. Jangan khawatir, Anda dapat menikmati layanan Transport Market.
                                                  fontSize: 12,
                                                  textAlign: TextAlign.center,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.5,
                                                  color: Colors.black),
                                              SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      24),
                                              modul == 'TRANSPORTMARKET'
                                                  ? Container(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          215,
                                                      child: Material(
                                                        borderRadius: BorderRadius
                                                            .circular(GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20),
                                                        color: Colors.white,
                                                        child: InkWell(
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          18),
                                                            ),
                                                            onTap: () async {
                                                              Get.back();
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                    vertical:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            7),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Color(ListColor
                                                                            .colorBlue)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                            20)),
                                                                child: Center(
                                                                  child: CustomText(
                                                                      'DemoTransportMarketTransporterIndexKembaliKeTransportMarket'
                                                                          .tr, //Kembali ke Transport Market
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          ListColor
                                                                              .colorBlue),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ))),
                                                      ))
                                                  : Container(
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          180,
                                                      child: Material(
                                                        borderRadius: BorderRadius
                                                            .circular(GlobalVariable
                                                                    .ratioWidth(
                                                                        Get.context) *
                                                                20),
                                                        color: Color(ListColor
                                                            .colorBlue),
                                                        child: InkWell(
                                                            customBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      GlobalVariable.ratioWidth(
                                                                              Get.context) *
                                                                          18),
                                                            ),
                                                            onTap: () async {
                                                              Get.back();
                                                              Get.back();
                                                              Get.back();
                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  () {
                                                                Get.toNamed(
                                                                    Routes
                                                                        .SELAMAT_DATANG,
                                                                    arguments: [
                                                                      'TRANSPORTMARKET',
                                                                      'TRANSPORTER'
                                                                    ]);
                                                              });
                                                            },
                                                            child: Container(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            12,
                                                                    vertical:
                                                                        GlobalVariable.ratioWidth(Get.context) *
                                                                            7),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Color(ListColor
                                                                            .colorBlue)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) *
                                                                            20)),
                                                                child: Center(
                                                                  child: CustomText(
                                                                      'DemoBigFleetsTransporterIndexLihatTransportMarket'
                                                                          .tr, //Lihat Transport Market
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ))),
                                                      )),
                                              SizedBox(
                                                  height: GlobalVariable
                                                          .ratioWidth(
                                                              Get.context) *
                                                      24)
                                            ])),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        child: GestureDetector(
                                            child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          'ic_close_blue.svg',
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      color: Color(ListColor.color4),
                                    ))),
                                  ))
                            ],
                          )))));
            });
      }
    }
  }

  void simpanKapasitasPengiriman(String qty, String force) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        });
    var result = await ApiHelper(
            context: Get.context,
            isShowDialogLoading: false,
            isShowDialogError: false)
        .setKapasitasPengiriman(qty, modul, force);
    var data = await GlobalVariable.getStatusUser(Get.context);
    print(result);
    if (result['Message']['Code'].toString() == '200') {
      Get.back();
      if(modul == 'BIGFLEET'){
        GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.BF);
      } else {
        print("tm");
        if(force == "1") {
          Get.back();
          Get.back();
          Future.delayed(
              const Duration(
                  milliseconds:
                      500), () {
            Get.toNamed(
                Routes
                    .SELAMAT_DATANG,
                arguments: [
                  'BIGFLEET',
                  'SHIPPER'
                ]);
          });
        } else {
          GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.TM);
        }
        // GetToPage.toNamed<RegisterShipperBfTmController>(Routes.REGISTER_SHIPPER_BF_TM, arguments: TipeModul.TM);
      }
      // CustomToast.show(context: Get.context, message: "test 2");
      // Get.toNamed(Routes.SHIPPER_BUYER_REGISTER);
    } else if (result['Message']['Code'].toString() == '500') {
      Get.back();
      if (result['Data']['ValidateResult'].toString() == "1") {
        popUpKapasitasAndaMemenuhiKetentuanBigFleets(qty, sisi);
      } else if (result['Data']['ValidateResult'].toString() == "-1") {
        showDialog(
            context: Get.context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return Dialog(
                  backgroundColor: Colors.white,
                  insetPadding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
                  child: Container(
                      padding: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                      child: Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            32),
                                Expanded(
                                    // margin: EdgeInsets.only(
                                    //   top: GlobalVariable.ratioWidth(Get.context) *
                                    //       24,
                                    // ),
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            20,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              modul == 'TRANSPORTMARKET'
                                                  ? "DemoTransportMarketShipperIndexMohonMaaf"
                                                      .tr //Mohon maaf, jumlah pengiriman yang Anda miliki kurang dari ketentuan Transport Market
                                                  : "DemoBigFleetsShipperIndexMohonMaaf"
                                                      .tr, //Mohon maaf, jumlah kapasitas pengiriman rata - rata perhari Anda tidak mencapai batas minimum Big Fleets Shipper. Jangan khawatir, Anda dapat menikmati layanan Transport Market
                                              fontSize: 12,
                                              textAlign: TextAlign.center,
                                              fontWeight:
                                                  (modul == 'TRANSPORTMARKET'
                                                      ? FontWeight.w600
                                                      : FontWeight.w500),
                                              height: 1.5,
                                              color: Colors.black),
                                          SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24),
                                          modul == 'TRANSPORTMARKET'
                                              ? Container(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          215,
                                                  child: Material(
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    color: Colors.white,
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
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        12,
                                                                vertical:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        7),
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
                                                                  'DemoTransportMarketTransporterIndexKembaliKeTransportMarket'
                                                                      .tr, //Kembali ke Transport Market
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      ListColor
                                                                          .colorBlue),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))),
                                                  ))
                                              : Container(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          200,
                                                  child: Material(
                                                    borderRadius: BorderRadius
                                                        .circular(GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            20),
                                                    color: Color(
                                                        ListColor.colorBlue),
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
                                                          if (data['ShipperIsVerifTM'] == 1) {
                                                            Get.toNamed(Routes.TRANSPORT_MARKET);
                                                          } else {
                                                          Get.back();
                                                          Get.back();
                                                          Get.back();
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      500), () {
                                                            Get.toNamed(
                                                                Routes
                                                                    .SELAMAT_DATANG,
                                                                arguments: [
                                                                  'TRANSPORTMARKET',
                                                                  'SHIPPER'
                                                                ]);
                                                          });
                                                          }
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        24,
                                                                vertical:
                                                                    GlobalVariable.ratioWidth(Get.context) *
                                                                        7),
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
                                                                  'DemoBigFleetsTransporterIndexLihatTransportMarket'
                                                                      .tr, //Lihat Transport Market
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ))),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                                Container(
                                    margin: EdgeInsets.only(
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8,
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          8,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                          child: GestureDetector(
                                              child: SvgPicture.asset(
                                        GlobalVariable.imagePath +
                                            'ic_close_blue.svg',
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                        color: Color(ListColor.color4),
                                      ))),
                                    ))
                              ])))));
            });
      }
    }
  }

  void popUpIndividu(modul, sisi) async {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: GlobalVariable.ratioWidth(Get.context) * 24),
                  child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    32),
                            Expanded(
                                // margin: EdgeInsets.only(
                                //   top: GlobalVariable.ratioWidth(Get.context) *
                                //       24,
                                // ),
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          modul == 'TRANSPORTMARKET' &&
                                                  sisi == 'SHIPPER'
                                              ? "DemoTransportMarketShipperIndexJenisAkunAnda"
                                                  .tr //Jenis Akun Anda Adalah Individu
                                              : modul == 'TRANSPORTMARKET' &&
                                                      sisi == 'TRANSPORTER'
                                                  ? "DemoTransportMarketTransporterIndexJenisAkunAnda"
                                                      .tr
                                                  : modul == 'BIGFLEET' &&
                                                          sisi == 'SHIPPER'
                                                      ? "DemoBigFleetsShipperIndexJenisAkunAnda"
                                                          .tr
                                                      : "DemoBigFleetsTransporterIndexJenisAkunAnda"
                                                          .tr,
                                          fontSize: 16,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12),
                                      CustomText(
                                          modul == 'TRANSPORTMARKET' &&
                                                  sisi == 'SHIPPER'
                                              ? "DemoTransportMarketShipperIndexMohonMaafAkunIndividu"
                                                  .tr //Mohon maaf untuk mendaftar bigfleet
                                              : modul == 'TRANSPORTMARKET' &&
                                                      sisi == 'TRANSPORTER'
                                                  ? "DemoTransportMarketTransporterIndexMohonMaafAkunIndividu"
                                                      .tr
                                                  : modul == 'BIGFLEET' &&
                                                          sisi == 'SHIPPER'
                                                      ? "DemoBigFleetsShipperIndexMohonMaafAkunIndividu"
                                                          .tr
                                                      : "DemoBigFleetsTransporterIndexMohonMaafAkunIndividu"
                                                          .tr,
                                          fontSize: 12,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                            Container(
                                margin: EdgeInsets.only(
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          8,
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      8,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      child: GestureDetector(
                                          child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        'ic_close_blue.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    color: Color(ListColor.color4),
                                  ))),
                                ))
                          ])))));
        });
  }

  void popUpInternal() async {
    GlobalAlertDialog.showAlertDialogCustom(
        paddingLeft: GlobalVariable.ratioWidth(Get.context) * 16,
        paddingRight: GlobalVariable.ratioWidth(Get.context) * 16,
        context: Get.context,
        title: "",
        customMessage: CustomText("Internal AZ Halaman form ".tr,
            fontSize: 12,
            height: 1.5,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            color: Colors.black),
        isShowButton: false);
  }
}
