import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/checkbox_custom_widget.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

import 'dart:math' as math;

import 'cari_harga_transport_controller.dart';

class CariHargaTransportView extends GetView<CariHargaTransportController> {
  // double _heightAppBar = AppBar().preferredSize.height + 30;
  // @override
  // void onInit() async {
  //   if (controller.showFirstTime.value) {
  //     popUpFirstTime();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: Future.delayed(Duration.zero, () async {
          bool check =
              await SharedPreferencesHelper.getCariHargaTransportPertamaKali();
          controller.showFirstTime.value = check;
          if (check) {
            popUpFirstTime();
          }
        }),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Color(ListColor.colorLightGrey6),
            body: Container(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    //background atas
                    Obx(() => Align(
                              alignment: Alignment.topLeft,
                              child: Stack(children: [
                                Positioned(
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Obx(() => controller
                                                      .imageSliders.length >
                                                  0
                                              ? CarouselSlider(
                                                  items: controller
                                                      .imageSliders.value,
                                                  options: CarouselOptions(
                                                    autoPlay: true,
                                                    autoPlayInterval:
                                                        Duration(seconds: 10),
                                                    enlargeCenterPage: false,
                                                    viewportFraction: 1,
                                                    aspectRatio: 16 / 9,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                context) *
                                                        156,
                                                    onPageChanged:
                                                        (index, reason) {
                                                      print(index);
                                                      controller
                                                          .indexImageSlider
                                                          .value = index;
                                                    },
                                                  ),
                                                )
                                              : SizedBox()),
                                        ))),
                                Positioned.fill(
                                    bottom:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            32,
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    controller.imageSliders
                                                        .value.length;
                                                i++)
                                              i ==
                                                      controller
                                                          .indexImageSlider
                                                          .value
                                                  ? _buildPageIndicator(true)
                                                  : _buildPageIndicator(false),
                                          ],
                                        ))),
                              ]),
                              // Image(
                              //   image: AssetImage(GlobalVariable.imagePath +
                              //       "banner cari harga transport.png"),
                              //   width: MediaQuery.of(context).size.width,
                              //   height: GlobalVariable.ratioWidth(Get.context) * 156,
                              //   fit: BoxFit.fill,
                            ) // ),
                        ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 16),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                onWillPop();
                              },
                              child: SvgPicture.asset(
                                GlobalVariable.imagePath + "ic_back_button.svg",
                                color: Colors.white,
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                                height:
                                    GlobalVariable.ratioWidth(Get.context) * 24,
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 92),
                          // form lokasi pickup dan destinasi
                          Container(
                            width: MediaQuery.of(context).size.width -
                                GlobalVariable.ratioWidth(Get.context) * 32,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  GlobalVariable.ratioWidth(context) * 5,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                    ),
                                    CustomText(
                                      "CariHargaTransportIndexLokasiPickup".tr +
                                          "*",
                                      fontSize: 14,
                                      color: Color(ListColor.colorGrey3),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.onSelectPickup();
                                      },
                                      child: Obx(
                                        () => Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  32,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                GlobalVariable.imagePath +
                                                    "lokasi gray.svg",
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                              ),
                                              SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8,
                                              ),
                                              Expanded(
                                                child: CustomText(
                                                  controller.selectedPickup
                                                              .value["Text"] ==
                                                          ""
                                                      ? "CariHargaTransportIndexPilihAlamatKecamatanKota"
                                                          .tr
                                                      : controller
                                                          .selectedPickup
                                                          .value["Text"],
                                                  color: controller
                                                              .selectedPickup
                                                              .value["Text"] ==
                                                          ""
                                                      ? Color(
                                                          ListColor.colorGrey3)
                                                      : Color(ListColor
                                                          .colorBlack1B),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                    ),
                                    Container(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          0.5,
                                      decoration: BoxDecoration(
                                        color: Color(
                                          ListColor.colorLightGrey2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                    ),
                                    CustomText(
                                      "CariHargaTransportIndexLokasiDestinasi"
                                              .tr +
                                          "*",
                                      color: Color(ListColor.colorGrey3),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.onSelectDestinasi();
                                      },
                                      child: Obx(
                                        () => Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  32,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                GlobalVariable.imagePath +
                                                    "lokasi gray.svg",
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                              ),
                                              SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8,
                                              ),
                                              Expanded(
                                                child: CustomText(
                                                  controller.selectedDestinasi
                                                              .value["Text"] ==
                                                          ""
                                                      ? "CariHargaTransportIndexPilihAlamatKecamatanKota"
                                                          .tr
                                                      : controller
                                                          .selectedDestinasi
                                                          .value["Text"],
                                                  color: controller
                                                              .selectedDestinasi
                                                              .value["Text"] ==
                                                          ""
                                                      ? Color(
                                                          ListColor.colorGrey3)
                                                      : Color(ListColor
                                                          .colorBlack1B),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12,
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: GlobalVariable.ratioWidth(context) *
                                          61),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      GestureDetector(
                                        onTap: () {
                                          print("test");
                                          controller
                                              .switchLokasiPickupDestinasi();
                                        },
                                        child: Container(
                                          height: GlobalVariable.ratioWidth(
                                                  context) *
                                              32,
                                          width: GlobalVariable.ratioWidth(
                                                  context) *
                                              32,
                                          decoration: BoxDecoration(
                                            color: Color(ListColor.colorBlue),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                GlobalVariable.ratioWidth(
                                                        context) *
                                                    5,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "sorting_active.svg",
                                              color: Colors.white,
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 12,
                          ),
                          //form jenis truk & carrier
                          Container(
                            width: MediaQuery.of(context).size.width -
                                GlobalVariable.ratioWidth(Get.context) * 32,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  GlobalVariable.ratioWidth(context) * 5,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                CustomText(
                                  "CariHargaTransportIndexJenisTruk".tr,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3),
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width -
                                      GlobalVariable.ratioWidth(Get.context) *
                                          32,
                                  child: Obx(
                                    () => Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            controller.onSelectJenisTruk();
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SvgPicture.asset(
                                                GlobalVariable.imagePath +
                                                    "icon truk gray.svg",
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                              ),
                                              SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8,
                                              ),
                                              Expanded(
                                                child: CustomText(
                                                  controller.selectedJenisTruk
                                                              .value["Text"] ==
                                                          ""
                                                      ? "CariHargaTransportIndexPilihJenisTruk"
                                                          .tr
                                                      : controller
                                                          .selectedJenisTruk
                                                          .value["Text"],
                                                  color: controller
                                                              .selectedJenisTruk
                                                              .value["Text"] ==
                                                          ""
                                                      ? Color(
                                                          ListColor.colorGrey3)
                                                      : Color(ListColor
                                                          .colorBlack1B),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        controller.selectedJenisTruk
                                                    .value["Text"] ==
                                                ""
                                            ? Container()
                                            : Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .onResetTextbox("truk");
                                                  },
                                                  child: SvgPicture.asset(
                                                    GlobalVariable.imagePath +
                                                        "ic_close.svg",
                                                    width: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16,
                                                    height: GlobalVariable
                                                            .ratioWidth(
                                                                Get.context) *
                                                        16,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Container(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0.5,
                                  decoration: BoxDecoration(
                                    color: Color(
                                      ListColor.colorLightGrey2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                CustomText(
                                  "CariHargaTransportIndexJenisCarrier".tr,
                                  color: Color(ListColor.colorGrey3),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width -
                                      GlobalVariable.ratioWidth(Get.context) *
                                          32,
                                  child: Obx(
                                    () => Stack(children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.onSelectJenisCarrier();
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "icon truk gray.svg",
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                            ),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  8,
                                            ),
                                            Container(
                                              child: CustomText(
                                                controller.selectedJenisCarrier
                                                            .value["Text"] ==
                                                        ""
                                                    ? "CariHargaTransportIndexPilihJenisCarrier"
                                                        .tr
                                                    : controller
                                                        .selectedJenisCarrier
                                                        .value["Text"],
                                                color: controller
                                                            .selectedJenisCarrier
                                                            .value["Text"] ==
                                                        ""
                                                    ? Color(
                                                        ListColor.colorGrey3)
                                                    : Color(
                                                        ListColor.colorBlack1B),
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      controller.selectedJenisCarrier
                                                  .value["Text"] ==
                                              ""
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.centerRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.onResetTextbox(
                                                      "carrier");
                                                },
                                                child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "ic_close.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                ),
                                              ),
                                            ),
                                    ]),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Obx(
                                  () => controller.urlGambarTrukCarrier.value ==
                                          ""
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  56,
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              167,
                                          decoration: BoxDecoration(
                                            color: Color(ListColor
                                                .colorBackgroundGambar),
                                            border: Border.all(
                                              color: Color(
                                                  ListColor.colorLightGrey10),
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  GlobalVariable.ratioWidth(
                                                          context) *
                                                      6),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                GlobalVariable.imagePath +
                                                    "pilih jenis truk carrier.svg",
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        37,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        28,
                                              ),
                                              SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8,
                                              ),
                                              CustomText(
                                                "CariHargaTransportIndexPilihJenisTrukCarrier"
                                                    .tr,
                                                color: Color(
                                                    ListColor.colorLightGrey4),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              )
                                            ],
                                          ),
                                        )
                                      : CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: controller
                                              .urlGambarTrukCarrier.value,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    56,
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                167,
                                            decoration: BoxDecoration(
                                                color: Color(ListColor
                                                    .colorBackgroundGambar),
                                                border: Border.all(
                                                  color: Color(ListColor
                                                      .colorLightGrey10),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(GlobalVariable
                                                          .ratioWidth(
                                                              context) *
                                                      6),
                                                ),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill)),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                        ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 12,
                          ),
                          //form transporter
                          Container(
                            width: MediaQuery.of(context).size.width -
                                GlobalVariable.ratioWidth(Get.context) * 32,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  GlobalVariable.ratioWidth(context) * 5,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                CustomText(
                                  "CariHargaTransportIndexNamaTransporter".tr,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3),
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Obx(
                                  () => Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.onSelectTransporter();
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  32,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                GlobalVariable.imagePath +
                                                    "user_admin.svg",
                                                color:
                                                    Color(ListColor.colorGrey3),
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        16,
                                              ),
                                              SizedBox(
                                                width:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8,
                                              ),
                                              CustomText(
                                                controller.selectedNamaTransport
                                                            .value["Text"] ==
                                                        ""
                                                    ? "CariHargaTransportIndexCariNamaTransporter"
                                                        .tr
                                                    : controller
                                                        .selectedNamaTransport
                                                        .value["Text"],
                                                color: controller
                                                            .selectedNamaTransport
                                                            .value["Text"] ==
                                                        ""
                                                    ? Color(
                                                        ListColor.colorGrey3)
                                                    : Color(
                                                        ListColor.colorBlack1B),
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      controller.selectedNamaTransport
                                                  .value["Text"] ==
                                              ""
                                          ? Container()
                                          : Align(
                                              alignment: Alignment.centerRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.onResetTextbox(
                                                      "transport");
                                                },
                                                child: SvgPicture.asset(
                                                  GlobalVariable.imagePath +
                                                      "ic_close.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Container(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0.5,
                                  decoration: BoxDecoration(
                                    color: Color(
                                      ListColor.colorLightGrey2,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            GlobalVariable.ratioWidth(context) *
                                                192,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              "CariHargaTransportIndexKategoriTransporter"
                                                  .tr,
                                              color:
                                                  Color(ListColor.colorGrey3),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12,
                                            ),
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .checkboxGoldTransporter
                                                          .value =
                                                      !controller
                                                          .checkboxGoldTransporter
                                                          .value;
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CheckBoxCustom(
                                                        size: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            12,
                                                        shadowSize: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            18,
                                                        borderWidth: 1,
                                                        paddingSize: 0,
                                                        isWithShadow: false,
                                                        value: controller
                                                            .checkboxGoldTransporter
                                                            .value,
                                                        onChanged: (value) {
                                                          controller
                                                              .checkboxGoldTransporter
                                                              .value = value;
                                                        }),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8),
                                                    CustomText(
                                                      "CariHargaTransportIndexGoldTransporter"
                                                          .tr,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .checkboxRegularTransporter
                                                          .value =
                                                      !controller
                                                          .checkboxRegularTransporter
                                                          .value;
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CheckBoxCustom(
                                                        size: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            12,
                                                        shadowSize: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            18,
                                                        borderWidth: 1,
                                                        paddingSize: 0,
                                                        isWithShadow: false,
                                                        value: controller
                                                            .checkboxRegularTransporter
                                                            .value,
                                                        onChanged: (value) {
                                                          controller
                                                              .checkboxRegularTransporter
                                                              .value = value;
                                                        }),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8),
                                                    CustomText(
                                                      "CariHargaTransportIndexRegularTransporter"
                                                          .tr,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              "CariHargaTransportIndexPromo".tr,
                                              color:
                                                  Color(ListColor.colorGrey3),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            SizedBox(
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12,
                                            ),
                                            Obx(
                                              () => GestureDetector(
                                                  onTap: () {
                                                    controller.checkboxPromo
                                                            .value =
                                                        !controller
                                                            .checkboxPromo
                                                            .value;
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CheckBoxCustom(
                                                          size: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              12,
                                                          shadowSize: GlobalVariable
                                                                  .ratioWidth(
                                                                      Get
                                                                          .context) *
                                                              18,
                                                          borderWidth: 1,
                                                          paddingSize: 0,
                                                          isWithShadow: false,
                                                          value: controller
                                                              .checkboxPromo
                                                              .value,
                                                          onChanged: (value) {
                                                            controller
                                                                .checkboxPromo
                                                                .value = value;
                                                          }),
                                                      SizedBox(
                                                          width: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              8),
                                                      CustomText(
                                                        "CariHargaTransportIndexPromo"
                                                            .tr,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                CustomText(
                                  "CariHargaTransportIndexJumlahArmadaTransporter"
                                      .tr,
                                  fontSize: 14,
                                  color: Color(ListColor.colorGrey3),
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            GlobalVariable.ratioWidth(context) *
                                                95,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .checkboxJumlahArmada
                                                          .value['1-50'] =
                                                      !controller
                                                          .checkboxJumlahArmada
                                                          .value['1-50'];
                                                  controller
                                                      .checkboxJumlahArmada
                                                      .refresh();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CheckBoxCustom(
                                                        size: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            12,
                                                        shadowSize: GlobalVariable
                                                                .ratioWidth(
                                                                    Get
                                                                        .context) *
                                                            18,
                                                        borderWidth: 1,
                                                        paddingSize: 0,
                                                        isWithShadow: false,
                                                        value: controller
                                                            .checkboxJumlahArmada
                                                            .value['1-50'],
                                                        onChanged: (value) {
                                                          controller
                                                                  .checkboxJumlahArmada
                                                                  .value[
                                                              '1-50'] = value;
                                                          controller
                                                              .checkboxJumlahArmada
                                                              .refresh();
                                                        }),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8),
                                                    CustomText(
                                                      "1-50",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .checkboxJumlahArmada
                                                          .value['51-100'] =
                                                      !controller
                                                          .checkboxJumlahArmada
                                                          .value['51-100'];
                                                  controller
                                                      .checkboxJumlahArmada
                                                      .refresh();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CheckBoxCustom(
                                                        size: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            12,
                                                        shadowSize: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            18,
                                                        borderWidth: 1,
                                                        paddingSize: 0,
                                                        isWithShadow: false,
                                                        value: controller
                                                            .checkboxJumlahArmada
                                                            .value['51-100'],
                                                        onChanged: (value) {
                                                          controller
                                                                  .checkboxJumlahArmada
                                                                  .value[
                                                              '51-100'] = value;
                                                          controller
                                                              .checkboxJumlahArmada
                                                              .refresh();
                                                        }),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8),
                                                    CustomText(
                                                      "51-100",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .checkboxJumlahArmada
                                                          .value['101-300'] =
                                                      !controller
                                                          .checkboxJumlahArmada
                                                          .value['101-300'];
                                                  controller
                                                      .checkboxJumlahArmada
                                                      .refresh();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CheckBoxCustom(
                                                        size: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            12,
                                                        shadowSize: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            18,
                                                        borderWidth: 1,
                                                        paddingSize: 0,
                                                        isWithShadow: false,
                                                        value: controller
                                                            .checkboxJumlahArmada
                                                            .value['101-300'],
                                                        onChanged: (value) {
                                                          controller
                                                                  .checkboxJumlahArmada
                                                                  .value[
                                                              '101-300'] = value;
                                                          controller
                                                              .checkboxJumlahArmada
                                                              .refresh();
                                                        }),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8),
                                                    CustomText(
                                                      "101-300",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        8),
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () {
                                                  controller
                                                          .checkboxJumlahArmada
                                                          .value['300+'] =
                                                      !controller
                                                          .checkboxJumlahArmada
                                                          .value['300+'];
                                                  controller
                                                      .checkboxJumlahArmada
                                                      .refresh();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CheckBoxCustom(
                                                        size: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            12,
                                                        shadowSize: GlobalVariable
                                                                .ratioWidth(
                                                                    Get
                                                                        .context) *
                                                            18,
                                                        borderWidth: 1,
                                                        paddingSize: 0,
                                                        isWithShadow: false,
                                                        value: controller
                                                            .checkboxJumlahArmada
                                                            .value['300+'],
                                                        onChanged: (value) {
                                                          controller
                                                                  .checkboxJumlahArmada
                                                                  .value[
                                                              '300+'] = value;
                                                          controller
                                                              .checkboxJumlahArmada
                                                              .refresh();
                                                        }),
                                                    SizedBox(
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            8),
                                                    CustomText(
                                                      "300+",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          12,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 12,
                          ),
                          // button ayo cari harga transport
                          GestureDetector(
                            onTap: () {
                              if (controller.selectedDestinasi.value["ID"] ==
                                      "" ||
                                  controller.selectedPickup.value["ID"] == "") {
                                popUpValidasi();
                              } else {
                                controller.onSubmit();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(ListColor.colorBlue),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      GlobalVariable.ratioWidth(Get.context) *
                                          70),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width -
                                  GlobalVariable.ratioWidth(Get.context) * 32,
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      GlobalVariable.ratioWidth(context) * 13),
                              child: Center(
                                child: CustomText(
                                  "CariHargaTransportIndexAyoCariHargaTransport"
                                      .tr,
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: GlobalVariable.ratioWidth(Get.context) * 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> onWillPop() async {
    Get.back(result: true);
  }

  void popUpValidasi() async {
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
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
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
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
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
                                            "CariHargaTransportIndexSilahkanPilihLokasiPickupDestinasi"
                                                .tr,
                                            fontSize: 14,
                                            height: 1.4,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                        SizedBox(
                                            height: GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20),
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            // width: double.infinity,
                                            decoration: BoxDecoration(
                                                color:
                                                    Color(ListColor.colorBlue),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            50))),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        9,
                                                horizontal:
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        38),
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  CustomText(
                                                      "CariHargaTransportIndexOke"
                                                          .tr,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

  void popUpFirstTime() async {
    showDialog(
        context: Get.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.only(
                  left: GlobalVariable.ratioWidth(Get.context) * 16,
                  right: GlobalVariable.ratioWidth(Get.context) * 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      GlobalVariable.ratioWidth(Get.context) * 10)),
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: GlobalVariable.ratioWidth(Get.context) * 16),
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
                                      Image(
                                        image: AssetImage(
                                            GlobalVariable.imagePath +
                                                "ilustrasi cari harga.png"),
                                        // width: GlobalVariable.ratioWidth(
                                        //         Get.context) *
                                        //     176,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            104,
                                        // fit: BoxFit.cover,
                                      ),
                                      Container(
                                        height:
                                            GlobalVariable.ratioWidth(context) *
                                                27,
                                      ),
                                      CustomText(
                                          "CariHargaTransportIndexLabelCariHargaTransport"
                                              .tr,
                                          fontSize: 18,
                                          height: 1.4,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              14),
                                      CustomText(
                                          "CariHargaTransportIndexAdalahFiturDariTransportMarket"
                                              .tr,
                                          fontSize: 14,
                                          height: 1.4,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      CustomText(
                                          "CariHargaTransportIndexPilihTransporterDenganBijak"
                                              .tr,
                                          fontSize: 14,
                                          height: 1.4,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      SizedBox(
                                          height: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              20),
                                      Container(
                                        child: CustomText(
                                          "CariHargaTransportIndexMuatMuatTidakBertanggungJawab"
                                              .tr,
                                          fontSize: 14,
                                          height: 1.4,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w500,
                                          color: Color(ListColor.colorRed),
                                        ),
                                      )
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
                                  onTap: () async {
                                    Get.back();
                                    if (controller.showFirstTime.value) {
                                      await SharedPreferencesHelper
                                          .setCariHargaTransportPertamaKali(
                                              false);
                                      controller.showFirstTime.value = false;
                                    }
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

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.only(
          left: GlobalVariable.ratioWidth(Get.context) * 2,
          right: GlobalVariable.ratioWidth(Get.context) * 2,
          top: GlobalVariable.ratioWidth(Get.context) * 16),
      height: GlobalVariable.ratioWidth(Get.context) * 8,
      width: GlobalVariable.ratioWidth(Get.context) * 8,
      decoration: BoxDecoration(
        color: isCurrentPage ? Color(ListColor.colorYellow) : Colors.white,
        borderRadius:
            BorderRadius.circular(GlobalVariable.ratioWidth(Get.context) * 12),
      ),
    );
  }
}
