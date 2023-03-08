import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_toast.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_kebutuhan/list_halaman_peserta_detail_kebutuhan_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_pemenang/list_halaman_peserta_detail_pemenang_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_detail_penawaran/list_halaman_peserta_detail_penawaran_controller.dart';
import 'package:muatmuat/app/modules/ARK/pemenang_tender/list_halaman_peserta_pilih_pemenang/list_halaman_peserta_pilih_pemenang_controller.dart';
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
import 'list_halaman_peserta_controller.dart';

class ListHalamanPesertaView extends GetView<ListHalamanPesertaController> {
  String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(statusBarColor: Color(ListColor.colorBlue)));
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });

        return null;
      },
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
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(GlobalVariable.urlImageNavbar),
                          fit: BoxFit.fill),
                      color: Colors.white),
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
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: SvgPicture.asset(
                                        GlobalVariable.imagePath +
                                            "ic_back_button.svg",
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                        color: GlobalVariable
                                            .tabDetailAcessoriesMainColor))),
                            SizedBox(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                            ),
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Obx(() => CustomTextField(
                                      context: Get.context,
                                      textInputAction: TextInputAction.search,
                                      readOnly: true,
                                      onTap:
                                          controller.listPeserta.length != 0 ||
                                                  controller.isFilter
                                              ? () {
                                                  controller.goToSearchPage();
                                                }
                                              : null,
                                      textSize: 14,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      newInputDecoration: InputDecoration(
                                        isDense: true,
                                        isCollapsed: true,
                                        hintText:
                                            "ProsesTenderLihatPesertaLabelSearchPlaceholder" // Cari Peserta Tender
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
                                      ))),
                                  Obx(
                                    () => Container(
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
                                        color: controller.listPeserta.length ==
                                                    0 &&
                                                !controller.isFilter
                                            ? Color(ListColor.colorLightGrey2)
                                            : null,
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            24,
                                      ),
                                    ),
                                  )
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
                                child: Obx(() => (controller.listPeserta.length != 0)
                                    ? ((controller.sortBy.value != "")
                                        ? SvgPicture.asset(GlobalVariable.imagePath + "ic_sort_blue_on.svg",
                                            width: GlobalVariable.ratioWidth(Get.context) *
                                                24,
                                            height:
                                                GlobalVariable.ratioWidth(Get.context) *
                                                    24)
                                        : SvgPicture.asset(GlobalVariable.imagePath + "sorting_active.svg",
                                            width: GlobalVariable.ratioWidth(Get.context) *
                                                24,
                                            height:
                                                GlobalVariable.ratioWidth(Get.context) *
                                                    24))
                                    : SvgPicture.asset(
                                        GlobalVariable.imagePath + "sorting_disable.svg",
                                        color: GlobalVariable.tabDetailAcessoriesDisableColor,
                                        width: GlobalVariable.ratioWidth(Get.context) * 24,
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
              bottomNavigationBar: Obx(() => !controller.isLoadingData.value
                  ? (controller.listPeserta.length == 0 && controller.isFilter)
                      ? SizedBox()
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        10),
                                topRight: Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        10)),
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
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 16),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            SvgPicture.asset(
                              GlobalVariable.imagePath + "pemenangtender.svg",
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 30,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 30,
                            ),
                            SizedBox(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    12),
                            Expanded(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  "ProsesTenderLihatPesertaLabelPemenangTender"
                                      .tr, //Pemenang Tender
                                  color: Color(ListColor.colorBlack1B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                                SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            4),
                                CustomText(
                                  controller.mode == 'UBAH'
                                      ? "ProsesTenderLihatPesertaLabelSudahDitentukan"
                                          .tr //Sudah Ditentukan
                                      : "ProsesTenderLihatPesertaLabelBelumDitentukan"
                                          .tr, //Belum Ditentukan
                                  color: Color(ListColor.colorLightGrey4),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  height: 0.8,
                                ),
                              ],
                            )),
                            SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            Obx(() => IgnorePointer(
                                ignoring: (controller.listPeserta.length > 0)
                                    ? false
                                    : controller.masaSeleksi
                                        ? true
                                        : false,
                                child: MaterialButton(
                                  minWidth:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          160,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  20))),
                                  color: ((controller.cekPilihPemenang &&
                                              controller.mode != 'UBAH') ||
                                          (controller.cekLihatPemenang &&
                                              controller.mode == 'UBAH'))
                                      ? (controller.listPeserta.length > 0 &&
                                                  !controller
                                                      .isLoadingData.value &&
                                                  controller.masaSeleksi) ||
                                              controller.mode == 'UBAH'
                                          ? Color(ListColor.color4)
                                          : Color(ListColor.colorLightGrey2)
                                      : Color(ListColor.colorAksesDisable),
                                  onPressed: () async {
                                    var data;
                                    if (controller.mode == 'UBAH') {
                                      controller.cekLihatPemenang =
                                          await SharedPreferencesHelper
                                              .getHakAkses("Lihat Pemenang",
                                                  denganLoading: true);
                                      if (SharedPreferencesHelper.cekAkses(
                                          controller.cekLihatPemenang)) {
                                        data = await GetToPage.toNamed<
                                                ListHalamanPesertaDetailPemenangController>(
                                            Routes
                                                .LIST_HALAMAN_PESERTA_DETAIL_PEMENANG,
                                            arguments: [
                                              controller.dataRuteTender,
                                              controller.satuanTender,
                                              controller.satuanVolume,
                                              controller.idTender,
                                              controller.noTender,
                                              controller.judulTender,
                                              controller.muatan,
                                              controller.totalKebutuhan,
                                              controller.tipeListPeserta,
                                            ]);
                                      }
                                    } else {
                                      controller.cekPilihPemenang =
                                          await SharedPreferencesHelper
                                              .getHakAkses("Pilih Pemenang",
                                                  denganLoading: true);
                                      if (SharedPreferencesHelper.cekAkses(
                                          controller.cekPilihPemenang)) {
                                        if (controller.masaSeleksi) {
                                          data = await GetToPage.toNamed<
                                                  ListHalamanPesertaPilihPemenangController>(
                                              Routes
                                                  .LIST_HALAMAN_PESERTA_PILIH_PEMENANG,
                                              arguments: [
                                                controller.dataRuteTender,
                                                controller.satuanTender,
                                                controller.satuanVolume,
                                                controller.idTender,
                                                controller.noTender,
                                                controller.judulTender,
                                                controller.muatan,
                                                controller.totalKebutuhan,
                                                controller.tipeListPeserta,
                                                'TAMBAH'
                                              ]);
                                        } else {
                                          GlobalAlertDialog
                                              .showAlertDialogCustom(
                                            context: Get.context,
                                            title: "".tr, //Konfirmasi Simpan
                                            message:
                                                "ProsesTenderLihatPesertaLabelSilahkanMemilihPemenang"
                                                    .tr, //Silahkan memilih pemenang ketika periode
                                            labelButtonPriority1: "Ok",
                                            onTapPriority1: () {},
                                          );
                                        }
                                      }
                                    }

                                    if (data != null) {
                                      controller.refreshAll();
                                    }
                                  },
                                  child: CustomText(
                                    controller.mode == 'UBAH'
                                        ? "ProsesTenderLihatPesertaButtonLihatPemenang" //Lihat Pemenang
                                            .tr
                                        : "ProsesTenderLihatPesertaButtonPilihPemenang"
                                            .tr, // Pilih Pemenang
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    height: 1.2,
                                  ),
                                ))),
                          ]))
                  : SizedBox()),
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
                  Container(
                    width: MediaQuery.of(Get.context).size.width,
                    margin: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 16,
                      right: GlobalVariable.ratioWidth(Get.context) * 16,
                      top: GlobalVariable.ratioWidth(Get.context) * 14,
                      bottom: GlobalVariable.ratioWidth(Get.context) * 13,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(ListColor.colorDarkGrey5),
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 100),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(ListColor.colorShadow)
                                      .withOpacity(0.05),
                                  blurRadius: 2, //5
                                  spreadRadius: 2,
                                  offset: Offset(0, 2), // 5
                                ),
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          100),
                                ),
                                onTap: () {
                                  if (controller.listPeserta.length != 0 ||
                                      controller.isFilter)
                                    controller.showFilter();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            2,
                                    horizontal:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            13,
                                  ),
                                  decoration: BoxDecoration(
                                      color: controller.isFilter
                                          ? Color(ListColor
                                              .colorBackgroundFilterTender)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      border: Border.all(
                                          width: 1,
                                          color: controller.isFilter
                                              ? Color(ListColor.colorBlue)
                                              : Color(
                                                  ListColor.colorLightGrey7))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                          'ProsesTenderLihatPesertaButtonFilter'
                                              .tr, //"Filter",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: controller.isFilter
                                              ? Color(ListColor.colorBlue)
                                              : (controller
                                                          .listPeserta.length ==
                                                      0)
                                                  ? Color(
                                                      ListColor.colorLightGrey2)
                                                  : Color(ListColor
                                                      .colorDarkBlue2)),
                                      SizedBox(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            7,
                                      ),
                                      SvgPicture.asset(
                                        (controller.listPeserta.length == 0 &&
                                                !controller.isFilter)
                                            ? GlobalVariable.imagePath +
                                                "filter_disable.svg"
                                            : GlobalVariable.imagePath +
                                                "filter_active.svg",
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        !controller.isLoadingData.value
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: CustomText(
                                    'ProsesTenderLihatPesertaLabelTotalPesertaTender' // Total Peserta Tender
                                            .tr +
                                        " : ${GlobalVariable.formatCurrencyDecimal(controller.jumlahData.value.toString()).toString()}"
                                            .tr,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600))
                            : SizedBox()
                      ],
                    ),
                  ),
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
                                  GlobalVariable.ratioWidth(Get.context) * 10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(controller.judulTender,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      color: Color(ListColor.colorBlack1B),
                                      height: 1.2),
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          2),
                                  GestureDetector(
                                    child: CustomText(
                                      'ProsesTenderLihatPesertaLabelDetailKebutuhan' //Detail Kebutuhan
                                          .tr,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                      decoration: TextDecoration.underline,
                                      color: Color(ListColor.colorBlue),
                                    ),
                                    onTap: () async {
                                      var data = await GetToPage.toNamed<
                                              ListHalamanPesertaDetailKebutuhanController>(
                                          Routes
                                              .LIST_HALAMAN_PESERTA_DETAIL_KEBUTUHAN,
                                          arguments: [
                                            controller.dataRuteTender,
                                            controller.satuanTender,
                                            controller.satuanVolume
                                          ]);
                                      if (data != null) {}
                                    },
                                  )
                                ]),
                          )),
                          SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                controller.expand.value =
                                    !controller.expand.value;
                              },
                              child: Transform.rotate(
                                  angle: (controller.expand.value ? 0 : 180) *
                                      3.14 /
                                      180,
                                  child: SvgPicture.asset(
                                      GlobalVariable.imagePath +
                                          "Icon_Blue.svg",
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24)))
                          // IconButton(
                          //     icon: Obx(() => controller.expand.value
                          //         ? Icon(Icons.keyboard_arrow_up_rounded,
                          //             color: Color(ListColor.colorBlue))
                          //         : Icon(Icons.keyboard_arrow_down_rounded,
                          //             color: Color(ListColor.colorBlue))),
                          //     onPressed: () {
                          //       controller.expand.value =
                          //           !controller.expand.value;
                          //     }),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: GlobalVariable.ratioWidth(Get.context) * 14,
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 10),
                              bottomRight: Radius.circular(
                                  GlobalVariable.ratioWidth(Get.context) *
                                      10))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              // margin: EdgeInsets.only(
                              //   bottom:
                              //       GlobalVariable.ratioWidth(Get.context) *
                              //           16,
                              // ),
                              decoration: BoxDecoration(
                                  color: Color(ListColor.colorHeaderListTender),
                                  border: Border.all(
                                      color: Color(ListColor.colorBlue),
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(GlobalVariable.ratioWidth(
                                              Get.context) *
                                          4))),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            12,
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          'ProsesTenderLihatPesertaLabelNomorTender'
                                              .tr,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        ), // No. Tender
                                        SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                6),
                                        CustomText(
                                          controller.noTender,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ],
                                    ),
                                  )),
                                  Container(
                                      color: Color(ListColor.colorBlue),
                                      width: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          2,
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          34),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                'ProsesTenderLihatPesertaLabelNomorPraTender'
                                                    .tr,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                              SizedBox(
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          6), // No. Pra Tender
                                              CustomText(
                                                controller.noPraTender,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ],
                                          )))
                                ],
                              )),
                          Obx(() => controller.expand.value
                              ? SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                GlobalVariable.imagePath +
                                                    "muatan.svg",
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16),
                                            SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            Expanded(
                                                child: Container(
                                                    child: CustomText(
                                              "ProsesTenderLihatPesertaLabelMuatan" // Muatan
                                                  .tr,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color(
                                                  ListColor.colorLightGrey14),
                                            )))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        24),
                                            Expanded(
                                                child: Container(
                                                    child: CustomText(
                                              controller.muatan,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              height: 1.2,
                                              fontWeight: FontWeight.w600,
                                            )))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            16,
                                      ),
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
                                                    "periode.svg",
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16),
                                            SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            Expanded(
                                                child: Container(
                                                    child: CustomText(
                                              "ProsesTenderLihatPesertaLabelPeriodePengumumanPemenang" // Periode Pengumuman Pemenang
                                                  .tr,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              //
                                              color: Color(
                                                  ListColor.colorLightGrey14),
                                            )))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        24),
                                            CustomText(
                                              controller
                                                  .tglPengumumanPemenangAw,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              height: 1.4,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        18,
                                                    right: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        18,
                                                    top: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        2),
                                                child: CustomText(
                                                  'ProsesTenderLihatPesertaLabelSampaiDengan' //s/d
                                                      .tr,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 12,
                                                  height: 1.4,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(
                                                      ListColor.colorBlack1B),
                                                )),
                                            Expanded(
                                                child: Container(
                                                    child: CustomText(
                                              controller
                                                  .tglPengumumanPemenangAk,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14,
                                              height: 1.4,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color(ListColor.colorBlack1B),
                                            )))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox())
                        ],
                      ),
                    ),
                  ],
                )),
          )
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
          : (controller.listPeserta.length == 0 &&
                  !controller.isLoadingData.value &&
                  controller.isFilter)
              ? Center(
                  child: Container(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                        GlobalVariable.imagePath +
                            "ic_pencarian_tidak_ditemukan.svg",
                        width: GlobalVariable.ratioWidth(Get.context) * 82,
                        height: GlobalVariable.ratioWidth(Get.context) * 93),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 15),
                    CustomText(
                        'ProsesTenderLihatPesertaLabelDatatidakDitemukan'
                                .tr + // Data Tidak Ditemukan
                            '\n' +
                            'ProsesTenderLihatPesertaLabelMohoncobahapusbeberapafilter'
                                .tr, // Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('ProsesTenderLihatPesertaLabelatau'.tr, //Atau
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorLightGrey4)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 20),
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
                            controller.showFilter();
                          },
                          child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          24,
                                      vertical: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20)),
                                  child: Center(
                                    child: CustomText(
                                        'ProsesTenderLihatPesertaButtonAturUlangFilter'
                                            .tr, //'Atur Ulang Filter'.tr,
                                        fontSize: 12,
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600),
                                  )))),
                    )
                  ],
                )))
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
          await controller.getListPeserta(
              controller.countData.value, controller.filter);
        },
        onRefresh: () async {
          controller.listPeserta.clear();
          controller.isLoadingData.value = true;
          controller.countData.value = 1;
          await controller.getListPeserta(1, controller.filter);
        },
        child: Container(
            child: SingleChildScrollView(
                child: Column(children: [
          _showListHeaderPeserta(),

          //KALAU TIDAK ADA DATA
          (controller.listPeserta.length == 0 &&
                  !controller.isLoadingData.value &&
                  !controller.isFilter)
              ? Center(
                  child: Container(
                      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 66,
                    ),
                    Container(
                        width: GlobalVariable.ratioWidth(Get.context) * 83,
                        height: GlobalVariable.ratioWidth(Get.context) * 75,
                        child: Image.asset(
                            GlobalVariable.imagePath + "tidak_ada_data.png")),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 15),
                    CustomText(
                        'ProsesTenderLihatPesertaLabelBelumAda'.tr +
                            '\n' +
                            'ProsesTenderLihatPesertaLabelPesertaTender'
                                .tr, //"Belum Ada Peserta Tender".tr,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3))
                  ],
                )))
              : _listPesertaTile()
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
                onTap: () async {
                  var data = await GetToPage.toNamed<
                          ListHalamanPesertaDetailPenawaranController>(
                      Routes.LIST_HALAMAN_PESERTA_DETAIL_PENAWARAN,
                      arguments: [
                        controller.dataRuteTender,
                        controller.satuanTender,
                        controller.satuanVolume,
                        controller.listPeserta[index]['transporter'] +
                            " (" +
                            controller.listPeserta[index]['kota'] +
                            ")",
                        controller.listPeserta[index]['tanggalDibuat'] +
                            " " +
                            controller.listPeserta[index]['jamDibuat'] +
                            " " +
                            controller.listPeserta[index]['zonaWaktu'],
                        controller.idTender,
                        controller.listPeserta[index]['idtransporter']
                      ]);
                  if (data != null) {}
                },
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
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 22,
                              ),
                              Container(
                                child: CustomText(
                                    controller.listPeserta[index]
                                            ['tanggalDibuat'] +
                                        "\n" +
                                        controller.listPeserta[index]
                                            ['jamDibuat'] +
                                        " " +
                                        controller.listPeserta[index]
                                            ['zonaWaktu'],
                                    fontSize: 10,
                                    height: 1.3,
                                    textAlign: TextAlign.right,
                                    color: Color(ListColor.colorBlue),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 5,
                              ),
                              GestureDetector(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                        top: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            2,
                                      ),
                                      child: SvgPicture.asset(
                                          GlobalVariable.imagePath +
                                              "more_vert.svg",
                                          color: Color(ListColor.colorIconVert),
                                          width: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              24)),
                                  onTap: () {
                                    controller.opsi(controller
                                        .listPeserta[index]['idtransporter']);
                                  }),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                            controller.listPeserta[index]['hargaPenawaranTerkecil'] !=
                                                    controller.listPeserta[index][
                                                        'hargaPenawaranTerbesar']
                                                ? ('Rp' +
                                                    GlobalVariable.formatCurrencyDecimal(
                                                        controller.listPeserta[index][
                                                            'hargaPenawaranTerkecil']) +
                                                    ' - Rp' +
                                                    GlobalVariable.formatCurrencyDecimal(
                                                        controller.listPeserta[index]
                                                            [
                                                            'hargaPenawaranTerbesar']))
                                                : ('Rp' +
                                                    GlobalVariable.formatCurrencyDecimal(
                                                        controller.listPeserta[index]
                                                            ['hargaPenawaranTerkecil'])),
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            height: 1.2,
                                            fontWeight: FontWeight.w500,
                                            //
                                            color: Color(ListColor.colorGrey4),
                                          )))
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
                                  color: Color(ListColor.colorBlue),
                                  child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                18),
                                      ),
                                      onTap: () async {
                                        var data = await GetToPage.toNamed<
                                                ListHalamanPesertaDetailPenawaranController>(
                                            Routes
                                                .LIST_HALAMAN_PESERTA_DETAIL_PENAWARAN,
                                            arguments: [
                                              controller.dataRuteTender,
                                              controller.satuanTender,
                                              controller.satuanVolume,
                                              controller.listPeserta[index]
                                                      ['transporter'] +
                                                  " (" +
                                                  controller.listPeserta[index]
                                                      ['kota'] +
                                                  ")",
                                              controller.listPeserta[index]
                                                      ['tanggalDibuat'] +
                                                  " " +
                                                  controller.listPeserta[index]
                                                      ['jamDibuat'] +
                                                  " " +
                                                  controller.listPeserta[index]
                                                      ['zonaWaktu'],
                                              controller.idTender,
                                              controller.listPeserta[index]
                                                  ['idtransporter']
                                            ]);
                                        if (data != null) {}
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      24,
                                              vertical:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      7),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          20)),
                                          child: Center(
                                            child: CustomText(
                                                'ProsesTenderLihatPesertaButtonDetail'
                                                    .tr, //'Detail'.tr,
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
}
