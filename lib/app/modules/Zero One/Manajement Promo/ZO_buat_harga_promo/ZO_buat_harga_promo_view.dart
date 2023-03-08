import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/function/global_alert_dialog.dart';
import 'package:muatmuat/app/modules/Zero%20One/Manajement%20Promo/ZO_buat_harga_promo/ZO_buat_harga_promo_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/checkbox_custom_widget_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/radio_button_custom_widget_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/radio_button_custom_with_text_widget_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'dart:math' as math;

class ZoBuatHargaPromoView extends GetView<ZoBuatHargaPromoController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {},
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(ListColor.colorYellow),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: Material(
                      shape: CircleBorder(),
                      color: Colors.black,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              width: GlobalVariable.ratioFontSize(context) * 28,
                              height:
                                  GlobalVariable.ratioFontSize(context) * 28,
                              child: Center(
                                  child: Icon(
                                Icons.arrow_back_ios_rounded,
                                size:
                                    GlobalVariable.ratioFontSize(context) * 19,
                                color: Color(ListColor.colorYellow),
                              ))))),
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
              Expanded(
                child: CustomText(
                  "Buat Harga Promo".tr,
                  color: Colors.black,
                  fontSize: GlobalVariable.ratioFontSize(context) * 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: _appBar.preferredSize.height,
                  color: Color(ListColor.colorYellow),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 0.5,
                          child: Container(color: Colors.black)),
                      Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Obx(() => CustomText(
                                      controller.title.value,
                                      color: Colors.black,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              context) *
                                          16,
                                      fontWeight: FontWeight.w600)),
                                )),
                                Obx(
                                  () => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (int i = 0; i < 4; i++)
                                        _buildPageIndicator(
                                            i == controller.slideIndex.value, i)
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                controller.slideIndex.value = index;
                                controller.updateTitle();
                              },
                              controller: controller.pageController,
                              children: [
                                Container(
                                  color: Color(ListColor.colorLightGrey6),
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      MediaQuery.of(Get.context).size.height,
                                  child: pilihPickupPage(),
                                ),
                                Container(
                                  color: Color(ListColor.colorLightGrey6),
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      MediaQuery.of(Get.context).size.height,
                                  child: pilihDestinasiPage(),
                                ),
                                Container(
                                  color: Color(ListColor.colorLightGrey6),
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      MediaQuery.of(Get.context).size.height,
                                  child: tarifKuotaPromoPage(),
                                ),
                                Container(
                                  color: Color(ListColor.colorLightGrey6),
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      MediaQuery.of(Get.context).size.height,
                                  child: spesifikasiPromoPage(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    GlobalVariable.ratioWidth(Get.context) * 16,
                                vertical:
                                    GlobalVariable.ratioWidth(Get.context) *
                                        12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withAlpha(70),
                                      offset: Offset(0, -2),
                                      blurRadius: 2,
                                      spreadRadius: 3)
                                ]),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Obx(() => Opacity(
                                        opacity:
                                            controller.slideIndex.value == 0
                                                ? 0
                                                : 1,
                                        child: controller.slideIndex.value == 0
                                            ? SizedBox.shrink()
                                            : MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    side: BorderSide(
                                                        color: Color(
                                                            ListColor.color4))),
                                                onPressed: () {
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      .unfocus();
                                                  var valid = false;
                                                  switch (controller
                                                      .slideIndex.value) {
                                                    case 0:
                                                      {
                                                        valid = true;
                                                        break;
                                                      }
                                                    case 1:
                                                      {
                                                        valid = true;
                                                        break;
                                                      }
                                                    case 2:
                                                      {
                                                        valid = true;
                                                        break;
                                                      }
                                                    case 3:
                                                      {
                                                        valid = true;
                                                        break;
                                                      }
                                                  }
                                                  if (valid) {
                                                    FocusScope.of(Get.context)
                                                        .unfocus();
                                                    if (controller
                                                            .slideIndex.value !=
                                                        4) {
                                                      controller
                                                          .slideIndex.value--;
                                                      controller.pageController
                                                          .animateToPage(
                                                              controller
                                                                  .slideIndex
                                                                  .value,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                              curve: Curves
                                                                  .linear);
                                                    }
                                                  }
                                                },
                                                child: CustomText(
                                                    "SubscriptionCreateLabelSebelumnya"
                                                        .tr,
                                                    color: Color(
                                                        ListColor.color4)),
                                              ),
                                      )),
                                ),
                                Container(width: 25),
                                Expanded(
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    color: Color(ListColor.color4),
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();
                                      var valid = false;
                                      switch (controller.slideIndex.value) {
                                        case 0:
                                          {
                                            valid = true;
                                            break;
                                          }
                                        case 1:
                                          {
                                            valid = true;
                                            break;
                                          }
                                        case 2:
                                          {
                                            valid = true;
                                            break;
                                          }
                                        case 3:
                                          {
                                            valid = true;
                                            break;
                                          }
                                      }
                                      if (valid) {
                                        FocusScope.of(Get.context).unfocus();
                                        if (controller.slideIndex.value != 3) {
                                          controller.slideIndex.value++;
                                          controller.pageController
                                              .animateToPage(
                                                  controller.slideIndex.value,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.linear);
                                        }
                                        // else {
                                        //   GlobalAlertDialog
                                        //       .showAlertDialogCustom(
                                        //           context: Get.context,
                                        //           title:
                                        //               "LelangMuatBuatLelangBuatLelangLabelTitleKonfirmasiPembuatanLelang"
                                        //                   .tr,
                                        //           message:
                                        //               "LelangMuatBuatLelangBuatLelangLabelTitlePastikanData"
                                        //                   .tr
                                        //                   .replaceAll(
                                        //                       "\\n", "\n"),
                                        //           isShowCloseButton: true,
                                        //           isDismissible: true,
                                        //           positionColorPrimaryButton:
                                        //               PositionColorPrimaryButton
                                        //                   .PRIORITY2,
                                        //           labelButtonPriority1:
                                        //               "LelangMuatTabAktifTabAktifLabelTitleConfirmYes"
                                        //                   .tr,
                                        //           labelButtonPriority2:
                                        //               "LelangMuatTabAktifTabAktifLabelTitleConfirmNo"
                                        //                   .tr,
                                        //           onTapPriority2: () {
                                        //             controller.saveLelangMuatan(
                                        //                 controller
                                        //                     .dateAwal.value,
                                        //                 controller
                                        //                     .dateAkhir.value,
                                        //                 controller
                                        //                     .radioButtonTerbukaTertutup
                                        //                     .value);
                                        //           });
                                        // }
                                      }
                                    },
                                    child: Obx(() => CustomText(
                                        controller.slideIndex.value == 3
                                            ? "LelangMuatBuatLelangBuatLelangLabelTitleSave"
                                                .tr
                                            : "SubscriptionCreateLabelSelanjutnya"
                                                .tr,
                                        color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCurrentPage
                    ? Color(ListColor.colorBlue)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(ListColor.colorBlue), width: 2),
              ),
            ),
            Center(
              child: CustomText(
                (index + 1).toString(),
                color:
                    isCurrentPage ? Color(ListColor.colorYellow) : Colors.black,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        index == 3
            ? SizedBox.shrink()
            : Container(height: 2, width: 5, color: Color(ListColor.colorBlue))
      ],
    );
  }

  Widget pilihPickupPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          GlobalVariable.ratioFontSize(Get.context) * 16,
          GlobalVariable.ratioFontSize(Get.context) * 20,
          GlobalVariable.ratioFontSize(Get.context) * 16,
          GlobalVariable.ratioFontSize(Get.context) * 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            labelForm("Buat Data Lokasi", Colors.black, 14, FontWeight.w600),
            sizedBoxJarak(24),
            namalokasi(),
            sizedBoxJarak(24),
            kotakabupaten(),
            sizedBoxJarak(24),
            provinsi(),
            sizedBoxJarak(24),
            kecamatan()
          ],
        ),
      ),
    );
  }

  Widget pilihDestinasiPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioFontSize(Get.context) * 16,
            GlobalVariable.ratioFontSize(Get.context) * 20,
            GlobalVariable.ratioFontSize(Get.context) * 16,
            0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(child: btnTukarLokasi()),
            sizedBoxJarak(20),
            labelForm("Buat Data Lokasi", Colors.black, 14, FontWeight.w600),
            sizedBoxJarak(24),
            namalokasi(),
            sizedBoxJarak(24),
            kotakabupaten(),
            sizedBoxJarak(24),
            provinsi(),
            sizedBoxJarak(24),
            kecamatan()
          ],
        ),
      ),
    );
  }

  Widget tarifKuotaPromoPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioFontSize(Get.context) * 16,
            GlobalVariable.ratioFontSize(Get.context) * 20,
            GlobalVariable.ratioFontSize(Get.context) * 16,
            0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            jenisTruck(),
            sizedBoxJarak(24),
            jenisCarrier(),
            sizedBoxJarak(24),
            jumlahKuotaPromo(),
            sizedBoxJarak(24),
            hargaPromo(),
            sizedBoxJarak(24),
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                color: Color(ListColor.colorRed),
                onPressed: () {},
                child: labelForm("Hapus".tr, Colors.white, 12, FontWeight.w600),
              ),
            ),
            sizedBoxJarak(24),
            dividerCust()
          ],
        ),
      ),
    );
  }

  Widget spesifikasiPromoPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioFontSize(Get.context) * 16,
            GlobalVariable.ratioFontSize(Get.context) * 20,
            GlobalVariable.ratioFontSize(Get.context) * 16,
            0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            labelForm("Periode Promo*".tr, Color(ListColor.colorGrey3), 14,
                FontWeight.w700),
            sizedBoxJarak(8),
            _formFilterDate(),
            sizedBoxJarak(24),
            pembayaran(),
            sizedBoxJarak(24),
            keteranganPromo(),
            sizedBoxJarak(24),
            brosurGambarPromo(),
          ],
        ),
      ),
    );
  }

  _formFilterDate() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  CustomTextField(
                      key: ValueKey("periodeAwalController"),
                      context: Get.context,
                      readOnly: true,
                      onTap: () {
                        // controller.datestartPicker();
                      },
                      controller: controller.periodeAwalController.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 12,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 10),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText: "LelangMuatBuatLelangBuatLelangLabelTitleAwal"
                            .tr, // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: controller.isKosongPeriodeAwal.value
                                  ? Color(ListColor.colorRed)
                                  : Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: controller.isKosongPeriodeAwal.value
                                  ? Color(ListColor.colorRed)
                                  : Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: controller.isKosongPeriodeAwal.value
                                  ? Color(ListColor.colorRed)
                                  : Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // controller.datestartPicker();
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: SvgPicture.asset("assets/ic_calendar.svg",
                                color: Color(ListColor.colorLightGrey4),
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    24)),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(Get.context) * 8,
            ),
            Container(
              child: CustomText(
                "s/d",
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorLightGrey4),
              ),
            ),
            SizedBox(
              width: GlobalVariable.ratioWidth(Get.context) * 8,
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  CustomTextField(
                      key: ValueKey("periodeAkhirController"),
                      context: Get.context,
                      readOnly: true,
                      onTap: () {
                        // if (controller.isSelectStartDate.value) {
                        //   controller.dateendPicker();
                        // }
                      },
                      controller: controller.periodeAkhirController.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 12,
                          vertical:
                              GlobalVariable.ratioWidth(Get.context) * 10),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      newInputDecoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        hintText:
                            "LelangMuatBuatLelangBuatLelangLabelTitleAkhir"
                                .tr, // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey4),
                            fontWeight: FontWeight.w600),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: controller.isKosongPeriodeAkhir.value
                                  ? Color(ListColor.colorRed)
                                  : Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: controller.isKosongPeriodeAkhir.value
                                  ? Color(ListColor.colorRed)
                                  : Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: controller.isKosongPeriodeAkhir.value
                                  ? Color(ListColor.colorRed)
                                  : Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // if (controller.isSelectStartDate.value) {
                          //   controller.dateendPicker();
                          // }
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: SvgPicture.asset("assets/ic_calendar.svg",
                                color: Color(ListColor.colorLightGrey4),
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    24)),
                      )),
                ],
              ),
            ),
          ],
        ),
        if ((controller.isKosongPeriodeAwal.value ||
                controller.isKosongPeriodeAkhir.value) ||
            (controller.isKosongPeriodeAwal.value &&
                controller.isKosongPeriodeAkhir.value))
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: controller.isKosongPeriodeAwal.value
                      ? labelForm(
                          "LelangMuatTabHistoryTabHistoryLabelTitleNotifPeriodeAwal"
                              .tr,
                          Color(ListColor.colorRed),
                          14,
                          FontWeight.w600)
                      : labelForm(
                          "", Color(ListColor.colorRed), 14, FontWeight.w600)),
              SizedBox(
                width: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              Container(
                child: CustomText(
                  "     ",
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                  fontWeight: FontWeight.w600,
                  color: Color(ListColor.colorLightGrey4),
                ),
              ),
              SizedBox(
                width: GlobalVariable.ratioWidth(Get.context) * 8,
              ),
              Expanded(
                  child: controller.isKosongPeriodeAkhir.value
                      ? labelForm(
                          "LelangMuatTabHistoryTabHistoryLabelTitleNotifPeriodeAkhir"
                              .tr,
                          Color(ListColor.colorRed),
                          14,
                          FontWeight.w600)
                      : labelForm(
                          "", Color(ListColor.colorRed), 14, FontWeight.w600)),
            ],
          )
      ],
    );
  }

  Widget dividerCust() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Color(ListColor.colorLightGrey5).withOpacity(0.29),
    );
  }

  Widget sizedBoxJarak(double nilai) {
    return SizedBox(
      height: GlobalVariable.ratioFontSize(Get.context) * nilai,
    );
  }

  Widget sizedBoxWidth(double nilai) {
    return SizedBox(
      width: GlobalVariable.ratioFontSize(Get.context) * nilai,
    );
  }

  Widget labelForm(String labelName, color, sizefont, weightfont) {
    return CustomText(labelName,
        fontSize: GlobalVariable.ratioFontSize(Get.context) * sizefont,
        fontWeight: weightfont,
        color: color);
  }

  Widget namalokasi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            labelForm("Nama Lokasi", Color(ListColor.colorGrey3), 14,
                FontWeight.w700),
            sizedBoxWidth(8),
            Container(
              child: SvgPicture.asset(
                "assets/ic_edit.svg",
                width: GlobalVariable.ratioFontSize(Get.context) * 16,
                height: GlobalVariable.ratioFontSize(Get.context) * 16,
              ),
            )
          ],
        ),
        sizedBoxJarak(8),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
                key: ValueKey("namaLokasi"),
                context: Get.context,
                readOnly: true,
                // controller: controller.jenisTruk.value,
                onTap: () {
                  popupinputLokasiArea();
                  // _datetimeRangePicker();
                  // controller.cariTruck();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioFontSize(Get.context) * 12,
                    vertical: GlobalVariable.ratioFontSize(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "Masukkan Nama Lokasi".tr, // "Cari Area Pick Up",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // controller.onClearSearch();
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: GlobalVariable.ratioFontSize(Get.context) * 24,
                      )),
                )),
          ],
        )
      ],
    );
  }

  Widget kotakabupaten() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            labelForm(
              "Kota/Kabupaten",
              Color(ListColor.colorGrey3),
              14,
              FontWeight.w700,
            ),
            sizedBoxWidth(8),
            Container(
              child: SvgPicture.asset(
                "assets/ic_edit.svg",
                width: GlobalVariable.ratioFontSize(Get.context) * 16,
                height: GlobalVariable.ratioFontSize(Get.context) * 16,
              ),
            )
          ],
        ),
        sizedBoxJarak(8),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
                key: ValueKey("kotaKabupaten"),
                context: Get.context,
                readOnly: true,
                // controller: controller.jenisTruk.value,
                onTap: () {
                  // _datetimeRangePicker();
                  // controller.cariTruck();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                // newContentPadding: EdgeInsets.symmetric(
                //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                newContentPadding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioFontSize(Get.context) * 44,
                    GlobalVariable.ratioFontSize(Get.context) * 10,
                    GlobalVariable.ratioFontSize(Get.context) * 12,
                    GlobalVariable.ratioFontSize(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText:
                      "Pilih Nama Kota/Kabupaten".tr, // "Cari Area Pick Up",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    // controller.onClearSearch();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 12),
                      child: SvgPicture.asset(
                        "assets/ic_terakhir_dicari.svg",
                        height: GlobalVariable.ratioFontSize(Get.context) * 24,
                        width: GlobalVariable.ratioFontSize(Get.context) * 24,
                      )),
                )),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // controller.onClearSearch();
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: GlobalVariable.ratioFontSize(Get.context) * 24,
                      )),
                )),
          ],
        )
      ],
    );
  }

  Widget provinsi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labelForm("Provinsi", Color(ListColor.colorGrey3), 14, FontWeight.w700),
        sizedBoxJarak(8),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
                key: ValueKey("Provinsi"),
                context: Get.context,
                readOnly: true,
                // controller: controller.jenisTruk.value,
                onTap: () {
                  // _datetimeRangePicker();
                  // controller.cariTruck();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioFontSize(Get.context) * 12,
                    vertical: GlobalVariable.ratioFontSize(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "-".tr, // "Cari Area Pick Up",
                  fillColor: Color(ListColor.colorLightGrey2),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget kecamatan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            labelForm(
                "Kecamatan", Color(ListColor.colorGrey3), 14, FontWeight.w700),
            sizedBoxWidth(8),
            Container(
              child: SvgPicture.asset(
                "assets/ic_edit.svg",
                width: GlobalVariable.ratioFontSize(Get.context) * 16,
                height: GlobalVariable.ratioFontSize(Get.context) * 16,
              ),
            )
          ],
        ),
        sizedBoxJarak(8),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
                key: ValueKey("kecamatan"),
                context: Get.context,
                readOnly: true,
                // controller: controller.jenisTruk.value,
                onTap: () {
                  // _datetimeRangePicker();
                  // controller.cariTruck();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                // newContentPadding: EdgeInsets.symmetric(
                //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                newContentPadding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioFontSize(Get.context) * 44,
                    GlobalVariable.ratioFontSize(Get.context) * 10,
                    GlobalVariable.ratioFontSize(Get.context) * 12,
                    GlobalVariable.ratioFontSize(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "Pilih Kecamatan".tr, // "Cari Area Pick Up",
                  fillColor: Color(ListColor.colorLightGrey2),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    // controller.onClearSearch();
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          left: GlobalVariable.ratioWidth(Get.context) * 12),
                      child: SvgPicture.asset(
                        "assets/ic_terakhir_dicari.svg",
                        height: GlobalVariable.ratioFontSize(Get.context) * 24,
                        width: GlobalVariable.ratioFontSize(Get.context) * 24,
                      )),
                )),
          ],
        ),
        sizedBoxJarak(12),
        Container(
          width: MediaQuery.of(Get.context).size.width,
          height: GlobalVariable.ratioFontSize(Get.context) * 111,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(ListColor.colorLightGrey19)),
              borderRadius: BorderRadius.circular(6)),
        )
      ],
    );
  }

  Widget btnTukarLokasi() {
    return Padding(
      padding: EdgeInsets.only(
          left: GlobalVariable.ratioFontSize(Get.context) * 51,
          right: GlobalVariable.ratioFontSize(Get.context) * 51),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(ListColor.colorBlue)),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        color: Colors.white,
        onPressed: () {},
        child: Row(
          children: [
            labelForm("Tukar dengan Lokasi Pickup".tr,
                Color(ListColor.colorBlue), 14, FontWeight.w500),
            sizedBoxWidth(9.33),
            Container(
              child: SvgPicture.asset(
                "assets/ic_tukar.svg",
                height: GlobalVariable.ratioFontSize(Get.context) * 16,
                width: GlobalVariable.ratioFontSize(Get.context) * 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget jenisTruck() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labelForm(
            "Jenis Truck #1", Color(ListColor.colorGrey3), 14, FontWeight.w700),
        sizedBoxJarak(8),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
                key: ValueKey("JenisTruck"),
                context: Get.context,
                readOnly: true,
                // controller: controller.jenisTruk.value,
                onTap: () {
                  // _datetimeRangePicker();
                  // controller.cariTruck();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioFontSize(Get.context) * 12,
                    vertical: GlobalVariable.ratioFontSize(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "-".tr, // "Cari Area Pick Up",
                  fillColor: Color(ListColor.colorLightGrey2),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget jenisCarrier() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labelForm(
            "Jenis Carrier", Color(ListColor.colorGrey3), 14, FontWeight.w700),
        sizedBoxJarak(8),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
                key: ValueKey("JenisCarrier"),
                context: Get.context,
                readOnly: true,
                // controller: controller.jenisTruk.value,
                onTap: () {
                  // _datetimeRangePicker();
                  // controller.cariTruck();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioFontSize(Get.context) * 12,
                    vertical: GlobalVariable.ratioFontSize(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "-".tr, // "Cari Area Pick Up",
                  fillColor: Color(ListColor.colorLightGrey2),
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget jumlahKuotaPromo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labelForm("Jumlah Kuota Promo", Color(ListColor.colorGrey3), 14,
            FontWeight.w700),
        sizedBoxJarak(8),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
                key: ValueKey("JumlahKuotaPromo"),
                context: Get.context,
                readOnly: true,
                // controller: controller.jenisTruk.value,
                onTap: () {
                  // _datetimeRangePicker();
                  // controller.cariTruck();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey2),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioFontSize(Get.context) * 12,
                    vertical: GlobalVariable.ratioFontSize(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "Contoh : 100".tr, // "Cari Area Pick Up",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey4),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget hargaPromo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labelForm("Harga Promo (Rp)", Color(ListColor.colorGrey3), 14,
            FontWeight.w700),
        sizedBoxJarak(8),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            CustomTextField(
                key: ValueKey("HargaPromo"),
                context: Get.context,
                readOnly: true,
                // controller: controller.jenisTruk.value,
                onTap: () {
                  // _datetimeRangePicker();
                  // controller.cariTruck();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioFontSize(Get.context) * 12,
                    vertical: GlobalVariable.ratioFontSize(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "Contoh : 1.000.000".tr, // "Cari Area Pick Up",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey2),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(ListColor.colorLightGrey19), width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget pembayaran() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labelForm(
            "Pembayaran*", Color(ListColor.colorGrey3), 14, FontWeight.w700),
        sizedBoxJarak(8),
        DropdownBelow(
          key: ValueKey("selectedpembayaran"),
          itemWidth: MediaQuery.of(Get.context).size.width -
              GlobalVariable.ratioWidth(Get.context) * 32,
          itemTextstyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
          boxTextstyle: TextStyle(
              color: Color(ListColor.colorLightGrey4),
              fontWeight: FontWeight.w600,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
          boxPadding: EdgeInsets.only(
              left: GlobalVariable.ratioFontSize(Get.context) * 12,
              right: GlobalVariable.ratioFontSize(Get.context) * 12),
          // boxPadding: EdgeInsets.symmetric(
          //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
          //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
          boxWidth: MediaQuery.of(Get.context).size.width -
              GlobalVariable.ratioWidth(Get.context) * 32,
          // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 46,
          boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
              GlobalVariable.ratioWidth(Get.context) * 13.5 +
              GlobalVariable.ratioWidth(Get.context) * 13.5,
          boxDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  width: 1,
                  color: controller.isKosongPembayaran.value
                      ? Color(ListColor.colorRed)
                      : Color(ListColor.colorGrey2))),
          icon: Icon(Icons.keyboard_arrow_down_sharp,
              size: GlobalVariable.ratioFontSize(Get.context) * 20,
              color: Color(ListColor.colorGrey4)),
          hint: controller.selectedPembayaran.value == ""
              ? CustomText("Pilih Jenis Pembayaran".tr,
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4))
              : CustomText(controller.selectedPembayaran.value.toString(),
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
          value: controller.selectedPembayaran.value == ""
              ? null
              : controller.selectedPembayaran.value,
          items: [
            for (var i = 0; i < 3; i++)
              DropdownMenuItem(
                value: "a",
                child: CustomText("a",
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    color: Color(ListColor.colorLightGrey4)),
              )
          ],

          // controller.dropdownJenisMuatan,
          onChanged: (value) {
            // controller.selectedjenismuatan.value = value;
            // controller.isKosongJenisMuatan.value = false;
          },
        )
      ],
    );
  }

  Widget keteranganPromo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labelForm("Keterangan Promo", Color(ListColor.colorGrey3), 14,
            FontWeight.w700),
        sizedBoxJarak(8),
        CustomTextField(
            key: ValueKey("keteranganPromo"),
            context: Get.context,
            // controller: controllerTextEditing,
            inputFormatters: [LengthLimitingTextInputFormatter(255)],
            maxLines: 6,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorLightGrey4),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
            newContentPadding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 8),
            textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            newInputDecoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              hintText: "Contoh : Hanya Berlaku untuk pembayaran Tunai"
                  .tr, // "Cari Area Pick Up",
              fillColor: Colors.white,
              filled: true,
              hintStyle: TextStyle(
                  color: Color(ListColor.colorLightGrey2),
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(ListColor.colorLightGrey19), width: 1.0),
                borderRadius: BorderRadius.circular(6),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(ListColor.colorLightGrey19), width: 1.0),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(ListColor.colorLightGrey19), width: 1.0),
                borderRadius: BorderRadius.circular(6),
              ),
            ))
      ],
    );
  }

  Widget brosurGambarPromo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labelForm("Brosur Gambar Promo", Color(ListColor.colorGrey3), 14,
            FontWeight.w700),
        sizedBoxJarak(8),
        Container(
          width: MediaQuery.of(Get.context).size.width,
          height: GlobalVariable.ratioFontSize(Get.context) * 167,
          decoration: BoxDecoration(
            color: Color(ListColor.colorLightGrey20),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: Color(ListColor.colorLightGrey10)),
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/img_masukan_promo.svg",
              height: GlobalVariable.ratioFontSize(Get.context) * 51,
              width: GlobalVariable.ratioFontSize(Get.context) * 175,
            ),
          ),
        ),
        sizedBoxJarak(8),
        Row(
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(ListColor.colorBlue)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              color: Colors.white,
              onPressed: () {},
              child: labelForm(
                  "Upload".tr, Color(ListColor.colorBlue), 12, FontWeight.w600),
            ),
            sizedBoxWidth(8),
            labelForm(
                "tes.jpg", Color(ListColor.colorGreen6), 16, FontWeight.w600)
          ],
        ),
        sizedBoxJarak(20),
      ],
    );
  }

  popupinputLokasiArea() {
    showDialog(
        context: Get.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              // key: GlobalKey<State>(),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Obx(
                () => Container(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(alignment: Alignment.bottomCenter, children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 3, top: 3),
                            child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                  // controller.jumlahtruck.value.text = "";
                                },
                                child: Container(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: Color(ListColor.color4),
                                      size: GlobalVariable.ratioFontSize(
                                              context) *
                                          24,
                                    ))),
                          )),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Container(
                        child: Column(
                          children: [
                            CustomText(
                                "LelangMuatPesertaLelangPesertaLelangLabelTitlePopJumlahTruk"
                                    .tr
                                    .replaceAll("\\n", "\n"),
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.center,
                                fontSize:
                                    GlobalVariable.ratioFontSize(context) * 14,
                                color: Colors.black),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  "LelangMuatPesertaLelangPesertaLelangLabelTitleJumlahTruk"
                                      .tr,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.start,
                                  fontSize:
                                      GlobalVariable.ratioFontSize(context) *
                                          12,
                                  color: Color(ListColor.colorLightGrey4)),
                              SizedBox(
                                height: 8,
                              ),
                              Stack(alignment: Alignment.centerLeft, children: [
                                CustomTextField(
                                    context: Get.context,
                                    // controller: controller.jumlahtruck.value,
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      // ThousanSeparatorFormater()
                                    ],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(ListColor.colorLightGrey4),
                                        fontSize: GlobalVariable.ratioFontSize(
                                                Get.context) *
                                            14),
                                    newContentPadding: EdgeInsets.symmetric(
                                        horizontal: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            12,
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            8),
                                    textSize: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        14,
                                    newInputDecoration: InputDecoration(
                                      isDense: true,
                                      isCollapsed: true,
                                      hintText:
                                          "Contoh: 20", // "Cari Area Pick Up",
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color:
                                              Color(ListColor.colorLightGrey2),
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              GlobalVariable.ratioFontSize(
                                                      Get.context) *
                                                  14),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey19),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey19),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                ListColor.colorLightGrey19),
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                      margin: EdgeInsets.only(right: 13),
                                      child: CustomText(
                                        "Unit",
                                        fontWeight: FontWeight.w500,
                                        fontSize: GlobalVariable.ratioFontSize(
                                                context) *
                                            12,
                                      )),
                                ),
                              ]),
                            ],
                          ),
                        )),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color(ListColor.color4),
                          side: BorderSide(
                              width: 2, color: Color(ListColor.color4)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                      onPressed: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                        child: Stack(alignment: Alignment.center, children: [
                          CustomText("Simpan",
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                )),
              ));
        });
  }

  Widget get messageInfo {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        margin: EdgeInsets.fromLTRB(
            41.5,
            GlobalVariable.ratioFontSize(Get.context) * 15,
            0,
            GlobalVariable.ratioFontSize(Get.context) * 55),
        // width: GlobalVariable.ratioWidth(Get.context) * 258,
        width: MediaQuery.of(Get.context).size.width,
        // height: GlobalVariable.ratioFontSize(Get.context) * 280,
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only(
                top: GlobalVariable.ratioFontSize(Get.context) * 5.0),
            child: Container(
              width: GlobalVariable.ratioFontSize(Get.context) * 258,
              // height: GlobalVariable.ratioFontSize(Get.context) * 260,
              decoration: BoxDecoration(
                color: Color(ListColor.colorDarkGrey4),
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                      color: Color(ListColor.colorLightGrey18), blurRadius: 18)
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 61.5),
            child: Align(
                alignment: Alignment.topLeft,
                child: Transform.rotate(
                  angle: -math.pi / 4,
                  child: Container(
                    width: GlobalVariable.ratioFontSize(Get.context) * 24,
                    height: GlobalVariable.ratioFontSize(Get.context) * 24,
                    decoration: BoxDecoration(
                      color: Color(ListColor.colorDarkGrey4),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                            color: Color(ListColor.colorLightGrey18),
                            blurRadius: 18)
                      ],
                    ),
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: GlobalVariable.ratioFontSize(Get.context) * 5.0),
            child: Container(
                width: GlobalVariable.ratioFontSize(Get.context) * 258,
                // height: GlobalVariable.ratioFontSize(Get.context) * 260,
                padding: EdgeInsets.all(8),
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(ListColor.colorDarkGrey4),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/ic_close_zo.svg",
                          height:
                              GlobalVariable.ratioFontSize(Get.context) * 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        GlobalVariable.ratioFontSize(Get.context) * 12.0,
                        GlobalVariable.ratioFontSize(Get.context) * 10.0,
                        GlobalVariable.ratioFontSize(Get.context) * 12.0,
                        GlobalVariable.ratioFontSize(Get.context) * 2.0,
                      ),
                      child: Html(
                          style: {
                            "body": Style(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero)
                          },
                          data: '<div style="text-align: center; vertical-align: top;"><span style="font-weight: 700; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #fff;">' +
                              'LelangMuatBuatLelangBuatLelangLabelTitleLelangTertutup'
                                  .tr +
                              '</span> <span style="font-weight: 500; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #fff;">' +
                              'LelangMuatBuatLelangBuatLelangLabelTitlePenjelasanLelangTertutup'
                                  .tr +
                              '</span><br><br><span style="font-weight: 700; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #fff;">' +
                              'LelangMuatBuatLelangBuatLelangLabelTitleLelangTerbuka'
                                  .tr +
                              '</span> <span style="font-weight: 500; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 12}; color: #fff;">' +
                              'LelangMuatBuatLelangBuatLelangLabelTitlePenjelasanLelangTerbuka'
                                  .tr +
                              '</span></div>'),
                    )
                  ],
                )

                // CustomText("Tekan tombol di bawah ini untuk memulai",
                //     fontSize: GlobalVariable.ratioWidth(Get.context) * 10,
                //     height: 1.3,
                //     fontWeight: FontWeight.w500,
                //     color: Color(ListColor.color2),
                //     textAlign: TextAlign.center)

                ),
          ),
        ]),
      ),
    ]);
  }
}
