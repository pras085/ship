import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/custom_text.dart';

import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'manajemen_hak_akses_controller.dart';

class ManajemenHakAksesView extends GetView<ManajemenHakAksesController> {
  String bullet = "\u2022 ";
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
    //     .copyWith(statusBarColor: Color(ListColor.colorBlue)));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Color(ListColor.colorBlue),
            statusBarIconBrightness: Brightness.light),
        child: Container(
          color: Color(ListColor.colorBackgroundManajemen),
          child: SafeArea(
            child: Obx(
              () => Stack(children: [
                Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(
                        GlobalVariable.ratioWidth(Get.context) * 170),
                    child: Column(
                      children: [
                        //search bar
                        Container(
                          height: GlobalVariable.ratioWidth(Get.context) * 56,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(GlobalVariable.urlImageNavbar),
                                  fit: BoxFit.fill),
                              color: Colors.white),
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
                                                11.5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                                child: GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .onSetData('COMPARE');
                                                    },
                                                    child: SvgPicture.asset(
                                                        GlobalVariable
                                                                .imagePath +
                                                            "ic_back_button.svg",
                                                        width: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            24,
                                                        height: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            24,
                                                        color: GlobalVariable
                                                            .tabDetailAcessoriesMainColor))),
                                            SizedBox(
                                              width: GlobalVariable.ratioWidth(
                                                      Get.context) *
                                                  12,
                                            ),
                                            Expanded(
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  Obx(() => CustomTextField(
                                                      controller: controller
                                                          .searchController
                                                          .value,
                                                      context: Get.context,
                                                      textInputAction:
                                                          TextInputAction
                                                              .search,
                                                      onChanged: (value) {
                                                        controller.onSearch();
                                                      },
                                                      textSize: 14,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      newInputDecoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        isCollapsed: true,
                                                        hintText:
                                                            "ManajemenRoleTambahRoleCariMenuHakAkses" // Cari Menu/Hak Akses
                                                                .tr,
                                                        fillColor: Colors.white,
                                                        hintStyle: TextStyle(
                                                          color: Color(ListColor
                                                              .colorLightGrey2),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        filled: true,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                          left: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              32,
                                                          right: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              30,
                                                          top: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              9,
                                                          bottom: GlobalVariable
                                                                  .ratioWidth(Get
                                                                      .context) *
                                                              6,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(ListColor
                                                                  .colorLightGrey7),
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  1),
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(ListColor
                                                                  .colorLightGrey7),
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  1),
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  ListColor
                                                                      .color4),
                                                              width: GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  1),
                                                          borderRadius: BorderRadius
                                                              .circular(GlobalVariable
                                                                      .ratioWidth(
                                                                          Get.context) *
                                                                  7),
                                                        ),
                                                      ))),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            6,
                                                        right: GlobalVariable
                                                                .ratioWidth(Get
                                                                    .context) *
                                                            2),
                                                    child: SvgPicture.asset(
                                                      GlobalVariable.imagePath +
                                                          "ic_search_blue.svg",
                                                      width: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          24,
                                                      height: GlobalVariable
                                                              .ratioWidth(
                                                                  Get.context) *
                                                          24,
                                                    ),
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Obx(() => controller
                                                              .searchController
                                                              .value
                                                              .text
                                                              .isEmpty
                                                          ? SizedBox.shrink()
                                                          : Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 7),
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        controller
                                                                            .onClearSearch();
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .close_rounded,
                                                                          size: GlobalVariable.ratioWidth(Get.context) *
                                                                              24,
                                                                          color:
                                                                              Color(ListColor.colorGrey3))))))
                                                ],
                                              ),
                                            ),
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
                        // bar filter dan total peserta tender
                        Container(
                          width: MediaQuery.of(Get.context).size.width,
                          height: GlobalVariable.ratioWidth(Get.context) * 110,
                          padding: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16,
                            right: GlobalVariable.ratioWidth(Get.context) * 16,
                            top: GlobalVariable.ratioWidth(Get.context) * 14,
                            bottom: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            5),
                                    decoration: BoxDecoration(
                                        color: Color(ListColor.colorDarkGrey5),
                                        borderRadius: BorderRadius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                100),
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
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    100),
                                          ),
                                          onTap: () {
                                            if ((controller
                                                        .listHakAkses.length !=
                                                    0 ||
                                                controller.isFilterHakAkses))
                                              controller.showFilter();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      2,
                                              horizontal:
                                                  GlobalVariable.ratioWidth(
                                                          Get.context) *
                                                      13,
                                            ),
                                            decoration: BoxDecoration(
                                                color: controller.isFilterHakAkses
                                                    ? Color(ListColor
                                                        .colorBackgroundFilterTender)
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        GlobalVariable.ratioWidth(
                                                                Get.context) *
                                                            20),
                                                border: Border.all(
                                                    width: 1,
                                                    color: controller.isFilterHakAkses
                                                        ? Color(
                                                            ListColor.colorBlue)
                                                        : Color(ListColor
                                                            .colorLightGrey7))),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    "Filter"
                                                        .tr, // ManajemenRoleTambahRoleFilter
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: controller
                                                            .isFilterHakAkses
                                                        ? Color(
                                                            ListColor.colorBlue)
                                                        : (controller
                                                                    .listHakAkses
                                                                    .length ==
                                                                0)
                                                            ? Color(ListColor
                                                                .colorLightGrey2)
                                                            : Color(ListColor
                                                                .colorDarkBlue2)),
                                                SizedBox(
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          7,
                                                ),
                                                SvgPicture.asset(
                                                  ((controller.listHakAkses
                                                                  .length ==
                                                              0 &&
                                                          !controller
                                                              .isFilterHakAkses))
                                                      ? GlobalVariable
                                                              .imagePath +
                                                          "filter_disable.svg"
                                                      : GlobalVariable
                                                              .imagePath +
                                                          "filter_active.svg",
                                                  width:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                  height:
                                                      GlobalVariable.ratioWidth(
                                                              Get.context) *
                                                          16,
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                      height: GlobalVariable.ratioWidth(
                                              Get.context) *
                                          12),
                                  CustomText(
                                    controller.namarole +
                                        "\n" +
                                        controller.namamenu,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  )
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(ListColor.colorDarkGrey5),
                                    borderRadius: BorderRadius.circular(
                                        GlobalVariable.ratioWidth(Get.context) *
                                            100),
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
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                100),
                                      ),
                                      onTap: () {
                                        if ((controller.listHakAkses.length !=
                                                0 ||
                                            controller.isFilterHakAkses))
                                          controller.bukaSemua();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              9,
                                          horizontal: GlobalVariable.ratioWidth(
                                                  Get.context) *
                                              12,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                GlobalVariable.ratioWidth(
                                                        Get.context) *
                                                    6),
                                            border: Border.all(
                                                width: 1,
                                                color: (controller.listHakAkses
                                                            .length ==
                                                        0)
                                                    ? Color(ListColor
                                                        .colorLightGrey2)
                                                    : controller.tampilkanSemua
                                                            .value
                                                        ? Color(
                                                            ListColor.colorBlue)
                                                        : Color(ListColor
                                                            .colorLightGrey10))),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomText(
                                                "ManajemenRoleTambahRoleTampilkanSemua"
                                                    .tr, //Tampilkan Semua
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: (controller.listHakAkses
                                                            .length ==
                                                        0)
                                                    ? Color(ListColor
                                                        .colorLightGrey2)
                                                    : controller.tampilkanSemua
                                                            .value
                                                        ? Color(
                                                            ListColor.colorBlue)
                                                        : Colors.black),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Color(ListColor.colorBackgroundManajemen),
                  // backgroundColor: Color(ListColor.colorLightGrey6),
                  body: _showlistHakAkses(),
                  bottomNavigationBar: Container(
                      width: MediaQuery.of(context).size.width,
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
                          vertical: GlobalVariable.ratioWidth(Get.context) * 16,
                          horizontal:
                              GlobalVariable.ratioWidth(Get.context) * 22),
                      child: Row(mainAxisSize: MainAxisSize.max, children: [
                        Expanded(
                            flex: 1,
                            child: Obx(() => MaterialButton(
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            1.5,
                                        color: Color(ListColor.color4)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20))),
                                color: Colors.white,
                                onPressed: !controller.isLoadingData.value
                                    ? () {
                                        FocusScope.of(Get.context).unfocus();
                                        Get.back();
                                      }
                                    : null,
                                child: CustomText(
                                  "ManajemenRoleTambahRoleSebelumnya"
                                      .tr, // Sebelumnya
                                  color: Color(ListColor.color4),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                )))),
                        SizedBox(
                            width: GlobalVariable.ratioWidth(Get.context) * 12),
                        Expanded(
                            flex: 1,
                            child: Obx(() => MaterialButton(
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        GlobalVariable.ratioWidth(Get.context) *
                                            8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            GlobalVariable.ratioWidth(
                                                    Get.context) *
                                                20))),
                                color: Color(ListColor.color4),
                                onPressed: !controller.isLoadingData.value
                                    ? () {
                                        FocusScope.of(Get.context).unfocus();
                                        controller.onSave();
                                      }
                                    : null,
                                child: CustomText(
                                  (controller.mode == 'TAMBAH'
                                          ? "ManajemenRoleTambahRoleTambahRole"
                                          : // Tambah Role
                                          "ManajemenRoleEditRoleSimpan")
                                      .tr, // Simpan
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                )))),
                      ])),
                ),
              ]),
            ),
          ),
        ));
  }

  Widget _showlistHakAkses() {
    return Stack(children: [
      //KALAU MASIH LOADING
      controller.isLoadingData.value
          ? Center(
              child: Container(
                  width: 30, height: 30, child: CircularProgressIndicator()),
            )
          :
          //KALAU TIDAK ADA DATA, TAPI MENGGUNAKAN FILTER
          (controller.listHakAkses.length == 0 &&
                  !controller.isLoadingData.value &&
                  controller.isFilterHakAkses)
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
                        'ManajemenRoleTambahRoleDataTidakDitemukan'
                                .tr + //Data Tidak Ditemukan
                            '\n' +
                            'ManajemenRoleTambahRoleMohonCoba'
                                .tr, //Mohon coba hapus beberapa filter
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        height: 1.2,
                        color: Color(ListColor.colorGrey3)),
                    SizedBox(
                        height: GlobalVariable.ratioWidth(Get.context) * 18),
                    CustomText('ManajemenRoleTambahRoleAtau'.tr, //Atau
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
                                        'ManajemenRoleTambahRoleAturUlangFilter'
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
              (controller.listHakAkses.length == 0 &&
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
                          height: GlobalVariable.ratioWidth(Get.context) * 93,
                        ),
                        SizedBox(
                            height:
                                GlobalVariable.ratioWidth(Get.context) * 15),
                        CustomText(
                            'ManajemenRoleTambahRoleKeywordTidakDitemukan' // Keyword tidak ditemukan
                                    .tr +
                                '\n' +
                                'ManajemenRoleTambahRoleDiSistem'
                                    .tr, // di Sistem
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            height: 1.2,
                            color: Color(ListColor.colorGrey3))
                      ],
                    )))
                  : controller.isCardNotEmpty.value
                      ? Container(
                          margin: EdgeInsets.only(
                            left: GlobalVariable.ratioWidth(Get.context) * 16,
                            right: GlobalVariable.ratioWidth(Get.context) * 16,
                            bottom: GlobalVariable.ratioWidth(Get.context) * 20,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  GlobalVariable.ratioWidth(Get.context) * 14,
                              vertical:
                                  GlobalVariable.ratioWidth(Get.context) * 14),
                          decoration: BoxDecoration(
                              color: Color(ListColor
                                  .colorWhiteManajemen), //colorWhiteManajemen
                              borderRadius: BorderRadius.circular(
                                  GlobalVariable.ratioWidth(Get.context) * 10)),
                          child: _listHakAksesTile(),
                        )
                      : controller.resultfilter.value == "dipilih"
                          ?
                          //filter dipilih
                          Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // SvgPicture.asset(
                                    //   GlobalVariable.imagePath + "ic_pencarian_tidak_ditemukan.svg",
                                    //   width: GlobalVariable.ratioWidth(
                                    //           Get.context) *
                                    //       82,
                                    //   height: GlobalVariable.ratioWidth(
                                    //           Get.context) *
                                    //       93,
                                    // ),
                                    Container(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            83,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            75,
                                        child: Image.asset(
                                            GlobalVariable.imagePath +
                                                "tidak_ada_data.png")),
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            15),
                                    CustomText(
                                        'ManajemenRoleTambahRoleAndaBelumMemilih' // Keyword tidak ditemukan
                                                .tr +
                                            '\n' +
                                            'ManajemenRoleTambahRoleHakAksesRole'
                                                .tr, // di Sistem
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        textAlign: TextAlign.center,
                                        height: 1.2,
                                        color: Color(ListColor.colorGrey3))
                                  ],
                                ),
                              ),
                            )
                          :
                          // filter tidak dipilih
                          Center(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // SvgPicture.asset(
                                    //   GlobalVariable.imagePath + "ic_pencarian_tidak_ditemukan.svg",
                                    //   width: GlobalVariable.ratioWidth(
                                    //           Get.context) *
                                    //       82,
                                    //   height: GlobalVariable.ratioWidth(
                                    //           Get.context) *
                                    //       93,
                                    // ),
                                    Container(
                                        width: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            83,
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            75,
                                        child: Image.asset(
                                            GlobalVariable.imagePath +
                                                "tidak_ada_data.png")),
                                    SizedBox(
                                        height: GlobalVariable.ratioWidth(
                                                Get.context) *
                                            15),
                                    CustomText(
                                        'ManajemenRoleTambahRoleAndaTelahMemilihSemua' // Keyword tidak ditemukan
                                                .tr +
                                            '\n' +
                                            'ManajemenRoleTambahRoleHakAksesRole'
                                                .tr, // di Sistem
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        textAlign: TextAlign.center,
                                        height: 1.2,
                                        color: Color(ListColor.colorGrey3))
                                  ],
                                ),
                              ),
                            ),
    ]);
  }

  Widget _listHakAksesTile() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.listHakAkses.length,
      itemBuilder: (content, index) {
        // return controller.listWidgetCheckbox.value[index];
        if (controller.listWidgetCheckbox.value[index]['access'] == true) {
          return controller.expandedWidget(1, controller.listHakAkses[index],
              index, controller.listWidgetCheckbox.value[index]);
        } else {
          return Container();
        }
        // if (controller.resultfilter.value == "dipilih") {
        //   if (controller.listHakAkses[index]["choose"]) {
        //     return controller.expandedWidget(
        //         1, controller.listHakAkses[index], index);
        //   } else {
        //     return Container();
        //   }
        // } else if (controller.resultfilter.value == "tidak") {
        //   if (!controller.listHakAkses[index]["choose"]) {
        //     return controller.expandedWidget(
        //         1, controller.listHakAkses[index], index);
        //   } else {
        //     return Container();
        //   }
        // } else {
        //   return controller.expandedWidget(
        //       1, controller.listHakAkses[index], index);
        // }
      },
    );
  }
}
