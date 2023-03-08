import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/function/get_to_page_function.dart';
import 'package:muatmuat/app/modules/ARK/cari_harga_transport/create_notification_harga/create_notification_harga_controller.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/shared_preferences_helper_ark.dart';
import 'package:muatmuat/app/routes/app_pages.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'hasil_cari_harga_transport_controller.dart';

class HasilCariHargaTransportView
    extends GetView<HasilCariHargaTransportController> {
  String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    double ukuranBoxTab = (MediaQuery.of(context).size.width -
            GlobalVariable.ratioWidth(context) * 33) /
        3;
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(statusBarColor: Color(ListColor.colorBlue)));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Color(ListColor.colorBlue),
            statusBarIconBrightness: Brightness.light),
        child: Container(
          color: Color(ListColor.colorBackgroundTender),
          child: WillPopScope(
            onWillPop: onWillPop,
            child: SafeArea(
              child: Obx(
                () => Stack(children: [
                  Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(
                          GlobalVariable.ratioWidth(Get.context) * 88), //108
                      child: Column(
                        children: [
                          //search bar
                          Container(
                            height: GlobalVariable.ratioWidth(Get.context) * 53,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  6.5),
                                          child: Stack(
                                            children: [
                                              Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        controller.onSave();
                                                      },
                                                      child: SvgPicture.asset(
                                                          GlobalVariable
                                                                  .imagePath +
                                                              "ic_back_button.svg",
                                                          width: GlobalVariable.ratioWidth(
                                                                  Get.context) *
                                                              24,
                                                          height: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              24,
                                                          color: Color(ListColor
                                                              .colorBlue)))),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    GlobalVariable.ratioWidth(
                                                            Get.context) *
                                                        32,
                                                child: Column(
                                                  children: [
                                                    CustomText(
                                                      "CariHargaTransportIndexHargaTransport"
                                                          .tr,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    CustomText(
                                                      controller.selectedPickup[
                                                                  'City']
                                                              .replaceAll(
                                                                  "Kabupaten",
                                                                  "Kab.") +
                                                          " - " +
                                                          controller
                                                              .selectedDestinasi[
                                                                  'City']
                                                              .replaceAll(
                                                                  "Kabupaten",
                                                                  "Kab."),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                ]),
                          ),
                          // bar filter dan total peserta tender
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(
                              GlobalVariable.ratioWidth(context) * 16,
                              0,
                              GlobalVariable.ratioWidth(context) * 16,
                              GlobalVariable.ratioWidth(context) * 8,
                            ),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (controller.listTransporter.length > 0) {
                                      controller.showSortingDialog();
                                    }
                                  },
                                  child: Container(
                                    width: ukuranBoxTab,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: GlobalVariable.ratioWidth(
                                                        context) *
                                                    5),
                                            child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "sorting_active.svg",
                                              color: controller.listTransporter
                                                          .length >
                                                      0
                                                  ? Color(ListColor.colorBlue)
                                                  : Color(
                                                      ListColor.colorStroke),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                            ),
                                          ),
                                          Container(
                                            height: GlobalVariable.ratioWidth(
                                                    context) *
                                                10,
                                            width: GlobalVariable.ratioWidth(
                                                    context) *
                                                10,
                                            margin: EdgeInsets.only(
                                                left: GlobalVariable.ratioWidth(
                                                        context) *
                                                    9),
                                            decoration: BoxDecoration(
                                                color: controller.sortByUser
                                                                .value !=
                                                            "" &&
                                                        controller
                                                                .listTransporter
                                                                .length >
                                                            0
                                                    ? Color(ListColor.colorRed)
                                                    : Colors.transparent,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            100))),
                                          ),
                                        ]),
                                        Container(
                                          width: GlobalVariable.ratioWidth(
                                                  context) *
                                              3,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    context) *
                                                5,
                                          ),
                                          child: CustomText(
                                            "CariHargaTransportIndexUrutkan".tr,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: controller.listTransporter
                                                        .length >
                                                    0
                                                ? Color(ListColor.colorBlack)
                                                : Color(ListColor.colorStroke),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: GlobalVariable.ratioWidth(context) * 5,
                                  ),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0.5,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                  decoration: BoxDecoration(
                                    color: Color(
                                      ListColor.colorLightGrey4,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    var result = await GetToPage.toNamed<
                                            CreateNotificationHargaController>(
                                        Routes.CREATE_NOTIFICATION_HARGA,
                                        arguments: [
                                          controller.selectedPickup['CityID'],
                                          controller.selectedPickup['City'],
                                          controller
                                              .selectedDestinasi['CityID'],
                                          controller.selectedDestinasi['City']
                                        ]);
                                  },
                                  child: Container(
                                    width: ukuranBoxTab,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: GlobalVariable.ratioWidth(
                                                        context) *
                                                    5),
                                            child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "notification blue.svg",
                                              color: Color(ListColor.colorBlue),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                            ),
                                          ),
                                          Container(
                                            height: GlobalVariable.ratioWidth(
                                                    context) *
                                                10,
                                            width: GlobalVariable.ratioWidth(
                                                    context) *
                                                10,
                                            margin: EdgeInsets.only(
                                                left: GlobalVariable.ratioWidth(
                                                        context) *
                                                    9),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            100))),
                                          ),
                                        ]),
                                        Container(
                                          width: GlobalVariable.ratioWidth(
                                                  context) *
                                              3,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    context) *
                                                5,
                                          ),
                                          child: CustomText(
                                            "CariHargaTransportIndexNotifikasi"
                                                .tr,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: GlobalVariable.ratioWidth(context) * 5,
                                  ),
                                  width:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          0.5,
                                  height:
                                      GlobalVariable.ratioWidth(Get.context) *
                                          16,
                                  decoration: BoxDecoration(
                                    color: Color(
                                      ListColor.colorLightGrey4,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.listTransporter.length > 0) {
                                      controller.showFilter();
                                    }
                                  },
                                  child: Container(
                                    width: ukuranBoxTab,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: GlobalVariable.ratioWidth(
                                                        context) *
                                                    5),
                                            child: SvgPicture.asset(
                                              GlobalVariable.imagePath +
                                                  "filter_active.svg",
                                              color: controller.listTransporter
                                                          .length >
                                                      0
                                                  ? Color(ListColor.colorBlue)
                                                  : Color(
                                                      ListColor.colorStroke),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                              height: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  16,
                                            ),
                                          ),
                                          Container(
                                            height: GlobalVariable.ratioWidth(
                                                    context) *
                                                10,
                                            width: GlobalVariable.ratioWidth(
                                                    context) *
                                                10,
                                            margin: EdgeInsets.only(
                                                left: GlobalVariable.ratioWidth(
                                                        context) *
                                                    9),
                                            decoration: BoxDecoration(
                                                color: controller.isFilter.value
                                                    ? Color(ListColor.colorRed)
                                                    : Colors.transparent,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            100))),
                                          ),
                                        ]),
                                        Container(
                                          width: GlobalVariable.ratioWidth(
                                                  context) *
                                              3,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: GlobalVariable.ratioWidth(
                                                    context) *
                                                5,
                                          ),
                                          child: CustomText(
                                            "CariHargaTransportIndexFilter".tr,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: controller.listTransporter
                                                        .length >
                                                    0
                                                ? Color(ListColor.colorBlack)
                                                : Color(ListColor.colorStroke),
                                          ),
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
                    backgroundColor: Color(ListColor.colorBackgroundTender),
                    // backgroundColor: Color(ListColor.colorLightGrey6),
                    body: _showlistUser(),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }

  Future<bool> onWillPop() {
    controller.onSave();
    return Future.value(true);
  }

  Widget _showlistUser() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA, TAPI MENGGUNAKAN FILTER
          (controller.listTransporter.length == 0 &&
                  !controller.isLoadingData.value &&
                  controller.isFilter.value)
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
                        'ManajemenUserIndexDataTidakDitemukan'
                                .tr + //Data Tidak Ditemukan
                            '\n' +
                            'ManajemenUserIndexMohonCoba'
                                .tr, //Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('ManajemenUserIndexAtau'.tr, //Atau
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
                                        'ManajemenUserIndexAturUlangFilter'
                                            .tr, // Atur Ulang Filter
                                        fontSize: 12,
                                        color: Colors.white,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600),
                                  )))),
                    )
                  ],
                )))
              :
              //KALAU TIDAK ADA DATA
              (controller.listTransporter.length == 0 &&
                      !controller.isLoadingData.value)
                  ? Center(
                      child: Container(
                          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            GlobalVariable.imagePath +
                                "ic_pencarian_tidak_ditemukan.svg",
                            width: GlobalVariable.ratioWidth(Get.context) * 82,
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 93),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 15),
                        CustomText(
                            'CariHargaTransportIndexDataTidakDitemukan.'
                                    .tr + //Data Tidak Ditemukan
                                '\n' +
                                'CariHargaTransportIndexLabelHapusFilter'
                                    .tr, //Mohon coba hapus beberapa filter
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.2,
                            color: Color(ListColor.colorGrey3)),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 18),
                        CustomText('CariHargaTransportIndexAtau'.tr, //Atau
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.2,
                            color: Color(ListColor.colorLightGrey4)),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 20),
                        Material(
                          borderRadius: BorderRadius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 20),
                          color: Color(ListColor.colorBlue),
                          child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    GlobalVariable.ratioWidth(Get.context) *
                                        18),
                              ),
                              onTap: () async {
                                Get.back();
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
                                            'CariHargaTransportIndexAturUlangPencarian'
                                                .tr, // Atur Ulang Filter
                                            fontSize: 12,
                                            color: Colors.white,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.w600),
                                      )))),
                        )
                      ],
                    )))
                  : _listUserRefresher()
    ]);
  }

  Widget _listUserRefresher() {
    return SmartRefresher(
        enablePullUp:
            controller.listTransporter.length == controller.jumlahDataUser.value
                ? false
                : true,
        controller: controller.refreshUserController,
        onLoading: () async {
          controller.countDataUser.value += 10;
          await controller.getListTransporter(
              controller.countDataUser.value, controller.filter);
        },
        onRefresh: () async {
          controller.countDataUser.value = 1;
          controller.listTransporter.clear();
          controller.isLoadingData.value = true;
          await controller.getListTransporter(1, controller.filter);
        },
        child: _listUserTile());
  }

  Widget _listUserTile() {
    return ListView.builder(
      itemCount: controller.listTransporter.length,
      itemBuilder: (content, index) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              index == 0 && controller.listBadge.value.length > 0
                  ? Container(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 20,
                          0,
                          GlobalVariable.ratioWidth(Get.context) * 14),
                      height: GlobalVariable.ratioWidth(Get.context) * 57,
                      width: MediaQuery.of(Get.context).size.width,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: controller.listBadge.value,
                      ),
                    )
                  : Container(
                      height: index == 0
                          ? GlobalVariable.ratioWidth(Get.context) * 20
                          : 0,
                    ),
              //KALAU DIA ADA DATA, MUNCUL DISINI, JIKA TIDAK
              GestureDetector(
                  onTap: () async {
                    // var data =
                    //     await GetToPage.toNamed<DetailManajemenUserController>(
                    //         Routes.DETAIL_MANAJEMEN_ROLE,
                    //         arguments: [controller.listTransporter[index]['id']]);

                    // if (data != null) {
                    //   controller.refreshAll();
                    // }
                  },
                  child: cardTile(content, index))
            ]);
      },
    );
  }

  Widget truckTile(context, index, detailIndex) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailIndex == 0
              ? Container()
              : Container(
                  margin: EdgeInsets.only(
                    bottom: GlobalVariable.ratioWidth(context) * 12,
                  ),
                  height: GlobalVariable.ratioWidth(context),
                  width: MediaQuery.of(Get.context).size.width -
                      GlobalVariable.ratioWidth(context) * 60,
                  decoration: BoxDecoration(
                    color: Color(ListColor.colorLightGrey2),
                  ),
                ),
          // gambar truk
          Container(
            width: MediaQuery.of(Get.context).size.width -
                GlobalVariable.ratioWidth(context) * 60,
            height: GlobalVariable.ratioWidth(Get.context) * 167,
            decoration: BoxDecoration(
              color: Color(ListColor.colorBackgroundGambar),
              border: Border.all(color: Color(ListColor.colorLightGrey21)),
              borderRadius: BorderRadius.all(
                Radius.circular(GlobalVariable.ratioWidth(Get.context) * 6),
              ),
            ),
            child: Stack(
              children: [
                //gambar
                controller.listTransporter.value[index]['detail'][detailIndex]
                            ['truck_picture'] ==
                        null
                    ? Center(child: CircularProgressIndicator())
                    : CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: controller.listTransporter.value[index]
                            ['detail'][detailIndex]['truck_picture'],
                        imageBuilder: (context, imageProvider) => Container(
                          width: MediaQuery.of(Get.context).size.width -
                              GlobalVariable.ratioWidth(context) * 60,
                          height: GlobalVariable.ratioWidth(Get.context) * 167,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(ListColor.colorLightGrey21)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    GlobalVariable.ratioWidth(Get.context) * 6),
                              ),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill)),
                        ),
                        errorWidget: (context, errortext, progress) =>
                            Center(child: CircularProgressIndicator()),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                      ),
                controller.listTransporter.value[index]['is_promo']
                                .toString() ==
                            "true" &&
                        detailIndex == 0
                    ? Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          GlobalVariable.imagePath + "promo.svg",
                          width: GlobalVariable.ratioWidth(Get.context) * 48,
                        ))
                    : Container(),
                //kapasitas & dimensi
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      // width: GlobalVariable.ratioWidth(context) *
                      //     231,
                      padding: EdgeInsets.symmetric(
                        horizontal: GlobalVariable.ratioWidth(context) * 4,
                        vertical: GlobalVariable.ratioWidth(context) * 2,
                      ),
                      decoration: BoxDecoration(
                        color: Color(ListColor.colorLightBlue3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 6),
                          bottomRight: Radius.circular(
                              GlobalVariable.ratioWidth(Get.context) * 6),
                        ),
                      ),
                      child: Wrap(
                        children: [
                          Wrap(children: [
                            Container(
                                // padding: EdgeInsets.only(
                                //     top: GlobalVariable
                                //             .ratioWidth(
                                //                 Get.context) *
                                //         2),
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "kapasitas blue.svg",
                                    color: Color(ListColor.colorBlue),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16)),
                            SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            Container(
                                padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            1),
                                child: CustomText(
                                  controller
                                          .listTransporter
                                          .value[index]['detail'][detailIndex]
                                              ['min_capacity']
                                          .toString() +
                                      " ~ " +
                                      controller
                                          .listTransporter
                                          .value[index]['detail'][detailIndex]
                                              ['max_capacity']
                                          .toString() +
                                      " " +
                                      controller
                                          .listTransporter
                                          .value[index]['detail'][detailIndex]
                                              ['capacity_unit']
                                          .toString(),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                          ]),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(context) * 8,
                            ),
                            width: GlobalVariable.ratioWidth(context),
                            height: GlobalVariable.ratioWidth(context) * 16,
                            decoration: BoxDecoration(
                              color: Color(ListColor.colorGrey3),
                            ),
                          ),
                          Wrap(children: [
                            Container(
                                // padding: EdgeInsets.only(
                                //     top: GlobalVariable
                                //             .ratioWidth(
                                //                 Get.context) *
                                //         2),
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath +
                                        "jumlah truk blue.svg",
                                    color: Color(ListColor.colorBlue),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            16)),
                            SizedBox(
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 8),
                            Container(
                                padding: EdgeInsets.only(
                                    top:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            1),
                                child: CustomText(
                                  controller
                                          .listTransporter
                                          .value[index]['detail'][detailIndex]
                                              ['width']
                                          .toString() +
                                      " x " +
                                      controller
                                          .listTransporter
                                          .value[index]['detail'][detailIndex]
                                              ['length']
                                          .toString() +
                                      " x " +
                                      controller
                                          .listTransporter
                                          .value[index]['detail'][detailIndex]
                                              ['height']
                                          .toString() +
                                      " " +
                                      controller
                                          .listTransporter
                                          .value[index]['detail'][detailIndex]
                                              ['dimension_unit']
                                          .toString(),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ))
                          ])
                        ],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 12),
          Container(
            child: CustomText(
              controller.listTransporter[index]['detail'][detailIndex]
                          ['head_name']
                      .toString() +
                  " - " +
                  controller.listTransporter[index]['detail'][detailIndex]
                          ['carrier_name']
                      .toString(),
              color: Color(ListColor.colorBlack1B),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 4),
          controller.listTransporter[index]['detail'][detailIndex]
                              ['promo_price']
                          .toString() ==
                      "0" ||
                  controller.listTransporter[index]['detail'][detailIndex]
                              ['promo_price']
                          .toString() !=
                      "null"
              ? Container()
              : Container(
                  child: CustomText(
                    "Rp" +
                        controller.listTransporter[index]['detail'][detailIndex]
                                ['price_per_unit']
                            .toString()
                            .trim(),
                    color: Color(ListColor.colorGrey3),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
          Container(
            child: CustomText(
              controller.listTransporter[index]['promo_price'].toString() ==
                          "0" ||
                      controller.listTransporter[index]['detail'][detailIndex]
                                  ['promo_price']
                              .toString() !=
                          "null"
                  ? "Rp" +
                      controller.listTransporter[index]['detail'][detailIndex]
                              ['price_per_unit']
                          .toString()
                          .trim()
                  : "Rp" +
                      controller.listTransporter[index]['detail'][detailIndex]
                              ['promo_price']
                          .toString()
                          .trim(),
              color: Color(ListColor.colorRed),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          SizedBox(height: GlobalVariable.ratioWidth(Get.context) * 4),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        top: GlobalVariable.ratioWidth(Get.context) * 2),
                    child: SvgPicture.asset(
                      GlobalVariable.imagePath + "metode pembayaran.svg",
                      height: GlobalVariable.ratioWidth(Get.context) * 16,
                    )),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 4),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(
                            top: GlobalVariable.ratioWidth(Get.context) * 1),
                        child: CustomText(
                          controller.listTransporter[index]['payment'],
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                          wrapSpace: true,
                          fontWeight: FontWeight.w600,
                        ))),
                SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 4),
                controller.listTransporter[index]['hasExpand'] &&
                        detailIndex == 0
                    ? GestureDetector(
                        onTap: () {
                          controller.expandTruck(index);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: GlobalVariable.ratioWidth(Get.context) * 1),
                          child: CustomText(
                            controller.listTransporter[index]['isExpand']
                                ? "CariHargaTransportIndexLihatLebihSedikit".tr
                                : "CariHargaTransportIndexLihatHargaTrukLainnya"
                                    .tr,
                            decoration: TextDecoration.underline,
                            color: Color(ListColor.colorBlue),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            height: GlobalVariable.ratioWidth(Get.context) * 12,
          ),
        ],
      ),
    );
  }

  Widget cardTile(BuildContext context, int index) {
    return Container(
        margin: EdgeInsets.fromLTRB(
            GlobalVariable.ratioWidth(Get.context) * 16,
            0,
            GlobalVariable.ratioWidth(Get.context) * 16,
            GlobalVariable.ratioWidth(Get.context) * 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(GlobalVariable.ratioWidth(Get.context) * 12)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 16,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  GlobalVariable.ratioWidth(Get.context) * 16,
                  GlobalVariable.ratioWidth(Get.context) * 7,
                  GlobalVariable.ratioWidth(Get.context) * 13,
                  GlobalVariable.ratioWidth(Get.context) * 7),
              decoration: BoxDecoration(
                  color: Color(ListColor.colorHeaderListTender),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10),
                      topRight: Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 10))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: GlobalVariable.ratioWidth(Get.context) * 30,
                    width: GlobalVariable.ratioWidth(Get.context) * 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(
                          GlobalVariable.ratioWidth(Get.context) * 20)),
                      border: Border.all(color: Colors.white),
                    ),
                    child: controller.listTransporter.value[index]
                                ['transporter_avatar'] ==
                            null
                        ? CircularProgressIndicator()
                        : CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: controller.listTransporter.value[index]
                                ['transporter_avatar'],
                            imageBuilder: (context, imageProvider) => Container(
                              width:
                                  GlobalVariable.ratioWidth(Get.context) * 32,
                              height:
                                  GlobalVariable.ratioWidth(Get.context) * 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(GlobalVariable.ratioWidth(
                                              Get.context) *
                                          20)),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain)),
                            ),
                            errorWidget: (context, errortext, progress) =>
                                Center(child: CircularProgressIndicator()),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                          ),
                  ),
                  SizedBox(width: GlobalVariable.ratioWidth(Get.context) * 8),
                  Expanded(
                      child: Container(
                    child: Wrap(children: [
                      CustomText(
                        controller.listTransporter[index]['transporter_name'] ??
                            "",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]),
                  )),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 5,
                  ),
                  GestureDetector(
                      child: controller.listTransporter.value[index]['is_gold']
                          ? Container(
                              padding: EdgeInsets.only(
                                top: GlobalVariable.ratioWidth(Get.context) * 2,
                              ),
                              child: Image(
                                image: AssetImage(
                                    GlobalVariable.imagePath + "ic_gold.png"),
                                width:
                                    GlobalVariable.ratioWidth(Get.context) * 18,
                              ),
                            )
                          : Container(),
                      onTap: () {
                        if (controller.listTransporter.value[index]
                            ['is_gold']) {
                          controller.popUpGoldTransporter();
                        }
                      }),
                  SizedBox(
                    width: GlobalVariable.ratioWidth(Get.context) * 5,
                  ),
                  Obx(
                    () => controller.cekProfilTransporter.value
                        ? GestureDetector(
                            child: Container(
                                padding: EdgeInsets.only(
                                  top: GlobalVariable.ratioWidth(Get.context) *
                                      2,
                                ),
                                child: SvgPicture.asset(
                                    GlobalVariable.imagePath + "more_vert.svg",
                                    color: Color(ListColor.colorIconVert),
                                    width:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24,
                                    height:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            24)),
                            onTap: () {
                              controller.opsi(index);
                            })
                        : SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 24),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                GlobalVariable.ratioWidth(Get.context) * 16,
                GlobalVariable.ratioWidth(Get.context) * 14,
                GlobalVariable.ratioWidth(Get.context) * 16,
                0,
              ),
              decoration: BoxDecoration(color: Colors.white
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(borderRadius),
                  //     bottomRight: Radius.circular(borderRadius))
                  ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller.listTransporter[index]['isExpand']
                            ? [
                                for (int detailIndex = 0;
                                    detailIndex <
                                        controller
                                            .listTransporter[index]['detail']
                                            .length;
                                    detailIndex++)
                                  truckTile(context, index, detailIndex),
                              ]
                            : [
                                truckTile(context, index, 0),
                              ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(Get.context).size.width,
              height: 0.5,
              color: Color(ListColor.colorLightGrey10),
            ),
            Container(
                padding: EdgeInsets.only(
                    left: GlobalVariable.ratioWidth(Get.context) * 16,
                    right: GlobalVariable.ratioWidth(Get.context) * 16,
                    top: GlobalVariable.ratioWidth(Get.context) * 7,
                    bottom: GlobalVariable.ratioWidth(Get.context) * 7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 10),
                        bottomRight: Radius.circular(
                            GlobalVariable.ratioWidth(Get.context) * 10))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // status belum ditugaskan
                    //status tidak aktif
                    !controller.listTransporter[index]['hasNotes']
                        ? Expanded(child: Container())
                        : Obx(() => GestureDetector(
                              onTap: () async {
                                controller.cekKetentuanHarga.value =
                                    await SharedPreferencesHelper.getHakAkses(
                                        "Ketentuan",
                                        denganLoading: true);
                                if (SharedPreferencesHelper.cekAkses(
                                    controller.cekKetentuanHarga.value)) {
                                  controller.goToKetentuanHargaTransport(
                                      controller.listTransporter[index]
                                              ['notes'] ??
                                          "",
                                      controller.listTransporter[index]
                                              ['additional_notes'] ??
                                          "");
                                }
                              },
                              child: CustomText(
                                "CariHargaTransportIndexKetentuanHarga".tr,
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: controller.cekKetentuanHarga.value
                                    ? Color(ListColor.colorBlue)
                                    : Color(ListColor.colorAksesDisable),
                              ),
                            )),
                    Obx(() => GestureDetector(
                        onTap: () async {
                          controller.cekHubungiTransporter.value =
                              await SharedPreferencesHelper.getHakAkses(
                                  "Hubungi Transporter",
                                  denganLoading: true);
                          if (SharedPreferencesHelper.cekAkses(
                              controller.cekHubungiTransporter.value)) {
                            controller.hubungi(controller.listTransporter[index]
                                    ['transporter_id']
                                .toString());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                GlobalVariable.ratioWidth(Get.context) * 24,
                            vertical:
                                GlobalVariable.ratioWidth(Get.context) * 6,
                          ),
                          decoration: BoxDecoration(
                            color: controller.cekHubungiTransporter.value
                                ? Color(
                                    ListColor.colorBlue,
                                  )
                                : Color(ListColor.colorAksesDisable),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                GlobalVariable.ratioWidth(Get.context) * 20,
                              ),
                            ),
                          ),
                          child: CustomText(
                              'CariHargaTransportIndexHubungiTransporter'.tr,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white),
                        ))),
                  ],
                ))
          ],
        ));
  }

  void popUpGoldTransporter() async {
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
                                            12,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  2,
                                            ),
                                            child: Image(
                                              image: AssetImage(
                                                  GlobalVariable.imagePath +
                                                      "ic_gold.png"),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18,
                                            ),
                                          ),
                                          Container(
                                            width: GlobalVariable.ratioWidth(
                                                    context) *
                                                4,
                                          ),
                                          Container(
                                            child: CustomText(
                                              "CariHargaTransportIndexGoldTransporter"
                                                  .tr,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          height: GlobalVariable.ratioWidth(
                                                  context) *
                                              12),
                                      CustomText(
                                        "     " +
                                            "CariHargaTransportIndexAdalahStatusYangDiberikan"
                                                .tr,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Container(
                                          height: GlobalVariable.ratioWidth(
                                                  context) *
                                              12),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  2,
                                            ),
                                            child: Image(
                                              image: AssetImage(
                                                  GlobalVariable.imagePath +
                                                      "checklist blue.png"),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18,
                                            ),
                                          ),
                                          Container(
                                            width: GlobalVariable.ratioWidth(
                                                    context) *
                                                4,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              "CariHargaTransportIndexCopySTNKSesuaiJumlahTruk"
                                                  .tr,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height:
                                            GlobalVariable.ratioWidth(context) *
                                                5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  2,
                                            ),
                                            child: Image(
                                              image: AssetImage(
                                                  GlobalVariable.imagePath +
                                                      "checklist blue.png"),
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  18,
                                            ),
                                          ),
                                          Container(
                                            width: GlobalVariable.ratioWidth(
                                                    context) *
                                                4,
                                          ),
                                          Expanded(
                                            child: CustomText(
                                              "CariHargaTransportIndexKelengkapanPersyaratanLegalitas"
                                                  .tr,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
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
}
