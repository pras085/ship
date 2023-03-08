import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/custom_toast_zo.dart';
import 'package:muatmuat/app/modules/Zero%20One/Lelang%20Muat%20Shipper/ZO_detail_lelang_muatan/ZO_detail_lelang_muatan_controller.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/list_colors_zo.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';
import 'package:latlong/latlong.dart';

class ZoDetailLelangMuatanView extends GetView<ZoDetailLelangMuatanController> {
  AppBar _appBar = AppBar(
    title: CustomText('Demo'),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(result: true);
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
          //               Get.back();
          //               // FocusManager.instance.primaryFocus.unfocus();
          //               // var valid = false;
          //               // switch (controller.slideIndex.value) {
          //               //   case 0:
          //               //     {
          //               //       Get.back(result: true);
          //               //       valid = true;
          //               //       break;
          //               //     }
          //               //   case 1:
          //               //     {
          //               //       valid = true;
          //               //       break;
          //               //     }
          //               //   case 2:
          //               //     {
          //               //       valid = true;
          //               //       break;
          //               //     }
          //               //   case 3:
          //               //     {
          //               //       valid = true;
          //               //       break;
          //               //     }
          //               //   case 4:
          //               //     {
          //               //       valid = true;
          //               //       break;
          //               //     }
          //               //   case 5:
          //               //     {
          //               //       valid = true;
          //               //       break;
          //               //     }
          //               // }
          //               // if (valid) {
          //               //   FocusScope.of(Get.context).unfocus();
          //               //   if (controller.slideIndex.value != 6) {
          //               //     controller.slideIndex.value--;
          //               //     controller.pageController.animateToPage(
          //               //         controller.slideIndex.value,
          //               //         duration: Duration(milliseconds: 500),
          //               //         curve: Curves.linear);
          //               //   }
          //               // }
          //             },
          //             child: Container(
          //                 width: GlobalVariable.ratioWidth(context) * 24,
          //                 height: GlobalVariable.ratioWidth(context) * 24,
          //                 child: Center(
          //                     child: Icon(
          //                   Icons.arrow_back_ios_rounded,
          //                   size: GlobalVariable.ratioWidth(context) * 15,
          //                   color: Color(ListColor.color4),
          //                 ))))),
          //   ),
          // ),
          title: Obx(
            () => controller.slideIndex.value == 0
                ? Row(
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
                                    Get.back();
                                  },
                                  child: Container(
                                      width: GlobalVariable.ratioFontSize(
                                              context) *
                                          28,
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          28,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: GlobalVariable.ratioFontSize(
                                                context) *
                                            19,
                                        color: Color(ListColor.color4),
                                      ))))),
                        ),
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
                      Expanded(
                        child: CustomText(
                          "LelangMuatDetailLelangDetailLelangLabelTitleBidDetail"
                              .tr,
                          color: Colors.white,
                          fontSize: GlobalVariable.ratioFontSize(context) * 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.type.value == "aktif")
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                  controller.salinData(controller
                                      .listDataDetail.value["ID"]
                                      .toString());
                                },
                                child: Container(
                                  child: SvgPicture.asset(
                                    "assets/copy_icon.svg",
                                    width: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        20,
                                    height: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        20,
                                  ),
                                )),
                          if (controller.type.value == "aktif")
                            SizedBox(
                              width: GlobalVariable.ratioWidth(context) * 14,
                            ),
                          if (controller.type.value == "aktif")
                            Column(
                              children: [
                                Container(
                                  child: SvgPicture.asset(
                                    "assets/peserta_icon.svg",
                                    width: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        20,
                                    height: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        20,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        GlobalVariable.ratioWidth(context) * 2),
                                CustomText(
                                  "LelangMuatDetailLelangDetailLelangButtonParticipant"
                                      .tr,
                                  color: Colors.white,
                                  fontSize:
                                      GlobalVariable.ratioFontSize(context) * 7,
                                  fontWeight: FontWeight.w600,
                                )
                              ],
                            ),
                          if (controller.type.value == "history")
                            GestureDetector(
                                onTap: () {
                                  // Get.back();
                                },
                                child: Container(
                                  child: SvgPicture.asset(
                                    "assets/ic_share_white.svg",
                                    width: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        20,
                                    height: GlobalVariable.ratioFontSize(
                                            Get.context) *
                                        20,
                                  ),
                                )),
                        ],
                      )
                    ],
                  )
                : Row(
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
                                    Get.back();
                                  },
                                  child: Container(
                                      width: GlobalVariable.ratioFontSize(
                                              context) *
                                          28,
                                      height: GlobalVariable.ratioFontSize(
                                              context) *
                                          28,
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        size: GlobalVariable.ratioFontSize(
                                                context) *
                                            19,
                                        color: Color(ListColor.color4),
                                      ))))),
                        ),
                      ),
                      SizedBox(width: GlobalVariable.ratioWidth(context) * 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              "LelangMuatDetailLelangDetailLelangLabelTitleBidNumber"
                                  .tr,
                              color: Colors.white,
                              fontSize:
                                  GlobalVariable.ratioFontSize(context) * 12,
                              fontWeight: FontWeight.w600,
                            ),
                            if (controller.listDataDetail.length > 0)
                              CustomText(
                                controller.listDataDetail.value["BidNo"],
                                color: Colors.white,
                                fontSize:
                                    GlobalVariable.ratioFontSize(context) * 18,
                                fontWeight: FontWeight.w600,
                              )
                            else
                              SizedBox(
                                child: CircularProgressIndicator(),
                                height:
                                    GlobalVariable.ratioFontSize(context) * 20,
                                width:
                                    GlobalVariable.ratioFontSize(context) * 20,
                              ),
                          ],
                        ),
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.type.value == "aktif")
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    controller.salinData(controller
                                        .listDataDetail.value["ID"]
                                        .toString());
                                  },
                                  child: Container(
                                    child: SvgPicture.asset(
                                      "assets/copy_icon.svg",
                                      width: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          20,
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          20,
                                    ),
                                  )),
                            if (controller.type.value == "aktif")
                              SizedBox(
                                width: GlobalVariable.ratioWidth(context) * 14,
                              ),
                            if (controller.type.value == "aktif")
                              Column(
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
                                      "assets/peserta_icon.svg",
                                      width: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          20,
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          20,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          GlobalVariable.ratioWidth(context) *
                                              2),
                                  CustomText(
                                    "LelangMuatDetailLelangDetailLelangButtonParticipant"
                                        .tr,
                                    color: Colors.white,
                                    fontSize:
                                        GlobalVariable.ratioFontSize(context) *
                                            7,
                                    fontWeight: FontWeight.w600,
                                  )
                                ],
                              ),
                            if (controller.type.value == "history")
                              GestureDetector(
                                  onTap: () {
                                    // Get.back();
                                  },
                                  child: Container(
                                    child: SvgPicture.asset(
                                      "assets/ic_share_white.svg",
                                      width: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          20,
                                      height: GlobalVariable.ratioFontSize(
                                              Get.context) *
                                          20,
                                    ),
                                  )),
                          ])
                    ],
                  ),
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
                              // physics: NeverScrollableScrollPhysics(),
                              onPageChanged: (index) {
                                controller.slideIndex.value = index;
                                controller.updateTitle();
                              },
                              controller: controller.pageController,
                              children: [
                                dataLelangPage(),
                                dataKebutuhanPage(),
                                dataMuatanPage(),
                                informasiPickupPage(),
                                informasiDestinasiPage(),
                                dataPenawaranPage()
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
                                          controller.slideIndex.value++;
                                          controller.pageController
                                              .animateToPage(
                                                  controller.slideIndex.value,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.linear);
                                        } else {
                                          if (controller
                                              .isTambahCatatan.value) {
                                            if (controller.catatanTambahan.value
                                                    .text !=
                                                "") {
                                              if (!controller
                                                  .isClickSimpan.value) {
                                                controller.isClickSimpan.value =
                                                    true;
                                                controller.tambahCatatanAction(
                                                    controller.catatanTambahan
                                                        .value.text);
                                              }
                                            } else {
                                              CustomToast.show(
                                                  context: Get.context,
                                                  sizeRounded: 6,
                                                  message:
                                                      "LelangMuatBuatLelangBuatLelangLabelTitleCatatanTidakBolehKosong"
                                                          .tr);
                                            }
                                          } else {
                                            Get.back();
                                          }
                                        }
                                      }
                                    },
                                    child: Obx(() => CustomText(
                                        controller.slideIndex.value == 5
                                            ? controller.isTambahCatatan.value
                                                ? "LelangMuatBuatLelangBuatLelangLabelTitleSave"
                                                    .tr
                                                : "LelangMuatBuatLelangBuatLelangLabelTitleKembaliKeList"
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
          () => controller.listDataDetail.value.isNotEmpty
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      labelForm(
                          "LelangMuatDetailLelangDetailLelangLabelTitleBidNumber"
                              .tr,
                          Color(ListColor.colorGrey3),
                          14,
                          FontWeight.w700),
                      sizedBoxJarak(8),
                      labelForm(controller.listDataDetail.value["BidNo"],
                          Colors.black, 14, FontWeight.w600),
                      sizedBoxJarak(24),
                      labelForm(
                          "LelangMuatDetailLelangDetailLelangLabelTitleBidCreatedDate"
                              .tr,
                          Color(ListColor.colorGrey3),
                          14,
                          FontWeight.w700),
                      sizedBoxJarak(8),
                      labelForm(controller.listDataDetail.value["Created"],
                          Colors.black, 14, FontWeight.w600),
                      sizedBoxJarak(24),
                      labelForm(
                          "LelangMuatDetailLelangDetailLelangLabelTitleBidPeriod"
                              .tr,
                          Color(ListColor.colorGrey3),
                          14,
                          FontWeight.w700),
                      sizedBoxJarak(8),
                      labelForm(
                          controller.listDataDetail.value["StartDate"] +
                              " - " +
                              controller.listDataDetail.value["EndDate"],
                          Colors.black,
                          14,
                          FontWeight.w600),
                      sizedBoxJarak(24),
                      labelForm(
                          "LelangMuatDetailLelangDetailLelangLabelTitleBidType"
                              .tr,
                          Color(ListColor.colorGrey3),
                          14,
                          FontWeight.w700),
                      sizedBoxJarak(8),
                      labelForm(
                          controller.listDataDetail.value["BidType"] == "1"
                              ? "LelangMuatBuatLelangBuatLelangLabelTitleTerbuka"
                                  .tr
                              : "LelangMuatBuatLelangBuatLelangLabelTitleTertutup"
                                  .tr,
                          Colors.black,
                          14,
                          FontWeight.w600),
                    ],
                  ),
                )
              : Center(
                  child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                )),
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
                _formImgTrukCarrier(),
                sizedBoxJarak(24),
                Row(
                  children: [
                    Expanded(
                      child: labelForm(
                          "LelangMuatTabAktifTabAktifLabelTitleTruckType".tr,
                          Color(ListColor.colorGrey3),
                          14,
                          FontWeight.w600),
                    ),
                    Expanded(
                      flex: 2,
                      child: labelForm(controller.truckJenis.value,
                          Colors.black, 14, FontWeight.w600),
                    ),
                  ],
                ),
                sizedBoxJarak(24),
                Row(
                  children: [
                    Expanded(
                      child: labelForm(
                          "LelangMuatTabAktifTabAktifLabelTitleCarrierType".tr,
                          Color(ListColor.colorGrey3),
                          14,
                          FontWeight.w600),
                    ),
                    Expanded(
                      flex: 2,
                      child: labelForm(controller.carrierJenis.value,
                          Colors.black, 14, FontWeight.w600),
                    ),
                  ],
                ),
                sizedBoxJarak(24),
                Row(
                  children: [
                    Expanded(
                      child: labelForm(
                          "LelangMuatBuatLelangBuatLelangLabelTitleJumlah".tr,
                          Color(ListColor.colorGrey3),
                          14,
                          FontWeight.w600),
                    ),
                    Expanded(
                      flex: 2,
                      child: labelForm(
                          controller.listDataDetail.value["TruckQty"]
                                  .toString() +
                              " Unit",
                          Colors.black,
                          14,
                          FontWeight.w600),
                    ),
                  ],
                ),
                sizedBoxJarak(24),
                labelForm("LelangMuatBuatLelangBuatLelangLabelTitleUnit".tr,
                    Color(ListColor.colorGrey3), 14, FontWeight.w600),
                sizedBoxJarak(8),
                labelForm(controller.beratMaxDimensiVolume.value, Colors.black,
                    14, FontWeight.w600),
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
                    "LelangMuatBuatLelangBuatLelangLabelTitleNamaMuatan".tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm(controller.listDataDetail.value["Cargo"],
                    Colors.black, 14, FontWeight.w600),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleWeight".tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm(
                    controller.listDataDetail.value["Weight"] ?? "-" + " Ton",
                    Colors.black,
                    14,
                    FontWeight.w600),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleCargoDimension"
                        .tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm(
                    controller.listDataDetail.value["Dimension"] ??
                        "-".toString().replaceAll("*_*_*", " x "),
                    Colors.black,
                    14,
                    FontWeight.w600),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleCargoType".tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm(controller.listDataDetail.value["IdCargoType"],
                    Colors.black, 14, FontWeight.w600),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleVolume".tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm(controller.listDataDetail.value["Volume"] ?? "-",
                    Colors.black, 14, FontWeight.w600),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleColiQty".tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm(controller.listDataDetail.value["KoliQty"].toString(),
                    Colors.black, 14, FontWeight.w600),
                sizedBoxJarak(24),
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
        child: Obx(
          () => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitlePickupType".tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm(controller.listDataDetail.value["PickupType"],
                    Colors.black, 14, FontWeight.w600),
                if (controller.listPickup.value.length > 1) sizedBoxJarak(24),
                if (controller.listPickup.value.length > 1)
                  labelForm("LelangMuatBuatLelangBuatLelangLabelTitleJumlah".tr,
                      Color(ListColor.colorGrey3), 14, FontWeight.w700),
                if (controller.listPickup.value.length > 1) sizedBoxJarak(8),
                if (controller.listPickup.value.length > 1)
                  labelForm("${controller.listPickup.value.length}",
                      Colors.black, 14, FontWeight.w600),
                sizedBoxJarak(24),
                if (controller.listPickup.value.length > 1)
                  for (var idx = 0;
                      idx < controller.listPickup.value.length;
                      idx++)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            controller.iconLocation[idx],
                            width:
                                GlobalVariable.ratioFontSize(Get.context) * 28,
                            height:
                                GlobalVariable.ratioFontSize(Get.context) * 28,
                          ),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 11,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              labelForm(
                                  "LelangMuatBuatLelangBuatLelangLabelTitleLokasiPickup"
                                          .tr +
                                      " " +
                                      (idx + 1).toString(),
                                  Color(ListColor.colorDarkGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(20),
                              labelForm(
                                  "LelangMuatDetailLelangDetailLelangLabelTitlePickupAddress"
                                      .tr,
                                  Color(ListColor.colorGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(8),
                              labelForm(
                                  controller.listPickup.value[idx]["Address"] ==
                                          null
                                      ? "-"
                                      : controller.listPickup.value[idx]
                                          ["Address"],
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              sizedBoxJarak(20),
                              labelForm(
                                  "LelangMuatBuatLelangBuatLelangLabelTitleDetailLokasi"
                                      .tr,
                                  Color(ListColor.colorGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(8),
                              labelForm(
                                  controller.listPickup.value[idx]
                                              ["DetailAddress"] ==
                                          null
                                      ? "-"
                                      : controller.listPickup.value[idx]
                                          ["DetailAddress"],
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              sizedBoxJarak(20),
                              labelForm(
                                  "LelangMuatDetailLelangDetailLelangLabelTitlePICName"
                                      .tr,
                                  Color(ListColor.colorGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(8),
                              labelForm(
                                  controller.listPickup.value[idx]["PicName"] ==
                                          null
                                      ? "-"
                                      : controller.listPickup.value[idx]
                                          ["PicName"],
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              sizedBoxJarak(20),
                              labelForm(
                                  "LelangMuatDetailLelangDetailLelangLabelTitlePICNumber"
                                      .tr,
                                  Color(ListColor.colorGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(8),
                              labelForm(
                                  controller.listPickup.value[idx]["PicNo"] ==
                                          null
                                      ? "-"
                                      : controller.listPickup.value[idx]
                                          ["PicNo"],
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              if (controller.listPickup.value.length - 1 == idx)
                                sizedBoxJarak(20),
                              if (controller.listPickup.value.length - 1 == idx)
                                labelForm(
                                    "LelangMuatDetailLelangDetailLelangLabelTitleExpectedPickupTime"
                                        .tr,
                                    Color(ListColor.colorGrey3),
                                    14,
                                    FontWeight.w700),
                              if (controller.listPickup.value.length - 1 == idx)
                                sizedBoxJarak(8),
                              if (controller.listPickup.value.length - 1 == idx)
                                labelForm(
                                    controller
                                        .listDataDetail.value["PickupEta"],
                                    Colors.black,
                                    14,
                                    FontWeight.w600),
                              if (controller.listPickup.value.length - 1 != idx)
                                sizedBoxJarak(29)
                              else
                                sizedBoxJarak(24)
                            ],
                          ),
                        )
                      ],
                    )
                else if (controller.listPickup.value.length > 0)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          "assets/pin7.svg",
                          width: GlobalVariable.ratioFontSize(Get.context) * 28,
                          height:
                              GlobalVariable.ratioFontSize(Get.context) * 28,
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 11,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleLokasiPickup"
                                    .tr,
                                Color(ListColor.colorDarkGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePickupAddress"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listPickup.value[0]["Address"] ==
                                        null
                                    ? "-"
                                    : controller.listPickup.value[0]["Address"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleDetailLokasi"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listPickup.value[0]
                                            ["DetailAddress"] ==
                                        null
                                    ? "-"
                                    : controller.listPickup.value[0]
                                        ["DetailAddress"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePICName"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listPickup.value[0]["PicName"] ==
                                        null
                                    ? "-"
                                    : controller.listPickup.value[0]["PicName"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePICNumber"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listPickup.value[0]["PicNo"] == null
                                    ? "-"
                                    : controller.listPickup.value[0]["PicNo"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitleExpectedPickupTime"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listDataDetail.value["PickupEta"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          "assets/pin7.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 24,
                          height: GlobalVariable.ratioWidth(Get.context) * 24,
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 11,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleLokasiPickup"
                                    .tr,
                                Color(ListColor.colorDarkGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePickupAddress"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm("-", Colors.black, 14, FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleDetailLokasi"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm("-", Colors.black, 14, FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePICName"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm("-", Colors.black, 14, FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePICNumber"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm("-", Colors.black, 14, FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitleExpectedPickupTime"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listDataDetail.value["PickupEta"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                          ],
                        ),
                      )
                    ],
                  ),
                sizedBoxJarak(20),
                _formMapPin(),
                sizedBoxJarak(38),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _formMapPin() {
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
                    if (controller.listPickup.value.length > 1)
                      for (var idx = 0;
                          idx < controller.listPickup.value.length;
                          idx++)
                        Marker(
                          width: GlobalVariable.ratioWidth(Get.context) * 24.0,
                          height: GlobalVariable.ratioWidth(Get.context) * 24.0,
                          point: LatLng(
                              double.parse(
                                  controller.listPickup.value[idx]["Latitude"]),
                              double.parse(controller.listPickup.value[idx]
                                  ["Longitude"])),
                          // point: controller.currentLocation.value,
                          builder: (ctx) => Container(
                              child: SvgPicture.asset(
                                  controller.iconLocation[idx])),
                        )
                    else
                      (!controller.currentLocation.isNull)
                          ? Marker(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 24.0,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 24.0,
                              point: controller.currentLocation.value,
                              // point: controller.currentLocation.value,
                              builder: (ctx) => Container(
                                  child: SvgPicture.asset("assets/pin7.svg")),
                            )
                          : null
                  ],
                ),
                // PolylineLayerOptions(polylines: [
                //   Polyline(
                //       points: controller.listRoute.value,
                //       strokeWidth: 4,
                //       color: Colors.purple)
                // ]
                // )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.toMapFullScreenPickup();
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
                  "LelangMuatDetailLelangDetailLelangLabelTitleOpenMap".tr,
                  textAlign: TextAlign.center,
                  color: Colors.white),
            ),
          ),
        ),
      ],
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
                    if (controller.listDestination.value.length > 1)
                      for (var idx = 0;
                          idx < controller.listDestination.value.length;
                          idx++)
                        Marker(
                          width: GlobalVariable.ratioWidth(Get.context) * 24.0,
                          height: GlobalVariable.ratioWidth(Get.context) * 24.0,
                          point: LatLng(
                              double.parse(controller.listDestination.value[idx]
                                  ["Latitude"]),
                              double.parse(controller.listDestination.value[idx]
                                  ["Longitude"])),
                          // point: controller.currentLocation.value,
                          builder: (ctx) => Container(
                              child: SvgPicture.asset(
                                  controller.iconLocation[idx])),
                        )
                    else
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
                  ],
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.toMapFullScreenDestination();
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
                  "LelangMuatDetailLelangDetailLelangLabelTitleOpenMap".tr,
                  textAlign: TextAlign.center,
                  color: Colors.white),
            ),
          ),
        ),
      ],
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
        child: Obx(
          () => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitlePickupType".tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                labelForm(controller.listDataDetail.value["DestinationType"],
                    Colors.black, 14, FontWeight.w600),
                if (controller.listDestination.value.length > 1)
                  sizedBoxJarak(24),
                if (controller.listDestination.value.length > 1)
                  labelForm("LelangMuatBuatLelangBuatLelangLabelTitleJumlah".tr,
                      Color(ListColor.colorGrey3), 14, FontWeight.w700),
                if (controller.listDestination.value.length > 1)
                  sizedBoxJarak(8),
                if (controller.listDestination.value.length > 1)
                  labelForm("${controller.listDestination.value.length}",
                      Colors.black, 14, FontWeight.w600),
                sizedBoxJarak(24),
                if (controller.listDestination.value.length > 1)
                  for (var idx = 0;
                      idx < controller.listDestination.value.length;
                      idx++)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            controller.iconLocation[idx],
                            width:
                                GlobalVariable.ratioFontSize(Get.context) * 28,
                            height:
                                GlobalVariable.ratioFontSize(Get.context) * 28,
                          ),
                        ),
                        SizedBox(
                          width: GlobalVariable.ratioWidth(Get.context) * 11,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              labelForm(
                                  "LelangMuatTabAktifTabAktifLabelTitleDestinationLocation"
                                          .tr +
                                      " ${idx + 1}",
                                  Color(ListColor.colorDarkGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(20),
                              labelForm(
                                  "LelangMuatDetailLelangDetailLelangLabelTitlePickupAddress"
                                      .tr,
                                  Color(ListColor.colorGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(8),
                              labelForm(
                                  controller.listDestination.value[idx]
                                              ["Address"] ==
                                          null
                                      ? "-"
                                      : controller.listDestination.value[idx]
                                          ["Address"],
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              sizedBoxJarak(20),
                              labelForm(
                                  "LelangMuatBuatLelangBuatLelangLabelTitleDetailLokasi"
                                      .tr,
                                  Color(ListColor.colorGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(8),
                              labelForm(
                                  controller.listDestination.value[idx]
                                              ["DetailAddress"] ==
                                          null
                                      ? "-"
                                      : controller.listDestination.value[idx]
                                          ["DetailAddress"],
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              sizedBoxJarak(20),
                              labelForm(
                                  "LelangMuatDetailLelangDetailLelangLabelTitlePICName"
                                      .tr,
                                  Color(ListColor.colorGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(8),
                              labelForm(
                                  controller.listDestination.value[idx]
                                              ["PicName"] ==
                                          null
                                      ? "-"
                                      : controller.listDestination.value[idx]
                                          ["PicName"],
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              sizedBoxJarak(20),
                              labelForm(
                                  "LelangMuatDetailLelangDetailLelangLabelTitlePICNumber"
                                      .tr,
                                  Color(ListColor.colorGrey3),
                                  14,
                                  FontWeight.w700),
                              sizedBoxJarak(8),
                              labelForm(
                                  controller.listDestination.value[idx]
                                              ["PicNo"] ==
                                          null
                                      ? "-"
                                      : controller.listDestination.value[idx]
                                          ["PicNo"],
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                              if (controller.listDestination.value.length - 1 ==
                                  idx)
                                sizedBoxJarak(20),
                              if (controller.listDestination.value.length - 1 ==
                                  idx)
                                labelForm(
                                    "LelangMuatDetailLelangDetailLelangLabelTitleExpectedPickupTime"
                                        .tr,
                                    Color(ListColor.colorGrey3),
                                    14,
                                    FontWeight.w700),
                              if (controller.listDestination.value.length - 1 ==
                                  idx)
                                sizedBoxJarak(8),
                              if (controller.listDestination.value.length - 1 ==
                                  idx)
                                labelForm(
                                    controller
                                        .listDataDetail.value["DestinationEta"],
                                    Colors.black,
                                    14,
                                    FontWeight.w600),
                              if (controller.listDestination.value.length - 1 !=
                                  idx)
                                sizedBoxJarak(29)
                              else
                                sizedBoxJarak(24)
                            ],
                          ),
                        )
                      ],
                    )
                else if (controller.listDestination.value.length > 0)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          "assets/pin7.svg",
                          width: GlobalVariable.ratioFontSize(Get.context) * 28,
                          height:
                              GlobalVariable.ratioFontSize(Get.context) * 28,
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 11,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            labelForm(
                                "LelangMuatTabAktifTabAktifLabelTitleDestinationLocation"
                                    .tr,
                                Color(ListColor.colorDarkGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePickupAddress"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listDestination.value[0]
                                            ["Address"] ==
                                        null
                                    ? "-"
                                    : controller.listDestination.value[0]
                                        ["Address"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleDetailLokasi"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listDestination.value[0]
                                            ["DetailAddress"] ==
                                        null
                                    ? "-"
                                    : controller.listDestination.value[0]
                                        ["DetailAddress"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePICName"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listDestination.value[0]
                                            ["PicName"] ==
                                        null
                                    ? "-"
                                    : controller.listDestination.value[0]
                                        ["PicName"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePICNumber"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller.listDestination.value[0]["PicNo"] ==
                                        null
                                    ? "-"
                                    : controller.listDestination.value[0]
                                        ["PicNo"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitleExpectedPickupTime"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller
                                    .listDataDetail.value["DestinationEta"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          "assets/pin7.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 24,
                          height: GlobalVariable.ratioWidth(Get.context) * 24,
                        ),
                      ),
                      SizedBox(
                        width: GlobalVariable.ratioWidth(Get.context) * 11,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            labelForm(
                                "LelangMuatTabAktifTabAktifLabelTitleDestinationLocation"
                                    .tr,
                                Color(ListColor.colorDarkGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePickupAddress"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm("-", Colors.black, 14, FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatBuatLelangBuatLelangLabelTitleDetailLokasi"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm("-", Colors.black, 14, FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePICName"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm("-", Colors.black, 14, FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitlePICNumber"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm("-", Colors.black, 14, FontWeight.w600),
                            sizedBoxJarak(20),
                            labelForm(
                                "LelangMuatDetailLelangDetailLelangLabelTitleExpectedPickupTime"
                                    .tr,
                                Color(ListColor.colorGrey3),
                                14,
                                FontWeight.w700),
                            sizedBoxJarak(8),
                            labelForm(
                                controller
                                    .listDataDetail.value["DestinationEta"],
                                Colors.black,
                                14,
                                FontWeight.w600),
                          ],
                        ),
                      )
                    ],
                  ),
                sizedBoxJarak(20),
                _formMapPinDestinasi(),
                sizedBoxJarak(38),
              ],
            ),
          ),
        ),
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
        child: Obx(
          () => Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleMaximumBid".tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(12),
                labelForm(
                    controller.converttoIDR(int.parse(controller
                            .listDataDetail.value["MaxPrice"]
                            .toString())) +
                        "/Unit",
                    Colors.black,
                    14,
                    FontWeight.w600),
                sizedBoxJarak(24),
                labelForm("LelangMuatBuatLelangBuatLelangLabelTitleBidOffer".tr,
                    Color(ListColor.colorGrey3), 14, FontWeight.w700),
                if (controller.hargaPenawaran.value.length > 0)
                  for (var i = 0;
                      i < controller.hargaPenawaran.value.length;
                      i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        sizedBoxJarak(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: labelForm(
                                  "- ", Colors.black, 14, FontWeight.w600),
                            ),
                            Expanded(
                              child: labelForm(
                                  controller.hargaPenawaran.value[i]
                                              .toString() ==
                                          "null"
                                      ? ""
                                      : controller.hargaPenawaran.value[i]
                                          .toString(),
                                  Colors.black,
                                  14,
                                  FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleSpecialHandling"
                        .tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioFontSize(Get.context) * 5),
                      child: SvgPicture.asset(
                        "assets/titik_biru_pickup.svg",
                        width: GlobalVariable.ratioFontSize(Get.context) * 18,
                        height: GlobalVariable.ratioFontSize(Get.context) * 18,
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          labelForm(
                              "LelangMuatDetailLelangDetailLelangLabelTitleLoadingPosition"
                                  .tr,
                              Color(ListColor.colorGrey3),
                              14,
                              FontWeight.w600),
                          sizedBoxJarak(12),
                          if (controller.tmpMuat.value.length > 0)
                            for (var i = 0;
                                i < controller.tmpMuat.value.length;
                                i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: labelForm("- ", Colors.black, 14,
                                            FontWeight.w600),
                                      ),
                                      Expanded(
                                        child: labelForm(
                                            controller.tmpMuat.value[i]
                                                        .toString() ==
                                                    "null"
                                                ? ""
                                                : controller.tmpMuat.value[i]
                                                    .toString(),
                                            Colors.black,
                                            14,
                                            FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  sizedBoxJarak(8),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
                sizedBoxJarak(18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: GlobalVariable.ratioFontSize(Get.context) * 5),
                      child: SvgPicture.asset(
                        "assets/titik_biru_kuning_destinasi.svg",
                        width: GlobalVariable.ratioFontSize(Get.context) * 18,
                        height: GlobalVariable.ratioFontSize(Get.context) * 18,
                      ),
                    ),
                    SizedBox(
                      width: GlobalVariable.ratioWidth(Get.context) * 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          labelForm(
                              "LelangMuatDetailLelangDetailLelangLabelTitleUnloadingPosition"
                                  .tr,
                              Color(ListColor.colorGrey3),
                              14,
                              FontWeight.w600),
                          sizedBoxJarak(12),
                          if (controller.tmpBongkar.value.length > 0)
                            for (var i = 0;
                                i < controller.tmpBongkar.value.length;
                                i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: labelForm("- ", Colors.black, 14,
                                            FontWeight.w600),
                                      ),
                                      Expanded(
                                        child: labelForm(
                                            controller.tmpBongkar.value[i]
                                                        .toString() ==
                                                    "null"
                                                ? ""
                                                : controller.tmpBongkar.value[i]
                                                    .toString(),
                                            Colors.black,
                                            14,
                                            FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  sizedBoxJarak(8),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitlePaymentTerm"
                        .tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(12),
                labelForm(controller.paymentTerm.value, Colors.black, 14,
                    FontWeight.w600),
                sizedBoxJarak(24),
                dividerCust(),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleAdditionalNote"
                        .tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(5),
                labelForm(
                    "LelangMuatBuatLelangBuatLelangLabelTitleMaxCatatan".tr,
                    Color(ListColor.colorDarkGrey3),
                    11,
                    FontWeight.w600),
                if (controller.listCatatan.value.length > 0) sizedBoxJarak(24),
                if (controller.listCatatan.value.length > 0)
                  for (var idx = 0;
                      idx < controller.listCatatan.value.length;
                      idx++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        labelForm(controller.listCatatan.value[idx]["Date"],
                            Color(ListColor.colorGrey3), 11, FontWeight.w500),
                        sizedBoxJarak(4),
                        labelForm(controller.listCatatan.value[idx]["Note"],
                            Colors.black, 14, FontWeight.w600),
                        if (controller.listCatatan.value.length - 1 != idx)
                          sizedBoxJarak(12),
                      ],
                    ),
                controller.isTambahCatatan.value
                    ? sizedBoxJarak(12)
                    : sizedBoxJarak(8),
                if (controller.listCatatan.value.length < 6)
                  if (!controller.isTambahCatatan.value)
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          side: BorderSide(color: Color(ListColor.color4))),
                      onPressed: () {
                        controller.isTambahCatatan.value = true;
                      },
                      child: CustomText(
                        "LelangMuatDetailLelangDetailLelangLabelTitleAddNotes"
                            .tr,
                        color: Color(ListColor.color4),
                        fontSize:
                            GlobalVariable.ratioFontSize(Get.context) * 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                if (controller.isTambahCatatan.value)
                  Container(
                      child: Stack(alignment: Alignment.bottomRight, children: [
                    CustomTextField(
                      key: ValueKey("catatanTambahan"),
                      context: Get.context,
                      maxLines: 6,
                      onTap: () {
                        controller.isIconClose.value = true;
                      },
                      onChanged: (value) {
                        if (value != "") {
                          controller.isIconClose.value = true;
                        }
                      },
                      controller: controller.catatanTambahan.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(ListColor.colorLightGrey4),
                          fontSize:
                              GlobalVariable.ratioFontSize(Get.context) * 14),
                      newContentPadding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 8,
                          vertical: GlobalVariable.ratioWidth(Get.context) * 6),
                      textSize: GlobalVariable.ratioFontSize(Get.context) * 12,
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
                            fontSize:
                                GlobalVariable.ratioFontSize(Get.context) * 12),
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
                      ),
                    ),
                    if (controller.isIconClose.value)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            controller.catatanTambahan.value.text = "";
                            controller.isIconClose.value = false;
                            controller.isTambahCatatan.value = false;
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    GlobalVariable.ratioWidth(Get.context) * 5,
                                right:
                                    GlobalVariable.ratioWidth(Get.context) * 5),
                            child: Icon(
                              Icons.close_rounded,
                              color: Color(ListColor.colorGrey3),
                              size: GlobalVariable.ratioFontSize(Get.context) *
                                  24,
                            ),
                          ),
                        ),
                        // child: Obx(() => controller.isShowClearSearch.value
                        //     ? GestureDetector(
                        //         onTap: () {
                        //           // controller.onClearSearch();
                        //         },
                        //         child: Container(
                        //             margin: EdgeInsets.only(right: 10),
                        //             child: Icon(
                        //               Icons.close_rounded,
                        //               color: Color(ListColor.colorGrey3),
                        //               size:
                        //                   GlobalVariable.ratioWidth(Get.context) *
                        //                       24,
                        //             )),
                        //       )
                        //     : SizedBox.shrink()),
                      ),
                  ])),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleCargoBidStatus"
                        .tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(12),
                labelForm(controller.status.value, Color(ListColor.colorGreen3),
                    14, FontWeight.w600),
                sizedBoxJarak(24),
                labelForm(
                    "LelangMuatDetailLelangDetailLelangLabelTitleStatusTransporter"
                        .tr,
                    Color(ListColor.colorGrey3),
                    14,
                    FontWeight.w700),
                sizedBoxJarak(12),
                labelForm(controller.listDataDetail.value["Viewers"].toString(),
                    Colors.black, 14, FontWeight.w600),
                sizedBoxJarak(24)
              ],
            ),
          ),
        ),
      ),
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
    return CustomText(
      labelName == null ? "" : labelName,
      fontSize: GlobalVariable.ratioFontSize(Get.context) * sizefont,
      fontWeight: weightfont,
      color: color,
      height: GlobalVariable.ratioFontSize(Get.context) * (17 / sizefont),
    );
  }

  _formImgTrukCarrier() {
    return Container(
      height: GlobalVariable.ratioWidth(Get.context) * 167,
      width: MediaQuery.of(Get.context).size.width,
      decoration: BoxDecoration(
          color: Color(ListColor.colorLightGrey20),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border:
              Border.all(width: 1, color: Color(ListColor.colorLightGrey2))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: Image.network(
          controller.imageUrl.value.toString(),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
