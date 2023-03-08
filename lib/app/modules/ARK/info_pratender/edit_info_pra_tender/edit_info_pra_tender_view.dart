import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/info_pratender/edit_info_pra_tender/edit_info_pra_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_rute_tender/select_rute_tender_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/select_transporter_mitra_tender/select_transporter_mitra_tender_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/radio_button_custom_with_text_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/text_form_field_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:latlong/latlong.dart';

class EditInfoPraTenderView extends GetView<EditInfoPraTenderController> {
  AppBar _appBar = AppBar(
    title: Text('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: onWillPop,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: Color(ListColor.colorBlue),
                statusBarIconBrightness: Brightness.light),
            child: SafeArea(
                child: Scaffold(
              appBar: AppBar(
                toolbarHeight: GlobalVariable.ratioWidth(Get.context) * 110,
                backgroundColor: GlobalVariable.appsMainColor,
                leadingWidth:
                    GlobalVariable.ratioWidth(Get.context) * (24 + 16),
                leading: Container(
                    padding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                    ),
                    child: GestureDetector(
                        onTap: () {
                          onWillPop();
                          //Get.back();
                        },
                        child: SvgPicture.asset(
                            GlobalVariable.imagePath + "ic_back_button.svg",
                            color:
                                GlobalVariable.tabDetailAcessoriesMainColor))),
                titleSpacing: GlobalVariable.ratioWidth(Get.context) * 8,
                title: Obx(() => controller.slideIndex.value > 0
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            margin: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 8,
                                bottom:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    "InfoPraTenderDetailLabelNomorPraTender"
                                        .tr, // Nomor Pra Tender
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: GlobalVariable
                                        .tabDetailAcessoriesMainColor),
                                CustomText(controller.kodePraTender.value,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: GlobalVariable
                                        .tabDetailAcessoriesMainColor)
                              ],
                            )))
                    : CustomText(
                        "InfoPraTenderEditJudulEdit"
                            .tr, //"Edit Info Pra Tender".tr,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: GlobalVariable.tabDetailAcessoriesMainColor)),
                elevation: 10.0,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                      GlobalVariable.ratioWidth(Get.context) * 55),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 16,
                    ),
                    height: GlobalVariable.ratioWidth(Get.context) * 55,
                    //color: Color(ListColor.color4),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 0.5,
                            child: Container(
                                color: Color(ListColor.colorLightBlue5))),
                        Expanded(
                          child: Container(
                              child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                child: Obx(() => CustomText(
                                    controller.title.value.tr,
                                    color: GlobalVariable
                                        .tabDetailAcessoriesMainColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                              )),
                              Obx(() => !controller.isLoading.value
                                  ? Obx(
                                      () => Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  (controller.satuanTender
                                                              .value ==
                                                          2
                                                      ? 5
                                                      : 4);
                                              i++)
                                            _buildPageIndicator(
                                                i ==
                                                    controller.slideIndex.value,
                                                i)
                                        ],
                                      ),
                                    )
                                  : SizedBox())
                            ],
                          )),
                        ),
                      ],
                    ),
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
                  padding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 11,
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 22),
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Obx(() => Opacity(
                            opacity: controller.slideIndex == 0 ? 0 : 1,
                            child: MaterialButton(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20)),
                                  side:
                                      BorderSide(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              1,
                                          color: Color(ListColor.color4))),
                              onPressed: !controller.isLoading.value
                                  ? () {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();
                                      if (controller.slideIndex.value != 0) {
                                        controller.slideIndex.value--;
                                        controller.pageController.animateToPage(
                                            controller.slideIndex.value,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.linear);
                                      }
                                    }
                                  : null,
                              child: CustomText(
                                "InfoPraTenderCreateLabelButtonSebelumnya"
                                    .tr, //Sebelumnya
                                color: Color(ListColor.color4),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 12),
                    Expanded(
                        flex: 1,
                        child: Obx(() => MaterialButton(
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20))),
                              color: Color(ListColor.color4),
                              onPressed: !controller.isLoading.value
                                  ? () {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();
                                      save();
                                    }
                                  : null,
                              child: controller.satuanTender.value == 2
                                  ? Obx(() => CustomText(
                                        controller.slideIndex.value == 4
                                            ? "InfoPraTenderCreateLabelButtonSimpan"
                                                .tr //Simpan
                                            : "InfoPraTenderCreateLabelSelanjutnya"
                                                .tr, // Selanjutnya
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ))
                                  : Obx(() => CustomText(
                                        controller.slideIndex.value == 3
                                            ? "InfoPraTenderCreateLabelButtonSimpan"
                                                .tr //Simpan
                                            : "InfoPraTenderCreateLabelSelanjutnya"
                                                .tr, // Selanjutnya
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      )),
                            ))),
                  ])),
              body: Container(
                  color: Color(ListColor.colorBackgroundTender),
                  child: Obx(() => !controller.isLoading.value
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: Obx(
                              () => PageView(
                                physics: NeverScrollableScrollPhysics(),
                                onPageChanged: (index) {
                                  controller.slideIndex.value = index;
                                  controller.updateTitle();
                                },
                                controller: controller.pageController,
                                children: controller.satuanTender.value == 2
                                    ? controller.tipeEdit == "SEBELUM"
                                        ? [
                                            firstSebelumPraTenderPage(context),
                                            secondSebelumPraTenderPage(context),
                                            thirdSebelumPraTenderPage(context),
                                            fourthSebelumPraTenderPage(context),
                                            fifthSebelumPraTenderPage(context),
                                          ]
                                        : [
                                            firstPraTenderPage(context),
                                            secondPraTenderPage(context),
                                            thirdPraTenderPage(context),
                                            fourthPraTenderPage(context),
                                            fifthPraTenderPage(context),
                                          ]
                                    : controller.tipeEdit == "SEBELUM"
                                        ? [
                                            firstSebelumPraTenderPage(context),
                                            secondSebelumPraTenderPage(context),
                                            fourthSebelumPraTenderPage(context),
                                            fifthSebelumPraTenderPage(context),
                                          ]
                                        : [
                                            firstPraTenderPage(context),
                                            secondPraTenderPage(context),
                                            fourthPraTenderPage(context),
                                            fifthPraTenderPage(context),
                                          ],
                              ),
                            )),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ))),
            ))));
  }

  Widget _buildPageIndicator(bool isCurrentPage, int index) {
    int saveIndex = 0;
    if (controller.satuanTender.value == 2) {
      saveIndex = 4;
    } else {
      saveIndex = 3;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: GlobalVariable.ratioWidth(Get.context) * 10,
            backgroundColor: GlobalVariable.tabDetailBorderPageIndicatorColor,
            child: CircleAvatar(
                radius: GlobalVariable.ratioWidth(Get.context) * 8,
                backgroundColor: isCurrentPage
                    ? GlobalVariable
                        .tabDetailBackgroundPageIndicatorCurrentColor
                    : GlobalVariable.appsMainColor,
                child: CustomText(
                  (index + 1).toString(),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: isCurrentPage
                      ? GlobalVariable.appsMainColor
                      : GlobalVariable.tabDetailAcessoriesMainColor,
                ))),
        index == saveIndex
            ? SizedBox.shrink()
            : Container(
                height: GlobalVariable.ratioWidth(Get.context) * 2,
                width: GlobalVariable.ratioWidth(Get.context) * 8,
                color: GlobalVariable.tabDetailBorderPageIndicatorColor)
      ],
    );
  }

  Widget firstSebelumPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formOne,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 20,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  "InfoPraTenderCreateLabelNomorPraTender"
                      .tr, //"Nomor Pra Tender".tr,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(
                controller.kodePraTender.value.tr,
                color: Color(ListColor.colorAutoGenerate),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderDetailLabelTanggalDibuat".tr, // Tanggal Dibuat
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(
                controller.tanggalDibuat.value,
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderCreateLabelDiumumkanKepada".tr +
                      "*", // Diumumkan Kepada
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              controller.dataSelectedTampil.value.length > 0
                  ? SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 2)
                  : SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 8),
              controller.dataSelectedTampil.value.length > 0
                  ? Obx(() => Column(
                        children: [
                          Wrap(
                            children: [
                              for (var index = 0;
                                  index <
                                      (controller.dataSelectedTampil.value
                                                  .length >
                                              6
                                          ? 6
                                          : controller
                                              .dataSelectedTampil.value.length);
                                  index++)
                                controller.selectedTransporterWidget(
                                    controller.dataSelectedTampil[index], index)
                            ],
                          ),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 9),
                        ],
                      ))
                  : SizedBox(),
              Material(
                borderRadius: BorderRadius.circular(
                    GlobalVariable.ratioWidth(Get.context) * 20),
                color: Color(ListColor.colorBlue),
                child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 18),
                    ),
                    onTap: () async {
                      FocusManager.instance.primaryFocus.unfocus();
                      var data = await GetToPage.toNamed<
                              SelectTransporterMitraTenderController>(
                          Routes.SELECT_TRANSPORTER_MITRA_TENDER,
                          arguments: [
                            controller.dataAll,
                            controller.dataGroup,
                            controller.dataMitraTransporter,
                            controller.dataEmail
                          ]);
                      print(data);
                      if (data != null) {
                        controller.dataAll.value = data[0];
                        controller.dataGroup.value = data[1];
                        controller.dataMitraTransporter.value = data[2];
                        controller.dataEmail.value = data[3];

                        controller.collectData();
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: controller
                                        .dataSelectedTampil.value.length >
                                    0
                                ? GlobalVariable.ratioWidth(Get.context) * 24
                                : GlobalVariable.ratioWidth(Get.context) * 12,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 20)),
                        child: Obx(() => CustomText(
                            controller.dataSelectedTampil.value.length > 0
                                ? 'InfoPraTenderCreateLabelGanti'.tr // Ganti
                                : 'InfoPraTenderCreateLabelButtonPilihTransporterMitra' //Pilih Transporter / Mitra
                                    .tr,
                            fontSize: 12,
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600)))),
              ),
              controller.errorFirstPage.value != ""
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 4),
                        Row(
                          children: [
                            Expanded(
                                child: Obx(() => CustomText(
                                      controller.errorFirstPage.value.tr,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      height: 1.2,
                                      color: Color(ListColor.colorRed),
                                    ))),
                            SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 74)
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText("InfoPraTenderCreateLabelJudul".tr + "*", // Judul
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
              CustomTextFormField(
                context: Get.context,
                newContentPadding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                  //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                ),
                textSize: 14,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorLightGrey4),
                ),
                newInputDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  isDense: true,
                  isCollapsed: true,
                  hintText: "InfoPraTenderCreateLabelJudulPraTender"
                      .tr, //Judul Pra Tender
                  hintStyle: TextStyle(
                    color: Color(ListColor.colorLightGrey2),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                controller: controller.judulController,
                validator: (value) {
                  if (value.isEmpty ||
                      value == "" ||
                      !controller.validasiSimpan) {
                    controller.validasiSimpan = false;
                    return "InfoPraTenderCreateLabelAlertJudul"
                        .tr; // Judul Harus Diisi
                  }
                  return null;
                },
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderCreateLabelTahapPraTender".tr, // Tahap Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
              //DETAIL TAHAP TENDER
              for (var index = 0;
                  index < controller.dataTahapTender.length;
                  index++)
                controller.listTahapTenderWidget(index),
              //DETAIL TAHAP TENDER
              CustomText(
                  "InfoPraTenderCreateLabelSatuanTender".tr, // Satuan Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 11),
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus.unfocus();
                  print(2);
                  controller.satuanTender.value = 2;

                  controller.ubahSatuanTender();
                },
                child: AbsorbPointer(
                    child: RadioButtonCustomWithText(
                        isWithShadow: true,
                        toggleable: false,
                        isDense: true,
                        colorNotSelected: Colors.white,
                        radioSize: GlobalVariable.ratioWidth(Get.context) * 14,
                        groupValue: controller.satuanTender.value.toString(),
                        value: 2.toString(),
                        onChanged: (str) {
                          FocusManager.instance.primaryFocus.unfocus();
                          print(str);
                          controller.satuanTender.value = int.parse(str);

                          controller.ubahSatuanTender();
                        },
                        customTextWidget: Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 3),
                            child: CustomText(
                                "InfoPraTenderCreateLabelUnitTruk"
                                    .tr, // Unit Truk
                                color: Color(ListColor.colorDarkGrey4),
                                fontWeight: FontWeight.w600,
                                fontSize: 14)))),
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 14),
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus.unfocus();
                  print(1);
                  controller.satuanTender.value = 1;

                  controller.ubahSatuanTender();
                },
                child: AbsorbPointer(
                    child: RadioButtonCustomWithText(
                        isWithShadow: true,
                        toggleable: false,
                        isDense: true,
                        colorNotSelected: Colors.white,
                        radioSize: GlobalVariable.ratioWidth(Get.context) * 14,
                        groupValue: controller.satuanTender.value.toString(),
                        value: 1.toString(),
                        onChanged: (str) {
                          FocusManager.instance.primaryFocus.unfocus();
                          print(str);
                          controller.satuanTender.value = int.parse(str);

                          controller.ubahSatuanTender();
                        },
                        customTextWidget: Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 3),
                            child: CustomText(
                                "InfoPraTenderCreateLabelBerat".tr, // Berat
                                color: Color(ListColor.colorDarkGrey4),
                                fontWeight: FontWeight.w600,
                                fontSize: 14)))),
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 14),
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus.unfocus();
                  print(3);
                  controller.satuanTender.value = 3;

                  controller.ubahSatuanTender();
                },
                child: AbsorbPointer(
                    child: RadioButtonCustomWithText(
                        isWithShadow: true,
                        toggleable: false,
                        isDense: true,
                        colorNotSelected: Colors.white,
                        radioSize: GlobalVariable.ratioWidth(Get.context) * 14,
                        groupValue: controller.satuanTender.value.toString(),
                        value: 3.toString(),
                        onChanged: (str) {
                          FocusManager.instance.primaryFocus.unfocus();
                          print(str);
                          controller.satuanTender.value = int.parse(str);

                          controller.ubahSatuanTender();
                        },
                        customTextWidget: Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 3),
                            child: CustomText(
                                "InfoPraTenderCreateLabelVolume".tr, //Volume
                                color: Color(ListColor.colorDarkGrey4),
                                fontWeight: FontWeight.w600,
                                fontSize: 14)))),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget firstPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formOne,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 20,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  "InfoPraTenderDetailLabelNomorPraTender"
                      .tr, // Nomor Pra Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(
                controller.kodePraTender.value,
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderDetailLabelTanggalDibuat".tr, // Tanggal Dibuat
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(
                controller.tanggalDibuat.value,
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderDetailLabelDiumumkanKepada"
                      .tr, // Diumumkan Kepada
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              controller.dataSelectedTampil.value.length > 0
                  ? SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 2)
                  : SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 8),
              controller.dataSelectedTampil.value.length > 0
                  ? Obx(() => Column(
                        children: [
                          Wrap(
                            children: [
                              for (var index = 0;
                                  index <
                                      (controller.dataSelectedTampil.value
                                                  .length >
                                              6
                                          ? 6
                                          : controller
                                              .dataSelectedTampil.value.length);
                                  index++)
                                controller.selectedTransporterWidget(
                                    controller.dataSelectedTampil[index], index)
                            ],
                          ),
                        ],
                      ))
                  : SizedBox(),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText("InfoPraTenderDetailLabelJudul".tr, //Judul
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(controller.judulPraTender.value,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderDetailLabelTahapTender".tr, // Tahap Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 14),
              //DETAIL TAHAP TENDER
              for (var index = 0;
                  index < controller.dataTahapTender.length;
                  index++)
                controller.listTahapTenderWidget(index),
              //DETAIL TAHAP TENDER
              CustomText(
                  "InfoPraTenderDetailLabelSatuanTender".tr, // Satuan Tender
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),

              CustomText(controller.namaSatuanTender.value,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black),
            ],
          ),
        ),
      ),
    ));
  }

  Widget secondSebelumPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formTwo,
      child: Container(
          margin: EdgeInsets.symmetric(
              vertical: GlobalVariable.ratioWidth(Get.context) * 20,
              horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText("InfoPraTenderCreateLabelMuatan".tr + "*", // Muatan
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomTextFormField(
                context: Get.context,
                newContentPadding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                  //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                ),
                textSize: 14,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorLightGrey4),
                ),
                newInputDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  isDense: true,
                  isCollapsed: true,
                  hintText:
                      "InfoPraTenderCreateLabelPlaceholderMasukkanNamaMuatan"
                          .tr, //Masukan nama muatan
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey2),
                  ),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[A-Za-z \(\)]")),
                ],
                controller: controller.muatanController,
                validator: (value) {
                  if (value.isEmpty ||
                      value == "" ||
                      !controller.validasiSimpan) {
                    return "InfoPraTenderCreateLabelAlertMuatan"
                        .tr; // Muatan Harus Diisi
                  }
                  return null;
                },
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText(
                  "InfoPraTenderCreateLabelJenisMuatan".tr +
                      "*", // Jenis Muatan
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              Obx(() => DropdownBelow(
                    itemWidth: MediaQuery.of(context).size.width -
                        GlobalVariable.ratioWidth(Get.context) * 32,
                    itemTextstyle: TextStyle(
                        color: Color(ListColor.colorGrey3),
                        fontWeight: FontWeight.w600,
                        fontSize: GlobalVariable.ratioWidth(Get.context) * 14),
                    boxTextstyle: TextStyle(
                        color: Color(ListColor.colorLightGrey4),
                        fontWeight: FontWeight.w600,
                        fontSize: GlobalVariable.ratioWidth(Get.context) * 14),
                    boxPadding: EdgeInsets.only(
                        left: GlobalVariable.ratioWidth(Get.context) * 17,
                        right: GlobalVariable.ratioWidth(Get.context) * 15),
                    boxWidth: MediaQuery.of(context).size.width -
                        GlobalVariable.ratioWidth(Get.context) * 32,
                    boxHeight: GlobalVariable.ratioWidth(Get.context) * 44,
                    boxDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 6),
                        border: Border.all(
                            width: 1,
                            color: controller.errorSecondPage.value != ""
                                ? Color(ListColor.colorRed)
                                : Color(ListColor.colorGrey2))),
                    icon: Icon(Icons.keyboard_arrow_down_sharp,
                        size: 30, color: Color(ListColor.colorGrey4)),
                    hint: CustomText(
                        controller.jenisMuatan.value == 0
                            ? "InfoPraTenderCreateLabelPilihJenisMuatan"
                                .tr //Pilih Jenis Muatan
                            : controller
                                .arrJenisMuatan[controller.jenisMuatan.value],
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(ListColor.colorLightGrey4)),
                    value: controller.jenisMuatan.value == 0
                        ? null
                        : controller.jenisMuatan.value,
                    items: [
                      DropdownMenuItem(
                        child:
                            CustomText(controller.arrJenisMuatan[1].tr, // Padat
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(ListColor.colorLightGrey4)),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child:
                            CustomText(controller.arrJenisMuatan[2].tr, //Cair
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(ListColor.colorLightGrey4)),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child:
                            CustomText(controller.arrJenisMuatan[3].tr, //Curah
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(ListColor.colorLightGrey4)),
                        value: 3,
                      ),
                    ],
                    onChanged: (value) {
                      FocusManager.instance.primaryFocus.unfocus();
                      print(value);
                      //FocusManager.instance.primaryFocus.unfocus();
                      controller.jenisMuatan.value = value;
                    },
                  )),
              controller.errorSecondPage.value != ""
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 4),
                        Row(
                          children: [
                            Expanded(
                                child: Obx(() => CustomText(
                                      controller.errorSecondPage.value.tr,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      height: 1.2,
                                      color: Color(ListColor.colorRed),
                                    ))),
                            SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 74)
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection:
                    //KHUSUS SATUAN TENDER VOLUME, DIATAS BERAT
                    controller.satuanTender.value == 3
                        ? VerticalDirection.up
                        : VerticalDirection.down,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            "InfoPraTenderCreateLabelBerat".tr +
                                (controller.satuanTender == 1
                                    ? "*"
                                    : ""), // Berat
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8),
                        CustomTextFormField(
                          context: Get.context,
                          newContentPadding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 12,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 12,
                            right: GlobalVariable.ratioWidth(Get.context) * 17,
                            //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                          ),
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9\,]")),
                            DecimalInputFormatter(
                                digit: 13,
                                digitAfterComma: 3,
                                controller: controller.beratController)
                          ],
                          textSize: 14,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorLightGrey4),
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
                                  GlobalVariable.ratioWidth(Get.context) * 40,
                              child: CustomText("Ton",
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: 14),
                            ),
                            isDense: true,
                            isCollapsed: true,
                            hintText: "InfoPraTenderCreateLabelContoh"
                                .tr, // Contoh : 50
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey2),
                            ),
                          ),
                          controller: controller.beratController,
                          validator: (value) {
                            if ((value.isEmpty ||
                                    value == "" ||
                                    value == "0" ||
                                    !controller.validasiSimpan) &&
                                controller.satuanTender.value == 1) {
                              return "InfoPraTenderCreateLabelAlertBeratFilled"
                                  .tr; // Berat Harus Diisi
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            "InfoPraTenderCreateLabelVolume".tr +
                                (controller.satuanTender == 3
                                    ? "*"
                                    : ""), // Volume
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: CustomTextFormField(
                              context: Get.context,
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9\,]")),
                                DecimalInputFormatter(
                                    digit: 13,
                                    digitAfterComma: 3,
                                    controller: controller.volumeController)
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(ListColor.colorLightGrey4),
                              ),
                              newContentPadding: EdgeInsets.symmetric(
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                              ),
                              textSize: 14,
                              newInputDecoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefix: SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            17),
                                suffix: SizedBox(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            17),
                                isDense: true,
                                isCollapsed: true,
                                hintText: "InfoPraTenderCreateLabelContoh"
                                    .tr, // Contoh : 50
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(ListColor.colorLightGrey2),
                                ),
                              ),
                              controller: controller.volumeController,
                              validator: (value) {
                                if ((value.isEmpty ||
                                        value == "" ||
                                        value == "0" ||
                                        !controller.validasiSimpan) &&
                                    controller.satuanTender.value == 3) {
                                  return "InfoPraTenderCreateLabelAlertVolumeFilled"
                                      .tr; // Volume Harus Diisi
                                }
                                return null;
                              },
                            )),
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    12),
                            Obx(() => DropdownBelow(
                                  itemWidth:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          76,
                                  itemTextstyle: TextStyle(
                                      color: Color(ListColor.colorGrey3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14),
                                  boxTextstyle: TextStyle(
                                      color: Color(ListColor.colorLightGrey4),
                                      fontWeight: FontWeight.w600,
                                      fontSize: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14),
                                  boxPadding: EdgeInsets.only(
                                      left: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          11,
                                      right: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          7),
                                  boxWidth:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          76,
                                  boxHeight:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          44,
                                  boxDecoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              6),
                                      border: Border.all(
                                          width: 1,
                                          color: Color(ListColor.colorGrey2))),
                                  icon: Icon(Icons.keyboard_arrow_down_sharp,
                                      size: 30,
                                      color: Color(ListColor.colorGrey4)),
                                  value: controller.satuanVolume.value,
                                  hint: CustomText(
                                      controller
                                          .arrSatuanVolume[
                                              controller.satuanVolume.value]
                                          .tr,
                                      color: Color(ListColor.colorLightGrey4),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  items: [
                                    DropdownMenuItem(
                                      child: CustomText(
                                          controller.arrSatuanVolume[1].tr,
                                          color:
                                              Color(ListColor.colorLightGrey4),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: CustomText(
                                          controller.arrSatuanVolume[2].tr,
                                          color:
                                              Color(ListColor.colorLightGrey4),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      value: 2,
                                    )
                                  ],
                                  onChanged: (value) {
                                    FocusManager.instance.primaryFocus
                                        .unfocus();
                                    controller.satuanVolume.value = value;
                                  },
                                )),
                          ],
                        ),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                      ])
                ],
              ),
              CustomText(
                  "InfoPraTenderCreateLabelDimensiMuatanKoli"
                      .tr, //Dimensi Muatan / Koli
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 12,
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 17,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(ListColor.colorBorderTextbox)),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 6))),
                          child: Row(
                            children: [
                              Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 42,
                                child: CustomTextField(
                                  keyboardType: TextInputType.text,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[0-9\,]")),
                                    DecimalInputFormatter(
                                        digit: 2,
                                        digitAfterComma: 2,
                                        controller:
                                            controller.panjangController)
                                  ],
                                  textAlign: TextAlign.center,
                                  context: Get.context,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor.colorLightGrey4),
                                      fontSize: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14),
                                  newInputDecoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          2,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
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
                                    )),
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText:
                                        "InfoPraTenderCreateLabelP".tr, //p
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(ListColor.colorLightGrey2),
                                    ),
                                  ),
                                  controller: controller.panjangController,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          2,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      0,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0,
                                ),
                                child: CustomText(
                                  "  x  ".tr,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 42,
                                child: CustomTextField(
                                  keyboardType: TextInputType.text,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[0-9\,]")),
                                    DecimalInputFormatter(
                                        digit: 2,
                                        digitAfterComma: 2,
                                        controller: controller.lebarController)
                                  ],
                                  textAlign: TextAlign.center,
                                  context: Get.context,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(ListColor.colorLightGrey4),
                                      fontSize: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          14),
                                  newInputDecoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          2,
                                    ),
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
                                    )),
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText:
                                        "InfoPraTenderCreateLabelL".tr, //l
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(ListColor.colorLightGrey2),
                                    ),
                                  ),
                                  controller: controller.lebarController,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  bottom:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          2,
                                  left: GlobalVariable.ratioWidth(Get.context) *
                                      0,
                                  right:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0,
                                ),
                                child: CustomText(
                                  "  x  ".tr,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Container(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          42,
                                  child: CustomTextField(
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[0-9\,]")),
                                      DecimalInputFormatter(
                                          digit: 2,
                                          digitAfterComma: 2,
                                          controller:
                                              controller.tinggiController)
                                    ],
                                    textAlign: TextAlign.center,
                                    context: Get.context,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorLightGrey4),
                                        fontSize: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            14),
                                    newInputDecoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            2,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
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
                                      )),
                                      isDense: true,
                                      isCollapsed: true,
                                      hintText:
                                          "InfoPraTenderCreateLabelT".tr, // t
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color(ListColor.colorLightGrey2),
                                      ),
                                    ),
                                    controller: controller.tinggiController,
                                  ))
                            ],
                          ))),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                  Obx(() => DropdownBelow(
                        itemWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                        itemTextstyle: TextStyle(
                            color: Color(ListColor.colorGrey3),
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioWidth(Get.context) * 14),
                        boxTextstyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioWidth(Get.context) * 14),
                        boxPadding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 11,
                            right: GlobalVariable.ratioWidth(Get.context) * 7),
                        boxWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                        boxHeight: GlobalVariable.ratioWidth(Get.context) * 44,
                        boxDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 6),
                            border: Border.all(
                                width: 1, color: Color(ListColor.colorGrey2))),
                        icon: Icon(Icons.keyboard_arrow_down_sharp,
                            size: 30, color: Color(ListColor.colorGrey4)),
                        value: controller.satuanMuatan.value,
                        hint: CustomText(
                            controller
                                .arrSatuanDimensi[controller.satuanMuatan.value]
                                .tr,
                            color: Color(ListColor.colorLightGrey4),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        items: [
                          DropdownMenuItem(
                            child: CustomText(controller.arrSatuanDimensi[1].tr,
                                color: Color(ListColor.colorLightGrey4),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: CustomText(controller.arrSatuanDimensi[2].tr,
                                color: Color(ListColor.colorLightGrey4),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            value: 2,
                          )
                        ],
                        onChanged: (value) {
                          FocusManager.instance.primaryFocus.unfocus();
                          controller.satuanMuatan.value = value;
                        },
                      )),
                ],
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
              CustomText("InfoPraTenderCreateLabelJumlahKoli".tr, // Jumlah Koli
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                  DecimalInputFormatter(
                      digit: 13,
                      digitAfterComma: 0,
                      controller: controller.jumlahKoliController)
                ],
                context: Get.context,
                newContentPadding: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                  //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorLightGrey4),
                ),
                textSize: 14,
                newInputDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  suffix: SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 17),
                  isDense: true,
                  isCollapsed: true,
                  hintText: "InfoPraTenderCreateLabelContoh".tr, // Contoh : 50
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey2),
                  ),
                ),
                controller: controller.jumlahKoliController,
              ),
            ],
          )),
    ));
  }

  Widget secondPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: controller.formTwo,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: GlobalVariable.ratioWidth(Get.context) * 20,
            horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText("InfoPraTenderDetailLabelNamaMuatan".tr, // Nama Muatan
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.namaMuatan.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
            CustomText("InfoPraTenderDetailLabelJenisMuatan".tr, // Jenis Muatan
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.keteranganMuatan.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection:
                    //KHUSUS SATUAN TENDER VOLUME, DIATAS BERAT
                    controller.satuanTender.value == 3
                        ? VerticalDirection.up
                        : VerticalDirection.down,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("InfoPraTenderDetailLabelBerat".tr, // Berat
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8),
                        CustomText(controller.berat.value,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("InfoPraTenderDetailLabelVolume".tr, //Volume
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 8),
                        CustomText(controller.volume.value,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24),
                      ])
                ]),
            CustomText(
                "InfoPraTenderDetailLabelDimensiMuatanKoli"
                    .tr, // Dimensi Muatan / Koli
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.dimensiMuatanKoli.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
            CustomText("InfoPraTenderDetailLabelJumlahKoli".tr, // Jumlah Koli
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Color(ListColor.colorGrey3)),
            SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
            CustomText(controller.jumlahKoli.value,
                fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
          ],
        ),
      ),
    ));
  }

  Widget thirdSebelumPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: controller.formThree,
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //KEBUTUHAN
                  for (var index = 0;
                      index < controller.dataTrukTender.length;
                      index++)
                    controller.kebutuhanTrukSebelumPraTenderWidget(index)
                  //KEBUTUHAN
                ],
              ),
            ),
          )),
    );
  }

  Widget thirdPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: controller.formThree,
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //KEBUTUHAN
                  for (var index = 0;
                      index < controller.dataTrukTender.length;
                      index++)
                    controller.kebutuhanTrukPraTenderWidget(index),
                  //KEBUTUHAN
                ],
              ),
            ),
          )),
    );
  }

  Widget fourthSebelumPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formFour,
        child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomText("InfoPraTenderCreateLabelJumlahRute".tr, // Jumlah Rute
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(ListColor.colorGrey3)),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              Container(
                width: GlobalVariable.ratioWidth(Get.context) * 76,
                child: Obx(() => DropdownBelow(
                      itemWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                      itemTextstyle: TextStyle(
                          color: Color(ListColor.colorGrey3),
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioWidth(Get.context) * 14),
                      boxTextstyle: TextStyle(
                          color: Color(ListColor.colorLightGrey4),
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioWidth(Get.context) * 14),
                      boxPadding: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 11,
                          right: GlobalVariable.ratioWidth(Get.context) * 0),
                      boxWidth: GlobalVariable.ratioWidth(Get.context) * 76,
                      boxHeight: GlobalVariable.ratioWidth(Get.context) * 44,
                      boxDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 6),
                          border: Border.all(
                              width: 1, color: Color(ListColor.colorGrey2))),
                      icon: Icon(Icons.keyboard_arrow_down_sharp,
                          size: 30, color: Color(ListColor.colorGrey4)),
                      value: controller.jumlahRute.value,
                      hint: CustomText(controller.jumlahRute.value.toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4)),
                      items: [1, 2, 3].map((data) {
                        return DropdownMenuItem(
                          child: CustomText(data.toString(),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey4)),
                          value: data,
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value < controller.jumlahRute.value) {
                          int jmlDatayangTerisi = 0;

                          for (var x = 0;
                              x < controller.dataRuteTender.length;
                              x++) {
                            var terisi = false;

                            for (var y = 0;
                                y < controller.dataRuteTender[x]['data'].length;
                                y++) {
                              if (controller.dataRuteTender[x]['data'][y]
                                          ['nilai'] >
                                      0 ||
                                  controller.dataRuteTender[x]['pickup'] !=
                                      "" ||
                                  controller.dataRuteTender[x]['destinasi'] !=
                                      "") {
                                terisi = true;
                              }
                            }
                            if (terisi) {
                              jmlDatayangTerisi++;
                            }
                          }

                          print(jmlDatayangTerisi);
                          print(value);

                          if (value < jmlDatayangTerisi) {
                            GlobalAlertDialog.showAlertDialogCustom(
                              context: Get.context,
                              title: "".tr,
                              message: "InfoPraTenderCreateLabelResetDataRute"
                                  .tr, //Jumlah kebutuhan unit Anda berubah. Harap menyesuaikan jumlah kebutuhan unit truk pada setiap rute
                              labelButtonPriority1: "Ok",
                              onTapPriority1: () {},
                            );
                          } else {
                            // YANG KOSONG DIHAPUS DATANYA
                            for (var x = controller.dataRuteTender.length - 1;
                                x >= 0;
                                x--) {
                              var hapus = false;

                              for (var y = 0;
                                  y <
                                      controller
                                          .dataRuteTender[x]['data'].length;
                                  y++) {
                                if (controller.dataRuteTender[x]['data'][y]
                                            ['nilai'] ==
                                        0 &&
                                    controller.dataRuteTender[x]['pickup'] ==
                                        "" &&
                                    controller.dataRuteTender[x]['destinasi'] ==
                                        "") {
                                  hapus = true;
                                }
                              }

                              if (hapus) {
                                controller.dataRuteTender.removeAt(x);
                              }
                            }
                            print(controller.dataRuteTender.length);
                            // LALU DITAMBAH ARRAY KOSONG, SUPAYA JUMLAHNYA SAMA LAGI
                            for (var x = controller.dataRuteTender.length;
                                x < 3;
                                x++) {
                              controller.dataRuteTender.add({
                                'pickup': '',
                                'destinasi': '',
                                'data': [],
                                'error_pickup': '',
                                'error_destinasi': '',
                                'error_lokasi_kembar': '',
                              });
                            }
                            print(controller.dataRuteTender);
                            controller.jumlahRute.value = value;
                            controller.hitungTotalYangDigunakan(false);
                          }
                        } else {
                          controller.jumlahRute.value = value;
                          controller.hitungTotalYangDigunakan(false);
                        }
                      },
                    )),
              ),
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 8),
              CustomText(
                  "InfoPraTenderCreateLabelInfoJumlahRute"
                      .tr, //Pilih jumlah rute yang akan Anda tenderkan (maksimum 3)
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  height: 1.2,
                  color: Colors.black),
              //JUMLAH RUTE
              for (var index = 0; index < controller.jumlahRute.value; index++)
                controller.satuanTender.value == 2
                    ? controller
                        .unitTrukRuteDitenderkanSebelumPraTenderWidget(index)
                    : controller.satuanTender.value == 1
                        ? // BERAT
                        controller
                            .beratRuteDitenderkanSebelumPraTenderWidget(index)
                        : // VOLUME
                        controller
                            .volumeRuteDitenderkanSebelumPraTenderWidget(index),

              //JUMLAH RUTE
              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),

              controller.satuanTender.value == 2
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                        horizontal: GlobalVariable.ratioWidth(Get.context) * 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(ListColor.colorBorderTextbox)),
                          borderRadius: BorderRadius.all(Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 6))),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              SvgPicture.asset(
                                  GlobalVariable.imagePath +
                                      "ic_truck_grey.svg",
                                  color: Color(ListColor.colorBlue),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          18),
                              SizedBox(
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          9),
                              CustomText(
                                  'ProsesTenderCreateLabelTotal'.tr, // Total
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(ListColor.colorGrey3))
                            ],
                          )),
                          Container(
                              alignment: Alignment.centerRight,
                              constraints: BoxConstraints(
                                  minWidth:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          52),
                              child: Obx(
                                () => CustomText(
                                    GlobalVariable.formatCurrencyDecimal(
                                            controller.jumlahYangDigunakan.value
                                                .toString()) +
                                        ' Unit'.tr,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.right,
                                    color: Color(ListColor.colorDarkGrey4)),
                              ))
                        ],
                      ))
                  : Container(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText('InfoPraTenderCreateLabelTotal'.tr, //Total
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 7),
                        Obx(
                          () => CustomText(
                              GlobalVariable.formatCurrencyDecimal(controller
                                      .jumlahYangDigunakan.value
                                      .toString()) +
                                  (controller.satuanTender.value == 1
                                      ? ' Ton'
                                      : " " +
                                          controller.arrSatuanVolume[
                                              controller.satuanVolume.value]),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(ListColor.colorDarkGrey4)),
                        )
                      ],
                    )),

              //KENAPA HANYA CEK VALIDASI SIMPAN, KARENA ERRORNYA CUMA SATU INI SAJA

              SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 4),
              Container(
                  child: Obx(() => CustomText(
                      controller.errorFourthPage.value.tr,
                      color: Color(ListColor.colorRed),
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      fontSize: 12))),
            ])),
      ),
    );
  }

  Widget fourthPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formFour,
        child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //JUMLAH RUTE
              for (var index = 0;
                  index < controller.dataRuteTender.length;
                  index++)
                controller.satuanTender.value == 2
                    ? controller.unitTrukRuteDitenderkanPraTenderWidget(index)
                    : controller.satuanTender.value == 1
                        ? controller.beratRuteDitenderkanPraTenderWidget(index)
                        : controller
                            .volumeRuteDitenderkanPraTenderWidget(index),
              //JUMLAH RUTE
              controller.satuanTender.value == 2
                  ? SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24)
                  : SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 14),

              Container(
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 10,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(ListColor.colorBorderTextbox)),
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 6))),
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    controller.satuanTender.value == 1
                        ? Padding(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 4,
                                right: GlobalVariable.ratioWidth(Get.context) *
                                    15),
                            child: SvgPicture.asset(
                                GlobalVariable.imagePath + 'ic_berat.svg',
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 17,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    17),
                          )
                        : controller.satuanTender.value == 3
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4,
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            15),
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        'volume_icon.svg',
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            17,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            17),
                              )
                            : controller.satuanTender.value == 2
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            9),
                                    child: SvgPicture.asset(
                                        GlobalVariable.imagePath +
                                            'ic_truck_grey.svg',
                                        color: Color(ListColor.colorBlue),
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            18,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            18),
                                  )
                                : SizedBox(),
                    Expanded(
                        child: CustomText(
                            'ProsesTenderDetailLabelTotal'.tr +
                                ' ' +
                                (controller.satuanTender.value == 2
                                    ? ''
                                    : controller.arrSatuanTender[
                                        controller.satuanTender.value]), //Total
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(ListColor.colorGrey3))),
                    Container(
                        alignment: controller.satuanTender.value == 2
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        constraints: BoxConstraints(
                            minWidth:
                                GlobalVariable.ratioWidth(Get.context) * 52),
                        child: Obx(
                          () => CustomText(
                              GlobalVariable.formatCurrencyDecimal(controller
                                      .jumlahYangDigunakan
                                      .toString()) +
                                  (controller.satuanTender.value == 2
                                          ? ' Unit'
                                          : controller.satuanTender.value == 1
                                              ? ' Ton'
                                              : ' ' +
                                                  controller.arrSatuanVolume[
                                                      controller
                                                          .satuanVolume.value])
                                      .tr,
                              fontSize: 14,
                              textAlign: controller.satuanTender.value == 2
                                  ? TextAlign.right
                                  : null,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ))
                  ])),
            ])),
      ),
    );
  }

  Widget fifthSebelumPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: controller.formFive,
          child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(Get.context) * 5,
                          left: GlobalVariable.ratioWidth(Get.context) * 4,
                          right: GlobalVariable.ratioWidth(Get.context) * 4,
                        ),
                        decoration: BoxDecoration(
                            border:
                                Border.all( width: GlobalVariable.ratioWidth(Get.context) * 1,color: Color(ListColor.colorBlue)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 6))),
                        child: CustomText(
                            'InfoPraTenderCreateLabelInfoPersyaratanKualifikasi'
                                .tr, //Masukkan Persyaratan Kualifikasi (Dokumen/Administrasi) untuk Transporter agar bisa mengikuti Tender yang Anda bua
                            fontSize: 14,
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            color: Color(ListColor.colorBlue))),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                    CustomText(
                        'InfoPraTenderCreateLabelPersyaratanKualifikasiLampiran'
                            .tr, //Persyaratan Kualifikasi / Lampiran
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 8),
                    CustomTextFormField(
                      maxLines: 4,
                      context: Get.context,
                      newContentPadding: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                        //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(ListColor.colorLightGrey4),
                        height: 1.4,
                      ),
                      textSize: 14,
                      newInputDecoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefix: SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 17),
                        suffix: SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 17),
                        isDense: true,
                        isCollapsed: true,
                        hintText:
                            "InfoPraTenderCreateLabelInfoPersyaratanKualifikasiLampiran"
                                .tr, //Contoh : 1. Akta Perusahaan

                        hintStyle: TextStyle(
                          color: Color(ListColor.colorLightGrey2),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      controller: controller.persyaratanController,
                    ),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            FocusManager.instance.primaryFocus.unfocus();
                            controller.chooseFile();
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Color(ListColor.colorBlue)),
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          50)),
                              child: CustomText(
                                  'InfoPraTenderCreateLabelButtonUpload'
                                      .tr, //Upload
                                  fontSize: 12,
                                  color: Color(ListColor.colorBlue),
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 11,
                        ),
                        Flexible(
                            child: controller.errorFifthPage.value == ""
                                ? Obx(() => CustomText(
                                    controller.nama_file.value
                                        .toString(), //Upload
                                    fontSize: 12,
                                    color: Color(ListColor.colorBlue),
                                    fontWeight: FontWeight.w600))
                                : Obx(() => CustomText(
                                    controller.errorFifthPage.value
                                        .toString(), //Upload
                                    fontSize: 12,
                                    height: 1.2,
                                    color: Color(ListColor.colorRed),
                                    fontWeight: FontWeight.w600))),
                        Obx(
                          () => controller.nama_file.value != ""
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          11,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          controller.nama_file.value = "";
                                          controller.errorFifthPage.value = "";
                                          controller.selectedFile.value = null;
                                          controller
                                              .nama_file_sebelumnya.value = "";
                                          controller.link.value = "";
                                        },
                                        child: SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              "ic_close_attachment.svg",
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              19,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              19,
                                        ))
                                  ],
                                )
                              : SizedBox(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                    CustomText(
                        'InfoPraTenderCreateLabelCatatanTambahan'
                            .tr, // Catatan Tambahan
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 8),
                    CustomTextFormField(
                      maxLines: 4,
                      context: Get.context,
                      newContentPadding: EdgeInsets.symmetric(
                        vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                        //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                      ),
                      textSize: 14,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          color: Color(ListColor.colorLightGrey4)),
                      newInputDecoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefix: SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 17),
                        suffix: SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 17),
                        isDense: true,
                        isCollapsed: true,
                        hintText: "InfoPraTenderCreateLabelInfoCatatanTambahan"
                            .tr, // Masukan Catatan Tambahan
                        hintStyle: TextStyle(
                          color: Color(ListColor.colorLightGrey2),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      controller: controller.catatanTambahanController,
                    ),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 24),
                    //DETAIL TAHAP TENDER
                    CustomText(
                        "InfoPraTenderEditStatusInfoPraTender"
                            .tr, // Status Info Pra Tender
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 12),
                    Row(
                      children: [
                        Obx(() => GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus.unfocus();
                              print(1);
                              controller.status.value = "1";
                            },
                            child: AbsorbPointer(
                              child: RadioButtonCustomWithText(
                                  isWithShadow: true,
                                  toggleable: false,
                                  isDense: true,
                                  colorNotSelected: Colors.white,
                                  radioSize:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          14,
                                  groupValue: controller.status.value,
                                  value: "1",
                                  onChanged: (str) {
                                    FocusManager.instance.primaryFocus
                                        .unfocus();
                                    print(str);
                                    controller.status.value = str;
                                  },
                                  customTextWidget: Container(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          74,
                                      padding: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              3),
                                      child: CustomText(
                                          "InfoPraTenderEditStatusInfoPraTenderAktif"
                                              .tr, // Aktif
                                          color:
                                              Color(ListColor.colorDarkGrey4),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14))),
                            ))),
                        SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 33),
                        Obx(() => GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus.unfocus();

                              print(3);
                              controller.status.value = "3";
                            },
                            child: AbsorbPointer(
                              child: RadioButtonCustomWithText(
                                  isWithShadow: true,
                                  toggleable: false,
                                  isDense: true,
                                  colorNotSelected: Colors.white,
                                  radioSize:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          14,
                                  groupValue: controller.status.value,
                                  value: "3",
                                  onChanged: (str) {
                                    FocusManager.instance.primaryFocus
                                        .unfocus();

                                    controller.status.value = "3";
                                  },
                                  customTextWidget: Container(
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          74,
                                      padding: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              3),
                                      child: CustomText(
                                          "InfoPraTenderEditStatusInfoPraTenderBatalkan"
                                              .tr, // Batalkan
                                          color:
                                              Color(ListColor.colorDarkGrey4),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14))),
                            ))),
                      ],
                    )
                  ]))),
    );
  }

  Widget fifthPraTenderPage(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: controller.formFive,
          child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: GlobalVariable.ratioWidth(Get.context) * 20,
                  horizontal: GlobalVariable.ratioWidth(Get.context) * 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                          bottom: GlobalVariable.ratioWidth(Get.context) * 5,
                          left: GlobalVariable.ratioWidth(Get.context) * 4,
                          right: GlobalVariable.ratioWidth(Get.context) * 4,
                        ),
                        decoration: BoxDecoration(
                            border:
                                Border.all( width: GlobalVariable.ratioWidth(Get.context) * 1,color: Color(ListColor.colorBlue)),
                            borderRadius: BorderRadius.all(Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 6))),
                        child: CustomText(
                            'InfoPraTenderDetailLabelInfoPersyaratanKualifikasi'
                                .tr, //Masukkan Persyaratan Kualifikasi (Dokumen/Administrasi) untuk Transporter agar bisa mengikuti Tender yang Anda buat
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.3,
                            color: Color(ListColor.colorBlue))),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                    CustomText(
                        'InfoPraTenderDetailLabelPersyaratanKualifikasiLampiran'
                            .tr, //Persyaratan Kualifikasi / Lampiran

                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.colorGrey3)),
                    controller.dataKualifikasiPraTender.length > 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                for (var index = 0;
                                    index <
                                        controller
                                            .dataKualifikasiPraTender.length;
                                    index++)
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            controller.dataKualifikasiPraTender[
                                                index]['tglDibuat'],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor
                                                .colorTimePersyaratanKualifikasi)),
                                        CustomText(
                                            controller.dataKualifikasiPraTender[
                                                index]['isi'],
                                            fontSize: 14,
                                            height: 1.4,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        index !=
                                                controller
                                                        .dataKualifikasiPraTender
                                                        .length -
                                                    1
                                            ? SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14)
                                            : SizedBox(),
                                      ]),
                              ])
                        : controller.nama_file.value == ""
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8),
                                    CustomText("-",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ])
                            : SizedBox(),

                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 10),

                    controller.dataKualifikasiPraTender.length == 6
                        ? SizedBox()
                        : Obx(() => !controller.persyaratanBaru.value
                            ? GestureDetector(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus.unfocus();
                                  controller.persyaratanBaru.value = true;
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          'InfoPraTenderEditLabelButtonTambahPersyaratan'
                                              .tr, //Tambah Persyaratan
                                          fontSize: 14,
                                          color: Color(ListColor.colorBlue),
                                          decoration: TextDecoration.underline,
                                          colordecoration:
                                              Color(ListColor.colorBlue),
                                          fontWeight: FontWeight.w600),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              2),
                                      SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              'blue_arrow.svg',
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                    ]))
                            : Stack(children: [
                                CustomTextFormField(
                                  maxLines: 4,
                                  context: Get.context,
                                  newContentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(ListColor.colorLightGrey4),
                                    height: 1.4,
                                  ),
                                  textSize: 12,
                                  newInputDecoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefix: SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            17),
                                    suffix: SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            17),
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText:
                                        "InfoPraTenderCreateLabelInfoPersyaratanKualifikasiLampiran"
                                            .tr, //Contoh : 1. Akta Perusahaan

                                    hintStyle: TextStyle(
                                      color: Color(ListColor.colorLightGrey2),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  controller: controller.persyaratanController,
                                ),
                                Positioned.fill(
                                    bottom:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            5,
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            5,
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'ic_close_blue.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18,
                                              color: Color(
                                                  ListColor.colorLightGrey4)),
                                          onTap: () async {
                                            controller.persyaratanController
                                                .clear();
                                            controller.persyaratanBaru.value =
                                                false;
                                          },
                                        )))
                              ])),

                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 10),

                    controller.nama_file.value != ""
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  controller.cekLampiran =
                                      await SharedPreferencesHelper.getHakAkses(
                                          "Lihat dan Download File Persyaratan/Lampiran Pra Tender",
                                          denganLoading: true);
                                  if (SharedPreferencesHelper.cekAkses(
                                      controller.cekLampiran)) {
                                    controller.lihat(controller.link.value,
                                        controller.nama_file.value);
                                  }
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            18,
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            4),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: controller.cekLampiran
                                                ? Color(ListColor.colorBlue)
                                                : Color(ListColor
                                                    .colorAksesDisable)),
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(Get.context) * 50)),
                                    child: CustomText('InfoPraTenderDetailLabelLihatLampiran'.tr, // Lihat
                                        fontSize: 12,
                                        color: controller.cekLampiran ? Color(ListColor.colorBlue) : Color(ListColor.colorAksesDisable),
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 8,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  controller.cekLampiran =
                                      await SharedPreferencesHelper.getHakAkses(
                                          "Lihat dan Download File Persyaratan/Lampiran Pra Tender",
                                          denganLoading: true);
                                  if (SharedPreferencesHelper.cekAkses(
                                      controller.cekLampiran)) {
                                    controller.shareData(
                                        controller.link.value, true);
                                  }
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            GlobalVariable.ratioWidth(Get.context) *
                                                11,
                                        vertical:
                                            GlobalVariable.ratioWidth(Get.context) *
                                                4),
                                    decoration: BoxDecoration(
                                        color: controller.cekLampiran
                                            ? Color(ListColor.colorBlue)
                                            : Color(
                                                ListColor.colorAksesDisable),
                                        border: Border.all(
                                            color: controller.cekLampiran
                                                ? Color(ListColor.colorBlue)
                                                : Color(ListColor
                                                    .colorAksesDisable)),
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(Get.context) * 50)),
                                    child: CustomText('InfoPraTenderDetailLabelBagikan'.tr, // Download
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),
                    CustomText(
                        'InfoPraTenderDetailLabelCatatanTambahan'
                            .tr, // Catatan Tambahan
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 8),
                    controller.dataNote.length > 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                for (var index = 0;
                                    index < controller.dataNote.length;
                                    index++)
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            controller.dataNote[index]
                                                ['tglDibuat'],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(ListColor
                                                .colorTimePersyaratanKualifikasi)),
                                        CustomText(
                                            controller.dataNote[index]['isi'],
                                            fontSize: 14,
                                            height: 1.4,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                        index != controller.dataNote.length - 1
                                            ? SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        14)
                                            : SizedBox()
                                      ]),
                              ])
                        : CustomText("-",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),

                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 10),

                    controller.dataNote.length == 6
                        ? SizedBox()
                        : Obx(() => !controller.catatanBaru.value
                            ? GestureDetector(
                                onTap: () async {
                                  controller.catatanBaru.value = true;
                                  FocusManager.instance.primaryFocus.unfocus();
                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          'InfoPraTenderEditLabelButtonTambahCatatan'
                                              .tr, //Tambah Catatan
                                          fontSize: 14,
                                          color: Color(ListColor.colorBlue),
                                          decoration: TextDecoration.underline,
                                          colordecoration:
                                              Color(ListColor.colorBlue),
                                          fontWeight: FontWeight.w600),
                                      SizedBox(
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              2),
                                      SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              'blue_arrow.svg',
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14)
                                    ]),
                              )
                            : Stack(children: [
                                CustomTextFormField(
                                  maxLines: 4,
                                  context: Get.context,
                                  newContentPadding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                    //horizontal: GlobalVariable.ratioWidth(Get.context) * 17,
                                  ),
                                  textSize: 12,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      height: 1.4,
                                      color: Color(ListColor.colorLightGrey4)),
                                  newInputDecoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefix: SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            17),
                                    suffix: SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            17),
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText:
                                        "InfoPraTenderCreateLabelInfoCatatanTambahan"
                                            .tr, // Masukan Catatan Tambahan
                                    hintStyle: TextStyle(
                                      color: Color(ListColor.colorLightGrey2),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  controller:
                                      controller.catatanTambahanController,
                                ),
                                Positioned.fill(
                                    bottom:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            5,
                                    right:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            5,
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  'ic_close_blue.svg',
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18,
                                              color: Color(
                                                  ListColor.colorLightGrey4)),
                                          onTap: () async {
                                            controller.catatanTambahanController
                                                .clear();
                                            controller.catatanBaru.value =
                                                false;
                                          },
                                        )))
                              ])),

                    SizedBox(
                      height: GlobalVariable.ratioWidth(Get.context) * 24,
                    ),

                    //DETAIL TAHAP TENDER
                    CustomText(
                        "InfoPraTenderEditStatusInfoPraTender"
                            .tr, // Status Info Pra Tender
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 12),
                    Row(children: [
                      Obx(() => GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus.unfocus();
                            print(1);
                            controller.status.value = "1";
                            controller.status.refresh();
                          },
                          child: AbsorbPointer(
                            child: RadioButtonCustomWithText(
                                isWithShadow: true,
                                toggleable: false,
                                isDense: true,
                                colorNotSelected: Colors.white,
                                radioSize:
                                    GlobalVariable.ratioWidth(Get.context) * 14,
                                groupValue: controller.status.value,
                                value: "1",
                                onChanged: (str) {
                                  FocusManager.instance.primaryFocus.unfocus();
                                  print(str);
                                  controller.status.value = str;
                                  controller.status.refresh();
                                },
                                customTextWidget: Container(
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            74,
                                    padding: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            3),
                                    child: CustomText(
                                        "InfoPraTenderEditStatusInfoPraTenderAktif"
                                            .tr, // Aktif
                                        color: Color(ListColor.colorDarkGrey4),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14))),
                          ))),
                      SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 33),
                      GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus.unfocus();
                            print(controller.status.value);

                            controller.status.value = "3";
                            controller.status.refresh();
                          },
                          child: Obx(
                            () => AbsorbPointer(
                                child: RadioButtonCustomWithText(
                                    isWithShadow: true,
                                    toggleable: false,
                                    isDense: true,
                                    colorNotSelected: Colors.white,
                                    radioSize:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            14,
                                    groupValue: controller.status.value,
                                    value: "3",
                                    onChanged: (str) {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();
                                      print(controller.status.value);
                                      controller.status.value = "3";
                                      controller.status.refresh();
                                    },
                                    customTextWidget: Container(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            74,
                                        padding: EdgeInsets.only(
                                            left: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                3),
                                        child: CustomText(
                                            "InfoPraTenderEditStatusInfoPraTenderBatalkan"
                                                .tr, // Batalkan
                                            color:
                                                Color(ListColor.colorDarkGrey4),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14)))),
                          )),
                    ])
                  ]))),
    );
  }

  void save() async {
    controller.errorFirstPage.value = "";
    controller.errorSecondPage.value = "";
    controller.errorThirdPage.value = "";
    controller.errorFourthPage.value = "";
    controller.errorFifthPage.value = "";

    controller.validasiSimpan = true;
    controller.dataTahapTender.refresh();
    controller.dataTrukTender.refresh();
    if (controller.satuanTender.value == 2) {
      switch (controller.slideIndex.value) {
        case 0:
          {
            controller.validasiSimpan =
                controller.formOne.currentState.validate();

            //CHECK ADA TANGGAL TAHAPAN TENDER KOSONG
            for (var index = 0;
                index < controller.dataTahapTender.length;
                index++) {
              controller.dataTahapTender[index]['error_min_date'] = "";

              controller.dataTahapTender[index]['error_max_date'] = "";

              if (controller.dataTahapTender[index]['min_date'] == "") {
                controller.validasiSimpan = false;
                controller.dataTahapTender[index]['error_min_date'] =
                    "InfoPraTenderCreateLabelAlertTanggalAwal"
                        .tr; //Tanggal Awal harus diisi
              }

              if (controller.dataTahapTender[index]['max_date'] == "") {
                controller.validasiSimpan = false;
                controller.dataTahapTender[index]['error_max_date'] =
                    "InfoPraTenderCreateLabelAlertTanggalAkhir"
                        .tr; //Tanggal Akhir harus diisi
              }
            }

            if (controller.validasiSimpan) {
              //CEK APAKAH ADA TANGGAL YANG LEBIH BESAR DARI PERIODE SEBELUMNYA
              //TGL TERTINGGI DIISI DENGAN TGL AWAL
              var tgltertinggi = controller.dataTahapTender[0]['min_date'];

              for (var index = 0;
                  index < controller.dataTahapTender.length;
                  index++) {
                if (index == 0) {
                  print(tgltertinggi);
                  print(controller.dataTahapTender[index]['max_date']);
                  //CEK APAKAH TGL TERTINGGI LEBIH KECIL DARI TGL AKHIR

                  if (tgltertinggi.compareTo(
                              controller.dataTahapTender[index]['max_date']) >
                          0 &&
                      controller.dataTahapTender[index]['error_max_date'] ==
                          '') {
                    controller.validasiSimpan = false;
                    controller.dataTahapTender[index]['error_max_date'] =
                        "InfoPraTenderCreateLabelAlertPeriodeAkhirKurangDariPeriodeAwal"
                            .tr; // Periode Akhir Tidak Boleh Kurang Dari Periode Awal
                  } else if (controller.dataTahapTender[index]
                          ['error_min_date'] ==
                      '') {
                    controller.dataTahapTender[index]['error_max_date'] = "";
                    tgltertinggi =
                        controller.dataTahapTender[index]['max_date'];
                  }
                } else {
                  //CEK TGL TERTINGGI TERAKHIR LEBIH BESAR DARI TGL AWAL SEKARANG
                  if (tgltertinggi.compareTo(
                              controller.dataTahapTender[index]['min_date']) >
                          0 &&
                      controller.dataTahapTender[index]['error_min_date'] ==
                          '') {
                    controller.validasiSimpan = false;
                    controller.dataTahapTender[index]['error_min_date'] =
                        "InfoPraTenderCreateLabelAlertPeriodeAwalKurangDariPeriodeAkhir"
                            .tr; //Periode Awal Tidak Boleh Kurang Dari Periode Akhir Proses Sebelumnya
                  } else if (controller.dataTahapTender[index]
                          ['error_min_date'] ==
                      '') {
                    tgltertinggi =
                        controller.dataTahapTender[index]['min_date'];
                  }

                  //CEK APAKAH TGL TERTINGGI LEBIH KECIL DARI TGL AKHIR
                  if (tgltertinggi.compareTo(
                              controller.dataTahapTender[index]['max_date']) >
                          0 &&
                      controller.dataTahapTender[index]['error_max_date'] ==
                          '') {
                    controller.validasiSimpan = false;
                    controller.dataTahapTender[index]['error_max_date'] =
                        "InfoPraTenderCreateLabelAlertPeriodeAkhirKurangDariPeriodeAwal"
                            .tr; //Periode akhir tidak boleh kurang dari periode awal

                  } else if (controller.dataTahapTender[index]
                          ['error_max_date'] ==
                      '') {
                    controller.dataTahapTender[index]['error_max_date'] = "";
                    tgltertinggi =
                        controller.dataTahapTender[index]['max_date'];
                  }
                }
              }
            }

            //ERROR TAHAP TENDER
            for (var x = 0; x < controller.dataTahapTender.length; x++) {
              controller.dataTahapTender[x]['error_tahap_tender'] = "";
              if (controller.dataTahapTender
                          .where((element) =>
                              element['tahap_tender'] ==
                              controller.dataTahapTender[x]['tahap_tender'])
                          .length >
                      1 &&
                  x ==
                      controller.dataTahapTender.lastIndexWhere((element) =>
                          element['tahap_tender'] ==
                          controller.dataTahapTender[x]['tahap_tender'])) {
                controller.validasiSimpan = false;
                controller.dataTahapTender[x]['error_tahap_tender'] =
                    'InfoPraTenderCreateLabelAlertTahapTenderKembar'
                        .tr; //Tahap Tender Tidak Boleh Kembar
              }
              //DAPATKAN INDEX TAHAP TENDER YANG LEBIH KECIL DARI TENDER INI DAN TERAKHIR, LALU CEK APAKAH TENDER TERSEBUT INDEXNYA KEBIH BESAR
              if ((controller.dataTahapTender.lastIndexWhere((element) =>
                          element['tahap_tender'] <
                          controller.dataTahapTender[x]['tahap_tender']) >
                      x &&
                  x ==
                      controller.dataTahapTender.indexWhere((element) =>
                          element['tahap_tender'] ==
                          controller.dataTahapTender[x]['tahap_tender']))) {
                controller.validasiSimpan = false;
                controller.dataTahapTender[x]['error_tahap_tender'] =
                    'InfoPraTenderCreateLabelAlertTahapTenderTidakUrut'
                        .tr; // Tahap Tender tidak boleh mundur

              }
            }

            if (controller.dataSelectedTampil.value.length == 0) {
              print('MASUK DONG');
              controller.validasiSimpan = false;
              controller.errorFirstPage.value =
                  "InfoPraTenderCreateLabelAlertDiumumkanKepada"
                      .tr; //  "Transporter / Mitra harus dipilih"
            }

            break;
          }
        case 1:
          {
            controller.validasiSimpan =
                controller.formTwo.currentState.validate();

            if (controller.jenisMuatan.value == 0) {
              controller.errorSecondPage.value =
                  "InfoPraTenderCreateLabelAlertJenisMuatan"
                      .tr; //Jenis Muatan Harus Diisi
              controller.validasiSimpan = false;
            }
            break;
          }
        case 2:
          {
            //RESET ERROR
            for (var index = 0;
                index < controller.dataTrukTender.length;
                index++) {
              controller.dataTrukTender[index]['error'] = '';

              controller.dataTrukTender[index]['jmlerror'] = '';
            }
            controller.validasiSimpan =
                controller.formThree.currentState.validate();
            if (controller.validasiSimpan) {
              //CHECK ADA TRUK DAN CARRIER YANG SAMA
              for (var index = 0;
                  index < controller.dataTrukTender.length;
                  index++) {
                if (controller.dataTrukTender
                        .where((element) =>
                            element['jenis_truk'] ==
                                controller.dataTrukTender[index]
                                    ['jenis_truk'] &&
                            element['jenis_carrier'] ==
                                controller.dataTrukTender[index]
                                    ['jenis_carrier'])
                        .length >
                    1) {
                  controller.validasiSimpan = false;
                  controller.dataTrukTender[index]['error'] =
                      'InfoPraTenderCreateAlertTrukKembar'
                          .tr; //Data Truk Tidak Boleh Sama
                }

                //PENGECEKAN JML UNIT TRUK
                if (controller.dataTrukTender[index]['jumlah_truck']
                            .toString() ==
                        "" &&
                    controller.validasiSimpan) {
                  controller.validasiSimpan = false;
                  //ERRORNYA DIOPER KE BAWAH (BEDA WIDGET)
                  controller.dataTrukTender[index]['jmlerror'] =
                      'InfoPraTenderAlertJumlahUnitTruk0'.tr;
                }

                if (controller.dataTrukTender[index]['jumlah_truck'] == 0 &&
                    controller.validasiSimpan) {
                  controller.validasiSimpan = false;
                  //ERRORNYA DIOPER KE BAWAH (BEDA WIDGET)
                  controller.dataTrukTender[index]['jmlerror'] =
                      'InfoPraTenderAlertJumlahUnitTruk0'
                          .tr; // Unit Truk Harus Lebih Dari 0
                }
              }
            }

            print(controller.validasiSimpan);
            print(controller.dataTrukTender);
            controller.dataTrukTender.refresh();
            controller.dataTrukController.refresh();
            controller.dataCarrierController.refresh();

            //DATANYA DISIMPAN UNTUK PENGECEKAN, JIKA ADA PERUBAHAN TRUK
            if (controller.validasiSimpan) {
              if (controller.cekRuteDitenderkanSudahAda()) {
                if (controller.cekJumlahTrukSebelumnyaBeda()) {
                  controller.validasiSimpan = false;
                  GlobalAlertDialog.showAlertDialogCustom(
                      context: Get.context,
                      title: "InfoPraTenderCreateLabelInfoKonfirmasiPerubahan"
                          .tr, //Konfirmasi Perubahan
                      message:
                          "InfoPraTenderCreateLabelPerubahanJumlah1" //Apakah anda yakin ingin melakukan perubahan data jumlah unit?
                                  .tr +
                              "\n" +
                              "InfoPraTenderCreateLabelPerubahanJumlah2" //Data yang telah diisi pada data rute yang ditenderkan harus diupdate
                                  .tr,
                      labelButtonPriority1: GlobalAlertDialog.noLabelButton,
                      onTapPriority1: () async {
                        controller.dataTrukTender.value = [];
                        //KALAU TIDAK SETUJU PERUBAHANNYA, KEMBALIKAN DATA KESEBELUMNYA
                        controller.dataTrukTender.value = json.decode(json
                            .encode(controller.dataTrukTenderSebelumnya.value));

                        for (var x = 0;
                            x < controller.dataTrukTender.length;
                            x++) {
                          controller.jmlTrukController[x].text = controller
                              .dataTrukTender[x]['jumlah_truck']
                              .toString();
                        }

                        controller.dataTrukTender.refresh();
                      },
                      onTapPriority2: () async {
                        //KALAU SETUJU PERUBAHANNYA, DISIMPAN
                        controller.dataTrukTenderSebelumnya.value = json.decode(
                            json.encode(controller.dataTrukTender.value));

                        //RESET, LALU BUAT ULANG
                        //controller.fourthPageinit();

                        //controller.setUlangDataRute();

                        print('BERUBAH JUMLAH UNIT');

                        //Jumlah Kebutuhan Unit anda Berubah
                        GlobalAlertDialog.showAlertDialogCustom(
                          context: Get.context,
                          title: "".tr,
                          message:
                              "InfoPraTenderCreateLabelInfoDataJumlahUnitTrukBerubah"
                                  .tr, //Jumlah kebutuhan unit Anda berubah. Harap menyesuaikan jumlah kebutuhan unit truk pada setiap rute
                          labelButtonPriority1: "Ok",
                          onTapPriority1: () {},
                        );

                        save();
                      },
                      labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
                } else {
                  print('AMAN');
                  //KALAU SETUJU PERUBAHANNYA, DISIMPAN
                  controller.dataTrukTenderSebelumnya.value =
                      json.decode(json.encode(controller.dataTrukTender.value));
                }
              } else {
                print('AMAN');
                //KALAU SETUJU PERUBAHANNYA, DISIMPAN
                controller.dataTrukTenderSebelumnya.value =
                    json.decode(json.encode(controller.dataTrukTender.value));
              }
            }

            break;
          }
        case 3:
          {
            controller.validasiSimpan =
                controller.formFour.currentState.validate();

            controller.cekBelumTerpakai();

            break;
          }
        case 4:
          {
            controller.validasiSimpan =
                controller.formFive.currentState.validate();
            break;
          }
      }
    } else {
      switch (controller.slideIndex.value) {
        case 0:
          {
            controller.validasiSimpan =
                controller.formOne.currentState.validate();

            //CHECK ADA TANGGAL TAHAPAN TENDER KOSONG
            for (var index = 0;
                index < controller.dataTahapTender.length;
                index++) {
              controller.dataTahapTender[index]['error_min_date'] = "";

              controller.dataTahapTender[index]['error_max_date'] = "";

              if (controller.dataTahapTender[index]['min_date'] == "") {
                controller.validasiSimpan = false;
                controller.dataTahapTender[index]['error_min_date'] =
                    "InfoPraTenderCreateLabelAlertTanggalAwal"
                        .tr; //Tanggal Awal harus diisi
              }

              if (controller.dataTahapTender[index]['max_date'] == "") {
                controller.validasiSimpan = false;
                controller.dataTahapTender[index]['error_max_date'] =
                    "InfoPraTenderCreateLabelAlertTanggalAkhir"
                        .tr; // Tanggal Akhir harus diisi
              }
            }
            if (controller.validasiSimpan) {
              //CEK APAKAH ADA TANGGAL YANG LEBIH BESAR DARI PERIODE SEBELUMNYA
              //TGL TERTINGGI DIISI DENGAN TGL AWAL
              var tgltertinggi = controller.dataTahapTender[0]['min_date'];

              for (var index = 0;
                  index < controller.dataTahapTender.length;
                  index++) {
                if (index == 0) {
                  print(tgltertinggi);
                  print(controller.dataTahapTender[index]['max_date']);
                  //CEK APAKAH TGL TERTINGGI LEBIH KECIL DARI TGL AKHIR

                  if (tgltertinggi.compareTo(
                              controller.dataTahapTender[index]['max_date']) >
                          0 &&
                      controller.dataTahapTender[index]['error_max_date'] ==
                          '') {
                    controller.validasiSimpan = false;
                    controller.dataTahapTender[index]['error_max_date'] =
                        "InfoPraTenderCreateLabelAlertPeriodeAkhirKurangDariPeriodeAwal"
                            .tr; //Periode Akhir Tidak Boleh Kurang Dari Periode Awal
                  } else if (controller.dataTahapTender[index]
                          ['error_min_date'] ==
                      '') {
                    controller.dataTahapTender[index]['error_max_date'] = "";
                    tgltertinggi =
                        controller.dataTahapTender[index]['max_date'];
                  }
                } else {
                  //CEK TGL TERTINGGI TERAKHIR LEBIH BESAR DARI TGL AWAL SEKARANG
                  if (tgltertinggi.compareTo(
                              controller.dataTahapTender[index]['min_date']) >
                          0 &&
                      controller.dataTahapTender[index]['error_min_date'] ==
                          '') {
                    controller.validasiSimpan = false;
                    controller.dataTahapTender[index]['error_min_date'] =
                        "InfoPraTenderCreateLabelAlertPeriodeAwalKurangDariPeriodeAkhir"
                            .tr; //Periode Awal Tidak Boleh Kurang Dari Periode Akhir Proses Sebelumnya
                  } else if (controller.dataTahapTender[index]
                          ['error_min_date'] ==
                      '') {
                    tgltertinggi =
                        controller.dataTahapTender[index]['min_date'];
                  }

                  //CEK APAKAH TGL TERTINGGI LEBIH KECIL DARI TGL AKHIR
                  if (tgltertinggi.compareTo(
                              controller.dataTahapTender[index]['max_date']) >
                          0 &&
                      controller.dataTahapTender[index]['error_max_date'] ==
                          '') {
                    controller.validasiSimpan = false;
                    controller.dataTahapTender[index]['error_max_date'] =
                        "InfoPraTenderCreateLabelAlertPeriodeAkhirKurangDariPeriodeAwal"
                            .tr; //Periode Akhir Tidak Boleh Kurang Dari Periode Awal
                  } else if (controller.dataTahapTender[index]
                          ['error_max_date'] ==
                      '') {
                    controller.dataTahapTender[index]['error_max_date'] = "";
                    tgltertinggi =
                        controller.dataTahapTender[index]['max_date'];
                  }
                }
              }
            }

            //ERROR TAHAP TENDER
            for (var x = 0; x < controller.dataTahapTender.length; x++) {
              controller.dataTahapTender[x]['error_tahap_tender'] = "";
              if (controller.dataTahapTender
                          .where((element) =>
                              element['tahap_tender'] ==
                              controller.dataTahapTender[x]['tahap_tender'])
                          .length >
                      1 &&
                  x ==
                      controller.dataTahapTender.lastIndexWhere((element) =>
                          element['tahap_tender'] ==
                          controller.dataTahapTender[x]['tahap_tender'])) {
                controller.validasiSimpan = false;
                controller.dataTahapTender[x]['error_tahap_tender'] =
                    'InfoPraTenderCreateLabelAlertTahapTenderKembar'
                        .tr; //Tahap Tender tidak boleh kembar

              }
              //DAPATKAN INDEX TAHAP TENDER YANG LEBIH KECIL DARI TENDER INI DAN TERAKHIR, LALU CEK APAKAH TENDER TERSEBUT INDEXNYA KEBIH BESAR
              if ((controller.dataTahapTender.lastIndexWhere((element) =>
                          element['tahap_tender'] <
                          controller.dataTahapTender[x]['tahap_tender']) >
                      x &&
                  x ==
                      controller.dataTahapTender.indexWhere((element) =>
                          element['tahap_tender'] ==
                          controller.dataTahapTender[x]['tahap_tender']))) {
                controller.validasiSimpan = false;
                controller.dataTahapTender[x]['error_tahap_tender'] =
                    'InfoPraTenderCreateLabelAlertTahapTenderTidakUrut'
                        .tr; // Tahap Tender tidak boleh mundur

              }
            }

            if (controller.dataSelectedTampil.value.length == 0) {
              controller.validasiSimpan = false;
              controller.errorFirstPage.value =
                  "InfoPraTenderCreateLabelAlertDiumumkanKepada"
                      .tr; //Transporter / Mitra harus dipilih
            }

            break;
          }
        case 1:
          {
            controller.validasiSimpan =
                controller.formTwo.currentState.validate();

            if (controller.jenisMuatan.value == 0) {
              controller.errorSecondPage.value =
                  "InfoPraTenderCreateLabelAlertJenisMuatan"
                      .tr; // Jenis Muatan Harus Dipilih
              controller.validasiSimpan = false;
            }
            break;
          }
        case 2:
          {
            controller.validasiSimpan =
                controller.formFour.currentState.validate();
            controller.cekBelumTerpakai();

            //PENGECEKAN LOKASI KOSONG
            for (var x = 0; x < controller.jumlahRute.value; x++) {
              controller.dataRuteTender[x]['error_pickup'] = "";
              controller.dataRuteTender[x]['error_destinasi'] = "";
              if (controller.dataRuteTender[x]['pickup'] == "") {
                controller.dataRuteTender[x]['error_pickup'] =
                    "InfoPraTenderCreateLabelAlertLokasiPickUp"
                        .tr; //Lokasi Pickup Belum Dimasukan
                controller.validasiSimpan = false;
              }
              if (controller.dataRuteTender[x]['destinasi'] == "") {
                controller.dataRuteTender[x]['error_destinasi'] =
                    "InfoPraTenderCreateLabelAlertLokasiDestinasi"
                        .tr; //Lokasi Destinasi Belum Dimasukan
                controller.validasiSimpan = false;
              }
            }

            //PENGECEKAN LOKASI KEMBAR
            for (var x = 0; x < controller.dataRuteTender.length; x++) {
              if (controller.dataRuteTender[x]['pickup'] != "" &&
                  controller.dataRuteTender[x]['destinasi'] != "" &&
                  controller.dataRuteTender
                          .where((element) =>
                              element['pickup'] ==
                                  controller.dataRuteTender[x]['pickup'] &&
                              element['destinasi'] ==
                                  controller.dataRuteTender[x]['destinasi'])
                          .toList()
                          .length >
                      1) {
                controller.validasiSimpan = false;
              }
            }

            controller.dataRuteTender.refresh();

            break;
          }
        case 3:
          {
            controller.validasiSimpan =
                controller.formFive.currentState.validate();
            break;
          }
      }
    }

    if (controller.aktifPengecekan == false) {
      controller.validasiSimpan = true;
    }

    if (controller.validasiSimpan) {
      FocusScope.of(Get.context).unfocus();
      int saveIndex = 0;
      if (controller.satuanTender.value == 2) {
        saveIndex = 4;
      } else {
        saveIndex = 3;
      }
      if (controller.slideIndex.value != saveIndex) {
        controller.slideIndex.value++;
        controller.pageController.animateToPage(controller.slideIndex.value,
            duration: Duration(milliseconds: 500), curve: Curves.linear);
      } else {
        controller.cekEdit = await SharedPreferencesHelper.getHakAkses(
            "Edit Info Pra Tender",
            denganLoading: true);
        if (SharedPreferencesHelper.cekAkses(controller.cekEdit)) {
          if (controller.status.value == "3") {
            GlobalAlertDialog.showAlertDialogCustom(
                context: Get.context,
                title: "InfoPraTenderCreateLabelInfoKonfirmasiPembatalan"
                    .tr, //Konfirmasi Pembatalan
                message:
                    "InfoPraTenderEditLabelInfoApakahAndaYakinBatal" //Apakah anda yakin untuk membatalkan Pra Tender ini ?
                        .tr,
                labelButtonPriority1: GlobalAlertDialog.noLabelButton,
                onTapPriority1: () async {},
                onTapPriority2: () async {
                  controller.onSetData("SAVE");
                },
                labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
          } else {
            controller.onSetData("SAVE");
          }
        }
      }
    }
  }

  Future<bool> onWillPop() async {
    FocusManager.instance.primaryFocus.unfocus();
    controller.onSetData("COMPARE");
  }
}
