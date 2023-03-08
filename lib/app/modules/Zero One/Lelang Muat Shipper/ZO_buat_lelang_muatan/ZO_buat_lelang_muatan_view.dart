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
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart'
    as ark_global;
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_buat_lelang_muatan/ZO_buat_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/checkbox_custom_widget_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/radio_button_custom_widget_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/radio_button_custom_with_text_widget_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'dart:math' as math;

class ZoBuatLelangMuatanView extends GetView<ZoBuatLelangMuatanController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        if (controller.periodeAwalController.value.text != "") {
          GlobalAlertDialog.showAlertDialogCustom(
              context: Get.context,
              title:
                  "LelangMuatBuatLelangBuatLelangLabelTitleConfirmasiBatal".tr,
              message: "LelangMuatBuatLelangBuatLelangLabelTitleApakahAndaYakin"
                  .tr
                  .replaceAll("\\n", "\n"),
              isShowCloseButton: true,
              isDismissible: true,
              positionColorPrimaryButton: PositionColorPrimaryButton.PRIORITY1,
              labelButtonPriority1:
                  "LelangMuatTabAktifTabAktifLabelTitleConfirmYes".tr,
              labelButtonPriority2:
                  "LelangMuatTabAktifTabAktifLabelTitleConfirmNo".tr,
              onTapPriority2: () {
                controller.pembatalanBuatLelang();
              });
        } else {
          Get.back();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: Center(
          //   child: ClipOval(
          //     child: Material(
          //         shape: CircleBorder(),
          //         color: Colors.white,
          //         child: InkWell(
          //             onTap: () {
          //               // Get.back();
          //               FocusManager.instance.primaryFocus.unfocus();
          //               var valid = false;
          //               switch (controller.slideIndex.value) {
          //                 case 0:
          //                   {
          //                     Get.back();
          //                     valid = true;
          //                     break;
          //                   }
          //                 case 1:
          //                   {
          //                     valid = true;
          //                     break;
          //                   }
          //                 case 2:
          //                   {
          //                     valid = true;
          //                     break;
          //                   }
          //                 case 3:
          //                   {
          //                     valid = true;
          //                     break;
          //                   }
          //                 case 4:
          //                   {
          //                     valid = true;
          //                     break;
          //                   }
          //                 case 5:
          //                   {
          //                     valid = true;
          //                     break;
          //                   }
          //               }
          //               if (valid) {
          //                 FocusScope.of(Get.context).unfocus();
          //                 if (controller.slideIndex.value != 6) {
          //                   controller.slideIndex.value--;
          //                   controller.pageController.animateToPage(
          //                       controller.slideIndex.value,
          //                       duration: Duration(milliseconds: 500),
          //                       curve: Curves.linear);
          //                 }
          //               }
          //             },
          //             child: Container(
          //                 width: 30,
          //                 height: 30,
          //                 child: Center(
          //                     child: Icon(
          //                   Icons.arrow_back_ios_rounded,
          //                   size: 30 * 0.7,
          //                   color: Color(ListColor.color4),
          //                 ))))),
          //   ),
          // ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: ClipOval(
                  child: Material(
                      shape: CircleBorder(),
                      color: Colors.white,
                      child: InkWell(
                          onTap: () {
                            if (controller.periodeAwalController.value.text !=
                                "") {
                              GlobalAlertDialog.showAlertDialogCustom(
                                  context: Get.context,
                                  title:
                                      "LelangMuatBuatLelangBuatLelangLabelTitleConfirmasiBatal"
                                          .tr,
                                  message:
                                      "LelangMuatBuatLelangBuatLelangLabelTitleApakahAndaYakin"
                                          .tr
                                          .replaceAll("\\n", "\n"),
                                  isShowCloseButton: true,
                                  isDismissible: true,
                                  positionColorPrimaryButton:
                                      PositionColorPrimaryButton.PRIORITY1,
                                  labelButtonPriority1:
                                      "LelangMuatTabAktifTabAktifLabelTitleConfirmYes"
                                          .tr,
                                  labelButtonPriority2:
                                      "LelangMuatTabAktifTabAktifLabelTitleConfirmNo"
                                          .tr,
                                  onTapPriority2: () {
                                    controller.pembatalanBuatLelang();
                                  });
                            } else {
                              Get.back();
                            }
                            // FocusManager.instance.primaryFocus.unfocus();
                            // var valid = false;
                            // switch (controller.slideIndex.value) {
                            //   case 0:
                            //     {
                            //       Get.back();
                            //       valid = true;
                            //       break;
                            //     }
                            //   case 1:
                            //     {
                            //       valid = true;
                            //       break;
                            //     }
                            //   case 2:
                            //     {
                            //       valid = true;
                            //       break;
                            //     }
                            //   case 3:
                            //     {
                            //       valid = true;
                            //       break;
                            //     }
                            //   case 4:
                            //     {
                            //       valid = true;
                            //       break;
                            //     }
                            //   case 5:
                            //     {
                            //       valid = true;
                            //       break;
                            //     }
                            // }
                            // if (valid) {
                            //   FocusScope.of(Get.context).unfocus();
                            //   if (controller.slideIndex.value != 6) {
                            //     controller.slideIndex.value--;
                            //     controller.pageController.animateToPage(
                            //         controller.slideIndex.value,
                            //         duration: Duration(milliseconds: 500),
                            //         curve: Curves.linear);
                            //   }
                            // }
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
                                color: Color(ListColor.color4),
                              ))))),
                ),
              ),
              SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
              Expanded(
                child: CustomText(
                  "LelangMuatBuatLelangBuatLelangLabelTitleCreateBidButton".tr,
                  color: Colors.white,
                  fontSize: GlobalVariable.ratioFontSize(context) * 18,
                  fontWeight: FontWeight.w600,
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
                  color: Color(ListColor.color4),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 0.5,
                          child: Container(
                              color: Color(ListColor.colorLightBlue5))),
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
                                      color: Colors.white,
                                      fontSize: GlobalVariable.ratioFontSize(
                                              context) *
                                          16,
                                      fontWeight: FontWeight.w700)),
                                )),
                                Obx(
                                  () => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (int i = 0; i < 6; i++)
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
                                // if (controller.slideIndex.value == 2) {
                                //   if (controller.muatan.value.text == "" ||
                                //       controller.muatan.value.text == null) {
                                //     controller.isKosong.value = true;
                                //     controller.scrollpyshic.value =
                                //         NeverScrollableScrollPhysics();
                                //   } else {
                                //     controller.isKosong.value = false;
                                //     controller.scrollpyshic.value =
                                //         PageScrollPhysics();
                                //   }
                                //   if (controller.selectedjenismuatan.value ==
                                //           "" ||
                                //       controller.selectedjenismuatan.value ==
                                //           null) {
                                //     controller.isKosongJenisMuatan.value = true;
                                //     controller.scrollpyshic.value =
                                //         NeverScrollableScrollPhysics();
                                //   } else {
                                //     controller.isKosongJenisMuatan.value =
                                //         false;
                                //     controller.scrollpyshic.value =
                                //         PageScrollPhysics();
                                //   }
                                //   if (controller.selectedjenismuatan.value !=
                                //           "" &&
                                //       controller.muatan.value.text != "") {
                                //     controller.scrollpyshic.value =
                                //         PageScrollPhysics();
                                //     controller.slideIndex.value = index;
                                //     controller.updateTitle();
                                //   }
                                // } else if (controller.slideIndex.value == 3) {
                                //   if (controller.radioButtonSatuMultipleLokasi
                                //           .value ==
                                //       "Satu Lokasi") {
                                //     if (controller.alamatSatuan.value.text ==
                                //         "") {
                                //       controller.isKosongAlamatSatuan.value =
                                //           true;
                                //     } else {
                                //       controller.isKosongAlamatSatuan.value =
                                //           false;
                                //     }
                                //   } else {
                                //     for (var i = 0;
                                //         i <
                                //             controller
                                //                 .dropdownJumlahLokasi.value;
                                //         i++) {
                                //       if (controller.alamatMulti[i].text ==
                                //           "") {
                                //         controller.isKosongAlamatMulti
                                //             .value[i] = true;
                                //       } else {
                                //         controller.isKosongAlamatMulti
                                //             .value[i] = false;
                                //       }
                                //     }
                                //   }

                                //   if (controller.radioButtonSatuMultipleLokasi
                                //           .value ==
                                //       "Satu Lokasi") {
                                //     if (controller.alamatSatuan.value.text !=
                                //         "") {
                                //       controller.slideIndex.value = index;
                                //       controller.updateTitle();
                                //     }
                                //   } else {
                                //     for (var i = 0;
                                //         i <
                                //             controller
                                //                 .dropdownJumlahLokasi.value;
                                //         i++) {
                                //       if (controller.alamatMulti[i].text !=
                                //           "") {
                                //         controller.slideIndex.value = index;
                                //         controller.updateTitle();
                                //       }
                                //     }
                                //   }
                                // } else if (controller.slideIndex.value == 4) {
                                //   if (controller
                                //           .radioButtonSatuMultipleLokasiDestinasi
                                //           .value ==
                                //       "Satu Lokasi") {
                                //     if (controller
                                //             .alamatSatuanDestinasi.value.text ==
                                //         "") {
                                //       controller.isKosongAlamatSatuanDestinasi
                                //           .value = true;
                                //     } else {
                                //       controller.isKosongAlamatSatuanDestinasi
                                //           .value = false;
                                //     }
                                //   } else {
                                //     for (var i = 0;
                                //         i <
                                //             controller
                                //                 .dropdownJumlahLokasiDestinasi
                                //                 .value;
                                //         i++) {
                                //       if (controller
                                //               .alamatMultiDestinasi[i].text ==
                                //           "") {
                                //         controller.isKosongAlamatMultiDestinasi
                                //             .value[i] = true;
                                //       } else {
                                //         controller.isKosongAlamatMultiDestinasi
                                //             .value[i] = false;
                                //       }
                                //     }
                                //   }

                                //   if (controller
                                //           .radioButtonSatuMultipleLokasiDestinasi
                                //           .value ==
                                //       "Satu Lokasi") {
                                //     if (controller
                                //             .alamatSatuanDestinasi.value.text !=
                                //         "") {
                                //       controller.slideIndex.value = index;
                                //       controller.updateTitle();
                                //     }
                                //   } else {
                                //     for (var i = 0;
                                //         i <
                                //             controller
                                //                 .dropdownJumlahLokasiDestinasi
                                //                 .value;
                                //         i++) {
                                //       if (controller
                                //               .alamatMultiDestinasi[i].text !=
                                //           "") {
                                //         controller.slideIndex.value = index;
                                //         controller.updateTitle();
                                //       }
                                //     }
                                //   }
                                // } else {
                                //   controller.slideIndex.value = index;
                                //   controller.updateTitle();
                                // }
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
                                  child: dataLelangPage(),
                                ),
                                Container(
                                  color: Color(ListColor.colorLightGrey6),
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      MediaQuery.of(Get.context).size.height,
                                  child: dataKebutuhanPage(),
                                ),
                                Container(
                                  color: Color(ListColor.colorLightGrey6),
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      MediaQuery.of(Get.context).size.height,
                                  child: dataMuatanPage(),
                                ),
                                Container(
                                  color: Color(ListColor.colorLightGrey6),
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      MediaQuery.of(Get.context).size.height,
                                  child: informasiPickupPage(),
                                ),
                                Container(
                                  color: Color(ListColor.colorLightGrey6),
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      MediaQuery.of(Get.context).size.height,
                                  child: informasiDestinasiPage(),
                                ),
                                Container(
                                  color: Color(ListColor.colorLightGrey6),
                                  width: MediaQuery.of(Get.context).size.width,
                                  height:
                                      MediaQuery.of(Get.context).size.height,
                                  child: dataPenawaranPage(),
                                )
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
                                                    case 4:
                                                      {
                                                        valid = true;
                                                        break;
                                                      }
                                                    case 5:
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
                                                        6) {
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
                                        case 4:
                                          {
                                            valid = true;
                                            break;
                                          }
                                        case 5:
                                          {
                                            valid = true;
                                            break;
                                          }
                                      }
                                      if (valid) {
                                        FocusScope.of(Get.context).unfocus();
                                        if (controller.slideIndex.value != 5) {
                                          if (controller.slideIndex.value ==
                                              0) {
                                            if (controller.periodeAwalController
                                                        .value.text ==
                                                    "" ||
                                                controller.periodeAwalController
                                                        .value.text ==
                                                    null) {
                                              controller.isKosongPeriodeAwal
                                                  .value = true;
                                            } else {
                                              controller.isKosongPeriodeAwal
                                                  .value = false;
                                            }
                                            if (controller
                                                        .periodeAkhirController
                                                        .value
                                                        .text ==
                                                    "" ||
                                                controller
                                                        .periodeAkhirController
                                                        .value
                                                        .text ==
                                                    null) {
                                              controller.isKosongPeriodeAkhir
                                                  .value = true;
                                            } else {
                                              controller.isKosongPeriodeAkhir
                                                  .value = false;
                                            }

                                            if ((controller
                                                        .periodeAwalController
                                                        .value
                                                        .text !=
                                                    "" &&
                                                controller
                                                        .periodeAkhirController
                                                        .value
                                                        .text !=
                                                    "")) {
                                              controller.slideIndex.value++;
                                              controller.pageController
                                                  .animateToPage(
                                                      controller
                                                          .slideIndex.value,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.linear);
                                            }
                                          } else if (controller
                                                  .slideIndex.value ==
                                              2) {
                                            if (controller.muatan.value.text ==
                                                    "" ||
                                                controller.muatan.value.text ==
                                                    null) {
                                              controller.isKosong.value = true;
                                            } else {
                                              controller.isKosong.value = false;
                                            }
                                            if (controller.selectedjenismuatan
                                                        .value ==
                                                    "" ||
                                                controller.selectedjenismuatan
                                                        .value ==
                                                    null) {
                                              controller.isKosongJenisMuatan
                                                  .value = true;
                                            } else {
                                              controller.isKosongJenisMuatan
                                                  .value = false;
                                            }
                                            if (controller.selectedjenismuatan
                                                        .value !=
                                                    "" &&
                                                controller.muatan.value.text !=
                                                    "") {
                                              controller.slideIndex.value++;
                                              controller.pageController
                                                  .animateToPage(
                                                      controller
                                                          .slideIndex.value,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.linear);
                                            }
                                          } else if (controller
                                                  .slideIndex.value ==
                                              3) {
                                            if (controller.ekspektasiwaktupickup
                                                        .value.text ==
                                                    "" ||
                                                controller.ekspektasiwaktupickup
                                                        .value.text ==
                                                    null) {
                                              controller
                                                  .isKosongEkspektasiWaktuPickup
                                                  .value = true;
                                            } else {
                                              controller
                                                  .isKosongEkspektasiWaktuPickup
                                                  .value = false;
                                            }
                                            if (controller
                                                    .radioButtonSatuMultipleLokasi
                                                    .value ==
                                                "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation"
                                                    .tr) {
                                              if (controller.alamatSatuan.value
                                                      .text ==
                                                  "") {
                                                controller.isKosongAlamatSatuan
                                                    .value = true;
                                              } else {
                                                controller.isKosongAlamatSatuan
                                                    .value = false;
                                              }
                                            } else {
                                              for (var i = 0;
                                                  i <
                                                      controller
                                                          .dropdownJumlahLokasi
                                                          .value;
                                                  i++) {
                                                if (controller
                                                        .alamatMulti[i].text ==
                                                    "") {
                                                  controller.isKosongAlamatMulti
                                                      .value[i] = true;
                                                } else {
                                                  controller.isKosongAlamatMulti
                                                      .value[i] = false;
                                                }
                                              }
                                            }

                                            if (controller
                                                    .radioButtonSatuMultipleLokasi
                                                    .value ==
                                                "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation"
                                                    .tr) {
                                              if (controller.alamatSatuan.value
                                                          .text !=
                                                      "" &&
                                                  controller
                                                          .ekspektasiwaktupickup
                                                          .value
                                                          .text !=
                                                      "") {
                                                controller.slideIndex.value++;
                                                controller.pageController
                                                    .animateToPage(
                                                        controller
                                                            .slideIndex.value,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.linear);
                                              }
                                            } else {
                                              if (controller
                                                      .dropdownJumlahLokasi
                                                      .value ==
                                                  2) {
                                                if (controller.alamatMulti[0]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[1]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .ekspektasiwaktupickup
                                                            .value
                                                            .text !=
                                                        "") {
                                                  controller.slideIndex.value++;
                                                  controller.pageController
                                                      .animateToPage(
                                                          controller
                                                              .slideIndex.value,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.linear);
                                                }
                                              }

                                              if (controller
                                                      .dropdownJumlahLokasi
                                                      .value ==
                                                  3) {
                                                if (controller.alamatMulti[0]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[1]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[2]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .ekspektasiwaktupickup
                                                            .value
                                                            .text !=
                                                        "") {
                                                  controller.slideIndex.value++;
                                                  controller.pageController
                                                      .animateToPage(
                                                          controller
                                                              .slideIndex.value,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.linear);
                                                }
                                              }

                                              if (controller
                                                      .dropdownJumlahLokasi
                                                      .value ==
                                                  4) {
                                                if (controller.alamatMulti[0]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[1]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[2]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[3]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .ekspektasiwaktupickup
                                                            .value
                                                            .text !=
                                                        "") {
                                                  controller.slideIndex.value++;
                                                  controller.pageController
                                                      .animateToPage(
                                                          controller
                                                              .slideIndex.value,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.linear);
                                                }
                                              }

                                              if (controller
                                                      .dropdownJumlahLokasi
                                                      .value ==
                                                  5) {
                                                if (controller.alamatMulti[0]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[1]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[2]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[3]
                                                            .text !=
                                                        "" &&
                                                    controller.alamatMulti[4]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .ekspektasiwaktupickup
                                                            .value
                                                            .text !=
                                                        "") {
                                                  controller.slideIndex.value++;
                                                  controller.pageController
                                                      .animateToPage(
                                                          controller
                                                              .slideIndex.value,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.linear);
                                                }
                                              }
                                            }
                                          } else if (controller
                                                  .slideIndex.value ==
                                              4) {
                                            if (controller
                                                        .ekspektasiwaktupickupDestinasi
                                                        .value
                                                        .text ==
                                                    "" ||
                                                controller
                                                        .ekspektasiwaktupickupDestinasi
                                                        .value
                                                        .text ==
                                                    null) {
                                              controller
                                                  .isKosongEkspektasiWaktuDestinasi
                                                  .value = true;
                                            } else {
                                              controller
                                                  .isKosongEkspektasiWaktuDestinasi
                                                  .value = false;
                                            }
                                            if (controller
                                                    .radioButtonSatuMultipleLokasiDestinasi
                                                    .value ==
                                                "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation"
                                                    .tr) {
                                              if (controller
                                                      .alamatSatuanDestinasi
                                                      .value
                                                      .text ==
                                                  "") {
                                                controller
                                                    .isKosongAlamatSatuanDestinasi
                                                    .value = true;
                                              } else {
                                                controller
                                                    .isKosongAlamatSatuanDestinasi
                                                    .value = false;
                                              }
                                            } else {
                                              for (var i = 0;
                                                  i <
                                                      controller
                                                          .dropdownJumlahLokasiDestinasi
                                                          .value;
                                                  i++) {
                                                if (controller
                                                        .alamatMultiDestinasi[i]
                                                        .text ==
                                                    "") {
                                                  controller
                                                      .isKosongAlamatMultiDestinasi
                                                      .value[i] = true;
                                                } else {
                                                  controller
                                                      .isKosongAlamatMultiDestinasi
                                                      .value[i] = false;
                                                }
                                              }
                                            }

                                            if (controller
                                                    .radioButtonSatuMultipleLokasiDestinasi
                                                    .value ==
                                                "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation"
                                                    .tr) {
                                              if (controller
                                                          .alamatSatuanDestinasi
                                                          .value
                                                          .text !=
                                                      "" &&
                                                  controller
                                                          .ekspektasiwaktupickupDestinasi
                                                          .value
                                                          .text !=
                                                      "") {
                                                controller.slideIndex.value++;
                                                controller.pageController
                                                    .animateToPage(
                                                        controller
                                                            .slideIndex.value,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.linear);
                                              }
                                            } else {
                                              if (controller
                                                      .dropdownJumlahLokasiDestinasi
                                                      .value ==
                                                  2) {
                                                if (controller.alamatMultiDestinasi[0].text != "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                1]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .ekspektasiwaktupickupDestinasi
                                                            .value
                                                            .text !=
                                                        "") {
                                                  controller.slideIndex.value++;
                                                  controller.pageController
                                                      .animateToPage(
                                                          controller
                                                              .slideIndex.value,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.linear);
                                                }
                                              }

                                              if (controller
                                                      .dropdownJumlahLokasiDestinasi
                                                      .value ==
                                                  3) {
                                                if (controller.alamatMultiDestinasi[0].text != "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                1]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                2]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .ekspektasiwaktupickupDestinasi
                                                            .value
                                                            .text !=
                                                        "") {
                                                  controller.slideIndex.value++;
                                                  controller.pageController
                                                      .animateToPage(
                                                          controller
                                                              .slideIndex.value,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.linear);
                                                }
                                              }

                                              if (controller
                                                      .dropdownJumlahLokasiDestinasi
                                                      .value ==
                                                  4) {
                                                if (controller.alamatMultiDestinasi[0].text != "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                1]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                2]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                3]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .ekspektasiwaktupickupDestinasi
                                                            .value
                                                            .text !=
                                                        "") {
                                                  controller.slideIndex.value++;
                                                  controller.pageController
                                                      .animateToPage(
                                                          controller
                                                              .slideIndex.value,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.linear);
                                                }
                                              }

                                              if (controller
                                                      .dropdownJumlahLokasiDestinasi
                                                      .value ==
                                                  5) {
                                                if (controller.alamatMultiDestinasi[0].text != "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                1]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                2]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                3]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .alamatMultiDestinasi[
                                                                4]
                                                            .text !=
                                                        "" &&
                                                    controller
                                                            .ekspektasiwaktupickupDestinasi
                                                            .value
                                                            .text !=
                                                        "") {
                                                  controller.slideIndex.value++;
                                                  controller.pageController
                                                      .animateToPage(
                                                          controller
                                                              .slideIndex.value,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.linear);
                                                }
                                              }
                                            }
                                          } else {
                                            controller.slideIndex.value++;
                                            controller.pageController
                                                .animateToPage(
                                                    controller.slideIndex.value,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.linear);
                                          }
                                        } else {
                                          GlobalAlertDialog
                                              .showAlertDialogCustom(
                                                  context: Get.context,
                                                  title:
                                                      "LelangMuatBuatLelangBuatLelangLabelTitleKonfirmasiPembuatanLelang"
                                                          .tr,
                                                  message:
                                                      "LelangMuatBuatLelangBuatLelangLabelTitlePastikanData"
                                                          .tr
                                                          .replaceAll(
                                                              "\\n", "\n"),
                                                  isShowCloseButton: true,
                                                  isDismissible: true,
                                                  positionColorPrimaryButton:
                                                      PositionColorPrimaryButton
                                                          .PRIORITY2,
                                                  labelButtonPriority1:
                                                      "LelangMuatTabAktifTabAktifLabelTitleConfirmYes"
                                                          .tr,
                                                  labelButtonPriority2:
                                                      "LelangMuatTabAktifTabAktifLabelTitleConfirmNo"
                                                          .tr,
                                                  onTapPriority2: () {
                                                    controller.saveLelangMuatan(
                                                        controller
                                                            .dateAwal.value,
                                                        controller
                                                            .dateAkhir.value,
                                                        controller
                                                            .radioButtonTerbukaTertutup
                                                            .value);
                                                  });
                                        }
                                      }
                                    },
                                    child: Obx(() => CustomText(
                                        controller.slideIndex.value == 5
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
                    ? Color(ListColor.colorYellow)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Color(ListColor.colorYellow), width: 2),
              ),
            ),
            Center(
              child: CustomText(
                (index + 1).toString(),
                color:
                    isCurrentPage ? Color(ListColor.colorBlue) : Colors.white,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 12,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        index == 5
            ? SizedBox.shrink()
            : Container(
                height: 2, width: 5, color: Color(ListColor.colorYellow))
      ],
    );
  }

  Widget dataLelangPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 20,
            GlobalVariable.ratioWidth(Get.context) * 16,
            0),
        child: Obx(
          () => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleNomorLelangMuatan"
                        .tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm("<otomatis>", Colors.black, 14, FontWeight.w600),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLableTitleBidPeriode".tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                _formFilterDate(),
                sizedBoxJarak(24),
                Stack(
                  children: [
                    Container(
                      height: GlobalVariable.ratioWidth(Get.context) * 350,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 13,
                            ),
                            RadioButtonCustomWithText(
                              isDense: true,
                              isWithShadow: true,
                              colorRoundedBG: Colors.white,
                              radioSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      20,
                              groupValue:
                                  controller.radioButtonTerbukaTertutup.value,
                              value: "1",
                              customTextWidget: labelForm(
                                  "LelangMuatBuatLelangBuatLelangLabelTitleTerbuka"
                                      .tr,
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              onChanged: (val) {
                                controller.radioButtonTerbukaTertutup.value =
                                    val;
                              },
                            ),
                            SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                            ),
                            RadioButtonCustomWithText(
                              isDense: true,
                              isWithShadow: true,
                              colorRoundedBG: Colors.white,
                              radioSize:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      20,
                              groupValue:
                                  controller.radioButtonTerbukaTertutup.value,
                              value: "0",
                              customTextWidget: labelForm(
                                  "LelangMuatBuatLelangBuatLelangLabelTitleTertutup"
                                      .tr,
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              onChanged: (val) {
                                controller.radioButtonTerbukaTertutup.value =
                                    val;
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        labelForm(
                            "LelangMuatBuatLelangBuatLelangLableTitleBidType"
                                .tr,
                            Color(ListColor.colorGrey3),
                            14,
                            FontWeight.w700),
                        SizedBox(
                          width: GlobalVariable.ratioFontSize(Get.context) * 8,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Container(
                            child: GestureDetector(
                              onTap: () {
                                controller.isShowInfoAction();
                              },
                              child: Image(
                                image: AssetImage("assets/Icon_info.png"),
                                width:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        16,
                                height:
                                    GlobalVariable.ratioFontSize(Get.context) *
                                        16,
                                fit: BoxFit.fitWidth,
                              ),
                              // SvgPicture.asset(
                              //     "assets/info_blok_disable.svg",
                              //     width: GlobalVariable.ratioWidth(
                              //             Get.context) *
                              //         18,
                              //     height: GlobalVariable.ratioWidth(
                              //             Get.context) *
                              //         18)
                            ),

                            // IconButton(
                            //   icon: Icon(
                            //     Icons.info,
                            //     size: GlobalVariable.ratioWidth(Get.context) * 18,
                            //     color: Color(ListColor.colorGrey3),
                            //   ),
                            //   onPressed: () {
                            //     controller.isShowInfoAction();
                            //   },
                            // ),
                          ),
                        )
                      ],
                    ),
                    if (controller.isShowInfo.value)
                      Positioned.fill(
                          top: GlobalVariable.ratioFontSize(Get.context) * 9,
                          // left: GlobalVariable.ratioWidth(Get.context) * 40,
                          child: messageInfo)
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //       top: GlobalVariable.ratioWidth(Get.context) * 20,
                    //       left:
                    //           MediaQuery.of(Get.context).size.width * 0.152),
                    //   child: messageInfo,
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dataKebutuhanPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 20,
            GlobalVariable.ratioWidth(Get.context) * 16,
            0),
        child: Obx(
          () => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleMasukanKebutuhan"
                        .tr,
                    Color(ListColor.colorLightGrey4),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleTruckCarrierType"
                        .tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(4),
                _formJenisTruk(),
                sizedBoxJarak(18),
                _formJenisCarier(),
                sizedBoxJarak(18),
                _formImgTrukCarrier(),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleEstimasiBeratMax"
                        .tr,
                    Color(ListColor.colorLightGrey14),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm(controller.beratMaxDimensiVolume.value.toString(),
                    Colors.black, 14, FontWeight.w600),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleTruckQuantity".tr,
                    Color(ListColor.colorLightGrey14),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                _formJumlahTruk(),
                sizedBoxJarak(24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dataMuatanPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 20,
            GlobalVariable.ratioWidth(Get.context) * 16,
            0),
        child: Obx(
          () => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleMasukanSpesifikasi"
                        .tr,
                    Color(ListColor.colorLightGrey4),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleCargo"
                            .tr
                            .replaceAll(" ", "") +
                        "*",
                    Color(ListColor.colorLightGrey14),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                _formMuatan(),
                if (controller.isKosong.value) sizedBoxJarak(4),
                if (controller.isKosong.value)
                  labelForm(
                      "LelangMuatBuatLelangBuatLelangLabelTitleNamaMuatanHarusIsi"
                          .tr,
                      Color(ListColor.colorRed),
                      14,
                      FontWeight.w600),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleCargoType".tr +
                        "*",
                    Color(ListColor.colorLightGrey14),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                _formJenisMuatan(),
                if (controller.isKosongJenisMuatan.value) sizedBoxJarak(4),
                if (controller.isKosongJenisMuatan.value)
                  labelForm(
                      "LelangMuatBuatLelangBuatLelangLabelTitleJensiMuatanHarusIsi"
                          .tr,
                      Color(ListColor.colorRed),
                      14,
                      FontWeight.w600),
                sizedBoxJarak(24),
                labelForm("LelangMuatBuatLelangBuatLelangLabelTitleWeight".tr,
                    Color(ListColor.colorLightGrey14), 14, FontWeight.w700),
                sizedBoxJarak(8),
                _formBerat(),
                sizedBoxJarak(24),
                labelForm("LelangMuatBuatLelangBuatLelangLabelTitleVolume".tr,
                    Color(ListColor.colorLightGrey14), 14, FontWeight.w700),
                sizedBoxJarak(8),
                _formVolume(),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleCargoDimension".tr,
                    Color(ListColor.colorLightGrey14),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                _formDimensiKoli(),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleColiQuantity".tr,
                    Color(ListColor.colorLightGrey14),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                _formJumlahKoli(),
                sizedBoxJarak(46),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget informasiPickupPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 20,
            GlobalVariable.ratioWidth(Get.context) * 16,
            0),
        child: Obx(() => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  labelForm(
                      "LelangMuatBuatLelangBuatLelangLabelTitleMasukanAlamat"
                          .tr,
                      Color(ListColor.colorLightGrey4),
                      14,
                      FontWeight.w700),
                  sizedBoxJarak(24),
                  labelForm("LelangMuatBuatLelangBuatLelangLabelTitleType".tr,
                      Color(ListColor.colorLightGrey14), 14, FontWeight.w700),
                  sizedBoxJarak(8),
                  _formTipe(),
                  sizedBoxJarak(24),
                  if (controller.radioButtonSatuMultipleLokasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitleJumlahLokasi"
                            .tr,
                        Color(ListColor.colorLightGrey14),
                        14,
                        FontWeight.w700),
                  if (controller.radioButtonSatuMultipleLokasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    sizedBoxJarak(8),
                  if (controller.radioButtonSatuMultipleLokasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    _formJumlahLokasi(),
                  if (controller.radioButtonSatuMultipleLokasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    sizedBoxJarak(24),
                  if (controller.radioButtonSatuMultipleLokasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    for (var idx = 0;
                        idx < controller.dropdownJumlahLokasi.value;
                        idx++)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleAlamatPickup"
                                        .tr +
                                    " ${idx + 1}",
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formAlamat(ValueKey("alamatMulti $idx"),
                                idx: idx,
                                controllerTextEditing:
                                    controller.alamatMulti[idx],
                                satuan: false),
                            Visibility(
                                visible: false,
                                child: _visibleCityList(controller.city[idx],
                                    ValueKey("city $idx"))),
                            Visibility(
                                visible: false,
                                child: _visibleLatList(
                                    controller.lat[idx], ValueKey("lat $idx"))),
                            Visibility(
                                visible: false,
                                child: _visibleLngList(
                                    controller.lng[idx], ValueKey("lng $idx"))),
                            Visibility(
                                visible: false,
                                child: _visibleProvinceIdList(
                                    controller.provinceIdList[idx],
                                    ValueKey("provinceIdList $idx"))),
                            if (controller.isKosongAlamatMulti[idx])
                              sizedBoxJarak(4),
                            if (controller.isKosongAlamatMulti[idx])
                              labelForm(
                                  "LelangMuatBuatLelangBuatLelangLabelTitleLokasiHarusIsi"
                                      .tr,
                                  Color(ListColor.colorRed),
                                  14,
                                  FontWeight.w600),
                            sizedBoxJarak(24),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleAddressDetail"
                                    .tr,
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formDetailAlamat(
                                ValueKey("detailalamatMulti $idx"),
                                controllerTextEditing:
                                    controller.detailalamatMulti[idx]),
                            sizedBoxJarak(24),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleProvince"
                                    .tr,
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formProvinsi(ValueKey("provinsiMulti $idx"),
                                controllerTextEditing:
                                    controller.provinsiMulti[idx]),
                            sizedBoxJarak(24),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitlePICName"
                                    .tr,
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formNamaPic(ValueKey("namaPicMulti $idx"),
                                controllerTextEditing:
                                    controller.namaPicMulti[idx]),
                            sizedBoxJarak(24),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleTelpPic"
                                    .tr,
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formNoTelpPic(ValueKey("noTelpPicMulti $idx"),
                                controllerTextEditing:
                                    controller.noTelpPicMulti[idx]),
                            sizedBoxJarak(24),
                            if (idx + 1 !=
                                controller.dropdownJumlahLokasi.value)
                              dividerCust(),
                            if (idx + 1 !=
                                controller.dropdownJumlahLokasi.value)
                              sizedBoxJarak(24)
                          ])
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        labelForm(
                            "LelangMuatDetailLelangDetailLelangLabelTitlePickupAddress"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formAlamat(ValueKey("alamatSatuan"),
                            controllerTextEditing:
                                controller.alamatSatuan.value,
                            satuan: true),
                        if (controller.isKosongAlamatSatuan.value)
                          sizedBoxJarak(4),
                        if (controller.isKosongAlamatSatuan.value)
                          labelForm(
                              "LelangMuatBuatLelangBuatLelangLabelTitleLokasiHarusIsi"
                                  .tr,
                              Color(ListColor.colorRed),
                              14,
                              FontWeight.w600),
                        sizedBoxJarak(24),
                        labelForm(
                            "LelangMuatBuatLelangBuatLelangLabelTitleAddressDetail"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formDetailAlamat(ValueKey("detailalamatSatuan"),
                            controllerTextEditing:
                                controller.detailalamatSatuan.value),
                        sizedBoxJarak(24),
                        labelForm(
                            "LelangMuatBuatLelangBuatLelangLabelTitleProvince"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formProvinsi(ValueKey("provinsiSatuan"),
                            controllerTextEditing:
                                controller.provinsiSatuan.value),
                        sizedBoxJarak(24),
                        labelForm(
                            "LelangMuatBuatLelangBuatLelangLabelTitlePICName"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formNamaPic(ValueKey("namaPicSatuan"),
                            controllerTextEditing:
                                controller.namaPicSatuan.value),
                        sizedBoxJarak(24),
                        labelForm(
                            "LelangMuatBuatLelangBuatLelangLabelTitleTelpPic"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formNoTelpPic(ValueKey("noTelpPicSatuam"),
                            controllerTextEditing:
                                controller.noTelpPicSatuam.value),
                        sizedBoxJarak(24),
                      ],
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      labelForm(
                          "LelangMuatTabAktifTabAktifLabelTitleExpectedPickupTime"
                              .tr,
                          Color(ListColor.colorLightGrey14),
                          14,
                          FontWeight.w700),
                      sizedBoxJarak(8),
                      _formEkspektasiWaktuPickup(),
                      if (controller.isKosongEkspektasiWaktuPickup.value)
                        labelForm(
                            "LelangMuatTabHistoryTabHistoryLabelTitleNotifWaktuHarusIsi"
                                .tr,
                            Color(ListColor.colorRed),
                            14,
                            FontWeight.w600),
                      sizedBoxJarak(4),
                      labelForm(
                          "LelangMuatBuatLelangBuatLelangLabelTitleUntukMultiPickup"
                              .tr,
                          Color(ListColor.colorLightGrey4),
                          11,
                          FontWeight.w600),
                      sizedBoxJarak(24),
                      _formMapPin(),
                      sizedBoxJarak(46),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget informasiDestinasiPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 20,
            GlobalVariable.ratioWidth(Get.context) * 16,
            0),
        child: Obx(() => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  labelForm(
                      "LelangMuatBuatLelangBuatLelangLabelTitleMasukanAlamatDestinasi"
                          .tr,
                      Color(ListColor.colorLightGrey4),
                      14,
                      FontWeight.w700),
                  sizedBoxJarak(24),
                  labelForm("LelangMuatBuatLelangBuatLelangLabelTitleType".tr,
                      Color(ListColor.colorLightGrey14), 14, FontWeight.w700),
                  sizedBoxJarak(8),
                  _formTipeDestinasi(),
                  sizedBoxJarak(24),
                  if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitleJumlahLokasi"
                            .tr,
                        Color(ListColor.colorLightGrey14),
                        14,
                        FontWeight.w700),
                  if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    sizedBoxJarak(8),
                  if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    _formJumlahLokasiDestinasi(),
                  if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    sizedBoxJarak(24),
                  if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation"
                          .tr)
                    for (var idx = 0;
                        idx < controller.dropdownJumlahLokasiDestinasi.value;
                        idx++)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleAlamatDestinasi"
                                        .tr +
                                    " ${idx + 1}",
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formAlamatDestinasi(
                                ValueKey("alamatMultiDestinasi $idx"),
                                idx: idx,
                                controllerTextEditing:
                                    controller.alamatMultiDestinasi[idx],
                                satuan: false),
                            Visibility(
                                visible: false,
                                child: _visibleCityList(
                                    controller.cityDestinasi[idx],
                                    ValueKey("cityDestinasi $idx"))),
                            Visibility(
                                visible: false,
                                child: _visibleLatList(
                                    controller.latDestinasi[idx],
                                    ValueKey("latDestinasi $idx"))),
                            Visibility(
                                visible: false,
                                child: _visibleLngList(
                                    controller.lngDestinasi[idx],
                                    ValueKey("lngDestinasi $idx"))),
                            Visibility(
                                visible: false,
                                child: _visibleProvinceIdList(
                                    controller.provinceIdListDestinasi[idx],
                                    ValueKey("provinceIdListDestinasi $idx"))),
                            if (controller.isKosongAlamatMultiDestinasi[idx])
                              sizedBoxJarak(4),
                            if (controller.isKosongAlamatMultiDestinasi[idx])
                              labelForm(
                                  "LelangMuatBuatLelangBuatLelangLabelTitleLokasiHarusIsi"
                                      .tr,
                                  Color(ListColor.colorRed),
                                  14,
                                  FontWeight.w600),
                            sizedBoxJarak(24),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleAddressDetail"
                                    .tr,
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formDetailAlamatDestinasi(
                                ValueKey("detailalamatMultiDestinasi $idx"),
                                controllerTextEditing:
                                    controller.detailalamatMultiDestinasi[idx]),
                            sizedBoxJarak(24),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleProvince"
                                    .tr,
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formProvinsiDestinasi(
                                ValueKey("provinsiMultiDestinasi $idx"),
                                controllerTextEditing:
                                    controller.provinsiMultiDestinasi[idx]),
                            sizedBoxJarak(24),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitlePICName"
                                    .tr,
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formNamaPicDestinasi(
                                ValueKey("namaPicMultiDestinasi $idx"),
                                controllerTextEditing:
                                    controller.namaPicMultiDestinasi[idx]),
                            sizedBoxJarak(24),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleTelpPic"
                                    .tr,
                                Color(ListColor.colorLightGrey14),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            _formNoTelpPicDestinasi(
                                ValueKey("noTelpPicMultiDestinasi $idx"),
                                controllerTextEditing:
                                    controller.noTelpPicMultiDestinasi[idx]),
                            sizedBoxJarak(24),
                            if (idx + 1 !=
                                controller.dropdownJumlahLokasiDestinasi.value)
                              dividerCust(),
                            if (idx + 1 !=
                                controller.dropdownJumlahLokasiDestinasi.value)
                              sizedBoxJarak(24)
                          ])
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        labelForm(
                            "LelangMuatDetailLelangDetailLelangLabelTitlePickupAddress"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formAlamatDestinasi(ValueKey("alamatSatuanDestinasi"),
                            controllerTextEditing:
                                controller.alamatSatuanDestinasi.value,
                            satuan: true),
                        if (controller.isKosongAlamatSatuanDestinasi.value)
                          sizedBoxJarak(4),
                        if (controller.isKosongAlamatSatuanDestinasi.value)
                          labelForm(
                              "LelangMuatBuatLelangBuatLelangLabelTitleLokasiHarusIsi"
                                  .tr,
                              Color(ListColor.colorRed),
                              14,
                              FontWeight.w600),
                        sizedBoxJarak(24),
                        labelForm(
                            "LelangMuatBuatLelangBuatLelangLabelTitleAddressDetail"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formDetailAlamatDestinasi(
                            ValueKey("detailalamatSatuanDestinasi"),
                            controllerTextEditing:
                                controller.detailalamatSatuanDestinasi.value),
                        sizedBoxJarak(24),
                        labelForm(
                            "LelangMuatBuatLelangBuatLelangLabelTitleProvince"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formProvinsiDestinasi(
                            ValueKey("provinsiSatuanDestinasi"),
                            controllerTextEditing:
                                controller.provinsiSatuanDestinasi.value),
                        sizedBoxJarak(24),
                        labelForm(
                            "LelangMuatBuatLelangBuatLelangLabelTitlePICName"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formNamaPicDestinasi(
                            ValueKey("namaPicSatuanDestinasi"),
                            controllerTextEditing:
                                controller.namaPicSatuanDestinasi.value),
                        sizedBoxJarak(24),
                        labelForm(
                            "LelangMuatBuatLelangBuatLelangLabelTitleTelpPic"
                                .tr,
                            Color(ListColor.colorLightGrey14),
                            14,
                            FontWeight.w700),
                        sizedBoxJarak(8),
                        _formNoTelpPicDestinasi(
                            ValueKey("noTelpPicSatuamDestinasi"),
                            controllerTextEditing:
                                controller.noTelpPicSatuamDestinasi.value),
                        sizedBoxJarak(24),
                      ],
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      labelForm(
                          "LelangMuatTabAktifTabAktifLabelTitleExpectedArrivalTime"
                              .tr,
                          Color(ListColor.colorLightGrey14),
                          14,
                          FontWeight.w700),
                      sizedBoxJarak(8),
                      _formEkspektasiWaktuPickupDestinasi(),
                      if (controller.isKosongEkspektasiWaktuDestinasi.value)
                        labelForm(
                            "LelangMuatTabHistoryTabHistoryLabelTitleNotifWaktuHarusIsi"
                                .tr,
                            Color(ListColor.colorRed),
                            14,
                            FontWeight.w600),
                      sizedBoxJarak(4),
                      labelForm(
                          "LelangMuatBuatLelangBuatLelangLabelTitleUntukMultiDestinasi"
                              .tr,
                          Color(ListColor.colorLightGrey4),
                          11,
                          FontWeight.w600),
                      sizedBoxJarak(24),
                      _formMapPinDestinasi(),
                      sizedBoxJarak(46),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget dataPenawaranPage() {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.fromLTRB(
              GlobalVariable.ratioWidth(Get.context) * 16,
              GlobalVariable.ratioWidth(Get.context) * 20,
              GlobalVariable.ratioWidth(Get.context) * 16,
              0),
          child: Obx(() => Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitleBuatDataPenawaran"
                            .tr,
                        Color(ListColor.colorLightGrey4),
                        14,
                        FontWeight.w700),
                    sizedBoxJarak(24),
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitleMaximumBid".tr,
                        Color(ListColor.colorLightGrey14),
                        14,
                        FontWeight.w700),
                    sizedBoxJarak(8),
                    _formMaksHargaPenawaran(),
                    sizedBoxJarak(24),
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitleBidOffer".tr,
                        Color(ListColor.colorLightGrey14),
                        14,
                        FontWeight.w700),
                    sizedBoxJarak(8),
                    _formHargaPenawaran(),
                    sizedBoxJarak(24),
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitleSpecialHandling"
                            .tr,
                        Color(ListColor.colorLightGrey14),
                        14,
                        FontWeight.w700),
                    sizedBoxJarak(8),
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitleLoadingPosition"
                            .tr,
                        Color(ListColor.colorLightGrey14),
                        12,
                        FontWeight.w600),
                    sizedBoxJarak(8),
                    _formTempatMuat(),
                    sizedBoxJarak(18),
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitleUnloadingPosition"
                            .tr,
                        Color(ListColor.colorLightGrey14),
                        12,
                        FontWeight.w600),
                    sizedBoxJarak(8),
                    _formTempatBongkar(),
                    sizedBoxJarak(24),
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTerm"
                            .tr,
                        Color(ListColor.colorLightGrey14),
                        14,
                        FontWeight.w700),
                    sizedBoxJarak(8),
                    _formTerminPembayaran(),
                    sizedBoxJarak(24),
                    dividerCust(),
                    sizedBoxJarak(24),
                    labelForm(
                        "LelangMuatBuatLelangBuatLelangLabelTitleAdditionalNote"
                            .tr,
                        Color(ListColor.colorLightGrey14),
                        14,
                        FontWeight.w700),
                    sizedBoxJarak(8),
                    _formCatatanTambahan(),
                    sizedBoxJarak(46),
                  ],
                ),
              ))),
    );
  }

  Widget dividerCust() {
    return Divider(
      height: 2,
      thickness: 2,
      color: Color(ListColor.colorLightGrey5).withOpacity(0.29),
    );
  }

  Widget sizedBoxJarak(double nilai) {
    return SizedBox(
      height: GlobalVariable.ratioWidth(Get.context) * nilai,
    );
  }

  Widget labelForm(String labelName, color, sizefont, weightfont) {
    return CustomText(labelName,
        fontSize: GlobalVariable.ratioFontSize(Get.context) * sizefont,
        fontWeight: weightfont,
        color: color,
        height: GlobalVariable.ratioFontSize(Get.context) * (17 / sizefont));
  }

  _formCatatanTambahan() {
    return Container(
      child: CustomTextField(
        key: ValueKey("catatanTambahan"),
        context: Get.context,
        inputFormatters: [LengthLimitingTextInputFormatter(255)],
        maxLines: 6,
        controller: controller.catatanTambahan.value,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            vertical: GlobalVariable.ratioWidth(Get.context) * 10),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText:
              "LelangMuatBuatLelangBuatLelangLabelTitleMasukanCatatanTambahan"
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
        ),
      ),
    );
  }

  _formTerminPembayaran() {
    return Column(
      children: [
        RadioButtonCustomWithText(
          isDense: true,
          isWithShadow: true,
          colorRoundedBG: Colors.white,
          radioSize: GlobalVariable.ratioFontSize(Get.context) * 20,
          groupValue: controller.terminPembayaran.value,
          value:
              "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermCashLoad".tr,
          customTextWidget: labelForm(
              "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermCashLoad".tr,
              Colors.black,
              14,
              FontWeight.w600),
          onChanged: (val) {
            controller.terminPembayaran.value = val;
            controller.lainlainTerminPembayaranForm.value.text = "";
            controller.lainlaintermin.value = false;
            controller.berjangkaDropdown.value = 1;
          },
        ),
        sizedBoxJarak(12),
        RadioButtonCustomWithText(
          isDense: true,
          isWithShadow: true,
          colorRoundedBG: Colors.white,
          radioSize: GlobalVariable.ratioFontSize(Get.context) * 20,
          groupValue: controller.terminPembayaran.value,
          value: "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermCashUnload"
              .tr,
          customTextWidget: labelForm(
              "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermCashUnload"
                  .tr,
              Colors.black,
              14,
              FontWeight.w600),
          onChanged: (val) {
            controller.terminPembayaran.value = val;
            controller.lainlainTerminPembayaranForm.value.text = "";
            controller.lainlaintermin.value = false;
            controller.berjangkaDropdown.value = 1;
          },
        ),
        sizedBoxJarak(12),
        RadioButtonCustomWithText(
          isDense: true,
          isWithShadow: true,
          colorRoundedBG: Colors.white,
          radioSize: GlobalVariable.ratioFontSize(Get.context) * 20,
          groupValue: controller.terminPembayaran.value,
          value: "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture".tr,
          customTextWidget: labelForm(
              "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture".tr,
              Colors.black,
              14,
              FontWeight.w600),
          onChanged: (val) {
            controller.terminPembayaran.value = val;
            controller.lainlainTerminPembayaranForm.value.text = "";
            controller.lainlaintermin.value = false;
          },
        ),
        sizedBoxJarak(8.5),
        Padding(
          padding: EdgeInsets.only(
              left: GlobalVariable.ratioFontSize(Get.context) * 28),
          child: Row(
            children: [
              Container(
                  child: DropdownBelow(
                key: ValueKey("berjangkaDropdown"),
                items: [
                  if (controller.terminPembayaran.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture"
                          .tr)
                    DropdownMenuItem(
                      child: CustomText("1",
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          color: Colors.black),
                      value: 1,
                    ),
                  if (controller.terminPembayaran.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture"
                          .tr)
                    DropdownMenuItem(
                      child: CustomText("2",
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          color: Colors.black),
                      value: 2,
                    ),
                  if (controller.terminPembayaran.value ==
                      "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture"
                          .tr)
                    DropdownMenuItem(
                      child: CustomText("3",
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          color: Colors.black),
                      value: 3,
                    ),
                ],
                onChanged: (value) {
                  controller.berjangkaDropdown.value = value;
                },
                itemWidth: 100,
                itemTextstyle: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w400,
                    color: Color(ListColor.colorLightGrey4)),
                boxTextstyle: TextStyle(
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w400,
                    color: Color(ListColor.colorLightGrey4)),
                boxPadding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 12,
                    right: GlobalVariable.ratioWidth(Get.context) * 12),
                // boxPadding: EdgeInsets.symmetric(
                //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                boxWidth: 100,
                // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 46,
                boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
                    GlobalVariable.ratioWidth(Get.context) * 13.5 +
                    GlobalVariable.ratioWidth(Get.context) * 13.5,
                boxDecoration: BoxDecoration(
                    color: controller.terminPembayaran.value ==
                            "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture"
                                .tr
                        ? Colors.white
                        : Color(ListColor.colorLightGrey2),
                    border: Border.all(
                        width: 1, color: Color(ListColor.colorLightGrey19)),
                    borderRadius: BorderRadius.circular(6)),
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: GlobalVariable.ratioFontSize(Get.context) * 24,
                  color: Color(ListColor.colorLightGrey19),
                ),
                hint: CustomText(
                  controller.berjangkaDropdown.value.toString(),
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4),
                ),
                value: controller.terminPembayaran.value ==
                        "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermFuture"
                            .tr
                    ? controller.berjangkaDropdown.value
                    : null,
              )),
              SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 12),
              labelForm(
                  " / " +
                      "LelangMuatBuatLelangBuatLelangLabelTitlePaymentTermMonth"
                          .tr,
                  Colors.black,
                  14,
                  FontWeight.w600)
            ],
          ),
        ),
        sizedBoxJarak(12),
        RadioButtonCustomWithText(
          isDense: true,
          isWithShadow: true,
          colorRoundedBG: Colors.white,
          radioSize: GlobalVariable.ratioFontSize(Get.context) * 20,
          groupValue: controller.terminPembayaran.value,
          value: "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr,
          customTextWidget: labelForm(
              "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr,
              Colors.black,
              14,
              FontWeight.w600),
          onChanged: (val) {
            controller.terminPembayaran.value = val;
            controller.lainlaintermin.value = true;
            controller.berjangkaDropdown.value = 1;
          },
        ),
        if (controller.lainlaintermin.value) sizedBoxJarak(8),
        if (controller.lainlaintermin.value)
          Padding(
              padding: EdgeInsets.only(
                  left: GlobalVariable.ratioFontSize(Get.context) * 28),
              child: CustomTextField(
                key: ValueKey("lainlainTerminPembayaranForm"),
                context: Get.context,
                maxLines: 6,
                controller: controller.lainlainTerminPembayaranForm.value,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "Transfer", // "Cari Area Pick Up",
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
                ),
              )),
      ],
    );
  }

  _formTempatBongkar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  colorBG: Colors.white,
                  borderColor: Color(ListColor.colorLightGrey14),
                  isWithShadow: true,
                  value: controller.tempatBongkarForklift.value,
                  onChanged: (value) {
                    controller.tempatBongkarForklift.value = value;
                    controller.tempatBongkarForkliftVal.value = "ForkLift";
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
                child: CustomText(
              "ForkLift",
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ))
          ],
        ),
        sizedBoxJarak(12),
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  colorBG: Colors.white,
                  borderColor: Color(ListColor.colorLightGrey14),
                  isWithShadow: true,
                  value: controller.tempatBongkarCrane.value,
                  onChanged: (value) {
                    controller.tempatBongkarCrane.value = value;
                    controller.tempatBongkarCraneVal.value = "Crane";
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
                child: CustomText(
              "Crane",
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ))
          ],
        ),
        sizedBoxJarak(12),
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  borderColor: Color(ListColor.colorLightGrey14),
                  colorBG: Colors.white,
                  isWithShadow: true,
                  value: controller.tempatBongkarJasaTenagaMuat.value,
                  onChanged: (value) {
                    controller.tempatBongkarJasaTenagaMuat.value = value;
                    controller.tempatBongkarJasaTenagaMuatVal.value =
                        "LelangMuatBuatLelangBuatLelangLabelTitleJasaTenaga".tr;
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
              child: CustomText(
                "LelangMuatBuatLelangBuatLelangLabelTitleJasaTenaga".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )
          ],
        ),
        sizedBoxJarak(12),
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  colorBG: Colors.white,
                  borderColor: Color(ListColor.colorLightGrey14),
                  isWithShadow: true,
                  value: controller.tempatBongkarLainLain.value,
                  onChanged: (value) {
                    controller.tempatBongkarLainLain.value = value;
                    controller.tempatBongkarLainLainVal.value =
                        "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr;
                    if (value == false) {
                      controller.tempatbongkarlainlainform.value.text = "";
                    }
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
              child: CustomText(
                "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        if (controller.tempatBongkarLainLain.value) sizedBoxJarak(8),
        if (controller.tempatBongkarLainLain.value)
          Padding(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioFontSize(Get.context) * 28),
            child: Container(
              width: MediaQuery.of(Get.context).size.width * 0.6,
              child: CustomTextField(
                key: ValueKey("tempatbongkarlainlainform"),
                inputFormatters: [LengthLimitingTextInputFormatter(255)],
                context: Get.context,
                controller: controller.tempatbongkarlainlainform.value,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "Hand Pallet", // "Cari Area Pick Up",
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
                ),
              ),
            ),
          )
      ],
    );
  }

  _formTempatMuat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  borderColor: Color(ListColor.colorLightGrey14),
                  colorBG: Colors.white,
                  isWithShadow: true,
                  value: controller.tempatMuatForklift.value,
                  onChanged: (value) {
                    controller.tempatMuatForklift.value = value;
                    controller.tempatMuatForkliftVal.value = "ForkLift";
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
                child: CustomText(
              "ForkLift",
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ))
          ],
        ),
        sizedBoxJarak(12),
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  colorBG: Colors.white,
                  borderColor: Color(ListColor.colorLightGrey14),
                  isWithShadow: true,
                  value: controller.tempatMuatCrane.value,
                  onChanged: (value) {
                    controller.tempatMuatCrane.value = value;
                    controller.tempatMuatCraneVal.value = "Crane";
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
                child: CustomText(
              "Crane",
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ))
          ],
        ),
        sizedBoxJarak(12),
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  borderColor: Color(ListColor.colorLightGrey14),
                  colorBG: Colors.white,
                  isWithShadow: true,
                  value: controller.tempatMuatJasaTenagaMuat.value,
                  onChanged: (value) {
                    controller.tempatMuatJasaTenagaMuat.value = value;
                    controller.tempatMuatJasaTenagaMuatVal.value =
                        "LelangMuatBuatLelangBuatLelangLabelTitleJasaTenaga".tr;
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
              child: CustomText(
                "LelangMuatBuatLelangBuatLelangLabelTitleJasaTenaga".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )
          ],
        ),
        sizedBoxJarak(12),
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  borderColor: Color(ListColor.colorLightGrey14),
                  colorBG: Colors.white,
                  isWithShadow: true,
                  value: controller.tempatMuatLainLain.value,
                  onChanged: (value) {
                    controller.tempatMuatLainLain.value = value;
                    controller.tempatMuatLainLainVal.value =
                        "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr;
                    if (value == false) {
                      controller.tempatmuatlainlainform.value.text = "";
                    }
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
              child: CustomText(
                "LelangMuatBuatLelangBuatLelangLabelTitleOthers".tr,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )
          ],
        ),
        if (controller.tempatMuatLainLain.value) sizedBoxJarak(8),
        if (controller.tempatMuatLainLain.value)
          Padding(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioFontSize(Get.context) * 28),
            child: Container(
              width: MediaQuery.of(Get.context).size.width * 0.6,
              child: CustomTextField(
                key: ValueKey("tempatmuatlainlainform"),
                inputFormatters: [LengthLimitingTextInputFormatter(255)],
                context: Get.context,
                controller: controller.tempatmuatlainlainform.value,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4),
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText: "Hand Pallet", // "Cari Area Pick Up",
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
                ),
              ),
            ),
          )
      ],
    );
  }

  _formHargaPenawaran() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  borderColor: Color(ListColor.colorLightGrey14),
                  colorBG: Colors.white,
                  isWithShadow: true,
                  value: controller.checkBoxTarifJasaTransport.value,
                  onChanged: (value) {
                    controller.checkBoxTarifJasaTransport.value = value;
                    controller.checkBoxTarifJasaTransportVal.value =
                        "LelangMuatBuatLelangBuatLelangLabelTitleTransportFee"
                            .tr;
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
                child: CustomText(
                    "LelangMuatBuatLelangBuatLelangLabelTitleTransportFee".tr,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black))
          ],
        ),
        sizedBoxJarak(12),
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  borderColor: Color(ListColor.colorLightGrey14),
                  colorBG: Colors.white,
                  isWithShadow: true,
                  value: controller.checkBoxAsuransiBarang.value,
                  onChanged: (value) {
                    controller.checkBoxAsuransiBarang.value = value;
                    controller.checkBoxAsuransiBarangVal.value =
                        "LelangMuatBuatLelangBuatLelangLabelTitleItemInsurance"
                            .tr;
                    if (value == false) {
                      controller.nilaiBarang.value.text = "";
                    }
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
              child: CustomText(
                  "LelangMuatBuatLelangBuatLelangLabelTitleItemInsurance".tr,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            )
          ],
        ),
        if (controller.checkBoxAsuransiBarang.value)
          Padding(
            padding: EdgeInsets.only(
                left: GlobalVariable.ratioFontSize(Get.context) * 28),
            child: Row(
              children: [
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleNilaiBarang".tr,
                    Colors.black,
                    14,
                    FontWeight.w600),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                Expanded(
                  child: CustomTextField(
                      key: ValueKey("nilaiBarang"),
                      context: Get.context,
                      controller: controller.nilaiBarang.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        ThousanSeparatorFormater()
                      ],
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
                        hintText: "Rp 400.000", // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey2),
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                )
              ],
            ),
          ),
        sizedBoxJarak(7),
        Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 5,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  borderColor: Color(ListColor.colorLightGrey14),
                  colorBG: Colors.white,
                  isWithShadow: true,
                  value: controller.checkBoxBiayaPengawalan.value,
                  onChanged: (value) {
                    controller.checkBoxBiayaPengawalan.value = value;
                    controller.checkBoxBiayaPengawalanVal.value =
                        "LelangMuatBuatLelangBuatLelangLabelTitleEscortFee".tr;
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: GlobalVariable.ratioWidth(Get.context) * 0),
                  child: labelForm(
                      "LelangMuatBuatLelangBuatLelangLabelTitleEscortFee".tr,
                      Colors.black,
                      GlobalVariable.ratioFontSize(Get.context) * 14,
                      FontWeight.w600)

                  // CustomText(
                  //     "LelangMuatBuatLelangBuatLelangLabelTitleEscortFee".tr,
                  //     fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.black),
                  ),
            )
          ],
        ),
        sizedBoxJarak(7),
        Row(
          children: [
            Container(
              child: CheckBoxCustom(
                  paddingL: 0,
                  paddingB: 0,
                  paddingT: 0,
                  size: 15,
                  shadowSize: 19,
                  border: 1,
                  borderColor: Color(ListColor.colorLightGrey14),
                  colorBG: Colors.white,
                  isWithShadow: true,
                  value: controller.checkBoxBiayaJalan.value,
                  onChanged: (value) {
                    controller.checkBoxBiayaJalan.value = value;
                    controller.checkBoxBiayaJalanVal.value =
                        "LelangMuatBuatLelangBuatLelangLabelTitleTollFee".tr;
                  }),
            ),
            sizedBoxJarak(8),
            Expanded(
                child: CustomText(
                    "LelangMuatBuatLelangBuatLelangLabelTitleTollFee".tr,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black))
          ],
        )
      ],
    );
  }

  _formMaksHargaPenawaran() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: RadioButtonCustom(
                isDense: true,
                colorRoundedBG: Colors.white,
                groupValue: controller.radioButtonMakHarga.value,
                value: "1",
                isWithShadow: true,
                width: GlobalVariable.ratioFontSize(Get.context) * 20,
                height: GlobalVariable.ratioFontSize(Get.context) * 20,
                onChanged: (val) {
                  controller.radioButtonMakHarga.value = val;
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      key: ValueKey("hargaUnitTruk"),
                      context: Get.context,
                      controller: controller.hargaUnitTruk.value,
                      onChanged: (value) async {
                        if (value.length > 0) {
                          controller.radioButtonMakHarga.value = "1";
                        }
                      },
                      inputFormatters: [
                        // FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]*$')),
                        LengthLimitingTextInputFormatter(13),
                        ThousanSeparatorFormater()
                      ],
                      keyboardType: TextInputType.number,
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
                            "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderMaxPrice"
                                .tr, // "Cari Area Pick Up",
                        fillColor: Colors.white,
                        filled: true,
                        hintStyle: TextStyle(
                            color: Color(ListColor.colorLightGrey2),
                            fontWeight: FontWeight.w600,
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(ListColor.colorLightGrey19),
                              width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )),
                ),
                Container(
                  child: labelForm(
                      " " +
                          "LelangMuatBuatLelangBuatLelangLabelTitleUnitTruk".tr,
                      Colors.black,
                      14,
                      FontWeight.w600),
                )
              ],
            )),
          ],
        ),
        sizedBoxJarak(4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: GlobalVariable.ratioFontSize(Get.context) * 20,
              height: GlobalVariable.ratioFontSize(Get.context) * 20,
            ),
            SizedBox(width: 8),
            Expanded(
                child: labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleExpectedMaxPrice"
                        .tr,
                    Color(ListColor.colorLightGrey4),
                    10,
                    FontWeight.w600)),
          ],
        ),
        sizedBoxJarak(12),
        Row(
          children: [
            Container(
              child: RadioButtonCustom(
                isDense: true,
                colorRoundedBG: Colors.white,
                groupValue: controller.radioButtonMakHarga.value,
                value: "2",
                isWithShadow: true,
                width: GlobalVariable.ratioFontSize(Get.context) * 20,
                height: GlobalVariable.ratioFontSize(Get.context) * 20,
                onChanged: (val) {
                  controller.radioButtonMakHarga.value = val;
                  controller.hargaUnitTruk.value.text = "";
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: labelForm(
                  "LelangMuatBuatLelangBuatLelangLabelTitleTidakAdaBatasMax".tr,
                  Colors.black,
                  14,
                  FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }

  _formJumlahLokasi() {
    return Obx(() => Container(
            child: DropdownBelow(
          key: ValueKey("dropdownJumlahLokasi"),
          items: [
            DropdownMenuItem(
              child: CustomText("2",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: 2,
            ),
            DropdownMenuItem(
              child: CustomText("3",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: 3,
            ),
            DropdownMenuItem(
              child: CustomText("4",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: 4,
            ),
            DropdownMenuItem(
              child: CustomText("5",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: 5,
            )
          ],
          onChanged: (int value) {
            controller.jumlahTrukDropdown(select: value);
          },
          itemWidth: MediaQuery.of(Get.context).size.width * 0.5,
          itemTextstyle: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w400,
              color: Color(ListColor.colorLightGrey4)),
          boxTextstyle: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w400,
              color: Color(ListColor.colorLightGrey4)),
          boxPadding: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 12,
              right: GlobalVariable.ratioWidth(Get.context) * 12),
          // boxPadding: EdgeInsets.symmetric(
          //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
          //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
          boxWidth: MediaQuery.of(Get.context).size.width * 0.5,
          // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 46,
          boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
              GlobalVariable.ratioWidth(Get.context) * 13.5 +
              GlobalVariable.ratioWidth(Get.context) * 13.5,
          boxDecoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: 1, color: Color(ListColor.colorLightGrey19)),
              borderRadius: BorderRadius.circular(6)),
          icon: Icon(Icons.keyboard_arrow_down_outlined,
              size: GlobalVariable.ratioFontSize(Get.context) * 24,
              color: Color(ListColor.colorLightGrey19)),
          hint: CustomText(controller.dropdownJumlahLokasi.value.toString(),
              fontWeight: FontWeight.w600,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              color: Color(ListColor.colorLightGrey4)),
          value: controller.dropdownJumlahLokasi.value,
        )));
  }

  _formJumlahLokasiDestinasi() {
    return Obx(() => Container(
            child: DropdownBelow(
          key: ValueKey("dropdownJumlahLokasiDestinasi"),
          items: [
            DropdownMenuItem(
              child: CustomText("2",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: 2,
            ),
            DropdownMenuItem(
              child: CustomText("3",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: 3,
            ),
            DropdownMenuItem(
              child: CustomText("4",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: 4,
            ),
            DropdownMenuItem(
              child: CustomText("5",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: 5,
            )
          ],
          onChanged: (value) {
            controller.jumlahTrukDropdownDestinasi(select: value);
          },
          itemWidth: MediaQuery.of(Get.context).size.width * 0.5,
          itemTextstyle: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w400,
              color: Color(ListColor.colorLightGrey4)),
          boxTextstyle: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w400,
              color: Color(ListColor.colorLightGrey4)),
          boxPadding: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 12,
              right: GlobalVariable.ratioWidth(Get.context) * 12),
          // boxPadding: EdgeInsets.symmetric(
          //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
          //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
          boxWidth: MediaQuery.of(Get.context).size.width * 0.5,
          // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 46,
          boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
              GlobalVariable.ratioWidth(Get.context) * 13.5 +
              GlobalVariable.ratioWidth(Get.context) * 13.5,
          boxDecoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: 1, color: Color(ListColor.colorLightGrey19)),
              borderRadius: BorderRadius.circular(6)),
          icon: Icon(Icons.keyboard_arrow_down_outlined,
              size: GlobalVariable.ratioFontSize(Get.context) * 24,
              color: Color(ListColor.colorLightGrey19)),
          hint: CustomText(
              controller.dropdownJumlahLokasiDestinasi.value.toString(),
              fontWeight: FontWeight.w600,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              color: Color(ListColor.colorLightGrey4)),
          value: controller.dropdownJumlahLokasiDestinasi.value,
        )));
  }

  _formMapPin() {
    return Obx(
      () => Column(
        // alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: GlobalVariable.ratioWidth(Get.context) * 150,
            width: MediaQuery.of(Get.context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
              child: FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                    center: controller.currentLocation.value,
                    interactiveFlags: InteractiveFlag.all),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: [
                      if (controller.radioButtonSatuMultipleLokasi.value ==
                          "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation"
                              .tr)
                        (!controller.currentLocation.isNull)
                            ? Marker(
                                width: GlobalVariable.ratioWidth(Get.context) *
                                    24.0,
                                height: GlobalVariable.ratioWidth(Get.context) *
                                    24.0,
                                point: controller.currentLocation.value,
                                // point: controller.currentLocation.value,
                                builder: (ctx) => Container(
                                    child: SvgPicture.asset("assets/pin7.svg")),
                              )
                            : null
                      else
                        for (var idx = 0;
                            idx < controller.dropdownJumlahLokasi.value;
                            idx++)
                          Marker(
                            width:
                                GlobalVariable.ratioWidth(Get.context) * 24.0,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24.0,
                            point: controller.currentLocationList[idx],
                            // point: controller.currentLocation.value,
                            builder: (ctx) => Container(
                                child: SvgPicture.asset(controller.pin[idx])),
                          )
                    ],
                  ),
                  PolylineLayerOptions(polylines: [
                    Polyline(
                        points: controller.listRoute.value,
                        strokeWidth: 4,
                        color: Colors.purple)
                  ])
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (controller.radioButtonSatuMultipleLokasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr) {
                controller.toMapPinSelectPickup();
              } else {
                controller.toMapFullScreenTambahPickup();
              }
            },
            child: Container(
              height: GlobalVariable.ratioWidth(Get.context) * 35,
              width: MediaQuery.of(Get.context).size.width,
              decoration: BoxDecoration(
                color: Color(ListColor.color4),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              child: Center(
                child: CustomText(
                    "LelangMuatBuatLelangBuatLelangLabelTitleAturPinLokasi".tr,
                    textAlign: TextAlign.center,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _formMapPinDestinasi() {
    return Column(
      // alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: GlobalVariable.ratioWidth(Get.context) * 150,
          width: MediaQuery.of(Get.context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            child: FlutterMap(
              mapController: controller.mapControllerDestinasi,
              options: MapOptions(
                  center: controller.currentLocationDestinasi.value,
                  interactiveFlags: InteractiveFlag.all),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    if (controller
                            .radioButtonSatuMultipleLokasiDestinasi.value ==
                        "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation"
                            .tr)
                      (!controller.currentLocationDestinasi.isNull)
                          ? Marker(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 24.0,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24.0,
                              point: controller.currentLocationDestinasi.value,
                              // point: controller.currentLocation.value,
                              builder: (ctx) => Container(
                                  child: SvgPicture.asset("assets/pin7.svg")),
                            )
                          : null
                    else
                      for (var idx = 0;
                          idx < controller.dropdownJumlahLokasiDestinasi.value;
                          idx++)
                        Marker(
                          width: GlobalVariable.ratioWidth(Get.context) * 24.0,
                          height: GlobalVariable.ratioWidth(Get.context) * 24.0,
                          point: controller.currentLocationDestinasiList[idx],
                          // point: controller.currentLocation.value,
                          builder: (ctx) => Container(
                              child: SvgPicture.asset(controller.pin[idx])),
                        )
                  ],
                ),
                PolylineLayerOptions(polylines: [
                  Polyline(
                      points: controller.listRoute.value,
                      strokeWidth: 4,
                      color: Colors.purple)
                ])
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr) {
              controller.toMapPinSelectDestinasi();
            } else {
              controller.toMapFullScreenTambahDestinasi();
            }
          },
          child: Container(
            height: GlobalVariable.ratioWidth(Get.context) * 35,
            width: MediaQuery.of(Get.context).size.width,
            decoration: BoxDecoration(
              color: Color(ListColor.color4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
            ),
            child: Center(
              child: CustomText(
                  "LelangMuatBuatLelangBuatLelangLabelTitleAturPinLokasi".tr,
                  textAlign: TextAlign.center,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  _formEkspektasiWaktuPickup() {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              CustomTextField(
                  key: ValueKey("ekspektasiwaktupickup"),
                  context: Get.context,
                  readOnly: true,
                  onTap: () {
                    _dateTimePickerPickup();
                  },
                  controller: controller.ekspektasiwaktupickup.value,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  newContentPadding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                  textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  newInputDecoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: "26 Des 2021 12:00", // "Cari Area Pick Up",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey2),
                        fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: controller.isKosongEkspektasiWaktuPickup.value
                              ? Color(ListColor.colorRed)
                              : Color(ListColor.colorLightGrey19),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: controller.isKosongEkspektasiWaktuPickup.value
                              ? Color(ListColor.colorRed)
                              : Color(ListColor.colorLightGrey19),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: controller.isKosongEkspektasiWaktuPickup.value
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
                      _dateTimePickerPickup();
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: SvgPicture.asset("assets/ic_calendar.svg",
                            color: Color(ListColor.colorLightGrey4),
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24)),
                  )),
            ],
          ),
        ),
        SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
        Container(
            child: DropdownBelow(
          key: ValueKey("bagianwaktuinformasiPickup"),
          items: [
            DropdownMenuItem(
              child: CustomText("WIB",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: "WIB",
            ),
            DropdownMenuItem(
              child: CustomText("WITA",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: "WITA",
            ),
            DropdownMenuItem(
              child: CustomText("WIT",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: "WIT",
            )
          ],
          onChanged: (value) {
            controller.bagianwaktuinformasiPickup.value = value;
          },
          itemWidth: 100,
          itemTextstyle: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w400,
              color: Color(ListColor.colorLightGrey4)),
          boxTextstyle: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w400,
              color: Color(ListColor.colorLightGrey4)),
          boxPadding: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 12,
              right: GlobalVariable.ratioWidth(Get.context) * 12),
          // boxPadding: EdgeInsets.symmetric(
          //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
          //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
          boxWidth: 100,
          // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 46,
          boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
              GlobalVariable.ratioWidth(Get.context) * 13.5 +
              GlobalVariable.ratioWidth(Get.context) * 13.5,
          boxDecoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: 1, color: Color(ListColor.colorLightGrey19)),
              borderRadius: BorderRadius.circular(6)),
          icon: Icon(Icons.keyboard_arrow_down_outlined,
              size: GlobalVariable.ratioFontSize(Get.context) * 24,
              color: Color(ListColor.colorLightGrey19)),
          hint: CustomText(controller.bagianwaktuinformasiPickup.value,
              fontWeight: FontWeight.w600,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              color: Color(ListColor.colorLightGrey4)),
          value: controller.bagianwaktuinformasiPickup.value,
        ))
      ],
    );
  }

  _formEkspektasiWaktuPickupDestinasi() {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              CustomTextField(
                  key: ValueKey("ekspektasiwaktupickupDestinasi"),
                  context: Get.context,
                  readOnly: true,
                  onTap: () {
                    _dateTimePickerDestinasi();
                  },
                  controller: controller.ekspektasiwaktupickupDestinasi.value,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  newContentPadding: EdgeInsets.symmetric(
                      horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                      vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                  textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  newInputDecoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: "26 Des 2021 12:00", // "Cari Area Pick Up",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey2),
                        fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              controller.isKosongEkspektasiWaktuDestinasi.value
                                  ? Color(ListColor.colorRed)
                                  : Color(ListColor.colorLightGrey19),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              controller.isKosongEkspektasiWaktuDestinasi.value
                                  ? Color(ListColor.colorRed)
                                  : Color(ListColor.colorLightGrey19),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              controller.isKosongEkspektasiWaktuDestinasi.value
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
                      _dateTimePickerDestinasi();
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: SvgPicture.asset("assets/ic_calendar.svg",
                            color: Color(ListColor.colorLightGrey4),
                            width: GlobalVariable.ratioWidth(Get.context) * 24,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 24)),
                  )),
            ],
          ),
        ),
        SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
        Container(
            child: DropdownBelow(
          key: ValueKey("bagianwaktuinformasiDestinasi"),
          items: [
            DropdownMenuItem(
              child: CustomText("WIB",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: "WIB",
            ),
            DropdownMenuItem(
              child: CustomText("WITA",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: "WITA",
            ),
            DropdownMenuItem(
              child: CustomText("WIT",
                  fontWeight: FontWeight.w600,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  color: Color(ListColor.colorLightGrey4)),
              value: "WIT",
            )
          ],
          onChanged: (value) {
            controller.bagianwaktuinformasiDestinasi.value = value;
          },
          itemWidth: 100,
          itemTextstyle: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w400,
              color: Color(ListColor.colorLightGrey4)),
          boxTextstyle: TextStyle(
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              fontWeight: FontWeight.w400,
              color: Color(ListColor.colorLightGrey4)),
          boxPadding: EdgeInsets.only(
              left: GlobalVariable.ratioWidth(Get.context) * 12,
              right: GlobalVariable.ratioWidth(Get.context) * 12),
          // boxPadding: EdgeInsets.symmetric(
          //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
          //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
          boxWidth: 100,
          // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 46,
          boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
              GlobalVariable.ratioWidth(Get.context) * 13.5 +
              GlobalVariable.ratioWidth(Get.context) * 13.5,
          boxDecoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: 1, color: Color(ListColor.colorLightGrey19)),
              borderRadius: BorderRadius.circular(6)),
          icon: Icon(Icons.keyboard_arrow_down_outlined,
              size: GlobalVariable.ratioFontSize(Get.context) * 24,
              color: Color(ListColor.colorLightGrey19)),
          hint: CustomText(controller.bagianwaktuinformasiDestinasi.value,
              fontWeight: FontWeight.w600,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              color: Color(ListColor.colorLightGrey4)),
          value: controller.bagianwaktuinformasiDestinasi.value,
        ))
      ],
    );
  }

  _visibleCityList(controllerTextEditing, keynya) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
            vertical: GlobalVariable.ratioWidth(Get.context) * 6),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "city list", // "Cari Area Pick Up",
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
        ));
  }

  _visibleLatList(controllerTextEditing, keynya) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
            vertical: GlobalVariable.ratioWidth(Get.context) * 6),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "lat list", // "Cari Area Pick Up",
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
        ));
  }

  _visibleLngList(controllerTextEditing, keynya) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
            vertical: GlobalVariable.ratioWidth(Get.context) * 6),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "lng list", // "Cari Area Pick Up",
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
        ));
  }

  _visibleProvinceIdList(controllerTextEditing, keynya) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 8,
            vertical: GlobalVariable.ratioWidth(Get.context) * 6),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "id province list", // "Cari Area Pick Up",
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
        ));
  }

  _formNoTelpPic(keynya, {controllerTextEditing}) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          // FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(14),
          FilteringTextInputFormatter.allow(RegExp(r'^[+0-9]*$'))
        ],
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            vertical: GlobalVariable.ratioWidth(Get.context) * 10),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "LelangMuatBuatLelangBuatLelangLabelTitleIsiHpPic"
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
        ));
  }

  _formNoTelpPicDestinasi(keynya, {controllerTextEditing}) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
        keyboardType: TextInputType.number,
        inputFormatters: [
          // FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(14),
          FilteringTextInputFormatter.allow(RegExp(r'^[+0-9]*$'))
        ],
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            vertical: GlobalVariable.ratioWidth(Get.context) * 10),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "LelangMuatBuatLelangBuatLelangLabelTitleIsiHpPic"
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
        ));
  }

  _formNamaPic(keynya, {controllerTextEditing}) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
        inputFormatters: [LengthLimitingTextInputFormatter(255)],
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            vertical: GlobalVariable.ratioWidth(Get.context) * 10),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "LelangMuatBuatLelangBuatLelangLabelTitleNamaPicLokasi"
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
        ));
  }

  _formNamaPicDestinasi(keynya, {controllerTextEditing}) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
        inputFormatters: [LengthLimitingTextInputFormatter(255)],
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            vertical: GlobalVariable.ratioWidth(Get.context) * 10),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "LelangMuatBuatLelangBuatLelangLabelTitleNamaPicLokasi"
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
        ));
  }

  _formProvinsi(keynya, {controllerTextEditing}) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        readOnly: true,
        controller: controllerTextEditing,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            vertical: GlobalVariable.ratioWidth(Get.context) * 10),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText:
              "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderChooseProvince"
                  .tr, // "Cari Area Pick Up",
          fillColor: Color(ListColor.colorLightGrey21),
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
        ));
  }

  _formProvinsiDestinasi(keynya, {controllerTextEditing}) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        readOnly: true,
        controller: controllerTextEditing,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            vertical: GlobalVariable.ratioWidth(Get.context) * 10),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText:
              "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderChooseProvince"
                  .tr, // "Cari Area Pick Up",
          fillColor: Color(ListColor.colorLightGrey21),
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
        ));
  }

  _formDetailAlamat(keynya, {controllerTextEditing}) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
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
          hintText: "LelangMuatBuatLelangBuatLelangLabelTitleCthDetailAlamat"
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
        ));
  }

  _formDetailAlamatDestinasi(keynya, {controllerTextEditing}) {
    return CustomTextField(
        key: keynya,
        context: Get.context,
        controller: controllerTextEditing,
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
          hintText: "LelangMuatBuatLelangBuatLelangLabelTitleCthDetailAlamat"
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
        ));
  }

  _formAlamat(keynya, {int idx, controllerTextEditing, satuan}) {
    var isRed = false;
    if (satuan) {
      isRed = controller.isKosongAlamatSatuan.value;
    } else {
      isRed = controller.isKosongAlamatMulti[idx];
    }
    if (idx == null) {
      if (controller.alamatSatuan.value.text != "") {
        controller.isKosongAlamatSatuan.value = false;
      }
    } else {
      if (controller.alamatMulti[idx].text != "") {
        controller.isKosongAlamatMulti[idx] = false;
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              CustomTextField(
                key: keynya,
                context: Get.context,
                readOnly: true,
                controller: controllerTextEditing,
                onTap: () async {
                  if (idx == null) {
                    controller.cariLokasi("assets/pin7.svg", null);
                  } else {
                    if (idx == 0) {
                      controller.cariLokasi("assets/pin1.svg", 0);
                    }
                    if (idx == 1) {
                      controller.cariLokasi("assets/pin2_biru.svg", 1);
                    }
                    if (idx == 2) {
                      controller.cariLokasi("assets/pin3_biru.svg", 2);
                    }
                    if (idx == 3) {
                      controller.cariLokasi("assets/pin4_biru.svg", 3);
                    }
                    if (idx == 4) {
                      controller.cariLokasi("assets/pin5_biru.svg", 4);
                    }
                  }
                },
                onChanged: (value) {
                  // controller.addTextSearchCity(value);
                },
                // controller: controller.searchTextEditingController.value,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  // controller.onSubmitSearch();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4)),
                newContentPadding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioFontSize(Get.context) * 40,
                    GlobalVariable.ratioWidth(Get.context) * 10,
                    GlobalVariable.ratioWidth(Get.context) * 12,
                    GlobalVariable.ratioWidth(Get.context) * 10),
                // newContentPadding: EdgeInsets.symmetric(
                //     horizontal: GlobalVariable.ratioWidth(Get.context) * 42,
                //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText:
                      "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderChooseLocation"
                          .tr, // "Cari Area Pick Up",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey2),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isRed
                            ? Color(ListColor.colorRed)
                            : Color(ListColor.colorLightGrey19),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isRed
                            ? Color(ListColor.colorRed)
                            : Color(ListColor.colorLightGrey19),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isRed
                            ? Color(ListColor.colorRed)
                            : Color(ListColor.colorLightGrey19),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              if (controller.radioButtonSatuMultipleLokasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr)
                Container(
                  margin: EdgeInsets.all(
                      GlobalVariable.ratioWidth(Get.context) * 8),
                  child: SvgPicture.asset(
                    "assets/pin7.svg",
                    width: GlobalVariable.ratioFontSize(Get.context) * 28,
                    height: GlobalVariable.ratioFontSize(Get.context) * 28,
                  ),
                ),
              if (controller.radioButtonSatuMultipleLokasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 0)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin1.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
              if (controller.radioButtonSatuMultipleLokasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 1)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin2_biru.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
              if (controller.radioButtonSatuMultipleLokasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 2)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin3_biru.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
              if (controller.radioButtonSatuMultipleLokasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 3)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin4_biru.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
              if (controller.radioButtonSatuMultipleLokasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 4)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin5_biru.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  _formAlamatDestinasi(keynya, {int idx, controllerTextEditing, satuan}) {
    var isRed = false;
    if (satuan) {
      isRed = controller.isKosongAlamatSatuanDestinasi.value;
    } else {
      isRed = controller.isKosongAlamatMultiDestinasi[idx];
    }
    if (idx == null) {
      if (controller.alamatSatuanDestinasi.value.text != "") {
        controller.isKosongAlamatSatuanDestinasi.value = false;
      }
    } else {
      if (controller.alamatMultiDestinasi[idx].text != "") {
        controller.isKosongAlamatMultiDestinasi[idx] = false;
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              CustomTextField(
                key: keynya,
                context: Get.context,
                readOnly: true,
                controller: controllerTextEditing,
                onTap: () {
                  if (idx == null) {
                    controller.cariLokasiDestinasi("assets/pin7.svg", null);
                  } else {
                    if (idx == 0) {
                      controller.cariLokasiDestinasi("assets/pin1.svg", 0);
                    }
                    if (idx == 1) {
                      controller.cariLokasiDestinasi("assets/pin2_biru.svg", 1);
                    }
                    if (idx == 2) {
                      controller.cariLokasiDestinasi("assets/pin3_biru.svg", 2);
                    }
                    if (idx == 3) {
                      controller.cariLokasiDestinasi("assets/pin4_biru.svg", 3);
                    }
                    if (idx == 4) {
                      controller.cariLokasiDestinasi("assets/pin5_biru.svg", 4);
                    }
                  }
                },
                onChanged: (value) {
                  // controller.addTextSearchCity(value);
                },
                // controller: controller.searchTextEditingController.value,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  // controller.onSubmitSearch();
                },
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4)),
                newContentPadding: EdgeInsets.fromLTRB(
                    GlobalVariable.ratioFontSize(Get.context) * 40,
                    GlobalVariable.ratioWidth(Get.context) * 10,
                    GlobalVariable.ratioWidth(Get.context) * 12,
                    GlobalVariable.ratioWidth(Get.context) * 10),
                // newContentPadding: EdgeInsets.symmetric(
                //     horizontal: GlobalVariable.ratioWidth(Get.context) * 42,
                //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintText:
                      "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderChooseLocation"
                          .tr, // "Cari Area Pick Up",
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                      color: Color(ListColor.colorLightGrey2),
                      fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isRed
                            ? Color(ListColor.colorRed)
                            : Color(ListColor.colorLightGrey19),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isRed
                            ? Color(ListColor.colorRed)
                            : Color(ListColor.colorLightGrey19),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isRed
                            ? Color(ListColor.colorRed)
                            : Color(ListColor.colorLightGrey19),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr)
                Container(
                  // decoration: BoxDecoration(boxShadow: [
                  //   BoxShadow(
                  //       color:
                  //           Color(ListColor.colorLightGrey19).withOpacity(0.5),
                  //       // offset: Offset(0.0, 2.0),
                  //       blurRadius: 5.0,
                  //       spreadRadius: 2.0)
                  // ]),
                  margin: EdgeInsets.all(
                      GlobalVariable.ratioWidth(Get.context) * 8),
                  child: SvgPicture.asset(
                    "assets/pin7.svg",
                    width: GlobalVariable.ratioFontSize(Get.context) * 28,
                    height: GlobalVariable.ratioFontSize(Get.context) * 28,
                  ),
                ),
              if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 0)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin1.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
              if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 1)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin2_biru.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
              if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 2)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin3_biru.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
              if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 3)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin4_biru.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
              if (controller.radioButtonSatuMultipleLokasiDestinasi.value ==
                  "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr)
                if (idx == 4)
                  Container(
                    margin: EdgeInsets.all(
                        GlobalVariable.ratioWidth(Get.context) * 8),
                    child: SvgPicture.asset(
                      "assets/pin5_biru.svg",
                      width: GlobalVariable.ratioFontSize(Get.context) * 28,
                      height: GlobalVariable.ratioFontSize(Get.context) * 28,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  _formTipe() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: RadioButtonCustomWithText(
                isDense: true,
                isWithShadow: true,
                colorRoundedBG: Colors.white,
                radioSize: GlobalVariable.ratioFontSize(Get.context) * 20,
                groupValue: controller.radioButtonSatuMultipleLokasi.value,
                value: "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr,
                customTextWidget: labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr,
                    Colors.black,
                    14,
                    FontWeight.w600),
                onChanged: (val) {
                  controller.getCurrentLocation();
                  controller.listCurentLocation = [];
                  controller.listCurentLocation
                      .add(controller.currentLocation.value);
                  controller.currentLocationList = [];
                  controller.currentLocationList
                      .add(controller.currentLocation.value);
                  controller.radioButtonSatuMultipleLokasi.value = val;
                  controller.alamatSatuan.value.text = "";
                  for (var i = 0; i < controller.alamatMulti.length; i++) {
                    controller.alamatMulti[i].text = "";
                  }

                  controller.detailalamatSatuan.value.text = "";
                  for (var i = 0;
                      i < controller.detailalamatMulti.length;
                      i++) {
                    controller.detailalamatMulti[i].text = "";
                  }

                  controller.provinsiSatuan.value.text = "";
                  for (var i = 0; i < controller.provinsiMulti.length; i++) {
                    controller.provinsiMulti[i].text = "";
                  }

                  controller.namaPicSatuan.value.text = "";
                  for (var i = 0; i < controller.namaPicMulti.length; i++) {
                    controller.namaPicMulti[i].text = "";
                  }

                  controller.noTelpPicSatuam.value.text = "";
                  for (var i = 0; i < controller.noTelpPicMulti.length; i++) {
                    controller.noTelpPicMulti[i].text = "";
                  }
                },
              ),
            ),
            Expanded(
              child: RadioButtonCustomWithText(
                isDense: true,
                isWithShadow: true,
                colorRoundedBG: Colors.white,
                radioSize: GlobalVariable.ratioFontSize(Get.context) * 20,
                groupValue: controller.radioButtonSatuMultipleLokasi.value,
                value:
                    "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr,
                customTextWidget: labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr,
                    Colors.black,
                    14,
                    FontWeight.w600),
                onChanged: (val) {
                  controller.getCurrentLocation();
                  controller.dropdownJumlahLokasi.value = 2;
                  controller.listCurentLocation = [];
                  controller.listCurentLocation
                      .add(controller.currentLocation.value);
                  controller.listCurentLocation
                      .add(controller.currentLocation.value);
                  controller.currentLocationList = [];
                  controller.currentLocationList
                      .add(controller.currentLocation.value);
                  controller.currentLocationList
                      .add(controller.currentLocation.value);
                  controller.radioButtonSatuMultipleLokasi.value = val;
                  controller.alamatSatuan.value.text = "";
                  for (var i = 0; i < controller.alamatMulti.length; i++) {
                    controller.alamatMulti[i].text = "";
                  }

                  controller.detailalamatSatuan.value.text = "";
                  for (var i = 0;
                      i < controller.detailalamatMulti.length;
                      i++) {
                    controller.detailalamatMulti[i].text = "";
                  }

                  controller.provinsiSatuan.value.text = "";
                  for (var i = 0; i < controller.provinsiMulti.length; i++) {
                    controller.provinsiMulti[i].text = "";
                  }

                  controller.namaPicSatuan.value.text = "";
                  for (var i = 0; i < controller.namaPicMulti.length; i++) {
                    controller.namaPicMulti[i].text = "";
                  }

                  controller.noTelpPicSatuam.value.text = "";
                  for (var i = 0; i < controller.noTelpPicMulti.length; i++) {
                    controller.noTelpPicMulti[i].text = "";
                  }
                },
              ),
            )
          ],
        ));
  }

  _formTipeDestinasi() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: RadioButtonCustomWithText(
                isDense: true,
                isWithShadow: true,
                colorRoundedBG: Colors.white,
                radioSize: GlobalVariable.ratioFontSize(Get.context) * 20,
                groupValue:
                    controller.radioButtonSatuMultipleLokasiDestinasi.value,
                value: "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr,
                customTextWidget: labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleOneLocation".tr,
                    Colors.black,
                    14,
                    FontWeight.w600),
                onChanged: (val) {
                  controller.getCurrentLocation();
                  controller.listCurentLocationDestinasi = [];
                  controller.listCurentLocationDestinasi
                      .add(controller.currentLocationDestinasi.value);
                  controller.currentLocationDestinasiList = [];
                  controller.currentLocationDestinasiList
                      .add(controller.currentLocationDestinasi.value);
                  controller.radioButtonSatuMultipleLokasiDestinasi.value = val;
                  controller.alamatSatuanDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.alamatMultiDestinasi.length;
                      i++) {
                    controller.alamatMultiDestinasi[i].text = "";
                  }

                  controller.detailalamatSatuanDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.detailalamatMultiDestinasi.length;
                      i++) {
                    controller.detailalamatMultiDestinasi[i].text = "";
                  }

                  controller.provinsiSatuanDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.provinsiMultiDestinasi.length;
                      i++) {
                    controller.provinsiMultiDestinasi[i].text = "";
                  }

                  controller.namaPicSatuanDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.namaPicMultiDestinasi.length;
                      i++) {
                    controller.namaPicMultiDestinasi[i].text = "";
                  }

                  controller.noTelpPicSatuamDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.noTelpPicMultiDestinasi.length;
                      i++) {
                    controller.noTelpPicMultiDestinasi[i].text = "";
                  }
                },
              ),
            ),
            Expanded(
              child: RadioButtonCustomWithText(
                isDense: true,
                isWithShadow: true,
                colorRoundedBG: Colors.white,
                radioSize: GlobalVariable.ratioFontSize(Get.context) * 20,
                groupValue:
                    controller.radioButtonSatuMultipleLokasiDestinasi.value,
                value:
                    "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr,
                customTextWidget: labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleMultiLocation".tr,
                    Colors.black,
                    14,
                    FontWeight.w600),
                onChanged: (val) {
                  controller.getCurrentLocation();
                  controller.dropdownJumlahLokasiDestinasi.value = 2;

                  controller.listCurentLocationDestinasi = [];
                  controller.listCurentLocationDestinasi
                      .add(controller.currentLocationDestinasi.value);
                  controller.listCurentLocationDestinasi
                      .add(controller.currentLocationDestinasi.value);
                  controller.currentLocationDestinasiList = [];
                  controller.currentLocationDestinasiList
                      .add(controller.currentLocationDestinasi.value);
                  controller.currentLocationDestinasiList
                      .add(controller.currentLocationDestinasi.value);
                  controller.radioButtonSatuMultipleLokasiDestinasi.value = val;
                  controller.alamatSatuanDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.alamatMultiDestinasi.length;
                      i++) {
                    controller.alamatMultiDestinasi[i].text = "";
                  }

                  controller.detailalamatSatuanDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.detailalamatMultiDestinasi.length;
                      i++) {
                    controller.detailalamatMultiDestinasi[i].text = "";
                  }

                  controller.provinsiSatuanDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.provinsiMultiDestinasi.length;
                      i++) {
                    controller.provinsiMultiDestinasi[i].text = "";
                  }

                  controller.namaPicSatuanDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.namaPicMultiDestinasi.length;
                      i++) {
                    controller.namaPicMultiDestinasi[i].text = "";
                  }

                  controller.noTelpPicSatuamDestinasi.value.text = "";
                  for (var i = 0;
                      i < controller.noTelpPicMultiDestinasi.length;
                      i++) {
                    controller.noTelpPicMultiDestinasi[i].text = "";
                  }
                },
              ),
            )
          ],
        ));
  }

  _formJumlahKoli() {
    return CustomTextField(
        key: ValueKey("jumlahKoli"),
        context: Get.context,
        keyboardType: TextInputType.number,
        controller: controller.jumlahKoli.value,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          ark_global.DecimalInputFormatter(
            digit: 5,
            digitAfterComma: 0,
            controller: controller.jumlahKoli.value,
          ),
        ],
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            vertical: GlobalVariable.ratioWidth(Get.context) * 10),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderQty"
              .tr, // "Cari Area Pick Up",
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
        ));
  }

  _formDimensiKoli() {
    return Container(
      // color: Colors.blue,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(Get.context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(ListColor.colorLightGrey19)),
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                        key: ValueKey("panjang"),
                        context: Get.context,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
                          ark_global.DecimalInputFormatter(
                            digit: 5,
                            digitAfterComma: 3,
                            controller: controller.panjang.value,
                          ),
                        ],
                        newContentPadding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 6,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 10),
                        controller: controller.panjang.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorLightGrey4)),
                        textSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        newInputDecoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey2)),
                          hintText:
                              "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderLength"
                                  .tr,
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorWhite), width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorWhite), width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorWhite), width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )),
                  ),
                  Container(
                    // width: GlobalVariable.ratioWidth(Get.context) * 20,
                    // height: GlobalVariable.ratioWidth(Get.context) * 32,
                    color: Colors.white,
                    child: Center(
                      child: CustomText(
                        "x",
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Color(ListColor.colorLightGrey4),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                        key: ValueKey("lebar"),
                        context: Get.context,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
                          ark_global.DecimalInputFormatter(
                            digit: 5,
                            digitAfterComma: 3,
                            controller: controller.lebar.value,
                          ),
                        ],
                        newContentPadding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 6,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 10),
                        controller: controller.lebar.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorLightGrey4)),
                        textSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        newInputDecoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey2)),
                          hintText:
                              "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderWidth"
                                  .tr,
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorWhite), width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorWhite), width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorWhite), width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )),
                  ),
                  Container(
                    // width: GlobalVariable.ratioWidth(Get.context) * 36,
                    // height: GlobalVariable.ratioWidth(Get.context) * 32,
                    color: Colors.white,
                    child: Center(
                      child: CustomText(
                        "x",
                        fontWeight: FontWeight.w600,
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        color: Color(ListColor.colorLightGrey4),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                        key: ValueKey("tinggi"),
                        context: Get.context,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9\,]")),
                          ark_global.DecimalInputFormatter(
                            digit: 5,
                            digitAfterComma: 3,
                            controller: controller.tinggi.value,
                          ),
                        ],
                        newContentPadding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 6,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 10),
                        controller: controller.tinggi.value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(ListColor.colorLightGrey4)),
                        textSize:
                            GlobalVariable.ratioFontSize(Get.context) * 14,
                        newInputDecoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(ListColor.colorLightGrey2)),
                          hintText:
                              "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderHeight"
                                  .tr,
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorWhite), width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorWhite), width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(ListColor.colorWhite), width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
          Container(
              child: DropdownBelow(
            key: ValueKey("selectedDimensiKoli"),
            items: [
              DropdownMenuItem(
                child: CustomText("m",
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    color: Color(ListColor.colorLightGrey4)),
                value: "m",
              ),
              DropdownMenuItem(
                child: CustomText("cm",
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    color: Color(ListColor.colorLightGrey4)),
                value: "cm",
              )
            ],
            onChanged: (value) {
              controller.selectedDimensiKoli.value = value;
            },
            itemWidth: 100,
            itemTextstyle: TextStyle(
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w400,
                color: Color(ListColor.colorLightGrey4)),
            boxTextstyle: TextStyle(
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                fontWeight: FontWeight.w400,
                color: Color(ListColor.colorLightGrey4)),
            boxPadding: EdgeInsets.only(
                left: GlobalVariable.ratioWidth(Get.context) * 12,
                right: GlobalVariable.ratioWidth(Get.context) * 12),
            // boxPadding: EdgeInsets.symmetric(
            //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
            boxWidth: 100,
            // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 48,
            boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
                GlobalVariable.ratioWidth(Get.context) * 14.5 +
                GlobalVariable.ratioWidth(Get.context) * 14.5,
            boxDecoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 1, color: Color(ListColor.colorLightGrey19)),
                borderRadius: BorderRadius.circular(6)),
            icon: Icon(Icons.keyboard_arrow_down_outlined,
                size: GlobalVariable.ratioFontSize(Get.context) * 24,
                color: Color(ListColor.colorLightGrey19)),
            hint: CustomText(controller.selectedDimensiKoli.value,
                fontWeight: FontWeight.w600,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                color: Color(ListColor.colorLightGrey4)),
            value: controller.selectedDimensiKoli.value,
          )),
        ],
      ),
    );
  }

  _formVolume() {
    return Container(
      // color: Colors.blue,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CustomTextField(
                key: ValueKey("volume"),
                context: Get.context,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ark_global.DecimalInputFormatter(
                    digit: 5,
                    digitAfterComma: 0,
                    controller: controller.volume.value,
                  ),
                ],
                newContentPadding: EdgeInsets.symmetric(
                    horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                    vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                controller: controller.volume.value,
                textInputAction: TextInputAction.search,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(ListColor.colorLightGrey4)),
                textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                newInputDecoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey2)),
                  hintText:
                      "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderQty"
                          .tr,
                  fillColor: Colors.white,
                  filled: true,
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
          ),
          SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
          Container(
              child: DropdownBelow(
                  key: ValueKey("selectedVolume"),
                  items: [
                    DropdownMenuItem(
                      child: Html(
                          style: {
                            "body": Style(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero)
                          },
                          data:
                              '<div style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 14}; color: #676767;">m<sup>3<sup></div>'),

                      // CustomText("m3",
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      //     color: Color(ListColor.colorLightGrey4),
                      //     ),
                      value: "m3",
                    ),
                    DropdownMenuItem(
                      child: CustomText("Liter",
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          color: Color(ListColor.colorLightGrey4)),
                      value: "Lt",
                    )
                  ],
                  onChanged: (value) {
                    controller.selectedVolume.value = value;
                  },
                  itemWidth: 100,
                  itemTextstyle: TextStyle(
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      fontWeight: FontWeight.w400,
                      color: Color(ListColor.colorLightGrey4)),
                  boxTextstyle: TextStyle(
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                      fontWeight: FontWeight.w400,
                      color: Color(ListColor.colorLightGrey4)),
                  boxPadding: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(Get.context) * 12,
                      right: GlobalVariable.ratioWidth(Get.context) * 12),
                  // boxPadding: EdgeInsets.symmetric(
                  //     horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                  //     vertical: GlobalVariable.ratioWidth(Get.context) * 10),
                  boxWidth: 100,
                  // boxHeight: GlobalVariable.ratioFontSize(Get.context) * 46,
                  boxHeight: GlobalVariable.ratioFontSize(Get.context) * 14 +
                      GlobalVariable.ratioWidth(Get.context) * 13.5 +
                      GlobalVariable.ratioWidth(Get.context) * 13.5,
                  boxDecoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1, color: Color(ListColor.colorLightGrey19)),
                      borderRadius: BorderRadius.circular(6)),
                  icon: Icon(Icons.keyboard_arrow_down_outlined,
                      size: GlobalVariable.ratioFontSize(Get.context) * 24,
                      color: Color(ListColor.colorLightGrey19)),
                  hint: controller.selectedVolume.value == "m3"
                      ? Html(
                          style: {
                              "body": Style(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.zero)
                            },
                          data:
                              '<div style="font-weight: 600; font-size: ${GlobalVariable.ratioFontSize(Get.context) * 14}; color: #676767;">m<sup>3<sup></div>')
                      : CustomText(controller.selectedVolume.value,
                          fontWeight: FontWeight.w600,
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14,
                          color: Color(ListColor.colorLightGrey4)),
                  value: controller.selectedVolume.value))
        ],
      ),
    );
  }

  _formBerat() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        CustomTextField(
            key: ValueKey("berat"),
            context: Get.context,
            onTap: () {},
            controller: controller.berat.value,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              ark_global.DecimalInputFormatter(
                digit: 5,
                digitAfterComma: 0,
                controller: controller.berat.value,
              ),
            ],
            keyboardType: TextInputType.number,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorLightGrey4),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
            newContentPadding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10),
            textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            newInputDecoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              hintText: "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderQty"
                  .tr, // "Cari Area Pick Up",
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
        Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                // controller.onClearSearch();
              },
              child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: CustomText(
                    "Ton",
                    fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                    fontWeight: FontWeight.w600,
                  )),
            )),
      ],
    );
  }

  _formJenisMuatan() {
    return DropdownBelow(
      key: ValueKey("selectedjenismuatan"),
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
          left: GlobalVariable.ratioWidth(Get.context) * 12,
          right: GlobalVariable.ratioWidth(Get.context) * 12),
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
              color: controller.isKosongJenisMuatan.value
                  ? Color(ListColor.colorRed)
                  : Color(ListColor.colorGrey2))),
      icon: Icon(Icons.keyboard_arrow_down_sharp,
          size: GlobalVariable.ratioFontSize(Get.context) * 20,
          color: Color(ListColor.colorGrey4)),
      hint: controller.selectedjenismuatan.value == ""
          ? CustomText(
              "LelangMuatBuatLelangBuatLelangLabelTitlePlaceholderCargoType".tr,
              fontWeight: FontWeight.w600,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              color: Color(ListColor.colorLightGrey4))
          : CustomText(controller.selectedjenismuatan.value.toString(),
              fontWeight: FontWeight.w600,
              fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
              color: Color(ListColor.colorLightGrey4)),
      value: controller.selectedjenismuatan.value == ""
          ? null
          : controller.selectedjenismuatan.value,
      items: [
        for (var i = 0; i < controller.listjenismuatan.value.length; i++)
          DropdownMenuItem(
            value: controller.listjenismuatan.value[i].toString(),
            child: CustomText(controller.listjenismuatan.value[i].toString(),
                fontWeight: FontWeight.w600,
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                color: Color(ListColor.colorLightGrey4)),
          )
      ],

      // controller.dropdownJenisMuatan,
      onChanged: (value) {
        controller.selectedjenismuatan.value = value;
        controller.isKosongJenisMuatan.value = false;
      },
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
                        controller.datestartPicker();
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
                            color: Color(ListColor.colorLightGrey2),
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
                          controller.datestartPicker();
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
                        if (controller.isSelectStartDate.value) {
                          controller.dateendPicker();
                        }
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
                            color: Color(ListColor.colorLightGrey2),
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
                          if (controller.isSelectStartDate.value) {
                            controller.dateendPicker();
                          }
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

  _formMuatan() {
    return CustomTextField(
        key: ValueKey("muatan"),
        context: Get.context,
        controller: controller.muatan.value,
        onChanged: (value) {
          if (value.length > 0) {
            controller.isKosong.value = false;
          }
        },
        inputFormatters: [LengthLimitingTextInputFormatter(255)],
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(ListColor.colorLightGrey4),
            fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
        newContentPadding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
            vertical: GlobalVariable.ratioWidth(Get.context) * 10),
        textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
        newInputDecoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          hintText: "LelangMuatBuatLelangBuatLelangLabelTitleMasukanNamaMuatan"
              .tr, // "Cari Area Pick Up",
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
              color: Color(ListColor.colorLightGrey2),
              fontWeight: FontWeight.w600),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: controller.isKosong.value
                    ? Color(ListColor.colorRed)
                    : Color(ListColor.colorLightGrey19),
                width: 1.0),
            borderRadius: BorderRadius.circular(6),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: controller.isKosong.value
                    ? Color(ListColor.colorRed)
                    : Color(ListColor.colorLightGrey19),
                width: 1.0),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: controller.isKosong.value
                    ? Color(ListColor.colorRed)
                    : Color(ListColor.colorLightGrey19),
                width: 1.0),
            borderRadius: BorderRadius.circular(6),
          ),
        ));
  }

  _formJenisTruk() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        CustomTextField(
            key: ValueKey("jenisTruk"),
            context: Get.context,
            readOnly: true,
            controller: controller.jenisTruk.value,
            onTap: () {
              // _datetimeRangePicker();
              controller.cariTruck();
            },
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorLightGrey4),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
            newContentPadding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10),
            textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            newInputDecoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              hintText: "LelangMuatBuatLelangBuatLelangLabelTitleTruckType"
                  .tr, // "Cari Area Pick Up",
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
    );
  }

  _formJenisCarier() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        CustomTextField(
            key: ValueKey("jenisCarrier"),
            context: Get.context,
            readOnly: true,
            controller: controller.jenisCarrier.value,
            onTap: () {
              if (controller.headId.value != "") {
                controller.cariCarrier();
              }

              // _datetimeRangePicker();
            },
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(ListColor.colorLightGrey4),
                fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
            newContentPadding: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(Get.context) * 12,
                vertical: GlobalVariable.ratioWidth(Get.context) * 10),
            textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
            newInputDecoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              hintText: "LelangMuatBuatLelangBuatLelangLabelTitleCarrierType"
                  .tr, // "Cari Area Pick Up",
              fillColor: controller.headId.value != ""
                  ? Colors.white
                  : Color(ListColor.colorLightGrey2),
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
    );
  }

  _formImgTrukCarrier() {
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 167,
      width: MediaQuery.of(Get.context).size.width,
      decoration: BoxDecoration(
          color: Color(ListColor.colorLightGrey20),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
              width: controller.lingImg.value.toString() == "" ? 0 : 1,
              color: Color(ListColor.colorLightGrey2))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: controller.lingImg.value.toString() == ""
            ? Image(
                image: AssetImage("assets/insert_pict.png"),
                // width: GlobalVariable.ratioWidth(Get.context) * 18,
                // height: GlobalVariable.ratioWidth(Get.context) * 18,
                fit: BoxFit.cover)
            : Image.network(
                controller.lingImg.value.toString(),
                fit: BoxFit.fitHeight,
              ),
      ),
    );
  }

  _formJumlahTruk() {
    return Container(
      child: Row(
        children: [
          Container(
            width: GlobalVariable.ratioWidth(Get.context) * 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                    color: Color(ListColor.colorLightGrey19), width: 1.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: GlobalVariable.ratioFontSize(Get.context) * 24,
                  height: GlobalVariable.ratioFontSize(Get.context) * 24,
                  child: MaterialButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          side: BorderSide(color: Color(ListColor.color4))),
                      onPressed: () {
                        if (controller.jumlahTrukCount.value - 1 >= 0) {
                          controller.jumlahTrukCount.value--;
                          controller.jumlahTruk.value.text = controller
                              .formatThousand(controller.jumlahTrukCount.value);
                          controller.jumlahTruk.value.selection =
                              TextSelection.collapsed(
                                  offset:
                                      controller.jumlahTruk.value.text.length);
                        }
                        if (controller.jumlahTruk.value.text == '') {
                          controller.jumlahTruk.value.text = '0';
                        }
                      },
                      child: Icon(
                        Icons.horizontal_rule,
                        color: Color(ListColor.color4),
                        size: GlobalVariable.ratioFontSize(Get.context) * 14,
                      )
                      // CustomText("-",
                      //     textAlign: TextAlign.center, color: Color(ListColor.color4)),
                      ),
                ),
                Expanded(
                    child: CustomTextField(
                  key: ValueKey("jumlahTruk"),
                  context: Get.context,
                  textAlign: TextAlign.center,
                  controller: controller.jumlahTruk.value,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ark_global.DecimalInputFormatter(
                      digit: 5,
                      digitAfterComma: 0,
                      controller: controller.jumlahTruk.value,
                    ),
                  ],
                  onChanged: (_) {
                    var val = "";
                    if (controller.jumlahTruk.value.text == '') {
                      val = "0";
                    } else {
                      val = controller.jumlahTruk.value.text;
                    }
                    controller.jumlahTrukCount.value =
                        int.parse(val.replaceAll('.', ''));
                  },
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(ListColor.colorLightGrey4),
                      fontSize: GlobalVariable.ratioFontSize(Get.context) * 14),
                  newContentPadding: EdgeInsets.symmetric(
                      vertical: GlobalVariable.ratioWidth(Get.context) * 0.2),
                  textSize: GlobalVariable.ratioFontSize(Get.context) * 14,
                  newInputDecoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true, // "Cari Area Pick Up",
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(
                        color: Color(ListColor.colorLightGrey2),
                        fontWeight: FontWeight.w600),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      // borderRadius: BorderRadius.circular(6),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      // borderRadius: BorderRadius.circular(6),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      // borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                )),
                Container(
                  width: GlobalVariable.ratioFontSize(Get.context) * 24,
                  height: GlobalVariable.ratioFontSize(Get.context) * 24,
                  child: MaterialButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          side: BorderSide(color: Color(ListColor.color4))),
                      onPressed: () {
                        if (controller.jumlahTrukCount.value + 1 <= 99999) {
                          controller.jumlahTrukCount.value++;
                          controller.jumlahTruk.value.text = controller
                              .formatThousand(controller.jumlahTrukCount.value);
                          controller.jumlahTruk.value.selection =
                              TextSelection.collapsed(
                                  offset:
                                      controller.jumlahTruk.value.text.length);
                        }
                      },
                      child: Icon(
                        Icons.add,
                        color: Color(ListColor.color4),
                        size: GlobalVariable.ratioFontSize(Get.context) * 14,
                      )
                      // CustomText("-",
                      //     textAlign: TextAlign.center, color: Color(ListColor.color4)),
                      ),
                ),
              ],
            ),
          ),
          SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
          labelForm("Unit", Colors.black, 14, FontWeight.w600)
        ],
      ),
    );
  }

  // _datestartPicker() async {
  //   var picked = await showDatePicker(
  //       context: Get.context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2010),
  //       lastDate: DateTime(2200));

  //   if (picked != null) {
  //     String isMonth = "";
  //     if (picked.month.toString().length > 1) {
  //       isMonth = "${picked.month}";
  //     } else {
  //       isMonth = "0${picked.month}";
  //     }

  //     String isDay = "";
  //     if (picked.day.toString().length > 1) {
  //       isDay = "${picked.day}";
  //     } else {
  //       isDay = "0${picked.day}";
  //     }

  //     controller.dateAwal.value = "${picked.year}-$isMonth-$isDay";
  //     controller.periodeAwalController.value.text =
  //         "$isDay/$isMonth/${picked.year}";
  //   }
  // }

  // _datestartendPicker() async {
  //   DateTimeRange picked = await showDateRangePicker(
  //       context: Get.context,
  //       firstDate: DateTime(DateTime.now().year - 5),
  //       lastDate: DateTime(DateTime.now().year + 5),
  //       // initialDateRange: DateTimeRange(
  //       //     start: DateTime.now(),
  //       //     end: DateTime(DateTime.now().year, DateTime.now().month,
  //       //         DateTime.now().day + 1)),
  //       builder: (context, child) {
  //         return Padding(
  //           padding: EdgeInsets.fromLTRB(
  //               GlobalVariable.ratioWidth(context) * 30,
  //               GlobalVariable.ratioWidth(context) * 100,
  //               GlobalVariable.ratioWidth(context) * 30,
  //               GlobalVariable.ratioWidth(context) * 100),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Expanded(
  //                 child: ConstrainedBox(
  //                   constraints: BoxConstraints(
  //                       maxHeight: MediaQuery.of(context).size.height),
  //                   child: child,
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });

  //   if (picked != null) {
  //     controller.firstExpWaktu.value = picked.end;
  //     String isMonth = "";
  //     if (picked.start.month.toString().length > 1) {
  //       isMonth = "${picked.start.month}";
  //     } else {
  //       isMonth = "0${picked.start.month}";
  //     }

  //     String isDay = "";
  //     if (picked.start.day.toString().length > 1) {
  //       isDay = "${picked.start.day}";
  //     } else {
  //       isDay = "0${picked.start.day}";
  //     }

  //     controller.dateAwal.value = "${picked.start.year}-$isMonth-$isDay";
  //     controller.periodeAwalController.value.text =
  //         "$isDay/$isMonth/${picked.start.year}";

  //     String isDayend = "";
  //     if (picked.end.day.toString().length > 1) {
  //       isDayend = "${picked.end.day}";
  //     } else {
  //       isDayend = "0${picked.end.day}";
  //     }

  //     String isMonthend = "";
  //     if (picked.end.month.toString().length > 1) {
  //       isMonthend = "${picked.end.month}";
  //     } else {
  //       isMonthend = "0${picked.end.month}";
  //     }

  //     controller.dateAkhir.value = "${picked.end.year}-$isMonthend-$isDayend";
  //     controller.periodeAkhirController.value.text =
  //         "$isDayend/$isMonthend/${picked.end.year}";
  //   }
  // }

  // _dateEndPicker() async {
  //   var picked = await showDatePicker(
  //       context: Get.context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2010),
  //       lastDate: DateTime(2200));
  //   // DateTimeRange picked = await showDateRangePicker(
  //   //     context: Get.context,
  //   //     firstDate: DateTime(DateTime.now().year - 5),
  //   //     lastDate: DateTime(DateTime.now().year + 5),
  //   //     // initialDateRange: DateTimeRange(
  //   //     //     start: DateTime.now(),
  //   //     //     end: DateTime(DateTime.now().year, DateTime.now().month,
  //   //     //         DateTime.now().day + 1)),
  //   //     builder: (context, child) {
  //   //       return Padding(
  //   //         padding: EdgeInsets.fromLTRB(
  //   //             GlobalVariable.ratioWidth(context) * 30,
  //   //             GlobalVariable.ratioWidth(context) * 100,
  //   //             GlobalVariable.ratioWidth(context) * 30,
  //   //             GlobalVariable.ratioWidth(context) * 100),
  //   //         child: Column(
  //   //           crossAxisAlignment: CrossAxisAlignment.center,
  //   //           mainAxisAlignment: MainAxisAlignment.center,
  //   //           children: [
  //   //             Expanded(
  //   //               child: ConstrainedBox(
  //   //                 constraints: BoxConstraints(
  //   //                     maxHeight: MediaQuery.of(context).size.height),
  //   //                 child: child,
  //   //               ),
  //   //             )
  //   //           ],
  //   //         ),
  //   //       );
  //   //     });

  //   if (picked != null) {
  //     String isDayend = "";
  //     if (picked.day.toString().length > 1) {
  //       isDayend = "${picked.day}";
  //     } else {
  //       isDayend = "0${picked.day}";
  //     }

  //     String isMonthend = "";
  //     if (picked.month.toString().length > 1) {
  //       isMonthend = "${picked.month}";
  //     } else {
  //       isMonthend = "0${picked.month}";
  //     }

  //     controller.dateAkhir.value = "${picked.year}-$isMonthend-$isDayend";
  //     controller.periodeAkhirController.value.text =
  //         "$isDayend/$isMonthend/${picked.year}";
  //   }
  // }

  _dateTimePickerPickup() async {
    var picked = await showDatePicker(
        context: Get.context,
        initialDate: controller.firstdatePick == null
            ? controller.firstExpWaktu.value
            : controller.firstdatePick,
        firstDate: controller.firstExpWaktu.value,
        lastDate: DateTime(2200));
    if (picked != null) {
      controller.inisialDestinasiWaktu = picked;
      controller.firstdatePick = picked;
      var timePick = await showTimePicker(
          context: Get.context, initialTime: TimeOfDay.now());

      String isMonth = "";
      if (picked.month.toString().length > 1) {
        isMonth = "${picked.month}";
      } else {
        isMonth = "0${picked.month}";
      }

      String isDay = "";
      if (picked.day.toString().length > 1) {
        isDay = "${picked.day}";
      } else {
        isDay = "0${picked.day}";
      }

      String isJam = "";
      if (timePick.hour.toString().length > 1) {
        isJam = "${timePick.hour}";
      } else {
        isJam = "0${timePick.hour}";
      }

      String isMenit = "";
      if (timePick.minute.toString().length > 1) {
        isMenit = "${timePick.minute}";
      } else {
        isMenit = "0${timePick.minute}";
      }
      controller.ekspektasiwaktupickup.value.text =
          "$isDay ${DateFormat.MMM().format(picked)} ${picked.year} $isJam:$isMenit";

      controller.ekspektasiwaktupickupValue.value =
          "${picked.year}-$isMonth-$isDay $isJam:$isMenit:00";

      controller.isKosongEkspektasiWaktuPickup.value = false;
    }
  }

  _dateTimePickerDestinasi() async {
    var picked = await showDatePicker(
        context: Get.context,
        initialDate: controller.firstdateDes == null
            ? controller.inisialDestinasiWaktu
            : controller.firstdateDes,
        firstDate: controller.inisialDestinasiWaktu,
        lastDate: DateTime(2200));
    if (picked != null) {
      controller.firstdateDes = picked;
      var timePick = await showTimePicker(
          context: Get.context, initialTime: TimeOfDay.now());

      String isMonth = "";
      if (picked.month.toString().length > 1) {
        isMonth = "${picked.month}";
      } else {
        isMonth = "0${picked.month}";
      }

      String isDay = "";
      if (picked.day.toString().length > 1) {
        isDay = "${picked.day}";
      } else {
        isDay = "0${picked.day}";
      }

      String isJam = "";
      if (timePick.hour.toString().length > 1) {
        isJam = "${timePick.hour}";
      } else {
        isJam = "0${timePick.hour}";
      }

      String isMenit = "";
      if (timePick.minute.toString().length > 1) {
        isMenit = "${timePick.minute}";
      } else {
        isMenit = "0${timePick.minute}";
      }
      controller.ekspektasiwaktupickupDestinasi.value.text =
          "$isDay ${DateFormat.MMM().format(picked)} ${picked.year} $isJam:$isMenit";

      controller.ekspektasiwaktupickupValueDestinasi.value =
          "${picked.year}-$isMonth-$isDay $isJam:$isMenit:00";

      controller.isKosongEkspektasiWaktuDestinasi.value = false;
    }
  }

  Widget get messageInfoTooltip {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 15, 0, 55),
        width: GlobalVariable.ratioWidth(Get.context) * 148,
        height: GlobalVariable.ratioWidth(Get.context) * 67,
        child: Stack(children: [
          Container(
            width: GlobalVariable.ratioWidth(Get.context) * 148,
            height: GlobalVariable.ratioWidth(Get.context) * 59,
            decoration: BoxDecoration(
              color: Color(ListColor.colorDarkGrey4),
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                    color: Color(ListColor.colorLightGrey18), blurRadius: 18)
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: Container(
                  width: GlobalVariable.ratioWidth(Get.context) * 24,
                  height: GlobalVariable.ratioWidth(Get.context) * 24,
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
          Container(
              width: GlobalVariable.ratioWidth(Get.context) * 148,
              height: GlobalVariable.ratioWidth(Get.context) * 59,
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(ListColor.colorDarkGrey4),
                borderRadius: BorderRadius.circular(9),
              ),
              child: CustomText(
                  "LelangMuatBuatLelangBuatLelangLabelTitlePressGetStarted".tr,
                  fontSize: GlobalVariable.ratioFontSize(Get.context) * 10,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                  color: Color(ListColor.color2),
                  textAlign: TextAlign.center)),
        ]),
      ),
    ]);
  }

  Widget get messageInfo {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                GlobalVariable.ratioFontSize(Get.context) * 46.5,
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
                          color: Color(ListColor.colorLightGrey18),
                          blurRadius: 18)
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
                            onTap: () {
                              controller.isShowInfoAction();
                            },
                            child: SvgPicture.asset(
                              "assets/ic_close_zo.svg",
                              height:
                                  GlobalVariable.ratioFontSize(Get.context) *
                                      10,
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

class ThousanSeparatorFormater extends TextInputFormatter {
  static const separator = ".";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: "");
    }

    String oldValueText = oldValue.text.replaceAll(separator, "");
    String newValueText = newValue.text.replaceAll(separator, "");

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = "";
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
          text: newString.toString(),
          selection: TextSelection.collapsed(
              offset: newString.length - selectionIndex));
    }

    return newValue;
  }
}
