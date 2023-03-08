import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang/list_pilih_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_pilih_pemenang_telah_dipilih/list_pilih_pemenang_telah_dipilih_controller.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/appbar_with_Tab2.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_below_app_header_theme1_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/button_filter_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'dart:math' as math;
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

class ListPilihPemenangView extends GetView<ListPilihPemenangController> {
  String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(statusBarColor: Color(ListColor.colorBlue)));
    return WillPopScope(
      onWillPop: onWillPop,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarColor: Color(ListColor.colorBlue),
              statusBarIconBrightness: Brightness.light),
          child: Container(
              child: SafeArea(
            child: Scaffold(
              backgroundColor: Color(ListColor.colorLightGrey6),
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    GlobalVariable.ratioWidth(Get.context) * 56),
                child: Container(
                  height: GlobalVariable.ratioWidth(Get.context) * 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Column(mainAxisSize: MainAxisSize.max, children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            GlobalVariable.ratioWidth(Get.context) * 16,
                            GlobalVariable.ratioWidth(Get.context) * 12,
                            GlobalVariable.ratioWidth(Get.context) * 16,
                            GlobalVariable.ratioWidth(Get.context) * 11.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                child: GestureDetector(
                                    onTap: onWillPop,
                                    child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          "ic_back_blue_button.svg",
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                    ))),
                            SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                            ),
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  CustomTextField(
                                      readOnly: true,
                                      onTap: () {
                                        controller.goToSearchPage();
                                      },
                                      context: Get.context,
                                      textInputAction: TextInputAction.search,
                                      textSize: 14,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      newInputDecoration: InputDecoration(
                                        isDense: true,
                                        isCollapsed: true,
                                        hintText:
                                            "ProsesTenderLihatPesertaLabelSearchPlaceholderPemenang" // Cari Peserta
                                                .tr,
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        filled: true,
                                        contentPadding: EdgeInsets.only(
                                          left: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              32,
                                          right: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              30,
                                          top: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              9,
                                          bottom: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              6,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey7),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1),
                                          borderRadius: BorderRadius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(
                                                  ListColor.colorLightGrey7),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1),
                                          borderRadius: BorderRadius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(ListColor.color4),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  1),
                                          borderRadius: BorderRadius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                        ),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            6,
                                        right: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            2),
                                    child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          "ic_search_blue.svg",
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 16,
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (controller.listPeserta.length != 0)
                                    controller.showSortingDialog();
                                },
                                child: Obx(() => controller.listPeserta.length >
                                        0
                                    ? controller.sortBy.value == ""
                                        ? SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg",
                                            color: Colors.black,
                                            width: GlobalVariable.ratioWidth(Get.context) *
                                                24,
                                            height:
                                                GlobalVariable.ratioWidth(Get.context) *
                                                    24)
                                        : SvgPicture.asset(
                                            GlobalVariable.imagePath +
                                                "ic_sort_black_on.svg",
                                            width:
                                                GlobalVariable.ratioWidth(Get.context) *
                                                    24,
                                            height:
                                                GlobalVariable.ratioWidth(Get.context) *
                                                    24)
                                    : //
                                    SvgPicture.asset(
                                        GlobalVariable.imagePath + "sorting_active.svg",
                                        width: GlobalVariable.ratioWidth(Get.context) * 24,
                                        color: Color(ListColor.colorLightGrey2),
                                        height: GlobalVariable.ratioWidth(Get.context) * 24)))
                          ],
                        ),
                      ),
                    ]),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        color: Color(ListColor.colorLightBlue5))
                  ]),
                ),
              ),
              body: _listPeserta(),
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
                    vertical: GlobalVariable.ratioWidth(Get.context) * 12,
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 96),
                child: MaterialButton(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    vertical: GlobalVariable.ratioWidth(Get.context) * 8,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 20))),
                  color: Color(ListColor.color4),
                  onPressed: () {
                    controller.save();
                  },
                  child: CustomText(
                    "ProsesTenderLihatPesertaButtonSimpan".tr, // Simpan
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ))),
    );
  }

  Widget _listPeserta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: _showListPeserta()),
                ]),
          ),
        )
      ],
    );
  }

  Widget _showListHeaderPeserta() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {},
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 20,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    0),
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    GlobalVariable.ratioWidth(Get.context) * 16),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: GlobalVariable.ratioWidth(Get.context) * 1,
                      color: Color(ListColor.colorLightGrey10)),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 12)),
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 10,
                  //     spreadRadius: 2,
                  //     offset: Offset(0, 5),
                  //   ),
                  // ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      controller.lokasi,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(ListColor.colorBlack1B),
                    ), // No. Tender
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 4),
                    CustomText(
                      GlobalVariable.formatCurrencyDecimal(
                              controller.nilaiMuatan) +
                          (controller.satuanTender == 2
                              ? " Unit"
                              : controller.satuanTender == 1
                                  ? " Ton"
                                  : " " + controller.satuanVolume),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    controller.satuanTender == 2
                        ? Column(
                            children: [
                              SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          4),
                              CustomText(controller.namaTruk,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3)),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 24),
                    Material(
                      borderRadius: BorderRadius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 20),
                      color: Colors.transparent,
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 18),
                          ),
                          onTap: () async {
                            GlobalAlertDialog.showAlertDialogCustom(
                                context: Get.context,
                                title:
                                    "ProsesTenderLihatPesertaLabelKonfirmasiTanpaPemenang"
                                        .tr, //Konfirmasi Tanpa Pemenang
                                message:
                                    "ProsesTenderLihatPesertaLabelMenentukanTanpaPemenang"
                                        .tr, //Apakah Anda yakin ingin menentukan tanpa pemenang?
                                labelButtonPriority1:
                                    GlobalAlertDialog.noLabelButton,
                                onTapPriority1: () {},
                                onTapPriority2: () async {
                                  controller.datapemenang.clear();
                                  Get.back(result: ["TANPA PEMENANG"]);
                                },
                                labelButtonPriority2:
                                    GlobalAlertDialog.yesLabelButton);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(ListColor.colorBlue)),
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20)),
                              child: Center(
                                child: CustomText(
                                    'ProsesTenderLihatPesertaLabelPutuskanRuteTanpaPemenang'
                                        .tr, //'Putuskan Rute Tanpa Pemenang'.tr,
                                    fontSize: 14,
                                    color: Color(ListColor.colorBlue),
                                    fontWeight: FontWeight.w600),
                              ))),
                    )
                  ],
                )),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
          GestureDetector(
            onTap: () async {},
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    0,
                    GlobalVariable.ratioWidth(Get.context) * 16,
                    0),
                padding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioWidth(Get.context) * 14,
                    GlobalVariable.ratioWidth(Get.context) * 10,
                    GlobalVariable.ratioWidth(Get.context) * 14,
                    GlobalVariable.ratioWidth(Get.context) * 10),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: GlobalVariable.ratioWidth(Get.context) * 1,
                      color: Color(ListColor.colorLightGrey10)),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 12)),
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 10,
                  //     spreadRadius: 2,
                  //     offset: Offset(0, 5),
                  //   ),
                  // ],
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  SvgPicture.asset(
                    GlobalVariable.imagePath + "pemenangtender.svg",
                    width: GlobalVariable.ratioWidth(Get.context) * 30,
                    height: GlobalVariable.ratioWidth(Get.context) * 30,
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        "ProsesTenderLihatPesertaLabelPemenangTenderTelahDipilih"
                            .tr, //Pemenang Telah Dipilih
                        color: Color(ListColor.colorBlack1B),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                          height: GlobalVariable.ratioWidth(Get.context) * 4),
                      CustomText(
                        "ProsesTenderLihatPesertaLabelTotal".tr +
                            " : " +
                            controller.totalPesertaDipilih.value.toString() +
                            " " +
                            "ProsesTenderLihatPesertaLabelPeserta"
                                .tr, //Total : 5 Peserta
                        color: Color(ListColor.colorLightGrey4),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                  Material(
                    borderRadius: BorderRadius.circular(
                        GlobalVariable.ratioWidth(Get.context) * 20),
                    color: Colors.transparent,
                    child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 18),
                        ),
                        onTap: controller.datapemenang.length > 0
                            ? () async {
                                var data = await GetToPage.toNamed<
                                        ListPilihPemenangTelahDipilihController>(
                                    Routes.LIST_PILIH_PEMENANG_TELAH_DIPILIH,
                                    arguments: [
                                      controller.idTender,
                                      controller.satuanTender,
                                      controller.satuanVolume,
                                      controller.nilaiMuatan,
                                      controller.lokasi,
                                      controller.namaTruk,
                                      controller.datapemenang,
                                      controller.nilaiMuatan,
                                      controller.idrute
                                    ]);

                                if (data == null) {
                                  controller.isLoadingData.value = true;
                                  controller.listPeserta.clear();
                                  controller.listPeserta.refresh();
                                  controller.hitungPemenang();
                                  await controller.getListPeserta(1);
                                }
                              }
                            : null,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 12,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) * 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller.datapemenang.length > 0
                                        ? Color(ListColor.colorBlue)
                                        : Color(ListColor.colorLightGrey2)),
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        20)),
                            child: Center(
                              child: CustomText(
                                  'ProsesTenderLihatPesertaButtonLihat'
                                      .tr, //'Lihat'.tr,
                                  fontSize: 12,
                                  color: controller.datapemenang.length > 0
                                      ? Color(ListColor.colorBlue)
                                      : Color(ListColor.colorLightGrey2),
                                  fontWeight: FontWeight.w600),
                            ))),
                  )
                ])),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 24),
        ]);
  }

  Widget _showListPeserta() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          : _listPesertaRefresher()
    ]);
  }

  Widget _listPesertaRefresher() {
    return SmartRefresher(
        enablePullUp:
            controller.listPeserta.length == controller.jumlahData.value
                ? false
                : true,
        controller: controller.refreshController,
        onLoading: () async {
          controller.countData.value += 1;
          await controller.getListPeserta(controller.countData.value);
        },
        onRefresh: () async {
          controller.listPeserta.clear();
          controller.isLoadingData.value = true;
          controller.countData.value = 1;
          await controller.getListPeserta(1);
        },
        child: Container(
            child: SingleChildScrollView(
                child: Column(children: [
          _showListHeaderPeserta(),

          //KALAU TIDAK ADA DATA
          _listPesertaTile()
        ]))));
  }

  Widget _listPesertaTile() {
    return Container(
        child: Column(children: [
      for (var index = 0; index < controller.listPeserta.length; index++)
        Container(
            child: Column(
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
                        GlobalVariable.ratioWidth(Get.context) * 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 12)),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              GlobalVariable.ratioWidth(Get.context) * 16,
                              GlobalVariable.ratioWidth(Get.context) * 8,
                              GlobalVariable.ratioWidth(Get.context) * 13,
                              GlobalVariable.ratioWidth(Get.context) * 7),
                          decoration: BoxDecoration(
                              color: Color(ListColor.colorHeaderListTender),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10),
                                  topRight: Radius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          10))),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          controller.listPeserta[index]
                                              ['transporter'],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          wrapSpace: true,
                                          height: 1.2),
                                      CustomText(
                                          controller.listPeserta[index]['kota'],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                          color: Color(ListColor.colorGrey3),
                                          height: 1.2)
                                    ]),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(borderRadius),
                            //     bottomRight: Radius.circular(borderRadius))
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "hargapenawaran.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          Expanded(
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          2),
                                                  child: CustomText(
                                                    "ProsesTenderLihatPesertaLabelHargaPenawaran"
                                                        .tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 14, //14
                                                    fontWeight: FontWeight.w700,
                                                    //
                                                    color: Colors.black,
                                                  )))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24),
                                          Expanded(
                                              child: Container(
                                                  child: CustomText(
                                            'Rp' +
                                                GlobalVariable
                                                    .formatCurrencyDecimal(
                                                        controller.listPeserta[
                                                                index]
                                                            ['hargaPenawaran']),
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            height: 1.2,
                                            fontWeight: FontWeight.w500,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          )))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          10,
                                    ),
                                    //DOKUMEN
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "dokumen.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          Expanded(
                                              child: Container(
                                                  child: CustomText(
                                            "ProsesTenderLihatPesertaLabelDokumenPenawaran"
                                                .tr,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            //
                                            color: Colors.black,
                                          )))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          6,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller
                                            .getPenawaranTransporter(index);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24),
                                          CustomText(
                                            "ProsesTenderLihatPesertaLabelFilePenawaran"
                                                .tr, // File Penawaran
                                            fontSize: 14,
                                            height: 1.2,
                                            fontWeight: FontWeight.w500,
                                            color: Color(ListColor.colorBlue),
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  4),
                                          SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "download_dokumen.svg",
                                              color: Color(ListColor.colorBlue),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(Get.context).size.width,
                          height: 0.5,
                          color: Color(ListColor.colorLightGrey2),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                left:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                top: GlobalVariable.ratioWidth(Get.context) *
                                    7.5,
                                bottom:
                                    GlobalVariable.ratioWidth(Get.context) * 7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10),
                                    bottomRight: Radius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            10))),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomText(""),
                                  ],
                                )),
                                Material(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          20),
                                  color: GlobalVariable.formatCurrencyDecimal(
                                              controller.sisaMuatan) !=
                                          "0"
                                      ? Color(ListColor.colorBlue)
                                      : Color(ListColor.colorLightGrey2),
                                  child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18),
                                      ),
                                      onTap: GlobalVariable.formatCurrencyDecimal(
                                                  controller.sisaMuatan) !=
                                              "0"
                                          ? () async {
                                              controller.pilih(index);
                                            }
                                          : null,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                              vertical: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  7),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  GlobalVariable.ratioWidth(Get.context) * 20)),
                                          child: Center(
                                            child: CustomText(
                                                'ProsesTenderLihatPesertaButtonPilih'
                                                    .tr, //'Pilih'.tr,
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ))),
                                )
                              ],
                            ))
                      ],
                    )),
              )
            ]))
    ]));
  }

  Future<bool> onWillPop() async {
    //JIKA JUMLAHNYA MAP SEBELUMNYA DAN AP SEKARANG TIDAK SAMA
    if (controller.datapemenang.length !=
        controller.datapemenangSebelumDisimpan.length) {
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
            Get.back(
                result: ["PEMENANG", controller.datapemenangSebelumDisimpan]);
          },
          labelButtonPriority2: GlobalAlertDialog.yesLabelButton);
    } else {
      Get.back(result: ["PEMENANG", controller.datapemenangSebelumDisimpan]);
    }
  }
}
